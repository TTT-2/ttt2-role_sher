local L = LANG.GetLanguageTableReference("it")

-- GENERAL ROLE LANGUAGE STRINGS
L[SHERIFF.name] = "Sceriffo"
L["info_popup_" .. SHERIFF.name] = [[Sei lo Sceriffo! Prova a prendere un Vice per proteggere gli Innocenti.]]
L["body_found_" .. SHERIFF.abbr] = "Era uno Sceriffo!"
L["search_role_" .. SHERIFF.abbr] = "Questa persona era uno Sceriffo!"
L["target_" .. SHERIFF.name] = "Sceriffo"
L["ttt2_desc_" .. SHERIFF.name] = [[Lo Sceriffo deve proteggere gli innocenti con il suo Vice! Se lo Sceriffo muore, anche il Vice lo farà (automaticamente).]]
L["credit_" .. SHERIFF.abbr .. "_all"] = "Sceriffo, ti è stato dato {num} credito per la tua performance."

L[DEPUTY.name] = "Deputato"
L["target_" .. DEPUTY.name] = "Deputato"
L["ttt2_desc_" .. DEPUTY.name] = [[Devi aiutare lo Sceriffo a proteggere gli innocenti!]]
L["body_found_" .. DEPUTY.abbr] = "Era un Deputato..."
L["search_role_" .. DEPUTY.abbr] = "Questa persona era un Deputato!"

-- OTHER ROLE LANGUAGE STRINGS
--L["label_dep_protection_time"] = "Protection time for new Deputy"
--L["label_dep_deagle_refill"] = "Deputy Deagle can be refilled after missing a shot"
--L["label_dep_deagle_refill_cd"] = "Refill cooldown in seconds"
--L["label_dep_deagle_refill_cd_per_kill"] = "Refill cooldown reduction per kill"
--L["label_dep_shared_death"] = "Should the deputy die with their sheriff?"
--L["label_ttt2_dep_shared_killer"] = "Should the killer be the same of dep and sheriff?"
--L["label_ttt2_dep_custom_logic"] = "Should custom logic be used?"
--L["label_ttt2_dep_kill_logic"] = "What should happen when a player of a specified team gets shot"
--L["label_ttt2_dep_kill_logic_deputy"] = "They become a deputy."
--L["label_ttt2_dep_kill_logic_skip"] = "Nothing."
--L["label_ttt2_dep_kill_logic_traitor"] = "The Victim dies."
--L["label_ttt2_dep_kill_logic_self"] = "The Attacker dies."
--L["label_ttt2_dep_kill_logic_team"] = "The team that triggers this logic"
--L["label_ttt2_dep_kill_team_traitor"] = "Traitor"
--L["label_ttt2_dep_kill_team_evil"] = "Any evil team"

--L["ttt2_weapon_deputydeagle_name"] = "Deputy Deagle"
--L["ttt2_weapon_deputydeagle_desc"] = "Shoot a player to make him your deputy."
