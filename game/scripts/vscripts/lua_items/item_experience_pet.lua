function ExperiencePetCommon( keys )
    Timers:CreateTimer(0.2, function()
	    local ability = keys.ability
        local owner = ability:GetOwner()
        local CommonPet = CreateUnitByName("unit_experience_pet_common", owner:GetAbsOrigin(), true, nil, nil, DOTA_TEAM_GOODGUYS)
        CommonPet:SetOwner(owner)
        CommonPet:SetTeam(owner:GetTeam())
        local CommonPetParticle = ParticleManager:CreateParticle( "particles/econ/courier/courier_onibi/courier_onibi_green_lvl0_ambient.vpcf", PATTACH_ABSORIGIN_FOLLOW, CommonPet)
    end)
end

function ExperiencePetRare( keys )
    Timers:CreateTimer(0.2, function()
        local ability = keys.ability
        local owner = ability:GetOwner()
        local UnitsList = FindUnitsInRadius(owner:GetTeamNumber(), owner:GetAbsOrigin(), nil, FIND_UNITS_EVERYWHERE, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_INVULNERABLE, FIND_CLOSEST, false)

        for i, PreviousPet in ipairs(UnitsList) do
            if PreviousPet:GetUnitName() == "unit_experience_pet_common" then
                PreviousPet:AddNoDraw()
                PreviousPet:ForceKill(false)
            end
        end

        Timers:CreateTimer(0.2, function()
            local RarePet = CreateUnitByName("unit_experience_pet_rare", owner:GetAbsOrigin(), true, nil, nil, DOTA_TEAM_GOODGUYS)
            RarePet:SetOwner(owner)
            local RarePetParticle = ParticleManager:CreateParticle( "particles/econ/courier/courier_onibi/courier_onibi_pink_lvl13_ambient.vpcf", PATTACH_ABSORIGIN_FOLLOW, RarePet)
        end)
    end)
end

function ExperiencePetMythical( keys )
    Timers:CreateTimer(0.2, function()
        local ability = keys.ability
        local owner = ability:GetOwner()
        local UnitsList = FindUnitsInRadius(owner:GetTeamNumber(), owner:GetAbsOrigin(), nil, FIND_UNITS_EVERYWHERE, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_INVULNERABLE, FIND_CLOSEST, false)

        for i, PreviousPet in ipairs(UnitsList) do
            if PreviousPet:GetUnitName() == "unit_experience_pet_rare" then
                PreviousPet:AddNoDraw()
                PreviousPet:ForceKill(false)
            end
            if PreviousPet:GetUnitName() == "unit_experience_pet_common" then
                PreviousPet:AddNoDraw()
                PreviousPet:ForceKill(false)
            end
        end

        Timers:CreateTimer(0.2, function()
            local MythicalPet = CreateUnitByName("unit_experience_pet_mythical", owner:GetAbsOrigin(), true, nil, nil, DOTA_TEAM_GOODGUYS)
            MythicalPet:SetOwner(owner)
            local MythicalPetParticle = ParticleManager:CreateParticle( "particles/econ/courier/courier_onibi/courier_onibi_pink_lvl13_ambient.vpcf", PATTACH_ABSORIGIN_FOLLOW, MythicalPet)
        end)
    end)
end

function ExperiencePetLegendary( keys )
    Timers:CreateTimer(0.2, function()
        local ability = keys.ability
        local owner = ability:GetOwner()
        local UnitsList = FindUnitsInRadius(owner:GetTeamNumber(), owner:GetAbsOrigin(), nil, FIND_UNITS_EVERYWHERE, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_INVULNERABLE, FIND_CLOSEST, false)

        for i, PreviousPet in ipairs(UnitsList) do
            if PreviousPet:GetUnitName() == "unit_experience_pet_mythical" then
                PreviousPet:AddNoDraw()
                PreviousPet:ForceKill(false)
            end
            if PreviousPet:GetUnitName() == "unit_experience_pet_rare" then
                PreviousPet:AddNoDraw()
                PreviousPet:ForceKill(false)
            end
            if PreviousPet:GetUnitName() == "unit_experience_pet_common" then
                PreviousPet:AddNoDraw()
                PreviousPet:ForceKill(false)
            end
        end

        Timers:CreateTimer(0.2, function()
            local LegendaryPet = CreateUnitByName("unit_experience_pet_legendary", owner:GetAbsOrigin(), true, nil, nil, DOTA_TEAM_GOODGUYS)
            LegendaryPet:SetOwner(owner)
            local LegendaryPetParticle = ParticleManager:CreateParticle( "particles/econ/courier/courier_onibi/courier_onibi_yellow_lvl20_ambient.vpcf", PATTACH_ABSORIGIN_FOLLOW, LegendaryPet)
        end)
    end)
end