Class statOMG extends xsExtendedStat config(xStats);

defaultproperties
{
	statName						=	"statOMG"

	minTargetAltitude=200
	minDistance=30000
	MaxDistance=900000
	minDamage=44.000000
	stylePointsPerStat=3
	logLevel=2
	Acronym="OMG"
	Description="O   M   G  's"
	awardDescription="Most O   M   G 's"
	personalMessage="     +   O   M   G   +     "
	PersonalMessageClass=Class'StatClasses.MPPersonalStatMessageDefault'
	
	Server_minTargetAltitude		=	200
	Server_minDistance				=	8000
	Server_MaxDistance				=	0
	Server_MinTargetSpeed 			=	200
	Server_MaxTargetSpeed 			=	0
	Server_minDamage				=	44
	Server_bAllowTargetInVehicleOrTurret	=	True
	Server_offensePointsPerStat		=	0
	Server_defensePointsPerStat		=	0
	Server_stylePointsPerStat		=	3
	Server_logLevel					=	3
	Server_Acronym					=	"OMG"
	Server_Description				=	"O M G 's"
	Server_awardDescription			=	"Most O M G 's"
	Server_PersonalMessageClass		=	Class'StatClasses.MPPersonalStatMessageDefault'
}
