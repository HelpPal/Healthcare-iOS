 <?php


 function get_city($job)
{
    $loc = array();
 $loc['city'] = $job['city'];
            $loc['state'] =  $job['state'];
            $loc['country'] = $job['state'];
$loc['address'] = $job['address'];
            return $loc;

}


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
//echo $response->geoplugin_region;
//echo $response->geoplugin_countryCode;

    // $request = 'http://maps.googleapis.com/maps/api/geocode/json?latlng='.$geolocation.'&sensor=false'; 
    // $file_contents = file_get_contents($request);
    // $json_decode = json_decode($file_contents);

    // print_r($json_decode);
    // if(isset($json_decode->results[0])) {
    //     $response = array();
    //      $response2 = array();
    //     foreach($json_decode->results[0]->address_components as $addressComponet) {
    //         if(in_array('political', $addressComponet->types)) {
    //                 $response[] = $addressComponet->long_name; 
    //                     $response2[] = $addressComponet->short_name;
    //         }
    //     }

    //     if(isset($response[0])){ $first  =  $response2[0];  } else { $first  = 'null'; }
    //     if(isset($response[1])){ $second =  $response2[1];  } else { $second = 'null'; } 
    //     if(isset($response[2])){ $third  =  $response2[2];  } else { $third  = 'null'; }
    //     if(isset($response[3])){ $fourth =  $response2[3];  } else { $fourth = 'null'; }
    //     if(isset($response[4])){ $fifth  =  $response2[4];  } else { $fifth  = 'null'; }


    //     $loc['address']=''; $loc['city']=''; $loc['state']=''; $loc['country']='';
    //     if( $first != 'null' && $second != 'null' && $third != 'null' && $fourth != 'null' && $fifth != 'null' ) {
    //         $loc['address'] = $first;
    //         $loc['city'] = $second;
    //         $loc['state'] = $fourth;
    //         $loc['country'] = $fifth;
    //     }
    //     else if ( $first != 'null' && $second != 'null' && $third != 'null' && $fourth != 'null' && $fifth == 'null'  ) {
    //         $loc['address'] = $first;
    //         $loc['city'] = $second;
    //         $loc['state'] = $third;
    //         $loc['country'] = $fourth;
    //     }
    //     else if ( $first != 'null' && $second != 'null' && $third != 'null' && $fourth == 'null' && $fifth == 'null' ) {
    //         $loc['city'] = $first;
    //         $loc['state'] = $second;
    //         $loc['country'] = $third;
    //     }
    //     else if ( $first != 'null' && $second != 'null' && $third == 'null' && $fourth == 'null' && $fifth == 'null'  ) {
    //         $loc['state'] = $first;
    //         $loc['country'] = $second;
    //     }
    //     else if ( $first != 'null' && $second == 'null' && $third == 'null' && $fourth == 'null' && $fifth == 'null'  ) {
    //         $loc['country'] = $first;
    //     }
    //   }
    //   return $loc;
}

function yearsDifference($endDate, $beginDate)
{
   $date_parts1=explode("-", $beginDate);
   $date_parts2=explode("-", $endDate);
   return $date_parts2[0] - $date_parts1[0];
}
 
//echo yearsDifference('2011-03-12','2008-03-09');

function distance($lat1, $lon1, $lat2, $lon2, $unit) {

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


class User {

 public static function profile($user, $type, $curentUser = 0) {
     global $db; 
     global $POST;
if($type == "id")
{
$user = $db->getRow("SELECT * FROM users WHERE id = ?", array($user));

 $skills = User::skills($user['id']);

 $otherSkill = explode(",",$user['other_skills']);

 foreach($otherSkill as $skil)
 {

    if(strlen($skil) > 0) {
 
    $skills[] = array("id"=>"35", "name"=>$skil);
    }
 }

 $user['skills'] = $skills;

   unset($user['password']);
     unset($user['subscribed']);
     unset($user['registration_time']);
     unset($user['other_skills']);
   //  echo $fee['address_lat'];
$user['location'] =  get_city($user);

//get_location($user['address_lat'], $user['address_long']);

//$user['birthday']


$date2 = date_create($user['birthday']);
 $date2=  date_format($date2,"Y-m-d");
     $user['years'] = yearsDifference(date("Y-m-d"), $date2);
    $user['distance'] = distance($user['address_lat'], $user['address_long'], $POST['lat'], $POST['long'], "M");
    $medias = 0;
  $ratings = $db->getRows("SELECT * FROM rating WHERE to_user = ? AND type = 1", array($user['id']));
  foreach($ratings as $rating)
  {
      $medias = $medias+$rating['rating'];
  } 

  if(count($ratings) > 0) {
  $medias = $medias/count($ratings);
  }
    $user['userRating'] = $medias;

    $user['myRating'] = 0;

    if($curentUser > 0) {
$myRating =  $db->getRow("SELECT * FROM rating WHERE to_user = ? AND user_id = ? AND type = 1", array($user['id'], $curentUser))['rating'];
        if($myRating > 0) {
    $user['myRating'] = $myRating;
        } else {
            $user['myRating'] =  0;    
        }
    }
    

}
return $user;

    }


    public static function skills($userid)
    {
        global $db; 
$skillsList = array();
$skills = $db->getRows("SELECT * from skills_attribute WHERE user_id = ?", array($userid));
foreach($skills as $skill)
{
  

    $skillsList[] = $db->getRow("SELECT * FROM skills WHERE id = ?", array($skill['skill_id']));

}



return $skillsList;
    }

}

    ?>