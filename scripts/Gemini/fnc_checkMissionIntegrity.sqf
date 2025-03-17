//if (OPEX_debug) exitWith {};

/*
	This script is outdated, it needs to be reworked from scratch
*/

// WAITING MISSION IS RUNNING
sleep 1;

// INITIALIZING CHECKING LIST
private _thingsErrors = [];
private _missingThings =
	[
	];

// LISTING REQUIRED OBJECTS
private _objectsErrors = [];
private _objectsToCheck =
	[
	];

// LISTING REQUIRED MARKERS
private _markersErrors = [];
private _markersToCheck =
	[
	];

// LISTING REQUIRED LOCATIONS
private _locationsErrors = [];
private _locationsToCheck =
	[
		OPEX_locations_safe
	];

// CHECKING EVERYTHING
{if (count _x == 0) then {_locationsErrors append [str _x]}} forEach _locationsToCheck;

// DISPLAYING ERRORS
private _errors = [_thingsErrors, _objectsErrors, _markersErrors, _locationsErrors]; systemChat str _errors;
if ((count (_errors select 0) > 0) || (count (_errors select 1) > 0) || (count (_errors select 2) > 0) || (count (_errors select 3) > 0)) then
	{
		disableUserInput false;
		hintC format [localize "STR_hint_missionIntegrity", _errors];
	};

if (true) exitWith {}; // LINES BELOW ARE OUTDATED

// OTHER VARIABLES
if (isNil "OPEX_locations_safe") then {_missingThings append ["OPEX_locations_safe"]} else {};

// CHECKING THINGS
{if (isNil _x) then {_missingThings append [_x]}} forEach _objectsToCheck; // OBJECTS
{if (getMarkerColor _x == "") then {_missingThings append [_x]}} forEach _markersToCheck; // MARKERS

// DISPLAYING A WARNING MESSAGE IN CASE SOME THINGS ARE MISSING
if (count _missingThings > 0) exitWith {disableUserInput false; hintC format [localize "STR_hint_missionIntegrity", _missingThings]};



// MARKERS
_checkedItem = "OPEX_marker_camp"; if (getMarkerColor _checkedItem == "") exitWith {disableUserInput false; hintC format ["ERROR DETECTED !!!\n\nMarker %1 is missing in the editor, so this mission can't work properly.\n\nINITIALIZATION HAS BEEN CANCELED", toUpper _checkedItem]};

// TRIGGERS AND SPECIAL AREAS

// MAIN OBJECTS
_checkedItem = "Server"; if (isNil _checkedItem) exitWith {disableUserInput false; hintC format ["ERROR DETECTED !!!\n\nObject %1 is missing in the editor, so this mission can't work properly.\n\nINITIALIZATION HAS BEEN CANCELED", toUpper _checkedItem]};
_checkedItem = "OPEX_deliveryZone"; if (isNil _checkedItem) exitWith {disableUserInput false; hintC format ["ERROR DETECTED !!!\n\nObject %1 is missing in the editor, so this mission can't work properly.\n\nINITIALIZATION HAS BEEN CANCELED", toUpper _checkedItem]};

// SUPPLY BOXES
//_checkedItem = "armoury_ammo"; if (isNil _checkedItem) exitWith {hintC format ["ERROR DETECTED !!!\n\nObject %1 is missing in the editor, so this mission can't work properly.\n\nINITIALIZATION HAS BEEN CANCELED", toUpper _checkedItem]};
//_checkedItem = "armoury_clothes"; if (isNil _checkedItem) exitWith {hintC format ["ERROR DETECTED !!!\n\nObject %1 is missing in the editor, so this mission can't work properly.\n\nINITIALIZATION HAS BEEN CANCELED", toUpper _checkedItem]};
//_checkedItem = "armoury_explosives"; if (isNil _checkedItem) exitWith {hintC format ["ERROR DETECTED !!!\n\nObject %1 is missing in the editor, so this mission can't work properly.\n\nINITIALIZATION HAS BEEN CANCELED", toUpper _checkedItem]};
//_checkedItem = "armoury_grenades"; if (isNil _checkedItem) exitWith {hintC format ["ERROR DETECTED !!!\n\nObject %1 is missing in the editor, so this mission can't work properly.\n\nINITIALIZATION HAS BEEN CANCELED", toUpper _checkedItem]};
//_checkedItem = "armoury_launchers"; if (isNil _checkedItem) exitWith {hintC format ["ERROR DETECTED !!!\n\nObject %1 is missing in the editor, so this mission can't work properly.\n\nINITIALIZATION HAS BEEN CANCELED", toUpper _checkedItem]};
//_checkedItem = "armoury_support"; if (isNil _checkedItem) exitWith {hintC format ["ERROR DETECTED !!!\n\nObject %1 is missing in the editor, so this mission can't work properly.\n\nINITIALIZATION HAS BEEN CANCELED", toUpper _checkedItem]};
//_checkedItem = "armoury_weapons"; if (isNil _checkedItem) exitWith {hintC format ["ERROR DETECTED !!!\n\nObject %1 is missing in the editor, so this mission can't work properly.\n\nINITIALIZATION HAS BEEN CANCELED", toUpper _checkedItem]};

// LIVE FEED FEATURE SCREEN
_checkedItem = "mainMonitor"; if (isNil _checkedItem) exitWith {disableUserInput false; hintC format ["ERROR DETECTED !!!\n\nObject %1 is missing in the editor, so this mission can't work properly.\n\nINITIALIZATION HAS BEEN CANCELED", toUpper _checkedItem]};

// VALID MAP ?
_checkedItem = "OPEX_mapRadius"; if (isNil _checkedItem) exitWith {disableUserInput false; hintC format ["ERROR DETECTED !!!\n\nVariable %1 hasn't been defined (unvalid map ?), so this mission can't work properly.\n\nINITIALIZATION HAS BEEN CANCELED", toUpper _checkedItem]};

// TO DO LATER :
// MAYBE AUTO-CREATE ALL OF THESE IN CASE THEY ARE NOT FOUND ???