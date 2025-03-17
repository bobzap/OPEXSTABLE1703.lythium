class OPEX_taskManager

	{
		idd = 2000;
		movingenable = true;

		class Controls
			{


				////////////////////////////////////////////////////////
				// GUI EDITOR OUTPUT START (by Fred, v1.063, #Wapeju)
				////////////////////////////////////////////////////////

				class OPEX_taskManager_title: RscText
				{
					idc = 2001;
					style = ST_LEFT;
					x = 0.25 * safezoneW + safezoneX;
					y = 0.145 * safezoneH + safezoneY;
					w = 0.5 * safezoneW;
					h = 0.030 * safezoneH;
					colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.00])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.25])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.65])",0.90};
				};

				class OPEX_taskManager_Background: RscFrame
				{
					idc = 2002;
					x = 0.25 * safezoneW + safezoneX;
					y = 0.1775 * safezoneH + safezoneY;
					w = 0.5 * safezoneW;
					h = 0.6 * safezoneH;
					colorBackground[] = {0.05,0.05,0.05,0.75}; // fond par défaut
				};

				class OPEX_taskManager_taskListTitle: RscText
				{
					idc = 2300;
					style = ST_LEFT;
					x = 0.257 * safezoneW + safezoneX;
					y = 0.188 * safezoneH + safezoneY;
					w = 0.486 * safezoneW;
					h = 0.025 * safezoneH;
					colorBackground[] = {0,0,0,0.9}; // fond par défaut
				};

				class OPEX_taskManager_taskList: RscListbox
				{
					idc = 2301;
					x = 0.257 * safezoneW + safezoneX;
					y = 0.213 * safezoneH + safezoneY;
					w = 0.486 * safezoneW;
					h = 0.370 * safezoneH;
					color[] = {1, 1, 1, 0};
					colorDisabled[] = {}; // Disabled text color
					colorText[] = {1, 1, 1, 1};
					colorScrollbar[] = {1, 1, 1, 1};
					colorSelect[] = {0, 0, 0, 1}; // text color
					colorSelect2[] = {0, 0, 0, 1};
					colorSelectBackground[] = {1, 1, 1, 0.8};
					colorSelectBackground2[] = {1, 1, 1, 0.8}; // selected line background
					colorBackground[] = {0,0,0,0.0}; // box background
					pictureColor[] = {1,0,0,0.5}; // Picture color
					pictureColorSelect[] = {0,1,0,0.5}; // Selected picture color
				};

				class OPEX_taskManager_overviewTitle: RscText
				{
					idc = 2400;
					style = ST_LEFT;
					x = 0.257 * safezoneW + safezoneX;
					y = 0.615 * safezoneH + safezoneY;
					w = 0.486 * safezoneW;
					h = 0.025 * safezoneH;
					colorBackground[] = {0,0,0,0.9}; // fond par défaut
				};

				class OPEX_taskManager_overview: RscText
				{
					idc = 2401;
					style = 16 + 512;
					x = 0.257 * safezoneW + safezoneX;
					y = 0.640 * safezoneH + safezoneY;
					w = 0.486 * safezoneW;
					h = 0.125 * safezoneH;
					colorBackground[] = {0,0,0,0.0}; // fond par défaut
				};

				class OPEX_taskManager_close: RscButton
				{
					idc = 2004;
					x = 0.25 * safezoneW + safezoneX;
					y = 0.7825 * safezoneH + safezoneY;
					w = 0.075 * safezoneW;
					h = 0.025 * safezoneH;
				};

				class OPEX_taskManager_cancel: RscButton
				{
					idc = 2005;
					x = 0.54 * safezoneW + safezoneX;
					y = 0.7825 * safezoneH + safezoneY;
					w = 0.1 * safezoneW;
					h = 0.025 * safezoneH;
				};

				class OPEX_taskManager_start: RscButton
				{
					idc = 2006;
					x = 0.65 * safezoneW + safezoneX;
					y = 0.7825 * safezoneH + safezoneY;
					w = 0.1 * safezoneW;
					h = 0.025 * safezoneH;
				};


	////////////////////////////////////////////////////////
	// GUI EDITOR OUTPUT END
	////////////////////////////////////////////////////////

		};

	};