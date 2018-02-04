Class statEatDisc extends xsExtendedStat config(xStats);

// MA Ultra Long Range stat

defaultproperties
{
	minTargetAltitude=200
	minDistance=12000
	MaxDistance=30000
	minDamage=44.000000
	stylePointsPerStat=2
	logLevel=3
	Acronym="ED"
	Description="Eat discs"
	awardDescription="Most eat discs"
	personalMessage="+ EAT DISC! +"
	PersonalMessageClass=Class'StatClasses.MPPersonalStatMessageDefault'
}
