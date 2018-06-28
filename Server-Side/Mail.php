<?php




class Mail
{


public static function header()
{
     $header = "From:no-repply@hr.com \r\n";
         $header .= "Cc:no-repply@hr.com \r\n";
         $header .= "MIME-Version: 1.0\r\n";
         $header .= "Content-type: text/html\r\n";
         return $header;
}
    public static function sendMail($user, $type) {

     if($type == "register_cna")
     {
mail($user['email'], "Registered succesfull","Registered succesfull", Mail::header());
     }

if($type == "register")
{
mail($user['email'], "Registered succesfull","Registered succesfull", Mail::header());
}

if($type == "recover")
{
mail($user['email'], "Recover Password","Recover Password", Mail::header());
}

    }




     public static function offer($user,$job, $type) {
       
if($type == "offer_accept")
{
mail($user['email'], "Offer was accepted","Offer was accepted", Mail::header());
     } 


     if($type == "offer_refuse")
{
mail($user['email'], "Offer was refused","Offer was refused",Mail::header());
     }


     if($type == "offer_job")
{
mail($user['email'], "Your have and offer for your job","Your have and offer for your job",Mail::header());
     }  

}

}

?>