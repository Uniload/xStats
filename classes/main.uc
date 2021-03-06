class main extends Gameplay.Mutator config(xStats);

/**
 *	Extended game stats
 *	Thanks schlieperich for laying the first stone years before I even knew about tribes.
**/

const PACKAGE_NAME = "xStats_b3";
const VERSION_NAME = "xStats_b3";

var private ClientStats clientStatsInstance;
var private StatSettings serverSettingsInstance;

var config class<EquipmentClasses.ProjectileDamageTypeDefault> stat_MA_PDT;
var config class<EquipmentClasses.ProjectileDamageTypeDefault> stat_MAp_PDT;
var config class<EquipmentClasses.ProjectileDamageTypeDefault> stat_MApp_PDT;
var config class<EquipmentClasses.ProjectileDamageTypeDefault> stat_ED_PDT;
var config class<EquipmentClasses.ProjectileDamageTypeDefault> stat_HS_PDT;
var config class<EquipmentClasses.ProjectileDamageTypeDefault> stat_EBMA_PDT;
var config class<EquipmentClasses.ProjectileDamageTypeDefault> stat_GLMA_PDT;
var config class<EquipmentClasses.ProjectileDamageTypeDefault> stat_MMA_PDT;
var config class<EquipmentClasses.ProjectileDamageTypeDefault> stat_PMA_PDT;
var config class<EquipmentClasses.ProjectileDamageTypeDefault> stat_RPMA_PDT;

var config Array<class<EquipmentClasses.ProjectileDamageTypeDefault> > stat_SS_PDT_LIST;
var config Array<class<EquipmentClasses.ProjectileDamageTypeDefault> > stat_OMG_PDT_LIST;
var config Array<class<EquipmentClasses.ProjectileDamageTypeDefault> > stat_Distance_PDT_LIST;

// ======================================================================================================================

/**	Will cause the clientStatClass to be spawned on the clients, allowing them to load/edit their own stat messages.
 */
replication
{
    reliable if (bNetInitial)
        clientStatsInstance, serverSettingsInstance;
}

static function Name getLogName()
{
  return Name("xStats_b3");
}

/**	Save/load this classes config variables on the server
 */
function ServerSaveConfig()
{
	if (Level.NetMode != NM_Client)
		SaveConfig();
}

function PreBeginPlay()
{
	Super.PreBeginPlay();
	AddServerPackage(PACKAGE_NAME);
}

simulated event PostBeginPlay()
{
	Super.PostBeginPlay();

	log("Startup...", class'main'.static.getLogName());

	ServerSaveConfig();

	serverSettingsInstance = spawn(class'StatSettings');
	clientStatsInstance = spawn(class'ClientStats');

	ModifyStats();

	serverSettingsInstance.Initialize();
}

function Tick(float Delta)
{
  if(ModeInfo(Level.Game).Tracker != none)
  {
    if (ModeInfo(Level.Game).Tracker.IsA('xsStatTracker'))
    {
      Disable('Tick');
      return;
    }
    else {
      ModifyStatTrackerInstance();
    }
  }
}

/** Used to swap the default StatTracker class with xsStatTracker
 */
function ModifyStatTrackerInstance()
{
 	local xsStatTracker xsst;
	local Gameplay.StatTracker st;

	st = ModeInfo(Level.Game).Tracker;
	xsst = Spawn(class'xsStatTracker');
	xsst.copy(st);

	ModeInfo(Level.Game).Tracker = xsst;
	log("Startup completed.", class'main'.static.getLogName());
}

/**	From Antics_v1. Check ServerPackages for a specific package. If missing, this will add the package to the list and stop the server.
 */
function AddServerPackage(string Package)
{
	local bool AddServerPackage;
	local int i;

	AddServerPackage = true;

	for(i = 0; i < class'Engine.GameEngine'.default.ServerPackages.Length; ++i)
	{
		if (class'Engine.GameEngine'.default.ServerPackages[i] == Package)
		{
			AddServerPackage = false;
			break;
		}
	}

	if (AddServerPackage)
	{
		class'Engine.GameEngine'.default.ServerPackages[class'Engine.GameEngine'.default.ServerPackages.Length] = Package;
		class'Engine.GameEngine'.static.StaticSaveConfig();
		log("Added a server package '" $ Package $ "'. Server requires a restart for setup to complete!", class'main'.static.getLogName());
		ConsoleCommand("Exit");
	}
}

/**	Does not work for sniper HS ( is not registered as an extended stat because it works by checking bodyparts (cant be done with extended stats)
 *	By using thie method, the stats wont be displayed in scorescreen when their PDT values are empty / None
 *
 *	Slow.
 */
simulated function RegisterExtendedStat(ModeInfo M, class<ProjectileDamageTypeDefault> PDT, class<xsExtendedStat> stat)
{
	local int index;

	if(stat != None && PDT != None)
	{
		index = M.extendedProjectileDamageStats.Length;
		M.extendedProjectileDamageStats.Insert(index, 1);
		serverSettingsInstance.addToStatList(stat);
		M.extendedProjectileDamageStats[index].damageTypeClass = PDT;
		M.extendedProjectileDamageStats[index].extendedStatClass = stat;
	}
}

simulated function ModifyStats()
{
	local ModeInfo M;
	local int i, statCount;

	M = ModeInfo(Level.Game);

	if(M != None && serverSettingsInstance != None)
	{
		for(i = 0; i < M.projectileDamageStats.Length; ++i)
		{
			// Remove default HS stat
			if(M.projectileDamageStats[i].damageTypeClass == Class'EquipmentClasses.ProjectileDamageTypeSniperRifle')
			{
				M.projectileDamageStats.Remove(i, 1);
			}
		}
		for(i = 0; i < M.extendedProjectileDamageStats.Length; ++i)
		{
			// Remove default MA stat, easier to order them by adding a new stat rather than using old one
			if(M.extendedProjectileDamageStats[i].damageTypeClass == stat_MA_PDT)
			{
				M.extendedProjectileDamageStats.Remove(i, 1);
			}
		}

		log("Loading game stats:", class'main'.static.getLogName());

		if (stat_EBMA_PDT != None)
		{
			statCount = M.projectileDamageStats.Length;
			M.projectileDamageStats.Insert(statCount, 1);	// we have 1 new SIMPLE stats

			// Head Shot
			serverSettingsInstance.addToStatList(Class'StatHS');
			M.projectileDamageStats[statCount].damageTypeClass = stat_HS_PDT;
			M.projectileDamageStats[statCount].headShotStatClass = Class'StatHS';
			// This one is most likely useless.
			M.projectileDamageStats[statCount].playerDamageStatClass = Class'xsExtendedStat';
			++statCount;
		}

		if (stat_EBMA_PDT != None)
			RegisterExtendedStat(M, stat_EBMA_PDT, Class'statEBMA');
		if (stat_MA_PDT != None)
			RegisterExtendedStat(M, stat_MA_PDT, Class'statMA');
		if (stat_MAp_PDT != None)
			RegisterExtendedStat(M, stat_MAp_PDT, Class'statMAPlus');
		if (stat_MApp_PDT != None)
			RegisterExtendedStat(M, stat_MApp_PDT, Class'statMASupreme');
		if (stat_ED_PDT != None)
			RegisterExtendedStat(M, stat_ED_PDT, Class'statEatDisc');
		if (stat_Distance_PDT_LIST.length != 0)
			for(i=0; i < stat_Distance_PDT_LIST.Length;i++)
			{
				//Only add one stat even if multiple PDT's trigger it
				if (i==0)
					RegisterExtendedStat(M, stat_Distance_PDT_LIST[i], Class'statDistance');
				else RegisterExtendedStat(M, stat_Distance_PDT_LIST[i], None );
			}
		if (stat_MA_PDT != None)
			RegisterExtendedStat(M, stat_MA_PDT, Class'statDistanceSpinfusor');
		if (stat_HS_PDT != None)
			RegisterExtendedStat(M, stat_HS_PDT, Class'statDistanceSniper');
		if (stat_PMA_PDT != None)
			RegisterExtendedStat(M, stat_PMA_PDT, Class'statPMA');
		if (stat_GLMA_PDT != None)
			RegisterExtendedStat(M, stat_GLMA_PDT, Class'statGLMA');
		if (stat_MMA_PDT != None)
			RegisterExtendedStat(M, stat_MMA_PDT, Class'statMMA');
		if (stat_SS_PDT_LIST.length != 0)
			for(i=0; i < stat_SS_PDT_LIST.Length ;i++)
			{
				if (i==0)
					RegisterExtendedStat(M, stat_SS_PDT_LIST[i], Class'statSweetShot');
				else RegisterExtendedStat(M, stat_SS_PDT_LIST[i], None );
			}
		if (stat_OMG_PDT_LIST.length != 0)
			for(i=0; i < stat_OMG_PDT_LIST.Length;i++)
			{
				if (i==0)
					RegisterExtendedStat(M, stat_OMG_PDT_LIST[i], Class'statOMG');
				RegisterExtendedStat(M, stat_OMG_PDT_LIST[i], None );
			}
		if (stat_RPMA_PDT != None)
			RegisterExtendedStat(M, stat_RPMA_PDT, Class'statRocketeer');

		//Server logging purposes
		serverSettingsInstance.notifyStatAmt();
	}
}

/**	Not sure about this.
 */
simulated event Destroyed()
{
	clientStatsInstance = None;
	serverSettingsInstance = None;
	Self.Destroy();
}

// ======================================================================================================================

defaultproperties
{
	stat_MA_PDT 			=		Class'EquipmentClasses.ProjectileDamageTypeSpinfusor'
	stat_MAp_PDT			=		Class'EquipmentClasses.ProjectileDamageTypeSpinfusor'
	stat_MApp_PDT			=		Class'EquipmentClasses.ProjectileDamageTypeSpinfusor'
	stat_ED_PDT 			=		Class'EquipmentClasses.ProjectileDamageTypeSpinfusor'
	stat_HS_PDT				=		Class'promod_v1rc7_b3.promodSniperProjectileDamageType'
	stat_EBMA_PDT			=		Class'promod_v1rc7_b3.promodBladeProjectileDamageType'
	stat_GLMA_PDT			=		Class'EquipmentClasses.ProjectileDamageTypeGrenadeLauncher'
	stat_MMA_PDT			=		Class'EquipmentClasses.ProjectileDamageTypeMortar'
	stat_PMA_PDT			=		Class'EquipmentClasses.ProjectileDamageTypeBurner'
	stat_RPMA_PDT			=		Class'EquipmentClasses.ProjectileDamageTypeRocketPod'

	stat_OMG_PDT_LIST(0)	=		Class'EquipmentClasses.ProjectileDamageTypeSpinfusor'
	stat_SS_PDT_LIST(0)		=		Class'EquipmentClasses.ProjectileDamageTypeGrenadeLauncher'
	stat_Distance_PDT_LIST(0)= 		None

	clientStatsInstance		=		None
	serverSettingsInstance	=		None

	bAddToServerPackages	=		true
	FriendlyName			=		"xStats"
	Description				=		"Gameplay stat manager"

	RemoteRole				=		ROLE_Authority
}
