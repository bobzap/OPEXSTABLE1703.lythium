/*
	to call this function, create a trigger with these parameters:
		(condition)			true
		(on activation)		0 = thisTrigger execVM "scripts\Gemini\fnc_fitness.sqf"
*/

if (isDedicated) exitWith {};
waitUntil {!isNil "OPEX_params_ready"};

while {true} do
	{
		sleep 1;
		if (player inArea _this)
			then {if (!(player getVariable ["canFitness", false])) then {player setVariable ["canFitness", true]}}
			else {if (player getVariable ["canFitness", true]) then {player setVariable ["canFitness", false]}}
	};