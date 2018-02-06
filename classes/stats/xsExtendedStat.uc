class xsExtendedStat extends Gameplay.ExtendedStat;

var bool showDistance;

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

/*

// CUSTOM DISTANCE STAT
	if (False && default.showDistance)
	{
		PC = PlayerController(Source);
		if (PC != None)
		{
			PC.ReceiveLocalizedMessage(class'xStats.statDistance'.default.personalMessageClass, 0, class'xStats.statDistance',,, string(relativeDistance*0.0125));
		}
	}

*/

defaultproperties
{
	showDistance = False
}