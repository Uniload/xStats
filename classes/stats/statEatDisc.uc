Class statEatDisc extends xsExtendedStat config(xStats);

defaultproperties
{
	showDistance=True
	minTargetAltitude=200
	minDistance=000
	MaxDistance=30000
	minDamage=1.000000
	stylePointsPerStat=2
	logLevel=2
	Acronym="ED"
	Description="Eat discs"
	awardDescription="Most eat discs"
	personalMessage="+ EAT DISC! +"
	PersonalMessageClass=Class'StatClasses.MPPersonalStatMessageDefault'
}
