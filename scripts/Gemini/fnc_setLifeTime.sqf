waitUntil {!isNil "OPEX_params_ready"};
waitUntil {!isNil "OPEX_entities"};
waitUntil {!isNil "OPEX_markers"};

private _entity = param [0, objNull, [objNull, ""]];
private _lifeTime = param [1, "distance", [""]];

switch (typeName _entity) do
	{
		case "OBJECT" :
			{
				switch (_lifeTime) do
					{
						case "distance"		:	{(OPEX_entities select 0) pushBackUnique _entity};
						case "task"			: 	{(OPEX_entities select 1) pushBackUnique _entity};
						case "unlimited"	: 	{(OPEX_entities select 2) pushBackUnique _entity};
						case "hq"			: 	{(OPEX_entities select 3) pushBackUnique _entity};
						default 			 	{(OPEX_entities select 2) pushBackUnique _entity};
					};
				publicVariable "OPEX_entities";
			};
		case "STRING" :
			{
				switch (_lifeTime) do
					{
						case "distance"		:	{(OPEX_markers select 0) pushBackUnique _entity};
						case "task"			: 	{(OPEX_markers select 1) pushBackUnique _entity};
						case "unlimited"	: 	{(OPEX_markers select 2) pushBackUnique _entity};
						case "hq"			:	{(OPEX_markers select 3) pushBackUnique _entity};
						default 			 	{(OPEX_markers select 2) pushBackUnique _entity};
					};
				publicVariable "OPEX_markers";
			};
	};

