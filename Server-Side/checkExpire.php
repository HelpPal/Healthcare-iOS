<?php
$debug = false;

 //$debug = true;

if($debug) {
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);
}

include("db.php");
include("Push.php");
header('Content-Type: application/json');


$expires = $db->getRows("SELECT * FROM users WHERE subscribed = 1 AND expire < CURDATE()+3 AND expire > CURDATE()");
foreach($expires as $expire)
{
    Push::expire($expire);
}
$db->updateRow("UPDATE users SET subscribed = 0 WHERE expire = CURDATE()");

?>