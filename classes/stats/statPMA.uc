Class statPMA extends xsExtendedStat config(xStats);

defaultproperties
{
	statName						=	"statPMA"

    minTargetAltitude=400
    minDamage=43.000000
    stylePointsPerStat=1
    logLevel=2
    Acronym="PMA"
    Description="Plasma midairs"
    awardDescription="Most plasma midairs"
    personalMessage="You plasma midaired %1"
    PersonalMessageClass=Class'StatClasses.MPPersonalStatMessageDefault'
	 
	Server_minTargetAltitude		=	200
	Server_minDistance				=	0
	Server_MaxDistance				=	0
	Server_MinTargetSpeed 			=	0
	Server_MaxTargetSpeed 			=	0
	Server_minDamage				=	40
	Server_bAllowTargetInVehicleOrTurret	=	False
	Server_offensePointsPerStat		=	0
	Server_defensePointsPerStat		=	0
	Server_stylePointsPerStat		=	1
	Server_logLevel					=	3
	Server_Acronym					=	"PMA"
	Server_Description				=	"Plasma midairs"
	Server_awardDescription			=	"Most plasma midairs"
	Server_PersonalMessageClass		=	Class'StatClasses.MPPersonalStatMessageDefault'
}
