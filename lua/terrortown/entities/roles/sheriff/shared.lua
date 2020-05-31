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
