<?php 

function filterReq($request){
   return htmlspecialchars(strip_tags($_POST[$request]));
}


define("MB", 1048576);

function imageUpload($imageRequest){
   global $Error;
   $imagename =  rand(1000,10000). $_FILES[$imageRequest]['name'];
   $imagetmp = $_FILES[$imageRequest]['tmp_name'];
   $imagesize = $_FILES[$imageRequest]['size'];
   $allowExt = array("jpg","png","gif","jpeg");

   $strToArray = explode(".", $imagename);
   $ext = strtolower(end($strToArray));
   if(!empty($imagename) && !in_array($ext, $allowExt)){
      $Error[] = "Ext";
   }
   if($imagesize > 10 * MB){
      $Error[] = "size";
   }

   if(empty($Error)){
      move_uploaded_file($imagetmp, "upload/" . $imagename);
      return $imagename;
   }else{
      return "fail";
   }
}

function deleteFile($dir, $imagename){
   $path = $dir . "/" . $imagename;
   if(file_exists($path)){
      unlink($path);
   }
}

function checkAuthenticate(){
   if (isset($_SERVER['PHP_AUTH_USER'])  && isset($_SERVER['PHP_AUTH_PW'])) {
      if ($_SERVER['PHP_AUTH_USER'] != "restaurante" ||  $_SERVER['PHP_AUTH_PW'] != "restaurante123"){
            header('WWW-Authenticate: Basic realm="My Realm"');
            header('HTTP/1.0 401 Unauthorized');
            echo 'Page Not Found';
            exit;
         }
      } else {
         echo "no api key";
         exit;
      }
   }

?>