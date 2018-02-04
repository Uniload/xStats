Class statMAPlus extends xsExtendedStat config(xStats);

// MA longer range stat

defaultproperties
{
	minTargetAltitude=200
	minDistance=3000
	MaxDistance=6000
	minDamage=44.000000
	stylePointsPerStat=1
	logLevel=3
	Acronym="MAP"
	Description="Midair plus"
	awardDescription="Most midair pluses"
	personalMessage="+ MIDAIR PLUS! +"
	PersonalMessageClass=Class'StatClasses.MPPersonalStatMessageDefault'
}
