function CooldownPetCommon( keys )
    Timers:CreateTimer(0.2, function()
	    local ability = keys.ability
        local owner = ability:GetOwner()
        local CooldownCommonPet = CreateUnitByName("unit_cooldown_pet_common", owner:GetAbsOrigin(), true, nil, nil, DOTA_TEAM_GOODGUYS)
        CooldownCommonPet:SetOwner(owner)
        CooldownCommonPet:SetTeam(owner:GetTeam())
        local CooldownCommonPetParticle = ParticleManager:CreateParticle( "particles/econ/courier/courier_ti10/courier_ti10_lvl1_ambient.vpcf", PATTACH_ABSORIGIN_FOLLOW, CooldownCommonPet)
    end)
end

function CooldownPetRare( keys )
    Timers:CreateTimer(0.2, function()
        local ability = keys.ability
        local owner = ability:GetOwner()
        local UnitsList = FindUnitsInRadius(owner:GetTeamNumber(), owner:GetAbsOrigin(), nil, FIND_UNITS_EVERYWHERE, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_INVULNERABLE, FIND_CLOSEST, false)

        for i, PreviousPet in ipairs(UnitsList) do
            if PreviousPet:GetUnitName() == "unit_cooldown_pet_common" then
                PreviousPet:AddNoDraw()
                PreviousPet:ForceKill(false)
            end
        end

        Timers:CreateTimer(0.2, function()
            local CooldownRarePet = CreateUnitByName("unit_cooldown_pet_rare", owner:GetAbsOrigin(), true, nil, nil, DOTA_TEAM_GOODGUYS)
            CooldownRarePet:SetOwner(owner)
            local CooldownRarePetParticle = ParticleManager:CreateParticle( "particles/econ/courier/courier_ti10/courier_ti10_lvl3_ambient.vpcf", PATTACH_ABSORIGIN_FOLLOW, CooldownRarePet)
        end)
    end)
end

function CooldownPetMythical( keys )
    Timers:CreateTimer(0.2, function()
        local ability = keys.ability
        local owner = ability:GetOwner()
        local UnitsList = FindUnitsInRadius(owner:GetTeamNumber(), owner:GetAbsOrigin(), nil, FIND_UNITS_EVERYWHERE, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_INVULNERABLE, FIND_CLOSEST, false)

        for i, PreviousPet in ipairs(UnitsList) do
            if PreviousPet:GetUnitName() == "unit_cooldown_pet_rare" then
                PreviousPet:AddNoDraw()
                PreviousPet:ForceKill(false)
            end
            if PreviousPet:GetUnitName() == "unit_cooldown_pet_common" then
                PreviousPet:AddNoDraw()
                PreviousPet:ForceKill(false)
            end
        end

        Timers:CreateTimer(0.2, function()
            local CooldownMythicalPet = CreateUnitByName("unit_cooldown_pet_mythical", owner:GetAbsOrigin(), true, nil, nil, DOTA_TEAM_GOODGUYS)
            CooldownMythicalPet:SetOwner(owner)
            local CooldownMythicalPetParticle = ParticleManager:CreateParticle( "particles/econ/courier/courier_ti10/courier_ti10_lvl4_ambient.vpcf", PATTACH_ABSORIGIN_FOLLOW, CooldownMythicalPet)
        end)
    end)
end

function CooldownPetLegendary( keys )
    Timers:CreateTimer(0.2, function()
        local ability = keys.ability
        local owner = ability:GetOwner()
        local UnitsList = FindUnitsInRadius(owner:GetTeamNumber(), owner:GetAbsOrigin(), nil, FIND_UNITS_EVERYWHERE, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_INVULNERABLE, FIND_CLOSEST, false)

        for i, PreviousPet in ipairs(UnitsList) do
            if PreviousPet:GetUnitName() == "unit_cooldown_pet_mythical" then
                PreviousPet:AddNoDraw()
                PreviousPet:ForceKill(false)
            end
            if PreviousPet:GetUnitName() == "unit_cooldown_pet_rare" then
                PreviousPet:AddNoDraw()
                PreviousPet:ForceKill(false)
            end
            if PreviousPet:GetUnitName() == "unit_cooldown_pet_common" then
                PreviousPet:AddNoDraw()
                PreviousPet:ForceKill(false)
            end
        end

        Timers:CreateTimer(0.2, function()
            local CooldownLegendaryPet = CreateUnitByName("unit_cooldown_pet_legendary", owner:GetAbsOrigin(), true, nil, nil, DOTA_TEAM_GOODGUYS)
            CooldownLegendaryPet:SetOwner(owner)
            local CooldownLegendaryPetParticle = ParticleManager:CreateParticle( "particles/econ/courier/courier_ti10/courier_ti10_lvl7_ambient.vpcf", PATTACH_ABSORIGIN_FOLLOW, CooldownLegendaryPet)
        end)
    end)
end