<!-- Change the text for on/off switches -->
<!-- var txt_on = '<img src=icons/on.png>'; -->
<!-- var txt_off = '<img src=icons/off.png>'; -->
var txt_on = 'Aan';
var txt_off = 'Uit';
var txt_zonon = 'Uit'; <!-- Dicht -->
var txt_zonoff = 'In'; <!-- Open -->
var txt_zonstopped = 'Gestopt';
var txt_zonstop = '| |';
<!-- var txt_dim_plus = ' + '; -->
<!-- var txt_dim_min = ' - '; -->

<!-- Change the text displayed in PopUps -->
var txt_switch_protected = '\'Schakelaar is beveiligd\'';
var txt_switch_on = '\'Inschakelen\'';
var txt_switch_off = '\'Uitschakelen\'';
var txt_blind_up = '\'Zonnescherm uit\'';
var txt_blind_down = '\'Zonnescherm in\'';
var txt_blind_stop = '\'Zonnescherm stoppen\'';

<!-- Change the timeout of the PopUp -->
var switch_protected_timeout = '1500';
var switch_on_timeout = '1500';
var switch_off_timeout = '1500';
var camera_doorbell_timeout = '15400';

<!-- Value for ZWave dimmer when on-->
var idx_zdimmer = '';
var z_dimmer = '';
var z_whichdimmer = '';
//var o_dimmer = '80'; //value 80 is for light in garden
//var o_whichdimmer = '';

<!-- Set values so colors can change -->
var temp_freeze = '0';
var temp_freeze_color = ';color:#0090ff;';
var humidity_max = '70';
var humidity_max_color = ';color:#0090ff;';
var CPUmem_max = '95';
var mem_max_color = ';color:red;';
var CPUusage_max = '50';
var cpu_max_color = ';color:red;';
var color_on = ';color:#1B9772;';
var color_off = ';color:#E24E2A;';
var show_sonos_volume = true; <!-- show Sonos volume in desc text -->

<!-- Change idx of special items -->
var idx_CPUmem = '11';
var idx_HDDmem = '13';
var idx_CPUusage = '17';
var idx_CPUtemp = '1100';
var idx_SunState = '198'; //Ingevuld
var idx_IsDonker = '198'; <!-- for day night css -->
var idx_FibaroWP = '1100';
var idx_Alarm = '109';
var idx_Rainmeter = '39';
var idx_Temp1 = '18';
var idx_Temp2 = '211';
var idx_Temp3 = '178';
var idx_Temp_buiten = '247';
var idx_Tempf = '154';
var idx_Iphone5s = '214';
var idx_Telefoon_m = '185';
var idx_Voordeur = '23'; //'207';
var idx_Garagedeur = '27'; //'208';
var idx_WindRichting = '100';
var idx_WindSnelheid = '101';
var idx_BewegingF = '145';
var idx_LuxF = '147';
var idx_ZonV = '142'; //Ingevuld
var idx_ZonA = '110'; //Ingevuld
var idx_Barometer = '214'; //Ingevuld
var idx_Visibility = '53';
var idx_Usage1 = '97'; //Ingevuld
var idx_Usage2 = '237'; //Ingevuld
var idx_Gas = '98' //Ingevuld
var idx_UsageTot1 = '97'; //Ingevuld
var idx_UsageTot2 = '237'; //Ingevuld
var idx_Pi = '218';
var idx_PC = '216';
var idx_TV = '240';

var idx_water_meter = '1100';
var idx_doorbell = '1100';
var idx_electricity_today = '0'; //Ingevuld
var idx_gas_today = '0'; //Ingevuld
var idx_ram_usage = '1100';
var idx_cpu_usage = '1100';

var IsNight = 'No';

<!-- Text for vdesc -->
var desc_alarm_off = 'Alarm uit';
var desc_alarm_home = 'Alarm aan (thuis)';
var desc_alarm_away = 'Alarm aan (weg)';
var desc_sunrise = 'Zon op';
var desc_sunset = 'Zon onder';
var desc_showsunboth = ''; // used to show sunrise and sunset in vdesc
var txt_sunboth='';
var txt_sunset='Zon onder';
var txt_sunrise='Zon op';
var var_sunrise='';
var var_sunset='';
var desc_protected = '<img src=icons/lock-closed_w.png align=right style="margin:1.5px 3px 0px -10px">'; //shows lock picture if device is protected or when plusmin is 4

<!-- This triggers the camera PopUp when the doorbell is pressed -->
<!-- Text could be 'On', 'Group On' or 'Chime' -->
var doorbell_status = 'On';
var idx_doorbell = '213'; //dummy switch which goes on when doorbell rings, goes off after 10 seconds
var doorbell_cmd = "lightbox_open('camera1', 15400);"

// ############################################################################################################
// #### vvvvv   USER VALUES below vvvvv   #######
// ############################################################################################################

$(document).ready(function() {
        $.roomplan=26	// define roomplan in Domoticz and create items below.
        $.domoticzurl="http://192.168.1.200:8080";
		//format: idx, value, label, description, lastseen(1 when lastseen is wanted, 2 is only time), plusmin button or protected (0 for empty, 1 for buttons, 2 for volume of Sonos, 4 for protected, 5 for zwave dimmer, 6 for protected when on), [override css], [alarm value]
        $.PageArray = [

	['0','Desc',		'cell1',	'Badkamer','2','0'], //Desc means show the sub cells
	['211','Temp',		'cell1a',	'Badkamer','2','0'], //Lastseen only from cell_a possible
	['211','Humidity',	'cell1b',	'Badkamer','2','0'],
	['0','Desc',		'cell2',	'Babykamer','2','0'],
	['210','Temp',		'cell2a',	'Babykamer','2','0'],
	['210','Humidity',	'cell2b',	'Babykamer','2','0'],
	//['214','ForecastStr',	'cell3',	'Weersvoorspelling','0','0'],
	['0','Desc',		'cell4',	'Kamer','2','0'],
	['303','Temp',		'cell4a',	'Kamer','2','0'],
	['303','Humidity',	'cell4b',	'Kamer','2','0'],
	['0','Desc',		'cell5',	'Buiten','2','0'],
	['209','Temp',		'cell5a',	'Buiten','2','0'],
	['209','Humidity',	'cell5b',	'Buiten','2','0'],

	['323','Selector',   'cell6',   'Mode','0','5'],
	['324','Status',		'cell7',	'Verlichting','2','0'],
	['347','Status',	'cell8',	'Tuinsproeier achter','2','0'],
	['346','Status',	'cell9',	'Ketel loopt','2','4'],
	['281','SetPoint',		'cell10',	'Thermostaat','1','1'],

	['97','CounterToday',		'cell11',	'Verbruik vandaag','2','4'],
	['142','Data',		'cell12',	'Babykamer','2','0'],
	['110','Data',		'cell13',	'Slaapkamer','2','0'],
	['98','CounterToday',		'cell14',	'Gas vandaag','2','4'],		
	['237','CounterToday',	'cell15',	'Opwek vandaag','2','4'],
	
	['97','Usage',	'cell21',	'Verbruik nu','2','4'],	
	['0','Tijd',		'cell22',	'Tijd','0','0'],	
	['237','Usage',		'cell23',	'Opwek nu','2','4'], 
	
	['232','Level','cell2_6',	'Lampen zithoek','1','100'],
	['230','Level',	'cell2_7',	'Lampen tussen','2','1'],
	['233','Level','cell2_8',	'Lampen achter','2','1'],
	['231','Level',	'cell2_9',	'Lampen keuken','2','1'],
	['316','Level',	'cell2_10',	'Schemerlampen','2','5'],
	
	['214','Barometer',	'cell2_11',	'Barometer','2','0'],
	['198','Status',	'cell2_12',	'IsDonker','2','0'],
	['311','Status',		'cell2_12',	'Buitenlamp','2','0']
		
	];
	$.PageArray_Scenes = [
	
	['5','Status',		'cell9',	'Lampen kamer','1','0'],
	//['7','Status',		'cell13',	'Lamp achtertuin','1','0'],
	
	];

// ############################################################################################################
// #### ^^^^^   USER VALUES above ^^^^^   #######
// ############################################################################################################

RefreshData();
});


