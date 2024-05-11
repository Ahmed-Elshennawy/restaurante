<?php

include '../config/db.php';

$id = filterReq("id");
$img = filterReq(("file"));

$stmt = $con->prepare("DELETE FROM users WHERE id = ?");

$stmt->execute(array($id));
$count = $stmt->rowCount();

if($count > 0){
    deleteFile("../profile/upload", $img);
    echo json_encode(array("status"=>"success"));
}else{
    echo json_encode(array("status"=>"fail"));
}