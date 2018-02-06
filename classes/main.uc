class main extends Gameplay.Mutator config(xStats);

/**
 *	Extended game stats
 *	Thanks schlieperich for laying the first stone years before I even knew about tribes.
**/

const VERSION_NAME = "xStats_b1";
const int STAT_AMOUNT = 13;

var Actor clientStatsClass;
var Actor serverSettingsClass;

var config class<EquipmentClasses.ProjectileDamageTypeDefault> stat_MA_PDT;
var config class<EquipmentClasses.ProjectileDamageTypeDefault> stat_MAp_PDT;
var config class<EquipmentClasses.ProjectileDamageTypeDefault> stat_MApp_PDT;
var config class<EquipmentClasses.ProjectileDamageTypeDefault> stat_ED_PDT;
var config class<EquipmentClasses.ProjectileDamageTypeDefault> stat_HS_PDT;
var config class<EquipmentClasses.ProjectileDamageTypeDefault> stat_EBMA_PDT;
var config class<EquipmentClasses.ProjectileDamageTypeDefault> stat_GLMA_PDT;
var config class<EquipmentClasses.ProjectileDamageTypeDefault> stat_OMG_PDT;
var config class<EquipmentClasses.ProjectileDamageTypeDefault> stat_MMA_PDT;
var config class<EquipmentClasses.ProjectileDamageTypeDefault> stat_SS_PDT;
var config class<EquipmentClasses.ProjectileDamageTypeDefault> stat_PMA_PDT;
var config class<EquipmentClasses.ProjectileDamageTypeDefault> stat_RPMA_PDT;
var config class<EquipmentClasses.ProjectileDamageTypeDefault> stat_DistancePDT;

replication
{
    reliable if (bNetInitial)
        clientStatsClass;
}

simulated event PostBeginPlay()
{
	Super.PostBeginPlay();
	
	ServerSaveConfig();
	
	clientStatsClass = spawn(class'xStats.ClientStats');
	serverSettingsClass = spawn(class'xStats.ServerSettings');
	
	ModifyStats();
}

function ServerSaveConfig()
{
	SaveConfig();
}

function ModifyStats()
{
	local ModeInfo M;
	local int i, statCount;

	M = ModeInfo(Level.Game);

	if(M != None)
	{
		for(i = 0; i < M.extendedProjectileDamageStats.Length; ++i)
		{
			// Set Extended stat to MA
			if(M.extendedProjectileDamageStats[i].damageTypeClass == stat_MA_PDT)
			{
				M.extendedProjectileDamageStats[i].extendedStatClass = Class'statMA';
			}		
		}
		for(i = 0; i < M.projectileDamageStats.Length; ++i)
		{
			// Remove default HS
			if(M.projectileDamageStats[i].damageTypeClass == Class'EquipmentClasses.ProjectileDamageTypeSniperRifle')
			{
				M.projectileDamageStats.Remove(i, 1);
			}
		}

                // ### DAMAGE STATS ###

		statCount = M.projectileDamageStats.Length;
		
		M.projectileDamageStats.Insert(statCount, 1);

		// Head Shot
		M.projectileDamageStats[statCount].damageTypeClass = stat_HS_PDT;
		M.projectileDamageStats[statCount].headShotStatClass = Class'StatHS';
		M.projectileDamageStats[statCount].playerDamageStatClass = Class'xStats.xsExtendedStat';
		++statCount;		
		
                // ### EXTENDED DAMAGE STATS ###

		statCount = M.extendedProjectileDamageStats.Length;
		
		M.extendedProjectileDamageStats.Insert(statCount, (STAT_AMOUNT-2) ); // we have 11 new stats
		
		// statDISTANCE		Its only purpose here is to be registered and shown at endgame. "Longest midair:  xxx"
		//					Need to find a way to modify/replace ModeInfo for this to work...
		M.extendedProjectileDamageStats[statCount].damageTypeClass = stat_DistancePDT;
		M.extendedProjectileDamageStats[statCount].extendedStatClass = Class'statDistance';
		++statCount;
		
		// statMAPlus
		M.extendedProjectileDamageStats[statCount].damageTypeClass = stat_MAp_PDT;
		M.extendedProjectileDamageStats[statCount].extendedStatClass = Class'statMAPlus';
		++statCount;
		
		// statMASupreme
		M.extendedProjectileDamageStats[statCount].damageTypeClass = stat_MApp_PDT;
		M.extendedProjectileDamageStats[statCount].extendedStatClass = Class'statMASupreme';
		++statCount;
		
		// statEatDisc
		M.extendedProjectileDamageStats[statCount].damageTypeClass = stat_ED_PDT;
		M.extendedProjectileDamageStats[statCount].extendedStatClass = Class'statEatDisc';
		++statCount;
		
		// statOMG
		M.extendedProjectileDamageStats[statCount].damageTypeClass = stat_OMG_PDT;
		M.extendedProjectileDamageStats[statCount].extendedStatClass = Class'statOMG';
		++statCount;
		
		// PMA
		M.extendedProjectileDamageStats[statCount].damageTypeClass = stat_PMA_PDT;
		M.extendedProjectileDamageStats[statCount].extendedStatClass = Class'statPMA';
		++statCount;
		
		// E-Blade
		M.extendedProjectileDamageStats[statCount].damageTypeClass = stat_EBMA_PDT;
		M.extendedProjectileDamageStats[statCount].extendedStatClass = Class'statEBMA';
		++statCount;
		
		// statRocketeer
		M.extendedProjectileDamageStats[statCount].damageTypeClass = stat_RPMA_PDT;
		M.extendedProjectileDamageStats[statCount].extendedStatClass = Class'statRocketeer';
		++statCount;
		
		// GLMA
		M.extendedProjectileDamageStats[statCount].damageTypeClass = stat_GLMA_PDT;
		M.extendedProjectileDamageStats[statCount].extendedStatClass = Class'statGLMA';
		++statCount;

		// MMA
		M.extendedProjectileDamageStats[statCount].damageTypeClass = stat_MMA_PDT;
		M.extendedProjectileDamageStats[statCount].extendedStatClass = Class'statMMA';
		++statCount;
		
		// statSweetShot
		M.extendedProjectileDamageStats[statCount].damageTypeClass = stat_SS_PDT;
		M.extendedProjectileDamageStats[statCount].extendedStatClass = Class'statSweetShot';
		++statCount;
	}
}

defaultproperties
{
	stat_MA_PDT 	=		Class'EquipmentClasses.ProjectileDamageTypeSpinfusor'
	stat_MAp_PDT	=		Class'EquipmentClasses.ProjectileDamageTypeSpinfusor'
	stat_MApp_PDT	=		Class'EquipmentClasses.ProjectileDamageTypeSpinfusor'
	stat_ED_PDT 	=		Class'EquipmentClasses.ProjectileDamageTypeSpinfusor'
	stat_HS_PDT		=		Class'EquipmentClasses.ProjectileDamageTypeSniperRifle'
	stat_EBMA_PDT	=		Class'Gameplay.ProjectileDamageType'
	stat_GLMA_PDT	=		Class'EquipmentClasses.ProjectileDamageTypeGrenadeLauncher'
	stat_MMA_PDT	=		Class'EquipmentClasses.ProjectileDamageTypeMortar'
	stat_OMG_PDT	=		Class'EquipmentClasses.ProjectileDamageTypeExplosion'
	stat_SS_PDT		=		Class'EquipmentClasses.ProjectileDamageTypeExplosion'
	stat_PMA_PDT	=		Class'EquipmentClasses.ProjectileDamageTypeBurner'
	stat_RPMA_PDT	=		Class'EquipmentClasses.ProjectileDamageTypeRocketPod'
	stat_DistancePDT= 		Class'EquipmentClasses.ProjectileDamageTypeSpinfusor'
	
	clientStatsClass	= None
	serverSettingsClass	= None
}