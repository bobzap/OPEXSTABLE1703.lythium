class OPEX_params

	{
		idd = 1000;
		onLoad = "[_this] execVM 'scripts\Gemini\fnc_params.sqf'";
		movingEnable = false;           // the dialog can be moved with the mouse (see "moving" below)
		enableSimulation = false;      	// freeze the game
		controlsBackground[] = { };     // no background controls needed
		objects[] = { };                // no objects needed


		class Controls
			{
				///////////////////
				///// COMMON /////
				/////////////////

				// SCREEN BACKGROUND (FRIENDLY FLAG)
				class OPEX_params_background_global: RscPicture
						{
							idc = 1001;
							x = 0.000 * safezoneW + safezoneX;
							y = -0.36 * safezoneH + safezoneY;
							w = 1.000 * safezoneW;
							h = 1.750 * safezoneH;
							colorBackground[] = {0.0,0.0,0.0,1};
							text = "";
						};

				// MAIN TITLE
				class OPEX_params_title: RscText
					{
						idc = 1002;
						style = ST_LEFT + ST_MULTI + ST_NO_RECT;
						x = 0.280 * safezoneW + safezoneX;
						y = 0.300 * safezoneH + safezoneY;
						w = 0.220 * safezoneW;
						h = 0.040 * safezoneH;
						sizeEx = 0.05;
						lineSpacing = 1;
						colorBackground[] = {0.0,0.0,0.0,0.9};
						// colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.00])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.25])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.65])","(profilenamespace getvariable ['GUI_BCG_RGB_A',1])"};
						colorText[] = {1,1,1,1};
					};
				class OPEX_params_version: RscText
					{
						idc = 10021;
						style = ST_RIGHT;
						x = 0.500 * safezoneW + safezoneX;
						y = 0.300 * safezoneH + safezoneY;
						w = 0.200 * safezoneW;
						h = 0.040 * safezoneH;
						sizeEx = 0.035;
						colorBackground[] = {0.0,0.0,0.0,0.9};
						// colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.00])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.25])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.65])","(profilenamespace getvariable ['GUI_BCG_RGB_A',1])"};
						colorText[] = {1,1,1,1};
					};

				// SEMI-TRANSPARENT BLACK BACKGROUND (FOR BETTER READABILITY)
				class OPEX_params_background: RscFrame
					{
						idc = 1003;
						x = 0.280 * safezoneW + safezoneX;
						y = 0.350 * safezoneH + safezoneY;
						w = 0.420 * safezoneW;
						h = 0.367 * safezoneH;
						colorBackground[] = {0.0,0.0,0.0,0.85};
					};

				// START BUTTON
				class OPEX_params_start: RscButton
					{
						idc = 1004;
						x = 0.615 * safezoneW + safezoneX;
						y = 0.730 * safezoneH + safezoneY;
						w = 0.0850 * safezoneW;
						h = 0.0280 * safezoneH;
						colorBackground[] = {0,0,0,1}; // background color
						// colorBackgroundActive[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.00])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.25])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.65])",0.80};
						colorBackgroundActive[] = {0.0,0.0,0.0,0.80};
						colorFocused[] = {0,0,0,1}; // background color #2 (when the button has been clicked)
						colorBackgroundDisabled[] = {0,0,0,1};
						colorText[] = {1,1,1,0.5};
						onMouseEnter = "(_this select 0) ctrlSetTextColor [1, 1, 1, 1]";
						onMouseExit = "(_this select 0) ctrlSetTextColor [1, 1, 1, 0.5]";
					};

				///////////////////////
				///// PARAMETERS /////
				/////////////////////

					// FRIENDLY FACTION
					class OPEX_params_friendlyFaction: RscText
						{
							idc = 1100;
							style = ST_LEFT;
							x = 0.290 * safezoneW + safezoneX;
							y = 0.365 * safezoneH + safezoneY;
							w = 0.150 * safezoneW;
							h = 0.028 * safezoneH;
							sizeEx = 0.035;
							colorText[] = {1,1,1,1};
							colorBackground[] = {0,0,0,0};
							tooltip = "$STR_params_friendlyFaction_tooltip";
							tooltipColorShade[] = {0,0,0,1};
						};
					class OPEX_params_friendlyFaction_list: RscXListNBox
						{
							idc = 1101;
							x = 0.490 * safezoneW + safezoneX;
							y = 0.370 * safezoneH + safezoneY;
							w = 0.200 * safezonew;
							h = 0.025 * safezoneh;
							sizeEx = 0.035;
							onLBSelChanged = "OPEX_param_friendlyFaction = (_this select 0) lbText (lbCurSel (_this select 0)); publicVariable 'OPEX_param_friendlyFaction'; false";
						};

					// ENEMY FACTION
					class OPEX_params_enemyFaction: RscText
						{
							idc = 1102;
							style = ST_LEFT;
							x = 0.290 * safezoneW + safezoneX;
							y = 0.395 * safezoneH + safezoneY;
							w = 0.150 * safezoneW;
							h = 0.028 * safezoneH;
							sizeEx = 0.035;
							colorText[] = {1,1,1,1};
							colorBackground[] = {0,0,0,0};
							tooltip = "$STR_params_enemyFaction_tooltip";
							tooltipColorShade[] = {0,0,0,1};
						};
					class OPEX_params_enemyFaction_list: RscXListNBox
						{
							idc = 1103;
							x = 0.490 * safezoneW + safezoneX;
							y = 0.400 * safezoneH + safezoneY;
							w = 0.200 * safezonew;
							h = 0.025 * safezoneh;
							sizeEx = 0.035;
							onLBSelChanged = "OPEX_param_enemyFaction = (_this select 0) lbText (lbCurSel (_this select 0)); publicVariable 'OPEX_param_enemyFaction'; false";
						};

					// TASK MANAGEMENT
					class OPEX_params_taskManagement: RscText
						{
							idc = 1104;
							style = ST_LEFT;
							x = 0.290 * safezoneW + safezoneX;
							y = 0.425 * safezoneH + safezoneY;
							w = 0.150 * safezoneW;
							h = 0.028 * safezoneH;
							sizeEx = 0.035;
							colorText[] = {1,1,1,1};
							colorBackground[] = {0,0,0,0};
							tooltip = "$STR_params_taskManagement_tooltip";
							tooltipColorShade[] = {0,0,0,1};
						};
					class OPEX_params_taskManagement_list: RscXListNBox
						{
							idc = 1105;
							x = 0.490 * safezoneW + safezoneX;
							y = 0.430 * safezoneH + safezoneY;
							w = 0.200 * safezonew;
							h = 0.025 * safezoneh;
							sizeEx = 0.035;
							onLBSelChanged = "OPEX_param_taskManagement = lbCurSel (_this select 0); publicVariable 'OPEX_param_taskManagement'; false";
						};

					// REST MANAGEMENT
					class OPEX_params_restManagement: RscText
						{
							idc = 1122;
							style = ST_LEFT;
							x = 0.290 * safezoneW + safezoneX;
							y = 0.455 * safezoneH + safezoneY;
							w = 0.150 * safezoneW;
							h = 0.028 * safezoneH;
							sizeEx = 0.035;
							colorText[] = {1,1,1,1};
							colorBackground[] = {0,0,0,0};
							tooltip = "$STR_params_restManagement_tooltip";
							tooltipColorShade[] = {0,0,0,1};
						};
					class OPEX_params_restManagement_list: RscXListNBox
						{
							idc = 1123;
							x = 0.490 * safezoneW + safezoneX;
							y = 0.460 * safezoneH + safezoneY;
							w = 0.200 * safezonew;
							h = 0.025 * safezoneh;
							sizeEx = 0.035;
							onLBSelChanged = "OPEX_param_restManagement = lbCurSel (_this select 0); publicVariable 'OPEX_param_restManagement'; false";
						};

					// GEAR MANAGEMENT
					class OPEX_params_gearManagement: RscText
						{
							idc = 1106;
							style = ST_LEFT;
							x = 0.290 * safezoneW + safezoneX;
							y = 0.485 * safezoneH + safezoneY;
							w = 0.150 * safezoneW;
							h = 0.028 * safezoneH;
							sizeEx = 0.035;
							colorText[] = {1,1,1,1};
							colorBackground[] = {0,0,0,0};
							tooltip = "$STR_params_gearManagement_tooltip";
							tooltipColorShade[] = {0,0,0,1};
						};
					class OPEX_params_gearManagement_list: RscXListNBox
						{
							idc = 1107;
							x = 0.490 * safezoneW + safezoneX;
							y = 0.490 * safezoneH + safezoneY;
							w = 0.200 * safezonew;
							h = 0.025 * safezoneh;
							sizeEx = 0.035;
							onLBSelChanged = "OPEX_param_gearManagement = lbCurSel (_this select 0); publicVariable 'OPEX_param_gearManagement'; false";
						};

					// SUPPORT MANAGEMENT
					class OPEX_params_supportManagement: RscText
						{
							idc = 1108;
							style = ST_LEFT;
							x = 0.290 * safezoneW + safezoneX;
							y = 0.515 * safezoneH + safezoneY;
							w = 0.150 * safezoneW;
							h = 0.028 * safezoneH;
							sizeEx = 0.035;
							colorText[] = {1,1,1,1};
							colorBackground[] = {0,0,0,0};
							tooltip = "$STR_params_supportManagement_tooltip";
							tooltipColorShade[] = {0,0,0,1};
						};
					class OPEX_params_supportManagement_list: RscXListNBox
						{
							idc = 1109;
							x = 0.490 * safezoneW + safezoneX;
							y = 0.520 * safezoneH + safezoneY;
							w = 0.200 * safezonew;
							h = 0.025 * safezoneh;
							sizeEx = 0.035;
							onLBSelChanged = "OPEX_param_supportManagement = lbCurSel (_this select 0); publicVariable 'OPEX_param_supportManagement'; false";
						};

					// MEDICAL SYSTEM
					/*
					class OPEX_params_medical: RscText
						{
							idc = 1110;
							style = ST_LEFT;
							x = 0.290 * safezoneW + safezoneX;
							y = 0.515 * safezoneH + safezoneY;
							w = 0.150 * safezoneW;
							h = 0.028 * safezoneH;
							sizeEx = 0.035;
							colorText[] = {1,1,1,1};
							colorBackground[] = {0,0,0,0};
							tooltip = "$STR_params_medical_tooltip";
							tooltipColorShade[] = {0,0,0,1};
						};
					class OPEX_params_medical_list: RscXListNBox
						{
							idc = 1111;
							x = 0.490 * safezoneW + safezoneX;
							y = 0.520 * safezoneH + safezoneY;
							w = 0.200 * safezonew;
							h = 0.025 * safezoneh;
							sizeEx = 0.035;
							onLBSelChanged = "OPEX_param_medical = lbCurSel (_this select 0); publicVariable 'OPEX_param_medical'; false";
						};
					*/

					// PRIMARY NEEDS
					class OPEX_params_primaryNeeds: RscText
						{
							idc = 1112;
							style = ST_LEFT;
							x = 0.290 * safezoneW + safezoneX;
							y = 0.545 * safezoneH + safezoneY;
							w = 0.150 * safezoneW;
							h = 0.028 * safezoneH;
							sizeEx = 0.035;
							colorText[] = {1,1,1,1};
							colorBackground[] = {0,0,0,0};
							tooltip = "$STR_params_primaryNeeds_tooltip";
							tooltipColorShade[] = {0,0,0,1};
						};
					class OPEX_params_primaryNeeds_list: RscXListNBox
						{
							idc = 1113;
							x = 0.490 * safezoneW + safezoneX;
							y = 0.550 * safezoneH + safezoneY;
							w = 0.200 * safezonew;
							h = 0.025 * safezoneh;
							sizeEx = 0.035;
							onLBSelChanged = "OPEX_param_primaryNeeds = lbCurSel (_this select 0); publicVariable 'OPEX_param_primaryNeeds'; false";
						};

					// FAST TRAVEL
					class OPEX_params_fastTravel: RscText
						{
							idc = 1114;
							style = ST_LEFT;
							x = 0.290 * safezoneW + safezoneX;
							y = 0.575 * safezoneH + safezoneY;
							w = 0.150 * safezoneW;
							h = 0.028 * safezoneH;
							sizeEx = 0.035;
							colorText[] = {1,1,1,1};
							colorBackground[] = {0,0,0,0};
							tooltip = "$STR_params_fastTravel_tooltip";
							tooltipColorShade[] = {0,0,0,1};
						};
					class OPEX_params_fastTravel_list: RscXListNBox
						{
							idc = 1115;
							x = 0.490 * safezoneW + safezoneX;
							y = 0.580 * safezoneH + safezoneY;
							w = 0.200 * safezonew;
							h = 0.025 * safezoneh;
							sizeEx = 0.035;
							onLBSelChanged = "OPEX_param_fastTravel = lbCurSel (_this select 0); publicVariable 'OPEX_param_fastTravel'; false";
						};

					// INTEL
					class OPEX_params_intel: RscText
						{
							idc = 1116;
							style = ST_LEFT;
							x = 0.290 * safezoneW + safezoneX;
							y = 0.605 * safezoneH + safezoneY;
							w = 0.150 * safezoneW;
							h = 0.028 * safezoneH;
							sizeEx = 0.035;
							colorText[] = {1,1,1,1};
							colorBackground[] = {0,0,0,0};
							tooltip = "$STR_params_intel_tooltip";
							tooltipColorShade[] = {0,0,0,1};
						};
					class OPEX_params_intel_list: RscXListNBox
						{
							idc = 1117;
							x = 0.490 * safezoneW + safezoneX;
							y = 0.610 * safezoneH + safezoneY;
							w = 0.200 * safezonew;
							h = 0.025 * safezoneh;
							sizeEx = 0.035;
							onLBSelChanged = "OPEX_param_intel = lbCurSel (_this select 0); publicVariable 'OPEX_param_intel'; false";
						};

					// DAY TIME
					class OPEX_params_dayTime: RscText
						{
							idc = 1118;
							style = ST_LEFT;
							x = 0.290 * safezoneW + safezoneX;
							y = 0.635 * safezoneH + safezoneY;
							w = 0.150 * safezoneW;
							h = 0.028 * safezoneH;
							sizeEx = 0.035;
							colorText[] = {1,1,1,1};
							colorBackground[] = {0,0,0,0};
							tooltip = "$STR_params_dayTime_tooltip";
							tooltipColorShade[] = {0,0,0,1};
						};
					class OPEX_params_dayTime_list: RscXListNBox
						{
							idc = 1119;
							x = 0.490 * safezoneW + safezoneX;
							y = 0.640 * safezoneH + safezoneY;
							w = 0.200 * safezonew;
							h = 0.025 * safezoneh;
							sizeEx = 0.035;
							onLBSelChanged = "OPEX_param_dayTime = lbCurSel (_this select 0); publicVariable 'OPEX_param_dayTime'; false";
						};

					// TIME MULTIPLIER
					class OPEX_params_timeMultiplier: RscText
						{
							idc = 1120;
							style = ST_LEFT;
							x = 0.290 * safezoneW + safezoneX;
							y = 0.665 * safezoneH + safezoneY;
							w = 0.150 * safezoneW;
							h = 0.028 * safezoneH;
							sizeEx = 0.035;
							colorText[] = {1,1,1,1};
							colorBackground[] = {0,0,0,0};
							tooltip = "$STR_params_timeMultiplier_tooltip";
							tooltipColorShade[] = {0,0,0,1};
						};
					class OPEX_params_timeMultiplier_list: RscXListNBox
						{
							idc = 1121;
							x = 0.490 * safezoneW + safezoneX;
							y = 0.670 * safezoneH + safezoneY;
							w = 0.200 * safezonew;
							h = 0.025 * safezoneh;
							sizeEx = 0.035;
							onLBSelChanged = "OPEX_param_timeMultiplier = lbCurSel (_this select 0); publicVariable 'OPEX_param_timeMultiplier'; false";
						};
			};

	};