local L = LANG.GetLanguageTableReference("en")

-- GENERAL ROLE LANGUAGE STRINGS
L[SHERIFF.name] = "Sheriff"
L["info_popup_" .. SHERIFF.name] = [[You are the Sheriff! Try to get a mate to protect the innocents.]]
L["body_found_" .. SHERIFF.abbr] = "They were a Sheriff."
L["search_role_" .. SHERIFF.abbr] = "This person was a Sheriff!"
L["target_" .. SHERIFF.name] = "Sheriff"
L["ttt2_desc_" .. SHERIFF.name] = [[The Sheriff needs to protect the innocents with their deputy! If the Sheriff dies, the deputy will die too (automatically).]]
L["credit_" .. SHERIFF.abbr .. "_all"] = "Sheriff, you have been awarded {num} equipment credit(s) for your performance."

L[DEPUTY.name] = "Deputy"
L["target_" .. DEPUTY.name] = "Deputy"
L["ttt2_desc_" .. DEPUTY.name] = [[You need to help protecting the innocents!]]
L["body_found_" .. DEPUTY.abbr] = "They were a Deputy."
L["search_role_" .. DEPUTY.abbr] = "This person was a Deputy!"

-- OTHER ROLE LANGUAGE STRINGS
L["label_dep_protection_time"] = "Protection Time for new Deputy"
L["label_dep_deagle_refill"] = "Deputy Deagle can be refilled when you missed a shot"
L["label_dep_deagle_refill_cd"] = "Seconds to Refill"
L["label_dep_deagle_refill_cd_per_kill"] = "CD Reduction per Kill"
