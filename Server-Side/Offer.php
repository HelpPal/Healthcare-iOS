<?php
class Offer
{

    public static function getJobID($id) {
    global $db; 
$jobID = $db->getRow("SELECT * FROM offers WHERE id = ?", array($id));
$jobID = $jobID['job_id'];

     return $jobID;

    }

  


}