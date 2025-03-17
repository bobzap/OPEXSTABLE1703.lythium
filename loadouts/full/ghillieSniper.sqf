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
	_unit forceAddUniform (selectRandom OPEX_friendly_ghillieUniforms);
	[_unit] spawn Gemini_fnc_setUnitInsigna;

	// VEST
	_unit addVest (selectRandom OPEX_friendly_shoulderVests);

	// BACKPACK
	_unit addBackpackGlobal (selectRandom OPEX_friendly_mediumBackpacks); waitUntil {!isNull backpackContainer _unit};	
	clearAllItemsFromBackpack _unit;
	clearItemCargoGlobal (unitBackpack _unit);

// ----------------------------------------------------------------------
// ADDING RIFLE
// ----------------------------------------------------------------------

	// RIFLE
	_rifle = selectRandom OPEX_friendly_sniperRifles;
	[_unit, _rifle] call Gemini_fnc_addLoadedWeapon;

	// ADDITIONAL MAGAZINES
	_rifleMagazine = (getArray (configfile >> "CfgWeapons" >> _rifle >> "magazines")) select 0;
	for "_i" from 1 to 3 do {_unit addItemToVest _rifleMagazine};
	for "_i" from 1 to 5 do {_unit addItemToBackpack _rifleMagazine};

	// OPTIC
	_compatibleRifleOptics = ([_rifle, 0] call Gemini_fnc_getWeaponAccessories) select {_x in OPEX_friendly_sniperOptics};
	if (count _compatibleRifleOptics > 0) then {_unit addPrimaryWeaponItem (selectRandom _compatibleRifleOptics)};

	// FLASHLIGHT
	_compatibleRifleFlashlights = ([_rifle, 1] call Gemini_fnc_getWeaponAccessories) select {_x in OPEX_friendly_flashlights};
	if (count _compatibleRifleFlashlights > 0) then {_unit addItemToBackpack (selectRandom _compatibleRifleFlashlights)};

	// POINTER
	_compatibleRiflePointers = ([_rifle, 1] call Gemini_fnc_getWeaponAccessories) select {_x in OPEX_friendly_pointers};
	if (count _compatibleRiflePointers > 0) then {_unit addPrimaryWeaponItem (selectRandom _compatibleRiflePointers)};

	// BIPOD
	_compatibleRifleBipods = ([_rifle, 3] call Gemini_fnc_getWeaponAccessories) select {_x in OPEX_friendly_bipods};
	if (count _compatibleRifleBipods > 0) then {_unit addPrimaryWeaponItem (selectRandom _compatibleRifleBipods)};

	// SILENCER
	_compatibleRifleSilencers = ([_rifle, 2] call Gemini_fnc_getWeaponAccessories) select {_x in OPEX_friendly_rifleSilencers};
	if (count _compatibleRifleSilencers > 0) then {_unit addItemToBackpack (selectRandom _compatibleRifleSilencers)};

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
	if (random 1 > 0.5) then {_unit linkItem (selectRandom OPEX_friendly_NVGs)} else {_unit addItemToBackpack (selectRandom OPEX_friendly_NVGs)};

	// BINOCULAR
	_unit addWeapon (selectRandom OPEX_friendly_spotterBinoculars);

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

	// CABLE TIES
	for "_i" from 1 to 3 do {_unit addItemToUniform (selectRandom OPEX_cableTies)};

	// GRENADES
	for "_i" from 1 to 1 do {_unit addItemToUniform (selectRandom OPEX_friendly_IRs)};
	for "_i" from 1 to 3 do {_unit addItemToVest (selectRandom OPEX_friendly_smokeGrenades_colors)};

	// FOOD
	if (isClass (configFile >> "CfgPatches" >> "Gemini_items")) then
		{
			for "_i" from 1 to 1 do {_unit addItemToBackpack "Gemini_rationMedium"};
			for "_i" from 1 to 1 do {_unit addItemToBackpack "Gemini_bottleMedium"};
		};

	// OTHERS
	if (count OPEX_friendly_sniperPDAs > 0) then {for "_i" from 1 to 1 do {_unit addItemToUniform (selectRandom OPEX_friendly_sniperPDAs)};
	if (count OPEX_friendly_weatherPDAs > 0) then {for "_i" from 1 to 1 do {_unit addItemToUniform (selectRandom OPEX_friendly_weatherPDAs)};
	if (count OPEX_friendly_mapTools > 0) then {for "_i" from 1 to 1 do {_unit addItemToUniform (selectRandom OPEX_friendly_mapTools)};
	if (count OPEX_friendly_rangeCards > 0) then {for "_i" from 1 to 1 do {_unit addItemToUniform (selectRandom OPEX_friendly_rangeCards)};
	if (count OPEX_friendly_advancedGPS > 0) then {for "_i" from 1 to 1 do {_unit addItemToUniform (selectRandom OPEX_friendly_advancedGPS)};
	if (count OPEX_friendly_tripods > 0) then {for "_i" from 1 to 1 do {_unit addItemToBackpack (selectRandom OPEX_friendly_tripods)};


// ----------------------------------------------------------------------
// SETTING SKILLS
// ----------------------------------------------------------------------

	_unit setSkill ["aimingAccuracy", 1];
	_unit setSkill ["aimingSpeed", 0.1];
	_unit setSkill ["aimingShake", 1];
	_unit setSkill ["spotDistance", 1];