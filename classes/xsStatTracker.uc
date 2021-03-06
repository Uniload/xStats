class xsStatTracker extends Gameplay.StatTracker;

var int sustainedSpeedCap;
var private float timeLastDistanceStat;
var float timeBetweenDistanceStats;

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

/**	Set Highspeed cap (defined in StatSettings class)
 */
function setStat(Controller c, class<Stat> s, int value)
{
	local TribesReplicationInfo TRI;

	TRI = TribesReplicationInfo(C.PlayerReplicationInfo);

	if (TRI == None)
		return;
	if (s == class'StatClasses.StatHighestSpeed')
	{
		if (value <= sustainedSpeedCap)
			TRI.getStatData(s).amount = value;
	} else
	{
		TRI.getStatData(s).amount = value;
	}
}

function awardStat(Controller C, Class<Stat> s, optional Controller Target, optional int value)
{
	local StatData sd;
	local int i;
	local TribesReplicationInfo TRI;
	local PlayerController PC;
	local int relativeDistance;
	local bool bDistanceStat;
	local class<xsExtendedStat> ES;

	if (C == None)
		return;
	PC = PlayerController(C);
	if (PC == None)
		return;
	if (s == None)
		return;
	if (s.default.logLevel > globalLogLevel)
		return;

	bDistanceStat = ClassIsChildOf(s, class'statDistance');

	if (bDistanceStat)
	{
		if (target != None)
		{
			// TODO calculate relativeDistance at projectile spawn rather than when it hits
			relativeDistance = VSize(C.Pawn.Location - Target.Pawn.Location);
			value = (relativeDistance*0.0125);
		}
	} else if (value <= 0)
	{
		value = 1;
	}

	TRI = TribesReplicationInfo(PC.PlayerReplicationInfo);

	if (TRI == None)
		return;

	sd = TRI.getStatData(s);

	if (sd == None)
	{
		Log("An unregistered stat was awarded ("$s$")", class'main'.static.getLogName());
		return;
	}

	if (ClassIsChildOf(s, class'xsExtendedStat'))
		ES = class<xsExtendedStat>(s);

	if (s.default.personalMessage != "" && s.default.personalMessageClass != None)
	{
		if (!bDistanceStat)
		{
			if (target != None)
			{
				PC.ReceiveLocalizedMessage(s.default.personalMessageClass, 0, s, target.playerReplicationInfo,, string(value));
				if (ES != None)
					PlayerController(Target).ReceiveLocalizedMessage(ES.default.Server_targetMessageClass, 0, s, C.playerReplicationInfo,, string(value));
			}
			else
			{
				PC.ReceiveLocalizedMessage(s.default.personalMessageClass, 0, s,,, string(value));
				if (ES != None)
					PlayerController(Target).ReceiveLocalizedMessage(ES.default.Server_targetMessageClass, 0, s,,, string(value));
			}
		}
		// This is used to avoid displaying distance stat multiple times
		else if ((Level.TimeSeconds - timeLastDistanceStat) > timeBetweenDistanceStats)
		{
			timeLastDistanceStat = Level.TimeSeconds;
			if (target != None)
			{
				PC.ReceiveLocalizedMessage(s.default.personalMessageClass, 0, s, target.playerReplicationInfo,, string(value));
				if (ES != None)
					PlayerController(Target).ReceiveLocalizedMessage(ES.default.Server_targetMessageClass, 0, s, C.playerReplicationInfo,, string(value));
			}
			else
			{
				PC.ReceiveLocalizedMessage(s.default.personalMessageClass, 0, s,,, string(value));
				if (ES != None)
					PlayerController(Target).ReceiveLocalizedMessage(ES.default.Server_targetMessageClass, 0, s,,, string(value));
			}
		}
	}

	// Set a timestamp
	// This ensures that all serializers will report the stat being awarded
	// at the same time.  It also allows this to be used to display times if
	// necessary, for example MPCheckpoints might want to somehow display the
	// finishing time of a race (not sure how yet).
	sd.lastAwardTimestamp = Level.TimeSeconds;

	//Custom score system for distance stat.

	if (!bDistanceStat)
	{
		sd.amount = sd.amount + value;

		// Also award offense, defense and style points
		TRI.offenseScore += sd.statClass.default.offensePointsPerStat * value;
		TRI.defenseScore += sd.statClass.default.defensePointsPerStat * value;
		TRI.styleScore += sd.statClass.default.stylePointsPerStat * value;

		// Calculate total score here for now; eventually this can be
		// performed when the score is displayed
		TRI.Score += sd.statClass.default.offensePointsPerStat * value;
		TRI.Score += sd.statClass.default.defensePointsPerStat * value;
		TRI.Score += sd.statClass.default.stylePointsPerStat * value;
	} else
	{
		if (sd.amount < value)
		{
			sd.amount = value;

			TRI.offenseScore += sd.statClass.default.offensePointsPerStat;
			TRI.defenseScore += sd.statClass.default.defensePointsPerStat;
			TRI.styleScore += sd.statClass.default.stylePointsPerStat;

			TRI.Score += sd.statClass.default.offensePointsPerStat;
			TRI.Score += sd.statClass.default.defensePointsPerStat;
			TRI.Score += sd.statClass.default.stylePointsPerStat;
		}
	}

	// Notify StatSerializers
	for (i=0; i<statSerializers.Length; i++)
	{
		statSerializers[i].serializeStat(TRI, sd);
	}
}

defaultproperties
{
	sustainedSpeedCap	=	400
	timeLastDistanceStat = 0.000000
	timeBetweenDistanceStats = 1.000000
}
