class StatSettings extends Engine.Actor config(xStats);

// Dynamic arrays CANNOT be replicated
const STATLIST_MAX_SIZE = 30;
var private int statListSize;
var class<xStats.xsExtendedStat> statList[STATLIST_MAX_SIZE];

var private bool bServer;
var config int sustainedSpeedCap;

replication
{
    reliable if (Role == ROLE_Authority)
        statList;
}

function Initialize()
{
	ServerSaveConfig();
	SetStatSettings();
}

simulated function PostBeginPlay()
{
	bServer = (Level.NetMode != NM_Client);
}

/**	When Clients receive replicated content, this function will be called.
 */
simulated function PostNetReceive()
{
	SetStatSettings();
}

function ServerSaveConfig()
{
	if (bServer)
		SaveConfig();
}

function bool addToStatList(class<xStats.xsExtendedStat> customStat)
{
	if (customStat == None || (statListSize-1) > STATLIST_MAX_SIZE)
		return False;
	
	statList[statListSize] = customStat;
	statListSize += 1;
	return True;
}

/*
simulated function SetStatSettings()
{
	local bool b;
	local int i;
	
	class'xStats.xsStatTracker'.default.sustainedSpeedCap = sustainedSpeedCap;
	class'StatClasses.flagPickupStat'.default.PersonalMessageClass = Class'xStats.xsNoScoreStatMessage';
	
	b = Level.NetMode != NM_Client
	
	for(i = 0; i < ArrayCount(statList); ++i)
	{
		if (statList[i] != None)
		{
			// This is so wrong
			(new statList[i]).Initialize( b );
		}
	}
}
*/

simulated function SetStatSettings()
{
	local class<xStats.xsExtendedStat> xsc;
	local int i;
	
	log("Called by Server?");
	log(bServer);
	
	class'xStats.xsStatTracker'.default.sustainedSpeedCap = sustainedSpeedCap;
	class'StatClasses.flagPickupStat'.default.PersonalMessageClass = Class'xStats.xsNoScoreStatMessage';
	
	for(i = 0; i < ArrayCount(statList); ++i)
	{
		xsc = statList[i];
		if (xsc != None)
		{
			// Is this the first map of the server ? aka, has this server been restarted ?
			//	Level = levelIsle0 / levelEmerald1 / levelEmerald2 
			//if ( last char of Level == 0 && bServer)
			//	xsc.static.StaticSaveConfig();
		
			xsc.default.minTargetAltitude = xsc.default.Server_minTargetAltitude;
			xsc.default.minDistance = xsc.default.Server_minDistance;
			xsc.default.MaxDistance = xsc.default.Server_MaxDistance;
			xsc.default.minTargetSpeed = xsc.default.Server_MinTargetSpeed;
			xsc.default.maxTargetSpeed = xsc.default.Server_MaxTargetSpeed;
			xsc.default.minDamage = xsc.default.Server_minDamage;
			xsc.default.bAllowTargetInVehicleOrTurret = xsc.default.Server_bAllowTargetInVehicleOrTurret;
			xsc.default.offensePointsPerStat = xsc.default.Server_offensePointsPerStat;
			xsc.default.defensePointsPerStat = xsc.default.Server_defensePointsPerStat;
			xsc.default.stylePointsPerStat = xsc.default.Server_stylePointsPerStat;
			xsc.default.logLevel = xsc.default.Server_logLevel;
			xsc.default.Acronym = xsc.default.Server_Acronym;
			xsc.default.Description = xsc.default.Server_Description;
			xsc.default.awardDescription = xsc.default.Server_awardDescription;
			xsc.default.PersonalMessageClass = xsc.default.Server_PersonalMessageClass;
			
			//if (bServer)
			//	xsc.static.StaticSaveConfig();
		}
	}
}

defaultproperties
{
	sustainedSpeedCap	=	400
	
	bServer					=		False
	statListSize			=		0
	bNetNotify				=		True
	NetUpdateFrequency		=		1
	bStatic					=		False
	bNoDelete				=		False
	bAlwaysRelevant			=		True
	netPriority				=		1
}