LinkLuaModifier("modifier_auto_cast", "lua_abilities/modifiers/modifier_auto_cast", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_frozen", "lua_abilities/modifiers/modifier_frozen", LUA_MODIFIER_MOTION_NONE)

---------------------------------------------------------------------------
-- Event: OnNPCSpawned
---------------------------------------------------------------------------
function dotacraze:OnNPCSpawned(event)
    local spawned = EntIndexToHScript(event.entindex)

    if not spawned then
        return
    end
  
  if spawned:IsRealHero() and spawned.bFirstspawned == nil then
    spawned.bFirstspawned = true
    dotacraze:OnHeroInGame(spawned)
  end
end

---------------------------------------------------------------------------
-- Event: OnHeroInGame
---------------------------------------------------------------------------
function dotacraze:OnHeroInGame(hero)
  hero:AddNewModifier(hero, nil, "modifier_auto_cast", {})

  local abilities = {
    "bristleback_quill_spray_lua"
  }

  for i = 1, #abilities do
  local current_ability = hero:FindAbilityByName(abilities[i])
    if current_ability then
      current_ability:SetLevel(1)
    end
  end 

  local playerID = hero:GetPlayerID()	
	PlayerResource:SetCameraTarget(playerID, hero)
  Timers:CreateTimer(0.1, function()
    PlayerResource:SetCameraTarget(playerID, hero)
	end)
end

---------------------------------------------------------------------------
-- Event: OnGameRulesStateChange
---------------------------------------------------------------------------
function dotacraze:OnGameRulesStateChange()
  local nNewState = GameRules:State_Get()
  if nNewState == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
    dotacraze:OnGameInProgress()
	  Convars:SetInt("dota_max_physical_items_purchase_limit", 9999)
    Convars:SetInt("dota_max_physical_items_drop_limit", 9999)
  end
end

function dotacraze:OnGameInProgress()
  -- Start spawning creep waves
  --StartSpawning() 
end


---------------------------------------------------------------------------
-- Event: OnPlayerGainedLevel
---------------------------------------------------------------------------
function dotacraze:OnPlayerGainedLevel(eventInfo)
  local hero = PlayerResource:GetSelectedHeroEntity(eventInfo.player_id)

  if eventInfo.level == 2 then
    CustomGameEventManager:Send_ServerToAllClients("player_reached_secondability_level", {})
    hero:AddNewModifier(hero, nil, "modifier_frozen", {})
  end

  if eventInfo.level == 5 then
    hero:SetModel("models/heroes/aghanim/aghanim_model.vmdl")
    hero:SetOriginalModel("models/heroes/aghanim/aghanim_model.vmdl")
    local particle = ParticleManager:CreateParticle( "particles/econ/events/fall_2021/hero_levelup_fall_2021.vpcf", PATTACH_ABSORIGIN_FOLLOW, hero) 
  end

  if eventInfo.level == 10 then
    hero:SetModel("models/heroes/aghanim_barbarian/aghanim_barbarian.vmdl")
    hero:SetOriginalModel("models/heroes/aghanim_barbarian/aghanim_barbarian.vmdl")
    local particle = ParticleManager:CreateParticle( "particles/econ/events/fall_2021/hero_levelup_fall_2021.vpcf", PATTACH_ABSORIGIN_FOLLOW, hero)
    CustomGameEventManager:Send_ServerToAllClients("player_reached_pet_level", {})
    hero:AddNewModifier(hero, nil, "modifier_frozen", {})
  end

  if eventInfo.level == 15 then
    hero:SetModel("models/heroes/aghanim_blacksmith/aghanim_blacksmith.vmdl")
    hero:SetOriginalModel("models/heroes/aghanim_blacksmith/aghanim_blacksmith.vmdl")
    local particle = ParticleManager:CreateParticle( "particles/econ/events/fall_2021/hero_levelup_fall_2021.vpcf", PATTACH_ABSORIGIN_FOLLOW, hero) 
  end

  if eventInfo.level == 20 then
    hero:SetModel("models/heroes/aghanim_goat/aghanim_goat.vmdl")
    hero:SetOriginalModel("models/heroes/aghanim_goat/aghanim_goat.vmdl")
    local particle = ParticleManager:CreateParticle( "particles/econ/events/fall_2021/hero_levelup_fall_2021.vpcf", PATTACH_ABSORIGIN_FOLLOW, hero) 
  end

  if eventInfo.level == 25 then
    hero:SetModel("models/heroes/aghanim_mad_maghs/aghanim_mad_maghs.vmdl")
    hero:SetOriginalModel("models/heroes/aghanim_mad_maghs/aghanim_mad_maghs.vmdl")
    local particle = ParticleManager:CreateParticle( "particles/econ/events/fall_2021/hero_levelup_fall_2021.vpcf", PATTACH_ABSORIGIN_FOLLOW, hero) 
  end

  if eventInfo.level == 30 then
    hero:SetModel("models/heroes/aghanim_mecha/aghanim_mecha.vmdl")
    hero:SetOriginalModel("models/heroes/aghanim_mecha/aghanim_mecha.vmdl")
    local particle = ParticleManager:CreateParticle( "particles/econ/events/fall_2021/hero_levelup_fall_2021.vpcf", PATTACH_ABSORIGIN_FOLLOW, hero) 
  end
end

---------------------------------------------------------------------------
-- Custom Event: CooldownPetEvent
---------------------------------------------------------------------------
function CooldownPetEvent(eventSourceIndex, args)
  local playerID = args.PlayerID
  local hero = PlayerResource:GetPlayer(playerID):GetAssignedHero()
  hero:AddItemByName("item_cooldown_pet_common")
  hero:RemoveModifierByName("modifier_frozen")
end

---------------------------------------------------------------------------
-- Custom Event: ExperiencePetEvent
---------------------------------------------------------------------------
function ExperiencePetEvent(eventSourceIndex, args)
  local playerID = args.PlayerID
  local hero = PlayerResource:GetPlayer(playerID):GetAssignedHero()
  hero:AddItemByName("item_experience_pet_common")
  hero:RemoveModifierByName("modifier_frozen")
end





---------------------------------------------------------------------------
-- Custom Event: Abilities
---------------------------------------------------------------------------
function AbilityEvent1(eventSourceIndex, args)
  local playerID = args.PlayerID
  local hero = PlayerResource:GetPlayer(playerID):GetAssignedHero()
  hero:AddAbility("centaur_warrunner_hoof_stomp_lua")
  hero:RemoveModifierByName("modifier_frozen")
end

function AbilityEvent2(eventSourceIndex, args)
  local playerID = args.PlayerID
  local hero = PlayerResource:GetPlayer(playerID):GetAssignedHero()
  hero:AddAbility("enchantress_natures_attendants_lua")
  hero:RemoveModifierByName("modifier_frozen")
end

function AbilityEvent3(eventSourceIndex, args)
  local playerID = args.PlayerID
  local hero = PlayerResource:GetPlayer(playerID):GetAssignedHero()
  hero:AddAbility("alchemist_acid_spray_lua")
  hero:RemoveModifierByName("modifier_frozen")
end