if SERVER then
	AddCSLuaFile()

	resource.AddFile("materials/vgui/ttt/dynamic/roles/icon_sher.vmt")
end

function ROLE:PreInitialize()
	self.color = Color(51, 93, 165, 255)

	self.abbr = "sher" -- abbreviation
	self.scoreKillsMultiplier = 1 -- multiplier for kill of player of another team
	self.scoreTeamKillsMultiplier = -8 -- multiplier for teamkill
	self.unknownTeam = true

	self.defaultTeam = TEAM_INNOCENT -- the team name: roles with same team name are working together
	self.defaultEquipment = SPECIAL_EQUIPMENT -- here you can set up your own default equipment

	self.conVarData = {
		pct = 0.13, -- necessary: percentage of getting this role selected (per player)
		maximum = 1, -- maximum amount of roles in a round
		minPlayers = 8, -- minimum amount of players until this role is able to get selected
		credits = 2, -- the starting credits of a specific role
		creditsTraitorKill = 0,
		creditsTraitorDead = 1,
		togglable = true, -- option to toggle a role for a client if possible (F1 menu)
		random = 50,
		shopFallback = SHOP_FALLBACK_DETECTIVE
	}
end

function ROLE:Initialize()
	roles.SetBaseRole(self, ROLE_DETECTIVE)

	if CLIENT then
		-- Role specific language elements
		LANG.AddToLanguage("English", self.name, "Sheriff")
		LANG.AddToLanguage("English", "info_popup_" .. self.name, [[You are the Sheriff! Try to get a mate to protect the innocents.]])
		LANG.AddToLanguage("English", "body_found_" .. self.abbr, "This person was a Sheriff!")
		LANG.AddToLanguage("English", "search_role_" .. self.abbr, "This person was a Sheriff!")
		LANG.AddToLanguage("English", "target_" .. self.name, "Sheriff")
		LANG.AddToLanguage("English", "ttt2_desc_" .. self.name, [[The Sheriff needs to protect the innocents with his deputy! If the Sheriff dies, the deputy will die too (automatically).]])
		LANG.AddToLanguage("English", "credit_" .. self.abbr .. "_all", "Sheriff, you have been awarded {num} equipment credit(s) for your performance.")

		LANG.AddToLanguage("Deutsch", self.name, "Sheriff")
		LANG.AddToLanguage("Deutsch", "info_popup_" .. self.name, [[Du bist ein Sheriff! Versuche, einen Deputy zu bekommen und so ie Innocents besser zu beschützen.]])
		LANG.AddToLanguage("Deutsch", "body_found_" .. self.abbr, "Er war ein Sheriff!")
		LANG.AddToLanguage("Deutsch", "search_role_" .. self.abbr, "Diese Person war ein Sheriff!")
		LANG.AddToLanguage("Deutsch", "target_" .. self.name, "Sheriff")
		LANG.AddToLanguage("Deutsch", "ttt2_desc_" .. self.name, [[Der Sheriff muss mit seinem Deputy die Unschuldigen beschützen! Wenn der Sheriff stirbt, wird auch der Hilfssheriff automatisch sterben.]])
		LANG.AddToLanguage("Deutsch", "credit_" .. self.abbr .. "_all", "Sheriffs, euch wurden {num} Ausrüstungs-Credit(s) für eure Leistung gegeben.")
	end
end

if SERVER then
	-- Give Loadout on respawn and rolechange
	function ROLE:GiveRoleLoadout(ply, isRoleChange)
		if isRoleChange then -- TODO: maybe give dep deagle on respawn if not used before
			ply:GiveEquipmentWeapon("weapon_ttt2_deputydeagle")
		end

		ply:GiveEquipmentItem("item_ttt_armor")
	end

	-- Remove Loadout on death and rolechange
	function ROLE:RemoveRoleLoadout(ply, isRoleChange)
		ply:StripWeapon("weapon_ttt2_deputydeagle")
		ply:RemoveEquipmentItem("item_ttt_armor")
	end
end
