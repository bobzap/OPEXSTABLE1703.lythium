if (!isServer) exitWith {};
if (typeOf _this in ["Alsatian_Black_F","Alsatian_Sandblack_F"]) exitWith {}; // loadouts don't concern dogs !
waitUntil {!isNil "OPEX_params_ready"}; waitUntil {OPEX_params_ready};

private _unit = _this;
private _side = side _this;

if ((typeOf _unit) in OPEX_civilian_reporters) exitWith {};

_unit setVariable ["BIS_enableRandomization", false];

removeAllWeapons _unit;
removeHeadgear _unit;
removeGoggles _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeAllAssignedItems _unit;

private ["_uniform","_balaclava","_headgear","_beard","_scarf","_glasses","_vest","_backpack","_rifle", "_handgun", "_launcher"];
private ["_proba_balaclava","_proba_headgear","_proba_beard","_proba_scarf","_proba_glasses","_proba_vest","_proba_backpack"];

switch (_side) do
	{

		///////////////////////////////////////////////////////////////////////////////////////////////////
		// ENEMIES
		///////////////////////////////////////////////////////////////////////////////////////////////////

		case (OPEX_enemy_side1) :
			{

				// SETTING PROBABILITIES TO GET HEADGEAR, FACEGEAR, VEST AND BACKPACK (DEPENDING ON THE ENEMY FACTION)
				switch OPEX_enemy_fighters do
					{
						case "STR_enemy_fighters_ISIS"	:	{_proba_balaclava = 75; _proba_headgear = 90; _proba_beard = 100; _proba_scarf = 75; _proba_glasses = 10; _proba_vest = 35; _proba_backpack = 25};
						case "STR_enemy_fighters_BOKO"	:	{_proba_balaclava = 75; _proba_headgear = 90; _proba_beard = 85; _proba_scarf = 50; _proba_glasses = 10; _proba_vest = 25; _proba_backpack = 25};
						case "STR_enemy_fighters_ULTRA"	:	{if (worldName in ["Tanoa"]) then {_proba_balaclava = 0} else {_proba_balaclava = 25}; _proba_headgear = 90; _proba_beard = 10; _proba_scarf = 50; _proba_glasses = 10; _proba_vest = 25; _proba_backpack = 20};
						case "STR_enemy_fighters_TALIB"	:
							{
								switch OPEX_param_enemyFaction do
									{
										case (("STR_enemy_name_TALIB_4") + " " + "(" + "CUP" + ")")	:	{_proba_balaclava = 5; _proba_headgear = 90; _proba_beard = 90; _proba_scarf = 75; _proba_glasses = 5; _proba_vest = 100; _proba_backpack = 20};
										case (("STR_enemy_name_TALIB_4") + " " + "(" + "CFP" + ")")	:	{_proba_balaclava = 5; _proba_headgear = 90; _proba_beard = 90; _proba_scarf = 75; _proba_glasses = 5; _proba_vest = 100; _proba_backpack = 20};
										case (("STR_enemy_name_TALIB_4") + " " + "(" + "LOP" + ")")	:	{_proba_balaclava = 5; _proba_headgear = 90; _proba_beard = 90; _proba_scarf = 75; _proba_glasses = 5; _proba_vest = 0; _proba_backpack = 20};
										case (("STR_enemy_name_TALIB_4") + " " + "(" + "3CB" + ")")	:	{_proba_balaclava = 5; _proba_headgear = 90; _proba_beard = 90; _proba_scarf = 75; _proba_glasses = 5; _proba_vest = 0; _proba_backpack = 20};
										default															{_proba_balaclava = 5; _proba_headgear = 90; _proba_beard = 90; _proba_scarf = 75; _proba_glasses = 5; _proba_vest = 0; _proba_backpack = 20};
									};
							};
						default 							{_proba_balaclava = 50; _proba_headgear = 75; _proba_beard = 50; _proba_scarf = 50; _proba_glasses = 10; _proba_vest = 50; _proba_backpack = 25};
					};

				// SETTING GEAR (DEPENDING ON THE ENEMY TYPE)
				switch (typeOf _unit) do
					{
						case (OPEX_enemy_teamLeader):
							{
								_uniform = selectRandom ["rhsgref_uniform_gorka_1_f","rhsgref_uniform_TLA_1","rhsgref_uniform_TLA_2","rhsgref_uniform_para_ttsko_mountain"];
								_balaclava = selectRandom OPEX_enemy_balaclavas; _proba_balaclava = 0;
								_headgear = selectRandom OPEX_enemy_officerHeadgears;
								_beard = selectRandom OPEX_enemy_beards; _proba_beard = 100;
								_scarf = selectRandom OPEX_enemy_scarfs;
								if (OPEX_sunHeight > 1) then {_glasses = selectRandom (OPEX_enemy_sunglasses + OPEX_enemy_glasses + OPEX_enemy_glasses)} else {_glasses = selectRandom OPEX_enemy_glasses}; _proba_glasses = 75;
								_vest = selectRandom (OPEX_enemy_commonVests + OPEX_enemy_beltVests);
								_backpack = selectRandom OPEX_enemy_commonBackpacks; _proba_backpack = 100;
								_rifle = selectRandom (OPEX_enemy_commonRifles + OPEX_enemy_specialRifles);
								_handgun = selectRandom (OPEX_enemy_commonHandguns + OPEX_enemy_specialHandguns);
								_launcher = "";
							};
						case (OPEX_enemy_rifleman):
							{
								_uniform = selectRandom ["rhsgref_uniform_gorka_1_f","rhsgref_uniform_TLA_1","rhsgref_uniform_TLA_2","rhsgref_uniform_para_ttsko_mountain"];
								_balaclava = selectRandom OPEX_enemy_balaclavas;
								_headgear = selectRandom OPEX_enemy_headgears;
								_beard = selectRandom OPEX_enemy_beards;
								_scarf = selectRandom OPEX_enemy_scarfs;
								if (OPEX_sunHeight > 1) then {_glasses = selectRandom (OPEX_enemy_sunglasses + OPEX_enemy_glasses + OPEX_enemy_glasses)} else {_glasses = selectRandom OPEX_enemy_glasses};
								_vest = selectRandom OPEX_enemy_commonVests;
								_backpack = selectRandom OPEX_enemy_commonBackpacks;
								_rifle = selectRandom (OPEX_enemy_commonRifles + OPEX_enemy_specialRifles);
								_handgun = selectRandom (OPEX_enemy_commonHandguns + OPEX_enemy_specialHandguns);
								_launcher = ""
							};
						case (OPEX_enemy_grenadier):
							{
								_uniform = selectRandom ["rhsgref_uniform_gorka_1_f","rhsgref_uniform_TLA_1","rhsgref_uniform_TLA_2","rhsgref_uniform_para_ttsko_mountain"];
								_balaclava = selectRandom OPEX_enemy_balaclavas;
								_headgear = selectRandom OPEX_enemy_headgears;
								_beard = selectRandom OPEX_enemy_beards;
								_scarf = selectRandom OPEX_enemy_scarfs;
								if (OPEX_sunHeight > 1) then {_glasses = selectRandom (OPEX_enemy_sunglasses + OPEX_enemy_glasses + OPEX_enemy_glasses)} else {_glasses = selectRandom OPEX_enemy_glasses};
								_vest = selectRandom OPEX_enemy_grenadierVests;
								_backpack = selectRandom OPEX_enemy_commonBackpacks;
								_rifle = selectRandom OPEX_enemy_GLrifles;
								_handgun = selectRandom OPEX_enemy_commonHandguns;
								_launcher = ""
							};
						case (OPEX_enemy_MG):
							{
								_uniform = selectRandom ["rhsgref_uniform_gorka_1_f","rhsgref_uniform_TLA_1","rhsgref_uniform_TLA_2","rhsgref_uniform_para_ttsko_mountain"];
								_balaclava = selectRandom OPEX_enemy_balaclavas;
								_headgear = selectRandom OPEX_enemy_headgears;
								_beard = selectRandom OPEX_enemy_beards;
								_scarf = selectRandom OPEX_enemy_scarfs;
								if (OPEX_sunHeight > 1) then {_glasses = selectRandom (OPEX_enemy_sunglasses + OPEX_enemy_glasses + OPEX_enemy_glasses)} else {_glasses = selectRandom OPEX_enemy_glasses};
								_vest = selectRandom OPEX_enemy_commonVests;
								_backpack = selectRandom OPEX_enemy_commonBackpacks;
								_rifle = selectRandom OPEX_enemy_MGrifles;
								_handgun = selectRandom OPEX_enemy_commonHandguns;
								_launcher = ""
							};
						case (OPEX_enemy_AT):
							{
								_uniform = selectRandom ["rhsgref_uniform_gorka_1_f","rhsgref_uniform_TLA_1","rhsgref_uniform_TLA_2","rhsgref_uniform_para_ttsko_mountain"];
								_balaclava = selectRandom OPEX_enemy_balaclavas;
								_headgear = selectRandom OPEX_enemy_headgears;
								_beard = selectRandom OPEX_enemy_beards;
								_scarf = selectRandom OPEX_enemy_scarfs;
								if (OPEX_sunHeight > 1) then {_glasses = selectRandom (OPEX_enemy_sunglasses + OPEX_enemy_glasses + OPEX_enemy_glasses)} else {_glasses = selectRandom OPEX_enemy_glasses};	_proba_glasses = 0;
								_vest = selectRandom OPEX_enemy_commonVests;
								_backpack = selectRandom OPEX_enemy_commonBackpacks;
								_rifle = selectRandom OPEX_enemy_commonRifles;
								_handgun = selectRandom OPEX_enemy_commonHandguns;
								_launcher = selectRandom OPEX_enemy_ATlaunchers
							};
						case (OPEX_enemy_AA):
							{
								_uniform = selectRandom ["rhsgref_uniform_gorka_1_f","rhsgref_uniform_TLA_1","rhsgref_uniform_TLA_2","rhsgref_uniform_para_ttsko_mountain"];
								_balaclava = selectRandom OPEX_enemy_balaclavas;
								_headgear = selectRandom OPEX_enemy_headgears;
								_beard = selectRandom OPEX_enemy_beards;
								_scarf = selectRandom OPEX_enemy_scarfs;
								if (OPEX_sunHeight > 1) then {_glasses = selectRandom (OPEX_enemy_sunglasses + OPEX_enemy_glasses + OPEX_enemy_glasses)} else {_glasses = selectRandom OPEX_enemy_glasses}; _proba_glasses = 0;
								_vest = selectRandom OPEX_enemy_commonVests;
								_backpack = selectRandom OPEX_enemy_commonBackpacks;
								_rifle = selectRandom OPEX_enemy_commonRifles;
								_handgun = selectRandom OPEX_enemy_commonHandguns;
								_launcher = selectRandom OPEX_enemy_AAlaunchers
							};
						case (OPEX_enemy_marksman):
							{
								_uniform = selectRandom ["rhsgref_uniform_gorka_1_f","rhsgref_uniform_TLA_1","rhsgref_uniform_TLA_2","rhsgref_uniform_para_ttsko_mountain"];
								_balaclava = selectRandom OPEX_enemy_balaclavas;
								_headgear = selectRandom OPEX_enemy_headgears;
								_beard = selectRandom OPEX_enemy_beards;
								_scarf = selectRandom OPEX_enemy_scarfs;
								if (OPEX_sunHeight > 1) then {_glasses = selectRandom (OPEX_enemy_sunglasses + OPEX_enemy_glasses + OPEX_enemy_glasses)} else {_glasses = selectRandom OPEX_enemy_glasses}; _proba_glasses = 0;
								_vest = selectRandom OPEX_enemy_commonVests;
								_backpack = selectRandom OPEX_enemy_commonBackpacks;
								_rifle = selectRandom (OPEX_enemy_precisionRifles + OPEX_enemy_sniperRifles);
								_handgun = selectRandom (OPEX_enemy_commonHandguns + OPEX_enemy_specialHandguns);
								_launcher = ""
							};
						case (OPEX_enemy_crewman):
							{
								_uniform = selectRandom ["rhsgref_uniform_gorka_1_f","rhsgref_uniform_TLA_1","rhsgref_uniform_TLA_2","rhsgref_uniform_para_ttsko_mountain"];
								_balaclava = selectRandom OPEX_enemy_balaclavas;
								_headgear = selectRandom OPEX_enemy_tankCrewHelmets;
								_beard = selectRandom OPEX_enemy_beards;
								_scarf = selectRandom OPEX_enemy_scarfs;
								if (OPEX_sunHeight > 1) then {_glasses = selectRandom (OPEX_enemy_sunglasses + OPEX_enemy_glasses + OPEX_enemy_glasses)} else {_glasses = selectRandom OPEX_enemy_glasses};
								_vest = ""; _proba_vest = 0;
								_backpack = ""; _proba_backpack = 0;
								_rifle = "";
								_handgun = selectRandom OPEX_enemy_commonHandguns;
								_launcher = "";
							};
						default
							{
								_uniform = selectRandom ["rhsgref_uniform_gorka_1_f","rhsgref_uniform_TLA_1","rhsgref_uniform_TLA_2","rhsgref_uniform_para_ttsko_mountain"];
								_balaclava = selectRandom OPEX_enemy_balaclavas;
								_headgear = selectRandom OPEX_enemy_headgears;
								_beard = selectRandom OPEX_enemy_beards;
								_scarf = selectRandom OPEX_enemy_scarfs;
								if (OPEX_sunHeight > 1) then {_glasses = selectRandom (OPEX_enemy_sunglasses + OPEX_enemy_glasses + OPEX_enemy_glasses)} else {_glasses = selectRandom OPEX_enemy_glasses};
								_vest = selectRandom OPEX_enemy_commonVests;
								_backpack = selectRandom OPEX_enemy_commonBackpacks;
								_rifle = selectRandom (OPEX_enemy_commonRifles + OPEX_enemy_specialRifles);
								_handgun = selectRandom (OPEX_enemy_commonHandguns + OPEX_enemy_specialHandguns);
								_launcher = ""
							};
					};

				// ASSIGNING GEAR
				_unit forceAddUniform _uniform;
				if ((random 100 < _proba_balaclava) && (goggles _unit == "")) then {_unit addGoggles _balaclava};
				if ((random 100 < _proba_headgear) && (goggles _unit == "") && (headgear _unit != "")) then {_unit addHeadgear _glasses};
				if ((random 100 < _proba_beard) && (goggles _unit == "") && (count OPEX_enemy_beards > 0)) then {_unit addGoggles _beard};
				if ((random 100 < _proba_scarf) && (goggles _unit == "")) then {_unit addGoggles _scarf};
				if ((random 100 < _proba_glasses) && (goggles _unit == "")) then {_unit addGoggles _glasses};
				if ((random 100 < _proba_vest) && (_vest != "") && (count (OPEX_enemy_commonVests + OPEX_enemy_beltVests + OPEX_enemy_grenadierVests) > 0)) then {_unit addVest _vest};
				if ((random 100 < _proba_backpack) && (_backpack != "")) then {_unit addBackpackGlobal _backpack; waitUntil {!isNull backpackContainer _unit}};	

				// ASSIGNING WEAPONS
				if (_rifle != "") then {[_unit, _rifle, selectRandom [2,3,3,4,4,5,5]] call BIS_fnc_addWeapon};
				if ((_handgun != "") && (random 100 <= 35)) then {[_unit, _handgun, selectRandom [1,2,3]] call BIS_fnc_addWeapon};
				//if (_launcher != "") then {[_unit, _launcher, 1 + round (random 2)] call BIS_fnc_addWeapon}; // this command doesn't work if the unit has not enough empty space, so using the commands below instead (thanks to Bardosy https://forums.bohemia.net/forums/topic/171758-addmagazine-to-rpg-launcher-does-not-work/)
				if (_launcher != "") then
					{
						private _rocket = selectRandom ((configFile >> "CfgWeapons" >> _launcher >> "magazines") call BIS_fnc_GetCfgData);
						if (backpack _unit == "")
						then
							{
								_unit addBackpackGlobal "B_AssaultPack_rgr";
								waitUntil {!isNull backpackContainer _unit};	
								_unit addMagazine [_rocket, 1];
								_unit addWeapon _launcher;
								removeBackpack _unit;
							}
						else
							{
								_unit addMagazine [_rocket, selectRandom [1,1,2]];
								_unit addWeapon _launcher;
							};
					};

				// RANDOMLY ADDING AN OPTIC TO THE RIFLE (90% CHANCE FOR SNIPERS & TEAM LEADERS - 15% CHANCE FOR OTHER UNITS)
				if ((typeOf _unit == OPEX_enemy_marksman) || ((typeOf _unit == OPEX_enemy_teamLeader) && (random 100 <= 90)))
					then {private _rifleOptic = [_rifle, 0] call Gemini_fnc_getWeaponAccessories; _unit addPrimaryWeaponItem (selectRandom _rifleOptic)}
					else {if (random 100 <= 15) then {private _rifleOptic = [_rifle, 0] call Gemini_fnc_getWeaponAccessories; _unit addPrimaryWeaponItem (selectRandom _rifleOptic)}};

				// RANDOMLY ADDING GRENADES
				if (random 100 <= 50) then {for "_i" from 1 to (selectRandom [1,2,3]) do {_unit addItem (selectRandom OPEX_enemy_handGrenades)}};

				// RANDOMLY ADDING OTHER ITEMS (IF GEMINI MOD IS ENABLED)
				if (isClass(configFile >> "CfgPatches" >> "Gemini_items")) then
					{
						for "_i" from 1 to 2 do {if (random 100 <= 50) then {_unit addItem (selectRandom OPEX_civilian_items)}};
						if (random 100 <= 50) then {_unit addItem (selectRandom OPEX_canteenItems)};
					};
			};

		///////////////////////////////////////////////////////////////////////////////////////////////////
		// FRIENDS
		///////////////////////////////////////////////////////////////////////////////////////////////////

		case (OPEX_friendly_side1) :
			{

				/*
					note: I don't know why, the command below doesn't (always) work ???

				private _type = typeOf _unit;
				switch (_type) do
					{
						case OPEX_friendly_teamLeader		:	{[_unit] execVM "loadouts\full\teamLeader.sqf"};
						case OPEX_friendly_rifleman			:	{[_unit] execVM "loadouts\full\rifleman.sqf"};
						case OPEX_friendly_grenadier		:	{[_unit] execVM "loadouts\full\grenadier.sqf"};
						case OPEX_friendly_MGLight			:	{[_unit] execVM "loadouts\full\mgLight.sqf"};
						case OPEX_friendly_MGHeavy			:	{[_unit] execVM "loadouts\full\mgHeavy.sqf"};
						case OPEX_friendly_AT				:	{[_unit] execVM "loadouts\full\at.sqf"};
						case OPEX_friendly_AA				:	{[_unit] execVM "loadouts\full\aa.sqf"};
						case OPEX_friendly_ghillie			:	{[_unit] execVM "loadouts\full\ghillieSniper.sqf"};
						case OPEX_friendly_spotter			:	{[_unit] execVM "loadouts\full\ghillieSpotter.sqf"};
						case OPEX_friendly_marksman			:	{[_unit] execVM "loadouts\full\marksman.sqf"};
						case OPEX_friendly_scout			:	{[_unit] execVM "loadouts\full\scout.sqf"};
						case OPEX_friendly_medic			:	{[_unit] execVM "loadouts\full\medic.sqf"};
						case OPEX_friendly_repairer			:	{[_unit] execVM "loadouts\full\repairer.sqf"};
						case OPEX_friendly_sapper			:	{[_unit] execVM "loadouts\full\sapper.sqf"};
						case OPEX_friendly_ammoAssistant	:	{[_unit] execVM "loadouts\full\ammoAssistant.sqf"};
						case OPEX_friendly_chopper_pilot	:	{[_unit] execVM "loadouts\full\chopperPilot.sqf"};
						case OPEX_friendly_aircraft_pilot	:	{[_unit] execVM "loadouts\full\aircraftPilot.sqf"};
						case OPEX_friendly_crewman			:	{[_unit] execVM "loadouts\full\crewman.sqf"};
						case OPEX_friendly_diver			:	{[_unit] execVM "loadouts\full\diver.sqf"};
						case OPEX_friendly_assault			:	{[_unit] execVM "loadouts\full\assault.sqf"};
						case OPEX_friendly_radioOperator	:	{[_unit] execVM "loadouts\full\radioOperator.sqf"};
						case OPEX_friendly_droneOperator	:	{[_unit] execVM "loadouts\full\droneOperator.sqf"};
						default									{[_unit] execVM "loadouts\full\rifleman.sqf"};
					};

				*/

				if ((typeOf _unit) == OPEX_friendly_teamLeader) then {[_unit] execVM "loadouts\full\teamLeader.sqf"};
				if ((typeOf _unit) == OPEX_friendly_rifleman) then {[_unit] execVM "loadouts\full\rifleman.sqf"};
				if ((typeOf _unit) == OPEX_friendly_grenadier) then {[_unit] execVM "loadouts\full\grenadier.sqf"};
				if ((typeOf _unit) == OPEX_friendly_MGLight) then {[_unit] execVM "loadouts\full\mgLight.sqf"};
				if ((typeOf _unit) == OPEX_friendly_MGHeavy) then {[_unit] execVM "loadouts\full\mgHeavy.sqf"};
				if ((typeOf _unit) == OPEX_friendly_AT) then {[_unit] execVM "loadouts\full\at.sqf"};
				if ((typeOf _unit) == OPEX_friendly_AA) then {[_unit] execVM "loadouts\full\aa.sqf"};
				if ((typeOf _unit) == OPEX_friendly_ghillie) then {[_unit] execVM "loadouts\full\ghillieSniper.sqf"};
				if ((typeOf _unit) == OPEX_friendly_spotter) then {[_unit] execVM "loadouts\full\ghillieSpotter.sqf"};
				if ((typeOf _unit) == OPEX_friendly_marksman) then {[_unit] execVM "loadouts\full\marksman.sqf"};
				if ((typeOf _unit) == OPEX_friendly_scout) then {[_unit] execVM "loadouts\full\scout.sqf"};
				if ((typeOf _unit) == OPEX_friendly_medic) then {[_unit] execVM "loadouts\full\medic.sqf"};
				if ((typeOf _unit) == OPEX_friendly_repairer) then {[_unit] execVM "loadouts\full\repairer.sqf"};
				if ((typeOf _unit) == OPEX_friendly_sapper) then {[_unit] execVM "loadouts\full\sapper.sqf"};
				if ((typeOf _unit) == OPEX_friendly_ammoAssistant) then {[_unit] execVM "loadouts\full\ammoAssistant.sqf"};
				if ((typeOf _unit) == OPEX_friendly_chopper_pilot) then {[_unit] execVM "loadouts\full\chopperPilot.sqf"};
				if ((typeOf _unit) == OPEX_friendly_aircraft_pilot) then {[_unit] execVM "loadouts\full\aircraftPilot.sqf"};
				if ((typeOf _unit) == OPEX_friendly_crewman) then {[_unit] execVM "loadouts\full\crewman.sqf"};
				if ((typeOf _unit) == OPEX_friendly_diver) then {[_unit] execVM "loadouts\full\diver.sqf"};
				if ((typeOf _unit) == OPEX_friendly_assault) then {[_unit] execVM "loadouts\full\assault.sqf"};
				if ((typeOf _unit) == OPEX_friendly_radioOperator) then {[_unit] execVM "loadouts\full\radioOperator.sqf"};
				if ((typeOf _unit) == OPEX_friendly_droneOperator) then {[_unit] execVM "loadouts\full\droneOperator.sqf"};
				if ((typeOf _unit) == OPEX_friendly_interpret) then {[_unit] execVM "loadouts\full\interpret.sqf"};
			};


		///////////////////////////////////////////////////////////////////////////////////////////////////
		// CIVILIANS
		///////////////////////////////////////////////////////////////////////////////////////////////////

		case (OPEX_civilian_side1) :
			{

				// SETTING PROBABILITIES TO GET GEAR (DEPENDING ON THE WORLD REGION)
				private ["_proba_headgear","_proba_beard","_proba_glasses","_proba_scarf","_proba_vest"];
				switch (OPEX_mapEnemy) do
					{
						case "ULTRA"	:	{_proba_headgear = 50; _proba_beard = 10; _proba_glasses = 25; _proba_scarf = 30; _proba_vest = 0};
						case "ISIS"		:	{_proba_headgear = 50; _proba_beard = 60; _proba_glasses = 10; _proba_scarf = 50; _proba_vest = 0; if (count OPEX_civilian_vests > 0) then {_proba_vest = 70}};
						case "TALIB"	:	{_proba_headgear = 50; _proba_beard = 75; _proba_glasses = 10; _proba_scarf = 90; _proba_vest = 0; if (count OPEX_civilian_vests > 0) then {_proba_vest = 90}};
						case "BOKO"		:	{_proba_headgear = 50; _proba_beard = 75; _proba_glasses = 25; _proba_scarf = 70; _proba_vest = 0; if (count OPEX_civilian_vests > 0) then {_proba_vest = 50}};
						default				{_proba_headgear = 50; _proba_beard = 10; _proba_glasses = 15; _proba_scarf = 25; _proba_vest = 0};
					};

				// ASSIGNING GEAR
				_unit forceAddUniform (selectRandom OPEX_civilian_uniforms);
				[_unit, ""] call BIS_fnc_setUnitInsignia;
				if ((random 100 < _proba_headgear) && (headgear _unit != "")) then {_unit addHeadGear (selectRandom OPEX_civilian_headgears)};
				if ((random 100 < _proba_beard) && (goggles _unit != "") && (count OPEX_civilian_beards > 0)) then {_unit addGoggles (selectRandom OPEX_civilian_beards)};
				if ((random 100 < _proba_scarf) && (goggles _unit != "") && (count OPEX_civilian_scarfs > 0)) then {_unit addGoggles (selectRandom OPEX_civilian_scarfs)};
				if ((random 100 < _proba_glasses) && (goggles _unit != "") && (OPEX_sunHeight > 1) && (overcast < 0.5)) then {_unit addGoggles (selectRandom OPEX_civilian_sunglasses)};
				if ((random 100 < _proba_glasses) && (goggles _unit != "")) then {_unit addGoggles (selectRandom OPEX_civilian_glasses)};
				if ((random 100 < _proba_vest) && (vest _unit != "")) then {_unit addVest (selectRandom OPEX_civilian_vests)};

				// ASSIGNING ITEMS
				private _itemList = OPEX_civilian_items call BIS_fnc_arrayShuffle;
				private _itemsNumber = selectRandom [0,1,2,3];

				for "_i" from 0 to _itemsNumber do {_unit addItem (selectRandom _itemList)};
				if (isClass (configFile >> "CfgPatches" >> "Gemini_items")) then
					{
						if ((selectRandom [true, false, false, false]) && (!("Gemini_passport" in ((items _unit) + (uniformitems _unit) + (assigneditems _unit))))) then {_unit addItem "Gemini_passport"};
						if ((selectRandom [true, false, false, false]) && (!("Gemini_IDcard" in ((items _unit) + (uniformitems _unit) + (assigneditems _unit))))) then {_unit addItem "Gemini_IDcard"};
					};
				if (random 100 > 60) then {_unit linkItem "ItemWatch"};
				if (random 100 > 90) then {_unit linkItem "ItemMap"};
				if (random 100 > 90) then {_unit linkItem "ItemCompass"};
			};

		default {};

	};