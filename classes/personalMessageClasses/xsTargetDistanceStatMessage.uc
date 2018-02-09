class xsTargetDistanceStatMessage extends Gameplay.MPPersonalStatMessage;

static function string GetPersonalString(
	out EMessageType messageType,
	optional int Switch,
	optional Core.Object Related1, 
	optional Core.Object Related2,
	optional Core.Object OptionalObject,
	optional String OptionalString
	)
{
	local class<xStats.xsExtendedStat> s;
	local int amount;

	// Expect Related1 to be a stat (required)
	s = class<xStats.xsExtendedStat>(Related1);
	if (s == None)
		return "";

	amount = 1;

	messageType = MessageType_StatPenalty;

	if (Switch == 0)
	{
		return replaceStr(s.default.targetMessage, OptionalString);
	}

	// A custom message has been defined
	if (default.personalMessages.Length < Switch)
		return "";

	return replaceStr(default.personalMessages[Switch], OptionalString);

	return "";
}

/**
 * remove "(+1 Style)" / "(+1 Offense)" 
 */
static function string createScoreString(class<Stat> s, int amount)
{
	return "";
}