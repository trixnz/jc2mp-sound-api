-- Create a one-off explosion
SoundDB.Play('Explosions', '9 - Missile Explo', {
	position = Camera:GetPosition(),
	angle = Angle()
})

-- Grab a reference to the sound meta data
local soundDef = SoundDB.Sounds['Adaptive Music']['Def_Agentish_Combat']

-- Create our music sound object
local sound = SoundDB.Create('Adaptive Music', 'Def_Agentish_Combat', {
	position = Camera:GetPosition(),
	angle = Angle()
})

-- Increase the heat parameter based on how far we are from the sound
-- This results in higher pitch notes, faster pace, etc.
Events:Subscribe('PostTick', function()
	local dist = Camera:GetPosition():Distance(sound:GetPosition()) / 10
	
	sound:SetParameter( soundDef.Parameters['heat'].Index, math.clamp(dist, 0, 1) )
end)

-- Clean up the sound when we are unloaded
Events:Subscribe('ModuleUnload', function() sound:Remove() end)