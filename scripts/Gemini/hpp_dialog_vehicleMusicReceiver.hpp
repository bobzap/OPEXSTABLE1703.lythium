class OPEX_vehicleMusicReceiver

	{
		idd = -1;
		movingenable = true;

		class Controls
			{
				class OPEX_vehicleMusicReceiver_background: RscPicture
					{
						idc = 900;
						x = 0.25 * safezoneW + safezoneX;
						y = 0.28 * safezoneH + safezoneY;
						w = 0.45 * safezoneW;
						h = 0.35 * safezoneH;
						text = "pictures\vehicleMusicReceiver.paa";
					};

				// LCD SCREEN ( track)
				class OPEX_vehicleMusicReceiver_track_title: RscText
					{
						idc = 901;
						style = 16 + 512;
						x = 0.38 * safezoneW + safezoneX;
						y = 0.406 * safezoneH + safezoneY;
						w = 0.295 * safezoneW;
						h = 0.040 * safezoneH;
						colorBackground[] = {0,0,0,0}; // fond par défaut
					};
				class OPEX_vehicleMusicReceiver_track_titleTITLE: RscText
					{
						idc = 9011;
						style = 16 + 512;
						sizeEx = 0.022;
						x = 0.38 * safezoneW + safezoneX;
						y = 0.396 * safezoneH + safezoneY;
						w = 0.250 * safezoneW;
						h = 0.040 * safezoneH;
						colorBackground[] = {0,0,0,0}; // fond par défaut
					};

				// LCD SCREEN (TIME TRACK)
				class OPEX_vehicleMusicReceiver_track_time: RscText
					{
						idc = 902;
						style = 16 + 512;
						x = 0.38 * safezoneW + safezoneX;
						y = 0.456 * safezoneH + safezoneY;
						w = 0.100 * safezoneW;
						h = 0.030 * safezoneH;
						colorBackground[] = {0,0,0,0}; // fond par défaut
					};
				class OPEX_vehicleMusicReceiver_track_timeTITLE: RscText
					{
						idc = 9021;
						style = 16 + 512;
						sizeEx = 0.022;
						x = 0.38 * safezoneW + safezoneX;
						y = 0.446 * safezoneH + safezoneY;
						w = 0.250 * safezoneW;
						h = 0.040 * safezoneH;
						colorBackground[] = {0,0,0,0}; // fond par défaut
					};


				// LCD SCREEN (SHUFFLE MODE)
				class OPEX_vehicleMusicReceiver_track_shuffle: RscText
					{
						idc = 904;
						style = 16 + 512;
						x = 0.50 * safezoneW + safezoneX;
						y = 0.456 * safezoneH + safezoneY;
						w = 0.100 * safezoneW;
						h = 0.030 * safezoneH;
						colorBackground[] = {0,0,0,0}; // fond par défaut
					};
				class OPEX_vehicleMusicReceiver_track_shuffleTITLE: RscText
					{
						idc = 9041;
						style = 16 + 512;
						sizeEx = 0.022;
						x = 0.50 * safezoneW + safezoneX;
						y = 0.446 * safezoneH + safezoneY;
						w = 0.250 * safezoneW;
						h = 0.040 * safezoneH;
						colorBackground[] = {0,0,0,0}; // fond par défaut
					};

				// LCD SCREEN (VOLUME)
				class OPEX_vehicleMusicReceiver_track_volume: RscText
					{
						idc = 903;
						style = 16 + 512;
						x = 0.60 * safezoneW + safezoneX;
						y = 0.456 * safezoneH + safezoneY;
						w = 0.960 * safezoneW;
						h = 0.030 * safezoneH;
						colorBackground[] = {0,0,0,0}; // fond par défaut
					};
				class OPEX_vehicleMusicReceiver_track_volumeTITLE: RscText
					{
						idc = 9031;
						style = 16 + 512;
						sizeEx = 0.022;
						x = 0.60 * safezoneW + safezoneX;
						y = 0.446 * safezoneH + safezoneY;
						w = 0.250 * safezoneW;
						h = 0.040 * safezoneH;
						colorBackground[] = {0,0,0,0}; // fond par défaut
					};

				// POWER BUTTON
				class OPEX_vehicleMusicReceiver_power: RscButton
					{
						idc = 910;
						x = 0.2625 * safezoneW + safezoneX;
						y = 0.43 * safezoneH + safezoneY;
						w = 0.029 * safezoneW;
						h = 0.037 * safezoneH;
						color[] = {0,0,0,0};
						colorText[] = {0,0,0,0};
						colorDisabled[] = {0,0,0,0};
						colorBackground[] = {0,0,0,0};
						colorBackgroundDisabled[] = {0,0,0,0};
						colorBackgroundActive[] = {0,0,0,0};
						colorFocused[] = {0,0,0,0};
						colorShadow[] = {0,0,0,0};
						colorBorder[] = {0,0,0,0};
						onMouseEnter = "(_this select 0) ctrlSetTextColor [0, 0, 0, 0]";
						onMouseExit = "(_this select 0) ctrlSetTextColor [0, 0, 0, 0]";
						offsetX = 0;
						offsetY = 0;
						offsetPressedX = 0;
						offsetPressedY = 0;
						borderSize = 0;
						tooltip =  "$STR_tooltip_power";
					};

				// VOL- BUTTON
				class OPEX_vehicleMusicReceiver_VolDown: RscButton
					{
						idc = 911;
						x = 0.366 * safezoneW + safezoneX;
						y = 0.512 * safezoneH + safezoneY;
						w = 0.037 * safezoneW;
						h = 0.029 * safezoneH;
						color[] = {0,0,0,0};
						colorText[] = {0,0,0,0};
						colorDisabled[] = {0,0,0,0};
						colorBackground[] = {0,0,0,0};
						colorBackgroundDisabled[] = {0,0,0,0};
						colorBackgroundActive[] = {0,0,0,0};
						colorFocused[] = {0,0,0,0};
						colorShadow[] = {0,0,0,0};
						colorBorder[] = {0,0,0,0};
						onMouseEnter = "(_this select 0) ctrlSetTextColor [0, 0, 0, 0]";
						onMouseExit = "(_this select 0) ctrlSetTextColor [0, 0, 0, 0]";
						offsetX = 0;
						offsetY = 0;
						offsetPressedX = 0;
						offsetPressedY = 0;
						borderSize = 0;
						tooltip =  "$STR_tooltip_VOLDOWN";
					};

				// MUTE BUTTON
				class OPEX_vehicleMusicReceiver_volMute: RscButton
					{
						idc = 912;
						x = 0.403 * safezoneW + safezoneX;
						y = 0.512 * safezoneH + safezoneY;
						w = 0.037 * safezoneW;
						h = 0.029 * safezoneH;
						color[] = {0,0,0,0};
						colorText[] = {0,0,0,0};
						colorDisabled[] = {0,0,0,0};
						colorBackground[] = {0,0,0,0};
						colorBackgroundDisabled[] = {0,0,0,0};
						colorBackgroundActive[] = {0,0,0,0};
						colorFocused[] = {0,0,0,0};
						colorShadow[] = {0,0,0,0};
						colorBorder[] = {0,0,0,0};
						onMouseEnter = "(_this select 0) ctrlSetTextColor [0, 0, 0, 0]";
						onMouseExit = "(_this select 0) ctrlSetTextColor [0, 0, 0, 0]";
						offsetX = 0;
						offsetY = 0;
						offsetPressedX = 0;
						offsetPressedY = 0;
						borderSize = 0;
						tooltip =  "$STR_tooltip_VOLMUTE";
					};

				// VOL+ BUTTON
				class OPEX_vehicleMusicReceiver_volUp: RscButton
					{
						idc = 913;
						x = 0.440 * safezoneW + safezoneX;
						y = 0.512 * safezoneH + safezoneY;
						w = 0.037 * safezoneW;
						h = 0.029 * safezoneH;
						color[] = {0,0,0,0};
						colorText[] = {0,0,0,0};
						colorDisabled[] = {0,0,0,0};
						colorBackground[] = {0,0,0,0};
						colorBackgroundDisabled[] = {0,0,0,0};
						colorBackgroundActive[] = {0,0,0,0};
						colorFocused[] = {0,0,0,0};
						colorShadow[] = {0,0,0,0};
						colorBorder[] = {0,0,0,0};
						onMouseEnter = "(_this select 0) ctrlSetTextColor [0, 0, 0, 0]";
						onMouseExit = "(_this select 0) ctrlSetTextColor [0, 0, 0, 0]";
						offsetX = 0;
						offsetY = 0;
						offsetPressedX = 0;
						offsetPressedY = 0;
						borderSize = 0;
						tooltip =  "$STR_tooltip_VOLUP";
					};

				// PLAY BUTTON
				class OPEX_vehicleMusicReceiver_play: RscButton
					{
						idc = 914;
						x = 0.496 * safezoneW + safezoneX;
						y = 0.512 * safezoneH + safezoneY;
						w = 0.037 * safezoneW;
						h = 0.029 * safezoneH;
						color[] = {0,0,0,0};
						colorText[] = {0,0,0,0};
						colorDisabled[] = {0,0,0,0};
						colorBackground[] = {0,0,0,0};
						colorBackgroundDisabled[] = {0,0,0,0};
						colorBackgroundActive[] = {0,0,0,0};
						colorFocused[] = {0,0,0,0};
						colorShadow[] = {0,0,0,0};
						colorBorder[] = {0,0,0,0};
						onMouseEnter = "(_this select 0) ctrlSetTextColor [0, 0, 0, 0]";
						onMouseExit = "(_this select 0) ctrlSetTextColor [0, 0, 0, 0]";
						offsetX = 0;
						offsetY = 0;
						offsetPressedX = 0;
						offsetPressedY = 0;
						borderSize = 0;
						tooltip =  "$STR_tooltip_PLAY";
					};

				// STOP BUTTON
				class OPEX_vehicleMusicReceiver_stop: RscButton
					{
						idc = 915;
						x = 0.533 * safezoneW + safezoneX;
						y = 0.512 * safezoneH + safezoneY;
						w = 0.037 * safezoneW;
						h = 0.029 * safezoneH;
						color[] = {0,0,0,0};
						colorText[] = {0,0,0,0};
						colorDisabled[] = {0,0,0,0};
						colorBackground[] = {0,0,0,0};
						colorBackgroundDisabled[] = {0,0,0,0};
						colorBackgroundActive[] = {0,0,0,0};
						colorFocused[] = {0,0,0,0};
						colorShadow[] = {0,0,0,0};
						colorBorder[] = {0,0,0,0};
						onMouseEnter = "(_this select 0) ctrlSetTextColor [0, 0, 0, 0]";
						onMouseExit = "(_this select 0) ctrlSetTextColor [0, 0, 0, 0]";
						offsetX = 0;
						offsetY = 0;
						offsetPressedX = 0;
						offsetPressedY = 0;
						borderSize = 0;
						tooltip =  "$STR_tooltip_STOP";
					};

				// PREVIOUS BUTTON
				class OPEX_vehicleMusicReceiver_previous: RscButton
					{
						idc = 916;
						x = 0.570 * safezoneW + safezoneX;
						y = 0.512 * safezoneH + safezoneY;
						w = 0.037 * safezoneW;
						h = 0.029 * safezoneH;
						color[] = {0,0,0,0};
						colorText[] = {0,0,0,0};
						colorDisabled[] = {0,0,0,0};
						colorBackground[] = {0,0,0,0};
						colorBackgroundDisabled[] = {0,0,0,0};
						colorBackgroundActive[] = {0,0,0,0};
						colorFocused[] = {0,0,0,0};
						colorShadow[] = {0,0,0,0};
						colorBorder[] = {0,0,0,0};
						onMouseEnter = "(_this select 0) ctrlSetTextColor [0, 0, 0, 0]";
						onMouseExit = "(_this select 0) ctrlSetTextColor [0, 0, 0, 0]";
						offsetX = 0;
						offsetY = 0;
						offsetPressedX = 0;
						offsetPressedY = 0;
						borderSize = 0;
						tooltip =  "$STR_tooltip_PREVIOUS";
					};

				// NEXT BUTTON
				class OPEX_vehicleMusicReceiver_next: RscButton
					{
						idc = 917;
						x = 0.607 * safezoneW + safezoneX;
						y = 0.512 * safezoneH + safezoneY;
						w = 0.037 * safezoneW;
						h = 0.029 * safezoneH;
						color[] = {0,0,0,0};
						colorText[] = {0,0,0,0};
						colorDisabled[] = {0,0,0,0};
						colorBackground[] = {0,0,0,0};
						colorBackgroundDisabled[] = {0,0,0,0};
						colorBackgroundActive[] = {0,0,0,0};
						colorFocused[] = {0,0,0,0};
						colorShadow[] = {0,0,0,0};
						colorBorder[] = {0,0,0,0};
						onMouseEnter = "(_this select 0) ctrlSetTextColor [0, 0, 0, 0]";
						onMouseExit = "(_this select 0) ctrlSetTextColor [0, 0, 0, 0]";
						offsetX = 0;
						offsetY = 0;
						offsetPressedX = 0;
						offsetPressedY = 0;
						borderSize = 0;
						tooltip =  "$STR_tooltip_NEXT";
					};

				// SHUFFLE BUTTON
				class OPEX_vehicleMusicReceiver_shuffle: RscButton
					{
						idc = 918;
						x = 0.644 * safezoneW + safezoneX;
						y = 0.512 * safezoneH + safezoneY;
						w = 0.037 * safezoneW;
						h = 0.029 * safezoneH;
						color[] = {0,0,0,0};
						colorText[] = {0,0,0,0};
						colorDisabled[] = {0,0,0,0};
						colorBackground[] = {0,0,0,0};
						colorBackgroundDisabled[] = {0,0,0,0};
						colorBackgroundActive[] = {0,0,0,0};
						colorFocused[] = {0,0,0,0};
						colorShadow[] = {0,0,0,0};
						colorBorder[] = {0,0,0,0};
						onMouseEnter = "(_this select 0) ctrlSetTextColor [0, 0, 0, 0]";
						onMouseExit = "(_this select 0) ctrlSetTextColor [0, 0, 0, 0]";
						offsetX = 0;
						offsetY = 0;
						offsetPressedX = 0;
						offsetPressedY = 0;
						borderSize = 0;
						tooltip =  "$STR_tooltip_SHUFFLE";
					};
			};

	};