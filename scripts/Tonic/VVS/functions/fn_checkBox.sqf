/*
	File: fn_checkBox.sqf

	Description:
	Short macro for clearing vehicle cargo, will change in the future and be
	expanded into actual checkboxes, etc.
*/
disableSerialization;
private["_control"];
_control = ((findDisplay 38100) displayCtrl 38103);


if(VVS_Checkbox) then {VVS_Checkbox = false;} else {VVS_Checkbox = true;};


/*
if(VVS_Checkbox) then
{
	hint localize "STR_vvs_noCargo";
	_control ctrlSetText localize "STR_Yes";
	_control ctrlSetTextColor [0,1,0,1];
}
	else
{
	hint localize "STR_vvs_yesCargo";
	_control ctrlSetText localize "STR_No";
	_control ctrlSetTextColor [1,0,0,1];
};

*/