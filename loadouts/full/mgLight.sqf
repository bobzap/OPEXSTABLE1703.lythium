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
	_unit forceAddUniform (selectRandom OPEX_friendly_tshirtUniforms);
	[_unit] spawn Gemini_fnc_setUnitInsigna;

	// VEST
	_unit addVest (selectRandom OPEX_friendly_commonVests);

	// HEADGEAR
	_unit addHeadgear (selectRandom (OPEX_friendly_caps + OPEX_friendly_bandanas));

	// BACKPACK
	_unit addBackpackGlobal (selectRandom OPEX_friendly_mediumBackpacks); waitUntil {!isNull backpackContainer _unit};	
	clearAllItemsFromBackpack _unit;
	clearItemCargoGlobal (unitBackpack _unit);

	// GLASSES
	if (random 1 > 0.5) then {_unit addGoggles (selectRandom OPEX_friendly_glasses)};

// ----------------------------------------------------------------------
// ADDING RIFLE
// ----------------------------------------------------------------------

	// RIFLE
	_rifle = selectRandom OPEX_friendly_MGriflesLight;
	[_unit, _rifle] call Gemini_fnc_addLoadedWeapon;

	// ADDITIONAL MAGAZINES
	_rifleMagazine = (getArray (configfile >> "CfgWeapons" >> _rifle >> "magazines")) select 0;
	for "_i" from 1 to 3 do {_unit addItemToBackpack _rifleMagazine};

	// OPTIC
	if (random 1 > 0.5) then
		{
			_compatibleRifleOptics = ([_rifle, 0] call Gemini_fnc_getWeaponAccessories) select {_x in OPEX_friendly_closeCombatOptics};
			if (count _compatibleRifleOptics > 0) then {_unit addPrimaryWeaponItem (selectRandom _compatibleRifleOptics)};
		};

	// FLASHLIGHT
	_compatibleRifleFlashlights = ([_rifle, 1] call Gemini_fnc_getWeaponAccessories) select {_x in OPEX_friendly_flashlights};
	if (count _compatibleRifleFlashlights > 0) then {_unit addItemToBackpack (selectRandom _compatibleRifleFlashlights)};

	// POINTER
	_compatibleRiflePointers = ([_rifle, 1] call Gemini_fnc_getWeaponAccessories) select {_x in OPEX_friendly_pointers};
	if (count _compatibleRiflePointers > 0) then {_unit addPrimaryWeaponItem (selectRandom _compatibleRiflePointers)};

	// BIPOD
	_compatibleRifleBipods = ([_rifle, 3] call Gemini_fnc_getWeaponAccessories) select {_x in OPEX_friendly_bipods};
	if (count _compatibleRifleBipods > 0) then {_unit addPrimaryWeaponItem (selectRandom _compatibleRifleBipods)};

// ----------------------------------------------------------------------
// ADDING HANDGUN
// ----------------------------------------------------------------------

	// HANDGUN
	_handgun = selectRandom OPEX_friendly_commonHandguns;
	[_unit, _handgun] call Gemini_fnc_addLoadedWeapon;

	// ADDITIONAL MAGAZINES
	_handgunMagazine = (getArray (configfile >> "CfgWeapons" >> _handgun >> "magazines")) select 0;
	for "_i" from 1 to 1 do {_unit addItemToVest _handgunMagazine};

// ----------------------------------------------------------------------
// ADDING NVG / BINOCULAR / RADIO / MAP / COMPASS / GPS / WATCH
// ----------------------------------------------------------------------

	// NVG
	_unit addItemToVest (selectRandom OPEX_friendly_NVGs);

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

	// GRENADES
	for "_i" from 1 to 3 do {_unit addItemToVest (selectRandom OPEX_friendly_handGrenades)};

	// MEDICAL
	for "_i" from 1 to 1 do {_unit addItemToBackpack OPEX_medical_firstAidKit};

	// EARPLUGS
	if (count OPEX_friendly_earplugs > 0) then {_unit addItemToUniform (selectRandom OPEX_friendly_earplugs)};

	// CABLE TIES
	for "_i" from 1 to 3 do {_unit addItemToUniform (selectRandom OPEX_cableTies)};

	// FOOD
	if (isClass (configFile >> "CfgPatches" >> "Gemini_items")) then
		{
			for "_i" from 1 to 1 do {_unit addItemToBackpack "Gemini_rationMedium"};
			for "_i" from 1 to 1 do {_unit addItemToBackpack "Gemini_bottleMedium"};
		};

// ----------------------------------------------------------------------
// SETTING SKILLS
// ----------------------------------------------------------------------

	_unit setSkill ["endurance", 0.8];
	_unit setSkill ["spotTime", 0.8];
	_unit setSkill ["aimingShake", 0.5];
	_unit setSkill ["aimingAccuracy", 0.6];
	_unit setSkill ["courage", 0.6];
	_unit setSkill ["reloadSpeed", 0.6];