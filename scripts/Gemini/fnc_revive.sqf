waitUntil {!isNil "OPEX_param_medical"};
if (isClass (configFile >> "CfgPatches" >> "ace_medical")) exitWith {};

Gemini_fnc_reviveUnit =
	{
		private _deadUnit = param [0, objNull, [objNull]];
		private _medic = param [1, objNull, [objNull]];

		// GETTING DEAD UNIT DATA
		private _type = typeOf _deadUnit;
		//private _ID = vehicleVarName _deadUnit;
		private _name = name _deadUnit;
		private _face = face _deadUnit;
		private _voice = speaker _deadUnit;
		private _position = getPosATL _deadUnit;
		private _direction = getDir _deadUnit;
		_damages = getAllHitPointsDamage _deadUnit select 2;
		private _speciality = "";
		if (_deadUnit getUnitTrait "medic") then {_speciality = "medic"};
		if (_deadUnit getUnitTrait "engineer") then {_speciality = "engineer"};
		if (_deadUnit getUnitTrait "explosiveSpecialist") then {_speciality = "explosiveSpecialist"};
		if (_deadUnit getUnitTrait "UAVHacker") then {_speciality = "UAVHacker"};
		if (_deadUnit getUnitTrait "interpret") then {_speciality = "interpret"};
		private _needs = [0,0,0];
		if (OPEX_param_primaryNeeds == 1) then
			{
				private _hunger = _deadUnit getVariable ["hunger", 0];
				private _thirst = _deadUnit getVariable ["thirst", 0];
				private _tiredness = _deadUnit getVariable ["tiredness", 0];
			};
		private _loadout = getUnitLoadout _deadUnit;
		private _insigna = [_deadUnit] call BIS_fnc_getUnitInsignia;
		private _weaponsOnTheGround = (_deadUnit nearEntities 5) select {typeOf _x == "WeaponHolderSimulated"};
		private _weapons = [];
		if (count _weaponsOnTheGround > 0) then
			{
				for "_i" from 0 to (count _weaponsOnTheGround - 1) do
					{
						private _weapon = weaponsItemsCargo (((_deadUnit nearEntities 5) select {typeOf _x == "WeaponHolderSimulated"}) select _i) select 0;
						_weapons append [_weapon];
					}
			};

		// DELETING DEAD UNIT;
		deleteVehicle _deadUnit;

		// REVIVING UNIT
		private _revivedUnit = [OPEX_friendly_side1, grpNull, _type, _position, OPEX_friendly_AIskill] call Gemini_fnc_createUnit;

		{_revivedUnit setHitIndex [_forEachIndex, _x - 0.1]} forEach _damages;
		_revivedUnit setDamage 0.9;

		switch _speciality do
			{
				case "medic"				:	{_revivedUnit setUnitTrait ["medic",true]};
				case "engineer"				:	{_revivedUnit setUnitTrait ["engineer",true]};
				case "UAVHacker"			:	{_revivedUnit setUnitTrait ["UAVHacker",true]};
				case "explosiveSpecialist"	:	{_revivedUnit setUnitTrait ["explosiveSpecialist",true]};
				case "medic"				:	{_revivedUnit setUnitTrait ["interpret",true,true]};
				case ""						:	{};
				default							{};
			};
		if (OPEX_param_primaryNeeds == 1) then
			{
				_revivedUnit setVariable ["hunger", _needs select 0];
				_revivedUnit setVariable ["thirst", _needs select 1];
				_revivedUnit setVariable ["tiredness", _needs select 2];
			};
		[_revivedUnit, _name] remoteExec ["setName", 0, _revivedUnit];
		//[_revivedUnit, _ID] remoteExec ["setVehicleVarName", 0, _revivedUnit];
		[_revivedUnit, _face] remoteExec ["setFace", 0, _revivedUnit];
		[_revivedUnit, _voice] remoteExec ["setSpeaker", 0, _revivedUnit];
		removeAllWeapons _revivedUnit;
		removeAllItems _revivedUnit;
		removeAllAssignedItems _revivedUnit;
		removeUniform _revivedUnit;
		removeVest _revivedUnit;
		removeBackpack _revivedUnit;
		removeHeadgear _revivedUnit;
		removeGoggles _revivedUnit;
		removeAllContainers _revivedUnit;
		_revivedUnit setUnitLoadout [_loadout, false];
		[_revivedUnit, _insigna] call BIS_fnc_setUnitInsignia;
		if (count _weapons > 0) then
			{
				{
					[_revivedUnit, (_x select 0)] call Gemini_fnc_addLoadedWeapon;
					_revivedUnit addPrimaryWeaponItem (_x select 1);
					_revivedUnit addPrimaryWeaponItem (_x select 2);
					_revivedUnit addPrimaryWeaponItem (_x select 3);
				} forEach _weapons;
			};
		addSwitchableUnit _revivedUnit;
		_revivedUnit setDir _direction;
		_revivedUnit playMove "DeadState";
		_revivedUnit setPosATL _position;
		_revivedUnit switchMove "AmovPpneMstpSrasWrflDnon_AmovPercMstpSrasWrflDnon";

		private _squad = group _revivedUnit;
		sleep 3;
		while {(count (waypoints _squad)) > 0} do {deleteWaypoint ((waypoints _squad) select 0)};
	};

Gemini_fnc_addReviveAction =
	{
		private _unit = param [0, objNull, [objNull]];
		if ((isMultiplayer) && (isPlayer _unit)) exitWith {};
		//[_unit, "<t color='#FFFFFF'>" + format [localize "STR_action_revive"] + "</t>", "pictures\icon_revive.paa", "pictures\icon_revive.paa", "(!alive _target) && (_target distance2D _this < 2) && (_target getVariable ['revivable',true])", "(OPEX_medical_defibrillator in (items _caller))", {if (!(OPEX_medical_defibrillator in (items _caller))) exitWith {hint format [localize "STR_hint_needDefibrilator", OPEX_medical_defibrillator]}; _caller playAction "medicStartRightSide"}, {}, {_caller playAction "medicStop"; [_target,_caller] spawn Gemini_fnc_reviveUnit}, {if (animationState _caller == "ainvpknlmstpsnonwrfldr_medic0s") then {_caller playAction "medicStop"}}, [], 30, 10, false, true] remoteExec ["BIS_fnc_holdActionAdd", 0, _unit];
		[_unit, ["STR_action_revive", "white"], "pictures\icon_revive.paa", "pictures\icon_revive.paa", "(!alive _target) && (_target distance2D _this < 2) && (_target getVariable ['revivable',true])", "(OPEX_medical_defibrillator in (items _caller))", {if (!(OPEX_medical_defibrillator in (items _caller))) exitWith {hint format [localize "STR_hint_needDefibrilator", OPEX_medical_defibrillator]}; _caller playAction "medicStartRightSide"}, {}, {_this call Gemini_fnc_reviveUnit}, {if (animationState _caller == "ainvpknlmstpsnonwrfldr_medic0s") then {_caller playAction "medicStop"}}, [], 30, 10, false, true, false] remoteExec ["Gemini_fnc_holdActionAdd", 0, _unit];
	};

if (!isDedicated) exitWith {[_this select 0] call Gemini_fnc_addReviveAction};