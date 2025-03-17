/*
CORE FUNCTIONS FOR TPW MODS
Author: tpw
Date: 20190703
Version: 1.73
Requires: CBA A3
Compatibility: N/A

Disclaimer: Feel free to use and modify this code, on the proviso that you post back changes and improvements so that everyone can benefit from them, and acknowledge the original author (tpw) in any derivative works.

To use:
1 - Save this script into your mission directory as eg tpw_core.sqf
2 - Call it with 0 = [["C_MAN","C_MAN","CUP_C","CAF_AG","CAF_AG","C_MAN"],["str1","str2",etc],5,23] execvm "tpw_core.sqf"; // where  ["C_MAN","C_MAN","CUP_C","CAF_AG","CAF_AG","C_MAN"] = civilian classname strings for Mediterranean, Oceanian, European, Mideastern, African, Asian maps respectively, ["str1","str2",etc] civs containing these strings in their classnames will be excluded, 5 = reduced civilian ambience will be spawned before this time (-1 to disable), 23 = reduced civilian ambience will be spawned after this time (-1 to disable).

TPW MODS WILL NOT FUNCTION WITHOUT THIS SCRIPT RUNNING
*/
if (isDedicated) exitWith {};
if (count _this < 4) exitwith {player sidechat "TPW CORE incorrect/no config, exiting."};

// VARS
tpw_core_mapstrings = _this select 0; // Strings to select per map civilians
tpw_core_blacklist = _this select 1; // Civilians to exclude
tpw_core_morning = _this select 2; // Reduced ambience before this time. Set to -1 to disable
tpw_core_night = _this select 3; // Reduced ambience after this time. Set to 25 to disable
tpw_core_active = true;
tpw_mods_version = "20190704"; // will appear on start hint

// MAP SPECIFIC MOD DISABLING
//Maps without roads - no cars
if (worldname in  ["pja307","pja319"]) then
	{
	tpw_car_active = false;
	tpw_park_active = false;
	};

// No aircraft
if (worldname in ["mak_Jungle","isladuala"]) then
	{
	tpw_air_active = false;
	};

// Winter 2035 specific
if (tolower worldname in ["stratis","altis"] && isclass (configfile/"CfgPatches"/"winter_2035")) then
	{
	tpw_winter2035 = true;
	} else
	{
	tpw_winter2035 = false;
	};

// CLOTHES
tpw_core_trouserlist = [
"U_Competitor",
"U_C_HunterBody_grn",
"U_C_Poor_1",
"U_C_Poor_2",
"U_IG_Guerilla2_2",
"U_IG_Guerilla2_3",
"U_IG_Guerilla3_1",
"U_IG_Guerilla3_2",
"U_NikosBody",
"U_Marshal",
"U_C_Journalist",
"U_Rangemaster",
"U_C_Mechanic_01_F",
// Tanoa
"u_c_man_casual_1_f",
"u_c_man_casual_2_f",
"u_c_man_casual_3_f",
"u_i_c_soldier_bandit_2_f",
"u_i_c_soldier_bandit_3_f",
"U_B_GEN_Commander_F",
//IDAP
"U_C_IDAP_Man_cargo_F",
"U_C_IDAP_Man_casual_F",
"U_C_IDAP_Man_Jeans_F",
"U_C_IDAP_Man_Tee_F",
// Livonia
"U_I_L_Uniform_01_camo_F",
"U_I_L_Uniform_01_deserter_F",
"U_I_L_Uniform_01_tshirt_black_F",
"U_I_L_Uniform_01_tshirt_olive_F",
"U_I_L_Uniform_01_tshirt_skull_F",
"U_I_L_Uniform_01_tshirt_sport_F",
"U_C_Uniform_Scientist_01_F",
"U_C_Uniform_Scientist_01_formal_F",
"U_C_Uniform_Scientist_02_formal_F",
"U_C_Uniform_Farmer_01_F",
"U_C_E_LooterJacket_01_F",
"U_O_R_Gorka_01_black_F",
// Weferlingen
"gm_gc_civ_uniform_man_01_80_base",
"gm_gc_civ_uniform_man_01_80_blk",
"gm_gc_civ_uniform_man_01_80_blu",
"gm_gc_civ_uniform_man_02_80_base",
"gm_gc_civ_uniform_man_02_80_brn"
];

tpw_core_shortlist = [
"U_C_Poloshirt_blue",
"U_C_Poloshirt_burgundy",
"U_C_Poloshirt_redwhite",
"U_C_Poloshirt_salmon",
"U_C_Poloshirt_stripped",
"U_C_Poloshirt_tricolour",
// Tanoa
"u_c_man_casual_4_f",
"u_c_man_casual_5_f",
"u_c_man_casual_6_f",
"u_i_c_soldier_bandit_1_f",
"u_i_c_soldier_bandit_4_f",
"u_i_c_soldier_bandit_5_f",
// IDAP
"U_C_IDAP_Man_shorts_F",
"U_C_IDAP_Man_TeeShorts_F",
// Livonia
"U_C_Uniform_Scientist_02_F"
];

// SCAN AVAILABLE CLOTHES
tpw_core_trousers = [];
tpw_core_shorts = [];
	{
	if (isclass (configfile/"CfgWeapons"/_x)) then
		{
		tpw_core_trousers pushback _x;
		};
	} foreach tpw_core_trouserlist;

	{
	if (isclass (configfile/"CfgWeapons"/_x)) then
		{
		tpw_core_shorts pushback _x;
		};
	} foreach tpw_core_shortlist;

// ADD DADPAT CLOTHING IF AVAILABLE
private ["_cfg","_str"];
_cfg = (configFile >> "CfgWeapons");
_str = _this select 0;
for "_i" from 0 to ((count _cfg) -1) do
	{
	if (isClass ((_cfg select _i) ) ) then
		{
		_cfgName = configName (_cfg select _i);
		if (["dadpat",str _cfgname] call BIS_fnc_inString && !(["tactical",str _cfgname] call BIS_fnc_inString) && !(["shorts",str _cfgname] call BIS_fnc_inString)) then
			{
			tpw_core_trousers set [count tpw_core_trousers,_cfgname];
			};
		if (["dadpat",str _cfgname] call BIS_fnc_inString && !(["tactical",str _cfgname] call BIS_fnc_inString) && (["shorts",str _cfgname] call BIS_fnc_inString)) then
			{
			tpw_core_shorts set [count tpw_core_shorts,_cfgname];
			};
		};
	};

// ADD ADL CLOTHING IF AVAILABLE
private ["_cfg","_str"];
_cfg = (configFile >> "CfgWeapons");
_str = _this select 0;
for "_i" from 0 to ((count _cfg) -1) do
	{
	if (isClass ((_cfg select _i)) ) then
		{
		_cfgName = configName (_cfg select _i);
		if (["adl_supreme",str _cfgname] call BIS_fnc_inString &&{random 1  < 0.05}) then
			{
			tpw_core_trousers set [count tpw_core_trousers,_cfgname];
			};
		};
	};

// ADD ARG CLOTHING IF AVAILABLE
private ["_cfg","_str"];
_cfg = (configFile >> "CfgWeapons");
_str = _this select 0;
for "_i" from 0 to ((count _cfg) -1) do
	{
	if (isClass ((_cfg select _i)) ) then
		{
		_cfgName = configName (_cfg select _i);
		if (["arg_shirt",str _cfgname] call BIS_fnc_inString &&{random 1  < 2}) then
			{
			tpw_core_trousers set [count tpw_core_trousers,_cfgname];
			};
		};
	};

tpw_core_fnc_clothes =
	{
	private ["_clothes"];

	// Appropriate clothing for climate
	if (!isnil "tpw_fog_temp" &&  {tpw_fog_temp > 25 } && {!(tolower worldname in tpw_core_mideast)}) then
		{
		_clothes = tpw_core_trousers + tpw_core_shorts + tpw_core_shorts;
		} else
		{
		_clothes = tpw_core_trousers;
		};
	_clothes
	};

// GRAB CIVS FROM CONFIG
tpw_core_fnc_grabciv =
	{
	private ["_cfg","_str"];
	tpw_core_civs = [];
	_cfg = (configFile >> "CfgVehicles");
	_str = _this select 0;
	for "_i" from 0 to ((count _cfg) -1) do
		{
		if (isClass ((_cfg select _i) ) ) then
			{
			_cfgName = configName (_cfg select _i);
			if ( (_cfgName isKindOf "camanbase") && {getNumber ((_cfg select _i) >> "scope") == 2} && {[_str,str _cfgname] call BIS_fnc_inString}) then
				{
				tpw_core_civs set [count tpw_core_civs,_cfgname];
				};
			};
		};

	// Use default BIS civs if custom string can't be found
	if (count tpw_core_civs < 2)then
		{
		_str = "c_man";
		for "_i" from 0 to ((count _cfg) -1) do
			{
			if (isClass ((_cfg select _i) ) ) then
				{
				_cfgName = configName (_cfg select _i);
				if ( (_cfgName isKindOf "camanbase") && {getNumber ((_cfg select _i) >> "scope") == 2} && {[_str,str _cfgname] call BIS_fnc_inString}) then
					{
					tpw_core_civs set [count tpw_core_civs,_cfgname];
					};
				};
			};
		};
	_str
	};

// GRAB FEMALE CIVS FROM CONFIG
tpw_core_fnc_grabfemciv =
	{
	private ["_cfg","_str"];
	_cfg = (configFile >> "CfgVehicles");
	_str = "Max_woman";
	for "_i" from 0 to ((count _cfg) -1) do
		{
		if (isClass ((_cfg select _i) ) ) then
			{
			_cfgName = configName (_cfg select _i);
			if ( (_cfgName isKindOf "camanbase") && {getNumber ((_cfg select _i) >> "scope") == 2} && {[_str,str _cfgname] call BIS_fnc_inString} && {!(["soldier",str _cfgname] call BIS_fnc_inString)}) then
				{
				tpw_core_civs set [count tpw_core_civs,_cfgname];
				tpw_core_civs set [count tpw_core_civs,_cfgname];
				};
			};
		};
	};

// GRAB IDAP CIVS FROM CONFIG
tpw_core_fnc_grabidapciv =
	{
	private ["_cfg","_str"];
	_cfg = (configFile >> "CfgVehicles");
	_str = "IDAP";
	for "_i" from 0 to ((count _cfg) -1) do
		{
		if (isClass ((_cfg select _i) ) ) then
			{
			_cfgName = configName (_cfg select _i);
			if ( (_cfgName isKindOf "camanbase") && {getNumber ((_cfg select _i) >> "scope") == 2} && {[_str,str _cfgname] call BIS_fnc_inString} && {!(["soldier",str _cfgname] call BIS_fnc_inString)}) then
				{
				tpw_core_civs set [count tpw_core_civs,_cfgname];
				};
			};
		};
	};

// REGION SPECIFIC CIVILIANS
tpw_core_fnc_civs =
	{
	private ["_civstring","_mideast","_african","_asian","_ethnicity","_ext"];
	private _civstrings = _this select 0;

	tpw_core_european = [
		"bush_island_51",
		"carraigdubh",
		"chernarus",
		"chernarus_summer",
		"chernarusredux",
		"fdf_isle1_a",
		"mbg_celle2",
		"woodland_acr",
		"bootcamp_acr",
		"thirsk",
		"thirskw",
		"utes",
		"gsep_mosch",
		"gsep_zernovo",
		"bornholm",
		"anim_helvantis_v2",
		"wgl_palms",
		"colleville",
		"staszow",
		"baranow",
		"panovo",
		"ivachev",
		"xcam_taunus",
		"abramia",
		"napfwinter",
		"beketov",
		"chernarus_winter",
		"utes_winter",
		"thirskw",
		"arctic",
		"hellanmaa",
		"blud_vidda",
		"ruha",
		"sennoe",
		"chernarus_2035",
		"kapaulio",
		"vis",
		"atmt_trava",
		"wl_rosche",
		"tem_summa",
		"gm_weferlingen_summer",
		"gm_weferlingen_winter",
		"enoch"
		];

	tpw_core_greek = [
		"stratis",
		"altis",
		"imrali",
		"pja314",
		"malden",
		"bozcaada",
		"tembelan",
		"porquerolles",
		"hebontes",
		"pianosa_aut",
		"montellav3"
		];

	tpw_core_mideast = [
		"mcn_aliabad",
		"mcn_hazarkot",
		"bmfayshkhabur",
		"clafghan",
		"fallujah",
		"fata",
		"hellskitchen",
		"hellskitchens",
		"mcn_hazarkot",
		"praa_av",
		"reshmaan",
		"shapur_baf",
		"takistan",
		"torabora",
		"tup_qom",
		"zargabad",
		"pja307",
		"pja306",
		"pja308",
		"pja310",
		"mountains_acr",
		"tunba",
		"kunduz",
		"mog",
		"waziristan",
		"dya",
		"lythium",
		"pja319",
		"huntersvalley",
		"farkhar",
		"altiplano",
		"mog",
		"tem_anizay"
		];

	tpw_core_african = [
		"mak_jungle",
		"pja305",
		"tropica",
		"tigeria",
		"tigeria_se",
		"sara",
		"saralite",
		"sara_dbe1",
		"porto",
		"intro",
		"kidal",
		"isladuala3",
		"bsoc_brasil",
		"lingor3",
		"dingor",
		"seanglola",
		"sfp_wamako",
		"tem_kujari"
		];

	tpw_core_asian = [
		"pja312",
		"prei_khmaoch_luong",
		 "us101_cao_bang",
		 "dakrong",
		 "uns_dong_ha",
		 "rungsat",
		 "csj_sea",
		 "csj_lowlands",
		 "phu_bai",
		 "uns_ptv",
		 "rockwall"
		];

	tpw_core_oceania = [
		"tanoa",
		"pulau",
		"126map"
	];

	// Ethnicity based on worldname
	_ethnicity = "default"; // Default
	if (tolower worldname in tpw_core_european) then {_ethnicity = "european"};
	if (tolower worldname in tpw_core_greek) then {_ethnicity = "greek"};
	if (tolower worldname in tpw_core_mideast) then {_ethnicity = "mideast"};
	if (tolower worldname in tpw_core_african) then {_ethnicity = "african"};
	if (tolower worldname in tpw_core_asian) then {_ethnicity = "asian"};
	if (tolower worldname in tpw_core_oceania) then {_ethnicity = "oceania"};

	// Greeks (eg Altis/Stratis)
	if (_ethnicity == "greek") then
		{
		_civstring = [_civstrings select 0] call tpw_core_fnc_grabciv;

		// Screen out non-Greeks from BIS civs
		if (_civstring == "c_man") then
			{
			for "_i" from 0 to (count tpw_core_civs - 1) do
				{
				_civ = tpw_core_civs select _i;
				if ((["unarmed",str _civ] call BIS_fnc_inString)  || (["euro",str _civ] call BIS_fnc_inString) || (["asia",str _civ] call BIS_fnc_inString)||(["afro",str _civ] call BIS_fnc_inString)||(["tanoa",str _civ] call BIS_fnc_inString)) then
					{
					tpw_core_civs set [_i, -1];
					};
				};
			tpw_core_civs = tpw_core_civs - [-1];
			};
		// Females, IDAP
		[] call tpw_core_fnc_grabfemciv;
		[] call	tpw_core_fnc_grabidapciv;
		};

	// Oceania (eg Tanoa)
	if (_ethnicity == "oceania") then
		{
		_civstring = [_civstrings select 1] call tpw_core_fnc_grabciv;

		// Screen out non-Tanoans from BIS civs
		if (_civstring == "c_man") then
			{
			for "_i" from 0 to (count tpw_core_civs - 1) do
				{
				_civ = tpw_core_civs select _i;
				if !(["tanoa",str _civ] call BIS_fnc_inString) then
					{
					tpw_core_civs set [_i, -1];
					};
				};
			tpw_core_civs = tpw_core_civs - [-1];
			};
		// IDAP
		[] call	tpw_core_fnc_grabidapciv;
		};

	// Europeans (eg Chernarus)
	if (_ethnicity == "european") then
		{
		_civstring = [_civstrings select 2] call tpw_core_fnc_grabciv;

		// Screen out non-Europeans from BIS civs
		if (_civstring == "c_man") then
			{
			for "_i" from 0 to (count tpw_core_civs - 1) do
				{
				_civ = tpw_core_civs select _i;
				if !(["euro",str _civ] call BIS_fnc_inString) then
					{
					tpw_core_civs set [_i, -1];
					};
				};
			tpw_core_civs = tpw_core_civs - [-1];
			};

		// Females, IDAP
		[] call tpw_core_fnc_grabfemciv;
		[] call	tpw_core_fnc_grabidapciv;
		};

	// Mid East (eg Takistan)
	if (_ethnicity == "mideast") then
		{
		_civstring = [_civstrings select 3] call tpw_core_fnc_grabciv;

		// Use Persian soldiers as civs
		if (_civstring == "c_man") then
			{
			tpw_core_civs = ["o_soldier_f"];
			};
		};

	// Africans (eg N'Ziwasogo)
	if (_ethnicity == "african") then
		{
		_civstring = [_civstrings select 4] call tpw_core_fnc_grabciv;

		// Screen out non-Africans from BIS civs
		if (_civstring == "c_man") then
			{
			for "_i" from 0 to (count tpw_core_civs - 1) do
				{
				_civ = tpw_core_civs select _i;
				if !(["afro",str _civ] call BIS_fnc_inString) then
					{
					tpw_core_civs set [_i, -1];
					};
				};
			tpw_core_civs = tpw_core_civs - [-1];
			};
		};

	// Asians (eg Prei Khmaoch Luong)
	if (_ethnicity == "asian") then
		{
		_civstring = [_civstrings select 5] call tpw_core_fnc_grabciv;

		// Screen out non-Asians from BIS civs
		if (_civstring == "c_man") then
			{
			for "_i" from 0 to (count tpw_core_civs - 1) do
				{
				_civ = tpw_core_civs select _i;
				if !(["asia",str _civ] call BIS_fnc_inString) then
					{
					tpw_core_civs set [_i, -1];
					};
				};
			tpw_core_civs = tpw_core_civs - [-1];
			};
		};

	// Default - ethnic mix
	if (_ethnicity == "default") then
		{
		_civstring = "c_man";
		_civstring = [_civstring] call tpw_core_fnc_grabciv;

		// Screen out unarmed combatants only
		if (_civstring == "c_man") then
			{
			for "_i" from 0 to (count tpw_core_civs - 1) do
				{
				_civ = tpw_core_civs select _i;
				if (["unarmed",str _civ] call BIS_fnc_inString) then
					{
					tpw_core_civs set [_i, -1];
					};
				};
			tpw_core_civs = tpw_core_civs - [-1];
			};
		// Females, IDAP
		[] call tpw_core_fnc_grabfemciv;
		[] call	tpw_core_fnc_grabidapciv;
		};

	// No pilot, diver, VR civs
	for "_i" from 0 to (count tpw_core_civs - 1) do
		{
		_unit = tpw_core_civs select _i;
		if ((["pilot",str _unit] call BIS_fnc_inString)||(["diver",str _unit] call BIS_fnc_inString)||(["vr",str _unit] call BIS_fnc_inString)) then
			{
			tpw_core_civs set [_i, -1];
			};
		};

	// User blacklist
	for "_i" from 0 to (count tpw_core_civs - 1) do
		{
		_unit = tpw_core_civs select _i;
			{
			if ([_x,str _unit] call BIS_fnc_inString) then
				{
				tpw_core_civs set [_i, -1];
				};
			} foreach tpw_core_blacklist;
		};
	tpw_core_civs = tpw_core_civs - [-1];


	// Prespawn to reduce stuttering later
		{
		_temp = _x createvehicle [0,0,1000];
		sleep 0.1;
		deletevehicle _temp;
		} count tpw_core_civs;

	tpw_core_ethnicity = _ethnicity;
	};

// HABITABLE HOUSES

// Core and DLC buildings
tpw_core_habitable = [
// Altis/Stratis
"Land_i_House_Small_01_V1_F",
"Land_i_House_Small_01_V2_F",
"Land_i_House_Small_01_V3_F",
"Land_i_House_Small_02_V1_F",
"Land_i_House_Small_02_V2_F",
"Land_i_House_Small_02_V3_F",
"Land_i_House_Small_03_V1_F",
"Land_i_House_Big_01_V1_F",
"Land_i_House_Big_01_V2_F",
"Land_i_House_Big_01_V3_F",
"Land_i_House_Big_02_V1_F",
"Land_i_House_Big_02_V2_F",
"Land_i_House_Big_02_V3_F",
"Land_i_Shop_01_V1_F",
"Land_i_Shop_01_V2_F",
"Land_i_Shop_01_V3_F",
"Land_i_Shop_02_V1_F",
"Land_i_Shop_02_V2_F",
"Land_i_Shop_02_V3_F",
"Land_i_Addon_01_V1_F",
"Land_i_Addon_01_V2_F",
"Land_i_Addon_01_V3_F",
"Land_i_Addon_02_V1_F",
"Land_i_Addon_02_V2_F",
"Land_i_Addon_02_V3_F",
"Land_i_Addon_03_V1_F",
"Land_i_Addon_03_V2_F",
"Land_i_Addon_03_V3_F",

// Tanoa
"Land_house_small_01_F",
"Land_house_small_02_F",
"Land_house_small_03_F",
"Land_house_small_04_F",
"Land_house_small_05_F",
"Land_house_small_06_F",
"Land_house_big_01_F",
"Land_house_big_02_F",
"Land_house_big_03_F",
"Land_house_big_04_F",
"Land_house_big_05_F",
"Land_slum_01_F",
"Land_slum_02_F",
"Land_slum_03_F",
"Land_slum_04_F",
"Land_slum_05_F",
"Land_slum_house_01_F",
"Land_slum_house_02_F",
"Land_slum_house_03_F",
"Land_slum_house_04_F",
"Land_slum_house_05_F",
"Land_house_native_01_F",
"Land_house_native_02_F",
"Land_hotel_01_F",
"Land_hotel_02_F",
"Land_shop_city_01_F",
"Land_shop_city_02_F",
"Land_shop_city_03_F",
"Land_shop_city_04_F",
"Land_shop_city_05_F",
"Land_shop_city_06_F",
"Land_shop_city_07_F",
"Land_shop_town_01_F",
"Land_shop_town_02_F",
"Land_shop_town_03_F",
"Land_shop_town_04_F",
"Land_shop_town_05_F",
"Land_Warehouse_01_F",
"Land_Warehouse_02_F",
"Land_Warehouse_03_F",
"Land_Temple_Native_01_F",
"Land_Temple_Native_02_F",
"Land_GarageShelter_01_F",
"Land_School_01_F",
"Land_FuelStation_02_workshop_F",
"Land_FuelStation_01_shop_F",
"Land_Multistoreybuilding_01_F",
"Land_Multistoreybuilding_03_F",
"Land_Multistoreybuilding_04_F",

// Malden
"Land_i_House_Small_01_b_blue_F",
"Land_i_House_Small_01_b_pink_F",
"Land_i_House_Small_01_b_yellow_F",
"Land_i_House_Small_01_b_brown_F",
"Land_i_House_Small_01_b_white_F",
"Land_i_House_Small_01_b_whiteblue_F",
"Land_i_House_Small_02_b_blue_F",
"Land_i_House_Small_02_b_pink_F",
"Land_i_House_Small_02_b_yellow_F",
"Land_i_House_Small_02_b_brown_F",
"Land_i_House_Small_02_b_white_F",
"Land_i_House_Small_02_b_whiteblue_F",
"Land_i_House_Small_02_c_blue_F",
"Land_i_House_Small_02_c_pink_F",
"Land_i_House_Small_02_c_yellow_F",
"Land_i_House_Small_02_c_brown_F",
"Land_i_House_Small_02_c_white_F",
"Land_i_House_Small_02_c_whiteblue_F",
"Land_i_House_Big_01_b_blue_F",
"Land_i_House_Big_01_b_pink_F",
"Land_i_House_Big_01_b_yellow_F",
"Land_i_House_Big_01_b_brown_F",
"Land_i_House_Big_01_b_white_F",
"Land_i_House_Big_01_b_whiteblue_F",
"Land_i_House_Big_02_b_blue_F",
"Land_i_House_Big_02_b_pink_F",
"Land_i_House_Big_02_b_yellow_F",
"Land_i_House_Big_02_b_brown_F",
"Land_i_House_Big_02_b_white_F",
"Land_i_House_Big_02_b_whiteblue_F",
"Land_i_Shop_01_b_blue_F",
"Land_i_Shop_01_b_pink_F",
"Land_i_Shop_01_b_yellow_F",
"Land_i_Shop_01_b_brown_F",
"Land_i_Shop_01_b_white_F",
"Land_i_Shop_01_b_whiteblue_F",
"Land_i_Shop_02_b_blue_F",
"Land_i_Shop_02_b_pink_F",
"Land_i_Shop_02_b_yellow_F",
"Land_i_Shop_02_b_brown_F",
"Land_i_Shop_02_b_white_F",
"Land_i_Shop_02_b_whiteblue_F",

// Weferlingen
"land_gm_euro_barracks_01",
"land_gm_euro_barracks_02",
"land_gm_euro_factory_01_01",
"land_gm_euro_factory_01_02",
"land_gm_euro_factory_02",
"land_gm_euro_house_01_e",
"land_gm_euro_house_01_w",
"land_gm_euro_house_01_d",
"land_gm_euro_house_02_e",
"land_gm_euro_house_02_w",
"land_gm_euro_house_02_d",
"land_gm_euro_house_03_e",
"land_gm_euro_house_03_w",
"land_gm_euro_house_04_e",
"land_gm_euro_house_04_w",
"land_gm_euro_house_04_d",
"land_gm_euro_house_05_e",
"land_gm_euro_house_05_w",
"land_gm_euro_house_05_d",
"land_gm_euro_house_06_e",
"land_gm_euro_house_06_w",
"land_gm_euro_house_06_d",
"land_gm_euro_house_07_e",
"land_gm_euro_house_07_w",
"land_gm_euro_house_07_d",
"land_gm_euro_house_08_e",
"land_gm_euro_house_08_w",
"land_gm_euro_house_08_d",
"land_gm_euro_house_09_e",
"land_gm_euro_house_09_w",
"land_gm_euro_house_09_d",
"land_gm_euro_house_10_e",
"land_gm_euro_house_10_w",
"land_gm_euro_house_10_d",
"land_gm_euro_house_11_e",
"land_gm_euro_house_11_w",
"land_gm_euro_house_11_d",
"land_gm_euro_house_12_e",
"land_gm_euro_house_12_w",
"land_gm_euro_house_12_d",
"land_gm_euro_house_13_e",
"land_gm_euro_house_13_w",
"land_gm_euro_house_13_d",
"land_gm_euro_office_01",
"land_gm_euro_office_02",
"land_gm_euro_office_03",
"land_gm_euro_pub_01",
"land_gm_euro_pub_02",
"land_gm_euro_fuelstation_01_w",
"land_gm_euro_fuelstation_02",
"land_gm_euro_shed_01",
"land_gm_euro_shed_02",
"land_gm_euro_shed_03",
"land_gm_euro_shed_04",
"land_gm_euro_shed_05",
"land_gm_euro_shop_01_w",
"land_gm_euro_shop_02_e",
"land_gm_euro_shop_02_w",
"land_gm_euro_church_01",
"land_gm_euro_church_02",
"land_gm_euro_farmhouse_01",
"land_gm_euro_farmhouse_02",
"land_gm_euro_farmhouse_03",
"land_gm_euro_barracks_01_win",
"land_gm_euro_barracks_02_win",
"land_gm_euro_factory_01_01_win",
"land_gm_euro_factory_01_02_win",
"land_gm_euro_factory_02_win",
"land_gm_euro_house_01_e_win",
"land_gm_euro_house_01_w_win",
"land_gm_euro_house_01_d_win",
"land_gm_euro_house_02_e_win",
"land_gm_euro_house_02_w_win",
"land_gm_euro_house_02_d_win",
"land_gm_euro_house_03_e_win",
"land_gm_euro_house_03_w_win",
"land_gm_euro_house_04_e_win",
"land_gm_euro_house_04_w_win",
"land_gm_euro_house_04_d_win",
"land_gm_euro_house_05_e_win",
"land_gm_euro_house_05_w_win",
"land_gm_euro_house_05_d_win",
"land_gm_euro_house_06_e_win",
"land_gm_euro_house_06_w_win",
"land_gm_euro_house_06_d_win",
"land_gm_euro_house_07_e_win",
"land_gm_euro_house_07_w_win",
"land_gm_euro_house_07_d_win",
"land_gm_euro_house_08_e_win",
"land_gm_euro_house_08_w_win",
"land_gm_euro_house_08_d_win",
"land_gm_euro_house_09_e_win",
"land_gm_euro_house_09_w_win",
"land_gm_euro_house_09_d_win",
"land_gm_euro_house_10_e_win",
"land_gm_euro_house_10_w_win",
"land_gm_euro_house_10_d_win",
"land_gm_euro_house_11_e_win",
"land_gm_euro_house_11_w_win",
"land_gm_euro_house_11_d_win",
"land_gm_euro_house_12_e_win",
"land_gm_euro_house_12_w_win",
"land_gm_euro_house_12_d_win",
"land_gm_euro_house_13_e_win",
"land_gm_euro_house_13_w_win",
"land_gm_euro_house_13_d_win",
"land_gm_euro_office_01_win",
"land_gm_euro_office_02_win",
"land_gm_euro_office_03_win",
"land_gm_euro_pub_01_win",
"land_gm_euro_pub_02_win",
"land_gm_euro_fuelstation_01_w_win",
"land_gm_euro_fuelstation_02_win",
"land_gm_euro_shed_01_win",
"land_gm_euro_shed_02_win",
"land_gm_euro_shed_03_win",
"land_gm_euro_shed_05_win",
"land_gm_euro_shed_04_win",
"land_gm_euro_shop_01_w_win",
"land_gm_euro_shop_02_e_win",
"land_gm_euro_shop_02_w_win",
"land_gm_euro_church_01_win",
"land_gm_euro_church_02_win",
"land_gm_euro_mine_01_win",
"land_gm_euro_farmhouse_01_win",
"land_gm_euro_farmhouse_02_win",
"land_gm_euro_farmhouse_03_win",
"land_gm_euro_misc_kiosk_01_win",
"land_gm_euro_misc_garage_01_01_win",
"land_gm_euro_misc_garage_01_02_win",
"land_gm_euro_misc_garage_02_win",

// Livonia
"Land_House_1B01_F",
"Land_House_1W01_F",
"Land_House_1W02_F",
"Land_House_1W03_F",
"Land_House_1W04_F",
"Land_House_1W05_F",
"Land_House_1W06_F",
"Land_House_1W07_F",
"Land_House_1W08_F",
"Land_House_1W09_F",
"Land_House_1W10_F",
"Land_House_1W11_F",
"Land_House_1W12_F",
"Land_House_2B01_F",
"Land_House_2B02_F",
"Land_House_2B03_F",
"Land_House_2B04_F",
"Land_House_2W01_F",
"Land_House_2W02_F",
"Land_House_2W03_F",
"Land_House_2W04_F",
"Land_House_2W05_F",
"Land_workshop_01_f",
"Land_workshop_02_f",
"Land_workshop_03_f",
"Land_barn_01_f",
"Land_barn_02_f",
"Land_barn_03_f",
"Land_barn_01_large_f",
"Land_barn_02_large_f",
"Land_barn_03_large_f",
"Land_Camp_House_01_brown_F",
"Land_VillageStore_01_f",
"Land_policestation_01_f",
"Land_caravan_01_rust_f",

// OA classes - thanks Spliffz
"Land_House_L_1_EP1",
"Land_House_L_3_EP1",
"Land_House_L_4_EP1",
"Land_House_L_6_EP1",
"Land_House_L_7_EP1",
"Land_House_L_8_EP1",
"Land_House_L_9_EP1",
"Land_House_K_1_EP1",
"Land_House_K_3_EP1",
"Land_House_K_5_EP1",
"Land_House_K_6_EP1",
"Land_House_K_7_EP1",
"Land_House_K_8_EP1",
"Land_Terrace_K_1_EP1",
"Land_House_C_1_EP1",
"Land_House_C_1_v2_EP1",
"Land_House_C_2_EP1",
"Land_House_C_3_EP1",
"Land_House_C_4_EP1",
"Land_House_C_5_EP1",
"Land_House_C_5_V1_EP1",
"Land_House_C_5_V2_EP1",
"Land_House_C_5_V3_EP1",
"Land_House_C_9_EP1",
"Land_House_C_10_EP1",
"Land_House_C_11_EP1",
"Land_House_C_12_EP1",
"Land_A_Villa_EP1",
"Land_A_Mosque_small_1_EP1",
"Land_A_Mosque_small_2_EP1",

//"Land_Ind_FuelStation_Feed_EP1",
"Land_Ind_FuelStation_Build_EP1",
"Land_Ind_FuelStation_Shed_EP1",
"Land_Ind_Garage01_EP1",
"Land_A_Mosque_big_minaret_1_EP1",
"Land_A_Mosque_big_hq_EP1",

// A2 classes - thanks Reserve
"Land_HouseV_1I1",
"Land_HouseV_1I2",
"Land_HouseV_1I3",
"Land_HouseV_1I4",
"Land_HouseV_1L1",
"Land_HouseV_1L2",
"Land_HouseV_1T",
"Land_HouseV_2I",
"Land_HouseV_2L",
"Land_HouseV_2T1",
"Land_HouseV_2T2",
"Land_HouseV_3I1",
"Land_HouseV_3I2",
"Land_HouseV_3I3",
"Land_HouseV_3I4",
"Land_HouseV2_01A",
"Land_HouseV2_01B",
"Land_HouseV2_02",
"Land_HouseV2_03",
"Land_HouseV2_03B",
"Land_HouseV2_04",
"Land_HouseV2_05",
"Land_HouseBlock_A1",
"Land_HouseBlock_A2",
"Land_HouseBlock_A3",
"Land_HouseBlock_B1",
"Land_HouseBlock_B2",
"Land_HouseBlock_B3",
"Land_HouseBlock_C2",
"Land_HouseBlock_C3",
"Land_HouseBlock_C4",
"Land_HouseBlock_C5",
"Land_Church_02",
"Land_Church_02A",
"Land_Church_03",
"Land_A_FuelStation_Build",
"Land_A_FuelStation_Shed",

// Fallujah
"Land_dum_istan2",
"Land_dum_istan2b",
"Land_dum_istan2_01",
"Land_dum_istan2_02",
"Land_dum_istan2_03",
"Land_dum_istan2_03a",
"Land_dum_istan2_04a",
"Land_dum_istan3",
"Land_dum_istan3_hromada",
"Land_dum_istan4",
"Land_dum_istan4_big",
"Land_dum_istan4_big_inverse",
"Land_dum_istan4_detaily1",
"Land_dum_istan4_inverse",
"Land_dum_mesto3_istan",
"Land_hotel",
"Land_stanek_1",
"Land_stanek_1b",
"Land_stanek_1c",
"Land_stanek_2",
"Land_stanek_2b",
"Land_stanek_2c",
"Land_stanek_3",
"Land_stanek_3b",
"Land_stanek_3c",

// JBAD buildings
"Land_jbad_house1",
"Land_jbad_house3",
"Land_jbad_house5",
"Land_jbad_house6",
"Land_jbad_house7",
"Land_jbad_house8",
"Land_jbad_house1",
"Land_jbad_House_c_1_v2",
"Land_jbad_House_c_2",
"Land_jbad_House_c_3",
"Land_jbad_House_c_4",
"Land_jbad_House_c_5",
"Land_jbad_House_c_9",
"Land_jbad_House_c_10",
"Land_jbad_House_c_11",
"Land_jbad_House_c_12",
"Land_Jbad_Ind_FuelStation_Build",
"Land_jbad_A_GeneralStore_01",
"Land_jbad_A_GeneralStore_01a",
"Land_Jbad_A_Mosque_small_1",
"Land_Jbad_A_Mosque_small_2",
"Land_Jbad_A_Stationhouse",
"Land_Jbad_A_Villa",
"Land_Jbad_Ind_Garage01",
"Land_jbad_House_1_old",
"Land_jbad_House_3_old",
"Land_jbad_House_4_old",
"Land_jbad_House_6_old",
"Land_jbad_House_7_old",
"Land_jbad_House_8_old",
"Land_jbad_House_9_old",

// Lythium
"land_ffaa_casa_urbana_1",
"land_ffaa_casa_urbana_2",
"land_ffaa_casa_urbana_3",
"land_ffaa_casa_urbana_4",
"land_ffaa_casa_urbana_5",
"land_ffaa_casa_urbana_6",
"land_ffaa_casa_urbana_7",
"land_ffaa_casa_urbana_7A",
"land_ffaa_casa_urbana_8",
"land_ffaa_casa_af_1",
"land_ffaa_casa_af_2",
"land_ffaa_casa_af_3",
"land_ffaa_casa_af_3A",
"land_ffaa_casa_af_4",
"land_ffaa_casa_af_4A",
"land_ffaa_casa_af_5",
"land_ffaa_casa_af_6",
"land_ffaa_casa_af_7",
"land_ffaa_casa_af_8",
"land_ffaa_casa_af_9",
"land_ffaa_casa_af_10",
"land_ffaa_casa_af_10A",
"land_ffaa_casa_sha_1",
"land_ffaa_casa_sha_2",
"land_ffaa_casa_sha_3",
"land_ffaa_casa_barrancon_1",
"land_ffaa_casa_barracon_2",
"land_ffaa_casa_caseta_peq",
"land_ffaa_casa_acc_1",

// Prei Khmoach Luong
"land_blud_hut1",
"land_blud_hut2",
"land_blud_hut3",
"land_blud_hut4",
"land_blud_hut5",
"land_blud_hut6",
"land_blud_hut7",
"land_blud_hut8",

// Chernarus redux
"land_housev_1l1",
"land_housev_1l2",
"land_housev_1t",
"land_housev_2i",
"land_housev_2l",
"land_housev_2t1",
"land_housev_2t2",
"land_housev_3i1",
"land_housev_3i2",
"land_housev_3i3",
"land_housev_3i4",
"land_housev_01a",
"land_housev_01b",

// Unsung - Thanks ReznikDeznik
"LAND_uns_hut2",
"LAND_uns_hut1",
"LAND_uns_hutraised1",
"LAND_uns_hutraised2",
"LAND_uns_villstorage_shelter",
"LAND_uns_villshelter1",
"LAND_uns_villshelter2",
"LAND_CSJ_Yard5",
"LAND_CSJ_Yard3",
"LAND_CSJ_Yard2",
"LAND_CSJ_Yard1",
"LAND_CSJ_Yard4",
"csj_shelter01",
"LAND_CSJ_hut06",
"LAND_CSJ_hut05",
"LAND_CSJ_hut07",
"LAND_CSJ_hut01",
"LAND_CSJ_hut02",
"LAND_uns_hut08",
"Land_MBG_Hut_B",
"Land_MBG_Hut_C",
"Land_MBG_Hut_A",
"LAND_CSJ_village6",
"LAND_CSJ_village5",
"LAND_CSJ_village8",
"LAND_CSJ_riverhut4",
"LAND_CSJ_riverhut3",
"LAND_CSJ_village7",
"LAND_CSJ_village4",
"LAND_CSJ_village1",
"LAND_CSJ_village2",
"LAND_CSJ_village3",
"LAND_CSJ_riverhut1",
"LAND_CSJ_riverhut2",
"LAND_csj_bar",
"LAND_uns_shopOld_01",
"LAND_uns_shopOld_02",
"LAND_uns_shopOld_03",
"LAND_uns_shopOld_04",
"LAND_uns_shopOld_05",
"LAND_uns_shopOld_06",
"LAND_uns_shopOld_07",
"Land_raz_hut04",
"Land_raz_hut07",
"LAND_uns_hut12",
"Land_raz_hut06",
"Land_raz_hut05",
"Land_raz_hut02",
"Land_raz_hut01",
"land_indo_hut_2",
"land_indo_hut_1",

// Chernarus redux
"Land_ds_houseV_1L2",
"Land_ds_houseV_1t",
"Land_ds_houseV_2l",
"Land_ds_houseV_2L",
"Land_ds_houseV_2T1",
"Land_ds_houseV_2T2",
"Land_ds_houseV_3l1",
"Land_ds_houseV_3l2",
"Land_ds_houseV_3l3",
"Land_ds_houseV_3l4",

// Rosche
"Land_MBG_GER_PUB_1",
"Land_MBG_GER_PUB_2",
"Land_MBG_GER_RHUS_1",
"Land_MBG_GER_RHUS_2",
"Land_MBG_GER_RHUS_3",
"Land_MBG_GER_RHUS_4",
"Land_MBG_GER_HUS_1",
"Land_MBG_GER_HUS_2",
"Land_MBG_GER_HUS_3",
"Land_MBG_GER_HUS_4",
"Land_MBG_GER_HUS_4",
"Land_MBG_GER_ESTATE_1",
"Land_MBG_GER_ESTATE_2",
"Land_sara_domek_zluty",
"Land_sara_domek_sedy",
"Land_dum_mesto2",
"Land_dum_mesto_in",

// Mogadishu
"land_mbg_brickhouse_01",
"land_mbg_brickhouse_02",
"land_mbg_brickhouse_031",
"mbg_apartments_big_01_EO",
"mbg_apartments_big_02_EO",
"mbg_apartments_big_02b_EO",
"mbg_apartments_big_02c_EO",
"mbg_apartments_big_03_EO",
"mbg_apartments_big_03b_EO",
"mbg_apartments_big_03c_EO",
"mbg_apartments_big_04_EO",
"mbg_brickhouse_01_EO",
"mbg_brickhouse_02_EO",
"mbg_brickhouse_03_EO",
"land_mbg_slum01",
"land_mbg_slum01b",
"land_mbg_slum01c",
"land_mbg_slum01d",
"land_mbg_slum01e",
"land_mbg_slum01f",
"land_mbg_slum01g",
"land_mbg_slum01h",
"land_mbg_slum02",
"land_mbg_slum02b",
"land_mbg_slum02c",
"land_mbg_slum02d",
"land_mbg_slum02e",
"land_mbg_slum02f",
"land_mbg_slum02g",
"land_mbg_slum02h",
"land_mbg_slum03",
"land_mbg_slum03b",
"land_mbg_slum03c",
"land_mbg_slum03d",
"land_mbg_slum03e",
"land_mbg_slum03f",
"land_mbg_slum03g",
"land_mbg_slum03h",
"mbg_slum01_EO",
"mbg_slum01b_EO",
"mbg_slum01c_EO",
"mbg_slum01d_EO",
"mbg_slum01e_EO",
"mbg_slum01f_EO",
"mbg_slum01g_EO",
"mbg_slum01h_EO",
"mbg_slum02_EO",
"mbg_slum02b_EO",
"mbg_slum02c_EO",
"mbg_slum02d_EO",
"mbg_slum02e_EO",
"mbg_slum02f_EO",
"mbg_slum02g_EO",
"mbg_slum02h_EO",
"mbg_slum03_EO",
"mbg_slum03b_EO",
"mbg_slum03c_EO",
"mbg_slum03d_EO",
"mbg_slum03h_EO",

// Montella
"Land_Sara_domek04",
"Land_Brana02nodoor",
"Land_Sara_domek05",
"Land_Deutshe_mini",
"Land_Dum_mesto3",
"Land_OrlHot",
"Land_Sara_domek03",
"Land_Cihlovej_Dum_in",
"Land_Sara_domek01",
"Land_Sara_domek_rosa"];

tpw_core_fnc_houses =
	{
	private ["_housearray","_radius","_return"];
	_housearray = [];
	_radius = _this select 0;
	_return = nearestObjects [position vehicle player,tpw_core_habitable,_radius];
	_return = _return select {!(["_u_", str (typeof _x)] call BIS_fnc_inString)};
	_return
	};

tpw_core_fnc_screenhouses =
	{
	private ["_radius","_return"];
	_radius = _this select 0;
	_return = tpw_core_habhouses select {_x distance player < _radius};
	_return
	};

/*
// SUN ANGLE - ORIGINAL CODE BY CARLGUSTAFFA
tpw_core_fnc_sunangle =
	{
	private ["_lat","_day","_hour"];
	while {true} do
		{
		_lat = -1 * getNumber(configFile >> "CfgWorlds" >> worldName >> "latitude");
		_day = 360 * (dateToNumber date);
		_hour = (daytime / 24) * 360;
		tpw_core_sunangle = ((12 * cos(_day) - 78) * cos(_lat) * cos(_hour)) - (24 * sin(_lat) * cos(_day));
		sleep 33.33;
		};
	};
*/

// DETERMINE UNIT'S WEAPON TYPE
tpw_core_fnc_weptype =
	{
	private["_unit","_weptype","_cw","_hw","_pw","_sw"];
	_unit = _this select 0;

	// Weapon type
	_cw = currentweapon _unit;
	_hw = handgunweapon _unit;
	_pw = primaryweapon _unit;
	_sw = secondaryweapon _unit;
	 switch _cw do
		{
		case "":
			{
			_weptype = 0;
			};
		case _hw:
			{
			_weptype = 1;
			};
		case _pw:
			{
			_weptype = 2;
			};
		case _sw:
			{
			_weptype = 3;
			};
		default
			{
			_weptype = 0;
			};
		};
	_unit setvariable ["tpw_core_weptype",_weptype];
	};

// DISABLE UNIT ON GROUND
tpw_core_fnc_disable =
	{
	private ["_unit"];
	_unit = _this select 0;
	if !(alive _unit) exitwith {};
	_unit setunitpos "DOWN";
	_unit switchmove "acts_InjuredLyingRifle02_180";
	{_unit disableai _x} count ["anim","move","fsm","target","autotarget"];
	_unit setvariable ["tpw_core_disabled",1];
	};

// RE-ENABLE UNIT
tpw_core_fnc_enable =
	{
	private ["_unit"];
	_unit = _this select 0;
	sleep random 5;
	{_unit enableai _x} count ["anim","move","fsm","target","autotarget"];
	_unit setunitpos "UP";
	[_unit] call tpw_core_fnc_weptype;
	_unit switchmove "AinjPpneMstpSnonWnonDnon_rolltofront";
	_unit playmove (['AmovPpneMstpSnonWnonDnon_AmovPercMstpSnonWnonDnon',"AmovPercMstpSrasWpstDnon","AmovPercMstpSrasWrflDnon","AmovPercMstpSrasWlnrDnon"] select (_unit getvariable "tpw_core_weptype"));
	_unit setvariable ["tpw_core_disabled",0];
	_unit setcaptive false;
	};

// SORT ARRAY OF OBJECTS BASED ON DISTANCE TO PLAYER
tpw_core_fnc_arraysort =
	{
	private _origarray = _this select 0;
	private _distarray = _origarray apply {[_x distance player, _x]};
	_distarray sort true;
	private _sortedarray = [];
	{_sortedarray pushback (_x select 1)} foreach _distarray;
	_sortedarray
	};

tpw_core_fnc_arrayrevsort =
	{
	private _origarray = _this select 0;
	private _distarray = _origarray apply {[_x distance player, _x]};
	_distarray sort false;
	private _sortedarray = [];
	{_sortedarray pushback (_x select 1)} foreach _distarray;
	_sortedarray
	};

// SCAN WHETHER THERE IS NEARBY BATTLE (GUNFIRE/EXPLOSIONS/GRENADES)
// tpw_core_battletime is advanced by 1-2 minutes every time these events occur
tpw_core_fnc_battle =
	{
	while {true} do
		{
		if (diag_ticktime > tpw_core_battletime) then
			{
			tpw_core_battle = false;
			} else
			{
			tpw_core_battle = true;
			};
		sleep 2;
		};
	};

// NEARBY GUNFIRE
tpw_core_battle = false;
tpw_core_battletime = 0;
player addeventhandler ["firednear",{tpw_core_battletime = diag_ticktime + 60 + random 120}];
0 = [] spawn tpw_core_fnc_battle;

// CALL OR SPAWN APPROPRIATE FUNCTIONS
tpw_core_housescanflag = 0;
//0 = [] spawn tpw_core_fnc_sunangle;
[tpw_core_mapstrings] spawn tpw_core_fnc_civs;

// NEARBY HABITABLE HOUSES
tpw_core_allhouses = [50000] call tpw_core_fnc_houses;
tpw_core_habitable = [];
	{
	_type = typeof _x;
	if !(_type in tpw_core_habitable) then
		{
		tpw_core_habitable pushback _type;
		};
	} foreach tpw_core_allhouses;

tpw_core_habhouses = [];
sleep 10;
_lastpos = [0,0,0];
while {true} do
	{
	if ((speed player < 20) && {player distance _lastpos > 250}) then
		{
		//tpw_core_habhouses = [500] call tpw_core_fnc_houses;
		tpw_core_habhouses = tpw_core_allhouses select {_x distance player < 500};
		_lastpos = position player;
		};
	sleep 30 + (count tpw_core_habhouses)/2;
	};


// DUMMY LOOP SO SCRIPT DOESN'T TERMINATE
while {true} do
	{
	sleep 10;
	};