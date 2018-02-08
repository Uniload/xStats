class StatSettings extends Engine.Actor config(xStats);

var config int sustainedSpeedCap;


simulated event PreBeginPlay()
{
	Super.PreBeginPlay();
	log("xStats_b1: SPAWNING server settings");
}

simulated event PostBeginPlay()
{
	Super.PostBeginPlay();

	ServerSaveConfig();
	SetStatSettings();
}

function ServerSaveConfig()
{
	SaveConfig();
}

simulated function SetStatSettings()
{
	local int i;
	
	class'xStats.xsStatTracker'.default.sustainedSpeedCap = sustainedSpeedCap;
	
	for (i = 0; i < 1; i++)
	{
		(new class'xStats.statDistance').setStats();
	}
}

defaultproperties
{
	sustainedSpeedCap	=	350

	NetUpdateFrequency		=		1
	bStatic					=		False
	bNoDelete				=		False
	bAlwaysRelevant			=		False
	netPriority				=		1
}