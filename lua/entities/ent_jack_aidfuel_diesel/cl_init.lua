//local Shit=Material("models/entities/mat_jack_apersbomb")
include('shared.lua')
language.Add("env_fire","Fire")
function ENT:Initialize()
	self.Prettiness=ClientsideModel("models/props_junk/gascan001a.mdl")
	self.Prettiness:SetPos(self:GetPos())
	self.Prettiness:SetParent(self)
	self.Prettiness:SetNoDraw(true)
	local Matricks=Matrix()
	Matricks:Scale(Vector(1,.9,.65))
	self.Prettiness:EnableMatrix("RenderMultiply",Matricks)
	self.Prettiness:SetMaterial("models/mat_jack_aidfuel_diesel")
	self.Thing=ClientsideModel("models/weapons/w_c4.mdl")
	self.Thing:SetPos(self:GetPos())
	self.Thing:SetParent(self)
	self.Thing:SetNoDraw(true)
	self.Thing:SetModelScale(.7,0)
end
function ENT:Draw()
	self.Prettiness:SetRenderOrigin(self:GetPos())
	local Ang=self:GetAngles()
	Ang:RotateAroundAxis(Ang:Up(),90)
	self.Prettiness:SetRenderAngles(Ang)
	if(self:GetDTBool(0))then
		self.Thing:SetRenderOrigin(self:GetPos()+self:GetUp()*6+self:GetForward()*4)
		self.Thing:SetRenderAngles(Ang)
		self.Thing:DrawModel()
	end
	self.Prettiness:DrawModel()
	--render.SetBlend(.5)
	--self:DrawModel()
	--render.SetBlend(1)
end
function ENT:OnRemove()
	
end
language.Add("ent_jack_aidfuel_diesel","Diesel Fuel Can")