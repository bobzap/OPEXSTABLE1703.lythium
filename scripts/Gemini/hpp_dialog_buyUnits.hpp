class OPEX_buyUnits

	{
		idd = -1;
		movingenable = true;

		class Controls
			{


				////////////////////////////////////////////////////////
				// GUI EDITOR OUTPUT START (by Fred, v1.063, #Wapeju)
				////////////////////////////////////////////////////////

				class OPEX_buyUnits_title: RscText
				{
					idc = 500;
					style = ST_LEFT;
					text = $STR_dialog_buyUnitsTitle; //--- ToDo: Localize;
					x = 0.25 * safezoneW + safezoneX;
					y = 0.165 * safezoneH + safezoneY;
					w = 0.46 * safezoneW;
					h = 0.030 * safezoneH;
					colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.00])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.25])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.65])",0.90};
				};

				class OPEX_buyUnits_currentUnitsBackground: RscFrame
				{
					idc = 501;
					x = 0.25 * safezoneW + safezoneX;
					y = 0.20 * safezoneH + safezoneY;
					w = 0.20 * safezoneW;
					h = 0.65 * safezoneH;
					colorBackground[] = {0.05,0.05,0.05,0.75};
				};

				class OPEX_buyUnits_currentUnitsTitle: RscText
				{
					idc = 502;
					style = ST_LEFT;
					x = 0.25 * safezoneW + safezoneX;
					y = 0.20 * safezoneH + safezoneY;
					w = 0.20 * safezoneW;
					h = 0.028 * safezoneH;
					colorBackground[] = {0,0,0,0.9};
				};

				class OPEX_buyUnits_currentUnits: RscListBox
				{
					idc = 503;
					x = 0.25 * safezoneW + safezoneX;
					y = 0.23 * safezoneH + safezoneY;
					w = 0.20 * safezoneW;
					h = 0.54 * safezoneH;
					colorBackground[] = {0,0,0,0.0};
				};

				class OPEX_buyUnits_availableUnitsBackground: RscFrame
				{
					idc = 504;
					x = 0.46 * safezoneW + safezoneX;
					y = 0.20 * safezoneH + safezoneY;
					w = 0.25 * safezoneW;
					h = 0.65 * safezoneH;
					colorBackground[] = {0.05,0.05,0.05,0.75};
				};


				class OPEX_buyUnits_availableUnitsTitle_backgroundTempFix: RscFrame
				{
					idc = 510;
					x = 0.46 * safezoneW + safezoneX;
					y = 0.20 * safezoneH + safezoneY;
					w = 0.25 * safezoneW;
					h = 0.028 * safezoneH;
					colorBackground[] = {0,0,0,1};
				};

				class OPEX_buyUnits_availableUnitsTitle: RscListNbox
				{
					idc = 505;
					x = 0.46 * safezoneW + safezoneX;
					y = 0.20 * safezoneH + safezoneY;
					w = 0.25 * safezoneW;
					h = 0.028 * safezoneH;
					columns[] = {0, 0.75}; // Horizontal coordinates of columns (relative to list width, in range from 0 to 1)
				};

				class OPEX_buyUnits_availableUnits: RscListNbox
				{
					idc = 506;
					x = 0.46 * safezoneW + safezoneX;
					y = 0.23 * safezoneH + safezoneY;
					w = 0.25 * safezoneW;
					h = 0.54 * safezoneH;
					colorBackground[] = {0,0,0,1};
					columns[] = {0, 0.75}; // Horizontal coordinates of columns (relative to list width, in range from 0 to 1)
					colorSelectBackground[] = {1,1,1,1}; // Selected item fill color
					colorSelectBackground2[] = {1,1,1,1}; // Selected item fill color (oscillates between this and colorSelectBackground)
					colorSelect[] = {0,0,0,1}; // Text selection color
					colorSelect2[] = {0,0,0,1}; // Text selection color (oscillates between this and colorSelect)
					colorPicture[] = {1,1,1,1};
					colorPictureSelected[] = {1,1,1,1};
					colorPictureDisabled[] = {0,0,0,0.5};
					//onMouseEnter = "(_this select 0) ctrlSetTextColor [0, 0, 0, 1]";
					//onMouseExit = "(_this select 0) ctrlSetTextColor [0, 0, 0, 1]";
				};


				class OPEX_buyUnits_enlist: RscButton
				{
					idc = 507;
					sizeEx = 0.035;
					x = 0.465 * safezoneW + safezoneX;
					y = 0.79 * safezoneH + safezoneY;
					w = 0.24 * safezoneW;
					h = 0.028 * safezoneH;
					colorBackground[] = {0,0.75,0,0.35};
					colorBackgroundActive[] = {0,0.75,0,0.8};
					colorFocused[] = {0,0.75,0,0.8};
					colorBackgroundDisabled[] = {0.75,0,0,0.35};
					colorText[] = {1,1,1,1};
					onMouseEnter = "(_this select 0) ctrlSetTextColor [1, 1, 1, 1]";
					onMouseExit = "(_this select 0) ctrlSetTextColor [1, 1, 1, 1]";
				};

				class OPEX_buyUnits_demobilize: RscButton
				{
					idc = 508;
					sizeEx = 0.035;
					x = 0.255 * safezoneW + safezoneX;
					y = 0.79 * safezoneH + safezoneY;
					w = 0.19 * safezoneW;
					h = 0.028 * safezoneH;
					colorBackground[] = {0.75,0,0,0.35};
					colorBackgroundActive[] = {0.75,0,0,0.8};
					colorFocused[] = {0.75,0,0,0.8};
					colorText[] = {1,1,1,1};
					onMouseEnter = "(_this select 0) ctrlSetTextColor [1, 1, 1, 1]";
					onMouseExit = "(_this select 0) ctrlSetTextColor [1, 1, 1, 1]";
				};

				class OPEX_buyUnits_close: RscButton
				{
					idc = 509;
					x = 0.25 * safezoneW + safezoneX;
					y = 0.855 * safezoneH + safezoneY;
					w = 0.075 * safezoneW;
					h = 0.025 * safezoneH;
				};

	////////////////////////////////////////////////////////
	// GUI EDITOR OUTPUT END
	////////////////////////////////////////////////////////

		};

	};