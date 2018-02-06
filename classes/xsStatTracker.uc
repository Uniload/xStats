class xsStatTracker extends Gameplay.StatTracker config;

/**
 * Did not manage to make Spawn(class,x,x,x,template) work.
 * Gonna have to copy properties manually...
 */
function copy(Gameplay.StatTracker st)
{
	Self.globalLogLevel = st.globalLogLevel;
	Self.stats = st.stats;
	Self.statSerializers = st.statSerializers;
	Self.currentStatID = currentStatID;
}

function awardStat(Controller C, Class<Stat> s, optional Controller Target, optional int value)
{
	local StatData sd;
	local int i;
	local TribesReplicationInfo TRI;
	local PlayerController PC;
	local int relativeDistance;
	
	if (C == None)
		return;
	PC = PlayerController(C);
	if (PC == None)
		return;
	if (s == None)
		return;
	if (s.default.logLevel > globalLogLevel)
		return;
	
	if (s == class'xStats.statDistance')
	{
		if (target != None)
		{
			relativeDistance = VSize(C.Pawn.Location - Target.Pawn.Location);
			value = (relativeDistance*0.0125);
		}
	} else if (value <= 0)
	{
		value = 1;
	}
	
	log(s);
	
	// Send personal message if applicable
	if (s.default.personalMessage != "" && s.default.personalMessageClass != None)
	{
		if (target != None)
			PC.ReceiveLocalizedMessage(s.default.personalMessageClass, 0, s, target.playerReplicationInfo,, string(value));
		else
			PC.ReceiveLocalizedMessage(s.default.personalMessageClass, 0, s,,, string(value));
	}

	// Send target message if applicable
	//if (Target != None && s.default.targetMessage != "" && s.default.targetMessageClass != None)
	//	PlayerController(Target).ReceiveLocalizedMessage(s.default.targetMessageClass, 0, s, C);

	TRI = TribesReplicationInfo(PC.PlayerReplicationInfo);

	if (TRI == None)
		return;

	sd = TRI.getStatData(s);

	if (sd == None)
	{
		Log("STATTRACKER warning:  An unregistered stat was awarded ("$s$")");
		return;
	}

	sd.amount = sd.amount + value;

	// Set a timestamp
	// This ensures that all serializers will report the stat being awarded
	// at the same time.  It also allows this to be used to display times if
	// necessary, for example MPCheckpoints might want to somehow display the
	// finishing time of a race (not sure how yet).
	sd.lastAwardTimestamp = Level.TimeSeconds;

	// Also award offense, defense and style points
	TRI.offenseScore += sd.statClass.default.offensePointsPerStat * value;
	TRI.defenseScore += sd.statClass.default.defensePointsPerStat * value;
	TRI.styleScore += sd.statClass.default.stylePointsPerStat * value;

	// Calculate total score here for now; eventually this can be
	// performed when the score is displayed
	TRI.Score += sd.statClass.default.offensePointsPerStat * value;
	TRI.Score += sd.statClass.default.defensePointsPerStat * value;
	TRI.Score += sd.statClass.default.stylePointsPerStat * value;

	//Log("TRACKER awarded "$s);

	// Notify StatSerializers
	for (i=0; i<statSerializers.Length; i++)
	{
		statSerializers[i].serializeStat(TRI, sd);
	}
}