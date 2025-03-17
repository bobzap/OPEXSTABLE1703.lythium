// **********************************************************************
// DEFAULT SETTINGS (do NOT modifiy or delete anything in this section)
// **********************************************************************

// MAPS
call compile preProcessFileLineNumbers "settings\maps\default.sqf";
call compile preProcessFileLineNumbers "settings\maps\VR.sqf";
call compile preProcessFileLineNumbers "settings\maps\altis.sqf";
call compile preProcessFileLineNumbers "settings\maps\stratis.sqf";
call compile preProcessFileLineNumbers "settings\maps\tanoa.sqf";
call compile preProcessFileLineNumbers "settings\maps\enoch.sqf";
call compile preProcessFileLineNumbers "settings\maps\fata.sqf";
call compile preProcessFileLineNumbers "settings\maps\isladuala.sqf";
call compile preProcessFileLineNumbers "settings\maps\kunduz.sqf";
call compile preProcessFileLineNumbers "settings\maps\kujari.sqf";
call compile preProcessFileLineNumbers "settings\maps\lythium.sqf";
call compile preProcessFileLineNumbers "settings\maps\nziwasogo.sqf";
call compile preProcessFileLineNumbers "settings\maps\taunus.sqf";

// BUILDINGS
call compile preProcessFileLineNumbers "settings\buildings\vanilla.sqf";
call compile preProcessFileLineNumbers "settings\buildings\mods.sqf";

// COSTS
call compile preProcessFileLineNumbers "settings\costs\default.sqf";

// ENEMIES
call compile preProcessFileLineNumbers "settings\enemies\default.sqf";

// FRIENDS
call compile preProcessFileLineNumbers "settings\friends\default.sqf";

// PRESS
call compile preProcessFileLineNumbers "settings\press\vanilla.sqf";
call compile preProcessFileLineNumbers "settings\press\xnooz.sqf";

// **********************************************************************
// EXTRA SETTINGS (enable your custom mods below these lines)
// **********************************************************************

// MUSICS
execVM "settings\musics\vanilla.sqf";
execVM "settings\musics\cup.sqf";
execVM "settings\musics\custom.sqf";

// CIVILIANS
execVM "settings\civilians\vanilla.sqf";
execVM "settings\civilians\cup.sqf";
execVM "settings\civilians\cfp.sqf";
execVM "settings\civilians\lop.sqf";
execVM "settings\civilians\3cb.sqf";

// ENEMIES
execVM "settings\enemies\ultra_vanilla.sqf";
execVM "settings\enemies\ultra_vanilla_bk.sqf";
execVM "settings\enemies\ultra_cfp.sqf";
execVM "settings\enemies\ultra_lop.sqf";
execVM "settings\enemies\ultra_cup.sqf";
execVM "settings\enemies\ultra_3cb.sqf";
execVM "settings\enemies\ultra_rhs.sqf";
execVM "settings\enemies\boko_cfp.sqf";
execVM "settings\enemies\boko_lop.sqf";
execVM "settings\enemies\boko_cup.sqf";
execVM "settings\enemies\boko_3cb.sqf";
execVM "settings\enemies\boko_vanilla.sqf";
execVM "settings\enemies\isis_vanilla.sqf";
execVM "settings\enemies\isis_cfp.sqf";
execVM "settings\enemies\isis_lop.sqf";
execVM "settings\enemies\isis_cup.sqf";
execVM "settings\enemies\isis_3cb.sqf";
execVM "settings\enemies\talib_cfp.sqf";
execVM "settings\enemies\talib_lop.sqf";
execVM "settings\enemies\talib_cup.sqf";
execVM "settings\enemies\talib_3cb.sqf";

// FRIENDS
execVM "settings\friends\usa_vanilla.sqf";
execVM "settings\friends\usa_rhs.sqf";
execVM "settings\friends\usa_cup.sqf";
execVM "settings\friends\russia_rhs.sqf";
execVM "settings\friends\russia_cup.sqf";
execVM "settings\friends\france_ofrpr3famf.sqf";
execVM "settings\friends\france_ofrpfafamf.sqf";
execVM "settings\friends\france_ofrp.sqf";
execVM "settings\friends\france_r3f.sqf";
execVM "settings\friends\france_jf.sqf";
execVM "settings\friends\france_amf.sqf";
execVM "settings\friends\france_cup.sqf";
execVM "settings\friends\spain_ffaa.sqf";
execVM "settings\friends\uk_3cb.sqf";
execVM "settings\friends\uk_cup.sqf";
execVM "settings\friends\germany_cup.sqf";
execVM "settings\friends\germany_bw.sqf";
execVM "settings\friends\germany_cfprnt.sqf";
execVM "settings\friends\czechia_cup.sqf";
execVM "settings\friends\canada_tfc.sqf";
execVM "settings\friends\italy_pedagne.sqf";

// GAMEPLAY
[] spawn
	{
		waitUntil {!isNil "OPEX_params_ready"};
		waitUntil {OPEX_params_ready};
		execVM "settings\gameplay\gemini.sqf";
		execVM "settings\gameplay\ace.sqf";
		execVM "settings\gameplay\acre.sqf";
		execVM "settings\gameplay\tfar.sqf";
	};