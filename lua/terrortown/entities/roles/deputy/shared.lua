if SERVER then
	AddCSLuaFile()

	resource.AddFile("materials/vgui/ttt/dynamic/roles/icon_dep.vmt")

	CreateConVar("ttt2_dep_protection_time", 1, {FCVAR_NOTIFY, FCVAR_ARCHIVE})
end

local plymeta = FindMetaTable("Player")
if not plymeta then return end

function ROLE:PreInitialize()
	self.color = Color(83, 120, 182, 255)

	self.abbr = "dep"
	self.score.killsMultiplier = 8
	self.score.teamKillsMultiplier = -8
	self.score.bodyFoundMuliplier = 3
	self.notSelectable = true
	self.unknownTeam = true

	self.defaultTeam = TEAM_INNOCENT
	self.defaultEquipment = SPECIAL_EQUIPMENT

	self.isPublicRole = true
	self.isPolicingRole = true

	self.conVarData = {
		credits = 1,
		creditsAwardDeadEnable = 1,
		creditsAwardKillEnable = 0,
		shopFallback = SHOP_FALLBACK_DETECTIVE
	}
end

function ROLE:Initialize()
	roles.SetBaseRole(self, ROLE_DETECTIVE)
end

function plymeta:IsDeputy()
	return IsValid(self:GetNWEntity("binded_deputy", nil))
end

function plymeta:GetDeputyMate()
	local data = self:GetNWEntity("binded_deputy", nil)

	return IsValid(data) and data or nil
end

function plymeta:GetDeputys()
	local tmp = {}

	for _, v in ipairs(player.GetAll()) do
		if v:GetSubRole() == ROLE_DEPUTY and v:GetDeputyMate() == self then
			tmp[#tmp + 1] = v
		end
	end

	if #tmp == 0 then return end

	return tmp
end

local function HealDeputy(ply)
	ply:SetHealth(ply:GetMaxHealth())
end

if SERVER then
	util.AddNetworkString("TTT2HealDeputy")
	util.AddNetworkString("TTT2SyncDepColor")

	function AddDeputy(target, attacker)
		if target:IsDeputy() or attacker:IsDeputy() then return end

		target:SetNWEntity("binded_deputy", attacker)
		target:SetRole(ROLE_DEPUTY)

		local credits = target:GetCredits()
		target:SetDefaultCredits()
		target:SetCredits(target:GetCredits() + credits)

		target.depTimestamp = os.time()
		target.depIssuer = attacker

		timer.Simple(0.1, SendFullStateUpdate)
	end

	hook.Add("PlayerShouldTakeDamage", "DepProtectionTime", function(ply, atk)
		local pTime = GetConVar("ttt2_dep_protection_time"):GetInt()

		if pTime > 0 and IsValid(atk) and atk:IsPlayer()
		and ply:IsActive() and atk:IsActive()
		and atk:IsDeputy() and atk.depIssuer == ply
		and atk.depTimestamp + pTime >= os.time() then
			return false
		end
	end)

	hook.Add("EntityTakeDamage", "DepEntTakeDmg", function(target, dmginfo)
		local attacker = dmginfo:GetAttacker()

		if not target:IsPlayer() or not IsValid(attacker) or not attacker:IsPlayer()
			or (target:Health() - dmginfo:GetDamage()) > 0
			or not hook.Run("TTT2DEPAddDeputy", attacker, target)
		then return end

		dmginfo:ScaleDamage(0)

		AddDeputy(target, attacker)
		HealDeputy(target)

		-- do this clientside as well
		net.Start("TTT2HealDeputy")
		net.Send(target)
	end)

	hook.Add("PlayerDisconnected", "DepPlyDisconnected", function(discPly)
		local deps

		if discPly:IsDeputy() then
			deps = {discPly}
		else
			deps = discPly:GetDeputys()
		end

		if not deps then return end

		for _, dep in ipairs(deps) do
			if IsValid(dep) and dep:IsPlayer() and dep:IsActive() then
				dep:SetNWEntity("binded_deputy", nil)
				dep:TakeDamage(99999, game.GetWorld())
			end
		end
	end)

	hook.Add("PostPlayerDeath", "PlayerDeathChangeDep", function(ply)
		local deps = ply:GetDeputys()
		if not deps then return end

		for _, dep in ipairs(deps) do
			if IsValid(dep) and dep:IsActive() then
				dep:SetNWEntity("binded_deputy", nil)
				dep:TakeDamage(99999, game.GetWorld())

				if #deps == 1 then -- a player can just be binded with one player as deputy
					ply.spawn_as_deputy = dep
				end
			end
		end
	end)

	hook.Add("PlayerSpawn", "PlayerSpawnsAsDeputy", function(ply)
		if not ply.spawn_as_deputy then return end

		AddDeputy(ply, ply.spawn_as_deputy)

		ply.spawn_as_deputy = nil
	end)
end

if CLIENT then
	function ROLE:AddToSettingsMenu(parent)
		local form = vgui.CreateTTT2Form(parent, "header_roles_additional")

		form:MakeSlider({
			serverConvar = "ttt2_dep_protection_time",
			label = "label_dep_protection_time",
			min = 0,
			max = 60,
			decimal = 0
		})

		form:MakeCheckBox({
			serverConvar = "ttt2_dep_deagle_refill",
			label = "label_dep_deagle_refill"
		})

		form:MakeSlider({
			serverConvar = "ttt2_dep_deagle_refill_cd",
			label = "label_dep_deagle_refill_cd",
			min = 1,
			max = 300,
			decimal = 0
		})

		form:MakeSlider({
			serverConvar = "ttt2_dep_deagle_refill_cd_per_kill",
			label = "label_dep_deagle_refill_cd_per_kill",
			min = 1,
			max = 300,
			decimal = 0
		})
	end

	net.Receive("TTT2HealDeputy", function()
		HealDeputy(LocalPlayer())
	end)
end

hook.Add("TTTPrepareRound", "DepPrepareRound", function()
	for _, ply in ipairs(player.GetAll()) do
		ply.spawn_as_deputy = nil

		if SERVER then
			ply:SetNWEntity("binded_deputy", nil)
		end
	end
end)
