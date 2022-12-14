modifier_enchantress_natures_attendants_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_enchantress_natures_attendants_lua:IsHidden()
	return false
end

function modifier_enchantress_natures_attendants_lua:IsDebuff()
	return false
end

function modifier_enchantress_natures_attendants_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_enchantress_natures_attendants_lua:OnCreated( kv )
	-- references
	self.count = self:GetAbility():GetSpecialValueFor( "wisp_count" ) -- special value
	self.heal = self:GetAbility():GetSpecialValueFor( "heal" ) -- special value
	self.interval = self:GetAbility():GetSpecialValueFor( "heal_interval" ) -- special value
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" ) -- special value

	if IsServer() then
		self:SetDuration(kv.duration+0.1,false)

		-- Start interval
		self:StartIntervalThink( self.interval )

		-- play effects
		--local sound_cast = "Hero_Enchantress.NaturesAttendantsCast"
		--EmitSoundOn( sound_cast, self:GetParent() )
	end
end

function modifier_enchantress_natures_attendants_lua:OnRefresh( kv )
	-- references
	self.count = self:GetAbility():GetSpecialValueFor( "wisp_count" ) -- special value
	self.heal = self:GetAbility():GetSpecialValueFor( "heal" ) -- special value
	self.interval = self:GetAbility():GetSpecialValueFor( "heal_interval" ) -- special value
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" ) -- special value

	if IsServer() then
		self:SetDuration(kv.duration+0.1,false)
		
		-- Start interval
		self:StartIntervalThink( self.interval )
	end	
end

function modifier_enchantress_natures_attendants_lua:OnDestroy( kv )
	if IsServer() then

		-- stop effects
		local sound_cast = "Hero_Enchantress.NaturesAttendantsCast"
		StopSoundOn( sound_cast, self:GetParent() )
	end
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_enchantress_natures_attendants_lua:OnIntervalThink()
	-- find allies
	local allies = FindUnitsInRadius(
		self:GetParent():GetTeamNumber(),	-- int, your team number
		self:GetParent():GetOrigin(),	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		self.radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_FRIENDLY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
		DOTA_UNIT_TARGET_FLAG_INVULNERABLE,	-- int, flag filter
		0,	-- int, order filter
		false	-- bool, can grow cache
	)

	-- filter full health alliees
	local targets = {}
	for i,ally in pairs(allies) do
		if ally:GetHealthPercent()<100 then
			table.insert( targets, i )
		end
	end
	if #targets<1 then return end
	local n = #targets

	-- heal random target
	for i=1,self.count do
		allies[targets[RandomInt(1,n)]]:Heal( self.heal, self:GetAbility() )
	end
end