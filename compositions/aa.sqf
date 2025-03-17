private ["_side", "_aa"];

_side = _this select 0;
if (_side == OPEX_enemy_side1) then {_aa = OPEX_enemy_AAstatics call BIS_fnc_selectRandom};
if (_side == OPEX_friendly_side1) then {_aa = OPEX_friendly_AAstatics call BIS_fnc_selectRandom};

[
	["Land_BagFence_Long_F",[-0.326172,1.45117,-0.000999928],0,1,0,[0,0],"","",true,false],
	["AmmoCrates_NoInteractive_Small",[-1.81445,0.473633,0],43,1,0,[0,0],"","",true,false],
	[_aa,[0,0,-0.0749998],0,1,0,[0,0],"","",true,false]
]