L = LANG.GetLanguageTableReference("english")

-- GENERAL ROLE LANGUAGE STRINGS
L[SHERIFF.name] = "Sheriff"
L["info_popup_" .. SHERIFF.name] = [[You are the Sheriff! Try to get a mate to protect the innocents.]]
L["body_found_" .. SHERIFF.abbr] = "They were a Sheriff."
L["search_role_" .. SHERIFF.abbr] = "This person was a Sheriff!"
L["target_" .. SHERIFF.name] = "Sheriff"
L["ttt2_desc_" .. SHERIFF.name] = [[The Sheriff needs to protect the innocents with his deputy! If the Sheriff dies, the deputy will die too (automatically).]]
L["credit_" .. SHERIFF.abbr .. "_all"] = "Sheriff, you have been awarded {num} equipment credit(s) for your performance."

L[DEPUTY.name] = "Deputy"
L["target_" .. DEPUTY.name] = "Deputy"
L["ttt2_desc_" .. DEPUTY.name] = [[You need to help protecting the innocents!]]
L["body_found_" .. DEPUTY.abbr] = "They were a Deputy."
L["search_role_" .. DEPUTY.abbr] = "This person was a Deputy!"
