if (!isMultiplayer) exitWith {};

if(!hasInterface&&!isServer)exitWith{};//Do not initialize on HC
if(hasInterface&&isNull player)then{waitUntil{!isNull player};systemChat"[AFAR: JIP Detected]"};//JIP Compatibility
if((isClass(configFile>>"CfgPatches">>"task_force_radio"))||{(isClass(configFile>>"CfgPatches">>"acre_main"))})exitWith{};//Don't initialize if ACRE / TFAR detected

waitUntil {player diarySubjectExists "Tribute"}; sleep 1; 
#include"CFG.sqf"

private _txt=[
(if(r_sideCH)then{"<font color='#00bdff'>SIDE</font>, "}else{""}),
format["<font color='#768ce0'>%1</font><br/><br/>",(toUpperANSI(r_mCHShort))],
(if(r_sideCH)then{"• Everyone on your Side can communiate via <font color='#00bdff'>Side channel</font><br/><br/>"}else{""}),
format["<font color='#768ce0'>%1</font><br/><br/>",r_mCHName],
(if(r_alertOn)then{"• Talking will alert nearby enemies <img size='.7' image='\A3\Ui_f\data\IGUI\Cfg\simpleTasks\types\listen_ca.paa'/><br/><br/>"}else{""}),
(if(!r_chOn)then{"<br/><br/>• Cannot use channel switching keybinds, must use handheld radio interface"}else{""})
];
private _AFARtxt=str composeText["
<br/><br/>
FR: Je ne suis pas l'auteur de ce script. Si vous ne comprenez pas l'Anglais, merci de contacter directement Phronk afin de lui demander une traduction.<br/><br/>
ES: No soy el autor de este guión. Si no entiende inglés, comuníquese directamente con Phronk para solicitar una traducción.<br/><br/>
 - Gemini
<br/><br/><br/>
<font face='PuristaMedium' size=12 color='#8E8E8E'>__________________________________</font></size><br/>
<font face='PuristaMedium' size=30 shadow='5' color='#808000'>ADDON-FREE ARMA RADIO</font></size><img image='\A3\Ui_f\data\IGUI\Cfg\simpleTasks\types\radio_ca.paa'/><b/><br/>Created by Phronk<br/>
<font face='PuristaMedium' size=12 color='#8E8E8E'>__________________________________</font></size><br/><br/>
<font face='PuristaMedium' size=20 color='#808000'>RADIO SETUP</font></size><br/><br/>
     0. Equip a radio or radio backpack<br/><br/>
     1. Use a PUSH TO TALK key to talk via radio<br/><br/>
     2. Open the in-game menu and go into 'Configure/Controls/Multiplayer'<br/><br/>
     3. Set your PUSH TO TALK key. (Mouse Button inputs not supported)<br/><br/>
     4. Unbind your VoiceOverNet keybind!<br/><br/>
     5. Raise VON volume slider in AUDIO settings<br/><br/>
     6. Cycle radio channels via the radio interface (Diary Key)<br/><br/>

<font face='PuristaMedium' size=20 color='#808000'>OPERATING RADIO</font></size><br/><br/>
• PUSH TO TALK key(s) to use radio<br/><br/>
• Radio channels are ",_txt#0,"<font color='#fffaa3'>COMMAND</font>, <font color='#b6f442'>GROUP</font>, <font color='#f4c542'>VEHICLE</font>, and ",_txt#1,
"• DIARY key to look at handheld radio interface<br/><br/>
• Radio must be equipped to send transmissions<br/><br/>
• The sun, overcast, and rain can interfere with radio transmissions<br/><br/>",_txt#2,
"• Only squad leaders can communicate via <font color='#fffaa3'>Command channel</font><br/><br/>
• Only squadmates can communicate via <font color='#b6f442'>Group channel</font><br/><br/>
• Only vehicle passengers can communicate via <font color='#f4c542'>Vehicle channel</font><br/><br/>",
"• Only RTOs, pilots, copilots, and gunners can use ",_txt#3,
"• Everyone in close proximity can communicate via <font color='#ffffff'>Direct channel</font><br/><br/>",_txt#4,
"• Cannot communicate if dead or underwater without rebreather<br/><br/>
• Cannot communicate via radio if incapacitated",_txt#5];
player createDiarySubject["Radio - AFAR","Radio - AFAR"];
player createDiaryRecord["Radio - AFAR",["Instructions",_AFARtxt]];
waitUntil{!isNil"r_chat"};
if(isServer)then{
//if(INDEPENDENT getFriend EAST>0.6)then{};
//if(INDEPENDENT getFriend WEST>0.6)then{};
//ch10Name="Allies channel";publicVariable"ch10Name";
//ch11Name="Allies channel";publicVariable"ch11Name";
//ch10=radioChannelCreate[[0.2,0.2,1,0.8],ch10Name,"(Allies) %UNIT_NAME",[]];publicVariable"ch10";//BLU
//ch11=radioChannelCreate[[1,0.2,0.2,0.8],ch11Name,"(Allies) %UNIT_NAME",[]];publicVariable"ch11";//OPF
private _txt=r_mCHShort+"%UNIT_NAME";
ch6=radioChannelCreate[[0.2,0.2,1,0.8],r_mCHName,_txt,[]];
ch7=radioChannelCreate[[0.2,1,0.2,0.8],r_mCHName,_txt,[]];
ch8=radioChannelCreate[[1,0.2,0.2,0.8],r_mCHName,"(Air) %UNIT_NAME",[]];
{publicVariable _x}forEach["ch6","ch7","ch8"];
ch9=13;
if("Spectator"in getMissionConfigValue"respawnTemplates")then{ch9=radioChannelCreate[[0.2,1,1,0.8],"Spectator channel","(Spectator) %UNIT_NAME",[]]};
publicVariable"ch9"};
sleep 1;
if(r_sideCH)then{r_CH=[1,2,3,4,(ch6+5),(ch7+5),(ch8+5)]}else{r_CH=[2,3,4,(ch6+5),(ch7+5),(ch8+5)]};publicVariable"r_CH";
if(isDedicated)exitWith{};
sleep 3;
setCurrentChannel 5;{_x enableChannel[false,false]}count[0,1,2,3,4,6,7,8,9];
waitUntil{!isObjectHidden player&&alive player};
r_RTOBP=["B_RadioBag_01_base_F","CUP_B_Kombat_Radio_Olive","CUP_B_Motherlode_Radio_MTP","CUP_B_Predator_Radio_MTP"]+r_RTOBP;

missionNamespace setVariable["r_p",player];player linkItem"ItemRadio";
{_x params[["_function",""],["_file",""]];
private _code=compileFinal(preprocessFile _file);
missionNamespace setVariable[_function,_code]}forEach
[["r_RC","scripts\AFAR\f\hasRadio.sqf"],
["r_3DLR","scripts\AFAR\f\3DLR.sqf"],
["r_noCHS","scripts\AFAR\f\noCHS.sqf"],
["r_allOn","scripts\AFAR\f\allOn.sqf"],
["r_allOff","scripts\AFAR\f\allOff.sqf"],
["r_RTO","scripts\AFAR\f\RTO.sqf"],
["r_alert","scripts\AFAR\f\alert.sqf"],
["r_snd","scripts\AFAR\f\snd.sqf"],
["r_fuzz","scripts\AFAR\f\fuzz.sqf"],
["r_fuzz2","scripts\AFAR\f\fuzz2.sqf"],
["r_up","scripts\AFAR\f\up.sqf"],
["r_dn","scripts\AFAR\f\dn.sqf"],
["r_opt","scripts\AFAR\f\opt.sqf"],
["r_out","scripts\AFAR\f\out.sqf"],
["r_out2","scripts\AFAR\f\out2.sqf"],
["r_anm","scripts\AFAR\f\anim.sqf"],
["r_z","scripts\AFAR\f\z.sqf"],
["C_In","scripts\AFAR\f\C_In.sqf"],
["D_In","scripts\AFAR\f\D_In.sqf"],
["G_In","scripts\AFAR\f\G_In.sqf"],
["M_In","scripts\AFAR\f\M_In.sqf"],
["S_In","scripts\AFAR\f\S_In.sqf"],
["V_In","scripts\AFAR\f\V_In.sqf"],
["cOut","scripts\AFAR\f\cOut.sqf"],
["dOut","scripts\AFAR\f\dOut.sqf"],
["gOut","scripts\AFAR\f\gOut.sqf"],
["mOut","scripts\AFAR\f\mOut.sqf"],
["sOut","scripts\AFAR\f\sOut.sqf"],
["vOut","scripts\AFAR\f\vOut.sqf"],
["r_ehAdd","scripts\AFAR\f\eh.sqf"],
["nextCH","scripts\AFAR\f\nextCH.sqf"],
["prevCH","scripts\AFAR\f\prevCH.sqf"],
["r_useRadio","scripts\AFAR\f\ui.sqf"]];
sleep 3;
[]spawn compileFinal(preprocessFile"scripts\AFAR\f\init.sqf")