waitUntil {!isNil "vehicleMusicReceiver_trackList"};

/*
	CUSTOM MUSIC INSTRUCTIONS

	TO LIST A CUSTOM MUSIC, ADD A NEW ENTRY UNDER THIS SECTION, USING THE EXAMPLE BELOW:
		vehicleMusicReceiver_trackList append [[count vehicleMusicReceiver_trackList, "MichaelJackson_BeatIt", 298, "Michael Jackson - Beat It (live)"]];

	THEN YOU NEED TO MODIFY:
		1. The track class name (in the example: "MichaelJackson_BeatIt") - the class must be defined in the CfgMusic section of the description.ext file. It MUST be a STRING.
		2. The track duration in seconds (in this example: 298). It MUST be a NUMBER.
		3. The track name that will be displayed on vehicle music receiver (in this example: "Michael Jackson - Beat It (live)"). It MUST be a STRING.

	SIMPLY REPEAT THE PROCESS FOR ANY MUSIC YOU WANT TO ADD.
*/

/*
	remove "//" in the line below and list your custom musics as described in the example
*/

// vehicleMusicReceiver_trackList append [[count vehicleMusicReceiver_trackList, "MichaelJackson_BeatIt", 298, "Michael Jackson - Beat It (live)"]];