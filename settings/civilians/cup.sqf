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

	if (!(isClass (configFile >> "CfgPatches" >> "CUP_Vehicles_Core"))) exitWith {}; // replace "xxxxx" by the name of the file you need to check
	if (!(isClass (configFile >> "CfgPatches" >> "CUP_Weapons_WeaponsCore"))) exitWith {}; // replace "xxxxx" by the name of the file you need to check
	if (!(isClass (configFile >> "CfgPatches" >> "CUP_Creatures_Extra"))) exitWith {}; // replace "xxxxx" by the name of the file you need to check

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
					OPEX_civilian_uniforms append ["CUP_U_I_GUE_Anorak_01","CUP_U_I_GUE_Anorak_03","CUP_U_I_GUE_Anorak_02","CUP_U_O_CHDKZ_Bardak","CUP_U_O_CHDKZ_Lopotev","CUP_U_C_Citizen_02","CUP_U_C_Citizen_01","CUP_U_C_Citizen_04","CUP_U_C_Citizen_03","CUP_U_C_Priest_01","CUP_U_C_Labcoat_02","CUP_U_C_Labcoat_03","CUP_U_C_Mechanic_01","CUP_U_C_Mechanic_02","CUP_U_C_Mechanic_03","CUP_U_C_Pilot_01","CUP_U_C_Profiteer_02","CUP_U_C_Profiteer_03","CUP_U_C_Profiteer_01","CUP_U_C_Profiteer_04","CUP_U_C_racketeer_01","CUP_U_C_racketeer_02","CUP_U_C_racketeer_03","CUP_U_C_racketeer_04","CUP_U_C_Rocker_01","CUP_U_C_Rocker_03","CUP_U_C_Rocker_02","CUP_U_C_Rocker_04","CUP_U_C_Villager_01","CUP_U_C_Villager_04","CUP_U_C_Villager_02","CUP_U_C_Villager_03","CUP_U_C_Woodlander_01","CUP_U_C_Woodlander_02","CUP_U_C_Woodlander_03","CUP_U_C_Woodlander_04","CUP_U_C_Worker_03","CUP_U_C_Worker_04","CUP_U_C_Worker_02","CUP_U_C_Worker_01","CUP_H_PMC_Cap_Back_Tan","CUP_H_NAPA_Fedora"];
					OPEX_civilian_headgears append ["CUP_H_PMC_Beanie_Black","CUP_H_C_Beanie_01","CUP_H_C_Beanie_02","CUP_H_C_Beanie_03","CUP_H_C_Beanie_04","CUP_H_SLA_BeanieGreen","CUP_H_PMC_Beanie_Khaki","CUP_H_C_Beret_04","CUP_H_C_Beret_01","CUP_H_C_Beret_02","CUP_H_C_Beret_03","CUP_H_PMC_Cap_Burberry","CUP_H_PMC_Cap_Grey","CUP_H_C_MAGA_01","CUP_H_PMC_Cap_Back_Burberry","CUP_H_PMC_Cap_Back_Grey","CUP_H_C_Ushanka_03","CUP_H_C_Ushanka_02","CUP_H_C_Ushanka_01","CUP_H_C_Ushanka_04"];
				};

			// MIDDLE-EAST REGION
			case "middleEast" :
				{
					switch (OPEX_mapEnemy) do
						{
							// AFGHANISTAN + PAKISTAN
							case "TALIB" :
								{
									OPEX_civilian_units append ["CUP_C_TK_Man_04"];
									OPEX_civilian_uniforms append ["CUP_O_TKI_Khet_Partug_01","CUP_O_TKI_Khet_Partug_02","CUP_O_TKI_Khet_Partug_03","CUP_O_TKI_Khet_Partug_04","CUP_O_TKI_Khet_Partug_01","CUP_O_TKI_Khet_Partug_02","CUP_O_TKI_Khet_Partug_03","CUP_O_TKI_Khet_Partug_04","CUP_O_TKI_Khet_Partug_05","CUP_O_TKI_Khet_Partug_06","CUP_O_TKI_Khet_Partug_07","CUP_O_TKI_Khet_Partug_08"];
									OPEX_civilian_headgears append ["CUP_H_TKI_Lungee_Open_01","CUP_H_TKI_Lungee_Open_02","CUP_H_TKI_Lungee_Open_03","CUP_H_TKI_Lungee_Open_04","CUP_H_TKI_Lungee_Open_05","CUP_H_TKI_Lungee_Open_06","CUP_H_TKI_Lungee_Open_01","CUP_H_TKI_Lungee_Open_02","CUP_H_TKI_Lungee_Open_03","CUP_H_TKI_Lungee_Open_04","CUP_H_TKI_Lungee_Open_05","CUP_H_TKI_Lungee_Open_06","CUP_H_TKI_Lungee_Open_01","CUP_H_TKI_Lungee_Open_02","CUP_H_TKI_Lungee_Open_03","CUP_H_TKI_Lungee_Open_04","CUP_H_TKI_Lungee_Open_05","CUP_H_TKI_Lungee_Open_06","CUP_H_TKI_Pakol_1_01","CUP_H_TKI_Pakol_2_04","CUP_H_TKI_Pakol_2_05","CUP_H_TKI_Pakol_2_06","CUP_H_TKI_Pakol_1_03","CUP_H_TKI_Pakol_1_04","CUP_H_TKI_Pakol_1_05","CUP_H_TKI_Pakol_1_06","CUP_H_TKI_Pakol_2_01","CUP_H_TKI_Pakol_2_02","CUP_H_TKI_Pakol_2_03","CUP_H_TKI_SkullCap_01","CUP_H_TKI_SkullCap_02","CUP_H_TKI_SkullCap_03","CUP_H_TKI_SkullCap_04","CUP_H_TKI_SkullCap_05","CUP_H_TKI_SkullCap_06"];
								};
							// OTHER MIDDLE-EAST REGIONS (IRAQ, SYRIA...)
							default
								{
									OPEX_civilian_units append ["CUP_C_TK_Man_04"];
									OPEX_civilian_uniforms append ["CUP_O_TKI_Khet_Jeans_01","CUP_O_TKI_Khet_Jeans_02","CUP_O_TKI_Khet_Jeans_03","CUP_O_TKI_Khet_Jeans_04","CUP_O_TKI_Khet_Partug_05","CUP_O_TKI_Khet_Partug_06","CUP_O_TKI_Khet_Partug_07","CUP_O_TKI_Khet_Partug_08"];
									OPEX_civilian_headgears append ["CUP_H_PMC_Cap_Burberry","CUP_H_PMC_Cap_Grey","CUP_H_PMC_Cap_Back_Burberry","CUP_H_PMC_Cap_Back_Grey","CUP_H_PMC_Cap_Back_Tan","CUP_H_TKI_Pakol_1_01","CUP_H_TKI_Pakol_2_04","CUP_H_TKI_Pakol_2_05","CUP_H_TKI_Pakol_2_06","CUP_H_TKI_Pakol_1_03","CUP_H_TKI_Pakol_1_04","CUP_H_TKI_Pakol_1_05","CUP_H_TKI_Pakol_1_06","CUP_H_TKI_Pakol_2_01","CUP_H_TKI_Pakol_2_02","CUP_H_TKI_Pakol_2_03","CUP_H_TKI_SkullCap_01","CUP_H_TKI_SkullCap_02","CUP_H_TKI_SkullCap_03","CUP_H_TKI_SkullCap_04","CUP_H_TKI_SkullCap_05","CUP_H_TKI_SkullCap_06"];
								};
						};
				};

			// AFRICA REGION
			case "africa" :
				{
					OPEX_civilian_units append ["C_man_polo_1_F_afro"];
					OPEX_civilian_uniforms append [];
					OPEX_civilian_headgears append ["CUP_H_PMC_Cap_Burberry","CUP_H_PMC_Cap_Grey","CUP_H_C_MAGA_01","CUP_H_PMC_Cap_Back_Burberry","CUP_H_PMC_Cap_Back_Grey","CUP_H_PMC_Cap_Back_Tan"];
				};

			// PACIFIC REGION
			case "pacific" :
				{
					OPEX_civilian_units append [];
					OPEX_civilian_uniforms append ["CUP_I_B_PMC_Unit_3","CUP_I_B_PMC_Unit_2","CUP_I_B_PMC_Unit_1","CUP_I_B_PMC_Unit_4"];
					OPEX_civilian_headgears append ["CUP_H_PMC_Cap_Burberry","CUP_H_PMC_Cap_Grey","CUP_H_C_MAGA_01","CUP_H_PMC_Cap_Back_Burberry","CUP_H_PMC_Cap_Back_Grey","CUP_H_PMC_Cap_Back_Tan"];
				};
		};

	// OTHER STUFF
	OPEX_civilian_vests append ["CUP_V_OI_TKI_Jacket1_04","CUP_V_OI_TKI_Jacket1_06","CUP_V_OI_TKI_Jacket1_05","CUP_V_OI_TKI_Jacket5_04","CUP_V_OI_TKI_Jacket5_05","CUP_V_OI_TKI_Jacket5_06","CUP_V_OI_TKI_Jacket6_04","CUP_V_OI_TKI_Jacket6_05","CUP_V_OI_TKI_Jacket6_06"];
	OPEX_civilian_glasses append [];
	OPEX_civilian_sunglasses append [];
	OPEX_civilian_scarfs append ["CUP_TK_NeckScarf","CUP_FR_NeckScarf","CUP_FR_NeckScarf2","CUP_FR_NeckScarf5","CUP_FR_NeckScarf4"];
	OPEX_civilian_beards append [];

	// VEHICLES
	OPEX_civilian_cars append ["CUP_C_Skoda_Blue_CIV","CUP_C_Skoda_Green_CIV","CUP_C_Skoda_Red_CIV","CUP_C_Skoda_White_CIV","CUP_C_Datsun_Covered","CUP_C_Datsun_Plain","CUP_C_Datsun_Tubeframe","CUP_C_Lada_White_CIV","CUP_C_Lada_Red_CIV","CUP_C_SUV_CIV","CUP_C_Tractor_CIV","CUP_C_Tractor_Old_CIV","CUP_C_TT650_RU","CUP_C_S1203_CIV","CUP_C_Lada_GreenTK_CIV","CUP_C_Lada_TK2_CIV","CUP_C_UAZ_Open_TK_CIV","CUP_C_Volha_Blue_TKCIV","CUP_C_Volha_Gray_TKCIV","CUP_C_Volha_Limo_TKCIV"];
	OPEX_civilian_trucks append ["CUP_C_Volha_Gray_TKCIV","CUP_C_Volha_Limo_TKCIV","CUP_C_Ural_Civ_01","CUP_C_V3S_Covered_TKC","CUP_C_V3S_Open_TKC","CUP_C_Ikarus_TKC","CUP_C_Ural_Open_Civ_01","CUP_C_Ural_Civ_03","CUP_C_Ural_Open_Civ_03"];
	OPEX_civilian_boats append ["CUP_C_Fishing_Boat_Chernarus","CUP_C_Fishing_Boat_Chernarus","CUP_C_Fishing_Boat_Chernarus","CUP_C_PBX_CIV","CUP_C_Zodiac_CIV"];
	OPEX_civilian_vehicles = OPEX_civilian_cars + OPEX_civilian_trucks; // don't delete this line if you have defined any of these variables