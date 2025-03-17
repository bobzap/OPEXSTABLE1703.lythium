if (!(isClass (configFile >> "CfgPatches" >> "Gemini_items"))) exitWith {};

Gemini_fnc_moveMobileRespawnPoint =
	{
		private ["_object", "_unit", "_position"];
		_object = _this select 0;
		_unit = _this select 1;
		_position = position _object;
		if (!isNil "mobileRespawnPoint") then {mobileRespawnPoint call BIS_fnc_removeRespawnPosition};
		mobileRespawnPoint = [missionNamespace, _position, localize "STR_marker_mobileRespawn"] call BIS_fnc_addRespawnPosition;
		publicVariable "mobileRespawnPoint";
		hint localize "STR_hint_respawnPointDeployed";
	};

Gemini_fnc_guardMobileRespawnPoint =
	{
		private ["_object"];
		_object = _this select 0;
		//while {{(!isNull _object) && (_x distance2D _object < 500) && (side _x == OPEX_friendly_side1)} count (allUnits) > 0} do {sleep 5}; // distance limit
		while {(!isNull _object) && (alive _object)} do {sleep 5}; // no limit
		if (!isNull _object) then {if (!isNil "mobileRespawnPoint") then {mobileRespawnPoint call BIS_fnc_removeRespawnPosition; mobileRespawnPoint = nil; publicVariable "mobileRespawnPoint"}};
		sleep 5;
		if (!isNull _object) then {deleteVehicle _object};
	};

Gemini_fnc_unpackRestEquipment =
	{
		private ["_object"];
		_unit = _this select 0;
		_equipmentType = _this select 1;
		_position = _unit modelToWorld [0,3,0];
		if (local _unit) then {_unit playMove "AinvPknlMstpSnonWnonDnon_medicUp3"};
		if (!isServer) exitWith {};
		if (_equipmentType == "tent") then
			{
				sleep 6;
				_object = "Land_TentDome_F" createVehicle _position;
				if (!isMultiplayer) then 
					{
						[_object, ["STR_action_skipTime_1", "white"], "pictures\icon_rest.paa", "pictures\icon_rest.paa", "_target distance2D _this < 3", "true", {}, {}, {_this spawn Gemini_fnc_haveRest}, {}, [1], 1, 6, false, false] remoteExec ["Gemini_fnc_holdActionAdd", 0, _object];
						[_object, ["STR_action_skipTime_3", "white"], "pictures\icon_rest.paa", "pictures\icon_rest.paa", "_target distance2D _this < 3", "true", {}, {}, {_this spawn Gemini_fnc_haveRest}, {}, [3], 1, 6, false, false] remoteExec ["Gemini_fnc_holdActionAdd", 0, _object];
						[_object, ["STR_action_skipTime_6", "white"], "pictures\icon_rest.paa", "pictures\icon_rest.paa", "_target distance2D _this < 3", "true", {}, {}, {_this spawn Gemini_fnc_haveRest}, {}, [6], 1, 6, false, false] remoteExec ["Gemini_fnc_holdActionAdd", 0, _object];
						[_object, ["STR_action_skipTime_9", "white"], "pictures\icon_rest.paa", "pictures\icon_rest.paa", "_target distance2D _this < 3", "true", {}, {}, {_this spawn Gemini_fnc_haveRest}, {}, [9], 1, 6, false, false] remoteExec ["Gemini_fnc_holdActionAdd", 0, _object];
						[_object, ["STR_action_skipTime_12", "white"], "pictures\icon_rest.paa", "pictures\icon_rest.paa", "_target distance2D _this < 3", "true", {}, {}, {_this spawn Gemini_fnc_haveRest}, {}, [12], 1, 6, false, false] remoteExec ["Gemini_fnc_holdActionAdd", 0, _object];
					}
				else
					{
						[_object, ["STR_action_moveMobileRespawn", "white"], "pictures\icon_respawn.paa", "pictures\icon_respawn.paa", "_target distance2D _this < 5", "true", {}, {}, {(_this select 3) call Gemini_fnc_moveMobileRespawnPoint}, {}, [_unit, _equipmentType, _object], 3, 6, false, false] remoteExec ["Gemini_fnc_holdActionAdd", 0, _object];
						[_object, ["STR_action_haveRest", "white"], "pictures\icon_rest.paa", "pictures\icon_rest.paa", "_target distance2D _this < 3", "true", {}, {}, {_this spawn Gemini_fnc_haveRest}, {}, [3], 1, 6, false, false] remoteExec ["Gemini_fnc_holdActionAdd", 0, _object];
						[_object, ["STR_action_skipTime_1", "white"], "pictures\icon_rest.paa", "pictures\icon_rest.paa", "_target distance2D _this < 3", "true", {if ((isMultiplayer) && (((OPEX_param_restManagement == 0) && (serverCommandAvailable "#kick")) || (OPEX_param_restManagement == 1))) then {hint localize "STR_hint_skipTimeWarning"}}, {}, {if ((isMultiplayer) && (((OPEX_param_restManagement == 0) && (serverCommandAvailable "#kick")) || (OPEX_param_restManagement == 1))) then {_this remoteExec ["Gemini_fnc_skipTime"]; hint ""} else {hint localize "STR_hint_adminOnly"}}, {}, [1], 5, 6, false, false] remoteExec ["Gemini_fnc_holdActionAdd", 0, _object];
						[_object, ["STR_action_skipTime_3", "white"], "pictures\icon_rest.paa", "pictures\icon_rest.paa", "_target distance2D _this < 3", "true", {if ((isMultiplayer) && (((OPEX_param_restManagement == 0) && (serverCommandAvailable "#kick")) || (OPEX_param_restManagement == 1))) then {hint localize "STR_hint_skipTimeWarning"}}, {}, {if ((isMultiplayer) && (((OPEX_param_restManagement == 0) && (serverCommandAvailable "#kick")) || (OPEX_param_restManagement == 1))) then {_this remoteExec ["Gemini_fnc_skipTime"]; hint ""} else {hint localize "STR_hint_adminOnly"}}, {}, [3], 5, 6, false, false] remoteExec ["Gemini_fnc_holdActionAdd", 0, _object];
						[_object, ["STR_action_skipTime_6", "white"], "pictures\icon_rest.paa", "pictures\icon_rest.paa", "_target distance2D _this < 3", "true", {if ((isMultiplayer) && (((OPEX_param_restManagement == 0) && (serverCommandAvailable "#kick")) || (OPEX_param_restManagement == 1))) then {hint localize "STR_hint_skipTimeWarning"}}, {}, {if ((isMultiplayer) && (((OPEX_param_restManagement == 0) && (serverCommandAvailable "#kick")) || (OPEX_param_restManagement == 1))) then {_this remoteExec ["Gemini_fnc_skipTime"]; hint ""} else {hint localize "STR_hint_adminOnly"}}, {}, [6], 5, 6, false, false] remoteExec ["Gemini_fnc_holdActionAdd", 0, _object];
						[_object] spawn Gemini_fnc_guardMobileRespawnPoint;
						_object addMPEventHandler
							[
								"MPKilled",
								{
									mobileRespawnPoint call BIS_fnc_removeRespawnPosition;
									mobileRespawnPoint = nil; publicVariable "mobileRespawnPoint";
									0 = [(_this select 0)] spawn {sleep 10; deleteVehicle (_this select 0)};
								}
							];					
					};
			};
		if (_equipmentType == "carpet") then
			{
				sleep 2;
				_object = "Land_Ground_sheet_khaki_F" createVehicle _position;
				if (!isMultiplayer) then 
					{
						[_object, ["STR_action_skipTime_1", "white"], "pictures\icon_rest.paa", "pictures\icon_rest.paa", "_target distance2D _this < 3", "true", {}, {}, {_this spawn Gemini_fnc_haveRest}, {}, [1], 1, 6, false, false] remoteExec ["Gemini_fnc_holdActionAdd", 0, _object];
						[_object, ["STR_action_skipTime_3", "white"], "pictures\icon_rest.paa", "pictures\icon_rest.paa", "_target distance2D _this < 3", "true", {}, {}, {_this spawn Gemini_fnc_haveRest}, {}, [3], 1, 6, false, false] remoteExec ["Gemini_fnc_holdActionAdd", 0, _object];
					}
				else
					{
						[_object, ["STR_action_haveRest", "white"], "pictures\icon_rest.paa", "pictures\icon_rest.paa", "_target distance2D _this < 3", "true", {}, {}, {_this spawn Gemini_fnc_haveRest}, {}, [3], 1, 6, false, false] remoteExec ["Gemini_fnc_holdActionAdd", 0, _object];
						[_object, ["STR_action_skipTime_1", "white"], "pictures\icon_rest.paa", "pictures\icon_rest.paa", "_target distance2D _this < 3", "true", {if ((isMultiplayer) && (((OPEX_param_restManagement == 0) && (serverCommandAvailable "#kick")) || (OPEX_param_restManagement == 1))) then {hint localize "STR_hint_skipTimeWarning"}}, {}, {if ((isMultiplayer) && (((OPEX_param_restManagement == 0) && (serverCommandAvailable "#kick")) || (OPEX_param_restManagement == 1))) then {_this remoteExec ["Gemini_fnc_skipTime"]; hint ""} else {hint localize "STR_hint_adminOnly"}}, {}, [1], 1, 6, false, false] remoteExec ["Gemini_fnc_holdActionAdd", 0, _object];
						[_object, ["STR_action_skipTime_3", "white"], "pictures\icon_rest.paa", "pictures\icon_rest.paa", "_target distance2D _this < 3", "true", {if ((isMultiplayer) && (((OPEX_param_restManagement == 0) && (serverCommandAvailable "#kick")) || (OPEX_param_restManagement == 1))) then {hint localize "STR_hint_skipTimeWarning"}}, {}, {if ((isMultiplayer) && (((OPEX_param_restManagement == 0) && (serverCommandAvailable "#kick")) || (OPEX_param_restManagement == 1))) then {_this remoteExec ["Gemini_fnc_skipTime"]; hint ""} else {hint localize "STR_hint_adminOnly"}}, {}, [3], 1, 6, false, false] remoteExec ["Gemini_fnc_holdActionAdd", 0, _object];
					};
			};
		_object allowDamage false;
		_object setPos _position;
		_object setDir (getDir _object + 180);
		_object setVectorUp (surfaceNormal (position _object));
		_object setVariable ["R3F_LOG_disabled", true, true];
		[_object, ["STR_action_repack", "white"], "pictures\icon_repack.paa", "pictures\icon_repack.paa", "_target distance2D _this < 5", "true", {}, {}, {(_this select 3) remoteExec ["Gemini_fnc_repackRestEquipment", 2]}, {}, [_unit, _equipmentType, _object], 1, 6, false, false] remoteExec ["Gemini_fnc_holdActionAdd", 0, _object];
	};

Gemini_fnc_repackRestEquipment =
	{
		private ["_object", "_newObject"];
		_unit = _this select 0;
		_equipmentType = _this select 1;
		_object = _this select 2;
		_position = position _object;
		if (local _unit) then {_unit playMove "AinvPknlMstpSnonWnonDnon_medicUp3"};
		if (!isServer) exitWith {};
		sleep 2;
		_object allowDamage true;
		_object setDamage 1;
		if (_equipmentType == "tent") then {sleep 6; deleteVehicle _object; _newObject = "GroundWeaponHolder" createVehicle _position; _newObject addMagazineCargoGlobal ["Gemini_portabletent", 1]};
		if (_equipmentType == "carpet") then {sleep 2; deleteVehicle _object; _newObject = "GroundWeaponHolder" createVehicle _position; _newObject addMagazineCargoGlobal ["Gemini_sleepingbag", 1]};
		_newObject setPos _position;
		_newObject setVectorUp (surfaceNormal (position _newObject));
	};

Gemini_fnc_selectRestItem =
	{
		private ["_item", "_unit"];
		_item = _this select 0;
		_unit = _this select 1;
		if (_item in ["Gemini_sleepingbag"]) then {[_unit, "carpet"] remoteExec ["Gemini_fnc_unpackRestEquipment", 0]};
		if (_item in ["Gemini_portabletent"]) then {[_unit, "tent"] remoteExec ["Gemini_fnc_unpackRestEquipment", 0]};
		player removeItem _item;
		closeDialog 0;
	};

Gemini_fnc_useItem =
	{
		private ["_unit"];
		_idc = ctrlIDC (_this select 0);
		_selectedIndex = _this select 1;
		_item = lbData [_idc, _selectedIndex];

		_unit = player;
		if (_item in ["Gemini_passport", "Gemini_IDcard"]) then {_unit = ((position player) nearEntities ["Man", 5]) select 1};
		if (isNil "_unit") exitWith {};

		if (_item in ((items _unit) + (uniformItems _unit) + (backpackItems _unit) + (vestItems _unit))) then
			{
					// ID ITEMS
					if (_item in ["Gemini_passport", "Gemini_IDcard"]) then
						{
							sleep 0.5;
							_unit setVariable ["known_realName", true, true];
							_unit setVariable ["known_realBirthdate", true, true];
							_unit setVariable ["known_realNationality", true, true];
							hint parseText
								(
									"<t size='1' align='right'>"
										+
										localize "STR_dialog_civilianInteractions_conversation_identity" + " : " + ((_unit getVariable "name") select 0)
										+ "<br/>" +
										localize "STR_dialog_civilianInteractions_conversation_nationality" + " : " + localize ((_unit getVariable "nationality") select 0)
										+ "<br/>" +
										localize "STR_dialog_civilianInteractions_conversation_birthdate" + " : " + ((_unit getVariable "birthdate") select 0)
										+
									"</t>"
								);
						};

					// REST ITEMS
					if (_item in ["Gemini_sleepingbag", "Gemini_portabletent"]) then {[_item, _unit] spawn Gemini_fnc_selectRestItem};

					// DRINKING
					if (_item in ["Gemini_bottleSmall", "Gemini_bottleMedium", "Gemini_bottleBig"]) then {[_item] spawn Gemini_fnc_needs_drink};

					// EATING
					if (_item in ["Gemini_rationSmall", "Gemini_rationMedium", "Gemini_rationBig", "Gemini_dattes", "Gemini_banana", "Gemini_fig", "Gemini_apple"]) then {[_item] spawn Gemini_fnc_needs_eat};

					// HEALING
					/*
					private ["_allDamages", "_isInjured"];
					_allDamages = getAllHitPointsDamage _unit select 2;
					_isInjured = ((_allDamages select 0) + (_allDamages select 1) + (_allDamages select 2) + (_allDamages select 3) + (_allDamages select 4) + (_allDamages select 5) + (_allDamages select 6) + (_allDamages select 7) + (_allDamages select 8) + (_allDamages select 9) + (_allDamages select 10) + (_allDamages select 11)) > 0;
					if ((_isInjured) && ((_item == OPEX_medical_firstAidKit) || ((_item in OPEX_medical_medikits) && (_unit getUnitTrait "Medic")))) then
					    {
					    	private ["_damage", "_damages"];
					    	_damage = damage _unit;
					    	_damages = getAllHitPointsDamage _unit;
					    	if (_unit getUnitTrait "Medic")
					    	then
					    		{
					    			if (_damage > 0) then {_unit setDamage (_damage / 4)};
					    			private ["_index"];
					    			_index = 0;
					    			{
					    				if ((_damages select 2 select _index) > 0) then {_unit setHitIndex [_index, (_damages select 2 select _index) / 4]} else {_unit setHitIndex [_index, 0.00]};
										_index = _index + 1;
									} forEach (_damages select 2);
					    		}
					    	else
					    		{
					    			if (_damage > 0) then {_unit setDamage (_damage / 2)};
					    			private ["_index"];
					    			_index = 0;
					    			{
					    				if ((_damages select 2 select _index) > 0) then {_unit setHitIndex [_index, (_damages select 2 select _index) / 2]} else {_unit setHitIndex [_index, 0.00]};
										_index = _index + 1;
									} forEach (_damages select 2);
					    		};
					    	_unit removeItem OPEX_medical_firstAidKit;
							hint localize "STR_hint_autoHealDone";
					    };
					  if ((!_isInjured) && ((_item == OPEX_medical_firstAidKit) || ((_item in OPEX_medical_medikits) && (_unit getUnitTrait "Medic")))) then {hint localize "STR_hint_noInjury";};
					  */
			};
	};


// =================================================
// LOOP
// =================================================

	[] spawn
		{
			while {true} do
				{
					sleep 1;
					waitUntil {!(isNull (findDisplay 602))};
					((findDisplay 602) displayCtrl 638) ctrlSetEventHandler ["LBDblClick", "_this spawn Gemini_fnc_useItem"];
					((findDisplay 602) displayCtrl 633) ctrlSetEventHandler ["LBDblClick", "_this spawn Gemini_fnc_useItem"];
					((findDisplay 602) displayCtrl 619) ctrlSetEventHandler ["LBDblClick", "_this spawn Gemini_fnc_useItem"];
					waitUntil {isNull (findDisplay 602)};
				};
		};