// =========================================================================================================
// TASK ID : 			FATA_01 (exclusive mission for FATA map - it works only on this map !)
// TASK OBJECTIVE :		CLEAR ENEMY HIDEOUTS
// TASK CREATOR : 		GEMINI (gemini.69@free.fr)
// =========================================================================================================

	if (worldName != "fata") exitWith {hint "THIS TASK CAN BE RUNNED ON FATA MAP ONLY !!!"};

// =========================================================================================================
// STARTING TASK CREATION
// =========================================================================================================

	private _unit = player;
	["hint", "STR_hint_creatingTask"] remoteExec ["Gemini_fnc_globalHint", _unit];

// =========================================================================================================
// CREATING TASK ON THE SERVER
// =========================================================================================================

	if (!isServer) exitWith {};

// =========================================================================================================
// GETTING MAIN VARIABLES
// =========================================================================================================

	private _debug = OPEX_debug;
	OPEX_taskID = _this select 0; publicVariable "OPEX_taskID";
	OPEX_assignedTask = true; publicVariable "OPEX_assignedTask";
	cave1_cleared = false; publicVariable "cave1_cleared";
	cave2_cleared = false; publicVariable "cave2_cleared";
	cave3_cleared = false; publicVariable "cave3_cleared";
	cave1_visited = false; publicVariable "cave1_visited";
	cave2_visited = false; publicVariable "cave2_visited";
	cave3_visited = false; publicVariable "cave3_visited";

// =========================================================================================================
// DEFINING TASK POSITION(S)
// =========================================================================================================

	// CAVE 1 (GRID 064-053)
		private _cave1_positions =
			[
				// INSIDE CAVE
					[6444.2,5296.72,5.26314],
					[6441.02,5309.87,4.94285],
					[6443.06,5308.9,4.86167],
					[6441.65,5304.44,5.46062],
					[6442.58,5300.28,6.13596],
					[6440.36,5297.67,2.70774],
					[6443.45,5296.69,5.21272],
					[6443.79,5302.34,5.68257],

				// OUTSIDE CAVE
					[6441.4,5289.29,0.00173187],
					[6446.6,5287.94,0.00172424],
					[6447.64,5292.83,0.708878],
					[6453.9,5296.68,0.00132751],
					[6449.89,5306.28,0.00193787],
					[6445.01,5302.38,12.4039],
					[6431.13,5298.17,0.00124359],
					[6422.79,5301.08,0.00139618],
					[6430.27,5284.57,0.00150299]
			];

	// CAVE 2 (GRID 056-042)
		private _cave2_positions =
			[
				// INSIDE CAVE
					[5697.81,4258.89,0.00274658],
					[5700.2,4257.04,0.0015564],
					[5702.34,4254.71,0.000869751],
					[5710.41,4251.86,0.00256348],
				// OUTSIDE CAVE
					[5692.21,4260.94,4.57764e-005],
					[5698.4,4265.52,0.268402],
					[5678.94,4265.42,0.000137329],
					[5706.7,4240.42,1.20323],
					[5694.98,4240.93,0.000579834]
			];

	// CAVE 3 (GRID 056-047)
		private _cave3_positions =
			[
				// INSIDE CAVE
					[5675.5,4772.2,0.00136566],
					[5672.1,4773.11,0.000930786],
					[5674.05,4777.02,0.00252533],
					[5679.69,4774.84,0.00133514],
					[5681.48,4776.95,0.00204468],
					[5671.14,4768.32,0.000831604],
					[5683.88,4771.47,0.00138092],
				// OUTSIDE CAVE
					[5671.51,4764.17,0.000312805],
					[5669.1,4747.69,0.00144196],
					[5639.7,4764.84,0.00183105],
					[5688.24,4769.47,0.00176239],
					[5687.21,4765.83,0.00242615],
					[5689.07,4767.07,0.00286102],
					[5702.28,4783.82,0.00241089],
					[5675.31,4802.3,0.0016098],
					[5657.53,4796.93,0.00175476]

			];

	// CAVE 4 (GRID 059-046)
		private _cave4_positions =
			[
				// INSIDE CAVE
					[5970.84,4619.94,0.00106812],
					[5975.42,4625.43,0.000915527],
					[5977.31,4629.44,9.15527e-005],
					[5973.01,4620.84,0.00352478],
					[5968.24,4617.01,0.00111389],
					[5968.97,4611.45,0.00198364],
					[5965.7,4611.54,0.00146484],
					[5965.6,4607.22,0.00114441],
				// OUTSIDE CAVE
					[5965.6,4600.68,0.00294495],
					[5954.46,4601.96,0.000366211],
					[5954.17,4577.73,0.00135803],
					[5979.09,4598.6,2.87848],
					[5982.69,4610.94,0.267075],
					[5971.71,4617.82,5.87886],
					[5956.84,4621.03,0.000595093],
					[5931.18,4599.63,0.0014801]
			];

	// CAVE 5 (GRID 066-043)
		private _cave5_positions =
			[
				// INSIDE CAVE
					[6654.28,4301.01,0.321022],
					[6626.87,4341.12,0.367455],
					[6636,4341.84,0.0986862],
					[6644.91,4330.48,0.313011],
					[6645.97,4323.77,0.234596],
					[6646.26,4317.75,0.21241],
					[6641.27,4316.92,0.274269],
					[6639.66,4319.48,0.269127],
					[6637.6,4321.74,0.16745],
					[6648.53,4321.2,0.234459],
					[6651.24,4321.62,0.172722],
					[6657.37,4323.82,0.232338],
					[6655.84,4327.3,0.211517],
					[6660.65,4328.38,0.190109],
					[6664.93,4333.1,0.315025],
					[6668.27,4326.74,0.216843],
					[6677.25,4330.55,0.684845],
					[6676.58,4332.93,0.331863],
					[6675.41,4337.88,0.912216],
					[6681.25,4323.25,0.783249],
					[6678.54,4315.14,0.210091],
					[6669.45,4308.96,0.0518875],
					[6668.46,4301.48,0.871185],
					[6671.35,4294.92,0.397224],
					[6663.85,4292.06,0.288597],
					[6654.2,4291.18,0.200745],
					[6653.84,4297,0.356598],
					[6649.7,4297.65,0.238358],
					[6657.16,4303.22,0.30751],
					[6654.35,4309.33,0.376488],
					[6646.31,4304.44,0.200745],
					[6657.23,4290,0.179314],
					[6656.38,4285.44,0.240517],
					[6657.21,4282.92,0.204742],
					[6657.73,4276.46,0.44886],
					[6660.83,4279.07,0.141556],
					[6661.21,4286.11,0.18399],
					[6666.96,4279.99,0.223061],
					[6646.85,4285.86,0.193268],
					[6642.84,4283.41,0.275017],
					[6668.9,4272.04,0.134338],
					[6671.59,4265.55,0.242935],
					[6675.87,4258.41,0.532028],
					[6678.56,4251.06,0.538055],
				// OUTSIDE CAVE
					[6675.31,4244.62,0.00163269],
					[6684.32,4243.61,0.00172424],
					[6663.93,4244.76,0.00038147],
					[6673,4235.09,0.00130463],
					[6692.58,4259.5,0.000770569],
					[6683.5,4253.03,2.50149],
					[6650.49,4253.68,0.00187683],
					[6614.86,4340.98,0.00204468],
					[6613.68,4335.67,0.00123596],
					[6618.39,4346.53,0.00161743],
					[6620.55,4317.77,0.00174713],
					[6602.57,4334.16,0.00152588],
					[6609.63,4319.72,0.0019989],
					[6649.91,4347.82,0.00145721],
					[6657.54,4359.64,0.00125885],
					[6668.66,4356.34,0.00161743]
			];

	// CAVE 6 (GRID 065-043)
		private _cave6_positions =
			[
				// INSIDE CAVE
					[6583.94,4397.41,0.123749],
					[6580.21,4399.92,1.08984],
					[6577.63,4401.69,0.00198364],
					[6584.76,4392.04,0.00131226],
					[6582.85,4389.47,0.00133514],
					[6584.24,4386.02,0.00163269],
					[6585.02,4406.99,0.00318146],
					[6585.01,4410.51,0.00063324],
					[6571.55,4401.44,0.0019455],
					[6565.75,4400.63,0.0027771],
					[6578.26,4406.24,-0.000747681],

				// OUTSIDE CAVE
					[6557.22,4401.44,0.00125885],
					[6559.28,4409.82,0.00246429],
					[6554.96,4411.06,0.000801086],
					[6549.4,4409.43,0.00164032],
					[6548.46,4417.91,0.00087738],
					[6562.76,4411.78,1.8468],
					[6588.57,4414.68,0.00167084],
					[6582.89,4422.93,0.00191498],
					[6572.89,4416.38,0.00182343],
					[6593.87,4413.4,0.00153351],
					[6596.81,4404.63,0.00172424],
					[6590.04,4378.52,0.00172424],
					[6600.51,4376.1,0.533165],
					[6600.74,4381.32,2.23387],
					[6617.21,4349.96,0.00235748],
					[6588.23,4361.66,2.50426],
					[6580.07,4371.27,2.14378],
					[6546.02,4391.6,0.000518799]
			];

	// CAVE 7 (GRID 051-030)
		private _cave7_positions =
			[
				// INSIDE CAVE
					[5707.25,3555.68,0.15152],
					[5705.43,3555.77,0.138016],
					[5704.26,3558.16,0.00119019],
					[5706.85,3559.47,0.0290375],
					[5703.01,3552.34,0.00320435],
					[5701.98,3562.59,0.000717163],
					[5696.84,3565.9,0.00190735],
					[5696.25,3572.9,0.000488281],
					[5693.33,3572.85,0.00205994],
				// OUTSIDE CAVE
					[5693.33,3572.85,0.00205994],
					[5681.01,3577.79,0.00161743],
					[5686.48,3593.69,0.00141907],
					[5703.33,3578.26,0.0017395],
					[5711.34,3572.49,0.00134277],
					[5728.88,3560.47,0.00154114],
					[5714.23,3536.07,0.00115967],
					[5694.38,3546.68,0.00126648],
					[5702.86,3557.4,10.8547]
			];

	// CAVE 8 (GRID )
		private _cave8_positions =
			[
				// INSIDE CAVE
					[5160.64,3080.92,0.00132751],
					[5160.73,3083.24,0.000686646],
					[5156.63,3083.33,0.00119019],
					[5153.61,3080.54,0.00198364],
					[5151.8,3082.95,0.00109863],
					[5149.84,3079.29,0.139328],
					[5142.41,3084.66,0.000717163],
					[5144.38,3080.67,0.00062561],
					[5145.43,3077.01,0.0010376],
					[5148.09,3082.62,0.000961304],
					[5144.48,3077.39,0.00143433],
					[5153.27,3084.82,0.00166321],
				// OUTSIDE CAVE
					[5140,3075.54,0.00137329],
					[5138.65,3078.56,0.00193787],
					[5138.67,3086.78,0.0018158],
					[5133.98,3084.04,0.00196838],
					[5136,3075.63,0.00169373],
					[5129.08,3075.56,0.00160217],
					[5122.48,3083.95,0.00144958],
					[5123.26,3063.95,0.00117493],
					[5112.46,3081.85,0.000900269],
					[5154.72,3066.73,0.00140381],
					[5181.39,3061.68,0.00131226],
					[5190.78,3078.83,0.00115967],
					[5199.82,3081.84,0.00120544],
					[5193.52,3097.89,0.000823975],
					[5171.35,3099.56,0.001297],
					[5153.7,3105.17,0.0010376],
					[5124.48,3090.84,0.0018158] ,
					[5162.73,3077.47,6.68719],
					[5146.59,3078.62,6.798]
			];

	// CAVE 9 (GRID )
		private _cave9_positions =
			[
				// INSIDE CAVE
				[6513.06,2937.43,0.0022583],
				[6511.81,2934.28,0.00143433],
				[6516.26,2939.52,0.000579834],
				[6511.35,2938.63,0.00189209],
				[6507.47,2940.72,0.000579834],
				[6506.26,2937.4,0.00219727],
				[6506.82,2933.99,0.00192261],
				[6504.07,2941.91,0.000793457],
				[6499.75,2941.49,0.00106812],
				[6501.64,2933.01,0.00222778],
				[6497.57,2934.12,0.00189209],
				[6497.09,2943.17,0.0015564],
				// OUTSIDE CAVE
				[6491.77,2943.74,0.00125122],
				[6487.69,2938.21,0.00167847],
				[6483.68,2945.6,0.00167847],
				[6478.57,2939.39,0.00167847],
				[6469.22,2950.06,0.00177002],
				[6479.88,2930.16,0.00210571],
				[6492.98,2924.41,0.00222778],
				[6483.39,2932.58,0.00219727],
				[6512.12,2916.6,0.00180054],
				[6538.68,2927.11,0.00180054],
				[6543.72,2936.7,0.00137329],
				[6554.72,2947.91,0.00115967],
				[6539.96,2954.94,0.0010376],
				[6529.43,2972.66,0.00241089],
				[6502.22,2958.93,0.00143433],
				[6486.58,2961.09,0.00131226],
				[6454.02,2963.06,0.00125122],
				[6509.3,2921.75,2.27805],
				[6532.26,2931.43,3.87378],
				[6488.76,2950.5,0.00189209]

			];

// =========================================================================================================
// SELECTING 3 RANDOM CACHES
// =========================================================================================================

	private _allCaves = [_cave1_positions, _cave2_positions, _cave3_positions, _cave4_positions, _cave5_positions, _cave6_positions, _cave7_positions, _cave8_positions, _cave9_positions];
	private _allCaves = _allCaves call BIS_fnc_arrayShuffle;
	private _selectedCaves = [];
	_selectedCaves = _selectedCaves + [_allCaves select 0];
	_selectedCaves = _selectedCaves + [_allCaves select 1];
	_selectedCaves = _selectedCaves + [_allCaves select 2];

// =========================================================================================================
// SPAWNING ENEMIES
// =========================================================================================================

	// CAVE 1
		if ((_cave1_positions in _selectedCaves) && (random 10 > 2)) then
			{
				private ["_maxPos", "_posIndex", "_unit", "_nearbyUnits"];

				// CREATING ENEMY UNIT(S) INTO AND NEARBY CAVE
				_maxPos = (count _cave1_positions) - 1;
				_posIndex = 0;
				while {_posIndex < _maxPos} do
					{
						if (random 10 > 7) then
							{
								_unit = [OPEX_enemy_side1, grpNull, OPEX_enemy_units, (_cave1_positions select _posIndex), OPEX_enemy_AIskill, false, "task"] call Gemini_fnc_createUnit;
								_unit setPos (_cave1_positions select _posIndex);
								_unit setDir (random 360);
								if (random 10 > 5) then
									{
										_unitAnim = selectRandom ["STAND", "STAND", "STAND_IA", "STAND_IA", "SIT_LOW", "WATCH", "WATCH", "WATCH1", "WATCH1", "WATCH2", "WATCH2"];
										[[_unit, _unitAnim, "ASIS", {behaviour _unit == "COMBAT"}], BIS_fnc_ambientAnimCombat] remoteExec ["call", 0, _unit];
									};
								_nearbyUnits = _unit nearEntities ["Man", 20];
								_nearbyUnits = _nearbyUnits - [_unit];
								if (count _nearbyUnits > 0)
								then
									{
										[_unit] joinSilent (group (_nearbyUnits select 0));
										_unit disableAI "move";
									};
							};
						sleep 0.001;
						_posIndex = _posIndex + 1;
					};

				// CREATING SQUAD(S) AROUND CAVE
				[OPEX_enemy_side1, ["infantry"], selectRandom [2,3,5], _cave1_positions select 0, [0,250], "patrol", _cave1_positions select 0, OPEX_enemy_AIskill, 75, "task"] call Gemini_fnc_spawnSquad;
				[OPEX_enemy_side1, ["infantry"], selectRandom [3,5,7,10,12], _cave1_positions select 0, [250,1000], "patrol", _cave1_positions select 0, OPEX_enemy_AIskill, 50, "task"] call Gemini_fnc_spawnSquad;

				// CREATING VEHICLE
				[OPEX_enemy_motorizedVehicles, OPEX_enemy_side1, _cave1_positions select 0, 100, [OPEX_enemy_units, selectRandom [0,1,2,3]], 10] call Gemini_fnc_spawnVehicle;

				// CREATING STATIC DEFENSE
				private ["_randomPosition", "_position", "_azimuth"];
				_randomPosition =
					[
						[[6456.41,5314.93,0.00215149], 20],
						[[6417.76,5309.31,0.00173187], 300],
						[[6431.38,5298.75,0.00126648], 275],
						[[6401.31,5284.02,0.00143433], 270]
					] call BIS_fnc_selectRandom;
				_position  = _randomPosition select 0;
				_azimuth  = _randomPosition select 1;
				[_position, OPEX_enemy_statics + OPEX_enemy_MGstatics + OPEX_enemy_MGstatics, OPEX_enemy_side1, _azimuth, 0, selectRandom [1,2,3], 30, "task"] call Gemini_fnc_spawnStaticDefense;

				// CREATING TRIGGER TO ALERT NEARBY UNITS
				private _alertTrigger1 =
					[
						_cave1_positions select 0,
						[100, 100, 0, false],
						[OPEX_friendly_side3, OPEX_enemy_detection, true],
						["this", "{_x setBehaviour 'combat'; _x setCombatMode 'red'; _x setSpeedMode 'limited'; _x enableAI 'move'} forEach (thisTrigger nearEntities ['Man', 100])", ""],
						[0, 0, 0, false],
						"task"
					] call Gemini_fnc_createTrigger;
			};

	// CAVE 2
		if ((_cave2_positions in _selectedCaves) && (random 10 > 2)) then
			{
				private ["_maxPos", "_posIndex", "_unit", "_nearbyUnits"];

				// CREATING ENEMY UNIT(S) INTO AND NEARBY CAVE
				_maxPos = (count _cave2_positions) - 1;
				_posIndex = 0;
				while {_posIndex < _maxPos} do
					{
						if (random 10 > 7) then
							{
								_unit = [OPEX_enemy_side1, grpNull, OPEX_enemy_units, (_cave2_positions select _posIndex), OPEX_enemy_AIskill, false, "task"] call Gemini_fnc_createUnit;
								_unit setPos (_cave2_positions select _posIndex);
								_unit setDir (random 360);
								if (random 10 > 5) then
									{
										_unitAnim = selectRandom ["STAND", "STAND", "STAND_IA", "STAND_IA", "SIT_LOW", "WATCH", "WATCH", "WATCH1", "WATCH1", "WATCH2", "WATCH2"];
										[[_unit, _unitAnim, "ASIS", {behaviour _unit == "COMBAT"}], BIS_fnc_ambientAnimCombat] remoteExec ["call", 0, _unit];
									};
								_nearbyUnits = _unit nearEntities ["Man", 20];
								_nearbyUnits = _nearbyUnits - [_unit];
								if (count _nearbyUnits > 0)
								then
									{
										[_unit] joinSilent (group (_nearbyUnits select 0));
										_unit disableAI "move";
									};
							};
						sleep 0.001;
						_posIndex = _posIndex + 1;
					};

				// CREATING SQUAD(S) AROUND CAVE
				[OPEX_enemy_side1, ["infantry"], selectRandom [2,3,5], _cave2_positions select 0, [0,250], "patrol", _cave2_positions select 0, OPEX_enemy_AIskill, 75, "task"] call Gemini_fnc_spawnSquad;
				[OPEX_enemy_side1, ["infantry"], selectRandom [3,5,7,10,12], _cave2_positions select 0, [250,1000], "patrol", _cave2_positions select 0, OPEX_enemy_AIskill, 50, "task"] call Gemini_fnc_spawnSquad;

				// CREATING VEHICLE
				[OPEX_enemy_motorizedVehicles, OPEX_enemy_side1, _cave2_positions select 0, 100, [OPEX_enemy_units, selectRandom [0,1,2,3]], 10] call Gemini_fnc_spawnVehicle;

				// CREATING STATIC DEFENSE
				private ["_randomPosition", "_position", "_azimuth"];
				_randomPosition =
					[

						[[5707.87,4226.07,0.00109863], 320],
						[[5722.77,4223.69,0.00196838], 265],
						[[5769.1,4227.56,0.00160217], 300],
						[[5632.33,4267.12,0.00163269], 265],
						[[5715.63,4288.51,0.00163269], 260],
						[[5690.5,4282.24,0.0018158], 280],
						[[5631.51,4266,0.00161743], 245]
					] call BIS_fnc_selectRandom;
				_position  = _randomPosition select 0;
				_azimuth  = _randomPosition select 1;
				[_position, OPEX_enemy_statics + OPEX_enemy_MGstatics + OPEX_enemy_MGstatics, OPEX_enemy_side1, _azimuth, 0, selectRandom [1,2,3], 30, "task"] call Gemini_fnc_spawnStaticDefense;

				// CREATING TRIGGER TO ALERT NEARBY UNITS
				private _alertTrigger2 =
					[
						_cave2_positions select 0,
						[100, 100, 0, false],
						[OPEX_friendly_side3, OPEX_enemy_detection, true],
						["this", "{_x setBehaviour 'combat'; _x setCombatMode 'red'; _x setSpeedMode 'limited'; _x enableAI 'move'} forEach (thisTrigger nearEntities ['Man', 100])", ""],
						[0, 0, 0, false],
						"task"
					] call Gemini_fnc_createTrigger;
			};

	// CAVE 3
		if ((_cave3_positions in _selectedCaves) && (random 10 > 2)) then
			{
				private ["_maxPos", "_posIndex", "_unit", "_nearbyUnits"];

				// CREATING ENEMY UNIT(S) INTO AND NEARBY CAVE
					_maxPos = (count _cave3_positions) - 1;
					_posIndex = 0;
					while {_posIndex < _maxPos} do
						{
							if (random 10 > 7) then
								{
									_unit = [OPEX_enemy_side1, grpNull, OPEX_enemy_units, (_cave3_positions select _posIndex), OPEX_enemy_AIskill, false, "task"] call Gemini_fnc_createUnit;
									_unit setPos (_cave3_positions select _posIndex);
									_unit setDir (random 360);
									if (random 10 > 5) then
										{
											_unitAnim = selectRandom ["STAND", "STAND", "STAND_IA", "STAND_IA", "SIT_LOW", "WATCH", "WATCH", "WATCH1", "WATCH1", "WATCH2", "WATCH2"];
											[[_unit, _unitAnim, "ASIS", {behaviour _unit == "COMBAT"}], BIS_fnc_ambientAnimCombat] remoteExec ["call", 0, _unit];
										};
									_nearbyUnits = _unit nearEntities ["Man", 20];
									_nearbyUnits = _nearbyUnits - [_unit];
									if (count _nearbyUnits > 0)
									then
										{
											[_unit] joinSilent (group (_nearbyUnits select 0));
											_unit disableAI "move";
										};
								};
							sleep 0.001;
							_posIndex = _posIndex + 1;
						};

				// CREATING SQUAD(S) AROUND CAVE
				[OPEX_enemy_side1, ["infantry"], selectRandom [2,3,5], _cave3_positions select 0, [0,250], "patrol", _cave3_positions select 0, OPEX_enemy_AIskill, 75, "task"] call Gemini_fnc_spawnSquad;
				[OPEX_enemy_side1, ["infantry"], selectRandom [3,5,7,10,12], _cave3_positions select 0, [250,1000], "patrol", _cave3_positions select 0, OPEX_enemy_AIskill, 50, "task"] call Gemini_fnc_spawnSquad;

				// CREATING VEHICLE
				[OPEX_enemy_motorizedVehicles, OPEX_enemy_side1, _cave3_positions select 0, 100, [OPEX_enemy_units, selectRandom [0,1,2,3]], 10] call Gemini_fnc_spawnVehicle;

				// CREATING STATIC DEFENSE
					private ["_randomPosition", "_position", "_azimuth"];
					[selectRandom _cave3_positions, OPEX_enemy_statics + OPEX_enemy_MGstatics + OPEX_enemy_MGstatics, OPEX_enemy_side1, random 360, 75, selectRandom [1,2,3], 30, "task"] call Gemini_fnc_spawnStaticDefense;

				// CREATING TRIGGER TO ALERT NEARBY UNITS
				private _alertTrigger3 =
					[
						_cave3_positions select 0,
						[100, 100, 0, false],
						[OPEX_friendly_side3, OPEX_enemy_detection, true],
						["this", "{_x setBehaviour 'combat'; _x setCombatMode 'red'; _x setSpeedMode 'limited'; _x enableAI 'move'} forEach (thisTrigger nearEntities ['Man', 100])", ""],
						[0, 0, 0, false],
						"task"
					] call Gemini_fnc_createTrigger;
			};

	// CAVE 4
		if ((_cave4_positions in _selectedCaves) && (random 10 > 2)) then
			{
				private ["_maxPos", "_posIndex", "_unit", "_nearbyUnits"];

				// CREATING ENEMY UNIT(S) INTO AND NEARBY CAVE
				_maxPos = (count _cave4_positions) - 1;
				_posIndex = 0;
				while {_posIndex < _maxPos} do
					{
						if (random 10 > 7) then
							{
								_unit = [OPEX_enemy_side1, grpNull, OPEX_enemy_units, (_cave4_positions select _posIndex), OPEX_enemy_AIskill, false, "task"] call Gemini_fnc_createUnit;
								_unit setPos (_cave4_positions select _posIndex);
								_unit setDir (random 360);
								if (random 10 > 5) then
									{
										_unitAnim = selectRandom ["STAND", "STAND", "STAND_IA", "STAND_IA", "SIT_LOW", "WATCH", "WATCH", "WATCH1", "WATCH1", "WATCH2", "WATCH2"];
										[[_unit, _unitAnim, "ASIS", {behaviour _unit == "COMBAT"}], BIS_fnc_ambientAnimCombat] remoteExec ["call", 0, _unit];
									};
								_nearbyUnits = _unit nearEntities ["Man", 20];
								_nearbyUnits = _nearbyUnits - [_unit];
								if (count _nearbyUnits > 0)
								then
									{
										[_unit] joinSilent (group (_nearbyUnits select 0));
										_unit disableAI "move";
									};
							};
						sleep 0.001;
						_posIndex = _posIndex + 1;
					};

				// CREATING SQUAD(S) AROUND CAVE
				[OPEX_enemy_side1, ["infantry"], selectRandom [2,3,5], _cave4_positions select 0, [0,250], "patrol", _cave4_positions select 0, OPEX_enemy_AIskill, 75, "task"] call Gemini_fnc_spawnSquad;
				[OPEX_enemy_side1, ["infantry"], selectRandom [3,5,7,10,12], _cave4_positions select 0, [250,1000], "patrol", _cave4_positions select 0, OPEX_enemy_AIskill, 50, "task"] call Gemini_fnc_spawnSquad;

				// CREATING VEHICLE
				[OPEX_enemy_motorizedVehicles, OPEX_enemy_side1, _cave4_positions select 0, 100, [OPEX_enemy_units, selectRandom [0,1,2,3]], 10] call Gemini_fnc_spawnVehicle;

				// CREATING STATIC DEFENSE
				private ["_randomPosition", "_position", "_azimuth"];
				_randomPosition =
					[
						[[6017.6,4697.71,0.00209045], 40],
						[[5923.66,4659.04,0.00125122], 180],
						[[5917.38,4671.89,0.00126648], 295],
						[[5918.25,4641.52,0.00141907], 160],
						[[6066.03,4630.28,0.0953369], 270],
						[[6068.95,4636.46,1.41591], 40],
						[[5953.56,4577.15,0.00135803], 20]
					] call BIS_fnc_selectRandom;
				_position  = _randomPosition select 0;
				_azimuth  = _randomPosition select 1;
				[_position, OPEX_enemy_statics + OPEX_enemy_MGstatics + OPEX_enemy_MGstatics, OPEX_enemy_side1, _azimuth, 0, selectRandom [1,2,3], 30, "task"] call Gemini_fnc_spawnStaticDefense;

				// CREATING TRIGGER TO ALERT NEARBY UNITS
				private _alertTrigger4 =
					[
						_cave4_positions select 0,
						[100, 100, 0, false],
						[OPEX_friendly_side3, OPEX_enemy_detection, true],
						["this", "{_x setBehaviour 'combat'; _x setCombatMode 'red'; _x setSpeedMode 'limited'; _x enableAI 'move'} forEach (thisTrigger nearEntities ['Man', 100])", ""],
						[0, 0, 0, false],
						"task"
					] call Gemini_fnc_createTrigger;
			};

	// CAVE 5
		if ((_cave5_positions in _selectedCaves) && (random 10 > 2)) then
			{
				private ["_maxPos", "_posIndex", "_unit", "_nearbyUnits"];

				// CREATING ENEMY UNIT(S) INTO AND NEARBY CAVE
				_maxPos = (count _cave5_positions) - 1;
				_posIndex = 0;
				while {_posIndex < _maxPos} do
					{
						if (random 10 > 8) then
							{
								_unit = [OPEX_enemy_side1, grpNull, OPEX_enemy_units, (_cave5_positions select _posIndex), OPEX_enemy_AIskill, false, "task"] call Gemini_fnc_createUnit;
								_unit setPos (_cave5_positions select _posIndex);
								_unit setDir (random 360);
								if (random 10 > 5) then
									{
										_unitAnim = selectRandom ["STAND", "STAND", "STAND_IA", "STAND_IA", "SIT_LOW", "WATCH", "WATCH", "WATCH1", "WATCH1", "WATCH2", "WATCH2"];
										[[_unit, _unitAnim, "ASIS", {behaviour _unit == "COMBAT"}], BIS_fnc_ambientAnimCombat] remoteExec ["call", 0, _unit];
									};
								_nearbyUnits = _unit nearEntities ["Man", 20];
								_nearbyUnits = _nearbyUnits - [_unit];
								if (count _nearbyUnits > 0)
								then
									{
										[_unit] joinSilent (group (_nearbyUnits select 0));
										_unit disableAI "move";
									};
							};
						sleep 0.001;
						_posIndex = _posIndex + 1;
					};

				// CREATING SQUAD(S) AROUND CAVE
				[OPEX_enemy_side1, ["infantry"], selectRandom [2,3,5], _cave5_positions select 0, [0,250], "patrol", _cave5_positions select 0, OPEX_enemy_AIskill, 75, "task"] call Gemini_fnc_spawnSquad;
				[OPEX_enemy_side1, ["infantry"], selectRandom [3,5,7,10,12], _cave5_positions select 0, [250,1000], "patrol", _cave5_positions select 0, OPEX_enemy_AIskill, 50, "task"] call Gemini_fnc_spawnSquad;

				// CREATING VEHICLE
				[OPEX_enemy_motorizedVehicles, OPEX_enemy_side1, _cave5_positions select 0, 100, [OPEX_enemy_units, selectRandom [0,1,2,3]], 10] call Gemini_fnc_spawnVehicle;;

				// CREATING STATIC DEFENSE
				[selectRandom _cave5_positions, OPEX_enemy_statics + OPEX_enemy_MGstatics + OPEX_enemy_MGstatics, OPEX_enemy_side1, random 360, 75, selectRandom [1,2,3], 30, "task"] call Gemini_fnc_spawnStaticDefense;

				// CREATING TRIGGER TO ALERT NEARBY UNITS
				private _alertTrigger5 =
					[
						_cave5_positions select 0,
						[100, 100, 0, false],
						[OPEX_friendly_side3, OPEX_enemy_detection, true],
						["this", "{_x setBehaviour 'combat'; _x setCombatMode 'red'; _x setSpeedMode 'limited'; _x enableAI 'move'} forEach (thisTrigger nearEntities ['Man', 100])", ""],
						[0, 0, 0, false],
						"task"
					] call Gemini_fnc_createTrigger;
			};

	// CAVE 6
		if ((_cave6_positions in _selectedCaves) && (random 10 > 2)) then
			{
				private ["_maxPos", "_posIndex", "_unit", "_nearbyUnits"];

				// CREATING ENEMY UNIT(S) INTO AND NEARBY CAVE
				_maxPos = (count _cave6_positions) - 1;
				_posIndex = 0;
				while {_posIndex < _maxPos} do
					{
						if (random 10 > 7) then
							{
								_unit = [OPEX_enemy_side1, grpNull, OPEX_enemy_units, (_cave6_positions select _posIndex), OPEX_enemy_AIskill, false, "task"] call Gemini_fnc_createUnit;
								_unit setPos (_cave6_positions select _posIndex);
								_unit setDir (random 360);
								if (random 10 > 5) then
									{
										_unitAnim = selectRandom ["STAND", "STAND", "STAND_IA", "STAND_IA", "SIT_LOW", "WATCH", "WATCH", "WATCH1", "WATCH1", "WATCH2", "WATCH2"];
										[[_unit, _unitAnim, "ASIS", {behaviour _unit == "COMBAT"}], BIS_fnc_ambientAnimCombat] remoteExec ["call", 0, _unit];
									};
								_nearbyUnits = _unit nearEntities ["Man", 20];
								_nearbyUnits = _nearbyUnits - [_unit];
								if (count _nearbyUnits > 0)
								then
									{
										[_unit] joinSilent (group (_nearbyUnits select 0));
										_unit disableAI "move";
									};
							};
						sleep 0.001;
						_posIndex = _posIndex + 1;
					};

				// CREATING SQUAD(S) AROUND CAVE
				[OPEX_enemy_side1, ["infantry"], selectRandom [2,3,5], _cave6_positions select 0, [0,250], "patrol", _cave6_positions select 0, OPEX_enemy_AIskill, 75, "task"] call Gemini_fnc_spawnSquad;
				[OPEX_enemy_side1, ["infantry"], selectRandom [3,5,7,10,12], _cave6_positions select 0, [250,1000], "patrol", _cave6_positions select 0, OPEX_enemy_AIskill, 50, "task"] call Gemini_fnc_spawnSquad;

				// CREATING VEHICLE
				[OPEX_enemy_motorizedVehicles, OPEX_enemy_side1, _cave6_positions select 0, 100, [OPEX_enemy_units, selectRandom [0,1,2,3]], 10] call Gemini_fnc_spawnVehicle;

				// CREATING STATIC DEFENSE
				[selectRandom _cave6_positions, OPEX_enemy_statics + OPEX_enemy_MGstatics + OPEX_enemy_MGstatics, OPEX_enemy_side1, random 360, 75, selectRandom [1,2,3], 30, "task"] call Gemini_fnc_spawnStaticDefense;

				// CREATING TRIGGER TO ALERT NEARBY UNITS
				private _alertTrigger6 =
					[
						_cave6_positions select 0,
						[100, 100, 0, false],
						[OPEX_friendly_side3, OPEX_enemy_detection, true],
						["this", "{_x setBehaviour 'combat'; _x setCombatMode 'red'; _x setSpeedMode 'limited'; _x enableAI 'move'} forEach (thisTrigger nearEntities ['Man', 100])", ""],
						[0, 0, 0, false],
						"task"
					] call Gemini_fnc_createTrigger;
			};

	// CAVE 7
		if ((_cave7_positions in _selectedCaves) && (random 10 > 2)) then
			{
				private ["_maxPos", "_posIndex", "_unit", "_nearbyUnits"];

				// CREATING ENEMY UNIT(S) INTO AND NEARBY CAVE
				_maxPos = (count _cave7_positions) - 1;
				_posIndex = 0;
				while {_posIndex < _maxPos} do
					{
						if (random 10 > 7) then
							{
								_unit = [OPEX_enemy_side1, grpNull, OPEX_enemy_units, (_cave7_positions select _posIndex), OPEX_enemy_AIskill, false, "task"] call Gemini_fnc_createUnit;
								_unit setPos (_cave7_positions select _posIndex);
								_unit setDir (random 360);
								if (random 10 > 5) then
									{
										_unitAnim = selectRandom ["STAND", "STAND", "STAND_IA", "STAND_IA", "SIT_LOW", "WATCH", "WATCH", "WATCH1", "WATCH1", "WATCH2", "WATCH2"];
										[[_unit, _unitAnim, "ASIS", {behaviour _unit == "COMBAT"}], BIS_fnc_ambientAnimCombat] remoteExec ["call", 0, _unit];
									};
								_nearbyUnits = _unit nearEntities ["Man", 20];
								_nearbyUnits = _nearbyUnits - [_unit];
								if (count _nearbyUnits > 0)
								then
									{
										[_unit] joinSilent (group (_nearbyUnits select 0));
										_unit disableAI "move";
									};
							};
						sleep 0.001;
						_posIndex = _posIndex + 1;
					};

				// CREATING SQUAD(S) AROUND CAVE
				[OPEX_enemy_side1, ["infantry"], selectRandom [2,3,5], _cave7_positions select 0, [0,250], "patrol", _cave7_positions select 0, OPEX_enemy_AIskill, 75, "task"] call Gemini_fnc_spawnSquad;
				[OPEX_enemy_side1, ["infantry"], selectRandom [3,5,7,10,12], _cave7_positions select 0, [250,1000], "patrol", _cave7_positions select 0, OPEX_enemy_AIskill, 50, "task"] call Gemini_fnc_spawnSquad;

				// CREATING VEHICLE
				[OPEX_enemy_motorizedVehicles, OPEX_enemy_side1, _cave7_positions select 0, 100, [OPEX_enemy_units, selectRandom [0,1,2,3]], 10] call Gemini_fnc_spawnVehicle;

				// CREATING STATIC DEFENSE
				[selectRandom _cave7_positions, OPEX_enemy_statics + OPEX_enemy_MGstatics + OPEX_enemy_MGstatics, OPEX_enemy_side1, random 360, 75, selectRandom [1,2,3], 30, "task"] call Gemini_fnc_spawnStaticDefense;

				// CREATING TRIGGER TO ALERT NEARBY UNITS
				private _alertTrigger7 =
					[
						_cave7_positions select 0,
						[100, 100, 0, false],
						[OPEX_friendly_side3, OPEX_enemy_detection, true],
						["this", "{_x setBehaviour 'combat'; _x setCombatMode 'red'; _x setSpeedMode 'limited'; _x enableAI 'move'} forEach (thisTrigger nearEntities ['Man', 100])", ""],
						[0, 0, 0, false],
						"task"
					] call Gemini_fnc_createTrigger;
			};

	// CAVE 8
		if ((_cave8_positions in _selectedCaves) && (random 10 > 2)) then
			{
				private ["_maxPos", "_posIndex", "_unit", "_nearbyUnits"];

				// CREATING ENEMY UNIT(S) INTO AND NEARBY CAVE
				_maxPos = (count _cave8_positions) - 1;
				_posIndex = 0;
				while {_posIndex < _maxPos} do
					{
						if (random 10 > 7) then
							{
								_unit = [OPEX_enemy_side1, grpNull, OPEX_enemy_units, (_cave8_positions select _posIndex), OPEX_enemy_AIskill, false, "task"] call Gemini_fnc_createUnit;
								_unit setPos (_cave8_positions select _posIndex);
								_unit setDir (random 360);
								if (random 10 > 5) then
									{
										_unitAnim = selectRandom ["STAND", "STAND", "STAND_IA", "STAND_IA", "SIT_LOW", "WATCH", "WATCH", "WATCH1", "WATCH1", "WATCH2", "WATCH2"];
										[[_unit, _unitAnim, "ASIS", {behaviour _unit == "COMBAT"}], BIS_fnc_ambientAnimCombat] remoteExec ["call", 0, _unit];
									};
								_nearbyUnits = _unit nearEntities ["Man", 20];
								_nearbyUnits = _nearbyUnits - [_unit];
								if (count _nearbyUnits > 0)
								then
									{
										[_unit] joinSilent (group (_nearbyUnits select 0));
										_unit disableAI "move";
									};
							};
						sleep 0.001;
						_posIndex = _posIndex + 1;
					};

				// CREATING SQUAD(S) AROUND CAVE
				[OPEX_enemy_side1, ["infantry"], selectRandom [2,3,5], _cave8_positions select 0, [0,250], "patrol", _cave8_positions select 0, OPEX_enemy_AIskill, 75, "task"] call Gemini_fnc_spawnSquad;
				[OPEX_enemy_side1, ["infantry"], selectRandom [3,5,7,10,12], _cave8_positions select 0, [250,1000], "patrol", _cave8_positions select 0, OPEX_enemy_AIskill, 50, "task"] call Gemini_fnc_spawnSquad;

				// CREATING VEHICLE
				[OPEX_enemy_motorizedVehicles, OPEX_enemy_side1, _cave8_positions select 0, 100, [OPEX_enemy_units, selectRandom [0,1,2,3]], 10] call Gemini_fnc_spawnVehicle;

				// CREATING STATIC DEFENSE
				[selectRandom _cave8_positions, OPEX_enemy_statics + OPEX_enemy_MGstatics + OPEX_enemy_MGstatics, OPEX_enemy_side1, random 360, 75, selectRandom [1,2,3], 30, "task"] call Gemini_fnc_spawnStaticDefense;

				// CREATING TRIGGER TO ALERT NEARBY UNITS
				private _alertTrigger8 =
					[
						_cave8_positions select 0,
						[100, 100, 0, false],
						[OPEX_friendly_side3, OPEX_enemy_detection, true],
						["this", "{_x setBehaviour 'combat'; _x setCombatMode 'red'; _x setSpeedMode 'limited'; _x enableAI 'move'} forEach (thisTrigger nearEntities ['Man', 100])", ""],
						[0, 0, 0, false],
						"task"
					] call Gemini_fnc_createTrigger;
			};

	// CAVE 9
		if ((_cave9_positions in _selectedCaves) && (random 10 > 2)) then
			{
				private ["_maxPos", "_posIndex", "_unit", "_nearbyUnits"];

				// CREATING ENEMY UNIT(S) INTO AND NEARBY CAVE
				_maxPos = (count _cave9_positions) - 1;
				_posIndex = 0;
				while {_posIndex < _maxPos} do
					{
						if (random 10 > 7) then
							{
								_unit = [OPEX_enemy_side1, grpNull, OPEX_enemy_units, (_cave9_positions select _posIndex), OPEX_enemy_AIskill, false, "task"] call Gemini_fnc_createUnit;
								_unit setPos (_cave9_positions select _posIndex);
								_unit setDir (random 360);
								if (random 10 > 5) then
									{
										_unitAnim = selectRandom ["STAND", "STAND", "STAND_IA", "STAND_IA", "SIT_LOW", "WATCH", "WATCH", "WATCH1", "WATCH1", "WATCH2", "WATCH2"];
										[[_unit, _unitAnim, "ASIS", {behaviour _unit == "COMBAT"}], BIS_fnc_ambientAnimCombat] remoteExec ["call", 0, _unit];
									};
								_nearbyUnits = _unit nearEntities ["Man", 20];
								_nearbyUnits = _nearbyUnits - [_unit];
								if (count _nearbyUnits > 0)
								then
									{
										if ((side (_nearbyUnits select 0)) == side _unit) then
										{
											[_unit] joinSilent (group (_nearbyUnits select 0));
											_unit disableAI "move";
										};
									};
							};
						sleep 0.001;
						_posIndex = _posIndex + 1;
					};

				// CREATING SQUAD(S) AROUND CAVE
				[OPEX_enemy_side1, ["infantry"], selectRandom [2,3,5], _cave9_positions select 0, [0,250], "patrol", _cave9_positions select 0, OPEX_enemy_AIskill, 75, "task"] call Gemini_fnc_spawnSquad;
				[OPEX_enemy_side1, ["infantry"], selectRandom [3,5,7,10,12], _cave9_positions select 0, [250,1000], "patrol", _cave9_positions select 0, OPEX_enemy_AIskill, 50, "task"] call Gemini_fnc_spawnSquad;

				// CREATING VEHICLE
				[OPEX_enemy_motorizedVehicles, OPEX_enemy_side1, _cave9_positions select 0, 100, [OPEX_enemy_units, selectRandom [0,1,2,3]], 10] call Gemini_fnc_spawnVehicle;

				// CREATING STATIC DEFENSE
				[selectRandom _cave9_positions, OPEX_enemy_statics + OPEX_enemy_MGstatics + OPEX_enemy_MGstatics, OPEX_enemy_side1, random 360, 75, selectRandom [1,2,3], 30, "task"] call Gemini_fnc_spawnStaticDefense;

				// CREATING TRIGGER TO ALERT NEARBY UNITS
				private _alertTrigger9 =
					[
						_cave9_positions select 0,
						[100, 100, 0, false],
						[OPEX_friendly_side3, OPEX_enemy_detection, true],
						["this", "{_x setBehaviour 'combat'; _x setCombatMode 'red'; _x setSpeedMode 'limited'; _x enableAI 'move'} forEach (thisTrigger nearEntities ['Man', 100])", ""],
						[0, 0, 0, false],
						"task"
					] call Gemini_fnc_createTrigger;
			};

// =========================================================================================================
// SPAWNING CIVILIANS
// =========================================================================================================

	private ["_civilian", "_civilianName"];

	if ((_cave1_positions in _selectedCaves) && (random 10 > 8.5)) then
		{
			for "_i" from 1 to (ceil (random 2)) do
				{
					_civilianPos = _cave1_positions call BIS_fnc_selectRandom;
					_civilian = [OPEX_civilian_side1, grpNull, OPEX_civilian_units, _civilianPos, OPEX_civilian_AIskill, false, "task"] call Gemini_fnc_createUnit;
					_civilian forceAddUniform (OPEX_civilian_uniforms call BIS_fnc_selectRandom);
					_civilian addHeadGear (OPEX_civilian_headgears call BIS_fnc_selectRandom);
					[_civilian, "civilian_"] call Gemini_fnc_setUnitName;
					_civilian setPos _civilianPos;
					_civilian allowFleeing 0;
					[_civilian] spawn {sleep 3; [_this select 0] spawn Gemini_fnc_civilianInteractions};
				};
		};

	if ((_cave2_positions in _selectedCaves) && (random 10 > 8.5)) then
		{
			for "_i" from 1 to (ceil (random 2)) do
				{
					_civilianPos = _cave2_positions call BIS_fnc_selectRandom;
					_civilian = [OPEX_civilian_side1, grpNull, OPEX_civilian_units, _civilianPos, OPEX_civilian_AIskill, false, "task"] call Gemini_fnc_createUnit;
					_civilian forceAddUniform (OPEX_civilian_uniforms call BIS_fnc_selectRandom);
					_civilian addHeadGear (OPEX_civilian_headgears call BIS_fnc_selectRandom);
					[_civilian, "civilian_"] call Gemini_fnc_setUnitName;
					_civilian setPos _civilianPos;
					_civilian allowFleeing 0;
					[_civilian] spawn {sleep 3; [_this select 0] spawn Gemini_fnc_civilianInteractions};
				};
		};

	if ((_cave3_positions in _selectedCaves) && (random 10 > 8.5)) then
		{
			for "_i" from 1 to (ceil (random 2)) do
				{
					_civilianPos = _cave3_positions call BIS_fnc_selectRandom;
					_civilian = [OPEX_civilian_side1, grpNull, OPEX_civilian_units, _civilianPos, OPEX_civilian_AIskill, false, "task"] call Gemini_fnc_createUnit;
					_civilian forceAddUniform (OPEX_civilian_uniforms call BIS_fnc_selectRandom);
					_civilian addHeadGear (OPEX_civilian_headgears call BIS_fnc_selectRandom);
					[_civilian, "civilian_"] call Gemini_fnc_setUnitName;
					_civilian setPos _civilianPos;
					_civilian allowFleeing 0;
					[_civilian] spawn {sleep 3; [_this select 0] spawn Gemini_fnc_civilianInteractions};
				};
		};

	if ((_cave4_positions in _selectedCaves) && (random 10 > 8.5)) then
		{
			for "_i" from 1 to (ceil (random 5)) do
				{
					_civilianPos = _cave4_positions call BIS_fnc_selectRandom;
					_civilian = [OPEX_civilian_side1, grpNull, OPEX_civilian_units, _civilianPos, OPEX_civilian_AIskill, false, "task"] call Gemini_fnc_createUnit;
					_civilian forceAddUniform (OPEX_civilian_uniforms call BIS_fnc_selectRandom);
					_civilian addHeadGear (OPEX_civilian_headgears call BIS_fnc_selectRandom);
					[_civilian, "civilian_"] call Gemini_fnc_setUnitName;
					_civilian setPos _civilianPos;
					_civilian allowFleeing 0;
					[_civilian] spawn {sleep 3; [_this select 0] spawn Gemini_fnc_civilianInteractions};
				};
		};

	if ((_cave5_positions in _selectedCaves) && (random 10 > 8.5)) then
		{
			for "_i" from 1 to (ceil (random 2)) do
				{
					_civilianPos = _cave5_positions call BIS_fnc_selectRandom;
					_civilian = [OPEX_civilian_side1, grpNull, OPEX_civilian_units, _civilianPos, OPEX_civilian_AIskill, false, "task"] call Gemini_fnc_createUnit;
					_civilian forceAddUniform (OPEX_civilian_uniforms call BIS_fnc_selectRandom);
					_civilian addHeadGear (OPEX_civilian_headgears call BIS_fnc_selectRandom);
					[_civilian, "civilian_"] call Gemini_fnc_setUnitName;
					_civilian setPos _civilianPos;
					_civilian allowFleeing 0;
					[_civilian] spawn {sleep 3; [_this select 0] spawn Gemini_fnc_civilianInteractions};
				};
		};

	if ((_cave6_positions in _selectedCaves) && (random 10 > 8.5)) then
		{
			for "_i" from 1 to (ceil (random 2)) do
				{
					_civilianPos = _cave6_positions call BIS_fnc_selectRandom;
					_civilian = [OPEX_civilian_side1, grpNull, OPEX_civilian_units, _civilianPos, OPEX_civilian_AIskill, false, "task"] call Gemini_fnc_createUnit;
					_civilian forceAddUniform (OPEX_civilian_uniforms call BIS_fnc_selectRandom);
					_civilian addHeadGear (OPEX_civilian_headgears call BIS_fnc_selectRandom);
					[_civilian, "civilian_"] call Gemini_fnc_setUnitName;
					_civilian setPos _civilianPos;
					_civilian allowFleeing 0;
					[_civilian] spawn {sleep 3; [_this select 0] spawn Gemini_fnc_civilianInteractions};
				};
		};

	if ((_cave7_positions in _selectedCaves) && (random 10 > 8.5)) then
		{
			for "_i" from 1 to (ceil (random 2)) do
				{
					_civilianPos = _cave7_positions call BIS_fnc_selectRandom;
					_civilian = [OPEX_civilian_side1, grpNull, OPEX_civilian_units, _civilianPos, OPEX_civilian_AIskill, false, "task"] call Gemini_fnc_createUnit;
					_civilian forceAddUniform (OPEX_civilian_uniforms call BIS_fnc_selectRandom);
					_civilian addHeadGear (OPEX_civilian_headgears call BIS_fnc_selectRandom);
					[_civilian, "civilian_"] call Gemini_fnc_setUnitName;
					_civilian setPos _civilianPos;
					_civilian allowFleeing 0;
					[_civilian] spawn {sleep 3; [_this select 0] spawn Gemini_fnc_civilianInteractions};
				};
		};

	if ((_cave8_positions in _selectedCaves) && (random 10 > 8.5)) then
		{
			for "_i" from 1 to (ceil (random 2)) do
				{
					_civilianPos = _cave8_positions call BIS_fnc_selectRandom;
					_civilian = [OPEX_civilian_side1, grpNull, OPEX_civilian_units, _civilianPos, OPEX_civilian_AIskill, false, "task"] call Gemini_fnc_createUnit;
					_civilian forceAddUniform (OPEX_civilian_uniforms call BIS_fnc_selectRandom);
					_civilian addHeadGear (OPEX_civilian_headgears call BIS_fnc_selectRandom);
					[_civilian, "civilian_"] call Gemini_fnc_setUnitName;
					_civilian setPos _civilianPos;
					_civilian allowFleeing 0;
					[_civilian] spawn {sleep 3; [_this select 0] spawn Gemini_fnc_civilianInteractions};
				};
		};

	if ((_cave9_positions in _selectedCaves) && (random 10 > 0.5)) then
		{
			for "_i" from 1 to (ceil (random 2)) do
				{
					_civilianPos = _cave9_positions call BIS_fnc_selectRandom;
					_civilian = [OPEX_civilian_side1, grpNull, OPEX_civilian_units, _civilianPos, OPEX_civilian_AIskill, false, "task"] call Gemini_fnc_createUnit;
					_civilian forceAddUniform (OPEX_civilian_uniforms call BIS_fnc_selectRandom);
					_civilian addHeadGear (OPEX_civilian_headgears call BIS_fnc_selectRandom);
					[_civilian, "civilian_"] call Gemini_fnc_setUnitName;
					_civilian setPos _civilianPos;
					_civilian allowFleeing 0;
					[_civilian] spawn {sleep 3; [_this select 0] spawn Gemini_fnc_civilianInteractions};
				};
		};

// =========================================================================================================
// CREATING MARKERS
// =========================================================================================================

	// CAVE 1/3
	"TaskMarker_A" setMarkerPos [((_selectedCaves select 0) select 0 select 0) + random 250 - random 250, ((_selectedCaves select 0) select 0 select 1) + random 250 - random 250];
	"TaskMarker_A" setMarkerSize [250,250];
	"TaskMarker_A" setMarkerShape "ellipse";
	"TaskMarker_A" setMarkerBrush "FDiagonal";
	"TaskMarker_A" setMarkerColor "colorRed";
	"TaskMarker_A" setMarkerAlpha 1;
	"taskMarker_B" setMarkerPos (getMarkerPos "taskMarker_A");
	"taskMarker_B" setMarkerSize [1,1];
	"taskMarker_B" setMarkerType "mil_unknown";
	"taskMarker_B" setMarkerColor "colorRed";
	"taskMarker_B" setMarkerAlpha 1;
	"taskMarker_B" setMarkerText format ["%1 ?", localize "STR_hideout"];

	// CAVE 2/3
	"TaskMarker_C" setMarkerPos [((_selectedCaves select 1) select 0 select 0) + random 250 - random 250, ((_selectedCaves select 1) select 0 select 1) + random 250 - random 250];
	"TaskMarker_C" setMarkerSize [250,250];
	"TaskMarker_C" setMarkerShape "ellipse";
	"TaskMarker_C" setMarkerBrush "FDiagonal";
	"TaskMarker_C" setMarkerColor "colorRed";
	"TaskMarker_C" setMarkerAlpha 1;
	"taskMarker_D" setMarkerPos (getMarkerPos "TaskMarker_C");
	"taskMarker_D" setMarkerSize [1,1];
	"taskMarker_D" setMarkerType "mil_unknown";
	"taskMarker_D" setMarkerColor "colorRed";
	"taskMarker_D" setMarkerAlpha 1;
	"taskMarker_D" setMarkerText format ["%1 ?", localize "STR_hideout"];

	// CAVE 3/3
	"TaskMarker_E" setMarkerPos [((_selectedCaves select 2) select 0 select 0) + random 250 - random 250, ((_selectedCaves select 2) select 0 select 1) + random 250 - random 250];
	"TaskMarker_E" setMarkerSize [250,250];
	"TaskMarker_E" setMarkerShape "ellipse";
	"TaskMarker_E" setMarkerBrush "FDiagonal";
	"TaskMarker_E" setMarkerColor "colorRed";
	"TaskMarker_E" setMarkerAlpha 1;
	"taskMarker_F" setMarkerPos (getMarkerPos "TaskMarker_E");
	"taskMarker_F" setMarkerSize [1,1];
	"taskMarker_F" setMarkerType "mil_unknown";
	"taskMarker_F" setMarkerColor "colorRed";
	"taskMarker_F" setMarkerAlpha 1;
	"taskMarker_F" setMarkerText format ["%1 ?", localize "STR_hideout"];

// =========================================================================================================
// DEFINING CONDITIONS OF VICTORY
// =========================================================================================================

	// CREATING TRIGGER TO CHECK IF ENEMIES ARE PRESENT NEARBY CAVE 1
	private _clearTrigger1 =
		[
			_selectedCaves select 0 select 0,
			[100, 100, 0, false],
			[OPEX_enemy_side2, "NOT PRESENT", true],
			["this", "deleteVehicle thisTrigger; cave1_cleared = true; publicVariable 'cave1_cleared'", ""],
			[0, 0, 0, false],
			"task"
		] call Gemini_fnc_createTrigger;

	// CREATING TRIGGER TO CHECK IF FRIENDLY ARE PRESENT NEARBY CAVE 1
	private _presenceTrigger1 =
		[
			_selectedCaves select 0 select 0,
			[10, 10, 0, false],
			[OPEX_friendly_side3, "PRESENT", true],
			["this", "deleteVehicle thisTrigger; cave1_visited = true; publicVariable 'cave1_visited'", ""],
			[0, 0, 0, false],
			"task"
		] call Gemini_fnc_createTrigger;

	// CREATING TRIGGER TO CHECK IF ENEMIES ARE PRESENT NEARBY CAVE 2
	private _clearTrigger2 =
		[
			_selectedCaves select 1 select 0,
			[100, 100, 0, false],
			[OPEX_enemy_side2, "NOT PRESENT", true],
			["this", "deleteVehicle thisTrigger; cave2_cleared = true; publicVariable 'cave2_cleared'", ""],
			[0, 0, 0, false],
			"task"
		] call Gemini_fnc_createTrigger;

	// CREATING TRIGGER TO CHECK IF FRIENDLY ARE PRESENT NEARBY CAVE 2
	private _presenceTrigger2 =
		[
			_selectedCaves select 1 select 0,
			[10, 10, 0, false],
			[OPEX_friendly_side3, "PRESENT", true],
			["this", "deleteVehicle thisTrigger; cave2_visited = true; publicVariable 'cave2_visited'", ""],
			[0, 0, 0, false],
			"task"
		] call Gemini_fnc_createTrigger;

	// CREATING TRIGGER TO CHECK IF ENEMIES ARE PRESENT NEARBY CAVE 3
	private _clearTrigger3 =
		[
			_selectedCaves select 2 select 0,
			[100, 100, 0, false],
			[OPEX_enemy_side2, "NOT PRESENT", true],
			["this", "deleteVehicle thisTrigger; cave3_cleared = true; publicVariable 'cave3_cleared'", ""],
			[0, 0, 0, false],
			"task"
		] call Gemini_fnc_createTrigger;


	// CREATING TRIGGER TO CHECK IF FRIENDLY ARE PRESENT NEARBY CAVE 3
	private _presenceTrigger3 =
		[
			_selectedCaves select 2 select 0,
			[10, 10, 0, false],
			[OPEX_friendly_side3, "PRESENT", true],
			["this", "deleteVehicle thisTrigger; cave3_visited = true; publicVariable 'cave3_visited'", ""],
			[0, 0, 0, false],
			"task"
		] call Gemini_fnc_createTrigger;

	// MONITORING
	_selectedCaves spawn
		{
			private _selectedCaves = _this;
			while {OPEX_assignedTask} do
				{
					sleep 3;
					if (OPEX_assignedTask && cave1_cleared && cave1_visited) then {"taskMarker_A" setMarkerSize [0,0]; "taskMarker_B" setMarkerType "mil_objective"; "taskMarker_B" setMarkerPos ((_selectedCaves select 0) select 0); "taskMarker_B" setMarkerText localize "STR_hideoutCleared"; "taskMarker_B" setMarkerColor "colorGreen"};
					if (OPEX_assignedTask && cave2_cleared && cave2_visited) then {"taskMarker_C" setMarkerSize [0,0]; "taskMarker_D" setMarkerType "mil_objective"; "taskMarker_D" setMarkerPos ((_selectedCaves select 1) select 0); "taskMarker_D" setMarkerText localize "STR_hideoutCleared"; "taskMarker_D" setMarkerColor "colorGreen"};
					if (OPEX_assignedTask && cave3_cleared && cave3_visited) then {"taskMarker_E" setMarkerSize [0,0]; "taskMarker_F" setMarkerType "mil_objective"; "taskMarker_F" setMarkerPos ((_selectedCaves select 2) select 0); "taskMarker_F" setMarkerText localize "STR_hideoutCleared"; "taskMarker_F" setMarkerColor "colorGreen"};

					// TASK SUCCEEDED IF ALL 3 CACHES HAS BEEN CLEARED AND VISITED
					if (OPEX_assignedTask && cave1_cleared && cave1_visited && cave2_cleared && cave2_visited && cave3_cleared && cave3_visited) then {[] remoteExecCall ["Gemini_fnc_taskSucceeded"]; ["supply", "explosives"] call Gemini_fnc_bonus};
				};
		};

// =========================================================================================================
// UPDATING DIARY
// =========================================================================================================

	[OPEX_taskID, "attack", "taskMarker_A"] remoteExecCall ["Gemini_fnc_taskAssigned"];

// =========================================================================================================
// PLAYING AMBIENT MUSIC
// =========================================================================================================

	["calm"] remoteExec ["Gemini_fnc_playMusic"]; // music type can be: "punchy", "calm", "stealth", "sad", "oriental", "tropical" or a specific music classname