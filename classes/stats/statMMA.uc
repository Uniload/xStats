Class statMMA extends xsExtendedStat config(xStats);

defaultproperties
{
	statName						=	"statMMA"

    minTargetAltitude=800
    minDamage=115.000000
    stylePointsPerStat=4
    logLevel=2
    Acronym="MMA"
    Description="Mortar midair"
    awardDescription="Most mortar midairs"
    personalMessage="You mortar midaired %1"
    PersonalMessageClass=Class'StatClasses.MPPersonalStatMessageDefault'
	 
	Server_minTargetAltitude		=	200
	Server_minDistance				=	0
	Server_MaxDistance				=	0
	Server_minDamage				=	115
	Server_MinTargetSpeed 			=	0
	Server_MaxTargetSpeed 			=	0
	Server_offensePointsPerStat		=	0
	Server_defensePointsPerStat		=	0
	Server_stylePointsPerStat		=	4
	Server_logLevel					=	3
	Server_Acronym					=	"MMA"
	Server_Description				=	"Mortar midair"
	Server_awardDescription			=	"Most mortar midairs"
	Server_PersonalMessageClass		=	Class'StatClasses.MPPersonalStatMessageDefault'
}
