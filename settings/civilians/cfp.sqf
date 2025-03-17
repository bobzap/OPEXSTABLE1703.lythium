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

	if (!(isClass (configFile >> "CfgPatches" >> "cfp_main"))) exitWith {}; // replace "xxxxx" by the name of the file you need to check
	if (!(isClass (configFile >> "CfgPatches" >> "cfp_uniforms"))) exitWith {}; // replace "xxxxx" by the name of the file you need to check
	if (!(isClass (configFile >> "CfgPatches" >> "cfp_vests"))) exitWith {}; // replace "xxxxx" by the name of the file you need to check
	if (!(isClass (configFile >> "CfgPatches" >> "cfp_vehicles"))) exitWith {}; // replace "xxxxx" by the name of the file you need to check

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
					OPEX_civilian_uniforms append ["SP_0000_Standard_Coverall_BlueDark","SP_0000_Standard_Coverall_BlueFrost","CFP_U_O_RUMVD_Gorka_Grey"];
					OPEX_civilian_headgears append ["SP_BaseballCap_TweedCheckedBrown","SP_BaseballCap_TweedCheckedGreen","SP_BaseballCap_TweedCheckedGrey","SP_BaseballCap_Yellow","SP_BeanieHat_Black","SP_BeanieHat_Green","SP_BeanieHat_Tan"];
				};

			// MIDDLE-EAST REGION
			case "middleEast" :
				{
					switch (OPEX_mapEnemy) do
						{
							// AFGHANISTAN + PAKISTAN
							case "TALIB" :
								{
									OPEX_civilian_units append ["CFP_C_ME_Civ_1_01"];
									OPEX_civilian_uniforms append ["CFP_U_KhetPartug_Long_Black","CFP_U_KhetPartug_Long_Blue","CFP_U_KhetPartug_Long_BlueGrey","CFP_U_KhetPartug_Long_Brown","CFP_U_KhetPartug_Long_Creme","CFP_U_KhetPartug_Long_Grey","CFP_U_KhetPartug_Long_light_olive","CFP_U_KhetPartug_Long_olive","CFP_U_KhetPartug_Long_Purple","CFP_U_KhetPartug_Long_Tan","CFP_U_KhetPartug_Long_White","CFP_U_KhetPartug_Long_Black","CFP_U_KhetPartug_Long_Blue","CFP_U_KhetPartug_Long_BlueGrey","CFP_U_KhetPartug_Long_Brown","CFP_U_KhetPartug_Long_Creme","CFP_U_KhetPartug_Long_Grey","CFP_U_KhetPartug_Long_light_olive","CFP_U_KhetPartug_Long_olive","CFP_U_KhetPartug_Long_Purple","CFP_U_KhetPartug_Long_Tan","CFP_U_KhetPartug_Long_White","CFP_U_KhetPartug_Short_Black","CFP_U_KhetPartug_Short_Blue","CFP_U_KhetPartug_Short_BlueGrey","CFP_U_KhetPartug_Short_Brown","CFP_U_KhetPartug_Short_Creme","CFP_U_KhetPartug_Short_GreenOlive","CFP_U_KhetPartug_Short_Grey","CFP_U_KhetPartug_Short_light_olive","CFP_U_KhetPartug_Short_olive","CFP_U_KhetPartug_Short_Purple","CFP_U_KhetPartug_Short_Tan","CFP_U_KhetPartug_Short_White"];
									OPEX_civilian_headgears append ["CFP_Lungee_Open_BlueGrey","CFP_Lungee_Open_Blue","CFP_Lungee_Open_Brown","CFP_Lungee_Open_Creme","CFP_Lungee_Open_Grey","CFP_Lungee_Open_LightOlive","CFP_Lungee_Open_Tan","CFP_Lungee_Shemagh_Black","CFP_Lungee_Shemagh_BlueGrey","CFP_Lungee_Shemagh_Grey","CFP_Lungee_Shemagh_Olive","CFP_Lungee_Shemagh","CFP_Lungee_Shemagh_White"];
								};
							// OTHER MIDDLE-EAST REGIONS (IRAQ, SYRIA...)
							default
								{
									OPEX_civilian_units append ["CFP_C_ME_Civ_1_01"];
									OPEX_civilian_uniforms append ["CFP_U_KhetPartug_Short_Black","CFP_U_KhetPartug_Short_Blue","CFP_U_KhetPartug_Short_BlueGrey","CFP_U_KhetPartug_Short_Brown","CFP_U_KhetPartug_Short_Creme","CFP_U_KhetPartug_Short_GreenOlive","CFP_U_KhetPartug_Short_Grey","CFP_U_KhetPartug_Short_light_olive","CFP_U_KhetPartug_Short_olive","CFP_U_KhetPartug_Short_Purple","CFP_U_KhetPartug_Short_Tan","CFP_U_KhetPartug_Short_White"];
									OPEX_civilian_headgears append ["CFP_Lungee_Open_BlueGrey","CFP_Lungee_Open_Blue","CFP_Lungee_Open_Brown","CFP_Lungee_Open_Creme","CFP_Lungee_Open_Grey","CFP_Lungee_Open_LightOlive","CFP_Lungee_Open_Tan","CFP_Lungee_Shemagh_Black","CFP_Lungee_Shemagh_BlueGrey","CFP_Lungee_Shemagh_Grey","CFP_Lungee_Shemagh_Olive","CFP_Lungee_Shemagh","CFP_Lungee_Shemagh_White"];
								};
						};
				};

			// AFRICA REGION
			case "africa" :
				{
					OPEX_civilian_units append ["CFP_C_AFRCHRISTIAN_Civ_1_01"];
					OPEX_civilian_uniforms append ["CFP_Bandit_Adidas","CFP_Bandit_Africa","CFP_Bandit_Chang","CFP_GUER_JEM","CFP_Polo_Liverpool","CFP_Polo_RealMadrid","CFP_Polo_Sudan"];
					OPEX_civilian_headgears append ["SP_BaseballCap_TweedCheckedBrown","SP_BaseballCap_TweedCheckedGreen","SP_BaseballCap_TweedCheckedGrey","SP_BaseballCap_Yellow"];
				};

			// PACIFIC REGION
			case "pacific" :
				{
					OPEX_civilian_units append ["CFP_C_AFRCHRISTIAN_Civ_1_01"];
					OPEX_civilian_uniforms append ["CFP_Bandit_Adidas","CFP_Bandit_Africa","CFP_Bandit_Chang","CFP_GUER_JEM","CFP_Polo_Liverpool","CFP_Polo_RealMadrid","CFP_Polo_Sudan"];
					OPEX_civilian_headgears append ["SP_BaseballCap_TweedCheckedBrown","SP_BaseballCap_TweedCheckedGreen","SP_BaseballCap_TweedCheckedGrey","SP_BaseballCap_Yellow"];
				};
		};

	// OTHER STUFF
	OPEX_civilian_vests append ["CFP_Field_Satchel","CFP_TakJacket_OD"];
	OPEX_civilian_glasses append [];
	OPEX_civilian_sunglasses append ["SP_Shades_Black"];
	OPEX_civilian_scarfs append ["CFP_Neck_Plain_Atacs","CFP_Neck_Plain_Atacs2","CFP_Neck_Plain2","CFP_Neck_Plain4","CFP_Neck_Plain3","CFP_Shemagh_Neck_Black","CFP_Shemagh_Neck_Creme","CFP_Shemagh_Neck_Gold","CFP_Shemagh_Neck_M81"];
	OPEX_civilian_beards append ["CFP_Beard","CFP_Beard_Grey","CFP_Beard","CFP_Beard_Grey","CFP_Beard","CFP_Beard_Grey","CFP_Scarfbeard_green","CFP_Scarfbeard_grey","CFP_Scarfbeard_tan","CFP_Scarfbeard_white"];

	// VEHICLES
	OPEX_civilian_cars append ["CFP_C_AFG_Datsun_Pickup_01","CFP_C_AFG_Datsun_Pickup_Covered_01","CFP_C_AFG_Lada_01","CFP_C_AFG_Skoda_105_L_01","CFP_C_AFG_Skoda_Octavia_01","CFP_C_AFG_SUV_01","CFP_C_AFRISLAMIC_Skoda_Blue_01","CFP_C_AFRISLAMIC_Skoda_Green_01","CFP_C_AFRISLAMIC_Skoda_White_01","CFP_C_ASIA_Datsun_Pickup_01"];
	OPEX_civilian_trucks append ["CFP_C_AFG_Zamak_Transport_Covered_01","CFP_C_AFRCHRISTIAN_Ikarus_01","CFP_C_AFRISLAMIC_Ural_Blue_01","CFP_C_AFRISLAMIC_Ural_Yellow_01","CFP_C_ASIA_Praga_V3S_01"];
	OPEX_civilian_boats append ["CFP_C_ASIA_Fishing_Boat_01","CFP_C_ASIA_Fishing_Boat_01","CFP_C_ASIA_Fishing_Boat_01","CFP_C_ASIA_Water_Scooter_01"];
	OPEX_civilian_vehicles = OPEX_civilian_cars + OPEX_civilian_trucks; // don't delete this line if you have defined any of these variables