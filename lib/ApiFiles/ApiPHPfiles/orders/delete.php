<?php

header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST');
header("Access-Control-Allow-Headers: X-Requested-With");

include '../config/db.php';

$orderid = filterReq("id");

$stmt = $con->prepare("DELETE FROM orders WHERE `order_id` = ?");

$stmt->execute(array($orderid));
$count = $stmt->rowCount();

if($count > 0){
    echo json_encode(array("status"=>"success"));
}else{
    echo json_encode(array("status"=>"fail"));
}