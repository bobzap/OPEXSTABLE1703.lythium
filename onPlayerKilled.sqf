["friendKilled"] call Gemini_fnc_updateStats;
["playerKilled"] call Gemini_fnc_updateStats;

// SAVING GEAR
//player setVariable ["current_loadout", getUnitLoadout player];
[player, [missionNamespace, "myLoadout"]] call BIS_fnc_saveInventory;

 // SAVING PRIMARY WEAPON (because the BIS_fnc_saveInventory function above doesn't always restore the primary weapon as it should)
missionNamespace setVariable ["myPrimaryWeapon", primaryWeapon player];
missionNamespace setVariable ["myPrimaryWeaponItems", primaryWeaponItems player];

// AUTO-STOPPING AI TEAM MATES WHEN PLAYER DIES - THIS AVOIDS AI MOVING BACK TO PLAYER POSITION AFTER HE RESPAWNED
{doStop _x} forEach units (group player);