if(!isServer) exitWith {};

enableDynamicSimulationSystem true;
"Group" setDynamicSimulationDistance 1000;
"Vehicle" setDynamicSimulationDistance 1000;
"EmptyVehicle" setDynamicSimulationDistance 250;
"Prop" setDynamicSimulationDistance 50;
"IsMoving" setDynamicSimulationDistanceCoef 2;

[] spawn
	{
		while {true} do
			{
				if (cameraView isEqualTo "GUNNER")
				then
					{
						"Group" setDynamicSimulationDistance (viewDistance - (viewDistance * fog));
					}
				else
					{
						"Group" setDynamicSimulationDistance ((viewDistance * 0.8) - (viewDistance * fog));
					};
				uiSleep 1;
			};
	};