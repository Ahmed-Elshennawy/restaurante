<?php

include '../config/db.php';

$userid = filterReq("id");

$stmt = $con->prepare("SELECT * FROM orders WHERE `order_user_id` = ?");
$stmt->execute(array($userid));

$data = $stmt->fetchAll(PDO::FETCH_ASSOC);
$count = $stmt->rowCount();
if($count > 0){
    echo json_encode(array("status"=>"success", "data" => $data));
}else{
    echo json_encode(array("status"=>"fail"));
}