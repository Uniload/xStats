class ClientStats extends Engine.Actor config(xStats);

//var private bool bInduceReplication;

var config bool removeUnawardedStats;

var config string messageDistance;
var config string messageDistanceSpinfusor;
var config string messageDistanceSniper;
var config string messageSpinfusorMA;
var config string messageSpinfusorMAPlus;
var config string messageSpinfusorMASupreme;
var config string messageSpinfusorEatDisc;
var config string messageOMG;
var config string messageSweetShot;
var config string messageBurnerMA;
var config string messageRocketPodMA;
var config string messageGrenadeLauncherMA;
var config string messageMortarMa;
var config string messageBladeMa;
var config string messageSniperHS;

var config string messageTargetDistance;
var config string messageTargetDistanceSpinfusor;
var config string messageTargetDistanceSniper;
var config string messageTargetSpinfusorMA;
var config string messageTargetSpinfusorMAPlus;
var config string messageTargetSpinfusorMASupreme;
var config string messageTargetSpinfusorEatDisc;
var config string messageTargetOMG;
var config string messageTargetSweetShot;
var config string messageTargetBurnerMA;
var config string messageTargetRocketPodMA;
var config string messageTargetGrenadeLauncherMA;
var config string messageTargetMortarMa;
var config string messageTargetBladeMa;
var config string messageTargetSniperHS;

/** DEFAULT CTF STATS **/
var config string messageKill;
var config string messageTeamKill;
var config string messageFlagReturned;
var config string messageFlagCaptured;
var config string messageCapperKilled;
var config string messageFlagDefended;
var config string messageFlagAttacked;
var config string messageFlagPickup;
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

simulated event PostBeginPlay()
{
	Super.PostBeginPlay();

	Disable('Tick');

	ClientSaveConfig();

	if (removeUnawardedStats)
		SetTimer(1, true);

	setDefaultStatMessages();
	setStatMessages();
	setTargetStatMessages();
}

simulated function ClientSaveConfig()
{
	if (Level.NetMode == NM_Client)
		SaveConfig();
}

/** Check for endgame
 */
event Timer()
{
	// TODO Does client know Level.Game ???
	if (MultiplayerGameInfo(Level.Game).bOnGameEndCalled && Level.NetMode == NW_Client)
		RemoveUnawardedStats();
}

/** Make client clear the unawarded stats themselves,
 *  changes on the server wont be replicated in time before the "end game summary screen" (EGSC) anyway.
 *  This can be done by replacing the non-awarded stat with a stat class that
 *	doesnt have a description set, because those are ignored on the EGSC by default.
 *
 *	No idea how to make sure this will be called before the EGSC generation though...
 */
simulated function RemoveUnawardedStats()
{
	local int i;
	local tribesReplicationInfo TRI;

	TRI = tribesReplicationInfo(PlayerOwner().playerReplicationInfo);

	for (i=0; i < TRI.statDataList.Length; ++i)
	{
		if (TRI.statDataList[i].amount == 0)
		{
			TRI.statDataList[i] = spawn(class'statEmpty');
		}
	}
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
	class'statDistance'.default.personalMessage = messageDistance;
	class'statDistanceSpinfusor'.default.personalMessage = messageDistanceSpinfusor;
	class'statDistanceSniper'.default.personalMessage = messageDistanceSniper;
	class'statMA'.default.personalMessage = messageSpinfusorMA;
	class'statMAPlus'.default.personalMessage = messageSpinfusorMAPlus;
	class'statMASupreme'.default.personalMessage = messageSpinfusorMASupreme;
	class'statEatDisc'.default.personalMessage = messageSpinfusorEatDisc;
	class'statOMG'.default.personalMessage = messageOMG;
	class'statSweetShot'.default.personalMessage = messageSweetShot;
	class'statPMA'.default.personalMessage = messageBurnerMA;
	class'statRocketeer'.default.personalMessage = messageRocketPodMA;
	class'statGLMA'.default.personalMessage = messageGrenadeLauncherMA;
	class'statEBMA'.default.personalMessage = messageBladeMa;
	class'statHS'.default.personalMessage = messageSniperHS;
	class'statMMA'.default.personalMessage = messageMortarMa;
}

simulated function setTargetStatMessages()
{
	class'statDistance'.default.targetMessage = messageTargetDistance;
	class'statDistanceSpinfusor'.default.targetMessage = messageTargetDistanceSpinfusor;
	class'statDistanceSniper'.default.targetMessage = messageTargetDistanceSniper;
	class'statMA'.default.targetMessage = messageTargetSpinfusorMA;
	class'statMAPlus'.default.targetMessage = messageTargetSpinfusorMAPlus;
	class'statMASupreme'.default.targetMessage = messageTargetSpinfusorMASupreme;
	class'statEatDisc'.default.targetMessage = messageTargetSpinfusorEatDisc;
	class'statOMG'.default.targetMessage = messageTargetOMG;
	class'statSweetShot'.default.targetMessage = messageTargetSweetShot;
	class'statPMA'.default.targetMessage = messageTargetBurnerMA;
	class'statRocketeer'.default.targetMessage = messageTargetRocketPodMA;
	class'statGLMA'.default.targetMessage = messageTargetGrenadeLauncherMA;
	class'statEBMA'.default.targetMessage = messageTargetBladeMa;
	class'statHS'.default.targetMessage = messageTargetSniperHS;
	class'statMMA'.default.targetMessage = messageTargetMortarMa;
}

defaultproperties
{
	removeUnawardedStats	=		true

	messageKill				=		"You killed %1"
	messageTeamKill			=		"You teamkilled %1"
	messageFlagPickup		=		"You grabbed the enemy flag"
	messageFlagCaptured		=		"You captured the flag"
	messageFlagReturned		=		"You returned the flag"
	messageCapperKilled		=		"You killed their flag carrier"
	messageFlagDefended		=		"You defended your flag"
	messageFlagAttacked		=		"You killed an enemy flag defender"
	messageTerritoryCaptured=		"You captured a territory"
	messageRabbitKilled		=		"You killed a rabbit"
	messageFuelDeposited	=		"You deposited fuel"
	messageFuelDefended		=		"You defended your fuel depot"
	messageFuelAttacked		=		"You killed an enemy fuel defender"
	messageRepairGenerator	=		"You repaired your generator"
	messageRepairSensor		=		"You repaired your sensor"
	messageRepairInventory	=		"You repaired an inventory station"
	messageDestoryGenerator	=		"You destroyed their generator"
	messageDestorySensor	=		"You destroyed their sensor"

	messageDistanceSpinfusor=		"%1 meters"
	messageDistanceSniper	=		"%1 meters"
	messageDistance			=		"%1 meters"
	messageSpinfusorMA		=		"You midair disced %1"
	messageSpinfusorMAPlus	=		"+ midair plus +"
	messageSpinfusorMASupreme=		"+ midair supreme +"
	messageSpinfusorEatDisc	=		"+ EAT DISC +"
	messageOMG				=		"+ O M G +"
	messageSweetShot		=		"+ sweet shot +"
	messageBurnerMA			=		"You plasma midaired %1"
	messageRocketPodMA		=		"+ Rocketeer +"
	messageGrenadeLauncherMA=		"You grenade midaired %1"
	messageMortarMa			=		"You mortar midaired %1"
	messageBladeMa			=		"You midair knifed %1"
	messageSniperHS			=		"Head Shot!"

	messageTargetDistanceSpinfusor	=		""
	messageTargetDistanceSniper		=		"Sniped from %1 meters"
	messageTargetDistance			=		""
	messageTargetSpinfusorMA		=		""
	messageTargetSpinfusorMAPlus	=		""
	messageTargetSpinfusorMASupreme	=		""
	messageTargetSpinfusorEatDisc	=		"EAT DISC by %1"
	messageTargetOMG				=		"O M G by %1"
	messageTargetSweetShot			=		""
	messageTargetBurnerMA			=		""
	messageTargetRocketPodMA		=		""
	messageTargetGrenadeLauncherMA	=		"GL MA by %1"
	messageTargetMortarMa			=		"Mortar MA by %1"
	messageTargetBladeMa			=		"knifed by %1"
	messageTargetSniperHS			=		"Head Shot by %1"

	bNetNotify				=		True
	NetUpdateFrequency		=		1
	bStatic					=		False
	bNoDelete				=		False
	bAlwaysRelevant			=		False
	netPriority				=		1
}
