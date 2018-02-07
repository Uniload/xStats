class ClientStats extends Engine.Actor config(xStats);

var config string messageDistance;
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

/** DEFAULT CTF STATS **/
var config string messageKill;
var config string messageTeamKill;
var config string messageFlagReturned;
var config string messageFlagCaptured;
var config string messageCapperKilled;
var config string messageFlagDefended;
var config string messageFlagAttacked;
var vonfig string messageFlagPickup;
/** DEFAULT TERRITORY STATS **/
var config string messageTerritoryCaptured;
/** DEFAULT FUEL STATS **/
var config string messageRabbitKilled;
var config string messageFuelDeposited;
var config string messageFuelDefended;
var config string messageFuelAttacked;
/** DEFAULT BASEDEVICES STATS **/
var config string messageRepairGenerator;
var config string messageRepairSensor;
var config string messageRepairInventory;
var config string messageDestoryGenerator;
var config string messageDestorySensor;

// ============================================

simulated event PreBeginPlay()
{
	Super.PreBeginPlay();
	log("xStats_b1: SPAWNING client stats");
}

simulated event PostBeginPlay()
{
	Super.PostBeginPlay();

	SaveConfig();
	
	setStatMessages();
	setDefaultStatMessages();
}

simulated function setDefaultStatMessages()
{

	class'StatClasses.killStat'.default.personalMessage = messageKill;
	class'StatClasses.killStatCTF'.default.personalMessage = messageKill;
	class'StatClasses.killStatArena'.default.personalMessage = messageKill;
	class'StatClasses.StatTeamKill'.default.personalMessage = messageTeamKill;
	class'StatClasses.flagCaptureStat'.default.personalMessage = messageFlagCaptured;
	class'StatClasses.flagReturnStat'.default.personalMessage = messageFlagReturned;
	class'StatClasses.StatFlagCarrierKill'.default.personalMessage = messageCapperKilled;
	class'StatClasses.StatFlagDefend'.default.personalMessage = messageFlagDefended;
	class'StatClasses.StatFlagAttack'.default.personalMessage = messageFlagAttacked;
	class'StatClasses.StatTerritoryCapture'.default.personalMessage = messageTerritoryCaptured;
	class'StatClasses.StatRabbitKill'.default.personalMessage = messageRabbitKilled;
	class'StatClasses.StatFuelDeposit'.default.personalMessage = messageFuelDeposited;
	class'StatClasses.StatFuelDepotDefend'.default.personalMessage = messageFuelDefended;
	class'StatClasses.StatFuelDepotAttack'.default.personalMessage = messageFuelAttacked;
	class'StatClasses.StatRepairGenerator'.default.personalMessage = messageRepairGenerator;
	class'StatClasses.StatRepairSensor'.default.personalMessage = messageRepairSensor;
	class'StatClasses.StatRepairInventory'.default.personalMessage = messageRepairInventory;
	class'StatClasses.StatDestroyGenerator'.default.personalMessage = messageDestoryGenerator;	
	class'StatClasses.StatDestroySensor'.default.personalMessage = messageDestorySensor;
	class'StatClasses.flagPickupStat'.default.personalMessage = messageFlagPickup;
}

simulated function setStatMessages()
{
	class'xStats.statDistance'.default.personalMessage = messageDistance;
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
}

defaultproperties
{
	messageKill				=		"_You killed %1"
	messageTeamKill			=		"_You teamkilled %1"
	messageFlagPickup		=		"_You grabbed the enemy flag"
	messageFlagCaptured		=		"_You captured the flag"
	messageFlagReturned		=		"_You returned the flag"
	messageCapperKilled		=		"_You killed their flag carrier"
	messageFlagDefended		=		"_You defended your flag"
	messageFlagAttacked		=		"_You killed an enemy flag defender"
	messageTerritoryCaptured=		"_You captured a territory"
	messageRabbitKilled		=		"_You killed a rabbit"
	messageFuelDeposited	=		"_You deposited fuel"
	messageFuelDefended		=		"_You defended your fuel depot"
	messageFuelAttacked		=		"_You killed an enemy fuel defender"
	messageRepairGenerator	=		"_You repaired your generator"
	messageRepairSensor		=		"_You repaired your sensor"
	messageRepairInventory	=		"_You repaired an inventory station"
	messageDestoryGenerator	=		"_You destroyed their generator"
	messageDestorySensor	=		"_You destroyed their sensor"
	
	messageDistance			=		"%1 meters"
	messageSpinfusorMA		=		"You midair disced %1"
	messageSpinfusorMAPlus	=		"+ MIDAIR PLUS +"
	messageSpinfusorMASupreme=		"+ MIDAIR SUPREME +"
	messageSpinfusorEatDisc	=		"+ EAT DISC +"
	messageOMG				=		"+ O M G +"
	messageSweetShot		=		"+ sweet shot +"
	messageBurnerMA			=		"You plasma midaired %1"
	messageRocketPodMA		=		"+ Rocketeer +"
	messageGrenadeLauncherMA=		"You grenade midaired %1"
	messageBladeMa			=		"You midair knifed %1"
	messageSniperHS			=		"Head Shot!"
	
	NetUpdateFrequency		=		1
	bStatic					=		False
	bNoDelete				=		False
	bAlwaysRelevant			=		False
	netPriority				=		1
}