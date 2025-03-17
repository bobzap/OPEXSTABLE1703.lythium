//////////////////////////////////////////////////////////////////
// AMBIENT MUSICS (WHEN STARTING A NEW TASK IN SINGLE PLAYER) ///
//////////////////////////////////////////////////////////////////

	waitUntil {!isNil "OPEX_mapRegion"};

	// PUNCHY MUSICS, FOR URGENT TASKS (RESCUE, IMMEDIATE ASSAULT...)
	ambianceMusic_punchy =
		[
			"BackgroundTrack02_F", "BackgroundTrack03_F",
			"LeadTrack01_F_Heli", "LeadTrack01a_F", "LeadTrack02_F_Mark", "LeadTrack02b_F_EPB",
			"LeadTrack03_F", "LeadTrack03_F_EXP", "LeadTrack03a_F_EPA", "LeadTrack04_F", "LeadTrack04_F_EPC", "LeadTrack04a_F", "LeadTrack05_F",
			"Track03_OnTheRoad", "Track06_CarnHeli", "Track07_ActionDark",
			"Track10_StageB_action", "Track12_StageC_action",
			"EventTrack01_F_Jets",
			"LeadTrack01_F_Malden",
			"LeadTrack01_F_Tacops", "LeadTrack02_F_Tacops", "LeadTrack03_F_Tacops", "LeadTrack04_F_Tacops",
			"MainTheme_F_Tank", "LeadTrack01_F_Tank", "LeadTrack02_F_Tank", "LeadTrack05_F_Tank", "LeadTrack06_F_Tank",
			"Music_Battle_Human", "Music_Russian_Theme", "Music_Battle_Human_Loop", "Music_Battle_Alien_Loop_01", "Music_Battle_Alien_Loop_02", "Music_Battle_Alien_Loop_03",
			"Music_Freeroam_End",
			"LeadTrack01_F_6th_Anniversary_Remix"
		];
	if (isClass (configFile >> "CfgPatches" >> "CUP_Vehicles_Core")) then {ambianceMusic_punchy append []};

	// CALM MUSICS, FOR NOT URGENT TAKS (PATROL, PLANNIFIED ASSAULT...)
	ambianceMusic_calm =
		[
			"BackgroundTrack01_F", "BackgroundTrack01_F_EPC", "BackgroundTrack01a_F", "BackgroundTrack02_F_EPC",
			"EventTrack02_F_EPB", "EventTrack03_F_Curator", "EventTrack03a_F_EPA",
			"LeadTrack01_F_EPA", "LeadTrack01_F_EPB", "LeadTrack01_F_Mark", "LeadTrack02_F", "LeadTrack02_F_Bootcamp", "LeadTrack02_F_EPA", "LeadTrack02_F_EXP",
			"LeadTrack03_F_EPC", "LeadTrack03_F_Mark", "LeadTrack03a_F_EPB", "LeadTrack04_F_EXP",
			"Track02_SolarPower",
			"LeadTrack02_F_Malden", "LeadTrack01_F_Orange", "AmbientTrack01_F_Orange"
		];

	// MYSTIC MUSICS, FOR INFILTRATION TASKS
	ambianceMusic_stealth =
		[
			"AmbientTrack01_F", "AmbientTrack01_F_EPB", "AmbientTrack01_F_EXP", "AmbientTrack01a_F", "AmbientTrack01a_F_EXP", "AmbientTrack01b_F", "AmbientTrack01b_F_EXP",
			"AmbientTrack03_F", "AmbientTrack04_F", "AmbientTrack04a_F",
			"BackgroundTrack01_F_EPB", "BackgroundTrack02_F_EPC", "BackgroundTrack04_F_EPC",
			"Defcon", "Fallout", "MAD", "Wasteland", "SkyNet",
			"EventTrack01a_F_EPB", "EventTrack02_F_Curator", "EventTrack02a_F_EPB", "EventTrack03_F_EPB", "EventTrack03_F_EPC", "EventTrack03a_F_EPB", "EventTrack04_F_EPB", "EventTrack04a_F_EPB",
			"LeadTrack01a_F_EPB", "LeadTrack01a_F_EXP", "LeadTrack01c_F_EXP", "LeadTrack02_F_EPB", "LeadTrack02a_F_EPB", "LeadTrack03_F_EPB", "LeadTrack04_F_EPB", "LeadTrack05_F_EPC", "LeadTrack06_F", "LeadTrack06_F_EPC", "LeadTrack02_F_Jets",
			"Track01_Proteus", "Track04_Underwater1", "Track05_Underwater2", "Track08_Night_ambient", "Track09_Night_percussions", "Track11_StageB_stealth",
			"AmbientTrack02_F_Orange", "EventTrack01_F_Orange",
			"AmbientTrack01a_F_Tacops", "AmbientTrack01b_F_Tacops", "AmbientTrack02a_F_Tacops", "AmbientTrack02b_F_Tacops", "AmbientTrack03a_F_Tacops", "AmbientTrack03b_F_Tacops", "AmbientTrack04a_F_Tacops", "AmbientTrack04b_F_Tacops", "EventTrack01a_F_Tacops", "EventTrack01b_F_Tacops", "EventTrack02a_F_Tacops", "EventTrack02b_F_Tacops", "EventTrack03a_F_Tacops", "EventTrack03b_F_Tacops",
			"LeadTrack03_F_Tank", "LeadTrack04_F_Tank", "AmbientTrack01_F_Tank", "Music_Menu_Contact",
			"Music_Roaming_Night", "Music_Roaming_Night_02", "Music_Roaming_Night_Fragment_01_20s", "Music_Roaming_Night_Fragment_01_30s", "Music_Roaming_Night_Fragment_01_60s", "Music_Roaming_Night_Fragment_02_30s", "Music_Roaming_Night_Fragment_02_60s", "Music_Roaming_Night_Fragment_03_60s", "Music_Hostile_Drone_Close_01", "Music_Battle_Alien"
		];

	// SAD MUSICS, FOR VENGEANCE TASKS
	ambianceMusic_sad =
		[
			"AmbientTrack02_F_EXP", "AmbientTrack02_F_EXP", "AmbientTrack02a_F_EXP", "AmbientTrack02b_F_EXP", "AmbientTrack02c_F_EXP", "AmbientTrack02d_F_EXP",
			"BackgroundTrack03_F_EPC",
			"EventTrack01_F_EPB", "EventTrack01_F_EPC",
			"LeadTrack01_F_EPC", "LeadTrack01_F_EXP", "LeadTrack01b_F_EXP", "LeadTrack01_F_Jets"
		];

	// ADDITIONNAL MUSICS, BASED ON MAP REGION
	if (OPEX_mapRegion == "middleEast") then
		{
			ambianceMusic_punchy append ["LeadTrack01c_F_EXP"];
			ambianceMusic_stealth append ["BackgroundTrack02_F_EPC", "EventTrack01a_F_EPB", "EventTrack02_F_EPB", "EventTrack03_F_EPB", "EventTrack03a_F_EPB", "EventTrack04_F_EPB", "EventTrack04a_F_EPB"];
			ambianceMusic_sad append ["EventTrack03_F_Curator", "LeadTrack03_F_EPB"," LeadTrack03_F_EPC", "LeadTrack03a_F_EPB"];
		};
	if (OPEX_mapRegion == "africa") then
		{
			ambianceMusic_punchy append ["LeadTrack04_F_EPB", "LeadTrack04_F_EPB", "LeadTrack04_F_EPB"];
			ambianceMusic_stealth append ["BackgroundTrack02_F_EPC", "AmbientTrack01_F_EXP", "AmbientTrack01b_F_EXP"];
			ambianceMusic_sad append ["LeadTrack03_F_EPC", "LeadTrack03a_F_EPB", "AmbientTrack01a_F_EXP"];
		};
	if (OPEX_mapRegion == "pacific") then
		{
			ambianceMusic_punchy append ["LeadTrack01a_F_EXP", "LeadTrack04_F_EPB"];
			ambianceMusic_stealth append ["AmbientTrack01_F_EXP", "AmbientTrack01b_F_EXP"];
			ambianceMusic_sad append ["AmbientTrack01a_F_EXP"];
		};


//////////////////////////////////////////////////////////////////
// CAR MUSICS (AVAILABLE IN VEHICLES) 						   ///
//////////////////////////////////////////////////////////////////


	// VANILLA TRACKS
		vehicleMusicReceiver_trackList =
			[
				// ARMA III
				[0, "AmbientTrack01a_F", getNumber (configfile >> "CfgMusic" >> "AmbientTrack01a_F" >> "duration"), getText (configfile >> "CfgMusic" >> "AmbientTrack01a_F" >> "name")],
				[1, "AmbientTrack01_F", getNumber (configfile >> "CfgMusic" >> "AmbientTrack01_F" >> "duration"), getText (configfile >> "CfgMusic" >> "AmbientTrack01_F" >> "name")],
				[2, "AmbientTrack01b_F", getNumber (configfile >> "CfgMusic" >> "AmbientTrack01b_F" >> "duration"), getText (configfile >> "CfgMusic" >> "AmbientTrack01b_F" >> "name")],
				[3, "AmbientTrack03_F", getNumber (configfile >> "CfgMusic" >> "AmbientTrack03_F" >> "duration"), getText (configfile >> "CfgMusic" >> "AmbientTrack03_F" >> "name")],
				[4, "AmbientTrack04_F", getNumber (configfile >> "CfgMusic" >> "AmbientTrack04_F" >> "duration"), getText (configfile >> "CfgMusic" >> "AmbientTrack04_F" >> "name")],
				[5, "AmbientTrack04a_F", getNumber (configfile >> "CfgMusic" >> "AmbientTrack04a_F" >> "duration"), getText (configfile >> "CfgMusic" >> "AmbientTrack04a_F" >> "name")],
				[6, "BackgroundTrack01a_F", getNumber (configfile >> "CfgMusic" >> "BackgroundTrack01a_F" >> "duration"), getText (configfile >> "CfgMusic" >> "BackgroundTrack01a_F" >> "name")],
				[7, "BackgroundTrack01_F", getNumber (configfile >> "CfgMusic" >> "BackgroundTrack01_F" >> "duration"), getText (configfile >> "CfgMusic" >> "BackgroundTrack01_F" >> "name")],
				[8, "BackgroundTrack02_F", getNumber (configfile >> "CfgMusic" >> "BackgroundTrack02_F" >> "duration"), getText (configfile >> "CfgMusic" >> "BackgroundTrack02_F" >> "name")],
				[9, "BackgroundTrack03_F", getNumber (configfile >> "CfgMusic" >> "BackgroundTrack03_F" >> "duration"), getText (configfile >> "CfgMusic" >> "BackgroundTrack03_F" >> "name")],
				[10, "LeadTrack01_F", getNumber (configfile >> "CfgMusic" >> "LeadTrack01_F" >> "duration"), getText (configfile >> "CfgMusic" >> "LeadTrack01_F" >> "name")],
				[11, "LeadTrack02_F", getNumber (configfile >> "CfgMusic" >> "LeadTrack02_F" >> "duration"), getText (configfile >> "CfgMusic" >> "LeadTrack02_F" >> "name")],
				[12, "LeadTrack03_F", getNumber (configfile >> "CfgMusic" >> "LeadTrack03_F" >> "duration"), getText (configfile >> "CfgMusic" >> "LeadTrack03_F" >> "name")],
				[13, "LeadTrack04_F", getNumber (configfile >> "CfgMusic" >> "LeadTrack04_F" >> "duration"), getText (configfile >> "CfgMusic" >> "LeadTrack04_F" >> "name")],
				[14, "LeadTrack05_F", getNumber (configfile >> "CfgMusic" >> "LeadTrack05_F" >> "duration"), getText (configfile >> "CfgMusic" >> "LeadTrack05_F" >> "name")],
				[15, "LeadTrack06_F", getNumber (configfile >> "CfgMusic" >> "LeadTrack06_F" >> "duration"), getText (configfile >> "CfgMusic" >> "LeadTrack06_F" >> "name")],
				[16, "LeadTrack01_F_EPA", getNumber (configfile >> "CfgMusic" >> "LeadTrack01_F_EPA" >> "duration"), getText (configfile >> "CfgMusic" >> "LeadTrack01_F_EPA" >> "name")],
				[17, "LeadTrack02_F_EPA", getNumber (configfile >> "CfgMusic" >> "LeadTrack02_F_EPA" >> "duration"), getText (configfile >> "CfgMusic" >> "LeadTrack02_F_EPA" >> "name")],
				[18, "LeadTrack03_F_EPA", getNumber (configfile >> "CfgMusic" >> "LeadTrack03_F_EPA" >> "duration"), getText (configfile >> "CfgMusic" >> "LeadTrack03_F_EPA" >> "name")],
				[19, "EventTrack01_F_EPA", getNumber (configfile >> "CfgMusic" >> "EventTrack01_F_EPA" >> "duration"), getText (configfile >> "CfgMusic" >> "EventTrack01_F_EPA" >> "name")],
				[20, "EventTrack02_F_EPA", getNumber (configfile >> "CfgMusic" >> "EventTrack02_F_EPA" >> "duration"), getText (configfile >> "CfgMusic" >> "EventTrack02_F_EPA" >> "name")],
				[21, "EventTrack03_F_EPA", getNumber (configfile >> "CfgMusic" >> "EventTrack03_F_EPA" >> "duration"), getText (configfile >> "CfgMusic" >> "EventTrack03_F_EPA" >> "name")],
				[22, "LeadTrack01_F_EPB", getNumber (configfile >> "CfgMusic" >> "LeadTrack01_F_EPB" >> "duration"), getText (configfile >> "CfgMusic" >> "LeadTrack01_F_EPB" >> "name")],
				[23, "LeadTrack02_F_EPB", getNumber (configfile >> "CfgMusic" >> "LeadTrack02_F_EPB" >> "duration"), getText (configfile >> "CfgMusic" >> "LeadTrack02_F_EPB" >> "name")],
				[24, "LeadTrack03_F_EPB", getNumber (configfile >> "CfgMusic" >> "LeadTrack03_F_EPB" >> "duration"), getText (configfile >> "CfgMusic" >> "LeadTrack03_F_EPB" >> "name")],
				[25, "LeadTrack04_F_EPB", getNumber (configfile >> "CfgMusic" >> "LeadTrack04_F_EPB" >> "duration"), getText (configfile >> "CfgMusic" >> "LeadTrack04_F_EPB" >> "name")],
				[26, "EventTrack01_F_EPB", getNumber (configfile >> "CfgMusic" >> "EventTrack01_F_EPB" >> "duration"), getText (configfile >> "CfgMusic" >> "EventTrack01_F_EPB" >> "name")],
				[27, "EventTrack02_F_EPB", getNumber (configfile >> "CfgMusic" >> "EventTrack02_F_EPB" >> "duration"), getText (configfile >> "CfgMusic" >> "EventTrack02_F_EPB" >> "name")],
				[28, "EventTrack03_F_EPB", getNumber (configfile >> "CfgMusic" >> "EventTrack03_F_EPB" >> "duration"), getText (configfile >> "CfgMusic" >> "EventTrack03_F_EPB" >> "name")],
				[29, "EventTrack04_F_EPB", getNumber (configfile >> "CfgMusic" >> "EventTrack04_F_EPB" >> "duration"), getText (configfile >> "CfgMusic" >> "EventTrack04_F_EPB" >> "name")],
				[30, "AmbientTrack01_F_EPB", getNumber (configfile >> "CfgMusic" >> "AmbientTrack01_F_EPB" >> "duration"), getText (configfile >> "CfgMusic" >> "AmbientTrack01_F_EPB" >> "name")],
				[31, "BackgroundTrack01_F_EPB", getNumber (configfile >> "CfgMusic" >> "BackgroundTrack01_F_EPB" >> "duration"), getText (configfile >> "CfgMusic" >> "BackgroundTrack01_F_EPB" >> "name")],
				[32, "LeadTrack01_F_EPC", getNumber (configfile >> "CfgMusic" >> "LeadTrack01_F_EPC" >> "duration"), getText (configfile >> "CfgMusic" >> "LeadTrack01_F_EPC" >> "name")],
				[33, "LeadTrack02_F_EPC", getNumber (configfile >> "CfgMusic" >> "LeadTrack02_F_EPC" >> "duration"), getText (configfile >> "CfgMusic" >> "LeadTrack02_F_EPC" >> "name")],
				[34, "LeadTrack03_F_EPC", getNumber (configfile >> "CfgMusic" >> "LeadTrack03_F_EPC" >> "duration"), getText (configfile >> "CfgMusic" >> "LeadTrack03_F_EPC" >> "name")],
				[35, "LeadTrack04_F_EPC", getNumber (configfile >> "CfgMusic" >> "LeadTrack04_F_EPC" >> "duration"), getText (configfile >> "CfgMusic" >> "LeadTrack04_F_EPC" >> "name")],
				[36, "LeadTrack05_F_EPC", getNumber (configfile >> "CfgMusic" >> "LeadTrack05_F_EPC" >> "duration"), getText (configfile >> "CfgMusic" >> "LeadTrack05_F_EPC" >> "name")],
				[37, "LeadTrack06_F_EPC", getNumber (configfile >> "CfgMusic" >> "LeadTrack06_F_EPC" >> "duration"), getText (configfile >> "CfgMusic" >> "LeadTrack06_F_EPC" >> "name")],
				[38, "EventTrack01_F_EPC", getNumber (configfile >> "CfgMusic" >> "EventTrack01_F_EPC" >> "duration"), getText (configfile >> "CfgMusic" >> "EventTrack01_F_EPC" >> "name")],
				[39, "EventTrack02_F_EPC", getNumber (configfile >> "CfgMusic" >> "EventTrack02_F_EPC" >> "duration"), getText (configfile >> "CfgMusic" >> "EventTrack02_F_EPC" >> "name")],
				[40, "EventTrack03_F_EPC", getNumber (configfile >> "CfgMusic" >> "EventTrack03_F_EPC" >> "duration"), getText (configfile >> "CfgMusic" >> "EventTrack03_F_EPC" >> "name")],
				[41, "BackgroundTrack01_F_EPC", getNumber (configfile >> "CfgMusic" >> "BackgroundTrack01_F_EPC" >> "duration"), getText (configfile >> "CfgMusic" >> "BackgroundTrack01_F_EPC" >> "name")],
				[42, "BackgroundTrack02_F_EPC", getNumber (configfile >> "CfgMusic" >> "BackgroundTrack02_F_EPC" >> "duration"), getText (configfile >> "CfgMusic" >> "BackgroundTrack02_F_EPC" >> "name")],
				[43, "BackgroundTrack03_F_EPC", getNumber (configfile >> "CfgMusic" >> "BackgroundTrack03_F_EPC" >> "duration"), getText (configfile >> "CfgMusic" >> "BackgroundTrack03_F_EPC" >> "name")],
				[44, "BackgroundTrack04_F_EPC", getNumber (configfile >> "CfgMusic" >> "BackgroundTrack04_F_EPC" >> "duration"), getText (configfile >> "CfgMusic" >> "BackgroundTrack04_F_EPC" >> "name")],
				[45, "LeadTrack01_F_Curator", getNumber (configfile >> "CfgMusic" >> "LeadTrack01_F_Curator" >> "duration"), getText (configfile >> "CfgMusic" >> "LeadTrack01_F_Curator" >> "name")],
				[46, "LeadTrack01_F_Bootcamp", getNumber (configfile >> "CfgMusic" >> "LeadTrack01_F_Bootcamp" >> "duration"), getText (configfile >> "CfgMusic" >> "LeadTrack01_F_Bootcamp" >> "name")],
				[47, "LeadTrack02_F_Bootcamp", getNumber (configfile >> "CfgMusic" >> "LeadTrack02_F_Bootcamp" >> "duration"), getText (configfile >> "CfgMusic" >> "LeadTrack02_F_Bootcamp" >> "name")],
				[48, "LeadTrack03_F_Bootcamp", getNumber (configfile >> "CfgMusic" >> "LeadTrack03_F_Bootcamp" >> "duration"), getText (configfile >> "CfgMusic" >> "LeadTrack03_F_Bootcamp" >> "name")],
				[49, "LeadTrack01_F_Heli", getNumber (configfile >> "CfgMusic" >> "LeadTrack01_F_Heli" >> "duration"), getText (configfile >> "CfgMusic" >> "LeadTrack01_F_Heli" >> "name")],
				[50, "LeadTrack01_F_Mark", getNumber (configfile >> "CfgMusic" >> "LeadTrack01_F_Mark" >> "duration"), getText (configfile >> "CfgMusic" >> "LeadTrack01_F_Mark" >> "name")],
				[51, "LeadTrack02_F_Mark", getNumber (configfile >> "CfgMusic" >> "LeadTrack02_F_Mark" >> "duration"), getText (configfile >> "CfgMusic" >> "LeadTrack02_F_Mark" >> "name")],
				[52, "LeadTrack03_F_Mark", getNumber (configfile >> "CfgMusic" >> "LeadTrack03_F_Mark" >> "duration"), getText (configfile >> "CfgMusic" >> "LeadTrack03_F_Mark" >> "name")],
				[53, "LeadTrack01_F_EXP", getNumber (configfile >> "CfgMusic" >> "LeadTrack01_F_EXP" >> "duration"), getText (configfile >> "CfgMusic" >> "LeadTrack01_F_EXP" >> "name")],
				[54, "LeadTrack02_F_EXP", getNumber (configfile >> "CfgMusic" >> "LeadTrack02_F_EXP" >> "duration"), getText (configfile >> "CfgMusic" >> "LeadTrack02_F_EXP" >> "name")],
				[55, "LeadTrack03_F_EXP", getNumber (configfile >> "CfgMusic" >> "LeadTrack03_F_EXP" >> "duration"), getText (configfile >> "CfgMusic" >> "LeadTrack03_F_EXP" >> "name")],
				[56, "AmbientTrack01_F_EXP", getNumber (configfile >> "CfgMusic" >> "AmbientTrack01_F_EXP" >> "duration"), getText (configfile >> "CfgMusic" >> "AmbientTrack01_F_EXP" >> "name")],
				[57, "AmbientTrack02_F_EXP", getNumber (configfile >> "CfgMusic" >> "AmbientTrack02_F_EXP" >> "duration"), getText (configfile >> "CfgMusic" >> "AmbientTrack02_F_EXP" >> "name")],
				[58, "LeadTrack01_F_Jets", getNumber (configfile >> "CfgMusic" >> "LeadTrack01_F_Jets" >> "duration"), getText (configfile >> "CfgMusic" >> "LeadTrack01_F_Jets" >> "name")],
				[59, "LeadTrack02_F_Jets", getNumber (configfile >> "CfgMusic" >> "LeadTrack02_F_Jets" >> "duration"), getText (configfile >> "CfgMusic" >> "LeadTrack02_F_Jets" >> "name")],
				[60, "EventTrack01_F_Jets", getNumber (configfile >> "CfgMusic" >> "EventTrack01_F_Jets" >> "duration"), getText (configfile >> "CfgMusic" >> "EventTrack01_F_Jets" >> "name")],
				[61, "LeadTrack01_F_Malden", getNumber (configfile >> "CfgMusic" >> "LeadTrack01_F_Malden" >> "duration"), getText (configfile >> "CfgMusic" >> "LeadTrack01_F_Malden" >> "name")],
				[62, "LeadTrack02_F_Malden", getNumber (configfile >> "CfgMusic" >> "LeadTrack02_F_Malden" >> "duration"), getText (configfile >> "CfgMusic" >> "LeadTrack02_F_Malden" >> "name")],
				[63, "LeadTrack01_F_Orange", getNumber (configfile >> "CfgMusic" >> "LeadTrack01_F_Orange" >> "duration"), getText (configfile >> "CfgMusic" >> "LeadTrack01_F_Orange" >> "name")],
				[64, "LeadTrack01_F_Tacops", getNumber (configfile >> "CfgMusic" >> "LeadTrack01_F_Tacops" >> "duration"), getText (configfile >> "CfgMusic" >> "LeadTrack01_F_Tacops" >> "name")],
				[65, "LeadTrack02_F_Tacops", getNumber (configfile >> "CfgMusic" >> "LeadTrack02_F_Tacops" >> "duration"), getText (configfile >> "CfgMusic" >> "LeadTrack02_F_Tacops" >> "name")],
				[66, "LeadTrack03_F_Tacops", getNumber (configfile >> "CfgMusic" >> "LeadTrack03_F_Tacops" >> "duration"), getText (configfile >> "CfgMusic" >> "LeadTrack03_F_Tacops" >> "name")],
				[67, "LeadTrack04_F_Tacops", getNumber (configfile >> "CfgMusic" >> "LeadTrack04_F_Tacops" >> "duration"), getText (configfile >> "CfgMusic" >> "LeadTrack04_F_Tacops" >> "name")],
				[68, "MainTheme_F_Tank", getNumber (configfile >> "CfgMusic" >> "MainTheme_F_Tank" >> "duration"), getText (configfile >> "CfgMusic" >> "MainTheme_F_Tank" >> "name")],
				[69, "LeadTrack01_F_Tank", getNumber (configfile >> "CfgMusic" >> "LeadTrack01_F_Tank" >> "duration"), getText (configfile >> "CfgMusic" >> "LeadTrack01_F_Tank" >> "name")],
				[70, "LeadTrack02_F_Tank", getNumber (configfile >> "CfgMusic" >> "LeadTrack02_F_Tank" >> "duration"), getText (configfile >> "CfgMusic" >> "LeadTrack02_F_Tank" >> "name")],
				[71, "LeadTrack03_F_Tank", getNumber (configfile >> "CfgMusic" >> "LeadTrack03_F_Tank" >> "duration"), getText (configfile >> "CfgMusic" >> "LeadTrack03_F_Tank" >> "name")],
				[72, "LeadTrack04_F_Tank", getNumber (configfile >> "CfgMusic" >> "LeadTrack04_F_Tank" >> "duration"), getText (configfile >> "CfgMusic" >> "LeadTrack04_F_Tank" >> "name")],
				[73, "LeadTrack05_F_Tank", getNumber (configfile >> "CfgMusic" >> "LeadTrack05_F_Tank" >> "duration"), getText (configfile >> "CfgMusic" >> "LeadTrack05_F_Tank" >> "name")],
				[74, "LeadTrack06_F_Tank", getNumber (configfile >> "CfgMusic" >> "LeadTrack06_F_Tank" >> "duration"), getText (configfile >> "CfgMusic" >> "LeadTrack06_F_Tank" >> "name")],
				[75, "LeadTrack01_F_6th_Anniversary_Remix", getNumber (configfile >> "CfgMusic" >> "LeadTrack01_F_6th_Anniversary_Remix" >> "duration"), getText (configfile >> "CfgMusic" >> "LeadTrack01_F_6th_Anniversary_Remix" >> "name")]
			];