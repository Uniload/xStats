class ServerSettings extends Engine.Actor config(xStats);

event PreBeginPlay()
{
	Super.PreBeginPlay();
}

event PostBeginPlay()
{
	Super.PostBeginPlay();

	SaveConfig();
}

defaultproperties
{
	NetUpdateFrequency = 0
}