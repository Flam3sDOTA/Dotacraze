function Spawn( entityKeyValues )
	Timers:CreateTimer(0.1, function()
		if thisEntity == nil then
			return
		end

		if IsServer() == false then
			return
		end

		thisEntity:SetContextThink( "PetThink", PetThink, 0.1)
	end)
end

function PetThink()
    if GameRules:IsGamePaused() or GameRules:State_Get() == DOTA_GAMERULES_STATE_POST_GAME or not thisEntity:IsAlive() then
        return
    end

	local owner = PlayerResource:GetSelectedHeroEntity(thisEntity:GetPlayerOwnerID())
	local distance = (thisEntity:GetAbsOrigin() - owner:GetAbsOrigin()):Length2D()
	if distance > 200 then
		ExecuteOrderFromTable({
			UnitIndex = thisEntity:entindex(),
			OrderType = DOTA_UNIT_ORDER_MOVE_TO_POSITION,
			Position = owner:GetAbsOrigin() + Vector(-150,-115,0)
		})
	end
    return 0.1
end