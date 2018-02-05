class xsDistanceStatMessage extends Gameplay.MPPersonalStatMessage;

static function string GetPersonalString(
	out EMessageType messageType,
	optional int Switch,
	optional Core.Object Related1, 
	optional Core.Object Related2,
	optional Core.Object OptionalObject,
	optional String OptionalString
	)
{
	local class<Stat> s;
	local int amount;

	// Expect Related1 to be a stat (required)
	s = class<Stat>(Related1);
	if (s == None)
		return "";

	amount = 1;
		
	// Check if it's a penalty
	if (s.default.offensePointsPerStat < 0 || s.default.defensePointsPerStat < 0 || s.default.stylePointsPerStat < 0)
		messageType = MessageType_StatPenalty;
	// Otherwise set messagetype depending on stat level
	else if (s.default.logLevel <= 1)
		messageType = MessageType_StatHigh;
	else if (s.default.logLevel == 2)
		messageType = MessageType_StatMedium;
	else
		messageType = MessageType_StatLow;

	if (Switch == 0)
	{
		return replaceStr(s.default.personalmessage, OptionalString) @ createScoreString(s, amount);
	}

	// A custom message has been defined
	if (default.personalMessages.Length < Switch)
		return "";

	return replaceStr(default.personalMessages[Switch], OptionalString) @ createScoreString(s, amount);

	return "";
}

/**
 * remove "(+1 Style)" / "(+1 Offense)" 
 */
static function string createScoreString(class<Stat> s, int amount)
{
	return "";
}