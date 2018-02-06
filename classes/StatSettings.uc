class StatSettings extends Engine.Actor config(xStats);

struct statProperties
{
	var config bool 					showDistance;
	var config int						minTargetAltitude;
	var config int						minDistance;
	var config int						MaxDistance;
	var config int						minDamage;
	var config int						offensePointsPerStat;
	var config int						defensePointsPerStat;
	var config int						stylePointsPerStat;
	var config int						logLevel;
	var config string					Acronym;
	var config string 					Description;
	var config string 					awardDescription;
	var config string 					personalMessage;
	var config class<MPPersonalMessage> PersonalMessageClass;
}

var config array<statProperties> xStatsList;

event PreBeginPlay()
{
	Super.PreBeginPlay();
}

event PostBeginPlay()
{
	Super.PostBeginPlay();

	SaveConfig();
}

function browseStats()
{
	local ModeInfo M;
	local int i, statCount;

	M = ModeInfo(Level.Game);

	if ( M == None ) return;
}


defaultproperties
{
	NetUpdateFrequency = 0	
}