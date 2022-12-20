function Spawn( entityKeyValues )
	Timers:CreateTimer(0.1, function()
		if thisEntity == nil then
			return
		end

		if IsServer() == false then
			return
		end

		thisEntity:SetContextThink( "WaveUnitThink", WaveUnitThink, 0.1)
	end)
end

function WaveUnitThink()
    if GameRules:IsGamePaused() or GameRules:State_Get() == DOTA_GAMERULES_STATE_POST_GAME or not thisEntity:IsAlive() then
        return
    end

	if thisEntity:GetAttackTarget() == nil then
		local enemies = FindUnitsInRadius( thisEntity:GetTeamNumber(), thisEntity:GetOrigin(), nil, 99999, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NONE, FIND_CLOSEST, false )
		if #enemies > 0 then
			ExecuteOrderFromTable({
				UnitIndex = thisEntity:entindex(),
				OrderType = DOTA_UNIT_ORDER_ATTACK_TARGET,
				AbilityIndex = nil,
				TargetIndex = enemies[1]:entindex(),
			})
		end
	end
end
