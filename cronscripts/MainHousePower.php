####################
#        POWER SCRIPT         #
####################

<?php

$i = 0;

while ($i <=3) {
getMainHousePower();
sleep(15);
$i++;
}

function getMainHousePower()
{
$context = stream_context_create(array(
    'http' => array(
        'header'  => "Authorization: Basic " . base64_encode("user:Rickyboy22")
    )
));

//Total consumption
$text = file_get_contents("http://192.168.1.196:8080/json.htm?type=devices&rid=97", false, $context);
$json = json_decode($text, true);
$data =  $json['result']['0']['Usage'];
$emon = substr($data,0,strpos($data, 'W')-1);

$url = "http://emoncms.org/input/post.json?json={totalpower:" . $emon . "}&apikey=c3bd4e4a2d1fd6ea68170f106ba00ad3";
$ch = curl_init($url);
curl_setopt($ch,CURLOPT_URL, $url);

$response = curl_exec($ch);
curl_close($ch);

//Total delivery
$text = file_get_contents("http://192.168.1.196:8080/json.htm?type=devices&rid=97", false, $context);
$json = json_decode($text, true);
$data =  $json['result']['0']['UsageDeliv'];
$emon = substr($data,0,strpos($data, 'W')-1);

$url = "http://emoncms.org/input/post.json?json={totaldelivery:" . $emon . "}&apikey=c3bd4e4a2d1fd6ea68170f106ba00ad3";
$ch = curl_init($url);
curl_setopt($ch,CURLOPT_URL, $url);

$response = curl_exec($ch);
curl_close($ch);

//Total generation
$text = file_get_contents("http://192.168.1.196:8080/json.htm?type=devices&rid=237", false, $context);
$json = json_decode($text, true);
$data =  $json['result']['0']['Usage'];
$emon = substr($data,0,strpos($data, 'W')-1);

$url = "http://emoncms.org/input/post.json?json={totalgeneration:" . $emon . "}&apikey=c3bd4e4a2d1fd6ea68170f106ba00ad3";
$ch = curl_init($url);
curl_setopt($ch,CURLOPT_URL, $url);

$response = curl_exec($ch);
curl_close($ch);

//DC voltage
$text = file_get_contents("http://192.168.1.196:8080/json.htm?type=devices&rid=238", false, $context);
$json = json_decode($text, true);
$data =  $json['result']['0']['Voltage'];
$emon = $data;

$url = "http://emoncms.org/input/post.json?json={dcvoltage:" . $emon . "}&apikey=c3bd4e4a2d1fd6ea68170f106ba00ad3";
$ch = curl_init($url);
curl_setopt($ch,CURLOPT_URL, $url);

$response = curl_exec($ch);
curl_close($ch);

}
?>