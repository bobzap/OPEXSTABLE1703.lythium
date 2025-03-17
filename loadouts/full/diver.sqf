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
	_unit forceAddUniform (selectRandom OPEX_friendly_diverUniforms);
	[_unit] spawn Gemini_fnc_setUnitInsigna;
	
	// VEST
	_unit addVest (selectRandom OPEX_friendly_diverVests);
	
	// HEADGEAR
	_unit addHeadgear (selectRandom OPEX_friendly_aircraftPilotHelmets);
	
	// BACKPACK
	_unit addBackpackGlobal (selectRandom OPEX_friendly_diverBackpacks); waitUntil {!isNull backpackContainer _unit};		
	clearAllItemsFromBackpack _unit;
	clearItemCargoGlobal (unitBackpack _unit);
	
	// GLASSES
	_unit addGoggles (selectRandom OPEX_friendly_diverGlasses);

// ----------------------------------------------------------------------
// ADDING RIFLE
// ----------------------------------------------------------------------

	// RIFLE
	_rifle = selectRandom OPEX_friendly_diverRifles;
	[_unit, _rifle] call Gemini_fnc_addLoadedWeapon;

	// ADDITIONAL MAGAZINES
	_rifleMagazine = (getArray (configfile >> "CfgWeapons" >> _rifle >> "magazines")) select 0;
	for "_i" from 1 to 3 do {_unit addItemToBackpack _rifleMagazine};

	// FLASHLIGHT
	_compatibleRifleFlashlights = ([_rifle, 1] call Gemini_fnc_getWeaponAccessories) select {_x in OPEX_friendly_flashlights};
	if (count _compatibleRifleFlashlights > 0) then {if (random 1 > 0.5) then {_unit addPrimaryWeaponItem (selectRandom _compatibleRifleFlashlights)} else {_unit addItemToBackpack (selectRandom _compatibleRifleFlashlights)}};

	// POINTER
	if (random 1 > 0.8) then
		{
		_compatibleRiflePointers = ([_rifle, 1] call Gemini_fnc_getWeaponAccessories) select {_x in OPEX_friendly_pointers};
		if (count _compatibleRiflePointers > 0) then {_unit addPrimaryWeaponItem (selectRandom _compatibleRiflePointers)};
		};

	// SILENCER
	_compatibleRifleSilencers = ([_rifle, 2] call Gemini_fnc_getWeaponAccessories) select {_x in OPEX_friendly_rifleSilencers};
	if (count _compatibleRifleSilencers > 0) then {_unit addItemToBackpack (selectRandom _compatibleRifleSilencers)};

// ----------------------------------------------------------------------
// ADDING HANDGUN
// ----------------------------------------------------------------------

	// HANDGUN
	_handgun = selectRandom OPEX_friendly_specialHandguns;
	[_unit, _handgun] call Gemini_fnc_addLoadedWeapon;

	// ADDITIONAL MAGAZINES
	_handgunMagazine = (getArray (configfile >> "CfgWeapons" >> _handgun >> "magazines")) select 0;
	for "_i" from 1 to 1 do {_unit addItemToUniform _handgunMagazine};

	// SILENCER
	_compatibleHandgunSilencers = ([_handgun, 2] call Gemini_fnc_getWeaponAccessories) select {_x in OPEX_friendly_handgunSilencers};
	if (count _compatibleHandgunSilencers > 0) then {_unit addItemToBackpack (selectRandom _compatibleHandgunSilencers)};

// ----------------------------------------------------------------------
// ADDING NVG / BINOCULAR / RADIO / MAP / COMPASS / GPS / WATCH
// ----------------------------------------------------------------------

	// NVG
	if (random 1 > 0.75) then {_unit linkItem (selectRandom OPEX_friendly_NVGs)} else {_unit addItemToBackpack (selectRandom OPEX_friendly_NVGs)};

	// BINOCULAR
	_unit addWeapon (selectRandom OPEX_friendly_commonBinoculars);

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

	// MEDICAL
	for "_i" from 1 to 1 do {_unit addItemToBackpack OPEX_medical_firstAidKit};

	// EARPLUGS
	if (count OPEX_friendly_earplugs > 0) then {_unit addItemToUniform (selectRandom OPEX_friendly_earplugs)};

	// CHEMLIGHTS
	for "_i" from 1 to 1 do {_unit addItemToBackpack (selectRandom OPEX_friendly_IRs)};
	for "_i" from 1 to 3 do {_unit addItemToBackpack (selectRandom OPEX_friendly_chemlights)};

	// FOOD
	if (isClass (configFile >> "CfgPatches" >> "Gemini_items")) then
		{
			for "_i" from 1 to 1 do {_unit addItemToBackpack "Gemini_rationMedium"};
			for "_i" from 1 to 1 do {_unit addItemToBackpack "Gemini_bottleMedium"};
		};

// ----------------------------------------------------------------------
// SETTING SKILLS
// ----------------------------------------------------------------------

	_unit setSkill ["endurance", 1];
	_unit setSkill ["aimingSpeed", 1];