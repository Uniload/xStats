Class statGLMA extends xsExtendedStat config(xStats);

defaultproperties
{
	statName						=	"statGLMA"

    minTargetAltitude=200
    minDamage=44.000000
    stylePointsPerStat=2
    logLevel=2
    Acronym="GLMA"
    Description="Grenade launcher midairs"
    awardDescription="Most grenade launcher midairs"
    personalMessage="You grenade midaired %1"
    PersonalMessageClass=Class'StatClasses.MPPersonalStatMessageDefault'
	 
	Server_minTargetAltitude		=	200
	Server_minDistance				=	0
	Server_MaxDistance				=	0
	Server_minDamage				=	44
	Server_MinTargetSpeed 			=	0
	Server_MaxTargetSpeed 			=	0
	Server_offensePointsPerStat		=	0
	Server_defensePointsPerStat		=	0
	Server_stylePointsPerStat		=	2
	Server_logLevel					=	3
	Server_Acronym					=	"GLMA"
	Server_Description				=	"Grenade launcher midairs"
	Server_awardDescription			=	"Most grenade launcher midairs"
	Server_PersonalMessageClass		=	Class'StatClasses.MPPersonalStatMessageDefault'
}
