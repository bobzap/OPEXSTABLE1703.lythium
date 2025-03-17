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

	if (!(isClass (configFile >> "CfgPatches" >> "A3_Characters_F"))) exitWith {}; // replace "xxxxx" by the name of the file you need to check

// =======================================================================================================================
// PART 2 (do NOT edit or delete this part)
// =======================================================================================================================

	OPEX_civilian_side1 = civilian;
	OPEX_civilian_side2 = "civ";
	OPEX_civilian_AIskill = [0.10, 0.50];
	waitUntil {!isNil "OPEX_mapRegion"};
	waitUntil {!isNil "OPEX_params_ready"};
	waitUntil {OPEX_params_ready};

// =======================================================================================================================
// PART 3 (customizable part)
// =======================================================================================================================

	// UNITS & GEAR
	switch (OPEX_mapRegion) do

		{
			// EUROPE REGION
			case "europe" :
				{
					OPEX_civilian_units = ["C_man_1"];
					OPEX_civilian_uniforms = ["U_BG_Guerilla3_1","U_Rangemaster","U_Competitor","U_BG_Guerrilla_6_1","U_BG_Guerilla2_2","U_BG_Guerilla2_3","U_BG_Guerilla2_1","U_Marshal","U_C_Poor_1"];
					if (1.02179e+006 in (getDLCs 1)) then {OPEX_civilian_uniforms append ["U_O_R_Gorka_01_black_F","U_O_R_Gorka_01_F","U_O_R_Gorka_01_brown_F"]};
					OPEX_civilian_headgears = ["H_Cap_grn_BI","H_Cap_tan","H_Cap_blk","H_Cap_oli","H_Cap_grn","H_Cap_blu","H_Cap_red","H_Cap_usblack","H_Cap_khaki_specops_UK","H_Cap_surfer","H_Hat_blue","H_Hat_checker","H_Hat_grey","H_Hat_tan","H_Hat_brown","H_StrawHat","H_StrawHat_dark"];
				};

			// MIDDLE-EAST REGION
			case "middleEast" :
				{
					switch (OPEX_mapEnemy) do
						{
							// AFGHANISTAN + PAKISTAN
							case "TALIB" :
								{
									OPEX_civilian_units = ["C_man_1"];
									OPEX_civilian_uniforms = ["U_BG_Guerilla2_2","U_BG_Guerilla2_3","U_BG_Guerilla2_1"];
									if (395180 in (getDLCs 1)) then {OPEX_civilian_uniforms append ["U_I_C_Soldier_Bandit_3_F"]};
									if (1.02179e+006 in (getDLCs 1)) then {OPEX_civilian_uniforms append ["U_C_Uniform_Farmer_01_F"]};
									OPEX_civilian_headgears = ["H_Cap_tan","H_Cap_blk","H_Cap_oli","H_Cap_grn","H_Cap_blu","H_Cap_red"];
								};
							// OTHER MIDDLE-EAST REGIONS (IRAQ, SYRIA...)
							default
								{
									OPEX_civilian_units = ["C_man_1"];
									OPEX_civilian_uniforms = ["U_BG_Guerilla2_2","U_BG_Guerilla2_3","U_BG_Guerilla2_1"];
									if (395180 in (getDLCs 1)) then {OPEX_civilian_uniforms append ["U_I_C_Soldier_Bandit_3_F"]};
									if (1.02179e+006 in (getDLCs 1)) then {OPEX_civilian_uniforms append ["U_C_Uniform_Farmer_01_F"]};
									OPEX_civilian_headgears = ["H_Cap_tan","H_Cap_blk","H_Cap_oli","H_Cap_grn","H_Cap_blu","H_Cap_red"];
								};
						};
				};

			// AFRICA REGION
			case "africa" :
				{
					OPEX_civilian_units = ["C_man_polo_1_F_afro"];
					OPEX_civilian_uniforms = ["U_C_Poloshirt_blue","U_C_Poloshirt_burgundy","U_C_Poloshirt_stripped","U_C_Poloshirt_redwhite","U_C_Poloshirt_salmon","U_C_Poloshirt_tricolour","U_C_Poor_1"];
					if (395180 in (getDLCs 1)) then {OPEX_civilian_uniforms append ["U_I_C_Soldier_Bandit_4_F","U_I_C_Soldier_Bandit_5_F","U_I_C_Soldier_Bandit_1_F","U_I_C_Soldier_Bandit_3_F","U_I_C_Soldier_Bandit_2_F","U_C_Man_casual_4_F","U_C_Man_casual_5_F","U_C_Man_casual_6_F","U_I_C_Soldier_Para_4_F"]};
					if (1.02179e+006 in (getDLCs 1)) then {OPEX_civilian_uniforms append ["U_I_L_Uniform_01_tshirt_sport_F"]};
					OPEX_civilian_headgears = ["H_Bandanna_blu","H_Bandanna_cbr","H_Bandanna_khk","H_Bandanna_gry","H_Bandanna_sand","H_Bandanna_surfer","H_Bandanna_surfer_blk","H_Bandanna_surfer_grn","H_Bandanna_sgg"];
					if (571710 in (getDLCs 1)) then {OPEX_civilian_headgears append ["H_Hat_Safari_olive_F","H_Hat_Safari_sand_F"]};
				};

			// PACIFIC REGION
			case "pacific" :
				{
					OPEX_civilian_units = ["C_man_polo_1_F_afro"];
					OPEX_civilian_uniforms = ["U_C_Poloshirt_blue","U_C_Poloshirt_burgundy","U_C_Poloshirt_stripped","U_C_Poloshirt_redwhite","U_C_Poloshirt_salmon","U_C_Poloshirt_tricolour"];
					OPEX_civilian_headgears = ["H_Bandanna_blu","H_Bandanna_cbr","H_Bandanna_khk","H_Bandanna_gry","H_Bandanna_sand","H_Bandanna_surfer","H_Bandanna_surfer_blk","H_Bandanna_surfer_grn","H_Bandanna_sgg","H_Cap_tan","H_Cap_blk","H_Cap_oli","H_Cap_grn","H_Cap_blu","H_Cap_red","H_Cap_surfer","H_Hat_blue","H_Hat_checker","H_Hat_grey","H_Hat_tan","H_Hat_brown","H_Booniehat_khk","H_Booniehat_oli","H_Booniehat_tan","H_StrawHat","H_StrawHat_dark"];
				};
		};

	// OTHER STUFF
	OPEX_civilian_vests = [];
	OPEX_civilian_glasses = ["G_Squares","G_Spectacles"];
	OPEX_civilian_sunglasses = ["G_Shades_Blue","G_Shades_Black","G_Shades_Red","G_Shades_Green","G_Squares_Tinted","G_Squares_Tinted","G_Squares_Tinted","G_Aviator","G_Aviator","G_Spectacles_Tinted","G_Spectacles_Tinted","G_Spectacles_Tinted"];
	OPEX_civilian_scarfs = [];
	OPEX_civilian_beards = [];
	OPEX_civilian_items = OPEX_civilian_headgears + OPEX_civilian_glasses + OPEX_civilian_sunglasses + OPEX_civilian_scarfs;

	// JOBS
	OPEX_civilian_jobs =
		[
			"STR_civilian_job_unemployed", "STR_civilian_job_farmer", "STR_civilian_job_merchent", "STR_civilian_job_craftsman",
			"STR_civilian_job_unemployed", "STR_civilian_job_farmer", "STR_civilian_job_merchent", "STR_civilian_job_craftsman",
			"STR_civilian_job_bricklayer", "STR_civilian_job_goatbreeder", "STR_civilian_job_sheepbreeder", "STR_civilian_job_carpetweaver"
		];

	// VEHICLES
	OPEX_civilian_cars = ["C_Hatchback_01_F","C_SUV_01_F","C_Offroad_02_unarmed_F","C_Offroad_01_F"]; if (1.02179e+006 in (getDLCs 1)) then {OPEX_civilian_cars append ["C_Offroad_01_covered_F","C_Tractor_01_F"]};
	OPEX_civilian_trucks = ["C_Van_01_box_F","C_Van_01_transport_F","C_Truck_02_transport_F"];
	OPEX_civilian_boats = ["C_Boat_Civil_01_F","C_Rubberboat"];
	OPEX_civilian_vehicles = OPEX_civilian_cars + OPEX_civilian_trucks; // don't delete this line if you have defined any of these variables

	// REMOVING VANILLA VEHICLES IF BETTER ONES (FROM MODS) HAVE BEEN DETECTED (DON'T DELETE THIS LINE)
	waitUntil {!isNil "OPEX_params_ready"};
	waitUntil {OPEX_params_ready};
	if (count OPEX_civilian_cars <= 7) exitWith {};
	{if (_x in OPEX_civilian_cars) then {OPEX_civilian_cars = OPEX_civilian_cars - [_x]}} forEach ["C_Hatchback_01_F","C_SUV_01_F","C_Offroad_02_unarmed_F","C_Offroad_01_F","C_Offroad_01_covered_F","C_Tractor_01_F"];
	{if (_x in OPEX_civilian_trucks) then {OPEX_civilian_trucks = OPEX_civilian_trucks - [_x]}} forEach ["C_Van_01_box_F","C_Van_01_transport_F","C_Truck_02_transport_F"];
	OPEX_civilian_vehicles = OPEX_civilian_cars + OPEX_civilian_trucks;