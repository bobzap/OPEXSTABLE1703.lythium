// THIS SCRIPT IS USELESS FOR DEDICATED SERVER
if (isDedicated) exitWith {};

// SETTING COLOR CORRECTIONS (BASED ON MAP REGION)
Gemini_fnc_mapColorCorrection =
	{
		switch (OPEX_mapRegion) do
			{
				case "europe"		:		{[0.91, 0.91, 0, [0.2, 0.29, 0.40, -0.22], [1, 1, 1, 1.30], [0.15, 0.09, 0.09, 0.0]]};
				case "middleEast"	:		{[0.94, 0.94, 0, [0.0, 0.10, 0.25, -0.14], [1, 1, 1, 1.26], [0.15, 0.09, 0.09, 0.0]]};
				case "africa"		:		{[0.90, 0.90, 0, [0.2, 0.29, 0.40, -0.22], [1, 1, 1, 1.30], [0.15, 0.09, 0.09, 0.0]]};
				default 					{[0.90, 0.90, 0, [0.2, 0.29, 0.40, -0.22], [1, 1, 1, 1.30], [0.15, 0.09, 0.09, 0.0]]};
				// alternative middle-east [0.9,1,0, [0.1,0.1,0.1,-0.1], [1,1,0.8,0.528], [1,0.2,0,0]]
				// alternative afghan [0.9,0.9,0, [0,0.1,0.25,-0.14], [1,1,1,1.26], [0.15,0.09,0.09,0.0]]
			};
	};


Gemini_fnc_gogglesColorCorrection =
	{
		// this function is inspired by gammadust script (http://www.armaholic.com/page.php?id=22518)

		private ["_base", "_correction"];

		// DEFING GLASSES EFFECTS // [brightness, contrast, gamma, [R, G, B, multiplier], [R, G, B, multiplier], [R, G, B, multiplier]];
		switch (goggles player) do
			{
				case ""								:	{_correction = call Gemini_fnc_mapColorCorrection};
				case "G_Aviator"					:	{_correction = [1, 1, 0, [0.0, 0.0, 0.0, 0.0], [0.5, 0.5, 0.3, 0.80], [0.5, 0.5, 0.5, 0.00]]};
				case "G_Shades_Black"				: 	{_correction = [1, 1, 0, [0.0, 0.0, 0.0, 0.0], [0.1, 0.1, 0.1, 0.90], [0.5, 0.5, 0.5, 0.00]]};
				case "G_Shades_Red"					: 	{_correction = [1, 1, 0, [0.0, 0.0, 0.0, 0.0], [1.0, 0.5, 0.5, 0.60], [0.5, 0.5, 0.5, 0.00]]};
				case "G_Shades_Green"				: 	{_correction = [1, 1, 0, [0.0, 0.0, 0.0, 0.0], [0.5, 1.0, 0.5, 0.60], [0.5, 0.5, 0.5, 0.00]]};
				case "G_Shades_Blue"				: 	{_correction = [1, 1, 0, [0.0, 0.0, 0.0, 0.0], [0.5, 0.5, 1.0, 0.60], [0.5, 0.5, 0.5, 0.00]]};
				case "G_Tactical_Clear"				: 	{_correction = [1, 1, 0, [0.0, 0.0, 0.0, 0.0], [0.1, 0.1, 0.1, 0.95], [0.5, 0.5, 0.5, 0.00]]};
				case "G_Tactical_Black"				:	{_correction = [1, 1, 0, [0.0, 0.0, 0.0, 0.0], [0.1, 0.1, 0.1, 0.90], [0.5, 0.5, 0.5, 0.00]]};
				case "G_Spectacles"					: 	{_correction = call Gemini_fnc_mapColorCorrection};
				case "G_Spectacles_Tinted"			: 	{_correction = [1, 1, 0, [0.0, 0.0, 0.0, 0.0], [0.1, 0.1, 0.1, 0.90], [0.5, 0.5, 0.5, 0.00]]};
				case "G_Combat"						: 	{_correction = [1, 1, 0, [0.0, 0.0, 0.0, 0.0], [0.1, 0.1, 0.1, 1.00], [0.5, 0.5, 0.5, 0.00]]};
				case "G_Lowprofile"					: 	{_correction = [1, 1, 0, [0.0, 0.0, 0.0, 0.0], [0.1, 0.1, 0.1, 1.00], [0.5, 0.5, 0.5, 0.00]]};
				case "G_Diving"						:	{_correction = [1, 1, 0, [0.0, 0.0, 0.0, 0.0], [0.1, 0.1, 0.1, 1.00], [0.5, 0.5, 0.5, 0.00]]};
				case "G_Squares"					:	{_correction = [1, 1, 0, [0.0, 0.0, 0.0, 0.0], [0.1, 0.1, 0.1, 1.00], [0.5, 0.5, 0.5, 0.00]]};
				case "G_Squares_Tinted"				:	{_correction = [1, 1, 0, [0.0, 0.0, 0.0, 0.0], [0.1, 0.1, 0.1, 0.90], [0.5, 0.5, 0.5, 0.00]]};
				case "G_Sport_BlackWhite"			: 	{_correction = [1, 1, 0, [0.0, 0.0, 0.0, 0.0], [0.1, 0.1, 0.1, 0.90], [0.5, 0.5, 0.5, 0.00]]};
				case "G_Sport_Blackred"				: 	{_correction = [1, 1, 0, [0.0, 0.0, 0.0, 0.0], [1.0, 0.5, 0.5, 0.60], [0.5, 0.5, 0.5, 0.00]]};
				case "G_Sport_Blackyellow"			:	{_correction = [1, 1, 0, [0.0, 0.0, 0.0, 0.0], [1.0, 1.0, 0.5, 0.60], [0.5, 0.5, 0.5, 0.00]]};
				case "G_Sport_Greenblack"			:	{_correction = [1, 1, 0, [0.0, 0.0, 0.0, 0.0], [0.5, 1.0, 0.5, 0.60], [0.5, 0.5, 0.5, 0.00]]};
				case "G_Sport_Checkered"			:	{_correction = [1, 1, 0, [0.0, 0.0, 0.0, 0.0], [1.0, 1.0, 1.0, 0.80], [0.5, 0.5, 0.5, 0.00]]};
				case "G_Sport_Red"					:	{_correction = [1, 1, 0, [0.0, 0.0, 0.0, 0.0], [1.0, 0.5, 0.5, 0.60], [0.5, 0.5, 0.5, 0.00]]};
				case "G_Lady_Mirror"				:	{_correction = [1, 1, 0, [0.0, 0.0, 0.0, 0.0], [0.3, 0.1, 0.1, 0.70], [0.5, 0.5, 0.5, 0.00]]};
				case "G_Lady_Dark"					:	{_correction = [1, 1, 0, [0.0, 0.0, 0.0, 0.0], [0.1, 0.1, 0.2, 0.70], [0.5, 0.5, 0.5, 0.00]]};
				case "G_Lady_Red"					:	{_correction = [1, 1, 0, [0.0, 0.0, 0.0, 0.0], [1.0, 0.5, 0.5, 0.70], [0.5, 0.5, 0.5, 0.00]]};
				case "G_Lady_Blue"					:	{_correction = [1, 1, 0, [0.0, 0.0, 0.0, 0.0], [0.2, 0.0, 0.2, 0.70], [0.5, 0.5, 0.5, 0.00]]};
				case "G_Combat_Goggles_tna_F"		:	{_correction = [1, 1, 0, [0.0, 0.0, 0.0, 0.0], [0.1, 0.1, 0.1, 0.90], [0.5, 0.5, 0.5, 0.00]]};
				case "G_Balaclava_TI_G_blk_F"		:	{_correction = [1, 1, 0, [0.0, 0.0, 0.0, 0.0], [0.1, 0.1, 0.1, 0.90], [0.5, 0.5, 0.5, 0.00]]};
				case "G_Balaclava_TI_G_tna_F"		:	{_correction = [1, 1, 0, [0.0, 0.0, 0.0, 0.0], [0.1, 0.1, 0.1, 0.90], [0.5, 0.5, 0.5, 0.00]]};
				case "G_B_Diving"					: 	{_correction = [1, 1, 0, [0.0, 0.0, 0.0, 0.0], [0.1, 0.1, 0.1, 1.00], [0.5, 0.5, 0.5, 0.00]]};
				case "R3F_lunettes_X800"			: 	{_correction = [1, 1, 0, [0.0, 0.0, 0.0, 0.0], [0.1, 0.1, 0.1, 0.90], [0.5, 0.5, 0.5, 0.00]]};
				case "R3F_lunettes_ESS"				: 	{_correction = [1, 1, 0, [0.0, 0.0, 0.0, 0.0], [0.1, 0.1, 0.1, 0.90], [0.5, 0.5, 0.5, 0.00]]};
				case "rhs_googles_black"			: 	{_correction = [1, 1, 0, [0.0, 0.0, 0.0, 0.0], [0.1, 0.1, 0.1, 0.90], [0.5, 0.5, 0.5, 0.00]]};
				case "rhs_googles_clear"			: 	{_correction = [1, 1, 0, [0.0, 0.0, 0.0, 0.0], [0.1, 0.1, 0.1, 0.95], [0.5, 0.5, 0.5, 0.00]]};
				case "rhs_googles_orange"			: 	{_correction = [1, 1, 0, [0.0, 0.0, 0.0, 0.0], [1.0, 0.6, 0.1, 0.60], [0.5, 0.5, 0.5, 0.00]]};
				case "rhs_googles_yellow"			: 	{_correction = [1, 1, 0, [0.0, 0.0, 0.0, 0.0], [0.9, 0.9, 0.0, 0.70], [0.5, 0.5, 0.5, 0.00]]};
				case "rhsusf_oakley_goggles_blk"	: 	{_correction = [1, 1, 0, [0.0, 0.0, 0.0, 0.0], [0.1, 0.1, 0.1, 0.90], [0.5, 0.5, 0.5, 0.00]]};
				case "rhsusf_oakley_goggles_clr"	: 	{_correction = [1, 1, 0, [0.0, 0.0, 0.0, 0.0], [0.1, 0.1, 0.1, 0.95], [0.5, 0.5, 0.5, 0.00]]};
				case "rhsusf_oakley_goggles_ylw"	: 	{_correction = [1, 1, 0, [0.0, 0.0, 0.0, 0.0], [0.9, 0.9, 0.0, 0.70], [0.5, 0.5, 0.5, 0.00]]};
				case "rhs_ess_black"				: 	{_correction = [1, 1, 0, [0.0, 0.0, 0.0, 0.0], [0.1, 0.1, 0.1, 0.90], [0.5, 0.5, 0.5, 0.00]]};
				case "rhsusf_shemagh_gogg_grn"		: 	{_correction = [1, 1, 0, [0.0, 0.0, 0.0, 0.0], [0.1, 0.1, 0.1, 0.90], [0.5, 0.5, 0.5, 0.00]]};
				case "rhsusf_shemagh2_gogg_grn"		: 	{_correction = [1, 1, 0, [0.0, 0.0, 0.0, 0.0], [0.1, 0.1, 0.1, 0.90], [0.5, 0.5, 0.5, 0.00]]};
				case "rhsusf_shemagh_gogg_od"		: 	{_correction = [1, 1, 0, [0.0, 0.0, 0.0, 0.0], [0.1, 0.1, 0.1, 0.90], [0.5, 0.5, 0.5, 0.00]]};
				case "rhsusf_shemagh2_gogg_od"		: 	{_correction = [1, 1, 0, [0.0, 0.0, 0.0, 0.0], [0.1, 0.1, 0.1, 0.90], [0.5, 0.5, 0.5, 0.00]]};
				case "rhsusf_shemagh_gogg_tan"		: 	{_correction = [1, 1, 0, [0.0, 0.0, 0.0, 0.0], [0.1, 0.1, 0.1, 0.90], [0.5, 0.5, 0.5, 0.00]]};
				case "rhsusf_shemagh2_gogg_tan"		: 	{_correction = [1, 1, 0, [0.0, 0.0, 0.0, 0.0], [0.1, 0.1, 0.1, 0.90], [0.5, 0.5, 0.5, 0.00]]};
				case "rhsusf_shemagh_gogg_white"	: 	{_correction = [1, 1, 0, [0.0, 0.0, 0.0, 0.0], [0.1, 0.1, 0.1, 0.90], [0.5, 0.5, 0.5, 0.00]]};
				case "rhsusf_shemagh2_gogg_white"	: 	{_correction = [1, 1, 0, [0.0, 0.0, 0.0, 0.0], [0.1, 0.1, 0.1, 0.90], [0.5, 0.5, 0.5, 0.00]]};
				case "ffaa_Glasses"					: 	{_correction = [1, 1, 0, [0.0, 0.0, 0.0, 0.0], [0.1, 0.1, 0.1, 1.00], [0.5, 0.5, 0.5, 0.00]]};
				case "UK3CB_BAF_G_Tactical_Black"	: 	{_correction = [1, 1, 0, [0.0, 0.0, 0.0, 0.0], [0.1, 0.1, 0.1, 0.90], [0.5, 0.5, 0.5, 0.00]]};
				case "UK3CB_BAF_G_Tactical_Grey"	: 	{_correction = [1, 1, 0, [0.0, 0.0, 0.0, 0.0], [0.1, 0.1, 0.1, 0.92], [0.5, 0.5, 0.5, 0.00]]};
				case "UK3CB_BAF_G_Tactical_Clear"	: 	{_correction = [1, 1, 0, [0.0, 0.0, 0.0, 0.0], [0.1, 0.1, 0.1, 0.95], [0.5, 0.5, 0.5, 0.00]]};
				case "UK3CB_BAF_G_Tactical_Orange"	: 	{_correction = [1, 1, 0, [0.0, 0.0, 0.0, 0.0], [1.0, 0.6, 0.1, 0.60], [0.5, 0.5, 0.5, 0.00]]};
				case "UK3CB_BAF_G_Tactical_Yellow"	: 	{_correction = [1, 1, 0, [0.0, 0.0, 0.0, 0.0], [0.9, 0.9, 0.0, 0.70], [0.5, 0.5, 0.5, 0.00]]};
				case "CUP_G_Oakleys_Drk"						: 	{_correction = [1, 1, 0, [0.0, 0.0, 0.0, 0.0], [0.1, 0.1, 0.1, 0.90], [0.5, 0.5, 0.5, 0.00]]};
				case "CUP_G_Oakleys_Embr"						: 	{_correction = [1, 1, 0, [0.0, 0.0, 0.0, 0.0], [1.0, 0.5, 0.5, 0.60], [0.5, 0.5, 0.5, 0.00]]};
				case "CUP_G_Oakleys_Clr"						: 	{_correction = [1, 1, 0, [0.0, 0.0, 0.0, 0.0], [0.1, 0.1, 0.1, 0.95], [0.5, 0.5, 0.5, 0.00]]};
				case "CUP_G_Grn_Scarf_Shades_GPS"				: 	{_correction = [1, 1, 0, [0.0, 0.0, 0.0, 0.0], [0.1, 0.1, 0.1, 0.95], [0.5, 0.5, 0.5, 0.00]]};
				case "CUP_G_Tan_Scarf_Shades_GPS"				: 	{_correction = [1, 1, 0, [0.0, 0.0, 0.0, 0.0], [0.1, 0.1, 0.1, 0.95], [0.5, 0.5, 0.5, 0.00]]};
				case "CUP_G_White_Scarf_Shades_GPS"				: 	{_correction = [1, 1, 0, [0.0, 0.0, 0.0, 0.0], [0.1, 0.1, 0.1, 0.95], [0.5, 0.5, 0.5, 0.00]]};
				case "CUP_G_PMC_RadioHeadset_Glasses"			: 	{_correction = [1, 1, 0, [0.0, 0.0, 0.0, 0.0], [0.1, 0.1, 0.1, 0.95], [0.5, 0.5, 0.5, 0.00]]};
				case "CUP_G_PMC_RadioHeadset_Glasses_Dark"		: 	{_correction = [1, 1, 0, [0.0, 0.0, 0.0, 0.0], [0.1, 0.1, 0.1, 0.90], [0.5, 0.5, 0.5, 0.00]]};
				case "CUP_G_PMC_RadioHeadset_Glasses_Ember"		: 	{_correction = [1, 1, 0, [0.0, 0.0, 0.0, 0.0], [1.0, 0.6, 0.1, 0.60], [0.5, 0.5, 0.5, 0.00]]};
				case "CUP_G_ESS_BLK_Dark"						: 	{_correction = [1, 1, 0, [0.0, 0.0, 0.0, 0.0], [0.1, 0.1, 0.1, 0.90], [0.5, 0.5, 0.5, 0.00]]};
				case "CUP_G_ESS_BLK_Ember"						: 	{_correction = [1, 1, 0, [0.0, 0.0, 0.0, 0.0], [1.0, 0.5, 0.5, 0.60], [0.5, 0.5, 0.5, 0.00]]};
				case "CUP_G_ESS_BLK"							: 	{_correction = [1, 1, 0, [0.0, 0.0, 0.0, 0.0], [0.1, 0.1, 0.1, 0.95], [0.5, 0.5, 0.5, 0.00]]};
				case "TFC_G_Ballistics_Dark"		: 	{_correction = [1, 1, 0, [0.0, 0.0, 0.0, 0.0], [0.1, 0.1, 0.1, 0.90], [0.5, 0.5, 0.5, 0.00]]};
				case "TFC_G_Ballistics_Clear"		: 	{_correction = [1, 1, 0, [0.0, 0.0, 0.0, 0.0], [0.1, 0.1, 0.1, 0.95], [0.5, 0.5, 0.5, 0.00]]};
				case "TFC_G_Ballistics_Orange"		: 	{_correction = [1, 1, 0, [0.0, 0.0, 0.0, 0.0], [1.0, 0.6, 0.1, 0.60], [0.5, 0.5, 0.5, 0.00]]};
				case "TFC_G_Ballistics_Yellow"		: 	{_correction = [1, 1, 0, [0.0, 0.0, 0.0, 0.0], [0.9, 0.9, 0.0, 0.70], [0.5, 0.5, 0.5, 0.00]]};
				case "BWA3_G_Combat_black"			: 	{_correction = [1, 1, 0, [0.0, 0.0, 0.0, 0.0], [0.1, 0.1, 0.1, 0.90], [0.5, 0.5, 0.5, 0.00]]};
				case "BWA3_G_Combat_clear"			: 	{_correction = [1, 1, 0, [0.0, 0.0, 0.0, 0.0], [0.1, 0.1, 0.1, 0.95], [0.5, 0.5, 0.5, 0.00]]};
				case "BWA3_G_Combat_orange"			: 	{_correction = [1, 1, 0, [0.0, 0.0, 0.0, 0.0], [1.0, 0.6, 0.1, 0.60], [0.5, 0.5, 0.5, 0.00]]};	
				default 								{_correction = call Gemini_fnc_mapColorCorrection};
			};

		// CREATING FILTER
		"colorCorrections" ppEffectAdjust _correction;
		"colorCorrections" ppEffectCommit 0.5;
		"colorCorrections" ppEffectEnable true;

	};

// CREATING INFINITE LOOP
while {true} do {call Gemini_fnc_gogglesColorCorrection; sleep 0.5};