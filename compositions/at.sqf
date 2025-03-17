private ["_side", "_at"];

_side = _this select 0;
if (_side == OPEX_enemy_side1) then {_at = OPEX_enemy_ATstatics call BIS_fnc_selectRandom};
if (_side == OPEX_friendly_side1) then {_at = OPEX_friendly_ATstatics call BIS_fnc_selectRandom};

[
	["Paleta1",[0.289063,-0.509277,0],0,1,0,[0,0],"","",true,false],
	["Paleta1",[-1.22607,-0.516113,0],0,1,0,[0,0],"","",true,false],
	["Paleta1",[-0.416504,0.928223,0],0,1,0,[0,0],"","",true,false],
	["AmmoCrates_NoInteractive_Small",[1.73193,1.28271,0],279,1,0,[0,0],"","",true,false],
	["Land_BagFence_Long_F",[0.0786133,2.42822,-0.000999928],0,1,0,[0,0],"","",true,false],
	["Land_Sunshade_03_F",[-2.2832,1.4917,0],0,1,0,[0,0],"","",true,false],
	["Land_CampingChair_V1_F",[-2.25293,2.05127,0],202,1,0,[0,0],"","",true,false],
	[_at,[0,0,-0.0272408],0,1,0,[0,0],"","",true,false]
]