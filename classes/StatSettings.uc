class StatSettings extends Engine.Actor config(xStats);

// Dynamic arrays CANNOT be replicated
const STATLIST_SIZE = 20;
var class<xStats.xsExtendedStat> statList[STATLIST_SIZE];
 
var config int sustainedSpeedCap;

// Replicate from Server -> Client
replication
{
    reliable if (Role == ROLE_Authority)
        statList;
}

simulated event PreBeginPlay()
{
	Super.PreBeginPlay();
	log("xStats_b1: SPAWNING server settings");
}

simulated event PostBeginPlay()
{
	Super.PostBeginPlay();

	ServerSaveConfig();
	
	//SetStatSettings();
}

/**	When Clients receive replicated content, this function will be called.
 */
simulated function PostNetReceive()
{
	SetStatSettings();
}

function ServerSaveConfig()
{
	SaveConfig();
}

function bool addToStatList(class<xStats.xsExtendedStat> customStat)
{
	local int i;
	
	if (customStat == None)
		return False;
	
	for (i = 0; i <	ArrayCount(statList); i++)
	{
		log("Adding: " $ customStat);
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
	local int i;
	
	class'xStats.xsStatTracker'.default.sustainedSpeedCap = sustainedSpeedCap;
	class'StatClasses.flagPickupStat'.default.PersonalMessageClass = Class'xStats.xsNoScoreStatMessage';
	
	for(i = 0; i < ArrayCount(statList); i++)
	{
		log("Setting Stats: " $ statList[i]);
		if (statList[i] != None)
		{
			(new statList[i]).Initialize();
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