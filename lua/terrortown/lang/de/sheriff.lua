local L = LANG.GetLanguageTableReference("de")

-- GENERAL ROLE LANGUAGE STRINGS
L[SHERIFF.name] = "Sheriff"
L["info_popup_" .. SHERIFF.name] = [[Du bist ein Sheriff! Versuche, einen Deputy zu bekommen und so ie Innocents besser zu beschützen.]]
L["body_found_" .. SHERIFF.abbr] = "Er war ein Sheriff!"
L["search_role_" .. SHERIFF.abbr] = "Diese Person war ein Sheriff!"
L["target_" .. SHERIFF.name] = "Sheriff"
L["ttt2_desc_" .. SHERIFF.name] = [[Der Sheriff muss mit seinem Deputy die Unschuldigen beschützen! Wenn der Sheriff stirbt, wird auch der Hilfssheriff automatisch sterben.]]
L["credit_" .. SHERIFF.abbr .. "_all"] = "Sheriffs, euch wurden {num} Ausrüstungs-Credit(s) für eure Leistung gegeben."

L[DEPUTY.name] = "Hilfssheriff"
L["target_" .. DEPUTY.name] = "Hilfssheriff"
L["ttt2_desc_" .. DEPUTY.name] = [[Du musst helfen, die Innocents zu beschützen!]]
L["body_found_" .. DEPUTY.abbr] = "Er war ein Hilfssheriff!"
L["search_role_" .. DEPUTY.abbr] = "Diese Person war ein Hilfssheriff!"
