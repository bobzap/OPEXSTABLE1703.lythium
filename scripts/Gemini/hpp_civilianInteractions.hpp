class OPEX_civilianInteractions

	{
		idd = 3000;
		movingenable = true;

		class Controls
			{
					// MOVEMENTS
						class OPEX_civilianInteractions_MOVEMENT: RscText
							{
								idc = 3001;
								sizeEx = 0.03;
								style = ST_LEFT;
								x = 0.1 * safezoneW + safezoneX;
								y = 0.33 * safezoneH + safezoneY;
								w = 0.135 * safezoneW;
								h = 0.025 * safezoneH;
								colorBackground[] = {0.00, 0.25, 0.65, 0.90};
							};
								class OPEX_civilianInteractions_movement_halt: RscButton
									{
										idc = 3002;
										sizeEx = 0.03;
										style = ST_LEFT;
										x = 0.1 * safezoneW + safezoneX;
										y = 0.36 * safezoneH + safezoneY;
										w = 0.135 * safezoneW;
										h = 0.025 * safezoneH;
										offsetPressedX = 0.002;
										offsetPressedY = 0.002;
										color[] = {1,1,1,1};
										colorText[] = {1,1,1,1};
										colorBackground[] = {0.00,0.00,0.00,1.00};
										colorActive[] = {1,1,1,1};
										colorBackgroundActive[] = {1.00,1.00,1.00,1.00};
										colorFocused[] = {0.00,0.00,0.00,1.00};
										colorDisabled[] = {0.4,0.4,0.4,1.0};
										colorBackgroundDisabled[] = {0.00,0.00,0.00,1.00};
									};
								class OPEX_civilianInteractions_movement_move: RscButton
									{
										idc = 3003;
										sizeEx = 0.03;
										style = ST_LEFT;
										x = 0.1 * safezoneW + safezoneX;
										y = 0.387 * safezoneH + safezoneY;
										w = 0.135 * safezoneW;
										h = 0.025 * safezoneH;
										offsetPressedX = 0.002;
										offsetPressedY = 0.002;
										color[] = {1,1,1,1};
										colorText[] = {1,1,1,1};
										colorBackground[] = {0.00,0.00,0.00,1.00};
										colorActive[] = {1,1,1,1};
										colorBackgroundActive[] = {1.00,1.00,1.00,1.00};
										colorFocused[] = {0.00,0.00,0.00,1.00};
										colorDisabled[] = {0.4,0.4,0.4,1.0};
										colorBackgroundDisabled[] = {0.00,0.00,0.00,1.00};
									};

					// CONVERSATIONS
						class OPEX_civilianInteractions_CONVERSATION: RscText
							{
								idc = 3004;
								sizeEx = 0.03;
								style = ST_LEFT;
								x = 0.1 * safezoneW + safezoneX;
								y = 0.45 * safezoneH + safezoneY;
								w = 0.135 * safezoneW;
								h = 0.025 * safezoneH;
								colorBackground[] = {0.00, 0.25, 0.65, 0.90};
							};
								class OPEX_civilianInteractions_conversation_thoughts: RscButton
									{
										idc = 3005;
										sizeEx = 0.03;
										style = ST_LEFT;
										x = 0.1 * safezoneW + safezoneX;
										y = 0.48 * safezoneH + safezoneY;
										w = 0.135 * safezoneW;
										h = 0.025 * safezoneH;
										offsetPressedX = 0.002;
										offsetPressedY = 0.002;
										color[] = {1,1,1,1};
										colorText[] = {1,1,1,1};
										colorBackground[] = {0.00,0.00,0.00,1.00};
										colorActive[] = {1,1,1,1};
										colorBackgroundActive[] = {1.00,1.00,1.00,1.00};
										colorFocused[] = {0.00,0.00,0.00,1.00};
										colorDisabled[] = {0.4,0.4,0.4,1.0};
										colorBackgroundDisabled[] = {0.00,0.00,0.00,1.00};
									};
								class OPEX_civilianInteractions_conversation_identity: RscButton
									{
										idc = 3006;
										sizeEx = 0.03;
										style = ST_LEFT;
										x = 0.1 * safezoneW + safezoneX;
										y = 0.507 * safezoneH + safezoneY;
										w = 0.135 * safezoneW;
										h = 0.025 * safezoneH;
										offsetPressedX = 0.002;
										offsetPressedY = 0.002;
										color[] = {1,1,1,1};
										colorText[] = {1,1,1,1};
										colorBackground[] = {0.00,0.00,0.00,1.00};
										colorActive[] = {1,1,1,1};
										colorBackgroundActive[] = {1.00,1.00,1.00,1.00};
										colorFocused[] = {0.00,0.00,0.00,1.00};
										colorDisabled[] = {0.4,0.4,0.4,1.0};
										colorBackgroundDisabled[] = {0.00,0.00,0.00,1.00};
									};
								class OPEX_civilianInteractions_conversation_nationality: RscButton
									{
										idc = 3007;
										sizeEx = 0.03;
										style = ST_LEFT;
										x = 0.1 * safezoneW + safezoneX;
										y = 0.534 * safezoneH + safezoneY;
										w = 0.135 * safezoneW;
										h = 0.025 * safezoneH;
										offsetPressedX = 0.002;
										offsetPressedY = 0.002;
										color[] = {1,1,1,1};
										colorText[] = {1,1,1,1};
										colorBackground[] = {0.00,0.00,0.00,1.00};
										colorActive[] = {1,1,1,1};
										colorBackgroundActive[] = {1.00,1.00,1.00,1.00};
										colorFocused[] = {0.00,0.00,0.00,1.00};
										colorDisabled[] = {0.4,0.4,0.4,1.0};
										colorBackgroundDisabled[] = {0.00,0.00,0.00,1.00};
									};
								class OPEX_civilianInteractions_conversation_birthdate: RscButton
									{
										idc = 3008;
										sizeEx = 0.03;
										style = ST_LEFT;
										x = 0.1 * safezoneW + safezoneX;
										y = 0.561 * safezoneH + safezoneY;
										w = 0.135 * safezoneW;
										h = 0.025 * safezoneH;
										offsetPressedX = 0.002;
										offsetPressedY = 0.002;
										color[] = {1,1,1,1};
										colorText[] = {1,1,1,1};
										colorBackground[] = {0.00,0.00,0.00,1.00};
										colorActive[] = {1,1,1,1};
										colorBackgroundActive[] = {1.00,1.00,1.00,1.00};
										colorFocused[] = {0.00,0.00,0.00,1.00};
										colorDisabled[] = {0.4,0.4,0.4,1.0};
										colorBackgroundDisabled[] = {0.00,0.00,0.00,1.00};
									};
								class OPEX_civilianInteractions_conversation_job: RscButton
									{
										idc = 3009;
										sizeEx = 0.03;
										style = ST_LEFT;
										x = 0.1 * safezoneW + safezoneX;
										y = 0.588 * safezoneH + safezoneY;
										w = 0.135 * safezoneW;
										h = 0.025 * safezoneH;
										offsetPressedX = 0.002;
										offsetPressedY = 0.002;
										color[] = {1,1,1,1};
										colorText[] = {1,1,1,1};
										colorBackground[] = {0.00,0.00,0.00,1.00};
										colorActive[] = {1,1,1,1};
										colorBackgroundActive[] = {1.00,1.00,1.00,1.00};
										colorFocused[] = {0.00,0.00,0.00,1.00};
										colorDisabled[] = {0.4,0.4,0.4,1.0};
										colorBackgroundDisabled[] = {0.00,0.00,0.00,1.00};
									};
								class OPEX_civilianInteractions_conversation_suspicious: RscButton
									{
										idc = 3010;
										sizeEx = 0.03;
										style = ST_LEFT;
										x = 0.1 * safezoneW + safezoneX;
										y = 0.617 * safezoneH + safezoneY;
										w = 0.135 * safezoneW;
										h = 0.025 * safezoneH;
										offsetPressedX = 0.002;
										offsetPressedY = 0.002;
										color[] = {1,1,1,1};
										colorText[] = {1,1,1,1};
										colorBackground[] = {0.00,0.00,0.00,1.00};
										colorActive[] = {1,1,1,1};
										colorBackgroundActive[] = {1.00,1.00,1.00,1.00};
										colorFocused[] = {0.00,0.00,0.00,1.00};
										colorDisabled[] = {0.4,0.4,0.4,1.0};
										colorBackgroundDisabled[] = {0.00,0.00,0.00,1.00};
									};
								class OPEX_civilianInteractions_conversation_goodbye: RscButton
									{
										idc = 3011;
										sizeEx = 0.03;
										style = ST_LEFT;
										x = 0.1 * safezoneW + safezoneX;
										y = 0.644 * safezoneH + safezoneY;
										w = 0.135 * safezoneW;
										h = 0.025 * safezoneH;
										offsetPressedX = 0.002;
										offsetPressedY = 0.002;
										color[] = {1,1,1,1};
										colorText[] = {1,1,1,1};
										colorBackground[] = {0.00,0.00,0.00,1.00};
										colorActive[] = {1,1,1,1};
										colorBackgroundActive[] = {1.00,1.00,1.00,1.00};
										colorFocused[] = {0.00,0.00,0.00,1.00};
										colorDisabled[] = {0.4,0.4,0.4,1.0};
										colorBackgroundDisabled[] = {0.00,0.00,0.00,1.00};
									};

					// ID CHECK
						class OPEX_civilianInteractions_IDcheck: RscText
							{
								idc = 3012;
								sizeEx = 0.03;
								style = ST_LEFT;
								x = 0.70 * safezoneW + safezoneX;
								y = 0.33 * safezoneH + safezoneY;
								w = 0.135 * safezoneW;
								h = 0.025 * safezoneH;
								colorBackground[] = {0.00, 0.25, 0.65, 0.90};
							};
								class OPEX_civilianInteractions_IDcheck_card: RscButton
									{
										idc = 3013;
										sizeEx = 0.03;
										style = ST_LEFT;
										x = 0.70 * safezoneW + safezoneX;
										y = 0.36 * safezoneH + safezoneY;
										w = 0.135 * safezoneW;
										h = 0.025 * safezoneH;
										offsetPressedX = 0.002;
										offsetPressedY = 0.002;
										color[] = {1,1,1,1};
										colorText[] = {1,1,1,1};
										colorBackground[] = {0.00,0.00,0.00,1.00};
										colorActive[] = {1,1,1,1};
										colorBackgroundActive[] = {1.00,1.00,1.00,1.00};
										colorFocused[] = {0.00,0.00,0.00,1.00};
										colorDisabled[] = {0.4,0.4,0.4,1.0};
										colorBackgroundDisabled[] = {0.00,0.00,0.00,1.00};
									};
								class OPEX_civilianInteractions_IDcheck_scan: RscButton
									{
										idc = 3014;
										sizeEx = 0.03;
										style = ST_LEFT;
										x = 0.70 * safezoneW + safezoneX;
										y = 0.387 * safezoneH + safezoneY;
										w = 0.135 * safezoneW;
										h = 0.025 * safezoneH;
										offsetPressedX = 0.002;
										offsetPressedY = 0.002;
										color[] = {1,1,1,1};
										colorText[] = {1,1,1,1};
										colorBackground[] = {0.00,0.00,0.00,1.00};
										colorActive[] = {1,1,1,1};
										colorBackgroundActive[] = {1.00,1.00,1.00,1.00};
										colorFocused[] = {0.00,0.00,0.00,1.00};
										colorDisabled[] = {0.4,0.4,0.4,1.0};
										colorBackgroundDisabled[] = {0.00,0.00,0.00,1.00};
									};


					// SUSPECT MOVEMENTS
						class OPEX_civilianInteractions_SUSPECT: RscText
							{
								idc = 3015;
								sizeEx = 0.03;
								style = ST_LEFT;
								x = 0.70 * safezoneW + safezoneX;
								y = 0.45 * safezoneH + safezoneY;
								w = 0.135 * safezoneW;
								h = 0.025 * safezoneH;
								colorBackground[] = {0.00, 0.25, 0.65, 0.90};
							};
								class OPEX_civilianInteractions_suspect_down: RscButton
									{
										idc = 3016;
										sizeEx = 0.03;
										style = ST_LEFT;
										x = 0.70 * safezoneW + safezoneX;
										y = 0.48 * safezoneH + safezoneY;
										w = 0.135 * safezoneW;
										h = 0.025 * safezoneH;
										offsetPressedX = 0.002;
										offsetPressedY = 0.002;
										color[] = {1,1,1,1};
										colorText[] = {1,1,1,1};
										colorBackground[] = {0.00,0.00,0.00,1.00};
										colorActive[] = {1,1,1,1};
										colorBackgroundActive[] = {1.00,1.00,1.00,1.00};
										colorFocused[] = {0.00,0.00,0.00,1.00};
										colorDisabled[] = {0.4,0.4,0.4,1.0};
										colorBackgroundDisabled[] = {0.00,0.00,0.00,1.00};
									};
								class OPEX_civilianInteractions_suspect_search: RscButton
									{
										idc = 3017;
										sizeEx = 0.03;
										style = ST_LEFT;
										x = 0.70 * safezoneW + safezoneX;
										y = 0.507 * safezoneH + safezoneY;
										w = 0.135 * safezoneW;
										h = 0.025 * safezoneH;
										offsetPressedX = 0.002;
										offsetPressedY = 0.002;
										color[] = {1,1,1,1};
										colorText[] = {1,1,1,1};
										colorBackground[] = {0.00,0.00,0.00,1.00};
										colorActive[] = {1,1,1,1};
										colorBackgroundActive[] = {1.00,1.00,1.00,1.00};
										colorFocused[] = {0.00,0.00,0.00,1.00};
										colorDisabled[] = {0.4,0.4,0.4,1.0};
										colorBackgroundDisabled[] = {0.00,0.00,0.00,1.00};
									};
								class OPEX_civilianInteractions_suspect_handcuff: RscButton
									{
										idc = 3018;
										sizeEx = 0.03;
										style = ST_LEFT;
										x = 0.70 * safezoneW + safezoneX;
										y = 0.534 * safezoneH + safezoneY;
										w = 0.135 * safezoneW;
										h = 0.025 * safezoneH;
										offsetPressedX = 0.002;
										offsetPressedY = 0.002;
										color[] = {1,1,1,1};
										colorText[] = {1,1,1,1};
										colorBackground[] = {0.00,0.00,0.00,1.00};
										colorActive[] = {1,1,1,1};
										colorBackgroundActive[] = {1.00,1.00,1.00,1.00};
										colorFocused[] = {0.00,0.00,0.00,1.00};
										colorDisabled[] = {0.4,0.4,0.4,1.0};
										colorBackgroundDisabled[] = {0.00,0.00,0.00,1.00};
										//onMouseEnter = "(_this select 0) ctrlSetTextColor [0.8, 0, 0, 1]";
									};
								class OPEX_civilianInteractions_suspect_take: RscButton
									{
										idc = 3019;
										sizeEx = 0.03;
										style = ST_LEFT;
										x = 0.70 * safezoneW + safezoneX;
										y = 0.561 * safezoneH + safezoneY;
										w = 0.135 * safezoneW;
										h = 0.025 * safezoneH;
										offsetPressedX = 0.002;
										offsetPressedY = 0.002;
										color[] = {1,1,1,1};
										colorText[] = {1,1,1,1};
										colorBackground[] = {0.00,0.00,0.00,1.00};
										colorActive[] = {1,1,1,1};
										colorBackgroundActive[] = {1.00,1.00,1.00,1.00};
										colorFocused[] = {0.00,0.00,0.00,1.00};
										colorDisabled[] = {0.4,0.4,0.4,1.0};
										colorBackgroundDisabled[] = {0.00,0.00,0.00,1.00};
									};
								class OPEX_civilianInteractions_suspect_load: RscButton
									{
										idc = 3020;
										sizeEx = 0.03;
										style = ST_LEFT;
										x = 0.70 * safezoneW + safezoneX;
										y = 0.588 * safezoneH + safezoneY;
										w = 0.135 * safezoneW;
										h = 0.025 * safezoneH;
										offsetPressedX = 0.002;
										offsetPressedY = 0.002;
										color[] = {1,1,1,1};
										colorText[] = {1,1,1,1};
										colorBackground[] = {0.00,0.00,0.00,1.00};
										colorActive[] = {1,1,1,1};
										colorBackgroundActive[] = {1.00,1.00,1.00,1.00};
										colorFocused[] = {0.00,0.00,0.00,1.00};
										colorDisabled[] = {0.4,0.4,0.4,1.0};
										colorBackgroundDisabled[] = {0.00,0.00,0.00,1.00};
									};
								class OPEX_civilianInteractions_suspect_drop: RscButton
									{
										idc = 3021;
										sizeEx = 0.03;
										style = ST_LEFT;
										x = 0.70 * safezoneW + safezoneX;
										y = 0.615 * safezoneH + safezoneY;
										w = 0.135 * safezoneW;
										h = 0.025 * safezoneH;
										offsetPressedX = 0.002;
										offsetPressedY = 0.002;
										color[] = {1,1,1,1};
										colorText[] = {1,1,1,1};
										colorBackground[] = {0.00,0.00,0.00,1.00};
										colorActive[] = {1,1,1,1};
										colorBackgroundActive[] = {1.00,1.00,1.00,1.00};
										colorFocused[] = {0.00,0.00,0.00,1.00};
										colorDisabled[] = {0.4,0.4,0.4,1.0};
										colorBackgroundDisabled[] = {0.00,0.00,0.00,1.00};
									};
								class OPEX_civilianInteractions_suspect_release: RscButton
									{
										idc = 3022;
										sizeEx = 0.03;
										style = ST_LEFT;
										x = 0.70 * safezoneW + safezoneX;
										y = 0.642 * safezoneH + safezoneY;
										w = 0.135 * safezoneW;
										h = 0.025 * safezoneH;
										offsetPressedX = 0.002;
										offsetPressedY = 0.002;
										color[] = {1,1,1,1};
										colorText[] = {1,1,1,1};
										colorBackground[] = {0.00,0.00,0.00,1.00};
										colorActive[] = {1,1,1,1};
										colorBackgroundActive[] = {1.00,1.00,1.00,1.00};
										colorFocused[] = {0.00,0.00,0.00,1.00};
										colorDisabled[] = {0.4,0.4,0.4,1.0};
										colorBackgroundDisabled[] = {0.00,0.00,0.00,1.00};
									};
			};

	};