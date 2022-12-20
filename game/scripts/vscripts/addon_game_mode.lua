if dotacraze == nil then
	_G.dotacraze = class({})
end

require("libraries/timers")
require("libraries/notifications")
require("libraries/projectiles")
require("libraries/animations")
require("libraries/utility_functions")
require("waves/wave_controller")
require("precache")
require("events")

function Precache( context )
	for _,Item in pairs( g_ItemPrecache ) do
    	PrecacheItemByNameSync( Item, context )
    end

	for _,Model in pairs( g_ModelPrecache ) do
		PrecacheResource( "model", Model, context )
	end

	for _,Particle in pairs( g_ParticlePrecache ) do
		PrecacheResource( "particle", Particle, context )
	end

	for _,ParticleFolder in pairs( g_ParticleFolderPrecache ) do
		PrecacheResource( "particle_folder", Particle, context )
	end

	for _,Sound in pairs( g_SoundPrecache ) do
		PrecacheResource( "soundfile", Sound, context )
	end
end


function Activate()
	GameRules.dotacraze = dotacraze()
	GameRules.dotacraze:InitGameMode()
end

function dotacraze:InitGameMode()
	-- Handle Team Colors
	self.m_TeamColors = {}
	self.m_TeamColors[DOTA_TEAM_GOODGUYS] = { 178, 34, 34 }		--		Red
	self.m_TeamColors[DOTA_TEAM_BADGUYS]  = { 0, 100, 0 }		--		Green
	self.m_TeamColors[DOTA_TEAM_CUSTOM_1] = { 30, 144, 225 }	--      Blue
	self.m_TeamColors[DOTA_TEAM_CUSTOM_2] = { 212, 212, 37 }	--		Yellow
	self.m_TeamColors[DOTA_TEAM_CUSTOM_3] = { 0, 0, 0 }	--		
	self.m_TeamColors[DOTA_TEAM_CUSTOM_4] = { 0, 0, 0 }	--		
	self.m_TeamColors[DOTA_TEAM_CUSTOM_5] = { 0, 0, 0 }	--
	self.m_TeamColors[DOTA_TEAM_CUSTOM_6] = { 0, 0, 0 }	--
	self.m_TeamColors[DOTA_TEAM_CUSTOM_7] = { 0, 0, 0 }	--
	self.m_TeamColors[DOTA_TEAM_CUSTOM_8] = { 0, 0, 0 }	--

	-- Handle Player Colors
	PLAYER_COLORS = {}
    PLAYER_COLORS[0] = "#cc2727;"
    PLAYER_COLORS[1] = "#0ba30b;"
    PLAYER_COLORS[2] = "#259ef5;"
    PLAYER_COLORS[3] = "#e3e332;"
    PLAYER_COLORS[4] = "#ffffff;"
    PLAYER_COLORS[5] = "#ffffff;"
    PLAYER_COLORS[6] = "#ffffff;"
    PLAYER_COLORS[7] = "#ffffff;"
    PLAYER_COLORS[8] = "#ffffff;"
    PLAYER_COLORS[9] = "#ffffff;"

	for team = 0, (DOTA_TEAM_COUNT-1) do
		color = self.m_TeamColors[ team ]
		if color then
			SetTeamCustomHealthbarColor( team, color[1], color[2], color[3] )
		end
	end

	self.m_VictoryMessages = {}
	self.m_VictoryMessages[DOTA_TEAM_GOODGUYS] = "#VictoryMessage_GoodGuys"
	self.m_VictoryMessages[DOTA_TEAM_BADGUYS]  = "#VictoryMessage_BadGuys"
	self.m_VictoryMessages[DOTA_TEAM_CUSTOM_1] = "#VictoryMessage_Custom1"
	self.m_VictoryMessages[DOTA_TEAM_CUSTOM_2] = "#VictoryMessage_Custom2"
	self.m_VictoryMessages[DOTA_TEAM_CUSTOM_3] = "#VictoryMessage_Custom3"
	self.m_VictoryMessages[DOTA_TEAM_CUSTOM_4] = "#VictoryMessage_Custom4"
	self.m_VictoryMessages[DOTA_TEAM_CUSTOM_5] = "#VictoryMessage_Custom5"
	self.m_VictoryMessages[DOTA_TEAM_CUSTOM_6] = "#VictoryMessage_Custom6"
	self.m_VictoryMessages[DOTA_TEAM_CUSTOM_7] = "#VictoryMessage_Custom7"
	self.m_VictoryMessages[DOTA_TEAM_CUSTOM_8] = "#VictoryMessage_Custom8"

	-- Game Rules
	GameRules:SetCustomGameAllowMusicAtGameStart(false)
	GameRules:SetCustomGameAllowBattleMusic(false)
	GameRules:SetCustomGameAllowHeroPickMusic(false)
	GameRules:EnableCustomGameSetupAutoLaunch(true)
	GameRules:SetSameHeroSelectionEnabled(true)
	GameRules:SetHideKillMessageHeaders(true)
	GameRules:LockCustomGameSetupTeamAssignment(true)
	GameRules:SetUseUniversalShopMode(true)
	GameRules:SetHeroRespawnEnabled(false)
	GameRules:SetSafeToLeave(true)
	GameRules:SetCustomGameSetupAutoLaunchDelay(0)
	GameRules:SetCustomGameEndDelay(15)
	GameRules:SetHeroSelectionTime(0)
	GameRules:SetPreGameTime(0)
	GameRules:SetStrategyTime(0)
	GameRules:SetShowcaseTime(0)
	GameRules:SetGoldTickTime(0)
	GameRules:SetStartingGold(0) -- default 150
	GameRules:SetGoldPerTick(0)
	GameRules:SetTimeOfDay(0.751)

	-- Gamemode Rules
	local GameMode = GameRules:GetGameModeEntity()
	GameMode:SetUseCustomHeroLevels(false)
	--GameMode:SetCustomXPRequiredToReachNextLevel(XP_PER_LEVEL_TABLE)
	GameMode:DisableHudFlip(true)
	GameMode:SetBuybackEnabled(false)
	GameMode:SetFogOfWarDisabled(true)
	GameMode:SetUnseenFogOfWarEnabled(false)
	GameMode:SetLoseGoldOnDeath(false)
	GameMode:SetAnnouncerDisabled(true)
	GameMode:SetDeathOverlayDisabled(false)
	GameMode:SetDaynightCycleDisabled(true)
	GameMode:SetWeatherEffectsDisabled(false)
	GameMode:SetRemoveIllusionsOnDeath(true)
	GameMode:SetStashPurchasingDisabled(true)
	GameMode:SetTopBarTeamValuesVisible(false)
	GameMode:SetTopBarTeamValuesOverride(true)
	GameMode:SetRecommendedItemsDisabled(true)
	GameMode:SetSelectionGoldPenaltyEnabled(false)
	GameMode:SetKillingSpreeAnnouncerDisabled(true)
	GameMode:SetCustomGameForceHero("npc_dota_hero_aghanim_custom")
	--GameMode:SetTPScrollSlotItemOverride("item_blink")

	MAX_NUMBER_OF_TEAMS = 2   
	CUSTOM_TEAM_PLAYER_COUNT = {}        
	CUSTOM_TEAM_PLAYER_COUNT[DOTA_TEAM_GOODGUYS] = 1
	CUSTOM_TEAM_PLAYER_COUNT[DOTA_TEAM_BADGUYS]  = 1

	local count = 0
	for team,number in pairs(CUSTOM_TEAM_PLAYER_COUNT) do
		if count >= MAX_NUMBER_OF_TEAMS then
			GameRules:SetCustomGameTeamMaxPlayers(team, 0)
		else
			GameRules:SetCustomGameTeamMaxPlayers(team, number)
		end
		count = count + 1
	end

	if IsInToolsMode() then
		GameRules:SetStartingGold(99999)
   end

   -- Events
	ListenToGameEvent("npc_spawned", Dynamic_Wrap(dotacraze, "OnNPCSpawned"), self)
	ListenToGameEvent('game_rules_state_change', Dynamic_Wrap( dotacraze, 'OnGameRulesStateChange' ), self )
	ListenToGameEvent('dota_player_gained_level', Dynamic_Wrap( dotacraze, 'OnPlayerGainedLevel' ), self )

	-- Custom Events
	CustomGameEventManager:RegisterListener('CooldownPetButtonPressed', CooldownPetEvent)
	CustomGameEventManager:RegisterListener('ExperiencePetButtonPressed', ExperiencePetEvent)

	CustomGameEventManager:RegisterListener('Ability1Selected', AbilityEvent1)
	CustomGameEventManager:RegisterListener('Ability2Selected', AbilityEvent2)
	CustomGameEventManager:RegisterListener('Ability3Selected', AbilityEvent3)
end
