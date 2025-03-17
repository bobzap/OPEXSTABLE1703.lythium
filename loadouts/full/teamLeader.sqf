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
	_unit forceAddUniform (selectRandom (OPEX_friendly_commonUniforms + OPEX_friendly_specialUniforms));
	[_unit] spawn Gemini_fnc_setUnitInsigna;

	// VEST
	_unit addVest (selectRandom (OPEX_friendly_commonVests + OPEX_friendly_specialVests));

	// HEADGEAR
	_unit addHeadgear (selectRandom OPEX_friendly_leaderHeadgear);

	// BACKPACK
	_unit addBackpackGlobal (selectRandom OPEX_friendly_mediumBackpacks); waitUntil {!isNull backpackContainer _unit};	
	clearAllItemsFromBackpack _unit;
	clearItemCargoGlobal (unitBackpack _unit);

	// GLASSES
	if ((OPEX_sunHeight > 0) && (random 100 < 50)) then {_unit addGoggles (selectRandom OPEX_friendly_sunglasses)};

// ----------------------------------------------------------------------
// ADDING RIFLE
// ----------------------------------------------------------------------

	// RIFLE
	_rifle = selectRandom OPEX_friendly_specialRifles;
	[_unit, _rifle] call Gemini_fnc_addLoadedWeapon;

	// ADDITIONAL MAGAZINES
	_rifleMagazine = (getArray (configfile >> "CfgWeapons" >> _rifle >> "magazines")) select 0;
	for "_i" from 1 to 3 do {_unit addItemToVest _rifleMagazine};
	for "_i" from 1 to 5 do {_unit addItemToBackpack _rifleMagazine};

	// OPTIC 1
	_compatibleRifleOptics = ([_rifle, 0] call Gemini_fnc_getWeaponAccessories) select {_x in OPEX_friendly_distantCombatOptics};
	if (count _compatibleRifleOptics > 0) then {_unit addPrimaryWeaponItem (selectRandom _compatibleRifleOptics)};

	// OPTIC 2
	_compatibleRifleOptics = ([_rifle, 0] call Gemini_fnc_getWeaponAccessories) select {_x in OPEX_friendly_closeCombatOptics};
	if (count _compatibleRifleOptics > 0) then {_unit addItemToBackpack (selectRandom _compatibleRifleOptics)};

	// FLASHLIGHT
	_compatibleRifleFlashlights = ([_rifle, 1] call Gemini_fnc_getWeaponAccessories) select {_x in OPEX_friendly_flashlights};
	if (count _compatibleRifleFlashlights > 0) then {_unit addPrimaryWeaponItem (selectRandom _compatibleRifleFlashlights)};

	// POINTER
	_compatibleRiflePointers = ([_rifle, 1] call Gemini_fnc_getWeaponAccessories) select {_x in OPEX_friendly_pointers};
	if (count _compatibleRiflePointers > 0) then {_unit addItemToBackpack (selectRandom _compatibleRiflePointers)};

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
	_handgun = selectRandom OPEX_friendly_specialHandguns;
	[_unit, _handgun] call Gemini_fnc_addLoadedWeapon;

	// ADDITIONAL MAGAZINES
	_handgunMagazine = (getArray (configfile >> "CfgWeapons" >> _handgun >> "magazines")) select 0;
	for "_i" from 1 to 1 do {_unit addItemToVest _handgunMagazine};

	// SILENCER
	_compatibleHandgunSilencers = ([_handgun, 2] call Gemini_fnc_getWeaponAccessories) select {_x in OPEX_friendly_handgunSilencers};
	if (count _compatibleHandgunSilencers > 0) then {_unit addItemToBackpack (selectRandom _compatibleHandgunSilencers)};

// ----------------------------------------------------------------------
// ADDING NVG / BINOCULAR / RADIO / MAP / COMPASS / GPS / WATCH
// ----------------------------------------------------------------------

	// NVG
	_unit addItemToBackpack (selectRandom OPEX_friendly_NVGs);

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

	// FOOD
	if (isClass (configFile >> "CfgPatches" >> "Gemini_items")) then
		{
			for "_i" from 1 to 1 do {_unit addItemToBackpack "Gemini_rationMedium"};
			for "_i" from 1 to 1 do {_unit addItemToBackpack "Gemini_bottleMedium"};
		};

	// CABLE TIES
	for "_i" from 1 to 3 do {_unit addItemToUniform (selectRandom OPEX_cableTies)};

	// GRENADES
	for "_i" from 1 to 3 do {_unit addItemToVest (selectRandom OPEX_friendly_handGrenades)};
	for "_i" from 1 to 3 do {_unit addItemToVest (selectRandom OPEX_friendly_smokeGrenades_white)};
	for "_i" from 1 to 1 do {_unit addItemToVest (selectRandom OPEX_friendly_smokeGrenades_colors)};

	// OTHERS
	for "_i" from 1 to 1 do {_unit addItemToUniform (selectRandom OPEX_friendly_chemlights)};
	if (count OPEX_friendly_advancedGPS > 0) then {_unit addItemToVest (selectRandom OPEX_friendly_advancedGPS)};
	if (count OPEX_friendly_mapTools > 0) then {_unit addItemToVest (selectRandom OPEX_friendly_mapTools)};
	for "_i" from 1 to 1 do {_unit addItemToBackpack (selectRandom OPEX_friendly_specialHelmets)};

// ----------------------------------------------------------------------
// SETTING SKILLS
// ----------------------------------------------------------------------

	_unit setSkill ["commanding", 1];