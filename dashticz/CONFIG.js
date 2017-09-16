var config = {}
config['domoticz_ip'] = 'http://192.168.1.200:8080';
config['app_title'] = 'Ons huis';
config['domoticz_refresh'] = '5';
config['dashticz_refresh'] = '60';
config['default_news_url'] = 'http://www.nu.nl/rss/algemeen';
config['news_scroll_after'] = '7';
config['standby_after'] = 0;
config['auto_swipe_back_to'] = 1;
config['auto_swipe_back_after'] = '10';
config['auto_slide_pages'] = 0;
config['slide_effect'] = 'slide';
config['standard_graph'] = 'hours';
config['language'] = 'en_US';
config['timeformat'] = 'DD-MM-YY HH:mm';
config['calendarformat'] = 'dd DD.MM HH:mm';
config['calendarlanguage'] = 'en_US';
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
config['garbage_company'] = 0;
config['garbage_icalurl'] = 0;
config['garbage_zipcode'] = 0;
config['garbage_street'] = 0;
config['garbage_housenumber'] = 0;
config['garbage_maxitems'] = 0;
config['garbage_width'] = 0;
config['selector_instead_of_buttons'] = 0;
config['auto_positioning'] = 0;
config['use_favorites'] = 1;
config['last_update'] = 1;
config['hide_topbar'] = 0;
config['hide_seconds'] = 0;
config['hide_seconds_stationclock'] = 0;
config['use_fahrenheit'] = 0;
config['use_beaufort'] = 0;
config['translate_windspeed'] = 1;
config['static_weathericons'] = 0;
config['hide_mediaplayer'] = 0;
config['garbage_hideicon'] = 0;

var buttons = {}
buttons.buienradar 		= {width:12, isimage:true, refreshimage:60000, image: 'http://api.buienradar.nl/image/1.0/RadarMapNL?w=285&h=256', url: 'http://www.weeronline.nl/Europa/Nederland/Amsterdam/4058223'}

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

blocks['303_1'] = {}
blocks['303_1']['title'] = 'Woonkamer';
blocks['303_1']['width'] = 6; 

blocks[338] = {}
blocks[338]['title'] = 'Slaapkamer';
blocks[338]['width'] = 6; 

blocks['211_1'] = {}
blocks['211_1']['title'] = 'Badkamer';
blocks['211_1']['width'] = 6; 

blocks[337] = {}
blocks[337]['title'] = 'Babykamer';
blocks[337]['width'] = 6; 

blocks['210_1'] = {}
blocks['210_1']['title'] = 'Morris';
blocks['210_1']['width'] = 6; 

blocks['97_2'] = {}
blocks['97_2']['title'] = 'Verbruik vandaag';
blocks['97_2']['width'] = 6; 

blocks['237_2'] = {}
blocks['237_2']['title'] = 'Opwek vandaag';
blocks['237_2']['width'] = 6; 

blocks['98_1'] = {}
blocks['98_1']['title'] = 'Gasverbruik';
blocks['98_1']['width'] = 6; 

blocks['97_5'] = {}
blocks['97_5']['title'] = 'Teruglevering vandaag';
blocks['97_5']['width'] = 6; 

blocks[210] = {}
blocks[210]['title'] = 'Verbruik nu';
blocks[210]['width'] = 6; 

blocks[210] = {}
blocks[210]['title'] = 'Opwek nu';
blocks[210]['width'] = 6; 

var columns = {}
columns[1] = {}
columns[1]['width'] = 4;
columns[1]['blocks'] = [323,387,487,142,110,347]

columns[2] = {}
columns[2]['width'] = 4;
columns[2]['blocks'] = [buttons.buienradar]

columns[3] = {}
columns[3]['width'] = 4;
columns[3]['blocks'] = [281,'303_1',338,'211_1',337,'210_1','97_2','237_2','98_1','97_5']

var screens = {}
screens[1] = {}
screens[1]['background'] = 'bg2.jpg';
screens[1]['columns'] = [1,2,3]