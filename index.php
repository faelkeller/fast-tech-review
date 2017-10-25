<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="css/fast_tech.css" rel="stylesheet">
    </head>
    <body>
        <div class="container">
            <h4>Defaults params</h4>
            <form method="post">
                <table id="table_params" class="table table-bordered table-striped">
                    <thead>
                        <tr>
                            <th>Params</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>
                                <input type="text" class="form-control" id="params_1" name="params_1" placeholder="Params 1" value="<?php echo isset($_POST['params_1'])? $_POST['params_1'] : "abv_gt=1&abv_lt=10&beer_name=t"; ?>">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <input type="text" class="form-control" name="params_2" id="params_2" placeholder="Params 2" value="<?php echo isset($_POST['params_2'])? $_POST['params_2'] : "ibu_gt=1&ibu_lt=10"; ?>">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <input type="text" class="form-control" name="params_3" id="params_3" placeholder="Params 3" value="<?php echo isset($_POST['params_3'])? $_POST['params_3'] : "ebc_gt=1&ebc_lt=10"; ?>">
                            </td>
                        </tr>
                    </tbody>
                </table>
                
                <div class="row">
                    <div class="col-md-12">
                        <input type="text" class="form-control" name="per_page" id="per_page" placeholder="Per Page" value="<?php echo isset($_POST['per_page'])? $_POST['per_page'] : "1"; ?>">
                    </div>
                </div>
                
                <div class="row">
                    <div class="actions_buttons">
                        <button class="btn btn-primary" type="submit">Call Api</button>
                    </div>
                </div>
            </form>
        </div>

        <script src="js/jquery-3.2.1.min.js"></script>        
        <script src="bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
        <script src="js/fast_tech.js"></script>
    </body>
</html>



