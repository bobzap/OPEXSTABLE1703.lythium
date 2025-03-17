/*
	EXAMPLE :
	[player, "Acts_carFixingWheel", "playMove", {dayTime > 12}] spawn Gemini_fnc_playAnimation;
	[unitA, "AmovPercMstpSnonWnonDnon_exercisePushup", "playMove", {true}] spawn Gemini_fnc_playAnimation;
	[unitA, "AmovPercMstpSnonWnonDnon_exercisePushup", "playMove", {true}] remoteExec ["Gemini_fnc_playAnimation", 0, unitA];
*/


	//if (isDedicated) exitWith {};

// =========================================================================================================
// PRIVATIZING LOCAL VARIABLES
// =========================================================================================================

	private ["_unit", "_animation", "_command", "_condition"];


// =========================================================================================================
// GETTING ARGUMENTS
// =========================================================================================================

	_unit = [_this, 0, player, [objNull]] call BIS_fnc_param; // (OBJECT) unit that plays the animation (default: player)
	_animation = [_this, 1, "", [""]] call BIS_fnc_param; // (STRING) animation name (default: "")
	_command = [_this, 2, "playMove", [""]] call BIS_fnc_param; // (STRING) "playMove" or "switchMove" (default: playMove)
	_condition = [_this, 3, {(!alive (_this select 0)) || (behaviour (_this select 0) != "combat")}, [{}]] call BIS_fnc_param; // (CODE) animation will be repeated as long as the condition define in the code is true (default: {(!alive (_this select 0)) || (behaviour (_this select 0) != "combat")})

// =========================================================================================================
// PLAYING ACTION
// =========================================================================================================

	private ["_position"];
	_position = position _unit;
	_unit setPos _position;
	_unit enableSimulationGlobal true;

	if (_command == "switchMove") then
		{
			while _condition do
				{
					sleep 5;
					_unit switchMove _animation;
					waitUntil {sleep 0.1; animationState _unit != _animation};
					_unit setPos _position;
				};
			_unit switchMove "";
		};

	if (_command == "playMove") then
		{
			while _condition do
				{
					sleep 5;
					_unit playMove _animation;
					waitUntil {sleep 0.1; animationState _unit != _animation};
					_unit setPos _position;
				};
			_unit playMove "";
		};

// =========================================================================================================
// EXITING SCRIPT
// =========================================================================================================

	if (true) exitWith {};