private ["_side", "_mg"];

_side = _this select 0;
if (_side == OPEX_enemy_side1) then {_mg = OPEX_enemy_MGstatics call BIS_fnc_selectRandom};
if (_side == OPEX_friendly_side1) then {_mg = OPEX_friendly_MGstatics call BIS_fnc_selectRandom};

[
	[_mg,[0,0,-0.0749998],0,1,0,[0,0],"","",true,false],
	["Land_CampingChair_V1_F",[-0.527344,-1.59912,0],202,1,0,[0,0],"","",true,false],
	["AmmoCrate_NoInteractive_",[1.72119,0.203613,0],0,1,0,[0,0],"","",true,false],
	["AmmoCrate_NoInteractive_",[1.72021,1.17676,0],70,1,0,[0,0],"","",true,false],
	["Land_Sunshade_03_F",[0.422852,-1.73193,0],0,1,0,[0,0],"","",true,false],
	["Land_BagFence_Round_F",[-0.228027,-2.43799,-0.00130129],0,1,0,[0,0],"","",true,false],
	["Land_BagFence_Round_F",[2.6958,1.1416,-0.880554],270,1,0,[0,0],"","",true,false],
	["Land_BagFence_Round_F",[-3.47705,0.841797,-0.00130129],90,1,0,[0,-0],"","",true,false],
	["Land_BagFence_Round_F",[-0.238281,3.94824,-0.00130129],179,1,0,[0,-0],"","",true,false]
]