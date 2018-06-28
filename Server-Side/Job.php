<?php





class Job {

public static function distance($lat1, $lon1, $lat2, $lon2, $unit) {



  $theta = $lon1 - $lon2;
  $dist = sin(deg2rad($lat1)) * sin(deg2rad($lat2)) +  cos(deg2rad($lat1)) * cos(deg2rad($lat2)) * cos(deg2rad($theta));
  $dist = acos($dist);
  $dist = rad2deg($dist);
  $miles = $dist * 60 * 1.1515;
  $unit = strtoupper($unit);

  if ($unit == "K") {
      return ($miles * 1.609344);
  } else if ($unit == "N") {
      return ($miles * 0.8684);
  } else {

      if($miles > 99) 
      {
      $miles = round($miles);

     
return (int)$miles;
      } else {
              return   sprintf('%0.2f',$miles);  
      }
  }
}

public static function get_city($job)
{
    $loc = array();
 $loc['city'] = $job['city'];
            $loc['state'] =  $job['state'];
            $loc['country'] = $job['state'];

            return $loc;

}



 public static function days($jobs, $ios = false, $curentUser = 0) {
     global $db; 
     global $POST;
$newJobs = array();
foreach($jobs as $job)
{

   
   

if($ios) {

$days =  $db->getRows("SELECT * FROM days where job_id = ?", array($job['id']));
$dd = array();
foreach($days as $day)
{
    $day['day'] = $day['day'] - 1;
$dd[] = $day;
}

$job['days'] =$dd;


} else {
 $job['days'] = $db->getRows("SELECT * FROM days where job_id = ?", array($job['id']));
}

$timehours =  count($job['days']) * $job['hours'];

$time = "";
$repeate = $job['repate'];

if($repeate == 1)
{
$repeate = "More then one week";
} else {
   $repeate = "One week"; 
}
 $job['time_desc'] = "Less then $timehours hours per week, $repeate";

 $job['distance'] = Job::distance($job['lat'], $job['longitude'], $POST['lat'], $POST['long'], "M");
   
    $job['location']  = Job::get_city($job);
 

    $medias = 0;
    $ratings = $db->getRows("SELECT * FROM rating WHERE to_user = ? AND type = 1", array($job['id']));
    foreach($ratings as $rating)
    {
        $medias = $medias+$rating['rating'];
    } 
  
    if(count($ratings) > 0) {
    $medias = $medias/count($ratings);
    }

    $job['myRating'] =  0;  
    if($curentUser > 0) {
        $myRating =  $db->getRow("SELECT * FROM rating WHERE to_user = ? AND user_id = ? AND type = 1", array($job['id'], $curentUser))['rating'];
                if($myRating > 0) {
            $job['myRating'] = $myRating;
                } else {
                    $job['myRating'] =  0;    
                }
            }

   
    $job['userRating'] =  $medias;


$newJobs[] = $job;




} 
return $newJobs;
 }

 public static function jobInfo($jobID, $curentUser = 0) {
     global $db; 

$job = $db->getRow("SELECT * FROM jobs WHERE id = $jobID");
$job['days'] = $db->getRows("SELECT * FROM days where job_id = ?", array($jobID));



$timehours =  count($job['days']) * $job['hours'];

$time = "";
$repeate = $job['repate'];

if($repeate == 1)
{
$repeate = "More then one week";
} else {
   $repeate = "One week"; 
}
 $job['time_desc'] = "Less then $timehours hours per week, $repeate";

 $job['distance'] =  Job::distance($job['lat'], $job['longitude'], $POST['lat'], $POST['long'], "M");
   
    $job['location'] = Job::get_city($job);
    

    $medias = 0;
    $ratings = $db->getRows("SELECT * FROM rating WHERE to_user = ? AND type = 1", array($job['id']));
    foreach($ratings as $rating)
    {
        $medias = $medias+$rating['rating'];
    } 
  
    if(count($ratings) > 0) {
    $medias = $medias/count($ratings);
    }

    $job['myRating'] =  0;  
    if($curentUser > 0) {
        $myRating =  $db->getRow("SELECT * FROM rating WHERE to_user = ? AND user_id = ? AND type = 1", array($job['id'], $curentUser))['rating'];
                if($myRating > 0) {
            $job['myRating'] = $myRating;
                } else {
                    $job['myRating'] =  0;    
                }
            }

    $job['myRating'] =  $medias;
    $job['userRating'] =  $medias;
   //  Job::get_location($job['lat'], $job['longitude']);
    
return $job;
 }

}
?>