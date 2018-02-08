Class statEatDisc extends xsExtendedStat config(xStats);

defaultproperties
{
	minTargetAltitude=200
	minDistance=12000
	MaxDistance=0
	minDamage=44
	stylePointsPerStat=2
	logLevel=2
	Acronym="ED"
	Description="Eat discs"
	awardDescription="Most eat discs"
	personalMessage="+ EAT DISC! +"
	PersonalMessageClass=Class'StatClasses.MPPersonalStatMessageDefault'
	
	Server_minTargetAltitude		=	200
	Server_minDistance				=	12000
	Server_MaxDistance				=	0
	Server_minDamage				=	44
	Server_MinTargetSpeed 			=	0
	Server_MaxTargetSpeed 			=	0
	Server_offensePointsPerStat		=	0
	Server_defensePointsPerStat		=	0
	Server_stylePointsPerStat		=	2
	Server_logLevel					=	3
	Server_Acronym					=	"ED"
	Server_Description				=	"Eat discs"
	Server_awardDescription			=	"Most eat discs"
	Server_PersonalMessageClass		=	Class'StatClasses.MPPersonalStatMessageDefault'
}
