modifier_auto_cast = class({})

function modifier_auto_cast:IsHidden() return true end

function modifier_auto_cast:OnCreated()
	if IsServer() then
		self:StartIntervalThink(0.1)
		self:OnIntervalThink()
	end
end

function modifier_auto_cast:OnIntervalThink()
	if IsServer() then
		local hero = self:GetCaster()
		local abilitieslist = {
			"bristleback_quill_spray_lua",
			"centaur_warrunner_hoof_stomp_lua",
			"enchantress_natures_attendants_lua",
			"alchemist_acid_spray_lua"
		}

		for i = 1, #abilitieslist do
			local current_ability = hero:FindAbilityByName(abilitieslist[i])
			if current_ability and current_ability:IsTrained() and current_ability:IsCooldownReady() then
				ExecuteOrderFromTable({
					UnitIndex = self:GetCaster():entindex(),
					OrderType = DOTA_UNIT_ORDER_CAST_NO_TARGET,
					AbilityIndex = current_ability:entindex(),
					Queue = false,
				})
			end
		end
	end
end
  
function modifier_auto_cast:CheckState()
return { 
	[MODIFIER_STATE_NO_HEALTH_BAR] = true,
}
end