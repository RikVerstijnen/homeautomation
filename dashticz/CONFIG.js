var config = {}
config['domoticz_ip'] = 'http://192.168.1.200:8080';
config['app_title'] = 'Ons huis';
config['domoticz_refresh'] = '5';
config['dashticz_refresh'] = '60';
config['default_news_url'] = 'http://www.nu.nl/rss/algemeen';
config['news_scroll_after'] = '7';
config['standby_after'] = 0;
config['auto_swipe_back_to'] = 1;
config['auto_swipe_back_after'] = '120';
config['auto_slide_pages'] = 0;
config['slide_effect'] = 'slide';
config['standard_graph'] = 'hours';
config['language'] = 'nl_NL';
config['timeformat'] = 'DD-MM-YY HH:mm';
config['calendarformat'] = 'dd DD.MM HH:mm';
config['calendarlanguage'] = 'nl_NL';
config['calendarurl'] = 0;
config['boss_stationclock'] = 'RedBoss';
config['gm_api'] = 0;
config['gm_zoomlevel'] = 0;
config['gm_latitude'] = 0;
config['gm_longitude'] = 0;
config['wu_api'] = 0;
config['wu_city'] = 'Drunen';
config['wu_name'] = 0;
config['wu_country'] = 'NL';
config['idx_moonpicture'] = 0;
config['switch_horizon'] = 0;
config['host_nzbget'] = 0;
config['spot_clientid'] = 0;
config['garbage_company'] = 'mijnafvalwijzer';
config['garbage_icalurl'] = '';
config['garbage_zipcode'] = '5151BW';
config['garbage_street'] = 'Wilhelminastraat';
config['garbage_housenumber'] = '15';
config['garbage_maxitems'] = 3;
config['garbage_width'] = 12;
config['selector_instead_of_buttons'] = 0;
config['auto_positioning'] = 0;
config['use_favorites'] = 1;
config['last_update'] = 1;
config['hide_topbar'] = 1;
config['hide_seconds'] = 1;
config['hide_seconds_stationclock'] = 0;
config['use_fahrenheit'] = 0;
config['use_beaufort'] = 0;
config['translate_windspeed'] = 1;
config['static_weathericons'] = 0;
config['hide_mediaplayer'] = 0;
config['garbage_hideicon'] = 0;

var _CLIENTID_SPOTIFY = 'f0bab48f1f3b480fa8a3ecaf3573d547';

var buttons = {}
buttons.buienradar 		= {width:12, isimage:true, refreshimage:60000, image: 'http://api.buienradar.nl/image/1.0/RadarMapNL?w=285&h=256', url: 'http://www.weeronline.nl/Europa/Nederland/Amsterdam/4058223'}

var frames = {}
frames.energy = {refreshiframe:120000,height:400,frameurl:"https://emoncms.org/vis/multigraph?mid=11549&embed=1",width:12}
frames.temps = {refreshiframe:120000,height:400,frameurl:"https://emoncms.org/vis/multigraph?mid=13675&embed=1",width:12}

var blocks = {}
blocks[323] = {}
blocks[323]['title'] = 'Mode';
blocks[323]['width'] = 12; 
blocks[323]['icon'] = 'fa-power-off';

blocks[387] = {}
blocks[387]['title'] = 'Verlichting';
blocks[387]['width'] = 12; 
blocks[387]['icon'] = 'fa-lightbulb-o';

blocks[487] = {}
blocks[487]['title'] = 'Verwarming';
blocks[487]['width'] = 12; 
blocks[487]['icon'] = 'fa-fire';

blocks[142] = {}
blocks[142]['title'] = 'Rolluiken babykamer';
blocks[142]['width'] = 12; 

blocks[110] = {}
blocks[110]['title'] = 'Rolluiken slaapkamer';
blocks[110]['width'] = 12; 

blocks[347] = {}
blocks[347]['title'] = 'Sproeier';
blocks[347]['width'] = 12; 
blocks[347]['icon'] = 'fa-power-off';

blocks[281] = {}
blocks[281]['title'] = 'Thermostaat';
blocks[281]['width'] = 6; 

blocks[303] = {}
blocks[303]['title'] = 'Woonkamer';
blocks[303]['width'] = 6; 
blocks[303]['hide_lastupdate'] = true

blocks[338] = {}
blocks[338]['title'] = 'Slaapkamer';
blocks[338]['width'] = 6; 

blocks[211] = {}
blocks[211]['title'] = 'Badkamer';
blocks[211]['width'] = 6; 
blocks[211]['hide_lastupdate'] = true

blocks[337] = {}
blocks[337]['title'] = 'Babykamer';
blocks[337]['width'] = 6; 

blocks[210] = {}
blocks[210]['title'] = 'Morris';
blocks[210]['width'] = 6; 
blocks[210]['hide_lastupdate'] = true

blocks[97] = {}
blocks[97]['title'] = 'Verbruik';
blocks[97]['width'] = 6; 
blocks[97]['hide_lastupdate'] = true

blocks[237] = {}
blocks[237]['title'] = 'Opwek';
blocks[237]['width'] = 6; 
blocks[237]['hide_lastupdate'] = true

blocks[98] = {}
blocks[98]['title'] = 'Gasverbruik';
blocks[98]['width'] = 6; 
blocks[98]['hide_lastupdate'] = true

blocks[231] = {}
blocks[231]['title'] = 'Lamp keuken';
blocks[231]['width'] = 12; 
blocks[231]['hide_lastupdate'] = true

blocks[233] = {}
blocks[233]['title'] = 'Lamp achter';
blocks[233]['width'] = 12;
blocks[233]['hide_lastupdate'] = true 

blocks[230] = {}
blocks[230]['title'] = 'Lamp tussen';
blocks[230]['width'] = 12; 
blocks[230]['hide_lastupdate'] = true

blocks[232] = {}
blocks[232]['title'] = 'Lamp zithoek';
blocks[232]['width'] = 12;
blocks[232]['hide_lastupdate'] = true 

blocks[316] = {}
blocks[316]['title'] = 'Schemerlamepn';
blocks[316]['width'] = 12;
blocks[316]['hide_lastupdate'] = true 

blocks[311] = {}
blocks[311]['title'] = 'Buitenlamp';
blocks[311]['width'] = 12;
blocks[311]['hide_lastupdate'] = true

blocks[197] = {}
blocks[197]['title'] = 'Sabine thuis';
blocks[197]['width'] = 12;
blocks[197]['hide_data'] = true;

blocks[187] = {}
blocks[187]['title'] = 'Rik thuis';
blocks[187]['width'] = 12;
blocks[187]['hide_data'] = true;

blocks[300] = {}
blocks[300]['title'] = 'Beweging binnen';
blocks[300]['width'] = 12;
blocks[300]['hide_data'] = true;

blocks[100] = {}
blocks[100]['title'] = 'Beweging buiten';
blocks[100]['width'] = 12;
blocks[100]['hide_data'] = true;

blocks[438] = {}
blocks[438]['title'] = 'Voordeur';
blocks[438]['width'] = 12;
blocks[438]['hide_data'] = true;

blocks[437] = {}
blocks[437]['title'] = 'Achterdeur';
blocks[437]['width'] = 12;
blocks[437]['hide_data'] = true;
blocks[437]['show_lastupdate'] = false; //werkt niet

var columns = {}
columns[11] = {}
columns[11]['width'] = 4;
columns[11]['blocks'] = [323,387,487,142,110,347]

columns[12] = {}
columns[12]['width'] = 4;
columns[12]['blocks'] = [buttons.buienradar,'garbage','spotify']

columns[13] = {}
columns[13]['width'] = 4;
columns[13]['blocks'] = [
281,'303_1', // Thermostaat | Woonkamer
338,'211_1', // Slaapkamer | Badkamer
337,'210_1', // Babykamer | Morris
'97_1','237_1', // Verbruik nu | Opwek nu
'97_2','237_2', // Verbruik vandaag | Opwek vandaag
'98_1','97_5' // Gas | Teruglevering vandaag
]

columns[21] = {}
columns[21]['width'] = 4;
columns[21]['blocks'] = [231,233,230,232,316,311]

columns[22] = {}
columns[22]['width'] = 2;
columns[22]['blocks'] = [197,187,300,100,438,437]

columns[31] = {}
columns[31]['width'] = 12;
columns[31]['blocks'] = [frames.energy]

columns[41] = {}
columns[41]['width'] = 12;
columns[41]['blocks'] = [frames.temps]

var screens = {}
screens[1] = {}
screens[1]['background'] = 'bg2.jpg';
screens[1]['columns'] = [11,12,13]

screens[2] = {}
screens[2]['background'] = 'bg2.jpg';
screens[2]['columns'] = [21,22,23]

screens[3] = {}
screens[3]['background'] = 'bg2.jpg';
screens[3]['columns'] = [31]

screens[4] = {}
screens[4]['background'] = 'bg2.jpg';
screens[4]['columns'] = [41]