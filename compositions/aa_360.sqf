private ["_side", "_aa"];

_side = _this select 0;
if (_side == OPEX_enemy_side1) then {_aa = OPEX_enemy_AAstatics call BIS_fnc_selectRandom};
if (_side == OPEX_friendly_side1) then {_aa = OPEX_friendly_AAstatics call BIS_fnc_selectRandom};

[
	[_aa,[0,0,-0.0765867],0,1,0,[0,0],"","",true,false],
	["AmmoCrates_NoInteractive_Small",[2.18311,-0.36084,0],261,1,0,[0,0],"","",true,false],
	["Land_BagFence_Round_F",[0.078125,2.66309,-0.00130129],179,1,0,[0,-0],"","",true,false],
	["Land_BagFence_Round_F",[2.72705,-0.637695,0.570948],270,1,0,[0,0],"","",true,false],
	["Land_BagFence_Round_F",[-3.16064,-0.443359,-0.00130129],90,1,0,[0,-0],"","",true,false],
	["Land_CampingChair_V1_F",[-0.210938,-2.88428,0],202,1,0,[0,0],"","",true,false],
	["Land_BagFence_Round_F",[0.0883789,-3.72314,-0.00130129],0,1,0,[0,0],"","",true,false]
]