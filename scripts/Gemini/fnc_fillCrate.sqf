// =========================================================================================================
// WAITING MISSION IS READY
// =========================================================================================================

	waitUntil {!isNil "OPEX_params_ready"}; waitUntil {OPEX_params_ready};
	waitUntil {!isNil "OPEX_param_gearManagement"};

// =========================================================================================================
// PRIVATIZING LOCAL VARIABLES
// =========================================================================================================

	private ["_crate", "_index"];

// =========================================================================================================
// GETTING ARGUMENT(S)
// =========================================================================================================

	sleep 3;
	_crate = _this;
	_crate allowDamage false;

// =========================================================================================================
// FILLING CRATE
// =========================================================================================================

	if (isServer) then
		{
			//if ("server" call Gemini_fnc_persistence_exists) exitWith {};

			// CLEARING BOX
			clearWeaponCargoGlobal _crate; clearMagazineCargoGlobal _crate; clearItemCargoGlobal _crate; clearBackpackCargoGlobal _crate;

			// WEAPONS
			if (typeOf _crate == "Box_NATO_Wps_F") then
				{
					_index = 0; for "_i" from 1 to (count OPEX_friendly_commonRifles) do {_crate addItemCargoGlobal [(OPEX_friendly_commonRifles select _index), 50]; _index = _index + 1};
					_index = 0; for "_i" from 1 to (count OPEX_friendly_specialRifles) do {_crate addItemCargoGlobal [(OPEX_friendly_specialRifles select _index), 10]; _index = _index + 1};
					_index = 0; for "_i" from 1 to (count OPEX_friendly_compactRifles) do {_crate addItemCargoGlobal [(OPEX_friendly_compactRifles select _index), 10]; _index = _index + 1};
					_index = 0; for "_i" from 1 to (count OPEX_friendly_GLrifles) do {_crate addItemCargoGlobal [(OPEX_friendly_GLrifles select _index), 10]; _index = _index + 1};
					_index = 0; for "_i" from 1 to (count OPEX_friendly_MGrifles) do {_crate addItemCargoGlobal [(OPEX_friendly_MGrifles select _index), 10]; _index = _index + 1};
					_index = 0; for "_i" from 1 to (count OPEX_friendly_precisionRifles) do {_crate addItemCargoGlobal [(OPEX_friendly_precisionRifles select _index), 10]; _index = _index + 1};
					_index = 0; for "_i" from 1 to (count OPEX_friendly_sniperRifles) do {_crate addItemCargoGlobal [(OPEX_friendly_sniperRifles select _index), 10]; _index = _index + 1};
					_index = 0; for "_i" from 1 to (count OPEX_friendly_shotguns) do {_crate addItemCargoGlobal [(OPEX_friendly_shotguns select _index), 5]; _index = _index + 1};
					_index = 0; for "_i" from 1 to (count OPEX_friendly_diverRifles) do {_crate addItemCargoGlobal [(OPEX_friendly_diverRifles select _index), 5]; _index = _index + 1};
					_index = 0; for "_i" from 1 to (count OPEX_friendly_commonHandguns) do {_crate addItemCargoGlobal [(OPEX_friendly_commonHandguns select _index), 50]; _index = _index + 1};
					_index = 0; for "_i" from 1 to (count OPEX_friendly_specialHandguns) do {_crate addItemCargoGlobal [(OPEX_friendly_specialHandguns select _index), 10]; _index = _index + 1};
				};

			// LAUNCHERS
			if (typeOf _crate == "Box_NATO_WpsLaunch_F") then
				{
					_index = 0; for "_i" from 1 to (count OPEX_friendly_ATlaunchers) do {_crate addItemCargoGlobal [(OPEX_friendly_ATlaunchers select _index), 10]; _index = _index + 1};
					_index = 0; for "_i" from 1 to (count OPEX_friendly_AAlaunchers) do {_crate addItemCargoGlobal [(OPEX_friendly_AAlaunchers select _index), 3]; _index = _index + 1};
				};

			// AMMO
			if (typeOf _crate == "Box_NATO_Ammo_F") then
				{
					// COMMON AMMO
					private ["_compiledMagazines", "_commonMagazines"];
					_compiledMagazines = [];
					_commonMagazines = [];
					{_commonMagazines append (getArray (configfile >> "CfgWeapons" >> _x >> "magazines"))} forEach (OPEX_friendly_commonHandguns + OPEX_friendly_commonRifles);
					{_compiledMagazines pushBackUnique _x} forEach _commonMagazines;
					_index = 0; for "_i" from 1 to (count _compiledMagazines) do {_crate addItemCargoGlobal [(_compiledMagazines select _index), 100]; _index = _index + 1};

					// SPECIAL AMMO
					private ["_compiledMagazines", "_specialMagazines"];
					_compiledMagazines = [];
					_specialMagazines = [];
					{_specialMagazines append (getArray (configfile >> "CfgWeapons" >> _x >> "magazines"))} forEach (OPEX_friendly_specialHandguns + OPEX_friendly_specialRifles + OPEX_friendly_GLrifles + OPEX_friendly_MGrifles + OPEX_friendly_compactRifles + OPEX_friendly_precisionRifles + OPEX_friendly_sniperRifles + OPEX_friendly_shotguns + OPEX_friendly_diverRifles);
					{_compiledMagazines pushBackUnique _x} forEach _specialMagazines;
					_index = 0; for "_i" from 1 to (count _compiledMagazines) do {_crate addItemCargoGlobal [(_compiledMagazines select _index), 50]; _index = _index + 1};

					// LAUNCHER AMMO
					private ["_compiledMagazines", "_launcherMagazines"];
					_compiledMagazines = [];
					_launcherMagazines = [];
					{_launcherMagazines append (getArray (configfile >> "CfgWeapons" >> _x >> "magazines"))} forEach (OPEX_friendly_ATlaunchers + OPEX_friendly_AAlaunchers);
					{_compiledMagazines pushBackUnique _x} forEach _launcherMagazines;
					_index = 0; for "_i" from 1 to (count _compiledMagazines) do {_crate addItemCargoGlobal [(_compiledMagazines select _index), 10]; _index = _index + 1};

					// GL AMMO
					_crate addItemCargoGlobal ["1Rnd_HE_Grenade_shell", 25];
					_crate addItemCargoGlobal ["3Rnd_HE_Grenade_shell", 10];
					_crate addItemCargoGlobal ["1Rnd_Smoke_Grenade_shell", 25];
					_crate addItemCargoGlobal ["3Rnd_Smoke_Grenade_shell", 10];
					_crate addItemCargoGlobal ["1Rnd_SmokeRed_Grenade_shell", 10];
					_crate addItemCargoGlobal ["3Rnd_SmokeRed_Grenade_shell", 10];
					_crate addItemCargoGlobal ["1Rnd_SmokeGreen_Grenade_shell", 10];
					_crate addItemCargoGlobal ["3Rnd_SmokeGreen_Grenade_shell", 10];
					_crate addItemCargoGlobal ["1Rnd_SmokeYellow_Grenade_shell", 10];
					_crate addItemCargoGlobal ["3Rnd_SmokeYellow_Grenade_shell", 10];
					_crate addItemCargoGlobal ["1Rnd_SmokePurple_Grenade_shell", 10];
					_crate addItemCargoGlobal ["3Rnd_SmokePurple_Grenade_shell", 10];
					_crate addItemCargoGlobal ["1Rnd_SmokeBlue_Grenade_shell", 10];
					_crate addItemCargoGlobal ["3Rnd_SmokeBlue_Grenade_shell", 10];
					_crate addItemCargoGlobal ["1Rnd_SmokeOrange_Grenade_shell", 10];
					_crate addItemCargoGlobal ["3Rnd_SmokeOrange_Grenade_shell", 10];
					_crate addItemCargoGlobal ["UGL_FlareWhite_F", 10];
					_crate addItemCargoGlobal ["3Rnd_UGL_FlareWhite_F", 10];
					_crate addItemCargoGlobal ["UGL_FlareGreen_F", 10];
					_crate addItemCargoGlobal ["3Rnd_UGL_FlareGreen_F", 10];
					_crate addItemCargoGlobal ["UGL_FlareRed_F", 10];
					_crate addItemCargoGlobal ["3Rnd_UGL_FlareRed_F", 10];
					_crate addItemCargoGlobal ["UGL_FlareYellow_F", 10];
					_crate addItemCargoGlobal ["3Rnd_UGL_FlareYellow_F", 10];
					_crate addItemCargoGlobal ["UGL_FlareCIR_F", 10];
					_crate addItemCargoGlobal ["3Rnd_UGL_FlareCIR_F", 10];
				};

			// ACCESSORIES
			if (typeOf _crate == "Box_NATO_Support_F") then
				{
					_index = 0; for "_i" from 1 to (count OPEX_friendly_closeCombatOptics) do {_crate addItemCargoGlobal [(OPEX_friendly_closeCombatOptics select _index), 10]; _index = _index + 1};
					_index = 0; for "_i" from 1 to (count OPEX_friendly_distantCombatOptics) do {_crate addItemCargoGlobal [(OPEX_friendly_distantCombatOptics select _index), 10]; _index = _index + 1};
					_index = 0; for "_i" from 1 to (count OPEX_friendly_sniperOptics) do {_crate addItemCargoGlobal [(OPEX_friendly_sniperOptics select _index), 5]; _index = _index + 1};
					_index = 0; for "_i" from 1 to (count OPEX_friendly_flashlights) do {_crate addItemCargoGlobal [(OPEX_friendly_flashlights select _index), 10]; _index = _index + 1};
					_index = 0; for "_i" from 1 to (count OPEX_friendly_pointers) do {_crate addItemCargoGlobal [(OPEX_friendly_pointers select _index), 10]; _index = _index + 1};
					_index = 0; for "_i" from 1 to (count OPEX_friendly_bipods) do {_crate addItemCargoGlobal [(OPEX_friendly_bipods select _index), 10]; _index = _index + 1};
					_index = 0; for "_i" from 1 to (count OPEX_friendly_rifleSilencers) do {_crate addItemCargoGlobal [(OPEX_friendly_rifleSilencers select _index), 10]; _index = _index + 1};
					_index = 0; for "_i" from 1 to (count OPEX_friendly_handgunSilencers) do {_crate addItemCargoGlobal [(OPEX_friendly_handgunSilencers select _index), 10]; _index = _index + 1};
					_index = 0; for "_i" from 1 to (count OPEX_friendly_NVGs) do {_crate addItemCargoGlobal [(OPEX_friendly_NVGs select _index), 10]; _index = _index + 1};
					_index = 0; for "_i" from 1 to (count OPEX_cableTies) do {_crate addItemCargoGlobal [(OPEX_cableTies select _index), 100]; _index = _index + 1};
					_index = 0; for "_i" from 1 to (count OPEX_friendly_chemlights) do {_crate addItemCargoGlobal [(OPEX_friendly_chemlights select _index), 25]; _index = _index + 1};
					_index = 0; for "_i" from 1 to (count OPEX_friendly_IRs) do {_crate addItemCargoGlobal [(OPEX_friendly_IRs select _index), 10]; _index = _index + 1};
					_index = 0; for "_i" from 1 to (count OPEX_bioScans) do {_crate addItemCargoGlobal [(OPEX_bioScans select _index), 3]; _index = _index + 1};
					_index = 0; for "_i" from 1 to (count OPEX_spyMicros) do {_crate addItemCargoGlobal [(OPEX_spyMicros select _index), 3]; _index = _index + 1};
					_index = 0; for "_i" from 1 to (count OPEX_friendly_mineDetectors) do {_crate addItemCargoGlobal [(OPEX_friendly_mineDetectors select _index), 3]; _index = _index + 1};
					_index = 0; for "_i" from 1 to (count OPEX_friendly_droneTerminals) do {_crate addItemCargoGlobal [(OPEX_friendly_droneTerminals select _index), 3]; _index = _index + 1};
					_index = 0; for "_i" from 1 to (count OPEX_friendly_toolKits) do {_crate addItemCargoGlobal [(OPEX_friendly_toolKits select _index), 5]; _index = _index + 1};
					_index = 0; for "_i" from 1 to 1 do {_crate addItemCargoGlobal ["ItemGPS", 25]};
					if (count OPEX_friendly_spotterBinoculars > 0) then {_index = 0; for "_i" from 1 to (count OPEX_friendly_spotterBinoculars) do {_crate addItemCargoGlobal [(OPEX_friendly_spotterBinoculars select _index), 10]; _index = _index + 1}};
					if (count OPEX_friendly_earplugs > 0) then {_index = 0; for "_i" from 1 to (count OPEX_friendly_earplugs) do {_crate addItemCargoGlobal [(OPEX_friendly_earplugs select _index), 50]; _index = _index + 1}};
					if (count OPEX_friendly_tablets > 0) then {_index = 0; for "_i" from 1 to (count OPEX_friendly_tablets) do {_crate addItemCargoGlobal [(OPEX_friendly_tablets select _index), 3]; _index = _index + 1}};
					if (count OPEX_friendly_mapTools > 0) then {_index = 0; for "_i" from 1 to (count OPEX_friendly_mapTools) do {_crate addItemCargoGlobal [(OPEX_friendly_mapTools select _index), 10]; _index = _index + 1}};
					if (count OPEX_friendly_rangeCards > 0) then {_index = 0; for "_i" from 1 to (count OPEX_friendly_rangeCards) do {_crate addItemCargoGlobal [(OPEX_friendly_rangeCards select _index), 5]; _index = _index + 1}};
					if (count OPEX_friendly_sniperPDAs > 0) then {_index = 0; for "_i" from 1 to (count OPEX_friendly_sniperPDAs) do {_crate addItemCargoGlobal [(OPEX_friendly_sniperPDAs select _index), 5]; _index = _index + 1}};
					if (count OPEX_friendly_weatherPDAs > 0) then {_index = 0; for "_i" from 1 to (count OPEX_friendly_weatherPDAs) do {_crate addItemCargoGlobal [(OPEX_friendly_weatherPDAs select _index), 5]; _index = _index + 1}};
					if (count OPEX_friendly_advancedGPS > 0) then {_index = 0; for "_i" from 1 to (count OPEX_friendly_advancedGPS) do {_crate addItemCargoGlobal [(OPEX_friendly_advancedGPS select _index), 5]; _index = _index + 1}};
					if (count OPEX_friendly_sandbags > 0) then {_index = 0; for "_i" from 1 to (count OPEX_friendly_sandbags) do {_crate addItemCargoGlobal [(OPEX_friendly_sandbags select _index), 10]; _index = _index + 1}};
					if (count OPEX_friendly_tripods > 0) then {_index = 0; for "_i" from 1 to (count OPEX_friendly_tripods) do {_crate addItemCargoGlobal [(OPEX_friendly_tripods select _index), 3]; _index = _index + 1}};
					if (count OPEX_friendly_HuntIRs > 0) then {_index = 0; for "_i" from 1 to (count OPEX_friendly_HuntIRs) do {_crate addItemCargoGlobal [(OPEX_friendly_HuntIRs select _index), 3]; _index = _index + 1}};
					if (count OPEX_friendly_altimeters > 0) then {_index = 0; for "_i" from 1 to (count OPEX_friendly_altimeters) do {_crate addItemCargoGlobal [(OPEX_friendly_altimeters select _index), 5]; _index = _index + 1}};
					if (count OPEX_entrenchingTools > 0) then {_index = 0; for "_i" from 1 to (count OPEX_entrenchingTools) do {_crate addItemCargoGlobal [(OPEX_entrenchingTools select _index), 5]; _index = _index + 1}};
					//if (count OPEX_ConcertinaWireCoils > 0) then {_index = 0; for "_i" from 1 to (count OPEX_ConcertinaWireCoils) do {_crate addItemCargoGlobal [(OPEX_ConcertinaWireCoils select _index), 5]; _index = _index + 1}}; // this is not a valid object !
					if (count OPEX_wireCutters > 0) then {_index = 0; for "_i" from 1 to (count OPEX_wireCutters) do {_crate addItemCargoGlobal [(OPEX_wireCutters select _index), 5]; _index = _index + 1}};
					if (count OPEX_flashlights > 0) then {_index = 0; for "_i" from 1 to (count OPEX_flashlights) do {_crate addItemCargoGlobal [(OPEX_flashlights select _index), 10]; _index = _index + 1}};
					if (isClass (configFile >> "CfgPatches" >> "task_force_radio")) then {_index = 0; for "_i" from 1 to (count OPEX_friendly_radiosShortDistance) do {_crate addItemCargoGlobal [(OPEX_friendly_radiosShortDistance select _index), 50]; _index = _index + 1}};
					if (isClass (configFile >> "CfgPatches" >> "task_force_radio")) then {_index = 0; for "_i" from 1 to (count OPEX_friendly_radiosLongDistance) do {_crate addBackpackCargoGlobal [(OPEX_friendly_radiosLongDistance select _index), 10]; _index = _index + 1}};
					if (count OPEX_press_cameras > 0) then {_index = 0; for "_i" from 1 to (count OPEX_press_cameras) do {_crate addItemCargoGlobal [(OPEX_press_cameras select _index), 3]; _index = _index + 1}};
					if (count OPEX_press_photos > 0) then {_index = 0; for "_i" from 1 to (count OPEX_press_photos) do {_crate addItemCargoGlobal [(OPEX_press_photos select _index), 3]; _index = _index + 1}};
					if (count OPEX_press_micros > 0) then {_index = 0; for "_i" from 1 to (count OPEX_press_micros) do {_crate addItemCargoGlobal [(OPEX_press_micros select _index), 3]; _index = _index + 1}};
				};

			// GRENADES
			if (typeOf _crate == "Box_NATO_Grenades_F") then
				{
					_index = 0; for "_i" from 1 to (count OPEX_friendly_handGrenades) do {_crate addItemCargoGlobal [(OPEX_friendly_handGrenades select _index), 25]; _index = _index + 1};
					_index = 0; for "_i" from 1 to (count OPEX_friendly_smokeGrenades_white) do {_crate addItemCargoGlobal [(OPEX_friendly_smokeGrenades_white select _index), 25]; _index = _index + 1};
					_index = 0; for "_i" from 1 to (count OPEX_friendly_smokeGrenades_colors) do {_crate addItemCargoGlobal [(OPEX_friendly_smokeGrenades_colors select _index), 5]; _index = _index + 1};
					if (count OPEX_friendly_stunGrenades > 0) then {_index = 0; for "_i" from 1 to (count OPEX_friendly_stunGrenades) do {_crate addItemCargoGlobal [(OPEX_friendly_stunGrenades select _index), 10]; _index = _index + 1}};
				};

			// EXPLOSIVES
			if (typeOf _crate == "Box_NATO_AmmoOrd_F") then {_index = 0; for "_i" from 1 to (count OPEX_friendly_explosives) do {_crate addItemCargoGlobal [(OPEX_friendly_explosives select _index), 10]; _index = _index + 1}};

			// CLOTHES
			if (typeOf _crate == "Box_NATO_Uniforms_F") then
				{
					private ["_clothes", "_backpacks"];
					_clothes = [];
					_backpacks = [];
					switch (OPEX_mapClimate) do
						{
							case default
											{
												_index = 0; for "_i" from 1 to (count OPEX_friendly_commonUniforms_woodland) do {_clothes pushBackUnique (OPEX_friendly_commonUniforms_woodland select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_specialUniforms_woodland) do {_clothes pushBackUnique (OPEX_friendly_specialUniforms_woodland select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_ghillieUniforms_woodland) do {_clothes pushBackUnique (OPEX_friendly_ghillieUniforms_woodland select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_heliPilotUniforms_woodland) do {_clothes pushBackUnique (OPEX_friendly_heliPilotUniforms_woodland select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_aircraftPilotUniforms_woodland) do {_clothes pushBackUnique (OPEX_friendly_aircraftPilotUniforms_woodland select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_tankPilotUniforms_woodland) do {_clothes pushBackUnique (OPEX_friendly_tankPilotUniforms_woodland select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_medicUniforms_woodland) do {_clothes pushBackUnique (OPEX_friendly_medicUniforms_woodland select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_instructorUniforms_woodland) do {_clothes pushBackUnique (OPEX_friendly_instructorUniforms_woodland select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_tshirtUniforms_woodland) do {_clothes pushBackUnique (OPEX_friendly_tshirtUniforms_woodland select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_diverUniforms) do {_clothes pushBackUnique (OPEX_friendly_diverUniforms select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_commonVests_woodland) do {_clothes pushBackUnique (OPEX_friendly_commonVests_woodland select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_specialVests) do {_clothes pushBackUnique (OPEX_friendly_specialVests select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_beltVests) do {_clothes pushBackUnique (OPEX_friendly_beltVests select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_shoulderVests) do {_clothes pushBackUnique (OPEX_friendly_shoulderVests select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_lightVests) do {_clothes pushBackUnique (OPEX_friendly_lightVests select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_grenadierVests) do {_clothes pushBackUnique (OPEX_friendly_grenadierVests select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_EODvests) do {_clothes pushBackUnique (OPEX_friendly_EODvests select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_diverVests) do {_clothes pushBackUnique (OPEX_friendly_diverVests select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_commonHelmets_woodland) do {_clothes pushBackUnique (OPEX_friendly_commonHelmets_woodland select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_specialHelmets_woodland) do {_clothes pushBackUnique (OPEX_friendly_specialHelmets_woodland select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_EODhelmets_woodland) do {_clothes pushBackUnique (OPEX_friendly_EODhelmets_woodland select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_heliPilotHelmets) do {_clothes pushBackUnique (OPEX_friendly_heliPilotHelmets select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_aircraftPilotHelmets) do {_clothes pushBackUnique (OPEX_friendly_aircraftPilotHelmets select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_tankCrewHelmets) do {_clothes pushBackUnique (OPEX_friendly_tankCrewHelmets select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_cameraHelmets_woodland) do {_clothes pushBackUnique (OPEX_friendly_cameraHelmets_woodland select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_hats_woodland) do {_clothes pushBackUnique (OPEX_friendly_hats_woodland select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_beanies_woodland) do {_clothes pushBackUnique (OPEX_friendly_beanies_woodland select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_leaderHeadgear_woodland) do {_clothes pushBackUnique (OPEX_friendly_leaderHeadgear_woodland select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_berets) do {_clothes pushBackUnique (OPEX_friendly_berets select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_caps) do {_clothes pushBackUnique (OPEX_friendly_caps select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_bandanas) do {_clothes pushBackUnique (OPEX_friendly_bandanas select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_shemags) do {_clothes pushBackUnique (OPEX_friendly_shemags select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_headsets) do {_clothes pushBackUnique (OPEX_friendly_headsets select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_balaclavas) do {_clothes pushBackUnique (OPEX_friendly_balaclavas select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_bandanas) do {_clothes pushBackUnique (OPEX_friendly_bandanas select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_glasses) do {_clothes pushBackUnique (OPEX_friendly_glasses select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_sunglasses) do {_clothes pushBackUnique (OPEX_friendly_sunglasses select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_diverGlasses) do {_clothes pushBackUnique (OPEX_friendly_diverGlasses select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_mediumBackpacks_woodland) do {_backpacks pushBackUnique (OPEX_friendly_mediumBackpacks_woodland select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_bigBackpacks_woodland) do {_backpacks pushBackUnique (OPEX_friendly_bigBackpacks_woodland select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_medicBackpacks_woodland) do {_backpacks pushBackUnique (OPEX_friendly_medicBackpacks_woodland select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_radioBackpacks_woodland) do {_backpacks pushBackUnique (OPEX_friendly_radioBackpacks_woodland select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_diverBackpacks) do {_backpacks pushBackUnique (OPEX_friendly_diverBackpacks select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count _clothes) do {_crate addItemCargoGlobal [(_clothes select _index), 10]; _index = _index + 1};
												_index = 0; for "_i" from 1 to (count _backpacks) do {_crate addBackpackCargoGlobal [(_backpacks select _index), 10]; _index = _index + 1};
												if (count OPEX_friendly_ladders > 0) then {_index = 0; for "_i" from 1 to (count OPEX_friendly_ladders) do {_crate addBackpackCargoGlobal [OPEX_friendly_ladders select _index, 3]}};
												_index = 0; for "_i" from 1 to (count OPEX_sleepingBags) do {_crate addItemCargoGlobal [(OPEX_sleepingBags select _index), 10]; _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_tacticalGlasses) do {_crate addItemCargoGlobal [OPEX_friendly_tacticalGlasses select _index, 3]; _index = _index + 1};
											};
							case "arid"	 :
											{
												_index = 0; for "_i" from 1 to (count OPEX_friendly_commonUniforms_desert) do {_clothes pushBackUnique (OPEX_friendly_commonUniforms_desert select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_specialUniforms_desert) do {_clothes pushBackUnique (OPEX_friendly_specialUniforms_desert select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_ghillieUniforms_desert) do {_clothes pushBackUnique (OPEX_friendly_ghillieUniforms_desert select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_heliPilotUniforms_desert) do {_clothes pushBackUnique (OPEX_friendly_heliPilotUniforms_desert select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_aircraftPilotUniforms_desert) do {_clothes pushBackUnique (OPEX_friendly_aircraftPilotUniforms_desert select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_tankPilotUniforms_desert) do {_clothes pushBackUnique (OPEX_friendly_tankPilotUniforms_desert select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_medicUniforms_desert) do {_clothes pushBackUnique (OPEX_friendly_medicUniforms_desert select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_instructorUniforms_desert) do {_clothes pushBackUnique (OPEX_friendly_instructorUniforms_desert select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_tshirtUniforms_desert) do {_clothes pushBackUnique (OPEX_friendly_tshirtUniforms_desert select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_diverUniforms) do {_clothes pushBackUnique (OPEX_friendly_diverUniforms select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_commonVests_desert) do {_clothes pushBackUnique (OPEX_friendly_commonVests_desert select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_specialVests) do {_clothes pushBackUnique (OPEX_friendly_specialVests select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_beltVests) do {_clothes pushBackUnique (OPEX_friendly_beltVests select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_shoulderVests) do {_clothes pushBackUnique (OPEX_friendly_shoulderVests select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_lightVests) do {_clothes pushBackUnique (OPEX_friendly_lightVests select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_grenadierVests) do {_clothes pushBackUnique (OPEX_friendly_grenadierVests select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_EODvests) do {_clothes pushBackUnique (OPEX_friendly_EODvests select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_diverVests) do {_clothes pushBackUnique (OPEX_friendly_diverVests select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_commonHelmets_desert) do {_clothes pushBackUnique (OPEX_friendly_commonHelmets_desert select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_specialHelmets_desert) do {_clothes pushBackUnique (OPEX_friendly_specialHelmets_desert select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_EODhelmets_desert) do {_clothes pushBackUnique (OPEX_friendly_EODhelmets_desert select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_heliPilotHelmets) do {_clothes pushBackUnique (OPEX_friendly_heliPilotHelmets select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_aircraftPilotHelmets) do {_clothes pushBackUnique (OPEX_friendly_aircraftPilotHelmets select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_tankCrewHelmets) do {_clothes pushBackUnique (OPEX_friendly_tankCrewHelmets select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_cameraHelmets_desert) do {_clothes pushBackUnique (OPEX_friendly_cameraHelmets_desert select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_hats_desert) do {_clothes pushBackUnique (OPEX_friendly_hats_desert select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_beanies_desert) do {_clothes pushBackUnique (OPEX_friendly_beanies_desert select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_leaderHeadgear_desert) do {_clothes pushBackUnique (OPEX_friendly_leaderHeadgear_desert select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_berets) do {_clothes pushBackUnique (OPEX_friendly_berets select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_caps) do {_clothes pushBackUnique (OPEX_friendly_caps select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_bandanas) do {_clothes pushBackUnique (OPEX_friendly_bandanas select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_shemags) do {_clothes pushBackUnique (OPEX_friendly_shemags select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_headsets) do {_clothes pushBackUnique (OPEX_friendly_headsets select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_balaclavas) do {_clothes pushBackUnique (OPEX_friendly_balaclavas select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_bandanas) do {_clothes pushBackUnique (OPEX_friendly_bandanas select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_glasses) do {_clothes pushBackUnique (OPEX_friendly_glasses select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_sunglasses) do {_clothes pushBackUnique (OPEX_friendly_sunglasses select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_diverGlasses) do {_clothes pushBackUnique (OPEX_friendly_diverGlasses select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_mediumBackpacks_desert) do {_backpacks pushBackUnique (OPEX_friendly_mediumBackpacks_desert select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_bigBackpacks_desert) do {_backpacks pushBackUnique (OPEX_friendly_bigBackpacks_desert select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_medicBackpacks_desert) do {_backpacks pushBackUnique (OPEX_friendly_medicBackpacks_desert select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_radioBackpacks_desert) do {_backpacks pushBackUnique (OPEX_friendly_radioBackpacks_desert select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_diverBackpacks) do {_backpacks pushBackUnique (OPEX_friendly_diverBackpacks select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count _clothes) do {_crate addItemCargoGlobal [(_clothes select _index), 10]; _index = _index + 1};
												_index = 0; for "_i" from 1 to (count _backpacks) do {_crate addBackpackCargoGlobal [(_backpacks select _index), 10]; _index = _index + 1};
												if (count OPEX_friendly_ladders > 0) then {_index = 0; for "_i" from 1 to (count OPEX_friendly_ladders) do {_crate addBackpackCargoGlobal [OPEX_friendly_ladders select _index, 3]}};
												_index = 0; for "_i" from 1 to (count OPEX_sleepingBags) do {_crate addBackpackCargoGlobal [(OPEX_sleepingBags select _index), 10]; _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_tacticalGlasses) do {_crate addItemCargoGlobal [OPEX_friendly_tacticalGlasses select _index, 3]; _index = _index + 1};
											};
							case "polar" :
											{
												_index = 0; for "_i" from 1 to (count OPEX_friendly_commonUniforms_snow) do {_clothes pushBackUnique (OPEX_friendly_commonUniforms_snow select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_specialUniforms_snow) do {_clothes pushBackUnique (OPEX_friendly_specialUniforms_snow select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_ghillieUniforms_snow) do {_clothes pushBackUnique (OPEX_friendly_ghillieUniforms_snow select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_heliPilotUniforms_snow) do {_clothes pushBackUnique (OPEX_friendly_heliPilotUniforms_snow select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_aircraftPilotUniforms_snow) do {_clothes pushBackUnique (OPEX_friendly_aircraftPilotUniforms_snow select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_tankPilotUniforms_snow) do {_clothes pushBackUnique (OPEX_friendly_tankPilotUniforms_snow select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_medicUniforms_snow) do {_clothes pushBackUnique (OPEX_friendly_medicUniforms_snow select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_instructorUniforms_snow) do {_clothes pushBackUnique (OPEX_friendly_instructorUniforms_snow select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_tshirtUniforms_snow) do {_clothes pushBackUnique (OPEX_friendly_tshirtUniforms_snow select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_diverUniforms) do {_clothes pushBackUnique (OPEX_friendly_diverUniforms select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_commonVests_snow) do {_clothes pushBackUnique (OPEX_friendly_commonVests_snow select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_specialVests) do {_clothes pushBackUnique (OPEX_friendly_specialVests select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_beltVests) do {_clothes pushBackUnique (OPEX_friendly_beltVests select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_shoulderVests) do {_clothes pushBackUnique (OPEX_friendly_shoulderVests select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_lightVests) do {_clothes pushBackUnique (OPEX_friendly_lightVests select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_grenadierVests) do {_clothes pushBackUnique (OPEX_friendly_grenadierVests select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_EODvests) do {_clothes pushBackUnique (OPEX_friendly_EODvests select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_diverVests) do {_clothes pushBackUnique (OPEX_friendly_diverVests select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_commonHelmets_snow) do {_clothes pushBackUnique (OPEX_friendly_commonHelmets_snow select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_specialHelmets_snow) do {_clothes pushBackUnique (OPEX_friendly_specialHelmets_snow select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_EODhelmets_snow) do {_clothes pushBackUnique (OPEX_friendly_EODhelmets_snow select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_heliPilotHelmets) do {_clothes pushBackUnique (OPEX_friendly_heliPilotHelmets select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_aircraftPilotHelmets) do {_clothes pushBackUnique (OPEX_friendly_aircraftPilotHelmets select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_tankCrewHelmets) do {_clothes pushBackUnique (OPEX_friendly_tankCrewHelmets select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_cameraHelmets_snow) do {_clothes pushBackUnique (OPEX_friendly_cameraHelmets_snow select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_hats_snow) do {_clothes pushBackUnique (OPEX_friendly_hats_snow select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_beanies_snow) do {_clothes pushBackUnique (OPEX_friendly_beanies_snow select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_leaderHeadgear_snow) do {_clothes pushBackUnique (OPEX_friendly_leaderHeadgear_snow select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_berets) do {_clothes pushBackUnique (OPEX_friendly_berets select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_caps) do {_clothes pushBackUnique (OPEX_friendly_caps select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_bandanas) do {_clothes pushBackUnique (OPEX_friendly_bandanas select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_shemags) do {_clothes pushBackUnique (OPEX_friendly_shemags select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_headsets) do {_clothes pushBackUnique (OPEX_friendly_headsets select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_balaclavas) do {_clothes pushBackUnique (OPEX_friendly_balaclavas select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_bandanas) do {_clothes pushBackUnique (OPEX_friendly_bandanas select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_glasses) do {_clothes pushBackUnique (OPEX_friendly_glasses select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_sunglasses) do {_clothes pushBackUnique (OPEX_friendly_sunglasses select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_diverGlasses) do {_clothes pushBackUnique (OPEX_friendly_diverGlasses select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_mediumBackpacks_snow) do {_backpacks pushBackUnique (OPEX_friendly_mediumBackpacks_snow select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_bigBackpacks_snow) do {_backpacks pushBackUnique (OPEX_friendly_bigBackpacks_snow select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_medicBackpacks_snow) do {_backpacks pushBackUnique (OPEX_friendly_medicBackpacks_snow select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_radioBackpacks_snow) do {_backpacks pushBackUnique (OPEX_friendly_radioBackpacks_snow select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_diverBackpacks) do {_backpacks pushBackUnique (OPEX_friendly_diverBackpacks select _index); _index = _index + 1};
												_index = 0; for "_i" from 1 to (count _clothes) do {_crate addItemCargoGlobal [(_clothes select _index), 10]; _index = _index + 1};
												_index = 0; for "_i" from 1 to (count _backpacks) do {_crate addBackpackCargoGlobal [(_backpacks select _index), 10]; _index = _index + 1};
												if (count OPEX_friendly_ladders > 0) then {_index = 0; for "_i" from 1 to (count OPEX_friendly_ladders) do {_crate addBackpackCargoGlobal [OPEX_friendly_ladders select _index, 3]}};
												_index = 0; for "_i" from 1 to (count OPEX_sleepingBags) do {_crate addBackpackCargoGlobal [(OPEX_sleepingBags select _index), 10]; _index = _index + 1};
												_index = 0; for "_i" from 1 to (count OPEX_friendly_tacticalGlasses) do {_crate addItemCargoGlobal [OPEX_friendly_tacticalGlasses select _index, 3]; _index = _index + 1};
											};
						};
				};

			// MEDICAL
			if (typeOf _crate == "Box_NATO_Equip_F") then
				{
					_index = 0; for "_i" from 1 to (count OPEX_medical_medikits) do {_crate addItemCargoGlobal [(OPEX_medical_medikits select _index), 10]; _index = _index + 1};
					_crate addItemCargoGlobal [OPEX_medical_firstAidKit, 50];
					_crate addItemCargoGlobal [OPEX_medical_defibrillator, 5];
					if (count OPEX_medical_commonSupplies > 0) then {_index = 0; for "_i" from 1 to (count OPEX_medical_commonSupplies) do {_crate addItemCargoGlobal [(OPEX_medical_commonSupplies select _index), 50]; _index = _index + 1}};
					if (count OPEX_medical_advancedSupplies > 0) then {_index = 0; for "_i" from 1 to (count OPEX_medical_advancedSupplies) do {_crate addItemCargoGlobal [(OPEX_medical_advancedSupplies select _index), 25]; _index = _index + 1}};
				};

			// FOOD
			if (typeOf _crate == "Box_IDAP_Equip_F") then
				{
					_index = 0; for "_i" from 1 to (count OPEX_canteenItems) do {_crate addItemCargoGlobal [(OPEX_canteenItems select _index), 100]; _index = _index + 1};
				};

			// CIVILIAN CLOTHES
			if (["WpsSpecial_F", typeOf _crate] call BIS_fnc_inString) then
				{
					_index = 0; for "_i" from 1 to (count OPEX_civilian_uniforms) do {_crate addItemCargoGlobal [(OPEX_civilian_uniforms select _index), 1]; _index = _index + 1};
					_index = 0; for "_i" from 1 to (count OPEX_civilian_headgears) do {_crate addItemCargoGlobal [(OPEX_civilian_headgears select _index), 1]; _index = _index + 1};
				};
		};