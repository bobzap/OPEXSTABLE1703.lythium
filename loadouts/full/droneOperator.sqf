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
	_unit addHeadgear (selectRandom OPEX_friendly_caps);

	// BACKPACK
	_unit addBackpackGlobal (selectRandom OPEX_friendly_portableDronesBackpack); waitUntil {!isNull backpackContainer _unit};
	clearAllItemsFromBackpack _unit;
	clearItemCargoGlobal (unitBackpack _unit);

// ----------------------------------------------------------------------
// ADDING RIFLE
// ----------------------------------------------------------------------

	// RIFLE
	_rifle = selectRandom OPEX_friendly_commonRifles;
	[_unit, _rifle] call Gemini_fnc_addLoadedWeapon;

	// ADDITIONAL MAGAZINES
	_rifleMagazine = (getArray (configfile >> "CfgWeapons" >> _rifle >> "magazines")) select 0;
	for "_i" from 1 to 5 do {_unit addItemToVest _rifleMagazine};

	// FLASHLIGHT
	_compatibleRifleFlashlights = ([_rifle, 1] call Gemini_fnc_getWeaponAccessories) select {_x in OPEX_friendly_flashlights};
	if (count _compatibleRifleFlashlights > 0) then {_unit addItemToBackpack (selectRandom _compatibleRifleFlashlights)};

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
	for "_i" from 1 to 1 do {_unit addItemToVest _handgunMagazine};

// ----------------------------------------------------------------------
// ADDING NVG / BINOCULAR / RADIO / MAP / COMPASS / GPS / WATCH
// ----------------------------------------------------------------------

	// BINOCULAR
	_unit addWeapon (selectRandom OPEX_friendly_commonBinoculars);

	// RADIO
	_unit linkItem (selectRandom OPEX_friendly_radiosShortDistance);

	// MAP
	_unit linkItem "ItemMap";

	// COMPASS
	_unit linkItem "ItemCompass";

	// GPS
	_unit linkItem (selectRandom OPEX_friendly_droneTerminals);

	// WATCH
	_unit linkItem "ItemWatch";

// ----------------------------------------------------------------------
// ADDING OTHER STUFF
// ----------------------------------------------------------------------

	// MEDICAL
	for "_i" from 1 to 1 do {_unit addItemToVest OPEX_medical_firstAidKit};

	// EARPLUGS
	if (count OPEX_friendly_earplugs > 0) then {_unit addItemToUniform (selectRandom OPEX_friendly_earplugs)};

	// FOOD
	if (isClass (configFile >> "CfgPatches" >> "Gemini_items")) then
		{
			for "_i" from 1 to 1 do {_unit addItemToVest "Gemini_rationSmall"};
			for "_i" from 1 to 1 do {_unit addItemToVest "Gemini_bottleSmall"};
		};

	// CABLE TIES
	for "_i" from 1 to 3 do {_unit addItemToUniform (selectRandom OPEX_cableTies)};

	// OTHERS
	for "_i" from 1 to 3 do {_unit addItemToUniform (selectRandom OPEX_friendly_chemlights)};
	if (count OPEX_friendly_advancedGPS > 0) then {_unit addItemToVest (selectRandom OPEX_friendly_advancedGPS)};
	if (count OPEX_friendly_mapTools > 0) then {_unit addItemToVest (selectRandom OPEX_friendly_mapTools)};

// ----------------------------------------------------------------------
// SETTING SKILLS
// ----------------------------------------------------------------------

