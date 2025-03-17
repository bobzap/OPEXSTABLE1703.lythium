private ["_side", "_mortar"];

_side = _this select 0;
if (_side == OPEX_enemy_side1) then {_mortar = OPEX_enemy_mortarStatics call BIS_fnc_selectRandom};
if (_side == OPEX_friendly_side1) then {_mortar = OPEX_friendly_mortarStatics call BIS_fnc_selectRandom};

[
	[_mortar,[0,0,-0.0749998],0,1,0,[0,0],"","",true,false],
	["AmmoCrate_NoInteractive_",[1.42627,-0.320313,0],70,1,0,[0,0],"","",true,false],
	["AmmoCrate_NoInteractive_",[-1.20166,1.3999,0],146,1,0,[0,-0],"","",true,false],
	["AmmoCrate_NoInteractive_",[1.42725,-1.29346,0],0,1,0,[0,0],"","",true,false],
	["Land_BagFence_Round_F",[-0.532227,2.45117,-0.00130129],179,1,0,[0,-0],"","",true,false],
	["Land_BagFence_Round_F",[2.40186,-0.355469,-0.880554],270,1,0,[0,0],"","",true,false],
	["Land_CampingChair_V1_F",[-0.821289,-3.09619,0],202,1,0,[0,0],"","",true,false],
	["Land_BagFence_Round_F",[-3.771,-0.655273,-0.00130129],90,1,0,[0,-0],"","",true,false],
	["Land_BagFence_Round_F",[-0.521973,-3.93506,-0.00130129],0,1,0,[0,0],"","",true,false]
]