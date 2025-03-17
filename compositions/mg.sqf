private ["_side", "_mg"];

_side = _this select 0;
if (_side == OPEX_enemy_side1) then {_mg = OPEX_enemy_MGstatics call BIS_fnc_selectRandom};
if (_side == OPEX_friendly_side1) then {_mg = OPEX_friendly_MGstatics call BIS_fnc_selectRandom};

[
	["Land_BagFence_Round_F",[-0.261719,1.67432,-0.00130129],183,1,0,[0,0],"","",true,false],
	["AmmoCrate_NoInteractive_",[1.19775,0.205078,0],279,1,0,[0,0],"","",true,false],
	["AmmoCrate_NoInteractive_",[-2.15088,-0.297363,0],351,1,0,[0,0],"","",true,false],
	["Land_CampingChair_V1_F",[-2.11768,0.727539,0],202,1,0,[0,0],"","",true,false],
	[_mg,[0,0,-0.0749998],0,1,0,[0,0],"","",true,false]
]