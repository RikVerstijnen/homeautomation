####################
#        GAS SCRIPT         #
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
$text = file_get_contents("http://192.168.1.196:8080/json.htm?type=devices&rid=98", false, $context);
$json = json_decode($text, true);
$data =  $json['result']['0']['Counter'];
$emon = $data * 100;

$url = "http://emoncms.org/input/post.json?json={totalgas:" . $emon . "}&apikey=c3bd4e4a2d1fd6ea68170f106ba00ad3";
$ch = curl_init($url);
curl_setopt($ch,CURLOPT_URL, $url);

$response = curl_exec($ch);
curl_close($ch);

}
?>