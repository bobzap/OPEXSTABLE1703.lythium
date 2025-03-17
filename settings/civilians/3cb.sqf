/*
	=======================================================================================================================
	NOTES FOR MISSION EDITORS (please take a few time to read and understand these lines to avoid any issue)
	=======================================================================================================================

	 - Adding custom mods into OPEX is your responsibility, so if you do so, please do it at your own risk and don't complain if something doesn't work as intended.
	 - Adding custom mods into OPEX requires some scripting skills and above all a lot of concentration - a single wrong data can break the whole mission so keep that in mind at any time.
	 - Keep the same variables types : some of them must be strings (""), some others are arrays ([]) etc... so double check before doing anything.
	 - Do NOT edit or delete anything in PART 2.
	 - If you want to add something to the vanilla content (if variable is an array), use this command: OPEX_exampleArray append ["myCustomData1", "myCustomData2", "myCustomData3", ""myCustomDataN"]
	 - If you want to replace the vanilla content (if variable is an array), use this command: OPEX_exampleArray = ["myCustomData1", "myCustomData2", "myCustomData3", ""myCustomDataN"]
	 - So be aware of how the variables are defined (with " = " or " append ") !
	 - If you want to use vanilla content, simply remove the data (for example, if your mod doesn't have any aircraft, simply remove the line that defines OPEX_friendly_aircrafts).
	 - Tip: if you want to increase the probability of usaage of a specific item, list it several times (example: OPEX_exampleArray = ["myCustomData1", "myCustomData1", "myCustomData1", ""myCustomData2"] means that "myCustomData1" has 3 times more chances to be used than "myCustomData2")
	 - When your template is ready, don't forget to enable it by editing the "settings\init.sqf" file.
	 - If you want your custom mod to be officially integrated into OPEX, please be sure your template is 100% working and send it to gemini.69@free.fr

	If you need help, please contact me:
	 - on the OPEX public comments on Steam (please do NOT add me to your friend list): https://steamcommunity.com/workshop/filedetails/?id=908003375
	 - on the official OPEX forum: https://forums.bohemia.net/forums/topic/194070-opex/
	 - by email: gemini.69@free.fr

	I will provide as much support as I can but please keep in mind that I'm alone and I'm developping OPEX on my free time.

	- Gemini
*/

// =======================================================================================================================
// PART 1 (you need AT LEAST ONE ENTRY to avoid this custom mod loading on computers that don't have it)
// =======================================================================================================================

	if (!(isClass (configFile >> "CfgPatches" >> "UK3CB_Factions_TKA"))) exitWith {}; // replace "xxxxx" by the name of the file you need to check
	if (!(isClass (configFile >> "CfgPatches" >> "UK3CB_Factions_TKC"))) exitWith {}; // replace "xxxxx" by the name of the file you need to check
	if (!(isClass (configFile >> "CfgPatches" >> "UK3CB_Factions_TKM"))) exitWith {}; // replace "xxxxx" by the name of the file you need to check
	if (!(isClass (configFile >> "CfgPatches" >> "UK3CB_Factions_TKP"))) exitWith {}; // replace "xxxxx" by the name of the file you need to check
	if (!(isClass (configFile >> "CfgPatches" >> "UK3CB_Factions_Weapons"))) exitWith {}; // replace "xxxxx" by the name of the file you need to check

// =======================================================================================================================
// PART 2 (do NOT edit or delete this part)
// =======================================================================================================================

	waitUntil {!isNil "OPEX_mapRegion"}; // do not edit or delete this line
	waitUntil {!isNil "OPEX_civilian_vehicles"}; // do not edit or delete this line

// =======================================================================================================================
// PART 3 (customizable part)
// =======================================================================================================================

	// UNITS & GEAR
	switch (OPEX_mapRegion) do

		{
			// EUROPE REGION
			case "europe" :
				{
					OPEX_civilian_units append [];
					OPEX_civilian_uniforms append ["UK3CB_CHC_C_U_HIKER_03","UK3CB_CHC_C_U_HIKER_02","UK3CB_CHC_C_U_HIKER_01","UK3CB_CHC_C_U_ACTIVIST_03","UK3CB_CHC_C_U_ACTIVIST_01","UK3CB_CHC_C_U_ACTIVIST_04","UK3CB_CHC_C_U_ACTIVIST_02","UK3CB_CHC_C_U_CIT_01","UK3CB_CHC_C_U_CIT_04","UK3CB_CHC_C_U_CIT_02","UK3CB_CHC_C_U_CIT_03","UK3CB_CHC_C_U_COACH_04","UK3CB_CHC_C_U_COACH_01","UK3CB_CHC_C_U_COACH_03","UK3CB_CHC_C_U_COACH_05","UK3CB_CHC_C_U_COACH_02","UK3CB_CHC_C_U_WORK_03","UK3CB_CHC_C_U_WORK_04","UK3CB_CHC_C_U_WORK_02","UK3CB_CHC_C_U_WORK_01","UK3CB_CHC_C_U_PROF_04","UK3CB_CHC_C_U_PROF_03","UK3CB_CHC_C_U_PROF_01","UK3CB_CHC_C_U_PROF_02","UK3CB_CHC_C_U_DOC_03","UK3CB_CHC_C_U_DOC_02","UK3CB_CHC_C_U_Overall_02","UK3CB_CHC_C_U_Overall_05","UK3CB_CHC_C_U_Overall_04","UK3CB_CHC_C_U_PRIEST_01","UK3CB_CHC_C_U_VILL_01","UK3CB_CHC_C_U_VILL_03","UK3CB_CHC_C_U_VILL_04","UK3CB_CHC_C_U_VILL_02","UK3CB_CHC_C_U_WOOD_04","UK3CB_CHC_C_U_WOOD_01","UK3CB_CHC_C_U_WOOD_02","UK3CB_CHC_C_U_WOOD_03"];
					OPEX_civilian_headgears append ["UK3CB_CHC_C_H_Can_Cap","UK3CB_H_Profiteer_Cap_01","UK3CB_H_Ushanka_Cap_01","UK3CB_H_Villager_Cap_01","UK3CB_H_Worker_Cap_01"];
				};

			// MIDDLE-EAST REGION
			case "middleEast" :
				{
					switch (OPEX_mapEnemy) do
						{
							// AFGHANISTAN + PAKISTAN
							case "TALIB" :
								{
									OPEX_civilian_units append [];
									OPEX_civilian_uniforms append ["UK3CB_TKC_C_U_01","UK3CB_TKC_C_U_01_B","UK3CB_TKC_C_U_01_C","UK3CB_TKC_C_U_01_D","UK3CB_TKC_C_U_01_E","UK3CB_TKC_C_U_02","UK3CB_TKC_C_U_02_B","UK3CB_TKC_C_U_02_C","UK3CB_TKC_C_U_02_D","UK3CB_TKC_C_U_02_E","UK3CB_TKC_C_U_03","UK3CB_TKC_C_U_03_B","UK3CB_TKC_C_U_03_C","UK3CB_TKC_C_U_03_D","UK3CB_TKC_C_U_03_E","UK3CB_TKC_C_U_06","UK3CB_TKC_C_U_06_B","UK3CB_TKC_C_U_06_C","UK3CB_TKC_C_U_06_D","UK3CB_TKC_C_U_06_E"];
									OPEX_civilian_headgears append ["UK3CB_TKC_H_Turban_01_1","UK3CB_TKC_H_Turban_02_1","UK3CB_TKC_H_Turban_06_1","UK3CB_TKC_H_Turban_03_1","UK3CB_TKC_H_Turban_04_1","UK3CB_TKC_H_Turban_05_1","UK3CB_TKM_O_H_Turban_03_1","UK3CB_TKM_O_H_Turban_04_1","UK3CB_TKM_O_H_Turban_05_1","UK3CB_TKM_O_H_Turban_01_1","UK3CB_TKM_O_H_Turban_02_1","UK3CB_TKM_B_H_Turban_03_1","UK3CB_TKM_B_H_Turban_04_1","UK3CB_TKM_B_H_Turban_05_1","UK3CB_TKM_B_H_Turban_01_1","UK3CB_TKM_B_H_Turban_02_1","UK3CB_TKM_I_H_Turban_03_1","UK3CB_TKM_I_H_Turban_04_1","UK3CB_TKM_I_H_Turban_05_1","UK3CB_TKM_I_H_Turban_01_1","UK3CB_TKM_I_H_Turban_02_1"];
								};
							// OTHER MIDDLE-EAST REGIONS (IRAQ, SYRIA...)
							default
								{
									OPEX_civilian_units append [];
									OPEX_civilian_uniforms append ["UK3CB_TKC_C_U_01","UK3CB_TKC_C_U_01_B","UK3CB_TKC_C_U_01_C","UK3CB_TKC_C_U_01_D","UK3CB_TKC_C_U_01_E"];
									OPEX_civilian_headgears append ["UK3CB_TKC_H_Turban_01_1","UK3CB_TKC_H_Turban_06_1","UK3CB_TKC_H_Turban_03_1","UK3CB_TKC_H_Turban_04_1","UK3CB_TKC_H_Turban_05_1","UK3CB_TKM_O_H_Turban_03_1","UK3CB_TKM_O_H_Turban_04_1","UK3CB_TKM_O_H_Turban_05_1","UK3CB_TKM_O_H_Turban_01_1","UK3CB_TKM_B_H_Turban_03_1","UK3CB_TKM_B_H_Turban_04_1","UK3CB_TKM_B_H_Turban_05_1","UK3CB_TKM_B_H_Turban_01_1","UK3CB_TKM_I_H_Turban_03_1","UK3CB_TKM_I_H_Turban_04_1","UK3CB_TKM_I_H_Turban_05_1","UK3CB_TKM_I_H_Turban_01_1"];
								};
						};
				};

			// AFRICA REGION
			case "africa" :
				{
					OPEX_civilian_units append [];
					OPEX_civilian_uniforms append [];
					OPEX_civilian_headgears append ["UK3CB_CHC_C_H_Can_Cap","UK3CB_H_Profiteer_Cap_01"];
				};

			// PACIFIC REGION
			case "pacific" :
				{
					OPEX_civilian_units append [];
					OPEX_civilian_uniforms append [];
					OPEX_civilian_headgears append ["UK3CB_CHC_C_H_Can_Cap","UK3CB_H_Profiteer_Cap_01"];
				};
		};

	// OTHER STUFF
	OPEX_civilian_vests append [];
	OPEX_civilian_glasses append [];
	OPEX_civilian_sunglasses append [];
	OPEX_civilian_scarfs append ["UK3CB_G_Neck_Shemag_Oli","UK3CB_G_Neck_Shemag_Tan","UK3CB_G_Neck_Shemag"];
	OPEX_civilian_beards append [];

	// VEHICLES
	OPEX_civilian_cars append ["UK3CB_TKC_C_Datsun_Civ_Closed","UK3CB_TKC_C_Datsun_Civ_Open","UK3CB_TKC_C_Hatchback","UK3CB_TKC_C_Hilux_Civ_Closed","UK3CB_TKC_C_Hilux_Civ_Open","UK3CB_TKC_C_Lada","UK3CB_TKC_C_Sedan","UK3CB_TKC_C_Skoda","UK3CB_TKC_C_S1203","UK3CB_TKC_C_Tractor","UK3CB_TKC_C_Tractor_Old","UK3CB_TKC_C_Gaz24","UK3CB_CHC_C_Lada"];
	OPEX_civilian_trucks append ["UK3CB_TKC_C_Ikarus","UK3CB_TKC_C_Kamaz_Covered","UK3CB_TKC_C_Kamaz_Open","UK3CB_TKC_C_V3S_Recovery","UK3CB_TKC_C_V3S_Closed","UK3CB_TKC_C_V3S_Open","UK3CB_TKC_C_Ural","UK3CB_TKC_C_Open","UK3CB_TKC_C_Ural_Empty","UK3CB_TKC_C_Ural_Recovery"];
	OPEX_civilian_boats append [];
	OPEX_civilian_vehicles = OPEX_civilian_cars + OPEX_civilian_trucks; // don't delete this line if you have defined any of these variables