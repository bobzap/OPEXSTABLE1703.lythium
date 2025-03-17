fn_STMG_AssignClientIDOnServer = 
{
	_unitName = _this select 0; 
	{
		if (name _x == _unitName) then {_x setVariable ["stmg_owner_id",owner _x,true];};
	} forEach playableUnits; 
};