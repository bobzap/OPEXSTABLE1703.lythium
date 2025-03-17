if (isDedicated) exitWith {};
if (!OPEX_intro) exitWith {};

// INITALIZING SOUNDS
enableRadio false;
0 fadeSound 0;
0 fadeMusic 0.5;
player allowDamage false;

// CREDITS & MAIN TITLE
private ["_sound"];
//if (!OPEX_debug) then {disableUserInput true};
//0 cutText ["", "black in", 10e10];
sleep 2;
1 cutRsc ["inmemoriam_faiavan","plain"]; // in the memory of Faiavan (https://www.youtube.com/user/faiavan / https://youtu.be/EFPklwvREFo)
sleep 2;
playMusic "EventTrack01_F_EPB";
1 cutRsc ["presentationSplash","plain"];
sleep 2;
player setBehaviour "safe";
player playMove "AmovPercMstpSlowWrflDnon";
sleep 2;
private _OPEX = "OPEX_neutral";
switch OPEX_friendly_subFaction do
	{
		case "STR_friendly_subFaction_France"	:	{_OPEX = "OPEX_france"};
		case "STR_friendly_subFaction_USA"		:	{_OPEX = "OPEX_usa"};
		case "STR_friendly_subFaction_Russia"	:	{_OPEX = "OPEX_russia"};
		case "STR_friendly_subFaction_Spain"	:	{_OPEX = "OPEX_spain"};
		case "STR_friendly_subFaction_UK"		:	{_OPEX = "OPEX_uk"};
		case "STR_friendly_subFaction_Germany"	:	{_OPEX = "OPEX_germany"};
		case "STR_friendly_subFaction_Czechia"	:	{_OPEX = "OPEX_czechia"};
		case "STR_friendly_subFaction_Canada"	:	{_OPEX = "OPEX_canada"};
		case "STR_friendly_subFaction_Italy"	:	{_OPEX = "OPEX_italy"};
		default										{_OPEX = "OPEX_default"};
	};
1 cutRsc [_OPEX,"PLAIN"];
sleep 2;
0 cutText ["", "black in", 3];
1 cutText ["", "black in", 3];
disableUserInput false;

// BLUR EFFECT
"dynamicBlur" ppEffectEnable true;
"dynamicBlur" ppEffectAdjust [5];
"dynamicBlur" ppEffectCommit 0;
"dynamicBlur" ppEffectAdjust [0.0];
"dynamicBlur" ppEffectCommit 4;

private _date = str (date select 0) + "-" + str (date select 1) + "-" + str (date select 2);
private _hours = floor dayTime;
private _minutes = floor ((dayTime - _hours) * 60);
switch _hours do
	{
		default 		{_hours = str _hours};
		case 0:			{_hours = "00"};
		case 1:			{_hours = "01"};
		case 2:			{_hours = "02"};
		case 3:			{_hours = "03"};
		case 4:			{_hours = "04"};
		case 5:			{_hours = "05"};
		case 6:			{_hours = "06"};
		case 7:			{_hours = "07"};
		case 8:			{_hours = "08"};
		case 9:			{_hours = "09"};
	};
switch _minutes do
	{
		default 		{_minutes = str _minutes};
		case 0:			{_minutes = "00"};
		case 1:			{_minutes = "01"};
		case 2:			{_minutes = "02"};
		case 3:			{_minutes = "03"};
		case 4:			{_minutes = "04"};
		case 5:			{_minutes = "05"};
		case 6:			{_minutes = "06"};
		case 7:			{_minutes = "07"};
		case 8:			{_minutes = "08"};
		case 9:			{_minutes = "09"};
	};
private _time = " " + _hours + ":" + _minutes;

sleep 1;

0 =
	[
		[
			[toUpper (OPEX_friendly_camp),"align = 'left' size = '1.2' font='PuristaBold'"],
			["","<br/>"],
			[format [localize "STR_mainBaseDescription", OPEX_friendly_army],"align = 'left' size = '0.75' font='PuristaMedium'"],
			["","<br/>"],
			[localize OPEX_mapCountry,"align = 'left' size = '0.75' font='PuristaMedium'"], [", ","align = 'left' size = '0.75' font='PuristaMedium'"], [localize OPEX_mapLocality,"align = 'left' size = '0.75' font='PuristaMedium'"],
			["","<br/>"],
			[_date,"align = 'left' size = '0.75' font='PuristaMedium'"], [_time,"align = 'left' size = '0.75' font='PuristaMedium'"]
			//[localize "STR_welcome","align = 'left' size = '0.7'"], [", ","align = 'left' size = '0.7'"], [name player,"align = 'left' size = '0.7'"], [" !","align = 'left' size = '0.7'"]
		],
		-0.40, // pos X
		1.15 // pos Y
	] spawn BIS_fnc_typeText2;

// RESETTING SOUNDS
12 fadeMusic 0;
10 fadeSound 1.0;
sleep 13;
playMusic "";
enableRadio true;
sleep 5;
0 fadeMusic 0.5;
player allowDamage true;
OPEX_introFinished = true;
sleep 5;
call Gemini_fnc_sitrep;
sleep 10;
hint localize "STR_hint_FAQ";
if ("BETA" in OPEX_version) then
	{
		private _betaLogo = "pictures\OPEX_beta.paa";
		[
		    '<img align=''left'' size=''3.0'' shadow=''0'' image='+(str(_betaLogo))+' />',
		    safezoneX + safezoneW - 0.200,
		    safezoneY + safezoneH - 0.200,
		    99999,
		    0,
		    0
		] spawn bis_fnc_dynamicText;
	};