--The Options Page variables and functions

--check SCT2 version
if (not SCT2) or (tonumber(SCT2.version) < 1.0) then
	StaticPopup_Show("SCTD2_VERSION");
	if (SCT2OptionsFrame_Misc103) then
		SCT2OptionsFrame_Misc103:Hide();
	end
	return;
end

--add tab to SCT2 tab table
SCT2.OptionFrames["SCT2OptionsFrame_Misc103"] = "SCTD2Options";

SCTD2.OptionFrames = {["SCT2OptionsFrame_Misc104"] = "SCTD2Options_EventsFrame",
										 ["SCT2OptionsFrame_Misc105"] = "SCTD2Options_DisplayFrame",
										 ["SCT2OptionsFrame_Misc106"] = "SCTD2Options_FrameFrame"}

--Event and Damage option values
SCT2.OPTIONS.FrameEventFrames [SCT2.LOCALS.OPTION_EVENT101.name] = { index = 101, tooltipText = SCT2.LOCALS.OPTION_EVENT101.tooltipText, SCT2Var = "SCTD2_SHOWMELEE"};
SCT2.OPTIONS.FrameEventFrames [SCT2.LOCALS.OPTION_EVENT102.name] = { index = 102, tooltipText = SCT2.LOCALS.OPTION_EVENT102.tooltipText, SCT2Var = "SCTD2_SHOWPERIODIC"};
SCT2.OPTIONS.FrameEventFrames [SCT2.LOCALS.OPTION_EVENT103.name] = { index = 103, tooltipText = SCT2.LOCALS.OPTION_EVENT103.tooltipText, SCT2Var = "SCTD2_SHOWSPELL"};
SCT2.OPTIONS.FrameEventFrames [SCT2.LOCALS.OPTION_EVENT104.name] = { index = 104, tooltipText = SCT2.LOCALS.OPTION_EVENT104.tooltipText, SCT2Var = "SCTD2_SHOWPET"};
SCT2.OPTIONS.FrameEventFrames [SCT2.LOCALS.OPTION_EVENT105.name] = { index = 105, tooltipText = SCT2.LOCALS.OPTION_EVENT105.tooltipText, SCT2Var = "SCTD2_SHOWCOLORCRIT"};
SCT2.OPTIONS.FrameEventFrames [SCT2.LOCALS.OPTION_EVENT106.name] = { index = 106, tooltipText = SCT2.LOCALS.OPTION_EVENT106.tooltipText, SCT2Var = "SCTD2_SHOWINTERRUPT"};
SCT2.OPTIONS.FrameEventFrames [SCT2.LOCALS.OPTION_EVENT107.name] = { index = 107, tooltipText = SCT2.LOCALS.OPTION_EVENT107.tooltipText, SCT2Var = "SCTD2_SHOWDMGSHIELD"};

--Check Button option values
SCT2.OPTIONS.FrameCheckButtons [SCT2.LOCALS.OPTION_CHECK101.name] = { index = 101, tooltipText = SCT2.LOCALS.OPTION_CHECK101.tooltipText, SCT2Var = "SCTD2_ENABLED"};
SCT2.OPTIONS.FrameCheckButtons [SCT2.LOCALS.OPTION_CHECK102.name] = { index = 102, tooltipText = SCT2.LOCALS.OPTION_CHECK102.tooltipText, SCT2Var = "SCTD2_FLAGDMG"};
SCT2.OPTIONS.FrameCheckButtons [SCT2.LOCALS.OPTION_CHECK103.name] = { index = 103, tooltipText = SCT2.LOCALS.OPTION_CHECK103.tooltipText, SCT2Var = "SCTD2_SHOWDMGTYPE"};
SCT2.OPTIONS.FrameCheckButtons [SCT2.LOCALS.OPTION_CHECK104.name] = { index = 104, tooltipText = SCT2.LOCALS.OPTION_CHECK104.tooltipText, SCT2Var = "SCTD2_SHOWSPELLNAME"};
SCT2.OPTIONS.FrameCheckButtons [SCT2.LOCALS.OPTION_CHECK105.name] = { index = 105, tooltipText = SCT2.LOCALS.OPTION_CHECK105.tooltipText, SCT2Var = "SCTD2_SHOWRESIST"}
SCT2.OPTIONS.FrameCheckButtons [SCT2.LOCALS.OPTION_CHECK106.name] = { index = 106, tooltipText = SCT2.LOCALS.OPTION_CHECK106.tooltipText, SCT2Var = "SCTD2_SHOWTARGETS"};
SCT2.OPTIONS.FrameCheckButtons [SCT2.LOCALS.OPTION_CHECK107.name] = { index = 107, tooltipText = SCT2.LOCALS.OPTION_CHECK107.tooltipText, SCT2Var = "SCTD2_DMGFONT"};
SCT2.OPTIONS.FrameCheckButtons [SCT2.LOCALS.OPTION_CHECK108.name] = { index = 108, tooltipText = SCT2.LOCALS.OPTION_CHECK108.tooltipText, SCT2Var = "SCTD2_TARGET"};
SCT2.OPTIONS.FrameCheckButtons [SCT2.LOCALS.OPTION_CHECK109.name] = { index = 109, tooltipText = SCT2.LOCALS.OPTION_CHECK109.tooltipText, SCT2Var = "SCTD2_NAMEPLATES"};
SCT2.OPTIONS.FrameCheckButtons [SCT2.LOCALS.OPTION_CHECK110.name] = { index = 110, tooltipText = SCT2.LOCALS.OPTION_CHECK110.tooltipText, SCT2Var = "SCTD2_USESCT"};
SCT2.OPTIONS.FrameCheckButtons [SCT2.LOCALS.OPTION_CHECK111.name] = { index = 111, tooltipText = SCT2.LOCALS.OPTION_CHECK111.tooltipText, SCT2Var = "SCTD2_STICKYCRIT"};
SCT2.OPTIONS.FrameCheckButtons [SCT2.LOCALS.OPTION_CHECK112.name] = { index = 112, tooltipText = SCT2.LOCALS.OPTION_CHECK112.tooltipText, SCT2Var = "SCTD2_SPELLCOLOR"};
SCT2.OPTIONS.FrameCheckButtons [SCT2.LOCALS.OPTION_CHECK113.name] = { index = 113, tooltipText = SCT2.LOCALS.OPTION_CHECK113.tooltipText, SCT2Var = "DIRECTION", SCT2Table = SCT2.FRAME3};
SCT2.OPTIONS.FrameCheckButtons [SCT2.LOCALS.OPTION_CHECK114.name] = { index = 114, tooltipText = SCT2.LOCALS.OPTION_CHECK114.tooltipText, SCT2Var = "SCTD2_TRUNCATE"};
SCT2.OPTIONS.FrameCheckButtons [SCT2.LOCALS.OPTION_CHECK115.name] = { index = 115, tooltipText = SCT2.LOCALS.OPTION_CHECK115.tooltipText, SCT2Var = "SCTD2_CUSTOMEVENTS"};

--Slider options values
SCT2.OPTIONS.FrameSliders [SCT2.LOCALS.OPTION_SLIDER101.name] = { index = 101, SCT2Var = "XOFFSET", minValue = -600, maxValue = 600, valueStep = 10, minText=SCT2.LOCALS.OPTION_SLIDER101.minText, maxText=SCT2.LOCALS.OPTION_SLIDER101.maxText, tooltipText = SCT2.LOCALS.OPTION_SLIDER101.tooltipText, SCT2Table = SCT2.FRAME3};
SCT2.OPTIONS.FrameSliders [SCT2.LOCALS.OPTION_SLIDER102.name] = { index = 102, SCT2Var = "YOFFSET", minValue = -400, maxValue = 400, valueStep = 10, minText=SCT2.LOCALS.OPTION_SLIDER102.minText, maxText=SCT2.LOCALS.OPTION_SLIDER102.maxText, tooltipText = SCT2.LOCALS.OPTION_SLIDER102.tooltipText, SCT2Table = SCT2.FRAME3};
SCT2.OPTIONS.FrameSliders [SCT2.LOCALS.OPTION_SLIDER103.name] = { index = 103, SCT2Var = "FADE", minValue = 1, maxValue = 3, valueStep = .5, minText=SCT2.LOCALS.OPTION_SLIDER103.minText, maxText=SCT2.LOCALS.OPTION_SLIDER103.maxText, tooltipText = SCT2.LOCALS.OPTION_SLIDER103.tooltipText, SCT2Table = SCT2.FRAME3};
SCT2.OPTIONS.FrameSliders [SCT2.LOCALS.OPTION_SLIDER104.name] = { index = 104, SCT2Var = "TEXTSIZE", minValue = 8, maxValue = 36, valueStep = 1, minText=SCT2.LOCALS.OPTION_SLIDER104.minText, maxText=SCT2.LOCALS.OPTION_SLIDER104.maxText, tooltipText = SCT2.LOCALS.OPTION_SLIDER104.tooltipText, SCT2Table = SCT2.FRAME3};
SCT2.OPTIONS.FrameSliders [SCT2.LOCALS.OPTION_SLIDER105.name] = { index = 105, SCT2Var = "ALPHA", minValue = 10, maxValue = 100, valueStep = 10, minText=SCT2.LOCALS.OPTION_SLIDER105.minText, maxText=SCT2.LOCALS.OPTION_SLIDER105.maxText, tooltipText = SCT2.LOCALS.OPTION_SLIDER105.tooltipText, SCT2Table = SCT2.FRAME3};
SCT2.OPTIONS.FrameSliders [SCT2.LOCALS.OPTION_SLIDER106.name] = { index = 106, SCT2Var = "GAPDIST", minValue = 0, maxValue = 200, valueStep = 10, minText=SCT2.LOCALS.OPTION_SLIDER106.minText, maxText=SCT2.LOCALS.OPTION_SLIDER106.maxText, tooltipText = SCT2.LOCALS.OPTION_SLIDER106.tooltipText, SCT2Table = SCT2.FRAME3};
SCT2.OPTIONS.FrameSliders [SCT2.LOCALS.OPTION_SLIDER107.name] = { index = 107, SCT2Var = "SCTD2_DMGFILTER", minValue = 0, maxValue = 10000, valueStep = 100, minText=SCT2.LOCALS.OPTION_SLIDER107.minText, maxText=SCT2.LOCALS.OPTION_SLIDER107.maxText, tooltipText = SCT2.LOCALS.OPTION_SLIDER107.tooltipText};

--Selection Boxes
SCT2.OPTIONS.FrameSelections [SCT2.LOCALS.OPTION_SELECTION101.name] = { index = 101, SCT2Var = "FONT", SCT2ValueSave=1, tooltipText = SCT2.LOCALS.OPTION_SELECTION101.tooltipText, table = SCT2.LOCALS.OPTION_SELECTION101.table, SCT2Table = SCT2.FRAME3};
SCT2.OPTIONS.FrameSelections [SCT2.LOCALS.OPTION_SELECTION102.name] = { index = 102, SCT2Var = "FONTSHADOW", tooltipText = SCT2.LOCALS.OPTION_SELECTION102.tooltipText, table = SCT2.LOCALS.OPTION_SELECTION102.table, SCT2Table = SCT2.FRAME3};
SCT2.OPTIONS.FrameSelections [SCT2.LOCALS.OPTION_SELECTION103.name] = { index = 103, SCT2Var = "ANITYPE", tooltipText = SCT2.LOCALS.OPTION_SELECTION103.tooltipText, table = SCT2.LOCALS.OPTION_SELECTION103.table, SCT2Table = SCT2.FRAME3};
SCT2.OPTIONS.FrameSelections [SCT2.LOCALS.OPTION_SELECTION104.name] = { index = 104, SCT2Var = "ANISIDETYPE", tooltipText = SCT2.LOCALS.OPTION_SELECTION104.tooltipText, table = SCT2.LOCALS.OPTION_SELECTION104.table, SCT2Table = SCT2.FRAME3};
SCT2.OPTIONS.FrameSelections [SCT2.LOCALS.OPTION_SELECTION105.name] = { index = 105, SCT2Var = "ALIGN", tooltipText = SCT2.LOCALS.OPTION_SELECTION105.tooltipText, table = SCT2.LOCALS.OPTION_SELECTION105.table, SCT2Table = SCT2.FRAME3};
SCT2.OPTIONS.FrameSelections [SCT2.LOCALS.OPTION_SELECTION106.name] = { index = 106, SCT2Var = "ICONSIDE", tooltipText = SCT2.LOCALS.OPTION_SELECTION106.tooltipText, table = SCT2.LOCALS.OPTION_SELECTION106.table, SCT2Table = SCT2.FRAME3};

--Other Options
SCT2.OPTIONS.FrameMisc [SCT2.LOCALS.OPTION_MISC101.name] = {index = 101, tooltipText = SCT2.LOCALS.OPTION_MISC101.tooltipText}
--SCT2.OPTIONS.FrameMisc [SCT2.LOCALS.OPTION_MISC102.name] = {index = 102, tooltipText = SCT2.LOCALS.OPTION_MISC102.tooltipText}
SCT2.OPTIONS.FrameMisc [SCT2.LOCALS.OPTION_MISC103.name] = {index = 103, tooltipText = SCT2.LOCALS.OPTION_MISC103.tooltipText}
SCT2.OPTIONS.FrameMisc [SCT2.LOCALS.OPTION_MISC104.name] = {index = 104, tooltipText = SCT2.LOCALS.OPTION_MISC104.tooltipText}
SCT2.OPTIONS.FrameMisc [SCT2.LOCALS.OPTION_MISC105.name] = {index = 105, tooltipText = SCT2.LOCALS.OPTION_MISC105.tooltipText}
SCT2.OPTIONS.FrameMisc [SCT2.LOCALS.OPTION_MISC106.name] = {index = 106, tooltipText = SCT2.LOCALS.OPTION_MISC106.tooltipText}

----------------------
--Set animation Options
function SCTD2:SetAnimationOptions(objItem)
	if (objItem:GetChecked()) then
		SCT2OptionsFrame_Slider103:Hide();
		SCT2OptionsFrame_Slider105:Show();
		UIDropDownMenu_EnableDropDown(SCT2OptionsFrame_Selection103);
		UIDropDownMenu_EnableDropDown(SCT2OptionsFrame_Selection104);
		BlizzardOptionsPanel_CheckButton_Enable(SCT2OptionsFrame_CheckButton113, true, SCT2OptionsFrame_CheckButton113:GetChecked());
		BlizzardOptionsPanel_Slider_Enable(SCT2OptionsFrame_Slider106Slider);
		SCT2OptionsFrame_Slider106EditBox:Show();
	else
		SCT2OptionsFrame_Slider105:Hide();
		SCT2OptionsFrame_Slider103:Show();
		UIDropDownMenu_DisableDropDown(SCT2OptionsFrame_Selection103);
		UIDropDownMenu_DisableDropDown(SCT2OptionsFrame_Selection104);
		BlizzardOptionsPanel_CheckButton_Disable(SCT2OptionsFrame_CheckButton113);
		BlizzardOptionsPanel_Slider_Disable(SCT2OptionsFrame_Slider106Slider);
		SCT2OptionsFrame_Slider106EditBox:Hide();
	end
end

----------------------
--change frame tabs
function SCTD2:OptionFrameTabClick(item)
	self:ToggleFrameTab(item:GetName(),self.OptionFrames[item:GetName()]);
	PlaySound(PlaySoundKitID and "igCharacterInfoTab" or 841);
end

----------------------
--change frame tabs
function SCTD2:ToggleFrameTab(tab, frameName)
	local key, value
	for key, value in pairs(self.OptionFrames) do
		if ( key == tab and value == frameName ) then
			_G[value]:Show();
			_G[key]:LockHighlight();
		else
			_G[value]:Hide();
			_G[key]:UnlockHighlight();
		end
	end
end

function SCTD2:MakeBlizzOptions()
  SCTD2Options_EventsFrame.name = "SCTD2 "..SCT2.LOCALS.OPTION_MISC104.name
  SCTD2Options_EventsFrame.parent = "SCTD2"
  SCTD2Options_EventsFrame.default = function() SCT2:Reset() end
  InterfaceOptions_AddCategory(SCTD2Options_EventsFrame)

  SCTD2Options_DisplayFrame.name = "SCTD2 "..SCT2.LOCALS.OPTION_MISC105.name
  SCTD2Options_DisplayFrame.parent = "SCTD2"
  SCTD2Options_DisplayFrame.default = function() SCT2:Reset() end
  InterfaceOptions_AddCategory(SCTD2Options_DisplayFrame)

  SCTD2Options_FrameFrame.name = "SCTD2 "..SCT2.LOCALS.OPTION_MISC106.name
  SCTD2Options_FrameFrame.parent = "SCTD2"
  SCTD2Options_FrameFrame.default = function() SCT2:Reset() end
  InterfaceOptions_AddCategory(SCTD2Options_FrameFrame)
end