﻿// =========================================================================================================
// PRIVATIZING LOCAL VARIABLES 
// =========================================================================================================

	private ["_unit", "_vehicle"];
	
// =========================================================================================================
// GETTING ARGUMENTS 
// =========================================================================================================

	_unit = _this select 0;
	_vehicle = _this select 1;
	
// =========================================================================================================
// REMOVING ACTIONS 
// =========================================================================================================

	_unit assignAsCargo _vehicle;
	[_unit] orderGetIn true;

// =========================================================================================================
// EXITING SCRIPT
// =========================================================================================================

	if (true) exitWith {};