####################
#  POWER DEVICES   #
####################

<?php

$i = 0;

while ($i <=3) {
getDevicePower();
sleep(15);
$i++;
}

function getDevicePower()
{
$context = stream_context_create(array(
    'http' => array(
        'header'  => "Authorization: Basic " . base64_encode("user:Rickyboy22")
    )
));

// 303 Woonkamer
$text = file_get_contents("http://192.168.1.196:8080/json.htm?type=devices&rid=303", false, $context);
$json = json_decode($text, true);

$data =  $json['result']['0']['Temp'];
$emon = $data;
$url = "http://emoncms.org/input/post.json?json={Temp_Woonkamer:" . $emon . "}&apikey=c3bd4e4a2d1fd6ea68170f106ba00ad3";
$ch = curl_init($url);
curl_setopt($ch,CURLOPT_URL, $url);
$response = curl_exec($ch);
curl_close($ch);

$data =  $json['result']['0']['Humidity'];
$emon = $data;
$url = "http://emoncms.org/input/post.json?json={Vocht_Woonkamer:" . $emon . "}&apikey=c3bd4e4a2d1fd6ea68170f106ba00ad3";
$ch = curl_init($url);
curl_setopt($ch,CURLOPT_URL, $url);
$response = curl_exec($ch);
curl_close($ch);

// 209 Buiten
$text = file_get_contents("http://192.168.1.196:8080/json.htm?type=devices&rid=209", false, $context);
$json = json_decode($text, true);

$data =  $json['result']['0']['Temp'];
$emon = $data;
$url = "http://emoncms.org/input/post.json?json={Temp_Buiten:" . $emon . "}&apikey=c3bd4e4a2d1fd6ea68170f106ba00ad3";
$ch = curl_init($url);
curl_setopt($ch,CURLOPT_URL, $url);
$response = curl_exec($ch);
curl_close($ch);

$data =  $json['result']['0']['Humidity'];
$emon = $data;
$url = "http://emoncms.org/input/post.json?json={Vocht_Buiten:" . $emon . "}&apikey=c3bd4e4a2d1fd6ea68170f106ba00ad3";
$ch = curl_init($url);
curl_setopt($ch,CURLOPT_URL, $url);
$response = curl_exec($ch);
curl_close($ch);

// 210 Babykamer
$text = file_get_contents("http://192.168.1.196:8080/json.htm?type=devices&rid=210", false, $context);
$json = json_decode($text, true);

$data =  $json['result']['0']['Temp'];
$emon = $data;
$url = "http://emoncms.org/input/post.json?json={Temp_Babykamer:" . $emon . "}&apikey=c3bd4e4a2d1fd6ea68170f106ba00ad3";
$ch = curl_init($url);
curl_setopt($ch,CURLOPT_URL, $url);
$response = curl_exec($ch);
curl_close($ch);

$data =  $json['result']['0']['Humidity'];
$emon = $data;
$url = "http://emoncms.org/input/post.json?json={Vocht_Babykamer:" . $emon . "}&apikey=c3bd4e4a2d1fd6ea68170f106ba00ad3";
$ch = curl_init($url);
curl_setopt($ch,CURLOPT_URL, $url);
$response = curl_exec($ch);
curl_close($ch);

// 211 Badkamer
$text = file_get_contents("http://192.168.1.196:8080/json.htm?type=devices&rid=211", false, $context);
$json = json_decode($text, true);

$data =  $json['result']['0']['Temp'];
$emon = $data;
$url = "http://emoncms.org/input/post.json?json={Temp_Badkamer:" . $emon . "}&apikey=c3bd4e4a2d1fd6ea68170f106ba00ad3";
$ch = curl_init($url);
curl_setopt($ch,CURLOPT_URL, $url);
$response = curl_exec($ch);
curl_close($ch);

$data =  $json['result']['0']['Humidity'];
$emon = $data;
$url = "http://emoncms.org/input/post.json?json={Vocht_Badkamer:" . $emon . "}&apikey=c3bd4e4a2d1fd6ea68170f106ba00ad3";
$ch = curl_init($url);
curl_setopt($ch,CURLOPT_URL, $url);
$response = curl_exec($ch);
curl_close($ch);

}
?>