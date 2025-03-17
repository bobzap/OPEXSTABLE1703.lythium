/* 
TPW ANIMALS - Spawn ambient animals around player.
Author: tpw, LarsAspra 
Date: 20190703
Version: 1.54
Requires: CBA A3, tpw_core.sqf, tpw_sounds.pbo
Compatibility: SP, MP client

Disclaimer: Feel free to use and modify this code, on the proviso that you post back changes and improvements so that everyone can benefit from them, and acknowledge the original author (tpw) in any derivative works.     

To use: 
1 - Save this script into your mission directory as eg tpw_animals.sqf
2 - Call it with 0 = [10,15,200,75,60,10] execvm "tpw_animals.sqf"; where 10 = start delay, 15 = maximum animals near player, 200 = animals will be removed beyond this distance (m), 75 = minimum distance from player to spawn an animal (m), 60 = maximum time between dog/cat noises (sec), 10 = % of horses with saddles

THIS SCRIPT WON'T RUN ON DEDICATED SERVERS.
*/

if (isDedicated) exitWith {};
if (count _this < 6) exitwith {player sidechat "TPW ANIMALS incorrect/no config, exiting."};
if (_this select 1 == 0) exitwith {};
WaitUntil {!isNull FindDisplay 46};

// READ IN CONFIGURATION VALUES
tpw_animal_version = "1.54"; // Version string
tpw_animal_sleep = _this select 0; // delay until animals start spawning
tpw_animal_max = _this select 1; // maximum animals near player
tpw_animal_maxradius = _this select 2; // distance beyond which animals will be removed
tpw_animal_minradius = _this select 3; // minimum distance from player to spawn animals
tpw_animal_noisetime = _this select 4; // maximum time in between animal noises
tpw_animal_saddleperc = _this select 5; // % of horses spawned with saddles (if using dbo_horses)


// DEFAULT VALUES FOR MP
if (isMultiplayer) then 
	{
	tpw_animal_sleep = 9.99; 
	tpw_animal_max =15; 
	tpw_animal_maxradius = 200;
	tpw_animal_minradius = 75;
	};

// VARIABLES
tpw_animal_debug = false; // debugging
tpw_animal_array = []; // array of animals near player
tpw_animal_exclude = false; // player near exlusion object
tpw_animal_active = true; // global activate/deactivate
tpw_animal_shark = 1; // 0 = no sharks

// TIME
tpw_animal_sunrise = ([] call BIS_fnc_sunriseSunsetTime) select 0;
tpw_animal_sunset = ([] call BIS_fnc_sunriseSunsetTime) select 1;

// WOLVES ON EUROPEAN AND COLD MAPS
tpw_animal_wolves = 0;
if (tolower worldname in ["japahto",
"thirsk",
"thirskw",
"lostw",
"lost",
"abramia",
"hellanmaa",
"bush_island_51",
"carraigdubh",
"chernarus",
"chernarusredux",
"chernarus_summer",
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
"beketov",
"ryderwood",
"caribou",
"namalsk",
"napfwinter",
"chernarus_winter",
"utes_winter",
"thirskw",
"arctic",
"blud_vidda",
"ruha",
"sennoe",
"chernarus2035",
"wl_rosche",
"gm_weferlingen_summer",
"gm_weferlingen_winter"
]) then
	{
	tpw_animal_wolves = 4;
	};

tpw_animals = // array of animals and their min / max flock sizes
[["Hen_random_F",2,4], // chicken
["Sheep_random_F",3,6], // sheep
["Sheep_random_F",3,6],
["Goat_random_F",3,6], // goat
["Goat_random_F",3,6],
["Alsatian_random_F",1,2], // alsatian
["Fin_random_f",1,2]]; // mutt

if (isclass (configfile/"CfgVehicles"/"dbo_horse_Base_F")) then 
	{
	tpw_animals append 
	[["dbo_horse",1,1]], //horses
	};


// DELAY
sleep tpw_animal_sleep;

// CONDITIONS FOR SPAWNING A NEW ANIMAL
tpw_animal_fnc_nearanimal =
	{
	private ["_owner","_spawnflag","_deadplayer","_animalarray","_animal","_i"];
	
	if (daytime < tpw_core_morning || daytime > tpw_core_night) exitWith {}; // don't bother at night
	
	if ((count nearestTerrainObjects [player, ["tree","smalltree"], tpw_animal_minradius, false]) > 50) exitwith {}; // don't bother with animals if too many trees nearby
	
	if ((count nearestTerrainObjects [player, ["house"], tpw_animal_minradius, false]) > 5) exitwith {}; // don't bother with animals if too many buildings nearby	
	
	if (count nearestLocations [position player, ["NameCity","NameCityCapital","NameVillage","NameLocal"], tpw_animal_maxradius] > 0) exitwith {}; // don't bother if town nearby
	
	_spawnflag = true; // only spawn animal if this is true

	// Check if any players have been killed and disown their animals - MP
	if (isMultiplayer) then 
		{
			{
			if ((isplayer _x) && !(alive _x)) then
				{
				_deadplayer = _x;
				_animalarray = _x getvariable ["tpw_animalarray"];
				for "_i" from 0 to (count _animalarray - 1) do 
					{
					
					_animal setvariable ["tpw_animal_owner",(_animal getvariable "tpw_animal_owner") - [_deadplayer],true];
					};
				};
			} count allunits;    

		// Any nearby animals owned by other players - MP
		_nearanimals = (position player) nearentities [["Fowl_Base_F", "Dog_Base_F", "Goat_Base_F", "Sheep_Random_F","feint_shark","dbo_horse_Base_F"],tpw_animal_maxradius]; 
		for "_i" from 0 to (count _nearanimals - 1) do 
			{
			_animal = _nearanimals select _i;
			_owner = _animal getvariable ["tpw_animal_owner",[]];
	
			//Animals with owners who are not this player
			if ((count _owner > 0) && !(player in _owner)) exitwith
				{
				_spawnflag = false;
				_owner set [count _owner,player]; // add player as another owner of this animal
				_animal setvariable ["tpw_animal_owner",_owner,true]; // update ownership
				tpw_animal_array set [count tpw_animal_array,_animal]; // add this animal to the array of animals for this player
				};
			};
		};  
    
	// Otherwise, spawn a new animal
	if (_spawnflag) then 
		{
		[] spawn tpw_animal_fnc_spawn;    
		};     
	};

// SPAWN ANIMALS INTO APPROPRIATE SPOTS
tpw_animal_fnc_spawn =
	{
	private ["_group","_pos","_dir","_posx","_posy","_spawnpos","_type","_animal","_typearray","_type","_flock","_minflock","_maxflock","_diff","_i","_horses"];

	_typearray = tpw_animals select (floor (random (count tpw_animals))); // select animal/flocksize
	_type = _typearray select 0; // type of animal
	_minflock = _typearray select 1; // minimum flock size
	_maxflock = _typearray select 2; // maximum flock size
	_diff = round (random (_maxflock - _minflock)); // how many animals more than minimum flock size
	_flock = _minflock + _diff; // flock size
	_pos = getposasl player;
	_spawnpos = ["land", _pos, tpw_animal_minradius, tpw_animal_maxradius, 1] call Gemini_fnc_findPos;
	
	// Sharks?
	if (surfaceiswater _pos && {isclass (configfile/"CfgVehicles"/"feint_shark")} && {(getposatl player) select 2 > 2} && {tpw_animal_shark == 1} ) then
		{
		waituntil
			{
			_dir = random 360;
			_posx = (_pos select 0) + ((tpw_animal_minradius + random tpw_animal_maxradius) * sin _dir);
			_posy = (_pos select 1) +  ((tpw_animal_minradius + random tpw_animal_maxradius) * cos _dir);
			_spawnpos = [_posx,_posy,-3];
			surfaceiswater _spawnpos
			};
		_type = ["feint_shark","feint_shark2"] select floor random 2;	
		_flock = 1;
		};
		
	// Man eating sharks?
	if ((random 1 > 0.8) && {surfaceiswater _pos} && {isclass (configfile/"CfgVehicles"/"GreatWhiteShark3")} && {(getposatl player) select 2 > 2} && {tpw_animal_shark == 1} ) then
		{
		waituntil
			{
			_dir = random 360;
			_posx = (_pos select 0) + ((tpw_animal_minradius + random tpw_animal_maxradius) * sin _dir);
			_posy = (_pos select 1) +  ((tpw_animal_minradius + random tpw_animal_maxradius) * cos _dir);
			_spawnpos = [_posx,_posy,-3];
			surfaceiswater _spawnpos
			};
		_type = ["GreatWhiteShark","GreatWhiteShark2","GreatWhiteShark3"] select floor random 3;
		_flock = 1;
		};		
		
	
	if(!(isnil "_spawnpos")) then 
		{
		// Spawn flock
		for "_i" from 1 to _flock do 
			{
			// Horses
			if (_type == "dbo_horse") then
				{
				_type = ["dbo_horse_W","dbo_horse_W2","dbo_horse_W3","dbo_horse_W4","dbo_horse_W5"] select floor random 5 ; 
				if (random 100 < tpw_animal_saddleperc) then
					{
					_type = ["dbo_horse","dbo_horse_dark","dbo_horse_snow","dbo_horse_wf","dbo_horse_wp","dbo_horse_lp"] select floor random 5;
					};
				_horsegroup = createGroup Civilian;
				_animal = _horsegroup createUnit [_type,_spawnpos, [], 0, "NONE"];
				_animal setdir random 360;
					{
					 _animal disableAI _x
					} forEach ["TARGET","AUTOTARGET","FSM","WEAPONAIM","AIMINGERROR","SUPPRESSION","COVER","AUTOCOMBAT","MINEDETECTION"];
				} else
				// Other animals
				{
				_animal = createAgent [_type,_spawnpos, [], 0, "NONE"];
				};
			_animal setdir random 360;
			_animal setbehaviour "CARELESS";
			_animal setSpeedMode "LIMITED";
			_animal setvariable ["tpw_animal_startpos",_spawnpos];
			_animal setvariable ["tpw_animal_owner",[player],true]; // mark it as owned by this player
			tpw_animal_array set [count tpw_animal_array,_animal]; // add to player's animal array
			player setvariable ["tpw_animalarray",tpw_animal_array,true]; // broadcast it
			sleep random 3;
			//if (_type in ["feint_shark","feint_shark2"]) then {_animal domove position player}; // sharks move towards player 
			};
		};	
	};

//DISPERSE	
tpw_animal_disperse = 
	{
	private ["_obj","_animal","_adir","_pdir","_dir","_pos","_posx","_posy"];
	_obj = _this select 0;
	_animal = _this select 1;
	
	if (_animal getvariable ["tpw_animal_disperse",0] == 0) then	
		{
		sleep random 2;
		_animal setvariable	["tpw_animal_disperse",1];
		_adir = [_obj,_animal] call bis_fnc_dirto;
		_pdir = direction _obj;
		_dir = 0;
		if (_adir < _pdir) then
			{
			_dir = _pdir - 45 - random 20;
			}
		else
			{
			_dir = _pdir + 45 + random 20;
			};
		_animal setdir _dir;	
		for "_i" from 1 to (50 + random 100) do
			{
			_pos = position _animal;
			_posx = (_pos select 0) + (0.05 * sin _dir);
			_posy = (_pos select 1) +  (0.05 * cos _dir);
			_animal setposatl [_posx,_posy,0];
			sleep random 0.1;
			};
		_animal setvariable	["tpw_animal_disperse",0];	
		};	
	};	
	
// BARKING DOGS	
tpw_animal_fnc_dogbark =
	{
	private ["_ball","_pos","_dist","_posx","_posy","_barkpos","_bark","_nearhouses","_vol"];		
	
	//Invisible object to attach bark to 
	_ball = "Land_HelipadEmpty_F" createvehiclelocal [0,0,0];
		
	while {true} do
		{
		if (tpw_animal_active && {!tpw_core_battle} && {player == vehicle player}) then
			{
			// random position around player
			_pos = getposasl player;
			_dir = random 360;
			_dist = 10 + (random 10);
			_posx = (_pos select 0) + (_dist * sin _dir);
			_posy = (_pos select 1) +  (_dist * cos _dir);
			_barkpos = [_posx,_posy,0]; 
			_ball setposatl _barkpos;
					
			// Scan for habitable houses 
			_nearhouses = [100] call tpw_core_fnc_screenhouses;
			
			// Reduce bark volume away from habitation
			if (count _nearhouses == 0) then 
				{
				_vol = 0.25;
				}
			else
				{
				_vol = 1;
				};
			
			// play bark
			_bark = format ["TPW_SOUNDS\sounds\animal\dog%1.ogg",ceil (random 20)];
			playsound3d [_bark,_ball,false,getposasl _ball,_vol,1,50];
			sleep 0.25;	
			playsound3d [_bark,_ball,false,getposasl _ball,_vol/8,1,50];
			sleep 0.25;	
			playsound3d [_bark,_ball,false,getposasl _ball,_vol/16,1,50];
			};
		sleep random tpw_animal_noisetime;
		};
	};	
	
// BLEATING GOATS 	
tpw_animal_fnc_goatbleat =
	{
	private ["_bleatpos","_bleat","_neargoats","_goat"];		
	while {true} do
		{
		_neargoats = (position player) nearEntities ["goat_base_f", 50];
		if (tpw_animal_active && {!tpw_core_battle} && {count _neargoats > 0} && {(daytime > tpw_core_morning &&  daytime < tpw_core_night)} && {player == vehicle player}) then
			{
			// Random goat
			_goat = _neargoats select (floor (random (count _neargoats)));
			_bleatpos = getposasl _goat; 
			
			// Play bleat
			_bleat = format ["TPW_SOUNDS\sounds\animal\goat%1.ogg",ceil (random 5)];
			playsound3d [_bleat,_goat,false,getposasl _goat,2,0.95 + (random 0.1),100];
			};
		sleep random 10;
		};
	};	
	
// BAAING SHEEP 	
tpw_animal_fnc_sheepbaa =
	{
	private ["_baapos","_baa","_nearsheep","_sheep"];		
	while {true} do
		{
		_nearsheep = (position player) nearEntities ["sheep_random_f", 50];
		if (tpw_animal_active && {!tpw_core_battle} && {count _nearsheep > 0} && {(daytime > tpw_core_morning &&  daytime < tpw_core_night)} && {player == vehicle player}) then
			{
			// Random goat
			_sheep = _nearsheep select (floor (random (count _nearsheep)));
			_baapos = getposasl _sheep; 
			
			// Play bleat
			_baa = format ["TPW_SOUNDS\sounds\animal\sheep%1.ogg",ceil (random 5)];
			playsound3d [_baa,_sheep,false,getposasl _sheep,10,0.95 + (random 0.1),100];
			};
		sleep random 10;
		};
	};	

// SNORTING HORSES	
tpw_animal_fnc_horsesnort =
	{
	private ["_snortpos","_snort","_nearhorses","_horse"];		
	while {true} do
		{
		_nearhorses = (position player) nearEntities ["dbo_horse_Base_F", 50];
		if (tpw_animal_active && {!tpw_core_battle} && {count _nearhorses > 0} && {(daytime > tpw_core_morning &&  daytime < tpw_core_night)} && {player == vehicle player}) then
			{
			// Random horse
			_horse = _nearhorses select (floor (random (count _nearhorses)));
			_snortpos = getposasl _horse; 
			
			// Play snort
			_snort = format ["TPW_SOUNDS\sounds\animal\horse%1.ogg",ceil (random 5)];
			playsound3d [_snort,_horse,false,getposasl _horse,1 + random 2,1 + (random 0.1),70];
			};
		sleep random 20;
		};
	};	

// CLUCKING CHICKENS 	
tpw_animal_fnc_chickencluck =
	{
	private ["_cluckpos","_cluck","_nearchickens","_chicken"];		
	while {true} do
		{
		_nearchickens = (position player) nearEntities ["Fowl_Base_F", 50];
		if (tpw_animal_active && {!tpw_core_battle} && {count _nearchickens > 0} && {(daytime > tpw_core_morning &&  daytime < tpw_core_night)} && {player == vehicle player}) then
			{
			// Random chicken
			_chicken = _nearchickens select (floor (random (count _nearchickens)));
			_cluckpos = getposasl _chicken; 
			
			// Play cluck
			_cluck = format ["TPW_SOUNDS\sounds\animal\cluck%1.ogg",ceil (random 6)];
			playsound3d [_cluck,_chicken,false,getposasl _chicken,1,0.9 + (random 0.2),100];
			};
		sleep random 10;
		};
	};	

// PANTING DOGS 	
tpw_animal_fnc_dogpant =
	{
	private ["_pantpos","_pant","_neardogs","_dog"];		
	while {true} do
		{
		_neardogs = (position player) nearEntities ["Dog_Base_F", 25];
		if (tpw_animal_active && {!tpw_core_battle} && {count _neardogs > 0} && {(daytime > tpw_core_morning &&  daytime < tpw_core_night)} && {player == vehicle player}) then
			{
			// Random dog
			_dog = _neardogs select (floor (random (count _neardogs)));
			_pantpos = getposasl _dog; 
			
			// Play pant noises
			_pant = format ["TPW_SOUNDS\sounds\animal\dogpant%1.ogg",ceil (random 6)];
			playsound3d [_pant,_dog,false,getposasl _dog,3,0.9 + (random 0.2),50];
			};
		sleep random 10;
		};
	};	
	
// YOWLING CATS AT NIGHT 	
tpw_animal_fnc_catmeow =
	{
	private ["_ball","_pos","_dist","_posx","_posy","_meowpos","_meow","_vol","_pitch"];		
	//Invisible object to attach meow to 
	_ball = "Land_HelipadEmpty_F" createvehiclelocal [0,0,0];
		
	while {true} do
		{
		// Scan for habitable houses 
		if (tpw_animal_active && {!tpw_core_battle} && {daytime < (tpw_animal_sunrise - 2) || daytime > (tpw_animal_sunset + 2)} && {player == vehicle player} && {count ([100] call tpw_core_fnc_screenhouses)> 2}) then
			{
			// random position around player
			_pos = getposasl player;
			_dir = random 360;
			_dist = 15 + (random 10);
			_posx = (_pos select 0) + (_dist * sin _dir);
			_posy = (_pos select 1) +  (_dist * cos _dir);
			_meowpos = [_posx,_posy,0]; 
			_ball setposatl _meowpos;
			
			// play meow
			_meow = format ["TPW_SOUNDS\sounds\animal\cat%1.ogg",ceil (random 5)];
			_vol = 1;
			_pitch = 0.5 + (random 0.6);
			playsound3d [_meow,_ball,false,getposasl _ball,_vol,_pitch,50];
			sleep 0.25;
			playsound3d [_meow,_ball,false,getposasl _ball,_vol/8,_pitch,50];
			sleep 0.25;	
			playsound3d [_meow,_ball,false,getposasl _ball,_vol/16,_pitch,50];
			};
		sleep random tpw_animal_noisetime;
		};
	};	
	
// HOWLING WOLVES AT NIGHT 	
tpw_animal_fnc_wolfhowl =
	{
	private ["_ball","_pos","_dist","_posx","_posy","_howlpos","_howl","_vol","_pitch"];		
	//Invisible object to attach meow to 
	_ball = "Land_HelipadEmpty_F" createvehiclelocal [0,0,0];
	sleep random (tpw_animal_noisetime * 3);	
	while {true} do
		{
		if (tpw_animal_active && {!tpw_core_battle} && {tpw_animal_wolves > 0} && {daytime < (tpw_animal_sunrise - 2) || daytime > (tpw_animal_sunset + 2)} && {player == vehicle player} && {count ([100] call tpw_core_fnc_screenhouses)== 0}) then
			{
			// random position around player
			_pos = getposasl player;
			_dir = random 360;
			_dist = 20 + (random 20);
			_posx = (_pos select 0) + (_dist * sin _dir);
			_posy = (_pos select 1) +  (_dist * cos _dir);
			_howlpos = [_posx,_posy,0]; 
			_ball setposatl _howlpos;
			
			// play howls
			for "_i" from 0 to ceil random 5 do
				{
				_howl = format ["TPW_SOUNDS\sounds\animal\wolf%1.ogg",ceil (random 10)];
				playsound3d [_howl,_ball,false,getposasl _ball,tpw_animal_wolves,0.9 + random 0.1,100];
				sleep random 2;
				};
			};
		sleep random (tpw_animal_noisetime * 3);
		};
	};	
	
// FOX SCREAMS AT NIGHT 	
tpw_animal_fnc_foxscream =
	{
	private ["_ball","_pos","_dist","_posx","_posy","_howpos","_howl"];		
	//Invisible object to attach meow to 
	_ball = "Land_HelipadEmpty_F" createvehiclelocal [0,0,0];
		
	while {true} do
		{
		if (tpw_animal_active && {!tpw_core_battle} && {daytime < (tpw_animal_sunrise - 2) || daytime > (tpw_animal_sunset + 2)} && {player == vehicle player}) then
			{
			// random position around player
			_pos = getposasl player;
			_dir = random 360;
			_dist = 20 + (random 20);
			_posx = (_pos select 0) + (_dist * sin _dir);
			_posy = (_pos select 1) +  (_dist * cos _dir);
			_howlpos = [_posx,_posy,0]; 
			_ball setposatl _howlpos;
			_howl = format ["TPW_SOUNDS\sounds\animal\fox%1.ogg",ceil (random 5)];
			_vol = 2;
			_pitch = 0.9 + random 0.1;
			playsound3d [_howl,_ball,false,getposasl _ball,_vol,_pitch,100];
			sleep 0.25;
			playsound3d [_howl,_ball,false,getposasl _ball,_vol/8,_pitch,100];
			sleep 0.25;
			playsound3d [_howl,_ball,false,getposasl _ball,_vol/16,_pitch,100];
			};
		sleep random tpw_animal_noisetime;
		};
	};		

// HOOTING OWLS AT NIGHT
tpw_animal_fnc_owlhoot = 
	{
	private ["_trees","_treepos","_hoot"];
	while {true} do
		{		
		sleep random (tpw_animal_noisetime/2);	
		if (tpw_animal_active && {!tpw_core_battle} && {daytime < (tpw_animal_sunrise - 2) || daytime > (tpw_animal_sunset + 2)}) then
			{
			_trees = nearestTerrainObjects [position player, ["tree"], 50, false];
			if (count _trees > 10) then
				{
				_treepos = (getposasl (_trees select 0)) vectoradd [0,0,3];
				_hoot = format ["TPW_SOUNDS\sounds\animal\owl%1.ogg",(ceil random 6)];
				for "_i" from 0 to ceil random 5 do
					{
					_vol = 8;
					playsound3d [_hoot,_treepos,false,_treepos,_vol,1,100];
					sleep 0.25;
					playsound3d [_hoot,_treepos,false,_treepos,_vol/8,1,100];
					sleep 0.25;
					playsound3d [_hoot,_treepos,false,_treepos,_vol/16,1,100];
					sleep (4 + random 1);
					};	
				};
			};
		};
	};	
	
// DAWN CHORUS
tpw_animal_fnc_dawnchorus = 
	{
	private ["_trees","_treepos","_chorus"];
	while {true} do
		{		
		sleep random 20;	
		if (tpw_animal_active && {!tpw_core_battle} && {daytime > (tpw_animal_sunrise - 1)} && {daytime < (tpw_animal_sunrise + 1)}) then
			{
			_trees = nearestTerrainObjects [position player, ["tree","smalltree","bush" ], 50, false];
			if (count _trees > 10) then
				{
				_treepos = (getposasl (_trees select (floor random count _trees))) vectoradd [0,0,3];
				_chorus = format ["TPW_SOUNDS\sounds\animal\chorus%1.ogg",(ceil random 10)];
				playsound3d [_chorus,_treepos,false,_treepos,2,1,200];
				};
			};
		};
	};	

// GENERAL BIRDS
tpw_animal_fnc_birds = 
	{
	private ["_trees","_treepos","_birds"];
	while {true} do
		{		
		sleep random 20;	
		if (tpw_animal_active && {!tpw_core_battle} && {daytime > tpw_animal_sunrise} && {daytime < tpw_animal_sunset}) then
			{
			_trees = nearestTerrainObjects [position player, ["tree","smalltree","bush" ], 50, false];
			if (count _trees > 5) then
				{
				_treepos = (getposasl (_trees select (floor random count _trees))) vectoradd [0,0,3];
				_birds = format ["TPW_SOUNDS\sounds\animal\chorus%1.ogg",(ceil random 10)];
				playsound3d [_birds,_treepos,false,_treepos,0.5,1,50];
				};
			};
		};
	};		

// FROGS
tpw_animal_fnc_frogs = 
	{
	private ["_reeds","_reed","_frog"];
	while {true} do
		{		
		sleep random 30;	
		if (tpw_animal_active && {!tpw_core_battle}  && {!(isnil "tpw_fog_temp")} && {tpw_fog_temp > 5}) then 
			{
			_reeds = nearestTerrainObjects [position player, ["hide","bush"], 15, false]  select {(getmodelinfo _x) select 0 in ["p_reeds_f.p3d","p_phragmites.p3d","cype_reeds.p3d","cype_phragmites.p3d","gm_river_01_600_l5.p3d","gm_river_01_600_l1.p3d","gm_river_01_600_r5.p3d","gm_river_01_600_r1.p3d","gm_river_01_600.p3d","b_phragmites_australis.p3d"]};
			if (count _reeds > 0) then
				{
				_reed = (getposasl (_reeds select (floor random count _reeds)));
				_frog = format ["TPW_SOUNDS\sounds\animal\frog%1.ogg",(ceil random 5)];
				playsound3d [_frog,_reed,false,_reed,2,1,50];
				};
			};
		};
	};	
	
// INSECTS
tpw_animal_fnc_insects = 
	{
	private ["_trees","_tree","_bug"];
	while {true} do
		{		
		sleep random 15;	
		if (tpw_animal_active && {!tpw_core_battle} && {!(isnil "tpw_fog_temp")} && {tpw_fog_temp > 5} ) then 
			{
			_trees = nearestTerrainObjects [position player, ["tree","small tree","bush"], 10, false];
			if (count _trees > 5) then
				{
				_tree = (getposasl (_trees select (floor random count _trees)));
				_bug = format ["TPW_SOUNDS\sounds\animal\insect%1.ogg",(ceil random 7)];
				playsound3d [_bug,_tree,false,_tree,2,1,20];
				};
			};
		};
	};	
	
// CROWS
tpw_animal_fnc_crows = 
	{
	private ["_closedead","_fardead","_crow","_crowflag"];
	tpw_animal_crows = [];
	while {true} do
		{
		if (!(tpw_core_battle) && {daytime > tpw_animal_sunrise} && {daytime < tpw_animal_sunset}) then 
			{
			_crowflag = true;
			};
		if (tpw_core_battle  || daytime < tpw_animal_sunrise  || daytime > tpw_animal_sunset) then 
			{
			_crowflag = false;
			};		
		
		if (tpw_animal_active && _crowflag) then
			{
			_closedead = alldead select {_x distance player <200};
			_fardead = alldead select {_x distance player >200};
			
			// Add crows to nearby bodies 
				{
				if (_x getvariable ["tpw_crows",-1] == -1) then
					{
					_crows = [getposasl _x,25,ceil random 3,10] call bis_fnc_crows;
					tpw_animal_crows = tpw_animal_crows + _crows;	
					_x setvariable ["tpw_crows",1];	
					sleep random 10;
					};
				} foreach _closedead;

			// Remove crow spawning flag from distant bodies
				{
				_x setvariable ["tpw_crows",-1];			
				} foreach _fardead;	
			};	
				
		// Crow wrangling	
		for "_i" from 0 to (count tpw_animal_crows - 1) do 
			{
			_crow = tpw_animal_crows select _i;
			// Delete distant crows
			if (!(_crowflag) || _crow distance player > 200) then 
				{
				deletevehicle _crow;
				tpw_animal_crows set[_i,-1];
				};
			};
		tpw_animal_crows = tpw_animal_crows - [-1];	

		// Reset bodies to not spawn crows
		if (!_crowflag) then
			{
				{
				_x setvariable ["tpw_crows",-1];	
				} foreach alldead;
			};
		sleep random 30;
		};
	};	

tpw_animal_fnc_crowcall =
	{
	private ["_crow","_caw","_nearcrows"];
	sleep 5;
	while {true} do
		{
		if (tpw_animal_active && {!tpw_core_battle} && {daytime > tpw_animal_sunrise} && {daytime < tpw_animal_sunset}) then
			{
			_nearcrows = tpw_animal_crows select {_x distance player < 200};
			if (count _nearcrows > 2) then
				{
				_crow = _nearcrows select floor random count _nearcrows;
				_caw = format ["TPW_SOUNDS\sounds\animal\crow%1.ogg",(ceil random 6)];	
				playsound3d [_caw,_crow,false,_crow,2,0.8 + random 0.2,200];
				};
			};
		sleep random 10;
		};	
	};	
	
// MAIN LOOP
tpw_animal_fnc_mainloop = 
	{
	while {true} do
		{
		if (tpw_animal_active && {!tpw_core_battle} && {vehicle player == player}) then
			{
			private ["_animal","_i"];

			if (tpw_animal_debug) then
				{
				hintsilent format ["Animals: %1",count tpw_animal_array];
				};
		
			// Spawn animals if there are less than the specified maximum
			if (count tpw_animal_array < tpw_animal_max && {rain < 0.3}) then
				{
				[] call tpw_animal_fnc_nearanimal;
				};

			// Remove ownership of distant or dead animals
			tpw_animal_removearray = []; // array of animals to remove
			for "_i" from 0 to (count tpw_animal_array - 1) do 
				{
				_animal = tpw_animal_array select _i;
				if (_animal distance player > tpw_animal_maxradius || !(alive _animal)) then 
					{
					_animal setvariable ["tpw_animal_owner",(_animal getvariable "tpw_animal_owner") - [player],true];
					tpw_animal_removearray set [count tpw_animal_removearray,_animal];
					};
				
				// Sharks are removed sooner	
				if (typeof _animal == "feint_shark" && _animal distance player > 50 || !(alive _animal)) then 
					{
					_animal setvariable ["tpw_animal_owner",(_animal getvariable "tpw_animal_owner") - [player],true];
					tpw_animal_removearray set [count tpw_animal_removearray,_animal];
					};	
				
				// Delete live animals with no owners
				if ((count (_animal getvariable ["tpw_animal_owner",[]]) == 0) && (alive _animal))then	
					{
					deletevehicle _animal;
					sleep 0.1;
					};
					
				// Animals move away from vehicles
				_near = (position _animal) nearEntities [["LandVehicle"], 20];
				if (count _near > 0) then
					{
					[(_near select 0),_animal] spawn tpw_animal_disperse;
					};
				
				// Slow and relaxed	
				_animal setAnimSpeedCoef 0.8 + random 0.2;					
				_animal setbehaviour "CARELESS";
				_animal setSpeedMode "LIMITED";	
				//_animal forceSpeed 0.0001; 
				//_animal forcewalk true;
				_animal moveto (_animal getvariable "tpw_animal_startpos");
				}; 

			// Update player's animal array	
			tpw_animal_array = tpw_animal_array - tpw_animal_removearray;
			player setvariable ["tpw_animalarray",tpw_animal_array,true];
			};
		sleep random 10;
		};
	};	
	
// RUN IT
if (isclass (configfile/"CfgVehicles"/"dbo_horse_Base_F")) then 
	{
	[] spawn tpw_animal_fnc_horsesnort;
	
	// Johnnyboy's code to prevent UAV control release when on horse
	_n = [] spawn
		{
		sleep 5;
		while {true} do
			{
			sleep 2;
			if ((cameraOn == player) and (animationState player == "horse_rider") and !(isNull attachedTo player)) then
				{
				sleep 1;
				// We check same condition twice because these conditions are true for a split second when player
				// chooses "Get Off" action. By waiting a bit, we know player is truly stuck.
				if ((cameraOn == player) and (animationState player == "horse_rider") and !(isNull attachedTo player)) then
					{
					sleep .5;
					_horse = attachedTo player;
					player switchMove "";
					detach player;
					player setVelocityModelSpace [-2,0,-2];
					removeAllActions _horse; // remove get off action then add get on action
					_hossmount = _horse addaction ["GetOn","\dbo\dbo_horses\scripts\horse_mount.sqf",nil,1.5,true,true,"","true",4,false,""];
					_horse setobjecttexture [0,"\dbo\dbo_horses\data\tack_co.paa"];
					_horse setobjecttexture [1,""];
					};
				};
			};
		};	
	};
sleep 10;	
[] spawn tpw_animal_fnc_dogbark;
[] spawn tpw_animal_fnc_dogpant;
[] spawn tpw_animal_fnc_catmeow;
[] spawn tpw_animal_fnc_wolfhowl;
[] spawn tpw_animal_fnc_foxscream;
[] spawn tpw_animal_fnc_owlhoot;
[] spawn tpw_animal_fnc_dawnchorus;
[] spawn tpw_animal_fnc_birds;
[] spawn tpw_animal_fnc_frogs;
[] spawn tpw_animal_fnc_insects;
[] spawn tpw_animal_fnc_goatbleat;
[] spawn tpw_animal_fnc_sheepbaa;
[] spawn tpw_animal_fnc_chickencluck;
[] spawn tpw_animal_fnc_crows;
[] spawn tpw_animal_fnc_crowcall;
[] spawn tpw_animal_fnc_mainloop;

while {true} do
	{
	// dummy loop so script doesn't terminate
	sleep 10;
	};