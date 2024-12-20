include('shared.lua')

language.Add("ent_jack_fgweaponbox_gamma_long","Weapon Box")

local Letter=surface.GetTextureID("sprites/mat_jack_gamma_uppercase")

function ENT:Initialize()
	util.PrecacheSound("snd_jack_boxopen.wav")
	
	util.PrecacheModel("models/weapons/v_snip_awj.mdl")
	util.PrecacheModel("models/weapons/w_357.mdl")
	util.PrecacheModel("models/mass_effect_3/weapons/assault_rifles/m-37 jalcon.mdl")
	util.PrecacheModel("models/mass_effect_3/weapons/misc/jhermal clip.mdl")
	util.PrecacheModel("models/mass_effect_3/weapons/misc/jeatsink.mdl")
	util.PrecacheModel("models/Mechanics/wheels/wheel_smooth_24f.mdl")
	
	util.PrecacheSound("snd_jack_heavycutterreload.wav")
	util.PrecacheSound("snd_jack_heavyplasmaloop_reversed.wav")
	util.PrecacheSound("snd_jack_heavyplasmaloop.wav")
	util.PrecacheSound("snd_jack_fglonggundraw.wav")
	util.PrecacheSound("snd_jack_smallcharge.wav")
	util.PrecacheSound("snd_jack_plasmapop.wav")
	util.PrecacheSound("snd_jack_heavylaservent.wav")
	util.PrecacheSound("snd_jack_displaysoff.wav")
	util.PrecacheSound("snd_jack_displayson.wav")
	util.PrecacheSound("snd_jack_nuclearfgc_start.wav")
	util.PrecacheSound("snd_jack_nuclearfgc_end.wav")
end

function ENT:Draw()
	self:DrawModel()
	
	local SelfPos=self:GetPos()
	local SelfAng=self:GetAngles()
	local Up=SelfAng:Up()
	
	local LightVec=render.GetLightColor(SelfPos)
	local LightCol=Color(LightVec.x*255,LightVec.y*255,LightVec.z*255,240)
	
	SelfAng:RotateAroundAxis(Up,180)
	cam.Start3D2D(SelfPos+Up*11.5,SelfAng,1)
		draw.TexturedQuad({
			texture=Letter,
			color=LightCol,
			x=-4,
			y=-3,
			w=8,
			h=8
		})
	cam.End3D2D()
end