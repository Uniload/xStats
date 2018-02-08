class StatSettings extends Engine.Actor config(xStats);

// Dynamic arrays CANNOT be replicated
const STATLIST_SIZE = 20;
var class<xStats.xsExtendedStat> statList[STATLIST_SIZE];
 
var config int sustainedSpeedCap;

replication
{
    reliable if (Role == ROLE_Authority)
        statList;
}

simulated event PreBeginPlay()
{
	Super.PreBeginPlay();
	//log("xStats_b1: SPAWNING server settings");
}

simulated event PostBeginPlay()
{
	Super.PostBeginPlay();
}

function Initialize()
{
	ServerSaveConfig();
	SetStatSettings();
}

/**	When Clients receive replicated content, this function will be called.
 */
simulated function PostNetReceive()
{
	//log("POST NET RECEIVE STAT SETTINGS ( SERVER CLASS )");
	SetStatSettings();
}

function ServerSaveConfig()
{
	if (Level.NetMode != NM_Client)
		SaveConfig();
}

function bool addToStatList(class<xStats.xsExtendedStat> customStat)
{
	local int i;
	
	if (customStat == None)
		return False;
	
	for (i = 0; i <	ArrayCount(statList); i++)
	{
		if ( statList[i] == None )
		{
			statlist[i] = customStat;
			return True;
		}
	}
	return False;
}

simulated function SetStatSettings()
{
	local Gameplay.ModeInfo M;
	local int i;
	
	// xStats.xsExtendedStat classes do not have access to "Level.NetMode"
	// Because I want to check: if (Level.NetMode == NM_Client), I can simulate the the same
	// outcome by calling ModeInfo(Level.Game), that will be None if this code is run on a client.
	M = ModeInfo(Level.Game);
	
	class'xStats.xsStatTracker'.default.sustainedSpeedCap = sustainedSpeedCap;
	class'StatClasses.flagPickupStat'.default.PersonalMessageClass = Class'xStats.xsNoScoreStatMessage';
	
	for(i = 0; i < ArrayCount(statList); i++)
	{
		if (statList[i] != None)
		{
			(new statList[i]).Initialize( M );
		}
	}
	
}

defaultproperties
{
	sustainedSpeedCap	=	400
	
	bNetNotify				=		True
	NetUpdateFrequency		=		1
	bStatic					=		False
	bNoDelete				=		False
	bAlwaysRelevant			=		False
	netPriority				=		1
}