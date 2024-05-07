<?php

include '../config/db.php';

$id = filterReq("id");

$stmt = $con->prepare("DELETE FROM users WHERE id = ?");

$stmt->execute(array($id));
$count = $stmt->rowCount();

if($count > 0){
    echo json_encode(array("status"=>"success"));
}else{
    echo json_encode(array("status"=>"fail"));
}