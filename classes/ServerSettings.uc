class ServerSettings extends Engine.Actor config(xStats);

var config int minTA;
var config int minDistance;
var config int maxDistance;

event PreBeginPlay()
{
	Super.PreBeginPlay();
}

event PostBeginPlay()
{
	Super.PostBeginPlay();

	SaveConfig();
	
	StatMA();
}


function StatMA()
{
	
}

defaultproperties
{
}