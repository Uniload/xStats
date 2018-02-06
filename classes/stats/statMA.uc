Class statMA extends xsExtendedStat config(xStats);

defaultproperties
{
	showDistance=True
	minTargetAltitude=0
	minDistance=0
	MaxDistance=12000
	minDamage=44.000000
	stylePointsPerStat=1
	logLevel=2
	Acronym="MA"
	Description="Midair discs"
	awardDescription="Most midair discs"
	personalMessage="You midair disced %1"
	PersonalMessageClass=Class'StatClasses.MPPersonalStatMessageDefault'
}