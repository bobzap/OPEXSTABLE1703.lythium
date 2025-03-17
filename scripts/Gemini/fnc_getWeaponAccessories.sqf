// _compatibleAcessories = [weapon, number] call Gemini_fnc_getWeaponAccessories;
// 0 - optic, 1 - pointer, 2 - silencer, 3 - bipod

private _weapon = _this select 0;
private _type = _this select 1;
private _list = [];

switch _type do
	{

		// OPTICS
		case 0 :
			{
				{
					_accessory = configfile >> "CfgWeapons" >> _weapon >> "WeaponSlotsInfo" >> _x >> "compatibleItems";
					if (isClass _accessory) then
						{
							_list = configProperties [_accessory, "isNumber _x"] select {getNumber _x > 0} apply {configName _x}} else {if (isArray _accessory) then {_list = getArray _accessory};
						};
				} forEach ["CowsSlot","CUP_PicatinnyTopMountSCAR","CUP_PicatinnyTopMountM4","CUP_PicatinnyTopMountM16","CUP_PicatinnyTopMountMk18","CUP_DovetailMount_AK","CUP_PicatinnyTopMountM240","CUP_PicatinnyTopMountM249","CUP_PicatinnyTopMountM107","CUP_PicatinnyTopMountM24","CUP_PicatinnyTopMountAK","CUP_PicatinnyTopMountL85","CUP_PicatinnyTopMountL129","MP5TopMount"];
			};

		// POINTERS
		case 1 :
			{
				{
					_accessory = configfile >> "CfgWeapons" >> _weapon >> "WeaponSlotsInfo" >> _x >> "compatibleItems";
					if (isClass _accessory) then
						{
							_list = configProperties [_accessory, "isNumber _x"] select {getNumber _x > 0} apply {configName _x}} else {if (isArray _accessory) then {_list = getArray _accessory};
						};
				} forEach ["PointerSlot","CUP_PicatinnySideMountSCAR","CUP_PicatinnySideMountM4","CUP_PicatinnySideMountM16","CUP_PicatinnySideMountMk18","CUP_PicatinnySideMountAK","CUP_PicatinnySideMountL85","CUP_PicatinnySideMountL129"];
			};

		// SILENCERS
		case 2 :
			{
				{
					_accessory = configfile >> "CfgWeapons" >> _weapon >> "WeaponSlotsInfo" >> _x >> "compatibleItems";
					if (isClass _accessory) then
						{
							_list = configProperties [_accessory, "isNumber _x"] select {getNumber _x > 0} apply {configName _x}} else {if (isArray _accessory) then {_list = getArray _accessory};
						};
				} forEach ["MuzzleSlot","CUP_EastMuzzleSlotAK"];
			};

		// BIPODS
		case 3 :
			{
				{
					_accessory = configfile >> "CfgWeapons" >> _weapon >> "WeaponSlotsInfo" >> _x >> "compatibleItems";
					if (isClass _accessory) then
						{
							_list = configProperties [_accessory, "isNumber _x"] select {getNumber _x > 0} apply {configName _x}} else {if (isArray _accessory) then {_list = getArray _accessory};
						};
				} forEach ["UnderBarrelSlot","CUP_PicatinnyUnderMountSCAR","CUP_PicatinnyUnderMountM16","CUP_PicatinnyUnderMountM24","CUP_PicatinnyUnderMountAK","CUP_PicatinnyUnderMountL129"];
			};

	};

_list