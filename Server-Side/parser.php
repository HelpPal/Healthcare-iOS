<?php

ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);


include("db.php");
include("Job.php");

function get_location($latitude='', $longitude='')
{
    $geolocation = $latitude.','.$longitude;

   

   $url      = "http://www.geoplugin.net/extras/location.gp?lat=$latitude&long=$longitude&format=json";
$response = json_decode(file_get_contents($url));

$loc['state'] =$response->geoplugin_countryCode;
$loc['country'] = $response->geoplugin_countryCode;
$loc['address'] =$response->geoplugin_region;
$loc['city']= $response->geoplugin_region;
return $loc;
}

$rows = $db->getRows("SELECT * FROM jobs WHERE city = '' and state = ''");

foreach($rows as $job)
{
   $loc =  get_location($job['lat'], $job['longitude']);
print_r($loc);

if(strlen($loc['city']) > 0) {
    $db->updateRow("UPDATE jobs SET city = ?, state =? WHERE id = ?",array($loc['city'],$loc['state'], $job['id']));
}
}




$rows = $db->getRows("SELECT * FROM users WHERE city = '' and state = ''");

foreach($rows as $job)
{
   $loc =  get_location($job['lat'], $job['longitude']);
///print_r($loc);

if(strlen($loc['city']) > 0) {
    $db->updateRow("UPDATE users SET city = ?, state =?, address = ? WHERE id = ?",array($loc['city'],$loc['state'],$loc['address'], $job['id']));
}
}





echo "end";