// ----------------------------------------------------------------------
// CHECKING IF REQUIRED MODS ARE ENABLED
// ----------------------------------------------------------------------

	waitUntil {!isNil "OPEX_params_ready"};
	if (OPEX_friendly_subFaction != "STR_friendly_subFaction_France") exitWith {[player] execVM "loadouts\full\teamLeader.sqf"};
	if ((!(isClass (configFile >> "CfgPatches" >> "R3F_Uniformes"))) || (!(isClass (configFile >> "CfgPatches" >> "r3f_armes"))) || (!(isClass (configFile >> "CfgPatches" >> "R3F_Retex")))) exitWith {[player] execVM "loadouts\full\teamLeader.sqf"};
// ----------------------------------------------------------------------
// GETTING UNIT
// ----------------------------------------------------------------------

	params ["_unit"];

// ----------------------------------------------------------------------
// REMOVING DEFAULT LOADOUT
// ----------------------------------------------------------------------

	removeAllWeapons _unit;
	removeAllItems _unit;
	removeAllAssignedItems _unit;
	removeUniform _unit;
	removeVest _unit;
	removeBackpack _unit;
	removeHeadgear _unit;
	removeGoggles _unit;
	removeAllContainers _unit;

// ----------------------------------------------------------------------
// ADDING CLOTHES
// ----------------------------------------------------------------------

	// UNIFORM
	switch (OPEX_mapClimate) do
		{
			case default {_unit forceAddUniform "R3F_uniform_apso"};
			case "arid"	 : {_unit forceAddUniform "R3F_uniform_apso_DA"};
			case "polar" : {_unit forceAddUniform "R3F_uniform_F1_SNOW"};
		};

	// VEST
	switch (OPEX_mapClimate) do
		{
			case default {_unit addVest "R3F_veste_ce300"};
			case "arid"	 : {_unit addVest "R3F_veste_TAN"};
			case "polar" : {_unit addVest "R3F_veste_SNOW"};
		};

	// HEADGEAR
	switch (OPEX_mapClimate) do
		{
			case default {_unit addHeadgear "R3F_beret_commando"};
			case "arid"	 : {_unit addHeadgear "R3F_beret_commando"};
			case "polar" : {_unit addHeadgear "R3F_beret_commando"};
		};

	// FACEGEAR
	if (OPEX_sunHeight > 0)
	then {if (isClass (configFile >> "CfgPatches" >> "rhs_weapons")) then {_unit addGoggles "rhs_googles_black"} else {_unit addGoggles "G_Aviator"}}
	else {if (isClass (configFile >> "CfgPatches" >> "rhs_weapons")) then {_unit addItemToUniform "rhs_googles_black"} else {_unit addItemToUniform "G_Aviator"}};


	// BACKPACK
	switch (OPEX_mapClimate) do
		{
			case default {_unit addBackpackGlobal "R3F_sac_moyen_CE"};
			case "arid"	 : {_unit addBackpackGlobal "R3F_sac_moyen_TAN"};
			case "polar" : {_unit addBackpackGlobal "R3F_sac_moyen_SNOW"};
		};
	waitUntil {!isNull backpackContainer _unit};	
	clearAllItemsFromBackpack _unit;
	clearItemCargoGlobal (unitBackpack _unit);

	// INSIGNA
	[_unit] spawn Gemini_fnc_setUnitInsigna;

// ----------------------------------------------------------------------
// ADDING RIFLE
// ----------------------------------------------------------------------

	// RIFLE
	_rifle = "R3F_Famas_G2_HG";
	[_unit, _rifle] call Gemini_fnc_addLoadedWeapon;

	// ADDITIONAL MAGAZINES
	_rifleMagazine = (getArray (configfile >> "CfgWeapons" >> _rifle >> "magazines")) select 0;
	for "_i" from 1 to 3 do {_unit addItemToVest _rifleMagazine};
	for "_i" from 1 to 5 do {_unit addItemToBackpack _rifleMagazine};

	// OPTIC 1
	_rifleOptic = "R3F_J4";
	_compatibleRifleOptics = [_rifle, 0] call Gemini_fnc_getWeaponAccessories;
	if (count _compatibleRifleOptics > 0) then {_unit addPrimaryWeaponItem (selectRandom _compatibleRifleOptics)};

	// OPTIC 2
	_rifleOptic = "R3F_EOTECH";
	_compatibleRifleOptics = [_rifle, 0] call Gemini_fnc_getWeaponAccessories;
	if (_rifleOptic in _compatibleRifleOptics) then {_unit addItemToBackpack _rifleOptic};

	// FLASHLIGHT
	_rifleFlashlight = selectRandom OPEX_friendly_flashlights;
	_compatibleRifleFlashlights = [_rifle, 1] call Gemini_fnc_getWeaponAccessories;
	if (_rifleFlashlight in _compatibleRifleFlashlights) then {_unit addPrimaryWeaponItem _rifleFlashlight};

	// POINTER
	_riflePointer = selectRandom OPEX_friendly_pointers;
	_compatibleRiflePointers = [_rifle, 1] call Gemini_fnc_getWeaponAccessories;
	if (_riflePointer in _compatibleRiflePointers) then {_unit addItemToBackpack _riflePointer};

	// BIPOD
	/*
	_rifleBipod = selectRandom OPEX_friendly_bipods;
	_compatibleRifleBipods = ([_rifle, 3] call Gemini_fnc_getWeaponAccessories) select {_x in OPEX_friendly_bipods};
	if (_rifleBipod in _compatibleRifleBipods) then {_unit addPrimaryWeaponItem _rifleBipod};
	*/

	// SILENCER
	_compatibleRifleSilencers = ([_rifle, 2] call Gemini_fnc_getWeaponAccessories) select {_x in OPEX_friendly_rifleSilencers};
	if (count _compatibleRifleSilencers > 0) then {_unit addItemToBackpack (selectRandom _compatibleRifleSilencers)};

// ----------------------------------------------------------------------
// ADDING HANDGUN
// ----------------------------------------------------------------------

	// HANDGUN
	_handgun = "R3F_PAMAS";
	[_unit, _handgun] call Gemini_fnc_addLoadedWeapon;

	// ADDITIONAL MAGAZINES
	_handgunMagazine = (getArray (configfile >> "CfgWeapons" >> _handgun >> "magazines")) select 0;
	for "_i" from 1 to 1 do {_unit addItemToVest _handgunMagazine};

	// SILENCER
	_handgunSilencer = "muzzle_snds_L";
	_compatibleHandgunSilencers = ([_handgun, 2] call Gemini_fnc_getWeaponAccessories) select {_x in OPEX_friendly_handgunSilencers};
	if (_handgunSilencer in _compatibleHandgunSilencers) then {_unit addItemToBackpack _handgunSilencer};

// ----------------------------------------------------------------------
// ADDING NVG / BINOCULAR / RADIO / MAP / COMPASS / GPS / WATCH
// ----------------------------------------------------------------------

	// NVG
	_unit addItemToBackpack "NVGoggles_OPFOR";

	// BINOCULAR
	_unit addWeapon "R3F_JIM_LR";

	// RADIO
	_unit linkItem (selectRandom OPEX_friendly_radiosShortDistance);

	// MAP
	_unit linkItem "ItemMap";

	// COMPASS
	_unit linkItem "ItemCompass";

	// GPS
	_unit linkItem "ItemGPS";

	// WATCH
	_unit linkItem "ItemWatch";

// ----------------------------------------------------------------------
// ADDING OTHER STUFF
// ----------------------------------------------------------------------

	// HELMET
	switch (OPEX_mapClimate) do
		{
			case default 	{_unit addItemToBackpack "R3F_casqueFS_olive"};
			case "arid"	 : 	{_unit addItemToBackpack "R3F_casqueFS_tan"};
			case "polar" : 	{_unit addItemToBackpack "R3F_casqueFS_SNOW"};
		};

	// CAP
	switch (OPEX_mapClimate) do
		{
			case default 	{_unit addItemToUniform "H_Cap_blk"};
			case "arid"	 : 	{_unit addItemToUniform "H_Cap_tan"};
			case "polar" : 	{_unit addItemToUniform "R3F_bonnet_SNOW"};
		};

	// MEDICAL
	for "_i" from 1 to 1 do {_unit addItemToBackpack OPEX_medical_firstAidKit};

	// EARPLUGS
	if (count OPEX_friendly_earplugs > 0) then {_unit addItemToUniform (selectRandom OPEX_friendly_earplugs)};

	// CABLE TIES
	for "_i" from 1 to 3 do {_unit addItemToUniform (selectRandom OPEX_cableTies)};

	// GRENADES
	for "_i" from 1 to 3 do {_unit addItemToVest (selectRandom OPEX_friendly_handGrenades)};
	for "_i" from 1 to 3 do {_unit addItemToBackpack (selectRandom OPEX_friendly_smokeGrenades_white)};
	for "_i" from 1 to 1 do {_unit addItemToBackpack (selectRandom OPEX_friendly_smokeGrenades_colors)};

	// OTHERS
	for "_i" from 1 to 1 do {_unit addItemToUniform (selectRandom OPEX_friendly_chemlights)};
	for "_i" from 1 to 1 do {_unit addItemToUniform (selectRandom OPEX_friendly_IRs)};
	if (count OPEX_friendly_paintSprays > 0) then {_unit addItemToBackpack (selectRandom OPEX_friendly_paintSprays)};
	if (count OPEX_friendly_advancedGPS > 0) then {_unit addItemToVest (selectRandom OPEX_friendly_advancedGPS)};
	if (count OPEX_friendly_mapTools > 0) then {_unit addItemToVest (selectRandom OPEX_friendly_mapTools)};

	// FOOD
	if (isClass (configFile >> "CfgPatches" >> "Gemini_items")) then
		{
			for "_i" from 1 to 1 do {_unit addItemToBackpack "Gemini_rationMedium"};
			for "_i" from 1 to 1 do {_unit addItemToBackpack "Gemini_bottleMedium"};
		};

// ----------------------------------------------------------------------
// SETTING SKILLS
// ----------------------------------------------------------------------

	_unit setSkill ["commanding", 1];