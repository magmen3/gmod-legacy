AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

ENT.DoNotBangOnCartridges=true

function ENT:SpawnFunction(ply,tr)
	local SpawnPos=tr.HitPos+tr.HitNormal*16
	local ent=ents.Create("ent_jack_fgironslug_small")
	ent:SetPos(SpawnPos)
	ent:Spawn()
	ent:Activate()
	
	local effectdata=EffectData()
	effectdata:SetEntity(ent)
	util.Effect("propspawn",effectdata)
	
	return ent
end

function ENT:Initialize()
	self:SetModel("models/cheeze/pcb2/pcb1.mdl")
	self:SetMaterial("models/shiny")
	self:SetColor(Color(100,100,100))
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:DrawShadow(true)
	
	self:SetUseType(SIMPLE_USE)
	
	self:SetCollisionGroup(COLLISION_GROUP_NONE)
	
	local phys=self:GetPhysicsObject()
	if(phys:IsValid())then
		phys:Wake()
		phys:SetMass(7)
	end
end

function ENT:Think()
	//nothin
end

function ENT:PhysicsCollide(data,physobj)
	if not(data.HitEntity.DoNotBangOnCartridges)then
		if(data.DeltaTime>.2)then
			local Traiss=util.QuickTrace(self:GetPos()-data.OurOldVelocity,data.OurOldVelocity*20,self)
			if(Traiss.Hit)then
				if((Traiss.MatType==MAT_DIRT)or(Traiss.MatType==MAT_SAND))then
					sound.Play("snd_jack_fgc_dirt_"..tostring(math.random(1,2))..".wav",self:GetPos(),60,math.Rand(110,130))
				else
					sound.Play("snd_jack_fgc_concrete_"..tostring(math.random(1,3))..".wav",self:GetPos(),60,math.Rand(110,130))
				end
			end
		end
	end
	local Impulse=-data.Speed*data.HitNormal*2+(data.OurOldVelocity*-2)
	self:GetPhysicsObject():ApplyForceCenter(Impulse)
end

function ENT:OnTakeDamage(dmginfo)
	self:TakePhysicsDamage(dmginfo)
end

function ENT:Use(activator)
	if(activator:IsPlayer())then
		local Wep=activator:GetActiveWeapon()
		if(IsValid(Wep))then
			if(Wep.IsAJackyFunGun)then
				if(Wep.LoadIronSlug)then
					if(Wep.TakesSmallIron)then
						Wep:LoadIronSlug(self)
						umsg.Start("JackyFGIronLoad")
						umsg.Entity(Wep)
						umsg.Entity(self)
						umsg.End()
					end
				end
			end
		end
	end
end