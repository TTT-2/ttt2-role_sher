SWEP.Base = "weapon_tttbase"

SWEP.Spawnable = true
SWEP.AutoSpawnable = false
SWEP.AdminSpawnable = true

SWEP.HoldType = "revolver"

SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

if SERVER then
	AddCSLuaFile()

	resource.AddFile("materials/vgui/ttt/icon_deputydeagle.vmt")

	util.AddNetworkString("tttDeputyMSG_attacker")
	util.AddNetworkString("tttDeputyMSG_target")
	util.AddNetworkString("tttDeputyRefillCDReduced")
	util.AddNetworkString("tttDeputyDeagleRefilled")
	util.AddNetworkString("tttDeputyDeagleMiss")
else
	hook.Add("Initialize", "TTTInitSikiDeagleLang", function()
		LANG.AddToLanguage("English", "ttt2_weapon_deputydeagle_desc", "Shoot a player to make him your deputy.")
		LANG.AddToLanguage("Deutsch", "ttt2_weapon_deputydeagle_desc", "Schieße auf einen Spieler, um ihn zu deinem Deputy zu machen.")
	end)

	SWEP.PrintName = "Deputy Deagle"
	SWEP.Author = "Alf21"

	SWEP.Slot = 7

	SWEP.ViewModelFOV = 54
	SWEP.ViewModelFlip = false

	SWEP.Category = "Deagle"
	SWEP.Icon = "vgui/ttt/icon_deputydeagle.vtf"
	SWEP.EquipMenuData = {
		type = "Weapon",
		desc = "ttt2_weapon_deputydeagle_desc"
	}
end

-- dmg
SWEP.Primary.Delay = 1
SWEP.Primary.Recoil = 6
SWEP.Primary.Automatic = false
SWEP.Primary.NumShots = 1
SWEP.Primary.Damage = 0
SWEP.Primary.Cone = 0.00001
SWEP.Primary.Ammo = ""
SWEP.Primary.ClipSize = 1
SWEP.Primary.ClipMax = 1
SWEP.Primary.DefaultClip = 1

-- some other stuff
SWEP.InLoadoutFor = nil
SWEP.AllowDrop = false
SWEP.IsSilent = false
SWEP.NoSights = false
SWEP.UseHands = true
SWEP.Kind = WEAPON_EXTRA
SWEP.CanBuy = nil
SWEP.notBuyable = true
SWEP.LimitedStock = true
SWEP.globalLimited = true
SWEP.NoRandom = true

-- view / world
SWEP.ViewModel = "models/weapons/cstrike/c_pist_deagle.mdl"
SWEP.WorldModel = "models/weapons/w_pist_deagle.mdl"
SWEP.Weight = 5
SWEP.Primary.Sound = Sound("Weapon_Deagle.Single")

SWEP.IronSightsPos = Vector(-6.361, -3.701, 2.15)
SWEP.IronSightsAng = Vector(0, 0, 0)

SWEP.notBuyable = true

local ttt2_deputy_deagle_refill_conv = CreateConVar("ttt2_dep_deagle_refill", 1, {FCVAR_NOTIFY, FCVAR_ARCHIVE})
local ttt2_deputy_deagle_refill_cd_conv = CreateConVar("ttt2_dep_deagle_refill_cd", 120, {FCVAR_NOTIFY, FCVAR_ARCHIVE})
local ttt2_dep_deagle_refill_cd_per_kill_conv = CreateConVar("ttt2_dep_deagle_refill_cd_per_kill", 60, {FCVAR_NOTIFY, FCVAR_ARCHIVE})

local function DeputyDeagleRefilled(wep)
	if not IsValid(wep) then return end

	local text = LANG.GetTranslation("ttt2_dep_recharged")

	MSTACK:AddMessage(text)
	STATUS:RemoveStatus("ttt2_deputy_deagle_reloading")

	net.Start("tttDeputyDeagleRefilled")
	net.WriteEntity(wep)
	net.SendToServer()
end

local function DeputyDeagleCallback(attacker, tr, dmg)
	if CLIENT then return end

	local target = tr.Entity

	--invalid shot return
	if not GetRoundState() == ROUND_ACTIVE or not IsValid(attacker) or not attacker:IsPlayer() or not attacker:IsTerror() then return end

	--no/bad hit: (send message), start timer and return
	if not IsValid(target) or not target:IsPlayer() or not target:IsTerror() then
		if ttt2_deputy_deagle_refill_conv:GetBool() then
			net.Start("tttDeputyDeagleMiss")
			net.Send(attacker)
		end

		return
	end

	local deagle = attacker:GetWeapon("weapon_ttt2_deputydeagle")
	if IsValid(deagle) then
		deagle:Remove()
	end

	AddDeputy(target, attacker)

	net.Start("tttDeputyMSG_attacker")
	net.WriteEntity(target)
	net.Send(attacker)

	net.Start("tttDeputyMSG_target")
	net.WriteEntity(attacker)
	net.Send(target)

	return true
end

function SWEP:OnDrop()
	self:Remove()
end

function SWEP:ShootBullet(dmg, recoil, numbul, cone)
	cone = cone or 0.01

	local bullet = {}
	bullet.Num = 1
	bullet.Src = self:GetOwner():GetShootPos()
	bullet.Dir = self:GetOwner():GetAimVector()
	bullet.Spread = Vector(cone, cone, 0)
	bullet.Tracer = 0
	bullet.TracerName = self.Tracer or "Tracer"
	bullet.Force = 10
	bullet.Damage = 0
	bullet.Callback = DeputyDeagleCallback

	self:GetOwner():FireBullets(bullet)

	self.BaseClass.ShootBullet(self, dmg, recoil, numbul, cone)
end

function SWEP:OnRemove()
	if CLIENT then
		STATUS:RemoveStatus("ttt2_deputy_deagle_reloading")

		timer.Stop("ttt2_deputy_deagle_refill_timer")
	end
end

function ShootDeputy(target, dmginfo)
	local attacker = dmginfo:GetAttacker()

	if not attacker:IsPlayer() or not target:IsPlayer() or not IsValid(attacker:GetActiveWeapon())
		or not attacker:IsTerror() or not IsValid(target) or not target:IsTerror()
		or target:GetSubRole() == ROLE_SHERIFF or target:GetSubRole() == ROLE_DEPUTY then
	return end

	AddDeputy(target, attacker)

	net.Start("tttDeputyMSG_attacker")
	net.WriteEntity(target)
	net.Send(attacker)

	net.Start("tttDeputyMSG_target")
	net.WriteEntity(attacker)
	net.Send(target)
end


if SERVER then
	hook.Add("PlayerDeath", "DeputyDeagleRefillReduceCD", function(victim, inflictor, attacker)
		if not IsValid(attacker) or not attacker:IsPlayer() or not attacker:HasWeapon("weapon_ttt2_deputydeagle") or not ttt2_deputy_deagle_refill_conv:GetBool() then return end

		net.Start("tttDeputyRefillCDReduced")
		net.Send(attacker)
	end)
end


-- auto add deputy weapon into jackal shop
hook.Add("LoadedFallbackShops", "DeputyDeagleAddToShop", function()
	if not SHERIFF or not DEPUTY or not SHERIFF.fallbackTable then return end

	AddWeaponIntoFallbackTable("weapon_ttt2_deputydeagle", SHERIFF)
end)

if CLIENT then
	hook.Add("TTT2FinishedLoading", "InitDepMsgText", function()
		LANG.AddToLanguage("English", "ttt2_dep_shot", "Successfully shot {name} as deputy!")
		LANG.AddToLanguage("Deutsch", "ttt2_dep_shot", "Erfolgreich {name} zum Hilfssheriff geschossen!")

		LANG.AddToLanguage("English", "ttt2_dep_were_shot", "You were shot as deputy by {name}!")
		LANG.AddToLanguage("Deutsch", "ttt2_dep_were_shot", "Du wurdest von {name} zum Hilfssheriff geschossen!")

		LANG.AddToLanguage("English", "ttt2_dep_ply_killed", "Your deputy deagle cooldown was reduced by {amount} seconds.")
		LANG.AddToLanguage("Deutsch", "ttt2_dep_ply_killed", "Deine Deputy Deagle Wartezeit wurde um {amount} Sekunden reduziert.")

		LANG.AddToLanguage("English", "ttt2_dep_recharged", "Your deputy deagle has been recharged.")
		LANG.AddToLanguage("Deutsch", "ttt2_dep_recharged", "Deine Deputy Deagle wurde wieder aufgefüllt.")
	end)

	hook.Add("Initialize", "ttt_deputy_init_status", function()
		STATUS:RegisterStatus("ttt2_deputy_deagle_reloading", {
			hud = Material("vgui/ttt/hud_icon_deagle.png"),
			type = "bad"
		})
	end)

	net.Receive("tttDeputyMSG_attacker", function(len)
		local target = net.ReadEntity()
		if not IsValid(target) then return end

		local text = LANG.GetParamTranslation("ttt2_dep_shot", {name = target:GetName()})
		MSTACK:AddMessage(text)
	end)

	net.Receive("tttDeputyMSG_target", function(len)
		local attacker = net.ReadEntity()
		if not IsValid(attacker) then return end

		local text = LANG.GetParamTranslation("ttt2_dep_were_shot", {name = attacker:GetName()})
		MSTACK:AddMessage(text)
	end)

	net.Receive("tttDeputyRefillCDReduced", function()
		if not timer.Exists("ttt2_deputy_deagle_refill_timer") or not LocalPlayer():HasWeapon("weapon_ttt2_deputydeagle") then return end

		local timeLeft = timer.TimeLeft("ttt2_deputy_deagle_refill_timer") or 0
		local newTime = math.max(timeLeft - ttt2_dep_deagle_refill_cd_per_kill_conv:GetInt(), 0.1)

		local wep = LocalPlayer():GetWeapon("weapon_ttt2_deputydeagle")
		if not IsValid(wep) then return end

		timer.Adjust("ttt2_deputy_deagle_refill_timer", newTime, 1, function()
			if not IsValid(wep) then return end

			DeputyDeagleRefilled(wep)
		end)

		if STATUS.active["ttt2_deputy_deagle_reloading"] then
			STATUS.active["ttt2_deputy_deagle_reloading"].displaytime = CurTime() + newTime
		end

		local text = LANG.GetParamTranslation("ttt2_dep_ply_killed", {amount = ttt2_dep_deagle_refill_cd_per_kill_conv:GetInt()})
		MSTACK:AddMessage(text)

		chat.PlaySound()
	end)

	net.Receive("tttDeputyDeagleMiss", function()
		local client = LocalPlayer()
		if not IsValid(client) or not client:IsTerror() or not client:HasWeapon("weapon_ttt2_deputydeagle") then return end

		local wep = client:GetWeapon("weapon_ttt2_deputydeagle")
		if not IsValid(wep) then return end

		local initialCD = ttt2_deputy_deagle_refill_cd_conv:GetInt()

		STATUS:AddTimedStatus("ttt2_deputy_deagle_reloading", initialCD, true)

		timer.Create("ttt2_deputy_deagle_refill_timer", initialCD, 1, function()
			if not IsValid(wep) then return end

			DeputyDeagleRefilled(wep)
		end)
	end)
else
	net.Receive("tttDeputyDeagleRefilled", function()
		local wep = net.ReadEntity()
		if not IsValid(wep) then return end

		wep:SetClip1(1)
	end)
end
