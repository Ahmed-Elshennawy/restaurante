<?php

header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST');
header("Access-Control-Allow-Headers: X-Requested-With");

include '../config/db.php';

$userid = filterReq("id");

$stmt = $con->prepare("SELECT * FROM orders WHERE `order_user` = ?");
$stmt->execute(array($userid));

$data = $stmt->fetchAll(PDO::FETCH_ASSOC);
$count = $stmt->rowCount();
if($count > 0){
    echo json_encode(array("status"=>"success", "data" => $data));
}else{
    echo json_encode(array("status"=>"fail"));
}