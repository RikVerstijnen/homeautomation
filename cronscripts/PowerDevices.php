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

// 47 Diepvries
$text = file_get_contents("http://192.168.1.196:8080/json.htm?type=devices&rid=47", false, $context);
$json = json_decode($text, true);
$data =  $json['result']['0']['Data'];
$emon = substr($data,0,strpos($data, 'W')-1);

$url = "http://emoncms.org/input/post.json?json={Diepvries:" . $emon . "}&apikey=c3bd4e4a2d1fd6ea68170f106ba00ad3";
$ch = curl_init($url);
curl_setopt($ch,CURLOPT_URL, $url);

$response = curl_exec($ch);
curl_close($ch);

// 80 CloseIn
$text = file_get_contents("http://192.168.1.196:8080/json.htm?type=devices&rid=80", false, $context);
$json = json_decode($text, true);
$data =  $json['result']['0']['Data'];
$emon = substr($data,0,strpos($data, 'W')-1);

$url = "http://emoncms.org/input/post.json?json={CloseIn:" . $emon . "}&apikey=c3bd4e4a2d1fd6ea68170f106ba00ad3";
$ch = curl_init($url);
curl_setopt($ch,CURLOPT_URL, $url);

$response = curl_exec($ch);
curl_close($ch);

// 79 Wassen
$text = file_get_contents("http://192.168.1.196:8080/json.htm?type=devices&rid=79", false, $context);
$json = json_decode($text, true);
$data =  $json['result']['0']['Data'];
$emon = substr($data,0,strpos($data, 'W')-1);

$url = "http://emoncms.org/input/post.json?json={Wassen:" . $emon . "}&apikey=c3bd4e4a2d1fd6ea68170f106ba00ad3";
$ch = curl_init($url);
curl_setopt($ch,CURLOPT_URL, $url);

$response = curl_exec($ch);
curl_close($ch);

// 93 Drogen
$text = file_get_contents("http://192.168.1.196:8080/json.htm?type=devices&rid=80", false, $context);
$json = json_decode($text, true);
$data =  $json['result']['0']['Data'];
$emon = substr($data,0,strpos($data, 'W')-1);

$url = "http://emoncms.org/input/post.json?json={Drogen:" . $emon . "}&apikey=c3bd4e4a2d1fd6ea68170f106ba00ad3";
$ch = curl_init($url);
curl_setopt($ch,CURLOPT_URL, $url);

$response = curl_exec($ch);
curl_close($ch);

// 32 Boiler
$text = file_get_contents("http://192.168.1.196:8080/json.htm?type=devices&rid=32", false, $context);
$json = json_decode($text, true);
$data =  $json['result']['0']['Data'];
$emon = substr($data,0,strpos($data, 'W')-1);

$url = "http://emoncms.org/input/post.json?json={Boiler:" . $emon . "}&apikey=c3bd4e4a2d1fd6ea68170f106ba00ad3";
$ch = curl_init($url);
curl_setopt($ch,CURLOPT_URL, $url);

$response = curl_exec($ch);
curl_close($ch);

// 41 HDMI
$text = file_get_contents("http://192.168.1.196:8080/json.htm?type=devices&rid=41", false, $context);
$json = json_decode($text, true);
$data =  $json['result']['0']['Data'];
$emon = substr($data,0,strpos($data, 'W')-1);

$url = "http://emoncms.org/input/post.json?json={HDMI:" . $emon . "}&apikey=c3bd4e4a2d1fd6ea68170f106ba00ad3";
$ch = curl_init($url);
curl_setopt($ch,CURLOPT_URL, $url);

$response = curl_exec($ch);
curl_close($ch);

// 43 Receiver
$text = file_get_contents("http://192.168.1.196:8080/json.htm?type=devices&rid=43", false, $context);
$json = json_decode($text, true);
$data =  $json['result']['0']['Data'];
$emon = substr($data,0,strpos($data, 'W')-1);

$url = "http://emoncms.org/input/post.json?json={Receiver:" . $emon . "}&apikey=c3bd4e4a2d1fd6ea68170f106ba00ad3";
$ch = curl_init($url);
curl_setopt($ch,CURLOPT_URL, $url);

$response = curl_exec($ch);
curl_close($ch);

// 45 Decoder
$text = file_get_contents("http://192.168.1.196:8080/json.htm?type=devices&rid=45", false, $context);
$json = json_decode($text, true);
$data =  $json['result']['0']['Data'];
$emon = substr($data,0,strpos($data, 'W')-1);

$url = "http://emoncms.org/input/post.json?json={Decoder:" . $emon . "}&apikey=c3bd4e4a2d1fd6ea68170f106ba00ad3";
$ch = curl_init($url);
curl_setopt($ch,CURLOPT_URL, $url);

$response = curl_exec($ch);
curl_close($ch);

// 49 Media
$text = file_get_contents("http://192.168.1.196:8080/json.htm?type=devices&rid=49", false, $context);
$json = json_decode($text, true);
$data =  $json['result']['0']['Data'];
$emon = substr($data,0,strpos($data, 'W')-1);

$url = "http://emoncms.org/input/post.json?json={Media:" . $emon . "}&apikey=c3bd4e4a2d1fd6ea68170f106ba00ad3";
$ch = curl_init($url);
curl_setopt($ch,CURLOPT_URL, $url);

$response = curl_exec($ch);
curl_close($ch);

// 51 TV
$text = file_get_contents("http://192.168.1.196:8080/json.htm?type=devices&rid=51", false, $context);
$json = json_decode($text, true);
$data =  $json['result']['0']['Data'];
$emon = substr($data,0,strpos($data, 'W')-1);

$url = "http://emoncms.org/input/post.json?json={TV:" . $emon . "}&apikey=c3bd4e4a2d1fd6ea68170f106ba00ad3";
$ch = curl_init($url);
curl_setopt($ch,CURLOPT_URL, $url);

$response = curl_exec($ch);
curl_close($ch);

// 53 DVD
$text = file_get_contents("http://192.168.1.196:8080/json.htm?type=devices&rid=53", false, $context);
$json = json_decode($text, true);
$data =  $json['result']['0']['Data'];
$emon = substr($data,0,strpos($data, 'W')-1);

$url = "http://emoncms.org/input/post.json?json={DVD:" . $emon . "}&apikey=c3bd4e4a2d1fd6ea68170f106ba00ad3";
$ch = curl_init($url);
curl_setopt($ch,CURLOPT_URL, $url);

$response = curl_exec($ch);
curl_close($ch);

// 94 Droger
$text = file_get_contents("http://192.168.1.196:8080/json.htm?type=devices&rid=94", false, $context);
$json = json_decode($text, true);
$data =  $json['result']['0']['Data'];
$emon = substr($data,0,strpos($data, 'W')-1);

$url = "http://emoncms.org/input/post.json?json={Droger:" . $emon . "}&apikey=c3bd4e4a2d1fd6ea68170f106ba00ad3";
$ch = curl_init($url);
curl_setopt($ch,CURLOPT_URL, $url);

$response = curl_exec($ch);
curl_close($ch);

}
?>