// PRIVATIZING VARIABLES
	private ["_chair", "_unit", "_animation"];

// GETTING VARIABLES
	_chair = _this select 0;
	_unit = _this select 1;

// TELLING TO EVERYBODY THAT PLAYER IS NOW SITTING ON THE CHAIR
	_unit setVariable ["isSitting", true, true];
	_chair setVariable ["isAvailable", false, true];

// DISABLING R3F LOGISTIC SCRIPTS (TO AVOID IT COULD ME MOVED WHILE SOMEONE IS SITTING ON IT)
	_chair setVariable ["R3F_LOG_disabled", true, true];

// MOVING PLAYER TO CHAIR'S POSITION
	//waitUntil {!isNil "OPEX_serverType"};
	_unit setDir ((getDir _chair) + 180);
	_unit setpos [getpos _chair select 0, getpos _chair select 1, ((getpos _chair select 2) + 0)];

// SELECTING A RANDOM ANIMATION
	_animation =
		selectRandom 
			[
				"HubSittingChairA_idle1",
				"HubSittingChairA_idle2",
				"HubSittingChairA_idle3",
				"HubSittingChairA_move1",
				"HubSittingChairB_idle1",
				"HubSittingChairB_idle2",
				"HubSittingChairB_idle3",
				"HubSittingChairB_move1",
				"HubSittingChairC_idle1",
				"HubSittingChairC_idle2",
				"HubSittingChairC_idle3",
				"HubSittingChairC_move1",
				"HubSittingChairUA_idle1",
				"HubSittingChairUA_idle2",
				"HubSittingChairUA_idle3",
				"HubSittingChairUA_move1",
				"HubSittingChairUB_idle1",
				"HubSittingChairUB_idle2",
				"HubSittingChairUB_idle3",
				"HubSittingChairUB_move1",
				"HubSittingChairUC_idle1",
				"HubSittingChairUC_idle2",
				"HubSittingChairUC_idle3",
				"HubSittingChairUC_move1"
			];

// ATTACHING CHAIR TO PLAYER
_chair attachTo [_unit, [0,0,0.45]];
[_chair, 180] remoteExec ["setDir", 0];
[_chair, (getPos _chair)] remoteExec ["setPos", _chair];
//_chair setDir 180; _chair setPos (getPos _chair);
//if (isMultiplayer) then {{_chair setDir (getDir _unit + 180); _chair setPos (getPos _chair)} remoteExec ["BIS_fnc_call", 2]} else {_chair setDir 180; _chair setPos (getPos _chair)};

// PLAYING ANIMATION
	//_unit switchMove _animation;
	[_unit, _animation] remoteExec ["switchMove", 0, _unit];
	//if (OPEX_debug) then {hint str _animation}; // DEBUG COMMAND

// ADDING ACTION TO ALLOW GETTING UP
	[
		_unit,
		"<t color='#FFFFFF'>" + localize "STR_action_getUp" + "</t>",
		"pictures\icon_stand.paa", "pictures\icon_stand.paa",
		"true", "true",
		{}, {},
		{
				detach (_this select 3 select 0);
				(_this select 3 select 0) setVariable ["R3F_LOG_disabled", false, true];
				(_this select 1) switchMove "";
				(_this select 1) setPos ((_this select 3 select 0) getRelPos [0.25, 90]);
				(_this select 1) removeAction (_this select 2);
				// TELLING TO EVERYBODY THAT THE CHAIR IS NOT OCCUPIED ANYMORE
				(_this select 1) setVariable ["isSitting", false, true];
				(_this select 3 select 0) setVariable ["isAvailable", true, true];
		},
		{}, [_chair], 1, 6, false, false
	] call BIS_fnc_holdActionAdd;

// CHECKING IF CHAIR IS STILL OCCUPIED, IF UNIT STIL EXISTS AND IS STILL ALIVE
	while {(!(_chair getVariable "isAvailable")) && (!isNull _unit) && (alive _unit)} do {sleep 1};

// IF PLAYER STILL EXISTS AND IS NOT ALIVE, STOPPING ANIMATION
	if ((!isNull _unit) && (!alive _unit)) then {_unit switchMove ""};

// TELLING TO EVERYBODY THAT THE CHAIR IS NOT OCCUPIED ANYMORE
	if (!isNull _unit) then {_unit setVariable ["isSitting", false, true]};
	_chair setVariable ["isAvailable", true, true];