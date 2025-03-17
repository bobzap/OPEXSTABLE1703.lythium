if (!isMultiplayer) exitWith {};

[
	"Gemini_disableInGameRadio",
	"onEachFrame",
	{
		private ["_allHumans", "_playerSquad_ALL", "_playerSquad_HUMANS"];
		_allHumans = (allPlayers - entities "HeadlessClient_F");
		_playerSquad_ALL = units group player;
		_playerSquad_HUMANS = [];
		{if (_x in _allHumans) then {_playerSquad_HUMANS = _playerSquad_HUMANS + [_x]}} forEach _playerSquad_ALL;
		if (count _playerSquad_ALL == count _playerSquad_HUMANS)
		then {enableRadio false}
		else {enableRadio true}
	}
] call BIS_fnc_addStackedEventHandler;