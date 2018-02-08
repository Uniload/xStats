class main extends Gameplay.Mutator config(xStats);

/**
 *	Extended game stats
 *	Thanks schlieperich for laying the first stone years before I even knew about tribes.
**/

const PACKAGE_NAME = "xStats";
const VERSION_NAME = "xStats_b1";

var config int StatTrackerSpawnDelay;

var private Actor clientStatsClass;
var private Actor serverSettingsClass;

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
        clientStatsClass, serverSettingsClass;
}

/**	Save/load this classes config variables on the server
 */
function ServerSaveConfig()
{
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

	log(VERSION_NAME $ ": Startup...");
	log(VERSION_NAME $ ": xsStatTracker spawning in " $ StatTrackerSpawnDelay $ " seconds...");
	
	ServerSaveConfig();
	
	serverSettingsClass = spawn(class'xStats.StatSettings');
	clientStatsClass = spawn(class'xStats.ClientStats');
	
	ModifyStats();

	SetTimer(StatTrackerSpawnDelay, False);
}

/** Used to swap the default StatTracker class with xsStatTracker
 */
function Timer()
{	
	local xStats.xsStatTracker xsst;
	local Gameplay.StatTracker st;
	
	log(VERSION_NAME $ ": xsStatTracker spawning...");
	
	st = ModeInfo(Level.Game).Tracker;
	xsst = Spawn(class'xStats.xsStatTracker');
	xsst.copy(st);
	
	ModeInfo(Level.Game).Tracker = xsst;
	log(VERSION_NAME $ ": Startup complete.");
}

/**	From Antics_v1. Check ServerPackages for a specific package. If missing, this will add the package to the list and stop the server.
 */
function AddServerPackage(string Package)
{
	local bool AddServerPackage;
	local int i;
	
	AddServerPackage = true;
	
	for(i = 0; i < class'Engine.GameEngine'.default.ServerPackages.Length; i++)
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
		log("Added a server package '" $ Package $ "'. Server requires a restart for setup to complete!");
		ConsoleCommand("Exit");
	}
}

private function int calculateExtendedStatsAmount()
{
	local int amt;
	amt += 10;
	amt += stat_SS_PDT_LIST.Length;
	amt += stat_OMG_PDT_LIST.Length;
	amt += stat_Distance_PDT_LIST.Length;
	return amt;
}

/**	The order they are added in the list, is the order in which the stats will be displayed at endgame (simple stats BEFORE extended stats).
 */
function ModifyStats()
{
	local ModeInfo M;
	local int i, statCount, EXstatCount;

	M = ModeInfo(Level.Game);

	if(M != None)
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
		
		statCount = M.projectileDamageStats.Length;
		EXstatCount = M.extendedProjectileDamageStats.Length;
		
		M.projectileDamageStats.Insert(statCount, 1);	// we have 1 new SIMPLE stats

		// Head Shot
		M.projectileDamageStats[statCount].damageTypeClass = stat_HS_PDT;
		M.projectileDamageStats[statCount].headShotStatClass = Class'StatHS';
		// This one is most likely useless.
		M.projectileDamageStats[statCount].playerDamageStatClass = Class'xStats.xsExtendedStat';
		++statCount;		
	
		M.extendedProjectileDamageStats.Insert(EXstatCount, calculateExtendedStatsAmount());
		
		// E-Blade
		M.extendedProjectileDamageStats[EXstatCount].damageTypeClass = stat_EBMA_PDT;
		M.extendedProjectileDamageStats[EXstatCount].extendedStatClass = Class'statEBMA';
		++EXstatCount;
		
		// statMA
		M.extendedProjectileDamageStats[EXstatCount].damageTypeClass = stat_MA_PDT;
		M.extendedProjectileDamageStats[EXstatCount].extendedStatClass = Class'statMA';
		++EXstatCount;
		
		// statMAPlus
		M.extendedProjectileDamageStats[EXstatCount].damageTypeClass = stat_MAp_PDT;
		M.extendedProjectileDamageStats[EXstatCount].extendedStatClass = Class'statMAPlus';
		++EXstatCount;
		
		// statMASupreme
		M.extendedProjectileDamageStats[EXstatCount].damageTypeClass = stat_MApp_PDT;
		M.extendedProjectileDamageStats[EXstatCount].extendedStatClass = Class'statMASupreme';
		++EXstatCount;
		
		// statEatDisc
		M.extendedProjectileDamageStats[EXstatCount].damageTypeClass = stat_ED_PDT;
		M.extendedProjectileDamageStats[EXstatCount].extendedStatClass = Class'statEatDisc';
		++EXstatCount;
		
		// statDISTANCE
		for(i=0; i < stat_Distance_PDT_LIST.Length;i++)
		{
			M.extendedProjectileDamageStats[EXstatCount].damageTypeClass = stat_Distance_PDT_LIST[i];
			M.extendedProjectileDamageStats[EXstatCount].extendedStatClass = Class'statDistance';
			++EXstatCount;
		}
		
		// PMA
		M.extendedProjectileDamageStats[EXstatCount].damageTypeClass = stat_PMA_PDT;
		M.extendedProjectileDamageStats[EXstatCount].extendedStatClass = Class'statPMA';
		++EXstatCount;
		
		// GLMA
		M.extendedProjectileDamageStats[EXstatCount].damageTypeClass = stat_GLMA_PDT;
		M.extendedProjectileDamageStats[EXstatCount].extendedStatClass = Class'statGLMA';
		++EXstatCount;

		// MMA
		M.extendedProjectileDamageStats[EXstatCount].damageTypeClass = stat_MMA_PDT;
		M.extendedProjectileDamageStats[EXstatCount].extendedStatClass = Class'statMMA';
		++EXstatCount;
		
		// statSweetShot
		for(i=0; i < stat_SS_PDT_LIST.Length ;i++)
		{
			M.extendedProjectileDamageStats[EXstatCount].damageTypeClass = stat_SS_PDT_LIST[i];
			M.extendedProjectileDamageStats[EXstatCount].extendedStatClass = Class'statSweetShot';
			++EXstatCount;
		}
		
		// statOMG
		for(i=0; i < stat_OMG_PDT_LIST.Length;i++)
		{
			M.extendedProjectileDamageStats[EXstatCount].damageTypeClass = stat_OMG_PDT_LIST[i];
			M.extendedProjectileDamageStats[EXstatCount].extendedStatClass = Class'statOMG';
			++EXstatCount;
		}
		
		// statRocketeer
		M.extendedProjectileDamageStats[EXstatCount].damageTypeClass = stat_RPMA_PDT;
		M.extendedProjectileDamageStats[EXstatCount].extendedStatClass = Class'statRocketeer';
		++EXstatCount;
	}
}

/**	Not sure about this.
 */
simulated event Destroyed()
{
	clientStatsClass.Destroy();
	serverSettingsClass.Destroy();
	Super.Destroy();
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
	stat_OMG_PDT_LIST(1)	=		Class'EquipmentClasses.ProjectileDamageTypeGrenadeLauncher'
	stat_OMG_PDT_LIST(2)	=		Class'EquipmentClasses.ProjectileDamageTypeMortar'
	stat_SS_PDT_LIST(0)		=		Class'EquipmentClasses.ProjectileDamageTypeSpinfusor'
	stat_SS_PDT_LIST(1)		=		Class'EquipmentClasses.ProjectileDamageTypeGrenadeLauncher'
	stat_SS_PDT_LIST(2)		=		Class'EquipmentClasses.ProjectileDamageTypeMortar'
	stat_Distance_PDT_LIST(0)= 		Class'EquipmentClasses.ProjectileDamageTypeSpinfusor'
	stat_Distance_PDT_LIST(1)= 		Class'EquipmentClasses.ProjectileDamageTypeGrenadeLauncher'
	stat_Distance_PDT_LIST(2)= 		Class'EquipmentClasses.ProjectileDamageTypeMortar'
	
	clientStatsClass		=		None
	serverSettingsClass		=		None
	
	StatTrackerSpawnDelay	=		5
	
	bAddToServerPackages	=		True
	FriendlyName			=		"xStats"
	Description				=		"Gameplay stat manager"
}