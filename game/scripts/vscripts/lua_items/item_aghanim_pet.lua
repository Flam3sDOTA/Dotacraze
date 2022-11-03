function AghanimPetAncient ( keys )
    Timers:CreateTimer(0.2, function()
        local ability = keys.ability
        local owner = ability:GetOwner()
        local UnitsList = FindUnitsInRadius(owner:GetTeamNumber(), owner:GetAbsOrigin(), nil, FIND_UNITS_EVERYWHERE, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_INVULNERABLE, FIND_CLOSEST, false)

        for i, PreviousPet in ipairs(UnitsList) do
            if PreviousPet:GetUnitName() == "unit_cooldown_pet_mythical" then
                PreviousPet:AddNoDraw()
                PreviousPet:ForceKill(false)
            end
            if PreviousPet:GetUnitName() == "unit_experience_pet_mythical" then
                PreviousPet:AddNoDraw()
                PreviousPet:ForceKill(false)
            end
            if PreviousPet:GetUnitName() == "unit_cooldown_pet_legendary" then
                PreviousPet:AddNoDraw()
                PreviousPet:ForceKill(false)
            end
            if PreviousPet:GetUnitName() == "unit_experience_pet_legendary" then
                PreviousPet:AddNoDraw()
                PreviousPet:ForceKill(false)
            end
        end

        Timers:CreateTimer(0.2, function()
            local AghanimPetAncient = CreateUnitByName("unit_aghanim_pet_ancient", owner:GetAbsOrigin(), true, nil, nil, DOTA_TEAM_GOODGUYS)
            AghanimPetAncient:SetOwner(owner)
        end)
    end)
end