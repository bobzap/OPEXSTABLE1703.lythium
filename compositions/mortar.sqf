private ["_side", "_mortar"];

_side = _this select 0;
if (_side == OPEX_enemy_side1) then {_mortar = OPEX_enemy_mortarStatics call BIS_fnc_selectRandom};
if (_side == OPEX_friendly_side1) then {_mortar = OPEX_friendly_mortarStatics call BIS_fnc_selectRandom};

[
	["Land_BagFence_Round_F",[0.081543,1.58154,-0.00130129],183,1,0,[0,0],"","",true,false],
	["Land_CampingChair_V1_F",[-1.40918,0.0146484,0],202,1,0,[0,0],"","",true,false],
	["AmmoCrates_NoInteractive_Medium",[1.58838,-0.0273438,0],351,1,0,[0,0],"","",true,false],
	[_mortar,[0,0,-0.0749998],0,1,0,[0,0],"","",true,false]
]