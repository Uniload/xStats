Class statMAPlus extends xsExtendedStat config(xStats);

defaultproperties
{
	statName						=	"statMAPlus"

	minTargetAltitude=200
	minDistance=3000
	MaxDistance=6000
	minDamage=44.000000
	stylePointsPerStat=1
	logLevel=2
	Acronym="MAP"
	Description="Midair plus"
	awardDescription="Most midair pluses"
	personalMessage="+ MIDAIR PLUS! +"
	PersonalMessageClass=Class'StatClasses.MPPersonalStatMessageDefault'
	
	Server_minTargetAltitude		=	200
	Server_minDistance				=	3000
	Server_MaxDistance				=	6000
	Server_minDamage				=	44
	Server_MinTargetSpeed 			=	0
	Server_MaxTargetSpeed 			=	0
	Server_offensePointsPerStat		=	0
	Server_defensePointsPerStat		=	0
	Server_stylePointsPerStat		=	1
	Server_logLevel					=	3
	Server_Acronym					=	"MAP"
	Server_Description				=	"Midair plus"
	Server_awardDescription			=	"Most midair pluses"
	Server_PersonalMessageClass		=	Class'StatClasses.MPPersonalStatMessageDefault'
}
