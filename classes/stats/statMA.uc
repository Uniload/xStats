Class statMA extends xsExtendedStat config(xStats);

defaultproperties
{
	statName						=	"statMA"

	minTargetAltitude=200
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
	
	Server_minTargetAltitude		=	200
	Server_minDistance				=	0
	Server_MaxDistance				=	12000
	Server_minDamage				=	44
	Server_MinTargetSpeed 			=	0
	Server_MaxTargetSpeed 			=	0
	Server_offensePointsPerStat		=	0
	Server_defensePointsPerStat		=	0
	Server_stylePointsPerStat		=	1
	Server_logLevel					=	3
	Server_Acronym					=	"MA"
	Server_Description				=	"Midair discs"
	Server_awardDescription			=	"Most midair discs"
	Server_PersonalMessageClass		=	Class'StatClasses.MPPersonalStatMessageDefault'
}