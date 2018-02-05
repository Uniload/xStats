Class statDistance extends xsExtendedStat config(xStats);

defaultproperties
{
	showDistance=False
	minTargetAltitude=200
	minDistance=0
	MaxDistance=99000
	minDamage=1.000000
	stylePointsPerStat=0
	logLevel=3
	Acronym="DMA"
	Description="Longest midair"
	awardDescription="Longest midair"
	personalMessage="%1 units"
	PersonalMessageClass=Class'xStats.xsDistanceStatMessage'
}