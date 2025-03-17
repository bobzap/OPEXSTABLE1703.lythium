// =========================================================================================================
// MAIN DIARY
// =========================================================================================================

	if (isDedicated) exitWith {};
	if (player diarySubjectExists "FAQ") exitWith {};
	//waitUntil {!isNil"OPEX_params_ready"};
	//waitUntil {OPEX_params_ready};

	_diary = player createDiaryRecord ["Diary", [localize "STR_diary_rofTitle", format [localize "STR_diary_rofContent", localize OPEX_friendly_factionName]]];
	_diary = player createDiaryRecord ["Diary", [localize "STR_diary_executionTitle", localize "STR_diary_executionContent"]];
	_diary = player createDiaryRecord ["Diary", [localize "STR_diary_missionTitle", format [localize "STR_diary_missionContent", localize OPEX_enemy_fighters, localize OPEX_friendly_factionName, localize OPEX_enemy_factionName3, OPEX_friendly_camp]]];
	_diary = player createDiaryRecord ["Diary", [localize "STR_diary_sitrepTitle", format [localize "STR_diary_sitrepContent", localize OPEX_enemy_factionName3, localize OPEX_friendly_factionName, localize OPEX_mapLocalityInside, localize OPEX_mapCountry]]];

	//_diary = player createDiaryRecord ["Diary", ["TEST", format [localize "STR_test_enemyName", localize enemy_name_2, localize OPEX_enemy_factionName3, localize OPEX_enemy_fighters]]];

// =========================================================================================================
// FAQ
// =========================================================================================================

	_faq = player createDiarySubject ["FAQ", localize "STR_FAQ"];

	_faq_newEntry = player createDiaryRecord ["FAQ", [localize "STR_faq_ratingDonations_title", localize "STR_faq_ratingDonations_content"]];
	_faq_newEntry = player createDiaryRecord ["FAQ", [localize "STR_faq_complain_title", localize "STR_faq_complain_content"]];
	_faq_newEntry = player createDiaryRecord ["FAQ", [localize "STR_faq_issues_title", localize "STR_faq_issues_content"]];

	_faq_newEntry = player createDiaryRecord ["FAQ", [localize "STR_faq_otherMaps_title", localize "STR_faq_otherMaps_content"]];

	_faq_newEntry = player createDiaryRecord ["FAQ", [localize "STR_faq_liveVideoFeed_title", localize "STR_faq_liveVideoFeed_content"]];
	_faq_newEntry = player createDiaryRecord ["FAQ", [localize "STR_faq_training_title", localize "STR_faq_training_content"]];
	_faq_newEntry = player createDiaryRecord ["FAQ", [localize "STR_faq_reputation_title", localize "STR_faq_reputation_content"]];
	_faq_newEntry = player createDiaryRecord ["FAQ", [localize "STR_faq_whatAreCredits_title", localize "STR_faq_whatAreCredits_content"]];

	_faq_newEntry = player createDiaryRecord ["FAQ", [localize "STR_faq_mobileRespawn_title", localize "STR_faq_mobileRespawn_content"]];
	_faq_newEntry = player createDiaryRecord ["FAQ", [localize "STR_faq_civNoAnswer_title", localize "STR_faq_civNoAnswer_content"]];
	_faq_newEntry = player createDiaryRecord ["FAQ", [localize "STR_faq_nvg_title", localize "STR_faq_nvg_content"]];
	_faq_newEntry = player createDiaryRecord ["FAQ", [localize "STR_faq_blackmap_title", localize "STR_faq_blackmap_content"]];
	_faq_newEntry = player createDiaryRecord ["FAQ", [localize "STR_faq_needs_title", localize "STR_faq_needs_content"]];

	_faq_newEntry = player createDiaryRecord ["FAQ", [localize "STR_faq_incognito_title", localize "STR_faq_incognito_content"]];
	_faq_newEntry = player createDiaryRecord ["FAQ", [localize "STR_faq_getSupport_title", localize "STR_faq_getSupport_content"]];

	_faq_newEntry = player createDiaryRecord ["FAQ", [localize "STR_faq_whereToRearm_title", localize "STR_faq_whereToRearm_content"]];
	_faq_newEntry = player createDiaryRecord ["FAQ", [localize "STR_faq_whereToRepair_title", localize "STR_faq_whereToRepair_content"]];
	_faq_newEntry = player createDiaryRecord ["FAQ", [localize "STR_faq_whereToRefuel_title", localize "STR_faq_whereToRefuel_content"]];
	_faq_newEntry = player createDiaryRecord ["FAQ", [localize "STR_faq_whereToHeal_title", localize "STR_faq_whereToHeal_content"]];
	_faq_newEntry = player createDiaryRecord ["FAQ", [localize "STR_faq_howToRevive_title", localize "STR_faq_howToRevive_content"]];
	_faq_newEntry = player createDiaryRecord ["FAQ", [localize "STR_faq_howToHeal_title", localize "STR_faq_howToHeal_content"]];

	_faq_newEntry = player createDiaryRecord ["FAQ", [localize "STR_faq_whereToBuySupplies_title", localize "STR_faq_whereToBuySupplies_content"]];
	_faq_newEntry = player createDiaryRecord ["FAQ", [localize "STR_faq_whereToBuyVehicles_title", localize "STR_faq_whereToBuyVehicles_content"]];
	_faq_newEntry = player createDiaryRecord ["FAQ", [localize "STR_faq_whereToBuyAI_title", localize "STR_faq_whereToBuyAI_content"]];

	_faq_newEntry = player createDiaryRecord ["FAQ", [localize "STR_faq_whereToSleep_title", localize "STR_faq_whereToSleep_content"]];
	_faq_newEntry = player createDiaryRecord ["FAQ", [localize "STR_faq_whereToFindFood_title", localize "STR_faq_whereToFindFood_content"]];
	_faq_newEntry = player createDiaryRecord ["FAQ", [localize "STR_faq_whereToFindMedical_title", localize "STR_faq_whereToFindMedical_content"]];
	_faq_newEntry = player createDiaryRecord ["FAQ", [localize "STR_faq_whereToFindWeapons_title", localize "STR_faq_whereToFindWeapons_content"]];

	_faq_newEntry = player createDiaryRecord ["FAQ", [localize "STR_faq_virtualGarage_title", localize "STR_faq_virtualGarage_content"]];
	_faq_newEntry = player createDiaryRecord ["FAQ", [localize "STR_faq_virtualArsenal_title", localize "STR_faq_virtualArsenal_content"]];

	_faq_newEntry = player createDiaryRecord ["FAQ", [localize "STR_faq_caches_title", localize "STR_faq_caches_content"]];
	_faq_newEntry = player createDiaryRecord ["FAQ", [localize "STR_faq_suspects_title", localize "STR_faq_suspects_content"]];

	_faq_newEntry = player createDiaryRecord ["FAQ", [localize "STR_faq_sitep_title", localize "STR_faq_sitrep_content"]];

	_faq_newEntry = player createDiaryRecord ["FAQ", [localize "STR_faq_persistenceReset_title", localize "STR_faq_persistenceReset_content"]];
	_faq_newEntry = player createDiaryRecord ["FAQ", [localize "STR_faq_persistenceSave_title", localize "STR_faq_persistenceSave_content"]];

	_faq_newEntry = player createDiaryRecord ["FAQ", [localize "STR_faq_whatToDo_title", localize "STR_faq_whatToDo_content"]];

// =========================================================================================================
// THANKS
// =========================================================================================================

	_thanks = player createDiarySubject ["Thanks", localize "STR_thanks"];
	_text = player createDiaryRecord ["Thanks", [localize "STR_thanks_influencers_title", localize "STR_thanks_influencers_text"]];
	_text = player createDiaryRecord ["Thanks", [localize "STR_thanks_contributors_title", localize "STR_thanks_contributors_text"]];
	_text = player createDiaryRecord ["Thanks", [localize "STR_thanks_translators_title", localize "STR_thanks_translators_text"]];
	_text = player createDiaryRecord ["Thanks", [localize "STR_thanks_helpers_title", localize "STR_thanks_helpers_text"]];
	_text = player createDiaryRecord ["Thanks", [localize "STR_thanks_creators_title", localize "STR_thanks_creators_text"]];

// =========================================================================================================
// TRIBUTE
// =========================================================================================================

	_tribute = player createDiarySubject ["Tribute", localize "STR_tribute"];
	_text = player createDiaryRecord ["Tribute", [localize "STR_tribute_title", localize "STR_tribute_text"]];