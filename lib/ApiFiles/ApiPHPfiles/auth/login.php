<?php

header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST');
header("Access-Control-Allow-Headers: X-Requested-With");

include '../config/db.php';

$email = filterReq("email");
$password = filterReq("password");

$stmt = $con->prepare("SELECT * FROM users WHERE email = ? AND `password` = ? ");
$stmt->execute(array($email,$password));

$data = $stmt->fetch(PDO::FETCH_ASSOC);
$count = $stmt->rowCount();
if($count > 0){
    echo json_encode(array("status"=>"success", "data" => $data));
}else{
    echo json_encode(array("status"=>"fail"));
}