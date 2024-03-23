<?php 

$dns = "mysql:host=localhost;dbname=test";
$user = "root";
$pass = "";
$option = array(PDO::MYSQL_ATTR_INIT_COMMAND => "SET NAMES UTF8");

try{
    $con = new PDO($dns,$user,$pass,$option);
    $con->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    include 'functions.php';
    
}catch(PDOException $e){
    echo $e->getMessage();
}

?>