class xsExtendedStat extends Gameplay.ExtendedStat;

var string statName;

var config bool Server_notifyTarget;
var config class<MPPersonalMessage> Server_targetMessageClass;
var config string targetMessage;

var config int Server_minTargetAltitude;
var config int Server_minDistance;
var config int Server_MaxDistance;
var config float Server_MinTargetSpeed;
var config float Server_MaxTargetSpeed;
var config float Server_minDamage;
var config bool Server_bAllowTargetInVehicleOrTurret;
var config int Server_offensePointsPerStat;
var config int Server_defensePointsPerStat;
var config int Server_stylePointsPerStat;
var config int Server_logLevel;
var config string Server_Acronym;
var config string Server_Description;
var config string Server_awardDescription;
var config class<MPPersonalMessage> Server_PersonalMessageClass;

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
	statName						=	"Default"

	Server_minTargetAltitude		=	0
	Server_minDistance				=	0
	Server_MaxDistance				=	0
	Server_MinTargetSpeed 			=	0
	Server_MaxTargetSpeed 			=	0
	Server_minDamage				=	0
	Server_bAllowTargetInVehicleOrTurret	=	False
	Server_offensePointsPerStat		=	0
	Server_defensePointsPerStat		=	0
	Server_stylePointsPerStat		=	0
	Server_logLevel					=	3
	Server_Acronym					=	"NONE"
	Server_Description				=	"Default"
	Server_awardDescription			=	"Default"
	Server_PersonalMessageClass		=	Class'StatClasses.MPPersonalStatMessageDefault'
	Server_notifyTarget				=	True
	Server_targetMessageClass		=	class'xStats.xsTargetStatMessage'
	targetMessage					=	"Hit by %1"
}