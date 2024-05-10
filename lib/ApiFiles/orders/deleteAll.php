<?php

include '../config/db.php';

$order_user_id = filterReq("id");

$stmt = $con->prepare("DELETE FROM orders WHERE `order_user_id` = ?");

$stmt->execute(array($order_user_id));
$count = $stmt->rowCount();

if($count > 0){
    echo json_encode(array("status"=>"success"));
}else{
    echo json_encode(array("status"=>"fail"));
}