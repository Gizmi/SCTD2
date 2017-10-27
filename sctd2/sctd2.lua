--[[
  ****************************************************************
	Scrolling Combat Text - Damage

	****************************************************************]]

--global name
SCTD2 = LibStub("AceAddon-3.0"):NewAddon("SCTD2", "AceEvent-3.0", "AceConsole-3.0", "AceHook-3.0")
local SCTD2 = SCTD2
local SCT2 = SCT2
local db = SCT2.db.profile

SCTD2.title = "sctd2"
SCTD2.version = GetAddOnMetadata(SCTD2.title, "Version")

--embedded libs
local media = LibStub("LibSharedMedia-3.0")

--Add new frame to SCT
SCT2.FRAME3 = 3
SCT2.ArrayAniData[SCT2.FRAME3] = {}
SCT2.ArrayAniCritData[SCT2.FRAME3] = {}

local MSG_Y_OFFSET = 0
local menuloaded = false
local arrMsgData = {
		["MSGTEXT1"] = {size=1, xoffset=0, yoffset=0, align="CENTER", height=5, duration=1},
}

--Blizzard APi calls
local UnitName = UnitName
local PlaySound = PlaySound
local GetSpellInfo = GetSpellInfo

--LUA calls
local _G = _G
local pairs = pairs
local tonumber = tonumber
local string_format = string.format

--combat log locals
local CombatLog_Object_IsA = CombatLog_Object_IsA

local COMBATLOG_OBJECT_NONE = COMBATLOG_OBJECT_NONE
local COMBATLOG_FILTER_MINE = COMBATLOG_FILTER_MINE
local COMBATLOG_FILTER_MY_PET = COMBATLOG_FILTER_MY_PET

local COMBAT_EVENTS = {
  ["SWING_DAMAGE"] = "DAMAGE",
  ["RANGE_DAMAGE"] = "DAMAGE",
  ["SPELL_DAMAGE"] = "DAMAGE",
  ["SPELL_PERIODIC_DAMAGE"] = "DAMAGE",
  ["DAMAGE_SHIELD"] = "DAMAGE",
  ["DAMAGE_SPLIT"] = "DAMAGE",
  ["SWING_MISSED"] = "MISS",
  ["RANGE_MISSED"] = "MISS",
  ["SPELL_MISSED"] = "MISS",
  ["SPELL_PERIODIC_MISSED"] = "MISS",
  ["DAMAGE_SHIELD_MISSED"] = "MISS",
  ["SPELL_INTERRUPT"] = "INTERRUPT",
}

local SCHOOL_STRINGS = {
  [SCHOOL_MASK_PHYSICAL] = SPELL_SCHOOL0_CAP,
  [SCHOOL_MASK_HOLY] = SPELL_SCHOOL1_CAP,
  [SCHOOL_MASK_FIRE] = SPELL_SCHOOL2_CAP,
  [SCHOOL_MASK_NATURE] = SPELL_SCHOOL3_CAP,
  [SCHOOL_MASK_FROST] = SPELL_SCHOOL4_CAP,
  [SCHOOL_MASK_SHADOW] = SPELL_SCHOOL5_CAP,
  [SCHOOL_MASK_ARCANE] = SPELL_SCHOOL6_CAP,
}

local POWER_STRINGS = {
  [SPELL_POWER_MANA] = MANA,
  [SPELL_POWER_RAGE] = RAGE,
  [SPELL_POWER_FOCUS] = FOCUS,
  [SPELL_POWER_ENERGY] = ENERGY,
  [SPELL_POWER_RUNES] = RUNES,
  [SPELL_POWER_RUNIC_POWER] = RUNIC_POWER,
  [SPELL_POWER_SOUL_SHARDS] = SHARDS,
  [SPELL_POWER_LUNAR_POWER] = LUNAR_POWER,
  [SPELL_POWER_HOLY_POWER] = HOLY_POWER,
  [SPELL_POWER_ALTERNATE_POWER] = ALTERNATE_RESOURCE_TEXT,
  [SPELL_POWER_MAELSTROM] = MAELSTROM_POWER,
  [SPELL_POWER_CHI] = CHI_POWER,
  [SPELL_POWER_INSANITY] = INSANITY_POWER,
  --[SPELL_POWER_OBSOLETE] = 14;
  --[SPELL_POWER_OBSOLETE2] = 15;
  [SPELL_POWER_ARCANE_CHARGES] = ARCANE_CHARGES_POWER,
  [SPELL_POWER_FURY] = FURY,
  [SPELL_POWER_PAIN] = PAIN,
}

local default_config = {
		["SCTD2_VERSION"] = SCTD2.version,
		["SCTD2_ENABLED"] = 1,
		["SCTD2_SHOWMELEE"] = 1,
		["SCTD2_SHOWPERIODIC"] = 1,
		["SCTD2_SHOWSPELL"] = 1,
		["SCTD2_SHOWPET"] = 1,
		["SCTD2_SHOWCOLORCRIT"] = false,
		["SCTD2_SHOWDMGSHIELD"] = false,
		["SCTD2_FLAGDMG"] = false,
		["SCTD2_SHOWDMGTYPE"] = false,
		["SCTD2_SHOWSPELLNAME"] = 1,
		["SCTD2_SHOWRESIST"] = 1,
		["SCTD2_SHOWTARGETS"] = false,
		["SCTD2_DMGFONT"] = 1,
		["SCTD2_TARGET"] = false,
		["SCTD2_USESCT"] = 1,
		["SCTD2_STICKYCRIT"] = 1,
		["SCTD2_SPELLCOLOR"] = false,
		["SCTD2_SHOWINTERRUPT"] = 1,
		["SCTD2_NAMEPLATES"] = false,
		["SCTD2_TRUNCATE"] = false,
		["SCTD2_CUSTOMEVENTS"] = 1,
		["SCTD2_DMGFILTER"] = 0,
	}

local default_config_colors = {
		["SCTD2_SHOWMELEE"] = {r = 1.0, g = 1.0, b = 1.0},
		["SCTD2_SHOWPERIODIC"] = {r = 1.0, g =1.0, b = 0.0},
		["SCTD2_SHOWSPELL"] = {r = 1.0, g = 1.0, b = 0.0},
		["SCTD2_SHOWPET"] = {r = 0.6, g = 0.6, b = 0.0},
		["SCTD2_SHOWCOLORCRIT"] = {r = 0.2, g = 0.4, b = 0.6},
		["SCTD2_SHOWINTERRUPT"] = {r = 0.5, g = 0.5, b = 0.7},
		["SCTD2_SHOWDMGSHIELD"] = {r = 0.0, g = 0.5, b = 0.5},
}

local default_frame_config = {
		["FONT"] = "Friz Quadrata TT",
		["FONTSHADOW"] = 2,
		["ALPHA"] = 100,
		["ANITYPE"] = 1,
		["ANISIDETYPE"] = 1,
		["XOFFSET"] = 0,
		["YOFFSET"] = 210,
		["DIRECTION"] = false,
		["TEXTSIZE"] = 24,
		["FADE"] = 1.5,
		["GAPDIST"] = 40,
		["ALIGN"] = 2,
		["ICONSIDE"] = 2,
}

local arrShadowOutline = {
	[1] = "",
	[2] = "OUTLINE",
	[3] = "THICKOUTLINE"
}

----------------------
--Called on login
function SCTD2:OnEnable()
	--check SCT version
	if (not SCT2) or (tonumber(SCT2.version) < 1.0) then
		StaticPopupDialogs["SCTD2_VERSION"] = {
								  text = SCTD2.LOCALS.Version_Warning,
								  button1 = TEXT(OKAY) ,
								  timeout = 0,
								  whileDead = 1,
								  hideOnEscape = 1,
								  showAlert = 1
								}
		StaticPopup_Show("SCTD2_VERSION")
		if (SCT2OptionsFrame_Misc103) then
			SCT2OptionsFrame_Misc103:Hide()
		end
		self:OnDisable()
		return
	end
	self:RegisterSelfEvents()
end

----------------------
-- Disable all events, not using AceDB, but may as well name it right.
function SCTD2:OnDisable()
	-- no more events to handle
	--parser:UnregisterAllEvents("sctd2")
	self:UnregisterAllEvents()
end

----------------------
--Called when addon loaded
function SCTD2:OnInitialize()

	self:RegisterChatCommand("sctd2", function() self:ShowSCTD2Menu() end)
	self:RegisterChatCommand("sctd2menu", function() self:ShowSCTD2Menu() end)

	--register with other mods
	self:RegisterOtherMods()

	--Hook SCT show menu
	self:RawHook(SCT2, "ShowMenu")

	--update old values
	self:UpdateValues()

	--setup msgs
	self:MsgInit()

	--setup damage flags
	self:SetDamageFlags()

	--setup Unit name plate tracking
	if (db["SCTD2_NAMEPLATES"]) then
		self:EnableNameplate()
	end

end

----------------------
-- Show the Option Menu
function SCTD2:ShowSCTD2Menu()
	local loaded, message = LoadAddOn("SCT2_options")
	if (loaded) then
		--if options page exsists (not disabled)
		if (SCTD2Options) then
			--Hook SCT ShowExample
			if (not SCTD2:IsHooked(SCT2, "ShowExample")) then
				SCTD2:RawHook(SCT2, "ShowExample")
			end
			--Hook SCT ShowTest
			if (not SCTD2:IsHooked(SCT2, "ShowTest")) then
				SCTD2:RawHook(SCT2, "ShowTest")
			end
			if not menuloaded then
        SCTD2:MakeBlizzOptions()
        menuloaded = true
      end
			--open sct window
			SCTD2.hooks[SCT2].ShowMenu()
			--open to SCTD2 menu
			InterfaceOptionsFrame_OpenToCategory("SCTD2 "..SCT2.LOCALS.OPTION_MISC104.name)
			--mimic clicking the menu
			--SCTOptionsFrame_Misc103:Click()
			--update animation options
			--SCTD2:UpdateAnimationOptions()
		else
			PlaySound(PlaySoundKitID and "TellMessage" or 3081)
			SCTD2:Print(SCTD2.LOCALS.Load_Error)
		end
	else
		PlaySound(PlaySoundKitID and "TellMessage" or 3081)
		SCTD2:Print(SCT2.LOCALS.Load_Error.." "..message)
	end
end

----------------------
--Reset everything to default for SCTD2
function SCTD2:ShowMenu()
	SCTD2:UpdateValues()
	--open sct menu
	self.hooks[SCT2].ShowMenu()
	--Hook SCT ShowExample
	if (not self:IsHooked(SCT2, "ShowExample") and SCT.ShowExample) then
		self:RawHook(SCT2, "ShowExample")
	end
	--Hook SCTD2 ShowTest
	if (not self:IsHooked(SCT2, "ShowTest") and SCT2.ShowTest) then
		self:RawHook(SCT2, "ShowTest")
	end
end

----------------------
-- display ddl or chxbox based on type
function SCTD2:UpdateAnimationOptions()
	--get scroll down checkbox
	local chkbox = _G["SCT2OptionsFrame_CheckButton113"]
	--get anime type dropdown
	local ddl1 = _G["SCT2OptionsFrame_Selection103"]
	--get animside type dropdown
	local ddl2 = _G["SCT2OptionsFrame_Selection104"]
	--get gap distance silder
	local slide = _G["SCT2OptionsFrame_Slider106"]
	--get subframe
	local subframe = _G["SCTD2AnimationSubFrame"]
	--get item
	local id = UIDropDownMenu_GetSelectedID(ddl1)
	chkbox:ClearAllPoints()
	chkbox:SetPoint("TOPLEFT", "SCT2OptionsFrame_Selection103", "BOTTOMLEFT", 15, 0)
	--reset all scales
	chkbox:SetScale(1)
	ddl2:SetScale(1)
	ddl1:SetScale(1)
	if (id == 1 or id == 6) then
		chkbox:Show()
		ddl2:Hide()
		slide:Hide()
		subframe:SetHeight(80)
	elseif (id == 7 or id == 8) then
		chkbox:ClearAllPoints()
		chkbox:SetPoint("TOPLEFT", "SCT2OptionsFrame_Selection103", "BOTTOMLEFT", 15, -40)
		chkbox:Show()
		ddl2:Show()
		slide:Show()
		subframe:SetHeight(165)
	else
		chkbox:Hide()
		ddl2:Show()
		slide:Hide()
		subframe:SetHeight(90)
	end
end

---------------------
--Show SCT2 Example
function SCTD2:ShowExample(frame, item)
	self.hooks[SCT2].ShowExample(frame, item)
	self:MsgInit()

	--animated example for options that may need it
	local option = item.SCT2Var
	if (option) and (string.find(option,"SCTD2_SHOW")) then
		self:DisplayText(option, self.LOCALS.EXAMPLE)
	end

	--show example FRAME3
	--get object
	example = _G["SCTD2MsgExample1"]
	--set text size
	SCT2:SetFontSize(example,
									db[SCT2.FRAMES_DATA_TABLE][SCT2.FRAME3]["FONT"],
									db[SCT2.FRAMES_DATA_TABLE][SCT2.FRAME3]["TEXTSIZE"],
									db[SCT2.FRAMES_DATA_TABLE][SCT2.FRAME3]["FONTSHADOW"])
	--set the color
	example:SetTextColor(1, 1, 0)
	--set alpha
	example:SetAlpha(db[SCT2.FRAMES_DATA_TABLE][SCT2.FRAME3]["ALPHA"]/100)
	--Position
	example:SetPoint("CENTER", "UIParent", "CENTER",
									 db[SCT2.FRAMES_DATA_TABLE][SCT2.FRAME3]["XOFFSET"],
									 db[SCT2.FRAMES_DATA_TABLE][SCT2.FRAME3]["YOFFSET"])
	--Set the text to display
	example:SetText(self.LOCALS.EXAMPLE)

	--update animation options
	self:UpdateAnimationOptions()
end

---------------------
--Show SCTD2 Test
function SCTD2:ShowTest()
	local color = {r=1,g=1,b=1}
	self.hooks[SCT2].ShowTest()
	if (db["SCTD2_USESCT"]) then
			SCT2:DisplayText(self.LOCALS.EXAMPLE, color, nil, "damage", SCT2.FRAME3, nil, nil, "Interface\\Icons\\INV_Misc_QuestionMark")
	else
		self:SetMsgFont(SCTD2_MSGTEXT1)
		SCTD2_MSGTEXT1:AddMessage(self.LOCALS.EXAMPLE, color.r, color.g, color.b, 1)
	end
end

----------------------
--Update old values for new versions
function SCTD2:UpdateValues()
	local i, var
	db = SCT2.db.profile
	--set defaults
	for i, _ in pairs(default_config) do
		if(db[i] == nil) then
			db[i] = default_config[i]
		end
	end
	--set colors
	for i,_ in pairs(default_config_colors) do
		var = db[SCT2.COLORS_TABLE][i] or default_config_colors[i]
		db[SCT2.COLORS_TABLE][i] = var
	end
	--set frame data
	if (not db[SCT2.FRAMES_DATA_TABLE][SCT2.FRAME3]) then
		db[SCT2.FRAMES_DATA_TABLE][SCT2.FRAME3] = {}
	end
	for i,_ in pairs(default_frame_config) do
		if (db[SCT2.FRAMES_DATA_TABLE][SCT2.FRAME3][i] == nil) then
			db[SCT2.FRAMES_DATA_TABLE][SCT2.FRAME3][i] = default_frame_config[i]
		end
	end
end

----------------------
-- Parses all combat events using combat log events
function SCTD2:ParseCombat(larg1, timestamp, event, hideCaster, sourceGUID, sourceName, sourceFlags, sourceFlags2, destGUID, destName, destFlags, destFlags2, ...)

	local etype = COMBAT_EVENTS[event]
  if not etype then return end

  local toPlayer, fromPlayer, toPet, fromPet
  if (sourceName and not CombatLog_Object_IsA(sourceFlags, COMBATLOG_OBJECT_NONE) ) then
    fromPlayer = CombatLog_Object_IsA(sourceFlags, COMBATLOG_FILTER_MINE)
    fromPet = CombatLog_Object_IsA(sourceFlags, COMBATLOG_FILTER_MY_PET)
  end

  --if not from player or pet, then end
  if not fromPlayer and not fromPet then return end

  local healtot, healamt, parent
  local amount, overDamage, school, resisted, blocked, absorbed, critical, glancing, crushing
  local spellId, spellName, spellSchool, missType, powerType, extraAmount, environmentalType, extraSpellId, extraSpellName, extraSpellSchool
  local text, texture, message, inout, color

	------------damage----------------
  if etype == "DAMAGE" then
    if event == "SWING_DAMAGE" then
      amount, overDamage, school, resisted, blocked, absorbed, critical, glancing, crushing = select(1, ...)
    else
      spellId, spellName, spellSchool, amount, overDamage, school, resisted, blocked, absorbed, critical, glancing, crushing = select(1, ...)
      texture = select(3, GetSpellInfo(spellId))
    end
    text = tostring(SCT2:ShortenValue(amount))

    if (amount < db["SCTD2_DMGFILTER"]) then return end
    if (crushing and db["SHOWGLANCE"]) then text = SCT2.LOCALS.Crushchar..text..SCT2.LOCALS.Crushchar end
    if (glancing and db["SHOWGLANCE"]) then text = SCT2.LOCALS.Glancechar..text..SCT2.LOCALS.Glancechar end
    if (blocked) then text = string_format("%s (%d)", text, SCT2:ShortenValue(blocked)) end
    if (absorbed) then text = string_format("%s (%d)", text, SCT2:ShortenValue(absorbed)) end
    if (event == "SWING_DAMAGE" or event == "RANGE_DAMAGE") and school == SCHOOL_MASK_PHYSICAL  then
      if fromPlayer then
        self:DisplayText("SCTD2_SHOWMELEE", text, critical, nil, nil, destName, nil, nil, destFlags, destGUID)
      elseif fromPet then
        self:DisplayText("SCTD2_SHOWPET", text, critical, SCHOOL_STRINGS[school], resisted, destName, PET, nil, destFlags, destGUID)
      end
    else
      local etype
      if fromPet then
        etype = "SCTD2_SHOWPET"
      elseif event == "SPELL_PERIODIC_DAMAGE" then
        etype = "SCTD2_SHOWPERIODIC"
      elseif event == "DAMAGE_SHIELD" then
        etype = "SCTD2_SHOWDMGSHIELD"
      else
        etype = "SCTD2_SHOWSPELL"
      end
      if school == SCHOOL_MASK_PHYSICAL then school = 0 end
      self:DisplayText(etype, text, critical, SCHOOL_STRINGS[school], resisted, destName, spellName, texture, destFlags, destGUID)
    end

  ------------misses----------------
  elseif etype == "MISS" then
    local etype, miss
    if event == "SWING_MISSED" or event == "RANGE_MISSED" then
      missType = select(1, ...)
      etype = "SCTD2_SHOWMELEE"
    else
      spellId, spellName, spellSchool, missType = select(1, ...)
      texture = select(3, GetSpellInfo(spellId))
      etype = "SCTD2_SHOWSPELL"
    end
    if fromPet then etype = "SCTD2_SHOWPET" end
    miss = _G[missType]
    if miss then
      self:DisplayText(etype, miss, nil, nil, nil, destName, spellName, texture, destFlags, destGUID)
    end
  ------------interrupts----------------
  elseif etype == "INTERRUPT" then
    spellId, spellName, spellSchool, extraSpellId, extraSpellName, extraSpellSchool = select(1, ...)
    texture = select(3, GetSpellInfo(extraSpellId))
    self:DisplayText("SCTD2_SHOWINTERRUPT", SCT2.LOCALS.Interrupted, nil, nil, nil, destName, extraSpellName, texture, destFlags, destGUID)
	end
end

----------------------
--Display for mainly combat events
--Mainly used for short messages
function SCTD2:DisplayText(option, msg1, crit, damagetype, resisted, target, spell, icon, destFlags, destGUID)
	local rbgcolor, showcrit, showmsg, adat, parent
	--if option is on
	if (db[option]) then
		--if show only target
		if (db["SCTD2_TARGET"]) then
			if (target ~= UnitName("target")) then
				return
			end
		end
		--get options
		rbgcolor = db[SCT2.COLORS_TABLE][option]
		--if damage type
		if ((damagetype) and (db["SCTD2_SHOWDMGTYPE"])) then
			msg1 = msg1.." "..damagetype
		end
		--if spell color
		if ((damagetype) and (db["SCTD2_SPELLCOLOR"])) then
			rbgcolor = db[SCT2.SPELL_COLORS_TABLE][damagetype] or rbgcolor
		end
		--if resisted
		if ((resisted) and (db["SCTD2_SHOWRESIST"])) then
			msg1 = string_format("%s {%d}", msg1, resisted)
		end
		--if target label
		if ((target) and (db["SCTD2_SHOWTARGETS"])) then
			msg1 = target..": "..msg1
		end
		--if spell
		if ((spell) and (db["SCTD2_SHOWSPELLNAME"])) then
			msg1 = msg1.." "..SCTD2:ShortenString(spell)..""
		end
		--if flag
		if (db["SCTD2_FLAGDMG"]) then
			msg1 = self.LOCALS.SelfFlag..msg1..self.LOCALS.SelfFlag
		end
		--get parent nameplate, if any
		if (db["SCTD2_NAMEPLATES"] and destFlags) then
			--parent = SCT2:GetNameplate(SCT2:CleanName(target, destFlags))
			parent = SCT2:GetNameplate(destGUID)
		end
		--if crit
		if (crit) then
			if (db["SCTD2_SHOWCOLORCRIT"]) then
				rbgcolor = db[SCT2.COLORS_TABLE]["SCTD2_SHOWCOLORCRIT"]
			end
			self:Display_Crit_Damage( msg1, rbgcolor, parent, icon )
		else
			self:Display_Damage( msg1, rbgcolor, parent, icon )
		end

	end
end


----------------------
--Displays a message at the top of the screen
function SCTD2:Display_Damage(msg, color, parent, icon)
	if (db["SCTD2_USESCT"]) then
			SCT2:DisplayText(msg, color, nil, "damage", SCT2.FRAME3, nil, parent, icon)
	else
		self:SetMsgFont(SCTD2_MSGTEXT1)
		SCTD2_MSGTEXT1:AddMessage(msg, color.r, color.g, color.b, 1)
	end
end

----------------------
--Displays a message at the top of the screen
function SCTD2:Display_Crit_Damage(msg, color, parent, icon)
	if (db["SCTD2_STICKYCRIT"]) then
		SCT2:DisplayText(msg, color, 1, "damage", SCT2.FRAME3, nil, parent, icon)
	elseif (db["SCTD2_USESCT"]) then
		SCT2:DisplayText("+"..msg.."+", color, nil, "damage", SCT2.FRAME3, nil, parent, icon)
	else
		self:SetMsgFont(SCTD2_MSGTEXT1)
		SCTD2_MSGTEXT1:AddMessage("+"..msg.."+", color.r, color.g, color.b, 1)
	end
end

------------------------
--Setup msg arrays
function SCTD2:MsgInit()
	for key, value in pairs(arrMsgData) do
		value.FObject = _G["SCTD2_"..key]
		--reset size of allow 5 messages
		value.FObject:SetHeight(db[SCT2.FRAMES_DATA_TABLE][SCT2.FRAME3]["TEXTSIZE"] * 6)
		--Set Fade Duration
		value.FObject:SetFadeDuration(1)
		--set offset to center
		MSG_Y_OFFSET = value.FObject:GetHeight()/2
		value.FObject:SetPoint("CENTER", "UIParent", "CENTER",
													 db[SCT2.FRAMES_DATA_TABLE][SCT2.FRAME3]["XOFFSET"],
													 db[SCT2.FRAMES_DATA_TABLE][SCT2.FRAME3]["YOFFSET"] + MSG_Y_OFFSET)
		value.FObject:SetTimeVisible(db[SCT2.FRAMES_DATA_TABLE][SCT2.FRAME3]["FADE"] or 1.5)
		--set font
		self:SetMsgFont(value.FObject)
	end
end

------------------------
--Setup Damage Flags based on Options
function SCTD2:SetDamageFlags()
	--set WoW Damage Flags
	if (db["SCTD2_DMGFONT"]) then
		SetCVar("floatingCombatTextCombatDamage", 0)
	else
		SetCVar("floatingCombatTextCombatDamage", 1)
	end
end

----------------------
--Start Nameplate tracking
function SCTD2:EnableNameplate()
	SetCVar("nameplateShowEnemies", 1)
	SCT2:EnableNameplate()
end

----------------------
--Stop Nameplate tracking
function SCTD2:DisableNameplate()
	SetCVar("nameplateShowEnemies", 0)
	SCT2:DisableNameplate()
end

----------------------
--shorten string using SCT2 settings
function SCTD2:ShortenString(strString)
	if (db["SCTD2_TRUNCATE"]) then
		return SCT2:ShortenString(strString)
	else
		return strString
	end
end

-------------------------
--Set the font of an object using msg vars
function SCTD2:SetMsgFont(object)
	--set font
	object:SetFont(media:Fetch("font",db[SCT2.FRAMES_DATA_TABLE][SCT2.FRAME3]["FONT"]),
								 db[SCT2.FRAMES_DATA_TABLE][SCT2.FRAME3]["TEXTSIZE"],
								 arrShadowOutline[db[SCT2.FRAMES_DATA_TABLE][SCT2.FRAME3]["FONTSHADOW"]])
end

----------------------
--Register All Events
function SCTD2:RegisterSelfEvents()
  self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED","ParseCombat")
end

-------------------------
--Regsiter SCTD2 with other mods
function SCTD2:RegisterOtherMods()
  local frame = CreateFrame("FRAME", nil)
  frame:SetScript("OnShow",function() SCTD2:ShowSCTD2Menu() end)
  frame.name = "SCTD2"

  InterfaceOptions_AddCategory(frame);
end