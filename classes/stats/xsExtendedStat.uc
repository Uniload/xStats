class xsExtendedStat extends Gameplay.ExtendedStat;

var config int Server_minTargetAltitude;
var config int Server_minDistance;
var config int Server_MaxDistance;
var config int Server_minDamage;
var config int Server_offensePointsPerStat;
var config int Server_defensePointsPerStat;
var config int Server_stylePointsPerStat;
var config int Server_logLevel;
var config string Server_Acronym;
var config string Server_Description;
var config string Server_awardDescription;
var config string Server_personalMessage;
var config class<MPPersonalMessage> Server_PersonalMessageClass;

simulated function setStats()
{
	ServerSaveConfig();
	
	(Self.class).default.minTargetAltitude = Server_minTargetAltitude;
	(Self.class).default.minDistance = Server_minDistance;
	(Self.class).default.MaxDistance = Server_MaxDistance;
	(Self.class).default.minDamage = Server_minDamage;
	(Self.class).default.offensePointsPerStat = Server_offensePointsPerStat;
	(Self.class).default.defensePointsPerStat = Server_defensePointsPerStat;
	(Self.class).default.stylePointsPerStat = Server_stylePointsPerStat;
	(Self.class).default.logLevel = Server_logLevel;
	(Self.class).default.Acronym = Server_Acronym;
	(Self.class).default.Description = Server_Description;
	(Self.class).default.awardDescription = Server_awardDescription;
	(Self.class).default.personalMessage = Server_personalMessage;
	(Self.class).default.PersonalMessageClass = Server_PersonalMessageClass;
}

function ServerSaveConfig()
{
	SaveConfig();
}

static function bool isEligible(Controller Source, Controller Target, float damageAmount)
{
	local vector hitLocation, hitNormal, startTrace, endTrace;
	local int relativeDistance;
	local Character targetCharacter;
	//local PlayerController pc;
	local PlayerCharacterController pcc;

	if (Target == None || Source == None)
		return false;

	// Damage check, but only if target is alive
	if (Target.Pawn.IsAlive() && damageAmount < default.minDamage)
		return false;

	// Vehicle/turret check
	pcc = PlayerCharacterController(Target);
	if (!default.bAllowTargetInVehicleOrTurret && pcc != None && !pcc.IsInState('CharacterMovement'))
		return false;

	// Minimum distance check
	relativeDistance = VSize(Source.Pawn.Location - Target.Pawn.Location);
	if (relativeDistance < default.minDistance)
		return false;

	// Maximum distance check
	if (default.maxDistance != 0 && relativeDistance >= default.maxDistance)
		return false;

	// Minimum target altitude check
	startTrace = Target.Pawn.Location;
	endTrace = Target.Pawn.Location;
	endTrace.z -= default.minTargetAltitude;
	if (Target.Trace(hitLocation, hitNormal, endTrace, startTrace) != None)
		return false;

	// Minimum target speed check
	targetCharacter = Character(Target.Pawn);
	if (targetCharacter.movementSpeed < default.minTargetSpeed)
		return false;

	// Maximum target speed check
	if (default.maxTargetSpeed != 0 && targetCharacter.movementSpeed >= default.maxTargetSpeed)
		return false;
		
	// If this point is reached, all tests passed and the stat is awarded
	
	return true;
}

defaultproperties
{
}