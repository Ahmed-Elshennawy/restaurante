<?php

include '../config/db.php';

$id = filterReq("id");
$stmt = $con->prepare("SELECT * FROM users where id = $id");
$stmt->execute(array($id));

$data = $stmt->fetch(PDO::FETCH_ASSOC);
$count = $stmt->rowCount();
if($count > 0){
    echo json_encode(array("status"=>"success", "data" => $data));
}else{
    echo json_encode(array("status"=>"fail"));
}