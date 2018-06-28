<?

class iOSpush
{


      private function normalize_token($token) {

            $token = str_replace('<', '', $token);
            $token = str_replace('>', '', $token);
            $token = str_replace(' ', '', $token);
            return $token;

        }


        private static function generate_aps_payload($notification, $badge = null, $additional_fields = null) {

            $aps = array(
                'alert' => $notification,
                'sound' => 'default'
            );
            if ($badge !== null) $aps['badge'] = $badge;
            if (count($additional_fields) > 0) {

                foreach ($additional_fields as $key=>$value) {

                    $aps[$key] = $value;

                }

            }

            $body['aps'] = $aps;
            $payload = json_encode($body);
            return $payload;

        }



        
public static function sendToUsers($registrationIds,$msg)
{

// if(1 == 2) {
     $cert_file = null;
            $aps_url = null;


                $cert_file = '../aps.pem';
if (!file_exists($cert_file)) {
         $cert_file = 'aps.pem';
}


                  $aps_url = 'ssl://gateway.sandbox.push.apple.com:2195';
            //    $aps_url = 'ssl://gateway.push.apple.com:2195';

     $tokens = $registrationIds;
            $ctx = stream_context_create();
            stream_context_set_option($ctx, 'ssl', 'local_cert', $cert_file);
            stream_context_set_option($ctx, 'ssl', 'passphrase', 'dd');

            $fp = stream_socket_client($aps_url, $err, $errstr, 60, STREAM_CLIENT_CONNECT | STREAM_CLIENT_PERSISTENT, $ctx);
            if (!$fp) return false;









         

            $notification =  $msg['push'];
       
            $badge = $msg['badge'];
$additional_fields = array();

$additional_fields['info'] = $msg;
            $payload = iOSpush::generate_aps_payload($notification, $badge, $additional_fields);



            foreach ($tokens as $token) {
                
                $message = chr(0) . pack('n', 32) . pack('H*', $token) . pack('n', strlen($payload)) . $payload;
                $result = fwrite($fp, $message, strlen($message));



            }

            // print_r($tokens);
if (!$result) {
		//	echo "Message not delivered ->" . PHP_EOL;
}else {
		//	echo "Message successfully delivered -> " . PHP_EOL;
            fclose($fp);
}
}

//} 


}
?>