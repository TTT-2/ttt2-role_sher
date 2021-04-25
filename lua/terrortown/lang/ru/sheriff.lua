local L = LANG.GetLanguageTableReference("ru")

-- GENERAL ROLE LANGUAGE STRINGS
L[SHERIFF.name] = "Шериф"
L["info_popup_" .. SHERIFF.name] = [[Вы шериф! Попробуйте найти себе товарища, чтобы защитить невинных.]]
L["body_found_" .. SHERIFF.abbr] = "Он был шерифом."
L["search_role_" .. SHERIFF.abbr] = "Этот человек был шерифом!"
L["target_" .. SHERIFF.name] = "Шериф"
L["ttt2_desc_" .. SHERIFF.name] = [[Шерифу нужно защитить невинных вместе со своим заместителем! Если шериф умрёт, умрёт и его заместитель (автоматически).]]
L["credit_" .. SHERIFF.abbr .. "_all"] = "Шериф, за вашу работу вы получили {num} кредит(а/ов)."

L[DEPUTY.name] = "Заместитель"
L["target_" .. DEPUTY.name] = "Заместитель"
L["ttt2_desc_" .. DEPUTY.name] = [[Вам нужно помочь защитить невинных!]]
L["body_found_" .. DEPUTY.abbr] = "Он был заместителем."
L["search_role_" .. DEPUTY.abbr] = "Этот человек был заместителем!"
