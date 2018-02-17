class xsTargetStatMessage extends Gameplay.MPPersonalStatMessage;

static function string GetPersonalString(
	out EMessageType messageType,
	optional int Switch,
	optional Core.Object Related1, 
	optional Core.Object Related2,
	optional Core.Object OptionalObject,
	optional String OptionalString
	)
{
	local class<xsExtendedStat> s;
	local PlayerReplicationInfo PRI;
	local int amount;

	// Expect Related1 to be a stat (required)
	// Expect Related2 to be a target PRI (optional)
	s = class<xsExtendedStat>(Related1);
	if (s == None)
		return "";

	if (Related2 != None)
		PRI = PlayerReplicationInfo(Related2);

	// If an amount wasn't explicitly sent, assume 1
	amount = int(OptionalString);
	if (amount <= 0)
	{
		amount = 1;
	}

	messageType = MessageType_StatPenalty;

	//Log("MPPersonalStatMessage set messageType to "$messageType$" due to logLevel "$s.default.logLevel$" for stat "$s);

	if (Switch == 0)
	{
		if (PRI == None)
			return s.default.targetMessage;
		else
			return replaceStr(s.default.targetMessage, PRI.PlayerName);
	}

	// A custom message has been defined
	if (default.personalMessages.Length < Switch)
		return "";

	if (PRI == None)
		return default.personalMessages[Switch];
	else
		return replaceStr(default.personalMessages[Switch], PRI.PlayerName);

	return "";
}

/**
 * remove "(+1 Style)" / "(+1 Offense)" 
 */
static function string createScoreString(class<Stat> s, int amount)
{
	return "";
}