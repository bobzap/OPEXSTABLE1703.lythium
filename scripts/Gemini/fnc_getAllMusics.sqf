private _cfg = configFile >> "CfgMusic";
private _result = [];

for "_i" from 0 to (count _cfg - 1) do
	{
		private _rec = _cfg select _i;
		if (isClass _rec) then
			{
				_result pushBack
					[
						configName _rec,
						if (isText (_rec >> "name")) then {getText (_rec >> "name")} else {""},
						if (isNumber (_rec >> "duration")) then {getNumber (_rec >> "duration")} else {0}
					]
			}
	};

	//copyToClipboard str _result;
	_result