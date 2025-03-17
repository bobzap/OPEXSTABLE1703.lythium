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
	_unit forceAddUniform (selectRandom OPEX_friendly_medicUniforms);
	[_unit] spawn Gemini_fnc_setUnitInsigna;

	// VEST
	_unit addVest (selectRandom OPEX_friendly_medicVests);

	// HEADGEAR
	_unit addHeadgear (selectRandom (OPEX_friendly_commonHelmets + OPEX_friendly_hats + OPEX_friendly_bandanas));

	// BACKPACK
	_unit addBackpackGlobal (selectRandom OPEX_friendly_medicBackpacks); waitUntil {!isNull backpackContainer _unit};
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
	if (count _compatibleRifleFlashlights > 0) then {if (random 1 > 0.5) then {_unit addPrimaryWeaponItem (selectRandom _compatibleRifleFlashlights)} else {_unit addItemToVest (selectRandom _compatibleRifleFlashlights)}};

	// SILENCER
	_compatibleRifleSilencers = ([_rifle, 2] call Gemini_fnc_getWeaponAccessories) select {_x in OPEX_friendly_rifleSilencers};
	if (count _compatibleRifleSilencers > 0) then {_unit addItemToBackpack (selectRandom _compatibleRifleSilencers)};

// ----------------------------------------------------------------------
// ADDING HANDGUN
// ----------------------------------------------------------------------

	// HANDGUN
	_handgun = selectRandom OPEX_friendly_commonHandguns;
	[_unit, _handgun] call Gemini_fnc_addLoadedWeapon;

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

	// EARPLUGS
	if (count OPEX_friendly_earplugs > 0) then {_unit addItemToUniform (selectRandom OPEX_friendly_earplugs)};

	// GRENADES
	for "_i" from 1 to 1 do {_unit addItemToVest (selectRandom OPEX_friendly_smokeGrenades_white)};

	// CHEMLIGHTS
	for "_i" from 1 to 3 do {_unit addItemToUniform (selectRandom OPEX_friendly_chemlights)};

	// FOOD
	if (isClass (configFile >> "CfgPatches" >> "Gemini_items")) then
		{
			for "_i" from 1 to 1 do {_unit addItemToBackpack "Gemini_rationSmall"};
			for "_i" from 1 to 1 do {_unit addItemToBackpack "Gemini_bottleSmall"};
		};

	// MEDICAL
	for "_i" from 1 to 1 do {_unit addItemToBackpack OPEX_medical_defibrillator};
	if (!(OPEX_medical_defibrillator in OPEX_medical_medikits)) then {for "_i" from 1 to 1 do {_unit addItemToBackpack (selectRandom OPEX_medical_medikits)}};
	for "_i" from 1 to 3 do {_unit addItemToVest OPEX_medical_firstAidKit};
	if (count OPEX_medical_commonSupplies > 0) then {private ["_index"]; for "_i" from 1 to 2 do {_index = 0; for "_index" from 0 to (count OPEX_medical_commonSupplies - 1) do {_unit addItemToBackpack (OPEX_medical_commonSupplies select _index); _index = _index + 1}}};
	if (count OPEX_medical_advancedSupplies > 0) then {private ["_index"]; for "_i" from 1 to 1 do {_index = 0; for "_index" from 0 to (count OPEX_medical_advancedSupplies - 1) do {_unit addItemToBackpack (OPEX_medical_advancedSupplies select _index); _index = _index + 1}}};

// ----------------------------------------------------------------------
// SETTING SKILLS
// ----------------------------------------------------------------------

	_unit setSkill ["courage", 1];