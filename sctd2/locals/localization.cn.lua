--Everything From here on would need to be translated and put
--into if statements for each specific language.

--***********
--Chinese Traditional
--***********

if GetLocale() ~= "zhCN" then return end

--Warnings
SCTD2.LOCALS.Version_Warning = "SCT版本错误，请更新你的SCT";
SCTD2.LOCALS.Load_Error = "|cff00ff00载入 SCTD2 设置错误，该插件可能停用了。|r错误：";

--"Melee" ranged skills
SCTD2.LOCALS.AUTO_SHOT = "自动射击";
SCTD2.LOCALS.SHOOT = "射击";

-- Cosmos button
SCTD2.LOCALS.CB_NAME			= "SCT - Damage".." "..SCTD2.Version;
SCTD2.LOCALS.CB_SHORT_DESC	= "by Grayhoof";
SCTD2.LOCALS.CB_LONG_DESC	= "将你的伤害显示在SCT中！";
SCTD2.LOCALS.CB_ICON			= "Interface\\Icons\\Ability_Warrior_BattleShout"