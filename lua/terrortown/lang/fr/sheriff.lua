local L = LANG.GetLanguageTableReference("fr")

-- GENERAL ROLE LANGUAGE STRINGS
L[SHERIFF.name] = "Shérif"
L["info_popup_" .. SHERIFF.name] = [[Vous êtes le Shérif! Essayez de trouver un partenaire pour protéger les innocents.]]
L["body_found_" .. SHERIFF.abbr] = "C'était un Shérif."
L["search_role_" .. SHERIFF.abbr] = "Cette personne était un Shérif!"
L["target_" .. SHERIFF.name] = "Shérif"
L["ttt2_desc_" .. SHERIFF.name] = [[Le Shérif doit protéger les innocents avec son Adjoint! Si le Shérif meurt, l'adjoint mourra aussi (automatiquement).]]
L["credit_" .. SHERIFF.abbr .. "_all"] = "Shérif, vous avez été récompensé de {num} crédit(s) d'équipement pour votre performance."

L[DEPUTY.name] = "Adjoint du Shérif"
L["target_" .. DEPUTY.name] = "Adjoint du Shérif"
L["ttt2_desc_" .. DEPUTY.name] = [[Vous devez aider à protéger les innocents!]]
L["body_found_" .. DEPUTY.abbr] = "C'était un Adjoint du Shérif."
L["search_role_" .. DEPUTY.abbr] = "Cette personne était un Adjoint du Shérif!"

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
