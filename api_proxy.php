<?php

//check request per second
session_start();

function check_requests(&$requests){
    $time = time(); 
    
    $count_remove = 0;
    
    foreach ($requests as $key=>$request) {
        if ($time - $request > 3){
            unset($requests[$key-$count_remove]);
            $count_remove++;
        }
    }
    
    if (sizeof($requests) >= 3){
        usleep(100000);
        check_requests($requests);
    }
        
}

$time = time();

if (!isset($_SESSION['requests'])){
    $_SESSION['requests'] = array();
    $_SESSION['requests'][] = $time;
} else {    
    if (sizeof($_SESSION['requests']) < 3)
        $_SESSION['requests'][] = $time;
    else {
        check_requests($_SESSION['requests']);
    } 
        
}

session_write_close();
//check request per second

//validate get params
$parameters = array("abv_gt", "abv_lt", "ibu_gt", "ibu_lt", "ebc_gt", "ebc_lt", "beer_name", "page", "per_page");

$get = "";
$operator_get = "?";

foreach ($_GET as $key=>$value){
    if (!in_array($key, $parameters)){
        error("Invalid parameter"); exit;
    }
    
    if ($value === "")
        error("Param shouldn't be empty");
    
    $get .= $operator_get."$key=".addslashes($value);
    
    $operator_get = "&";
}

//$get .= $operator_get."per_page=3";

//validate get params


//call api - here we have two options: local (developed by me) and oficial api 
//$ch = curl_init("http://localhost/fasttech/beer/$get");
$ch = curl_init("https://api.punkapi.com/v2/beers/$get");

curl_setopt($ch, CURLOPT_HEADER, 0);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
curl_setopt($ch,CURLOPT_SSL_VERIFYPEER, false);

$return = curl_exec($ch);

$http_status = curl_getinfo($ch, CURLINFO_HTTP_CODE);

curl_close($ch);

if ($http_status != 200){
    try{
        $return = json_decode($return);
        
        if (isset($return->message))
           error($return->message);
        
    } catch (Exception $e){};
    
     error("Api connection error");
}

echo $return;

function error($msg){
    echo json_encode(array("error"=> 1, "msg"=> $msg)); exit;
}


