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
	_unit forceAddUniform (selectRandom OPEX_press_uniforms);

	// VEST
	_unit addVest (selectRandom OPEX_press_vests);

	// HEADGEAR
	_unit addHeadgear (selectRandom OPEX_press_headgears);

// ----------------------------------------------------------------------
// ADDING MICROPHONE
// ----------------------------------------------------------------------

	//if (count OPEX_press_micros > 0) then {_unit addWeapon (selectRandom OPEX_press_micros)};

// ----------------------------------------------------------------------
// ADDING CAMERA/PHOTO
// ----------------------------------------------------------------------

	if (count (OPEX_press_cameras + OPEX_press_photos) > 0) then {_unit addWeapon (selectRandom (OPEX_press_cameras + OPEX_press_photos))};

// ----------------------------------------------------------------------
// ADDING NVG / BINOCULAR / RADIO / MAP / COMPASS / GPS / WATCH
// ----------------------------------------------------------------------

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

	// FOOD
	if (isClass (configFile >> "CfgPatches" >> "Gemini_items")) then
		{
			for "_i" from 1 to 1 do {_unit addItem "Gemini_rationSmall"};
			for "_i" from 1 to 1 do {_unit addItem "Gemini_bottleSmall"};
		};