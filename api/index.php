<?php

    //Vou usar um código simples e estruturado para simular a api por acreditar ser mais rápido. Sei que orientção a objeto usando as diretrizes do solid são a melhor forma de trabalhar com desenvolimento, mas pelo tempo, vou usar o método mais simples.

    define('DATABASE_NAME', 'fast_tech');
    define('DATABASE_USER', 'root');
    define('DATABASE_PASS', '');
    define('DATABASE_HOST', 'localhost');

    require_once 'class_db_pdo.php';
    
    //display or not the errors
    $debug = 1;
    
    $DB = new DBPDO();
    
    //simple get ip
    $ip = $_SERVER['REMOTE_ADDR'];
    
    $contador = $DB->fetch("select count(id) as contador from request where ip = '$ip' and date >= date_sub(now(), interval 1 hour)");
    
    //header get conections
    header("x-ratelimit-limit: 3600");
    header("x-ratelimit-remaining: ". (3600 - $contador['contador']));   
    
    
    if (!$contador)
        erro("Error find request");
    
    if ($contador['contador'] > 3600)
        erro("Request limit exceeded");
    
    //store request in database
    $DB->execute("insert into request (ip) values ('$ip')");

    $filter_sql = "";    
    
    //filters rules
    $filters = array(
        'abv_gt' => "number",
        'abv_lt' => "number",
        'ibu_gt' => "number",
        'ibu_lt' => "number",
        'ebc_gt' => "number",
        'ebc_lt' => "number",
        'beer_name' => "string",
        'yeast' => "string",
        'brewed_before' => "date",
        'brewed_after' => "date",
        'hops' => "string",
        'malt' => "string",
        'food' => "string",        
        'ids' => "string",
        "per_page"=>"string",
        "page"=>"string"
    );

    $errors = [];
    $wheres = [];
    $joins = [];
    $group_by = [];
    $limit = "80";

    foreach ($filters as $filter => $condition) {
        
        if (!isset($_GET[$filter]))
            continue;

        //pequeno tratamento para injection
        $value = addslashes($_GET[$filter]);
        
        if ($value === ""){
            header("HTTP/1.0 404 Not Found"); 
            exit;
        }
            

        switch ($condition) {
            case "number":
                if (!filter_var($value, FILTER_VALIDATE_FLOAT) && filter_var($value, FILTER_VALIDATE_INT) === false ) {
                    $errors[] = $filter;
                }
                break;
            case "date":
                if (!is_date($value)) {
                    $errors[] = $filter;
                }
                break;
        }

        if (sizeof($errors) > 0)
            continue;
        

        switch ($filter) {
            case "abv_gt":
                $wheres[] = string_greater_less($filter, $value);
                break;
            case "abv_lt":
                $wheres[] = string_greater_less($filter, $value);
                break;
            case "ibu_gt":
                $wheres[] = string_greater_less($filter, $value);
                break;
            case "ibu_lt":
                $wheres[] = string_greater_less($filter, $value);
                break;
            case "ebc_gt":
                $wheres[] = string_greater_less($filter, $value);
                break;
            case "ebc_lt":
                $wheres[] = string_greater_less($filter, $value);
                break;
            case "beer_name":
                $wheres[] = "(b.name like '%$value%')";
                break;
            case "yeast":
                $joins[] = " inner join beer_yeast bey on b.id = bey.id_beer ";
                $joins[] = " inner join yeast y on bey.id_yeast = y.id ";                
                $wheres[] = "(y.name like '%$value%')";
                break;
            case "brewed_before":
                $value = explode("/", $value);
                $wheres[] = "( cast(substring(b.first_brewed, 4, 4) as unsigned) < $value[1] or ( cast(substring(b.first_brewed, 4, 4) as unsigned) = $value[1] && cast(substring(b.first_brewed, 1, 2) as unsigned) < $value[0]) )";
                break;
            case "brewed_after":
                $value = explode("/", $value);
                $wheres[] = "( cast(substring(b.first_brewed, 4, 4) as unsigned) > $value[1] or ( cast(substring(b.first_brewed, 4, 4) as unsigned) = $value[1] && cast(substring(b.first_brewed, 1, 2) as unsigned) > $value[0]) )";
                break;
            case "hops":
                $joins[] = " inner join beer_hop bh on b.id = bh.id_beer ";
                $joins[] = " inner join hop h on bh.id_hop = h.id ";
                $group_by[] = "b.id";
                $wheres[] = "(h.name like '%$value%')";
                break;
            case "malt":
                $joins[] = " inner join beer_malt bm on b.id = bm.id_beer ";
                $joins[] = " inner join malt m on bm.id_malt = m.id ";
                $group_by[] = "b.id";
                $wheres[] = "(m.name like '%$value%')";
                break;
            case "food":
                $joins[] = " inner join beer_food_pairing bfp on b.id = bfp.id_beer ";
                $joins[] = " inner join food_pairing fp on bfp.id_food_pairing = fp.id ";
                $group_by[] = "b.id";
                $wheres[] = "(fp.text like '%$value%')";
                break;
            case "ids":
                $value = explode("|", $value);
                if (is_array($value)){
                    foreach ($value as $id){
                        if (!filter_var($id, FILTER_VALIDATE_INT)){
                            $errors[] = $filter;
                            break;
                        }
                    }
                } else {
                    $errors[] = $filter;
                }
                
                $value = implode(",", $value);
                
                $wheres[] = "b.id in ($value)";
                break;
            case "per_page":
                $limit = $value;
                break;
            case "page":
                $limit =  ($limit * ($value - 1))  . ", ".$limit;
                break;
        }
    }
    
    if (sizeof($errors) > 0)
        erro("An error was encountered in the field(s) below: ".implode(", ", $errors));
    

    $sql = "select b.id, b.name, b.tagline, b.first_brewed, b.description, b.image_url, b.abv, b.ibu, b.target_fg, b.target_og, b.ebc, b.srm, b.ph, b.attenuation_level, '' as volume, b.volume_value, b.volume_unit, '' as boil_volume, b.boil_volume_value, b.boil_volume_unit, '' as method, b.ferm_temp_unit, b.ferm_temp_value, b.twist, '' as ingredients, y.name as name_yeast, (select group_concat(fp.text separator ', ') from food_pairing fp join beer_food_pairing bfp on fp.id = bfp.id_food_pairing where bfp.id_beer = b.id) as food_pairing, b.brewers_tips, b.contributed_by from beer b left join beer_yeast bye on b.id = bye.id_beer left join yeast y on bye.id_yeast = y.id group by b.id";
    
    if (sizeof($joins) > 0)
        $sql .= implode($joins);     
    
    if (sizeof($wheres) > 0)
        $sql .= " where ".implode(" and ", $wheres);    
    
    if (sizeof($group_by) > 0)
        $sql .= " group by ".implode(" , ", $group_by);    
    
    $sql .= " limit $limit";
    
    $beers = $DB->fetchAll($sql);
    
    if (sizeof($beers) == 0){
        $error = $DB->getError();
        if (isset($error) && $error != "")
            erro($error);
    } else {
        
        
        // get units for compare later. (performance)
        $units = $DB->fetchAll("select * from unit");
        
        if (is_array($units) && sizeof($units) > 0){
            $temp_units = [];
            foreach ($units as $unit){
                $temp_units[$unit['id']] = $unit['value'];
            }
            
            $units = $temp_units;
        }
        
        
        //format data for specific return rule 
        foreach ($beers as &$beer){
            $beer['volume'] = return_volume($beer);
            $beer['boil_volume'] = return_boil_volume($beer);
            $beer['method'] = return_method($beer);
            $beer['ingredients'] = return_ingredients($beer);
            $beer['food_pairing'] = explode(", ", $beer['food_pairing']);
        }
    }
    
    
    
    echo json_encode($beers); exit;

    function erro($msg) {
        
        global $debug;
        
        if (!$debug)
            $msg = "";
        
        echo json_encode(array("error"=>1, "msg" => $msg));
        exit;
    }

    function is_date($date) {        
        $date = explode("/", $date);
        
        if (sizeof($date) != 2)
            return false;
        
        if ($date[0] < 1 || $date[0] > 12)
            return false;
        
        return true;
    }

    function string_greater_less($field, $value) {
        $parts = explode("_", $field);
        
        //var_dump($parts);

        if ($parts[1] == "gt") {
            $condition = ">";
        } else if ($parts[1] == "lt") {
            $condition = "<";
        } else {
            return "";
        }

        return "(b.$parts[0] $condition $value)";
    }
    
    function return_volume(&$beer){
        $volume = new stdClass();  
        
        $volume = return_object($volume, "value", "volume_value", $beer);
        $volume = return_object($volume, "unit", "volume_unit", $beer, true);
        
        return $volume;
    }
    
    function return_boil_volume(&$beer){
        $boil_volume = new stdClass();   
        
        $boil_volume = return_object($boil_volume, "value", "boil_volume_value", $beer);
        $boil_volume = return_object($boil_volume, "unit", "boil_volume_unit", $beer, true);
        
        return $boil_volume;
    }
    
    function return_method(&$beer){
        global $DB;
        
        $method = new stdClass();
        $method->mash_temp = [];
        
        $mashs = $DB->fetchAll("select * from mash_temp where id_beer = ".$beer['id']);
        
        if (is_array($mashs) && sizeof($mashs) > 0){
            foreach ($mashs as $mash){
                $temp_mash = new stdClass();
                $temp_mash->temp = new stdClass();
                $temp_mash->temp->value = $mash['temp_value'];
                $temp_mash->temp->unit = return_text_unit($mash['temp_unit']);
                $temp_mash->duration = $mash['duration'];
                $method->mash_temp[] = $temp_mash;
            }
        }
        
        $method->fermentation = new stdClass();
        $method->fermentation->temp = new stdClass();
        $method->fermentation->temp = return_object($method->fermentation->temp, "value", "ferm_temp_value", $beer);
        $method->fermentation->temp = return_object($method->fermentation->temp, "unit", "ferm_temp_unit", $beer, true);
        
        $method->twist = $beer['twist'];
        unset($beer['twist']);
        
        return $method;
    }
    
    function return_ingredients(&$beer){        
        global $DB;
        
        $ingredients = new stdClass();
        $ingredients->malt = [];        
        
        $malts = $DB->fetchAll("select m.name, bm.amount_value, bm.amount_unit from beer_malt bm join malt m on bm.id_malt = m.id where bm.id_beer = ".$beer['id']);
        
        if (is_array($malts) && sizeof($malts) > 0){
            foreach ($malts as $malt){
                $temp_malt = new stdClass();
                $temp_malt->name = $malt['name'];
                $temp_malt->amount = new stdClass();
                $temp_malt->amount->value = $malt['amount_value'];
                $temp_malt->amount->unit = return_text_unit($malt['amount_unit']);
                $ingredients->malt[] = $temp_malt;
            }
        }
        
        $ingredients->hops = [];
        
        $hops = $DB->fetchAll("select h.name, bh.amount_value, bh.amount_unit, bh.add, a.name as attribute from beer_hop bh join hop h on bh.id_hop = h.id join attribute a on bh.id_attribute = a.id where bh.id_beer = ".$beer['id']);
        
        if (is_array($hops) && sizeof($hops) > 0){
            foreach ($hops as $hop){
                $temp_hops = new stdClass();
                $temp_hops->name = $hop['name'];
                $temp_hops->amount = new stdClass();
                $temp_hops->amount->value = $hop['amount_value'];
                $temp_hops->amount->unit = return_text_unit($hop['amount_unit']);
                $temp_hops->add = $hop['add'];
                $temp_hops->attribute = $hop['attribute'];
                $ingredients->hops[] = $temp_hops;
            }
        }
        
        $ingredients->yeast = $beer['name_yeast'];
        unset($beer['name_yeast']);        
        
        return $ingredients;
    }
    
    function return_object(&$object, $key, $key_beer, &$beer, $unit = false){
        $object->$key = ($unit == true) ? return_text_unit($beer[$key_beer]) : $beer[$key_beer];
        unset($beer[$key_beer]);
        return $object;
    }
    
    function return_text_unit($id = ""){
        global $units;
        
        if (!isset($id) || $id == "")
            return "";
        
        return $units[$id];
    }
    
?>

