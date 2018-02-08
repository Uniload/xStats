Class statEBMA extends xsExtendedStat config(xStats);

defaultproperties
{
    minTargetAltitude=200
    minDamage=1.000000
    stylePointsPerStat=1
    logLevel=2
    Acronym="MAEB"
    Description="Knife midairs"
    awardDescription="Most midair stabs"
    personalMessage="You midair knifed %1"
    PersonalMessageClass=Class'StatClasses.MPPersonalStatMessageDefault'
	 
	Server_minTargetAltitude		=	200
	Server_minDistance				=	0
	Server_MaxDistance				=	0
	Server_minDamage				=	1
	Server_MinTargetSpeed 			=	0
	Server_MaxTargetSpeed 			=	0
	Server_offensePointsPerStat		=	0
	Server_defensePointsPerStat		=	0
	Server_stylePointsPerStat		=	1
	Server_logLevel					=	3
	Server_Acronym					=	"MAEB"
	Server_Description				=	"Knife midairs"
	Server_awardDescription			=	"Most midair stabs"
	Server_PersonalMessageClass		=	Class'StatClasses.MPPersonalStatMessageDefault'
}
