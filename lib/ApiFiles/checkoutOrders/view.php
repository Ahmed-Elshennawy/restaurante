<?php

include '../config/db.php';

$stmt = $con->prepare('SELECT * FROM checkout_orders');

$stmt->execute();
$data = $stmt->fetchAll(PDO::FETCH_ASSOC);

$count = $stmt->rowCount();
if($count > 0){
    echo json_encode(array("status"=>"success", "data" => $data));
}else{
    echo json_encode(array("status"=>"fail"));
}