waitUntil {!isNil "OPEX_params_ready"};

private _entity = param [0, objNull, [objNull]];
private _text = param [1, "", ["..."]];

// TEXT COLOR
UI_colorRGB_places = [profileNamespace getVariable ["GUI_BCG_RGB_R", 0.00], profileNamespace getVariable ["GUI_BCG_RGB_G", 0.00], profileNamespace getVariable ["GUI_BCG_RGB_B", 0.80]];
//UI_colorRGB_objects = [(profileNamespace getVariable ["GUI_BCG_RGB_R", 0.00]) * 2, (profileNamespace getVariable ["GUI_BCG_RGB_G", 0.00]) * 2, (profileNamespace getVariable ["GUI_BCG_RGB_B", 0.80]) * 2];
//UI_colorRGB_places = [0.0, 0.0, 0.8];
UI_colorRGB_objects = [1.0, 1.0, 1.0];

/*
if (count _this > 0) then
	{

		if (isNil "OPEX_guides_3D_objects") then {OPEX_guides_3D_objects = []};
		if (!(["SignAd_SponsorS", typeOf (_this select 0)] call BIS_fnc_inString)) then {OPEX_guides_3D_objects pushBack [_this select 0, _this select 1]};

		if (isNil "OPEX_guides_3D_places") then {OPEX_guides_3D_places = []};
		if ((["SignAd_SponsorS", typeOf (_this select 0)] call BIS_fnc_inString) || (typeOf (_this select 0) == "EmptyDetector")) then {OPEX_guides_3D_places pushBack [_this select 0, _this select 1]};
	};
*/
if (isNil "OPEX_guides_3D_objects") then {OPEX_guides_3D_objects = []};
if (isNil "OPEX_guides_3D_places") then {OPEX_guides_3D_places = []};
if ("marker" in _text) then {OPEX_guides_3D_places pushBack [_entity, _text]} else {OPEX_guides_3D_objects pushBack [_entity, _text]};


Gemini_fnc_guidedTour3D_show =
	{
		EH_tour3D_objects = addMissionEventHandler
			[
				"Draw3D",
				{
					{
						alphaText = linearConversion [4, 8, (player distance (_x select 0)), profileNamespace getVariable ["GUI_BCG_RGB_A", 0.90], 0, true];
						drawIcon3D ["", [UI_colorRGB_objects select 0, UI_colorRGB_objects select 1, UI_colorRGB_objects select 2, alphaText], (_x select 0) modelToWorld [0,0,0.5], 0, 0, 0, toUpper localize (_x select 1), 2, 0.05, "PuristaMedium"];
					} forEach OPEX_guides_3D_objects;
				}
			];
		EH_tour3D_places = addMissionEventHandler
			[
				"Draw3D",
				{
					{
						alphaText = linearConversion [25, 50, (player distance (_x select 0)), profileNamespace getVariable ["GUI_BCG_RGB_A", 0.90], 0, true];
						drawIcon3D ["", [UI_colorRGB_places select 0, UI_colorRGB_places select 1, UI_colorRGB_places select 2, alphaText], (_x select 0) modelToWorld [0,0,5], 0, 0, 0, toUpper localize (_x select 1), 0, 0.075, "PuristaMedium"];
					} forEach OPEX_guides_3D_places;
				}
			];
	};

Gemini_fnc_guidedTour3D_hide =
	{
		if ((count (OPEX_guides_3D_objects) > 0) && (!isNil "EH_tour3D_objects")) then {removeMissionEventHandler ["Draw3D", EH_tour3D_objects]};
		if ((count (OPEX_guides_3D_places) > 0) && (!isNil "EH_tour3D_places")) then {removeMissionEventHandler ["Draw3D", EH_tour3D_places]};
	};

Gemini_fnc_guidedTour3D_setup =
	{
		waitUntil {!isNil "OPEX_introFinished"};
		waitUntil {OPEX_introFinished};
		if (profileNamespace getVariable ["OPEX_" + worldName + "_guidedTour3D", true]) then {call Gemini_fnc_guidedTour3D_show} else {call Gemini_fnc_guidedTour3D_hide};
	};

Gemini_fnc_guidedTour3D_switch =
	{
		if (profileNamespace getVariable ["OPEX_" + worldName + "_guidedTour3D", true]) then {profileNamespace setVariable ["OPEX_" + worldName + "_guidedTour3D", false]; hint localize "STR_hint_guidedTourDisabled"} else {profileNamespace setVariable ["OPEX_" + worldName + "_guidedTour3D", true]; hint localize "STR_hint_guidedTourEnabled"};
		call Gemini_fnc_guidedTour3D_setup;
	};