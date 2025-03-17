// =========================================================================================================
// STARTING SCRIPT
// =========================================================================================================

// =========================================================================================================
// PRIVATIZING LOCAL VARIABLE(S)
// =========================================================================================================

	private
		[
			"_caller",
			"_selectedSupply",
			"_emptyPos",
			"_newCrate",
			"_callersAmount",
			"_crateType"
		];

// =========================================================================================================
// GETTING ARGUMENT(S)
// =========================================================================================================

	_caller = _this select 0;
	_selectedSupply = _this select 1;
	_callersAmount = count (allPlayers - entities "HeadlessClient_F");

// =========================================================================================================
// CHECKING IF REQUEST IS AUTHORISED
// =========================================================================================================

	_emptyPos = [];
	_emptyPos = (position OPEX_deliveryZone) findEmptyPosition [0,5,"B_Heli_Transport_01_F"];
	if (count _emptyPos == 0) exitWith {hint localize "STR_hint_DeliveryZoneEncumbered"};

// =========================================================================================================
// SUPPLYING
// =========================================================================================================

	// GETTING CURRRENT INTEL LEVEL
	private ["_intel"];
	_intel = OPEX_stats_faction select 14;

	private ["_cost"];

	// CHECKING CRATE PRICE & AVAILABLE CREDITS
	if (_selectedSupply == 0) then {_cost = (abs OPEX_cost_weapons)};
	if (_selectedSupply == 1) then {_cost = (abs OPEX_cost_launchers)};
	if (_selectedSupply == 2) then {_cost = (abs OPEX_cost_ammo)};
	if (_selectedSupply == 3) then {_cost = (abs OPEX_cost_grenades)};
	if (_selectedSupply == 4) then {_cost = (abs OPEX_cost_explosives)};
	if (_selectedSupply == 5) then {_cost = (abs OPEX_cost_accessories)};
	if (_selectedSupply == 6) then {_cost = (abs OPEX_cost_clothes)};
	if (_selectedSupply == 7) then {_cost = (abs OPEX_cost_medical)};
	if (_selectedSupply == 8) then {_cost = (abs OPEX_cost_canteenSupplies)};
	if (_intel < _cost) exitWith {hint localize "STR_hint_globalStatsTooLow"};

	// CREATING CRATE
	if (_selectedSupply == 0) then {_crateType = "Box_NATO_Wps_F"};
	if (_selectedSupply == 1) then {_crateType = "Box_NATO_WpsLaunch_F"};
	if (_selectedSupply == 2) then {_crateType = "Box_NATO_Ammo_F"};
	if (_selectedSupply == 3) then {_crateType = "Box_NATO_Grenades_F"};
	if (_selectedSupply == 4) then {_crateType = "Box_NATO_AmmoOrd_F"};
	if (_selectedSupply == 5) then {_crateType = "Box_NATO_Support_F"};
	if (_selectedSupply == 6) then {_crateType = "Box_NATO_Uniforms_F"};
	if (_selectedSupply == 7) then {_crateType = "Box_NATO_Equip_F"};
	if (_selectedSupply == 8) then {_crateType = "Box_IDAP_Equip_F"};
	_newCrate = _crateType createVehicle (position OPEX_deliveryZone);

	// FILLING CRATE
	_newCrate remoteExec ["Gemini_fnc_fillCrate", 2];

	// UPDATING CREDITS
	OPEX_stats_faction set [14, _intel - _cost]; publicVariable "OPEX_stats_faction";
	//[OPEX_friendly_side1, "Base", "str_globalStats_updateBuy", name _caller, _cost, _intel] remoteExec ["Gemini_fnc_globalChat"];