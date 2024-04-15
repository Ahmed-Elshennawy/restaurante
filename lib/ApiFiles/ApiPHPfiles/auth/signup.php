<?php

header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST');
header("Access-Control-Allow-Headers: X-Requested-With");

include '../config/db.php';

$username = filterReq("username");
$email = filterReq("email");
$password = filterReq("password");

$stmt = $con->prepare('INSERT INTO `users` (`username`, `email`, `password`, `wallet_palance`) VALUES (? , ? , ?, 0)');
$stmt->execute(array($username,$email,$password));

$count = $stmt->rowCount();
if($count > 0){
    echo json_encode(array("status"=>"success"));
}else{
    echo json_encode(array("status"=>"fail"));
}