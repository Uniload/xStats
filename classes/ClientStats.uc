class ClientStats extends Engine.Actor config(xStats);

var config string messageSpinfusorMA;
var config string messageSpinfusorMAPlus;
var config string messageSpinfusorMASupreme;
var config string messageSpinfusorEatDisc;

var config string messageOMG;
var config string messageSweetShot;
var config string messageBurnerMA;
var config string messageRocketPodMA;
var config string messageGrenadeLauncherMA;
var config string messageBladeMa;
var config string messageSniperHS;


simulated event PreBeginPlay()
{
	Super.PreBeginPlay();
}

simulated event PostBeginPlay()
{
	Super.PostBeginPlay();
	
	SaveConfig();
	
	class'xStats.statMA'.default.personalMessage = messageSpinfusorMA;
	class'xStats.statMAPlus'.default.personalMessage = messageSpinfusorMAPlus;
	class'xStats.statMASupreme'.default.personalMessage = messageSpinfusorMASupreme;
	class'xStats.statEatDisc'.default.personalMessage = messageSpinfusorEatDisc;
	class'xStats.statOMG'.default.personalMessage = messageOMG;
	class'xStats.statSweetShot'.default.personalMessage = messageSweetShot;
	class'xStats.statPMA'.default.personalMessage = messageBurnerMA;
	class'xStats.statRocketeer'.default.personalMessage = messageRocketPodMA;
	class'xStats.statGLMA'.default.personalMessage = messageGrenadeLauncherMA;
	class'xStats.statEBMA'.default.personalMessage = messageBladeMa;
	class'xStats.statHS'.default.personalMessage = messageSniperHS;
	
	Destroy();
}

defaultproperties
{
	messageSpinfusorMA="You midair disced %1"
	messageSpinfusorMAPlus="+ MIDAIR PLUS +"
	messageSpinfusorMASupreme="+ MIDAIR SUPREME +"
	messageSpinfusorEatDisc="+ EAT DISC +"
	messageOMG="+   O   M   G   +"
	messageSweetShot="+   SWEET SHOT   +"
	messageBurnerMA="You plasma midaired %1"
	messageRocketPodMA="+ Rocketeer +"
	messageGrenadeLauncherMA="You grenade midaired %1"
	messageBladeMa="You midair knifed %1"
	messageSniperHS="-Head Shot-"
	
	NetUpdateFrequency = 0
}