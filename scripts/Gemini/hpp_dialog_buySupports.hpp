class OPEX_buySupports

	{
		idd = -1;
		movingenable = true;

		class Controls
			{
				// TITLE PART

					class OPEX_buySupports_mainTitle: RscText
						{
							idc = 900;
							style = ST_LEFT;
							text = $STR_dialog_buySupportsTitle;
							x = 0.35 * safezoneW + safezoneX;
							y = 0.245 * safezoneH + safezoneY;
							w = 0.35 * safezoneW;
							h = 0.030 * safezoneH;
							colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.00])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.25])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.65])",0.90};
						};

				// MAIN PART

					class OPEX_buySupports_mainBackground: RscFrame
						{
							idc = 901;
							x = 0.35 * safezoneW + safezoneX;
							y = 0.28 * safezoneH + safezoneY;
							w = 0.35 * safezoneW;
							h = 0.30 * safezoneH;
							colorBackground[] = {0.05,0.05,0.05,0.75};
						};

				// SUPPORTS

					class OPEX_buySupports_listTitleBackground: RscText
						{
							idc = 902;
							style = ST_LEFT;
							x = 0.35 * safezoneW + safezoneX;
							y = 0.28 * safezoneH + safezoneY;
							w = 0.35 * safezoneW;
							h = 0.028 * safezoneH;
							colorBackground[] = {0,0,0,0.9};
							color[] = {0, 1, 0, 1};
							colorSelect[] = {1,0,0,1}; // Text selection color
							colorSelect2[] = {1,1,1,1}; // Text selection color (oscillates between this and colorSelect)
						};

					class OPEX_buySupports_listTitle: RscListNbox
						{
							idc = 903;
							x = 0.35 * safezoneW + safezoneX;
							y = 0.28 * safezoneH + safezoneY;
							w = 0.35 * safezoneW;
							h = 0.028 * safezoneH;
							columns[] = {0, 0.1, 0.8}; // Horizontal coordinates of columns (relative to list width, in range from 0 to 1)
							colorSelect[] = {1,1,1,1}; // Text selection color
							colorSelect2[] = {1,1,1,1}; // Text selection color (oscillates between this and colorSelect)
						};

					class OPEX_buySupports_listContent: RscListNbox
						{
							idc = 904;
							x = 0.35 * safezoneW + safezoneX;
							y = 0.307 * safezoneH + safezoneY;
							w = 0.35 * safezoneW;
							h = 0.21 * safezoneH;
							columns[] = {0, 0.1, 0.8}; // Horizontal coordinates of columns (relative to list width, in range from 0 to 1)
							colorSelectBackground[] = {1,1,1,1}; // Selected item fill color
							colorSelectBackground2[] = {1,1,1,1}; // Selected item fill color (oscillates between this and colorSelectBackground)
							colorSelect[] = {0,0,0,1}; // Text selection color
							colorSelect2[] = {0,0,0,1}; // Text selection color (oscillates between this and colorSelect)
							colorPicture[] = {1,1,1,1};
							colorPictureSelected[] = {0,0,0,1};
							colorPictureDisabled[] = {0,0,0,0.5};

						};
					class OPEX_buySupports_buyButton: RscButton
						{
							idc = 905;
							sizeEx = 0.035;
							x = 0.375 * safezoneW + safezoneX;
							y = 0.53 * safezoneH + safezoneY;
							w = 0.30 * safezoneW;
							h = 0.03 * safezoneH;
							colorBackground[] = {0,0.75,0,0.35}; // background color
							colorBackgroundActive[] = {0,0.75,0,0.8}; // background color (when cursor is hovering the button)
							colorFocused[] = {0,0.75,0,0.8}; // background color #2 (when the button has been clicked)
							colorBackgroundDisabled[] = {0.75,0,0,0.35};
							colorText[] = {1,1,1,1};
							onMouseEnter = "(_this select 0) ctrlSetTextColor [1, 1, 1, 1]";
							onMouseExit = "(_this select 0) ctrlSetTextColor [1, 1, 1, 1]";
						};
					class OPEX_buySupports_closeButton: RscButton
						{
							idc = 906;
							x = 0.35 * safezoneW + safezoneX;
							y = 0.585 * safezoneH + safezoneY;
							w = 0.075 * safezoneW;
							h = 0.025 * safezoneH;
						};


			};

	};