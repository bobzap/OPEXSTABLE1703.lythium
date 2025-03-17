// EXECUTING ON SERVER ONLY
//if (!isServer) exitWith {};

// WAITING MISSION IS READY
waitUntil {!isNil "OPEX_params_ready"};
waitUntil {OPEX_params_ready};
waitUntil {!isNil "OPEX_param_friendlyFaction"};
waitUntil {!isNil "OPEX_friendly_commonUniforms"};

// GETTING ALL AI UNITS ON THE MAP AT MISSION STARTUP
private _AIs = allUnits - (call BIS_fnc_listPlayers);

// CONVERTING
{
    [_x] call Gemini_fnc_setSpeaker;
    if ((side _x) == OPEX_civilian_side1) then
        {
            _x call Gemini_fnc_randomizeLoadout;
            private _blackFaces =
                ["AfricanHead_01", "AfricanHead_02", "AfricanHead_03","AfricanHead_01", "AfricanHead_02", "AfricanHead_03","AfricanHead_01", "AfricanHead_02", "AfricanHead_03","AfricanHead_01", "AfricanHead_02", "AfricanHead_03","AfricanHead_01", "AfricanHead_02", "AfricanHead_03"
                ];
            if (395180 in (getDLCs 1)) then {_blackFaces append ["TanoanHead_A3_02","TanoanHead_A3_03","TanoanHead_A3_04","TanoanHead_A3_05","TanoanHead_A3_07","TanoanHead_A3_01","TanoanHead_A3_06","TanoanHead_A3_08"]};
            private _arabicFaces =
                [
                    "PersianHead_A3_01","PersianHead_A3_02","PersianHead_A3_03",
                    "PersianHead_A3_01","PersianHead_A3_02","PersianHead_A3_03",
                    "PersianHead_A3_01","PersianHead_A3_02","PersianHead_A3_03",
                    "WhiteHead_08","WhiteHead_16", "GreekHead_A3_01","GreekHead_A3_03"
                ];
            switch OPEX_mapRegion do
                {
                    case "europe"       :   {};
                    case "middleEast"   :   {[_x, selectRandom _arabicFaces] remoteExec ["setFace", 0, _x]};
                    case "africa"       :   {[_x, selectRandom _blackFaces] remoteExec ["setFace", 0, _x]};
                    case "pacific"      :   {[_x, selectRandom _blackFaces] remoteExec ["setFace", 0, _x]};
                    default                 {};
                };
        };
    if ((side _x) == OPEX_friendly_side1) then
        {
            switch (typeOf _x) do
              {
                // REMOVING ALL GEAR
                removeAllWeapons _x;
                removeAllItems _x;
                removeAllAssignedItems _x;
                removeUniform _x;
                removeVest _x;
                removeBackpack _x;
                removeHeadgear _x;
                removeGoggles _x;
                removeAllContainers _x;

                // SETTING NEW GEAR, BASED ON UNIT'S CLASS
                //[_x, {_this execVM "loadouts\ambient\sentry_rifle.sqf"}] remoteExec ["spawn", _x];
                case "B_Soldier_F" :             {_x execVM "loadouts\ambient\sentry_rifle.sqf"};
                case "B_soldier_AR_F" :          {_x execVM "loadouts\ambient\sentry_mg.sqf"};
                case "B_soldier_M_F" :           {_x execVM "loadouts\ambient\sentry_marksman.sqf"};
                case "B_medic_F" :               {_x execVM "loadouts\ambient\medic.sqf"};
                case "B_Survivor_F" :            {_x execVM "loadouts\ambient\injured.sqf"};
                case "B_Soldier_lite_F" :        {_x execVM "loadouts\ambient\light.sqf"};
                case "B_Helipilot_F" :           {_x execVM "loadouts\ambient\pilot.sqf"};
                case "B_Pilot_F" :               {_x execVM "loadouts\ambient\pilot.sqf"};
                case "B_Competitor_F" :          {_x execVM "loadouts\ambient\radio.sqf"};
                case "B_RangeMaster_F" :         {_x execVM "loadouts\ambient\technician.sqf"};
                case "B_soldier_repair_F" :      {_x execVM "loadouts\ambient\repairer.sqf"};
                case "B_Story_SF_Captain_F" :    {_x execVM "loadouts\ambient\instructor.sqf"};
                case "B_officer_F" :             {_x execVM "loadouts\ambient\officer.sqf"};
                case "B_Soldier_unarmed_F" :     {_x execVM "loadouts\ambient\relax.sqf"};
                case "B_recon_F" :               {_x execVM "loadouts\full\scout.sqf"};
                case "B_Soldier_TL_F" :          {_x execVM "loadouts\full\teamLeader.sqf"};
                default                          {_x execVM "loadouts\ambient\relax.sqf"};
              };
            //_x spawn {sleep 5; [_this, false] remoteExec ["enableSimulationGlobal", 2]};
            _x enableDynamicSimulation true;
        };
} forEach _AIs;