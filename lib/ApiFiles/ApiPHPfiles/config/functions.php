<?php 

function filterReq($request){
   return htmlspecialchars(strip_tags($_POST[$request]));
}

?>