<?php

header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST');
header("Access-Control-Allow-Headers: X-Requested-With");

include '../config/db.php';

$id = filterReq(("id"));
$wallet_palance = filterReq(("wallet_palance"));

$stmt = $con->prepare('UPDATE users SET `wallet_palance` = ? where `id` = ?');

$stmt->execute(array($wallet_palance,$id));
$count = $stmt->rowCount();

if($count > 0){
    echo json_encode(array("status"=>"success"));
}else{
    echo json_encode(array("status"=>"fail"));
}