Class statRocketeer extends xsExtendedStat config(xStats);

defaultproperties
{
    minTargetSpeed=115.000000
    minDistance=750
    minDamage=45.000000
    stylePointsPerStat=0
    logLevel=2
    Acronym="R"
    Description="Rocketeers"
    awardDescription="The Rocketeer"
    personalMessage="+ Rocketeer +"
    PersonalMessageClass=Class'StatClasses.MPPersonalStatMessageDefault'
	 
	 
	Server_minTargetAltitude		=	200
	Server_minDistance				=	0
	Server_MaxDistance				=	0
	Server_MinTargetSpeed 			=	0
	Server_MaxTargetSpeed 			=	0
	Server_minDamage				=	20
	Server_bAllowTargetInVehicleOrTurret	=	True
	Server_offensePointsPerStat		=	0
	Server_defensePointsPerStat		=	0
	Server_stylePointsPerStat		=	1
	Server_logLevel					=	3
	Server_Acronym					=	"R"
	Server_Description				=	"Rocketeers"
	Server_awardDescription			=	"The Rocketeer"
	Server_PersonalMessageClass		=	Class'xStats.xsNoScoreStatMessage'
}
