class OPEX_needsManager

	{
		idd = 4000;
		movingenable = true;

		class Controls
			{


				////////////////////////////////////////////////////////
				// GUI EDITOR OUTPUT START (by Fred, v1.063, #Wapeju)
				////////////////////////////////////////////////////////

				class OPEX_needsManager_title: RscText
					{
						idc = 4001;
						style = ST_LEFT;
						text = $STR_dialog_needsManagerTitle; //--- ToDo: Localize;
						x = 0.25 * safezoneW + safezoneX;
						y = 0.245 * safezoneH + safezoneY;
						w = 0.5 * safezoneW;
						h = 0.030 * safezoneH;
						colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.00])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.25])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.65])",0.90};
					};

				class OPEX_needsManager_background: RscFrame
					{
						idc = 4002;
						x = 0.25 * safezoneW + safezoneX;
						y = 0.2775 * safezoneH + safezoneY;
						w = 0.5 * safezoneW;
						h = 0.40 * safezoneH;
						colorBackground[] = {0.05,0.05,0.05,0.75};
					};

				class OPEX_needsManager_hunger: RscText
					{
						idc = 4010;
						style = 16 + 512;
						x = 0.275 * safezoneW + safezoneX;
						y = 0.32 * safezoneH + safezoneY;
						w = 0.126 * safezoneW;
						h = 0.027 * safezoneH;
						colorBackground[] = {0,0,0,0.0}; // fond par défaut
					};

				class OPEX_needsManager_hungerStatus: RscText
					{
						idc = 4011;
						style = 16 + 512;
						x = 0.34 * safezoneW + safezoneX;
						y = 0.32 * safezoneH + safezoneY;
						w = 0.126 * safezoneW;
						h = 0.027 * safezoneH;
						colorBackground[] = {0,0,0,0.0}; // fond par défaut
					};


				class OPEX_needsManager_thirst: RscText
					{
						idc = 4020;
						style = 16 + 512;
						x = 0.275 * safezoneW + safezoneX;
						y = 0.35 * safezoneH + safezoneY;
						w = 0.126 * safezoneW;
						h = 0.027 * safezoneH;
						colorBackground[] = {0,0,0,0.0}; // fond par défaut
					};

				class OPEX_needsManager_thirstStatus: RscText
					{
						idc = 4021;
						style = 16 + 512;
						x = 0.34 * safezoneW + safezoneX;
						y = 0.35 * safezoneH + safezoneY;
						w = 0.126 * safezoneW;
						h = 0.027 * safezoneH;
						colorBackground[] = {0,0,0,0.0}; // fond par défaut
					};


				class OPEX_needsManager_tiredness: RscText
					{
						idc = 4030;
						style = 16 + 512;
						x = 0.275 * safezoneW + safezoneX;
						y = 0.38 * safezoneH + safezoneY;
						w = 0.126 * safezoneW;
						h = 0.027 * safezoneH;
						colorBackground[] = {0,0,0,0.0}; // fond par défaut
					};

				class OPEX_needsManager_tirednessStatus: RscText
					{
						idc = 4031;
						style = 16 + 512;
						x = 0.34 * safezoneW + safezoneX;
						y = 0.38 * safezoneH + safezoneY;
						w = 0.126 * safezoneW;
						h = 0.027 * safezoneH;
						colorBackground[] = {0,0,0,0.0}; // fond par défaut
					};

				class OPEX_needsManager_warning: RscText
					{
						idc = 4040;
						style = 16 + 512;
						x = 0.275 * safezoneW + safezoneX;
						y = 0.440 * safezoneH + safezoneY;
						w = 0.445 * safezoneW;
						h = 0.20 * safezoneH;
						colorBackground[] = {0,0,0,0.0}; // fond par défaut
					};

				class OPEX_needsManager_close: RscButton
					{
						idc = 4999;
						x = 0.25 * safezoneW + safezoneX;
						y = 0.68 * safezoneH + safezoneY;
						w = 0.075 * safezoneW;
						h = 0.025 * safezoneH;
					};

	////////////////////////////////////////////////////////
	// GUI EDITOR OUTPUT END
	////////////////////////////////////////////////////////

		};

	};