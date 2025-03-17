private ["_civilian"];
_civilian = _this;

// SELECTING A RANDOM ACTIVITY (DEPENDING ON DAYTIME)
private ["_activity"];
if (OPEX_sunHeight > 0) then {_activity = selectRandom ["staying", "moving", "talking"]} else {_activity = selectRandom ["staying", "sitting", "sitting", "sitting"]};

// ACTIVITY 1 : SITTING (AT HOME)
if (_activity == "sitting") then {[_civilian] spawn {sleep 5; (_this select 0) action ["sitDown", (_this select 0)]}};

// ACTIVITY 2 : STAYING (AT HOME OR OUTSIDE)
if (_activity == "staying") then {_civilian setVariable ["OPEX_civilianActivity_isMoving", false, false]; _civilian setVariable ["OPEX_civilianActivity_isTalking", false, false]; if (random 10 > 5) then {private ["_outsidePos"]; _position = ["land", _civilian, 1, 50, 1] call Gemini_fnc_findPos; if (!(_position isEqualTo [0,0,0])) then {_civilian setPos _position}}};

// ACTIVITY 3 : MOVING
if (_activity == "moving") then {_civilian setVariable ["OPEX_civilianActivity_isMoving", true, false]; _civilian setVariable ["OPEX_civilianActivity_isTalking", false, false]; [group _civilian, _civilian, 50] spawn Gemini_fnc_doPatrol};

// ACTIVITY 4 : TALKING
if (_activity == "talking") then
	{
		_civilian setVariable ["OPEX_civilianActivity_isTalking", true, false];
		private ["_nearbyUnits", "_nearbyCivilians"];
		_nearbyUnits = (_civilian nearEntities ["Man", 25]) - [_civilian];
		_nearbyCivilians = [];
		{if ((side _x == civilian) && (alive _x) && (!(_x getVariable "OPEX_civilianActivity_isMoving")) && (!(_x getVariable "OPEX_civilianActivity_isTalking"))) then {_nearbyCivilians append [_x]}} forEach _nearbyUnits;
		if (count _nearbyCivilians > 0) then
			{
				private ["_talker", "_listener"];
				_talker = _civilian;
				_listener = selectRandom _nearbyCivilians;

				// RANDOMLY MOVING OUTSIDE
				private ["_conversationPos"];
				if (random 10 > 5) then {_conversationPos = ["land", _civilian, 10, 50, 1] call Gemini_fnc_findPos; if (!(_conversationPos isEqualTo [0,0,0])) then {_civilian setPos _conversationPos} else {_conversationPos = position _talker}} else {_conversationPos = position _talker};

				// STARTING CONVERSATION
				while {(count (waypoints group _talker)) > 0} do {deleteWaypoint ((waypoints group _talker) select 0)};
				while {(count (waypoints group _listener)) > 0} do {deleteWaypoint ((waypoints group _listener) select 0)};
				_talker setPos _conversationPos;
				[_talker, _listener, [0,1,0], 180] call BIS_fnc_relPosObject;
				_listener setFormDir (getDir _talker + 180);
				{_x setPosATL (getPos _x)} forEach [_talker, _listener];
				private ["_animations"];
				_animations =
					[	"", "", "", "", "",
						"HubBriefing_think",
						"HubBriefing_lookaround1", "HubBriefing_lookaround2",
						"HubBriefing_pointleft", "HubBriefing_pointright",
						"HubBriefing_scratch", "HubBriefing_stretch",
						"HubStandingUC_idle1", "HubStandingUC_idle2", "HubStandingUC_idle3",
						"acts_PointingLeftUnarmed", "acts_PointingLeftUnarmed", "acts_PointingLeftUnarmed", "acts_PointingLeftUnarmed"
					];
				_talker switchMove (selectRandom _animations);
				_listener switchMove (selectRandom _animations);
			};
	};