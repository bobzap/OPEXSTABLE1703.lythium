//////////////////////////////////////////////////////////////////
// AMBIENT MUSICS (WHEN STARTING A NEW TASK IN SINGLE PLAYER) ///
//////////////////////////////////////////////////////////////////

	// CHECKING IF MOD IS INSTALLED
	if (!(isClass (configFile >> "CfgPatches" >> "CUP_Music_DBE1"))) exitWith {};
	if (!(isClass (configFile >> "CfgPatches" >> "CUP_Worlds"))) exitWith {};
	if (!(isClass (configFile >> "CfgPatches" >> "CUP_Sounds_Data"))) exitWith {};

	// WAITING FOR MUSIC INITIALIZATION
	waitUntil {!isNil "ambianceMusic_punchy"};
	waitUntil {!isNil "ambianceMusic_calm"};
	waitUntil {!isNil "ambianceMusic_stealth"};
	waitUntil {!isNil "ambianceMusic_sad"};
	waitUntil {!isNil "vehicleMusicReceiver_trackList"};

	ambianceMusic_punchy append ["QGTrack1", "QGTrack6", "QGTrack7"];
	ambianceMusic_calm append ["QGTrack3", "QGTrack9"];
	ambianceMusic_stealth append ["QGTrack5"];
	ambianceMusic_sad append ["QGTrack2", "QGTrack8"];

//////////////////////////////////////////////////////////////////
// CAR MUSICS (AVAILABLE IN VEHICLES) 						   ///
//////////////////////////////////////////////////////////////////

vehicleMusicReceiver_trackList append [[count vehicleMusicReceiver_trackList, "BAF_Track01", getNumber (configfile >> "CfgMusic" >> "BAF_Track01" >> "duration"), getText (configfile >> "CfgMusic" >> "BAF_Track01" >> "name")]];
vehicleMusicReceiver_trackList append [[count vehicleMusicReceiver_trackList, "BAF_Track02", getNumber (configfile >> "CfgMusic" >> "BAF_Track02" >> "duration"), getText (configfile >> "CfgMusic" >> "BAF_Track02" >> "name")]];
vehicleMusicReceiver_trackList append [[count vehicleMusicReceiver_trackList, "BAF_Track03", getNumber (configfile >> "CfgMusic" >> "BAF_Track03" >> "duration"), getText (configfile >> "CfgMusic" >> "BAF_Track03" >> "name")]];
vehicleMusicReceiver_trackList append [[count vehicleMusicReceiver_trackList, "BAF_Track04", getNumber (configfile >> "CfgMusic" >> "BAF_Track04" >> "duration"), getText (configfile >> "CfgMusic" >> "BAF_Track04" >> "name")]];
vehicleMusicReceiver_trackList append [[count vehicleMusicReceiver_trackList, "BAF_Track05", getNumber (configfile >> "CfgMusic" >> "BAF_Track05" >> "duration"), getText (configfile >> "CfgMusic" >> "BAF_Track05" >> "name")]];
vehicleMusicReceiver_trackList append [[count vehicleMusicReceiver_trackList, "BAF_Track06", getNumber (configfile >> "CfgMusic" >> "BAF_Track06" >> "duration"), getText (configfile >> "CfgMusic" >> "BAF_Track06" >> "name")]];