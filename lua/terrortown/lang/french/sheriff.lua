local L = LANG.GetLanguageTableReference("french")

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
