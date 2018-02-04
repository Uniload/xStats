class main extends Gameplay.Mutator config(xStats);

/**
 *	Extended game stats
 *	Thanks schlieperich for laying the first stone years before I even knew about tribes.
**/

const VERSION_NAME = "xStats_b1";

var config bool bCompatibilityMode;
var config class<EquipmentClasses.ProjectileDamageTypeDefault> sniperProjectileDamageType;

simulated event PreBeginPlay()
{
	Super.PreBeginPlay();
	
	ModifyStats();
}

simulated event PostBeginPlay()
{
	Super.PostBeginPlay();
	
	ServerSaveConfig();
	
	//No idea how to spawn for client only
	spawn(class'xStats.ClientStats');
	
	
	if (Level.NetMode != NM_Client)	{
		log("xStats: Running in server mode");
		spawn(class'xStats.ServerSettings');
	}
}

function ServerSaveConfig()
{
	SaveConfig();
}

simulated function ModifyStats()
{
	local ModeInfo M;
	local int i, statCount;

	M = ModeInfo(Level.Game);

	if(M != None)
	{
		for(i = 0; i < M.extendedProjectileDamageStats.Length; ++i)
		{
			// Set Extended stat to SMA
			if(M.extendedProjectileDamageStats[i].damageTypeClass == Class'EquipmentClasses.ProjectileDamageTypeSpinfusor')
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
		if (bCompatibilityMode) {
			M.projectileDamageStats[statCount].damageTypeClass = sniperProjectileDamageType;
		} else {
			M.projectileDamageStats[statCount].damageTypeClass = Class'EquipmentClasses.ProjectileDamageTypeSniperRifle';
		}
		M.projectileDamageStats[statCount].headShotStatClass = Class'StatHS';
		M.projectileDamageStats[statCount].playerDamageStatClass = Class'xStats.xsExtendedStat';
		++statCount;		
		
                // ### EXTENDED DAMAGE STATS ###

		statCount = M.extendedProjectileDamageStats.Length;
		
		M.extendedProjectileDamageStats.Insert(statCount, 10); // we have 10 new stats
		
		// statMAPlus
		M.extendedProjectileDamageStats[statCount].damageTypeClass = Class'EquipmentClasses.ProjectileDamageTypeSpinfusor';
		M.extendedProjectileDamageStats[statCount].extendedStatClass = Class'statMAPlus';
		++statCount;
		
		// statMASupreme
		M.extendedProjectileDamageStats[statCount].damageTypeClass = Class'EquipmentClasses.ProjectileDamageTypeSpinfusor';
		M.extendedProjectileDamageStats[statCount].extendedStatClass = Class'statMASupreme';
		++statCount;
		
		// statEatDisc
		M.extendedProjectileDamageStats[statCount].damageTypeClass = Class'EquipmentClasses.ProjectileDamageTypeSpinfusor';
		M.extendedProjectileDamageStats[statCount].extendedStatClass = Class'statEatDisc';
		++statCount;
		
		// statOMG
		M.extendedProjectileDamageStats[statCount].damageTypeClass = Class'EquipmentClasses.ProjectileDamageTypeExplosion';
		M.extendedProjectileDamageStats[statCount].extendedStatClass = Class'statOMG';
		++statCount;
		
		// PMA
		M.extendedProjectileDamageStats[statCount].damageTypeClass = Class'EquipmentClasses.ProjectileDamageTypeBurner';
		M.extendedProjectileDamageStats[statCount].extendedStatClass = Class'statPMA';
		++statCount;
		
		// E-Blade
		M.extendedProjectileDamageStats[statCount].damageTypeClass = Class'EquipmentClasses.ProjectileDamageTypeDefault';
		M.extendedProjectileDamageStats[statCount].extendedStatClass = Class'statEBMA';
		++statCount;
		
		// statRocketeer
		M.extendedProjectileDamageStats[statCount].damageTypeClass = Class'EquipmentClasses.ProjectileDamageTypeRocketPod';
		M.extendedProjectileDamageStats[statCount].extendedStatClass = Class'statRocketeer';
		++statCount;
		
		// GLMA
		M.extendedProjectileDamageStats[statCount].damageTypeClass = Class'EquipmentClasses.ProjectileDamageTypeGrenadeLauncher';
		M.extendedProjectileDamageStats[statCount].extendedStatClass = Class'statGLMA';
		++statCount;

		// MMA
		M.extendedProjectileDamageStats[statCount].damageTypeClass = Class'EquipmentClasses.ProjectileDamageTypeMortar';
		M.extendedProjectileDamageStats[statCount].extendedStatClass = Class'statMMA';
		++statCount;
		
		// statSweetShot
		M.extendedProjectileDamageStats[statCount].damageTypeClass = Class'EquipmentClasses.ProjectileDamageTypeExplosion';
		M.extendedProjectileDamageStats[statCount].extendedStatClass = Class'statSweetShot';
		++statCount;
	}
}

defaultproperties
{
	bCompatibilityMode=False
	sniperProjectileDamageType = Class'promod_v1rc7_b3.promodSniperProjectileDamageType'