function CooldownPetCommon( keys )
    Timers:CreateTimer(0.2, function()
	    local ability = keys.ability
        local owner = ability:GetOwner()
        local Pet = CreateUnitByName( "unit_cooldown_pet_common" , owner:GetAbsOrigin(), true, nil, nil, DOTA_TEAM_GOODGUYS )
        Pet:SetOwner(owner)
    end)
end