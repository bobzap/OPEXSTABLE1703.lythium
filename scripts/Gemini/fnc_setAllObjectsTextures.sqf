waitUntil {!isNil "OPEX_params_ready"};
waitUntil {OPEX_params_ready};

{
	 _x setVariable ["R3F_LOG_disabled", true];

	switch (typeOf _x) do
		{
			// FLAGS
			case "Flag_UNO_F"							:		{_x setFlagTexture OPEX_friendly_flag_faction};
			case "Flag_US_F"							:		{_x setFlagTexture OPEX_friendly_flag_country};
			case "Flag_BI_F"							:		{_x setFlagTexture OPEX_friendly_flag_army};

			// BANNERS
			case "Banner_01_F"							:		{_x setObjectTexture [0, OPEX_friendly_flag_army]};
			case "Banner_01_NATO_F"						:		{_x setObjectTexture [0, OPEX_friendly_flag_country]};

			// BRIEFING BOARD
			case "Land_MapBoard_F"						:		{_x setObjectTexture [0, OPEX_briefingBoard]};

			// WHITE BOARD (MAP)
			case "Land_MapBoard_01_Wall_Altis_F"		:
																{
																	switch (worldName) do
																		{
																			case "Altis"			:	{_x setObjectTexture [0, "a3\structures_f\civ\infoboards\data\mapboard_altis_co.paa"]};
																			case "Stratis"			:	{_x setObjectTexture [0, "a3\structures_f\civ\infoboards\data\mapboard_stratis_co.paa"]};
																			case "Tanoa"			:	{_x setObjectTexture [0, "a3\props_f_argo\civilian\infoboards\data\mapboard_tanoa_co.paa"]};
																			case "Malden"			:	{_x setObjectTexture [0, "a3\props_f_argo\civilian\infoboards\data\mapboard_malden_co.paa"]};
																			case "Enoch"			:	{_x setObjectTexture [0, "a3\props_f_enoch\civilian\infoboards\data\mapboard_enoch_co.paa"]};
																			case "fata"				:	{_x setObjectTexture [0, "pictures\mapboard_fata.paa"]};
																			case "isladuala3"		:	{_x setObjectTexture [0, "pictures\mapboard_isladuala.paa"]};
																			case "tem_kujari"		:	{_x setObjectTexture [0, "pictures\mapboard_kujari.paa"]};
																			case "kunduz"			:	{_x setObjectTexture [0, "pictures\mapboard_kunduz.paa"]};
																			case "lythium"			:	{_x setObjectTexture [0, "pictures\mapboard_lythium.paa"]};
																			case "xcam_taunus"		:	{_x setObjectTexture [0, "pictures\mapboard_taunus.paa"]};
																			default 					{_x setObjectTexture [0, "a3\structures_f\civ\infoboards\data\mapboard_altis_co.paa"]};
																		};
																};

			// WHITE BOARD (SPECIALIZATION)
			case "Land_MapBoard_01_Wall_F"				:		{_x setObjectTexture [0, OPEX_monitorBig_specialization]};

			// LAPTOPS
			case "Land_Laptop_device_F"					:		{if ((((getObjectTextures _x) select 0) find "laptop1610_specialization") != -1) then {_x setObjectTexture [0, OPEX_laptop_specialization]}};

			// FOB SIGNS
			case "Land_Billboard_02_blank_F"			:		{_x setObjectTexture [0, OPEX_sign_camp]};
			case "SignAd_SponsorS_ARMEX_F"				:
																{
																	if ((((getObjectTextures _x) select 0) find "sign_ammo") != -1) then {_x setObjectTexture [0, OPEX_sign_ammo]};
																	if ((((getObjectTextures _x) select 0) find "sign_armory") != -1) then {_x setObjectTexture [0, OPEX_sign_armory]};
																	if ((((getObjectTextures _x) select 0) find "sign_canteen") != -1) then {_x setObjectTexture [0, OPEX_sign_canteen]};
																	if ((((getObjectTextures _x) select 0) find "sign_delivery") != -1) then {_x setObjectTexture [0, OPEX_sign_delivery]};
																	if ((((getObjectTextures _x) select 0) find "sign_dormitory") != -1) then {_x setObjectTexture [0, OPEX_sign_dormitory]};
																	if ((((getObjectTextures _x) select 0) find "sign_fitness") != -1) then {_x setObjectTexture [0, OPEX_sign_fitness]};
																	if ((((getObjectTextures _x) select 0) find "sign_fuel") != -1) then {_x setObjectTexture [0, OPEX_sign_fuel]};
																	if ((((getObjectTextures _x) select 0) find "sign_jail") != -1) then {_x setObjectTexture [0, OPEX_sign_jail]};
																	if ((((getObjectTextures _x) select 0) find "sign_medical") != -1) then {_x setObjectTexture [0, OPEX_sign_medical]};
																	if ((((getObjectTextures _x) select 0) find "sign_practice") != -1) then {_x setObjectTexture [0, OPEX_sign_practice]};
																	if ((((getObjectTextures _x) select 0) find "sign_shooting") != -1) then {_x setObjectTexture [0, OPEX_sign_shooting]};
																	if ((((getObjectTextures _x) select 0) find "sign_showers") != -1) then {_x setObjectTexture [0, OPEX_sign_showers]};
																	if ((((getObjectTextures _x) select 0) find "sign_toc") != -1) then {_x setObjectTexture [0, OPEX_sign_toc]};
																	if ((((getObjectTextures _x) select 0) find "sign_training") != -1) then {_x setObjectTexture [0, OPEX_sign_training]};
																	if ((((getObjectTextures _x) select 0) find "sign_workshop") != -1) then {_x setObjectTexture [0, OPEX_sign_workshop]};
																	if ((((getObjectTextures _x) select 0) find "sign_recreation") != -1) then {_x setObjectTexture [0, OPEX_sign_recreation]};
																};
			// TV
			case "Land_FlatTV_01_F"						:		{_x setObjectTexture [0, OPEX_tv]};
		};
} forEach (allMissionObjects "all");

// DELIVERY
waitUntil {!isNil "OPEX_deliveryZone"};
private _groundTexture = "UserTexture10m_F" createVehicleLocal (position OPEX_deliveryZone);
_groundTexture setObjectTexture [0, OPEX_keepclear];
_groundTexture setPos [getPos _groundTexture select 0, getPos _groundTexture select 1, 0.035];
_groundTexture setDir (getDir OPEX_deliveryZone);
[_groundTexture, -90, 0] call BIS_fnc_setPitchBank;
hideObject OPEX_deliveryZone;