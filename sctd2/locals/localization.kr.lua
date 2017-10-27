-- SCT localization information
-- Korean Locale
-- Initial translation by SayClub, Next96
-- Translation by SayClub, Next96
-- Date 2006/08/09

if GetLocale() ~= "koKR" then return end

--Warnings
SCTD2.LOCALS.Version_Warning = "올바른 SCT가 로드되지 않았습니다. SCTD2는 SCT 5.0 이상을 사용하지 않으면 동작하지 않습니다.";
SCTD2.LOCALS.Load_Error = "|cff00ff00SCTD2 설정을 불러오는데 실패했습니다. 설정이 불가능합니다.|r";

--"Melee" ranged skills
SCTD2.LOCALS.AUTO_SHOT = "자동 사격";
SCTD2.LOCALS.SHOOT = "발사";

-- Cosmos button
SCTD2.LOCALS.CB_NAME			= "SCT - Damage".." "..SCTD2.Version;
SCTD2.LOCALS.CB_SHORT_DESC	= "by Grayhoof";
SCTD2.LOCALS.CB_LONG_DESC	= "SCT에 자신의 공격력 메시지를 추가합니다!";
SCTD2.LOCALS.CB_ICON			= "Interface\\Icons\\Ability_Warrior_BattleShout"
