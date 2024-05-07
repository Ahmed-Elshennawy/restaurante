<?php

include '../config/db.php';

$id = filterReq(("id"));
$theme = filterReq(("theme"));

$stmt = $con->prepare('UPDATE users SET `theme` = ? where `id` = ?');

$stmt->execute(array($theme,$id));
$count = $stmt->rowCount();

if($count > 0){
    echo json_encode(array("status"=>"success"));
}else{
    echo json_encode(array("status"=>"fail"));
}