modifier_frozen = class({})

function modifier_frozen:IsHidden() return true end

function modifier_frozen:OnCreated()
  if not IsServer() then return end
end

function modifier_frozen:OnDestroy()
  if not IsServer() then return end
end

function modifier_frozen:CheckState()
return { 
	[MODIFIER_STATE_STUNNED] = true,
    [MODIFIER_STATE_OUT_OF_GAME] = true, 
    [MODIFIER_STATE_INVULNERABLE] = true, 
    [MODIFIER_STATE_NO_HEALTH_BAR] = true, 
}
end