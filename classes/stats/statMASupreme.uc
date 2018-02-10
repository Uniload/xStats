Class statMASupreme extends xsExtendedStat config(xStats);

defaultproperties
{
	statName						=	"statMASupreme"

	minTargetAltitude=200
	minDistance=6000
	MaxDistance=12000
	minDamage=44.000000
	stylePointsPerStat=1
	logLevel=2
	Acronym="MAS"
	Description="Midair supremes"
	awardDescription="Most midair supremes"
	personalMessage="+ MIDAIR SUPREME! +"
	PersonalMessageClass=Class'StatClasses.MPPersonalStatMessageDefault'
	
	Server_minTargetAltitude		=	200
	Server_minDistance				=	8000
	Server_MaxDistance				=	12000
	Server_minDamage				=	44
	Server_MinTargetSpeed 			=	0
	Server_MaxTargetSpeed 			=	0
	Server_offensePointsPerStat		=	0
	Server_defensePointsPerStat		=	0
	Server_stylePointsPerStat		=	1
	Server_logLevel					=	3
	Server_Acronym					=	"MAS"
	Server_Description				=	"Midair supremes"
	Server_awardDescription			=	"Most midair supremes"
	Server_PersonalMessageClass		=	Class'StatClasses.MPPersonalStatMessageDefault'
}
