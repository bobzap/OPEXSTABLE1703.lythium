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

	if (!(isClass (configFile >> "CfgPatches" >> "po_main"))) exitWith {}; // replace "xxxxx" by the name of the file you need to check

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
					OPEX_civilian_units append ["C_man_1"];
					OPEX_civilian_uniforms append ["LOP_U_CHR_Assistant_01","LOP_U_CHR_Citizen_03","LOP_U_CHR_Citizen_04","LOP_U_CHR_Citizen_01","LOP_U_CHR_Citizen_06","LOP_U_CHR_Citizen_02","LOP_U_CHR_Villager_01","LOP_U_CHR_Villager_01","LOP_U_CHR_Villager_04","LOP_U_CHR_Villager_03","LOP_U_CHR_Villager_02","LOP_U_CHR_Priest_01","LOP_U_CHR_Profiteer_02","LOP_U_CHR_Profiteer_03","LOP_U_CHR_Profiteer_01","LOP_U_CHR_Profiteer_04","LOP_U_CHR_Rocker_03","LOP_U_CHR_Rocker_04","LOP_U_CHR_Rocker_01","LOP_U_CHR_Rocker_02","LOP_U_CHR_SchoolTeacher_01","LOP_U_CHR_Woodlander_01","LOP_U_CHR_Woodlander_02","LOP_U_CHR_Woodlander_03","LOP_U_CHR_Woodlander_04","LOP_U_CHR_Worker_03","LOP_U_CHR_Worker_04","LOP_U_CHR_Worker_01","LOP_U_CHR_Worker_02"];
					OPEX_civilian_headgears append ["LOP_H_Ushanka","LOP_H_Villager_cap","LOP_H_Worker_cap"];
				};

			// MIDDLE-EAST REGION
			case "middleEast" :
				{
					switch (OPEX_mapEnemy) do
						{
							// AFGHANISTAN + PAKISTAN
							case "TALIB" :
								{
									OPEX_civilian_units append ["LOP_Tak_Civ_Random"];
									OPEX_civilian_uniforms append ["LOP_U_CHR_Villager_02", "LOP_U_CHR_Villager_03", "LOP_U_CHR_Villager_04", "LOP_U_CHR_Worker_01", "LOP_U_CHR_Worker_02", "LOP_U_CHR_Worker_03", "LOP_U_CHR_Worker_04", "LOP_U_CHR_Citizen_01", "LOP_U_CHR_Citizen_02", "LOP_U_CHR_Citizen_04", "LOP_U_TAK_Civ_Fatigue_01", "LOP_U_TAK_Civ_Fatigue_02", "LOP_U_TAK_Civ_Fatigue_04", "LOP_U_TAK_Civ_Fatigue_05", "LOP_U_TAK_Civ_Fatigue_06", "LOP_U_TAK_Civ_Fatigue_07", "LOP_U_TAK_Civ_Fatigue_08", "LOP_U_TAK_Civ_Fatigue_09", "LOP_U_TAK_Civ_Fatigue_10", "LOP_U_TAK_Civ_Fatigue_11", "LOP_U_TAK_Civ_Fatigue_12", "LOP_U_TAK_Civ_Fatigue_13", "LOP_U_TAK_Civ_Fatigue_14", "LOP_U_TAK_Civ_Fatigue_15", "LOP_U_TAK_Civ_Fatigue_16", "LOP_U_TAK_Civ_Fatigue_01", "LOP_U_TAK_Civ_Fatigue_02", "LOP_U_TAK_Civ_Fatigue_04", "LOP_U_TAK_Civ_Fatigue_05", "LOP_U_TAK_Civ_Fatigue_06", "LOP_U_TAK_Civ_Fatigue_07", "LOP_U_TAK_Civ_Fatigue_08", "LOP_U_TAK_Civ_Fatigue_09", "LOP_U_TAK_Civ_Fatigue_10", "LOP_U_TAK_Civ_Fatigue_11", "LOP_U_TAK_Civ_Fatigue_12", "LOP_U_TAK_Civ_Fatigue_13", "LOP_U_TAK_Civ_Fatigue_14", "LOP_U_TAK_Civ_Fatigue_15", "LOP_U_TAK_Civ_Fatigue_16"];
									OPEX_civilian_headgears append ["LOP_H_Villager_cap", "LOP_H_Worker_cap", "LOP_H_Pakol", "LOP_H_Pakol", "LOP_H_Pakol", "LOP_H_Pakol", "LOP_H_Pakol", "LOP_H_Pakol", "LOP_H_Turban","LOP_H_Turban","LOP_H_Turban", "LOP_H_Turban","LOP_H_Turban","LOP_H_Turban", "LOP_H_Turban","LOP_H_Turban","LOP_H_Turban", "LOP_H_Turban","LOP_H_Turban","LOP_H_Turban", "LOP_H_Turban","LOP_H_Turban","LOP_H_Turban"];
								};
							// OTHER MIDDLE-EAST REGIONS (IRAQ, SYRIA...)
							default
								{
									OPEX_civilian_units append ["LOP_Tak_Civ_Random"];
									OPEX_civilian_uniforms append ["LOP_U_CHR_Villager_02", "LOP_U_CHR_Villager_03", "LOP_U_CHR_Villager_04", "LOP_U_CHR_Worker_01", "LOP_U_CHR_Worker_02", "LOP_U_CHR_Worker_03", "LOP_U_CHR_Worker_04", "LOP_U_CHR_Citizen_01", "LOP_U_CHR_Citizen_02", "LOP_U_CHR_Citizen_04", "U_C_Poor_1", "U_BG_Guerilla2_1", "U_BG_Guerilla2_2", "U_BG_Guerilla2_3", "U_BG_Guerilla3_1", "LOP_U_CHR_Villager_02", "LOP_U_CHR_Villager_03", "LOP_U_CHR_Villager_04", "LOP_U_CHR_Worker_01", "LOP_U_CHR_Worker_02", "LOP_U_CHR_Worker_03", "LOP_U_CHR_Worker_04", "LOP_U_CHR_Citizen_01", "LOP_U_CHR_Citizen_02", "LOP_U_CHR_Citizen_04", "LOP_U_TAK_Civ_Fatigue_01", "LOP_U_TAK_Civ_Fatigue_02", "LOP_U_TAK_Civ_Fatigue_04", "LOP_U_TAK_Civ_Fatigue_05", "LOP_U_TAK_Civ_Fatigue_06", "LOP_U_TAK_Civ_Fatigue_07", "LOP_U_TAK_Civ_Fatigue_08", "LOP_U_TAK_Civ_Fatigue_09", "LOP_U_TAK_Civ_Fatigue_10", "LOP_U_TAK_Civ_Fatigue_11", "LOP_U_TAK_Civ_Fatigue_12", "LOP_U_TAK_Civ_Fatigue_13", "LOP_U_TAK_Civ_Fatigue_14", "LOP_U_TAK_Civ_Fatigue_15", "LOP_U_TAK_Civ_Fatigue_16"];
									OPEX_civilian_headgears append ["LOP_H_Villager_cap", "LOP_H_Worker_cap", "LOP_H_Pakol", "LOP_H_Pakol", "LOP_H_Pakol", "LOP_H_Turban","LOP_H_Turban","LOP_H_Turban"];
								};
						};
				};

			// AFRICA REGION
			case "africa" :
				{
					OPEX_civilian_units append ["LOP_AFR_Civ_Man_01"];
					OPEX_civilian_uniforms append ["LOP_U_AFR_Civ_01","LOP_U_AFR_Civ_02","LOP_U_AFR_Civ_03","LOP_U_AFR_Civ_04","LOP_U_AFR_Civ_05","LOP_U_AFR_Civ_06","LOP_U_AFR_Civ_01S","LOP_U_AFR_Civ_02S","LOP_U_AFR_Civ_03S","LOP_U_AFR_Civ_04S","LOP_U_AFR_Civ_05S","LOP_U_AFR_Civ_06S","LOP_U_PMC_shorts_floral","LOP_U_PMC_shorts_blue_hi","LOP_U_PMC_shorts_red_hi","LOP_U_PMC_shorts_m81_olv","LOP_U_PMC_shorts_grn_palm","LOP_U_PMC_shorts_prp_palm","LOP_U_PMC_shorts_blue_plaid","LOP_U_PMC_shorts_tacky","LOP_U_PMC_shorts_grn_plaid","LOP_U_PMC_shorts_orng_plaid","LOP_U_PMC_shorts_red_plaid","LOP_U_PMC_shorts_tan_olv","LOP_U_BH_Fatigue_GUE_M81_OLV","LOP_U_AFR_Fatigue_03"];
					OPEX_civilian_headgears append ["LOP_H_Cowboy_hat"];
				};

			// PACIFIC REGION
			case "pacific" :
				{
					OPEX_civilian_units append ["LOP_AFR_Civ_Man_01"];
					OPEX_civilian_uniforms append ["LOP_U_AFR_Civ_01","LOP_U_AFR_Civ_02","LOP_U_AFR_Civ_03","LOP_U_AFR_Civ_04","LOP_U_AFR_Civ_05","LOP_U_AFR_Civ_06","LOP_U_AFR_Civ_01S","LOP_U_AFR_Civ_02S","LOP_U_AFR_Civ_03S","LOP_U_AFR_Civ_04S","LOP_U_AFR_Civ_05S","LOP_U_AFR_Civ_06S","LOP_U_PMC_shorts_floral","LOP_U_PMC_shorts_blue_hi","LOP_U_PMC_shorts_red_hi","LOP_U_PMC_shorts_m81_olv","LOP_U_PMC_shorts_grn_palm","LOP_U_PMC_shorts_prp_palm","LOP_U_PMC_shorts_blue_plaid","LOP_U_PMC_shorts_tacky","LOP_U_PMC_shorts_grn_plaid","LOP_U_PMC_shorts_orng_plaid","LOP_U_PMC_shorts_red_plaid","LOP_U_PMC_shorts_tan_olv","LOP_U_PMC_floral","LOP_U_PMC_blue_hi","LOP_U_PMC_red_hi","LOP_U_PMC_grn_palm","LOP_U_PMC_prp_palm","LOP_U_PMC_blue_plaid","LOP_U_PMC_grn_plaid","LOP_U_PMC_orng_plaid","LOP_U_PMC_red_plaid","LOP_U_BH_Fatigue_GUE_M81_OLV","LOP_U_AFR_Fatigue_03"];
					OPEX_civilian_headgears append [];
				};

		};

	// VEHICLES
	OPEX_civilian_cars append ["LOP_TAK_Civ_Landrover","LOP_TAK_Civ_Offroad","LOP_TAK_Civ_UAZ","LOP_TAK_Civ_UAZ_Open"];
	OPEX_civilian_trucks append ["LOP_TAK_Civ_Ural_open","LOP_TAK_Civ_Ural"];
	OPEX_civilian_vehicles = OPEX_civilian_cars + OPEX_civilian_trucks; // don't delete this line if you have defined any of these variables