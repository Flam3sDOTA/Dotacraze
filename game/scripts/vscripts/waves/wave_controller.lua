local wave_table = require("waves/wave_tables")
local CURRENT_WAVE = 0
local TIME_BETWEEN_ROUNDS = 25
local TIME_BEFORE_FIRST_ROUND = 0
local NUM_ROUNDS = TableCount(wave_table)

function StartSpawning()
  local timeToNextRound = TIME_BEFORE_FIRST_ROUND
  Timers:CreateTimer(function()
    CustomGameEventManager:Send_ServerToAllClients("next_round_time_changed", {seconds = timeToNextRound})
    timeToNextRound = timeToNextRound - 1

    if timeToNextRound <= 0 then
    	SpawnNextWave()
    	return
    end

    return 1
  end)
end

function SpawnNextWave()
  CURRENT_WAVE = CURRENT_WAVE + 1

  local waveData = wave_table["wave" .. CURRENT_WAVE]
  if not waveData then
    -- start over from the start
    local waveNumber = CURRENT_WAVE % NUM_ROUNDS
    if waveNumber == 0 then
      waveNumber = 2
    end
    waveData = wave_table["wave" .. waveNumber]
  end

  local ascension = math.floor((CURRENT_WAVE - 1) / NUM_ROUNDS)
  CustomGameEventManager:Send_ServerToAllClients("round_started", 
    {
      round_type = waveData.round_type,
      round_number = CURRENT_WAVE,
      unit_count = waveData.wave_count,
    }
  )
  
  local waveDuration = waveData.wave_count * waveData.spawn_interval
  local timeToNextRound = waveDuration + TIME_BETWEEN_ROUNDS

  Timers:CreateTimer(function()
    timeToNextRound = timeToNextRound - 1
    CustomGameEventManager:Send_ServerToAllClients("next_round_time_changed", {seconds = timeToNextRound})
    if timeToNextRound <= 0 then
    	SpawnNextWave()
    	return
    end
    return 1
  end)
  
  -- Get the team for each hero (assume there is one hero per player)
  for _,hero in pairs(HeroList:GetAllHeroes()) do
    if hero:IsAlive() then
      SpawnWave(hero, waveData, ascension)
    end
  end
end

function SpawnWave(hero, waveData, ascension)
  local creepName = waveData.unit_name
  local numToSpawn = waveData.wave_count
  local spawnInterval = waveData.spawn_interval
  local round_type = waveData.round_type
  local spawned = 0

  Timers:CreateTimer(function()
    if spawned >= numToSpawn then return end

	for i=1,4 do
		local spawnpoint = Entities:FindByName(nil, "SpawnPoint" .. i):GetAbsOrigin()
		local creep = CreateUnitByName(creepName, spawnpoint, true, nil, nil, DOTA_TEAM_NEUTRALS)
    	creep:CreatureLevelUp(ascension)

		if round_type == "Boss" then
			--local particle = ParticleManager:CreateParticle( "particles/creep_effects/overhead_boss.vpcf", PATTACH_OVERHEAD_FOLLOW, creep)
			--ParticleManager:SetParticleControl(particle, 0, creep:GetOrigin())
			--ParticleManager:SetParticleControl(particle, 3, creep:GetOrigin())
		elseif round_type == "Normal" then
			--creep.leakDamage = 1
		elseif round_type == "Bonus" then
			--creep.leakDamage = 0
			--local particle = ParticleManager:CreateParticle( "particles/creep_effects/overhead_bonus.vpcf", PATTACH_OVERHEAD_FOLLOW, creep)
			--ParticleManager:SetParticleControl(particle, 0, creep:GetOrigin())
			--ParticleManager:SetParticleControl(particle, 3, creep:GetOrigin())
		end
	end

    spawned = spawned + 1

    return spawnInterval
  end)
end