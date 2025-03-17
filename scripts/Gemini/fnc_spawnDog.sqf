private _master = param [0, objNull, [objNull]];
private _mission = param [1, "guardian", [""]];

// SPAWNING DOG
private _dogs = ["Alsatian_Black_F","Alsatian_Sandblack_F","Alsatian_Sandblack_F"];
//private _dog = createAgent [selectRandom _dogs, position _master, [], 0, "NONE"];
private _dog = (group _master) createUnit [(selectRandom _dogs), position _master, [], 0, "CAN_COLLIDE"];
private _position = _master getRelPos [1.5, 45];
_dog setDir (getDir _master);
_dog setPos [_position select 0, _position select 1, 0];
_dog allowDamage false;

// DISABLING DOG BEHAVIOUR
_dog setVariable ["BIS_fnc_animalBehaviour_disable", true];

// INITIALIZING DYNAMIC SIMULATION
_dog enableDynamicSimulation true;

// FOLLOWING MASTER

switch _mission do
	{
		case "guardian":
			{
				[_dog, _master] spawn
					{
						params ["_dog", "_master"];
						_dog playMove "Dog_Sit";
						_dog disableAI "move";
						while {sleep 1; (alive _dog && alive _master)} do
						{
							sleep 30 + (random 30);
							_soundPath = [str missionConfigFile, 0, -15] call BIS_fnc_trimString;
							_soundToPlay = _soundPath + (selectRandom ["sounds\sfx\dog_bark1.ogg","sounds\sfx\dog_bark2.ogg","sounds\sfx\dog_bark3.ogg","sounds\sfx\dog_pant.ogg","sounds\sfx\dog_whimper.ogg"]);
							private _volume = 3;
							if ("bark" in _soundToPlay) then {_volume = 5} else {_volume = 2};
							playSound3D [_soundToPlay, _dog, false, getPos _dog, _volume, 1, 25];
						};
					};
			};

		case "follow":
			{
				[_dog, _master] spawn
					{
						params ["_dog", "_master"];
						while {sleep 3; (alive _dog && alive _master)} do
							{
								_dogDestination = _master getRelPos [9, 0];
								if ((_dog distance _dogDestination < 3) && (speed _master < 1)) then {_dog playMove "Dog_Sit"};
								if ((_dog distance _dogDestination < 3) && (speed _master > 1)) then {_dog playMove "Dog_Stop"};
								if ((_dog distance _dogDestination > 3) && (_dog distance _dogDestination < 6)) then {_dog playMove "Dog_Walk"; _dog moveTo _dogDestination};
								if ((_dog distance _dogDestination > 6) && (_dog distance _dogDestination < 9)) then {_dog playMove "Dog_Run"; _dog moveTo _dogDestination};
								if (_dog distance _dogDestination > 9) then {_dog playMove "Dog_Sprint"; _dog moveTo _dogDestination; if (random 100 > 75) then {playSound3D [([str missionConfigFile, 0, -15] call BIS_fnc_trimString) + (selectRandom ["sounds\sfx\dog_bark1.ogg","sounds\sfx\dog_bark2.ogg","sounds\sfx\dog_bark3.ogg"]), _dog, false, getPos _dog, 5, 1, 25]}};
							};
						if (alive _dog) && (!alive _master) then {_dog playMove "Dog_Sit"};
					};
			};

		default
			{
				_dog playMove "Dog_Sit";
				_dog disableAI "move";
			};
	};