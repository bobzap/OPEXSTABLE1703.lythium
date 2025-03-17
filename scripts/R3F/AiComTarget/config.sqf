/**************************************
config.sqf
Variables of configuration.

Author : ~R3F~ Mapoule
team-r3f.org
***************************************/

//----------------------------------------------------------------------------------------------------
// *** SUPPRESS FIRE SETTINGS ***
//
//----------------------------------------------------------------------------------------------------
// Probability of suppress fire
R3F_AIC_CFG_suppress_fire_probability = 30;// %

// Minimal distance for suppress fire
R3F_AIC_CFG_distance_min_suppress_fire = 300;// m

// Maximal distance for suppress fire
R3F_AIC_CFG_distance_max_suppress_fire = 500;// m

// Minimal time of suppress fire
R3F_AIC_CFG_time_min_suppress_fire = 4;// sec

// Maximal time of suppress fire
R3F_AIC_CFG_time_max_suppress_fire = 12;// sec
//-----------------------------------------------------------------------------------------------------

//-----------------------------------------------------------------------------------------------------
// ***  KNOWLEDGE LEVEL  ***
//
//-----------------------------------------------------------------------------------------------------
//  See KnowsAbout on BIKI
//  https://community.bistudio.com/wiki/knowsAbout
//
// Example : array_valeur_reperage = [ value if the distance < 600 m et >= 250 ,  valeur if the distance < 250m ];
// Example : R3F_AIC_CFG_spotting_day_min_max = [ 2.3, 3.5 ];
//-----------------------------------------------------------------------------------------------------
// Value day 600 m
R3F_AIC_CFG_spotting_day_min_max = [ 2.5, 3.7 ]; 

// Value night 600 m
R3F_AIC_CFG_spotting_night_min_max = [ 1.5, 2.2 ]; 

// Value dawn and dusk
R3F_AIC_CFG_spotting_transition_d_n_min_max = [ 2, 2.6 ];

// Value min at 600 m
R3F_AIC_CFG_knowsAbout_set_mini = 1.5;

//-----------------------------------------------------------------------------------------------------
//-----------------------------------------------------------------------------------------------------