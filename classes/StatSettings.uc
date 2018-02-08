class StatSettings extends Engine.Actor config(xStats);

var config int sustainedSpeedCap;

event PreBeginPlay()
{
	Super.PreBeginPlay();
}

event PostBeginPlay()
{
	Super.PostBeginPlay();

	SaveConfig();
}

function applySettings()
{
	class'xStats.xsStatTracker'.default.sustainedSpeedCap = sustainedSpeedCap;
}

defaultproperties
{
	sustainedSpeedCap	=	400

	NetUpdateFrequency = 0	
}