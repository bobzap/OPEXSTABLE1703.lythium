waitUntil {!isNil "OPEX_params_ready"};
waitUntil {OPEX_params_ready};
sleep 1;

{OPEX_friendly_rifleSilencers set [_forEachIndex, toLower _x]} forEach OPEX_friendly_rifleSilencers;
{OPEX_friendly_handgunSilencers set [_forEachIndex, toLower _x]} forEach OPEX_friendly_handgunSilencers;
{OPEX_friendly_flashlights set [_forEachIndex, toLower _x]} forEach OPEX_friendly_flashlights;