Class statSweetShot extends xsExtendedStat config(xStats);

defaultproperties
{
	statName						=	"statSweetShot"

	minTargetAltitude=0
	minDistance=5000
	MaxDistance=0
	minTargetSpeed=150
	minDamage=44.000000
	stylePointsPerStat=2
	logLevel=2
	Acronym="SS"
	Description="Sweet shots"
	awardDescription="Most sweet shots"
	personalMessage="+   SWEET SHOT   +"
	PersonalMessageClass=Class'StatClasses.MPPersonalStatMessageDefault'
	
	Server_minTargetAltitude		=	0
	Server_minDistance				=	8000
	Server_MaxDistance				=	0
	Server_MinTargetSpeed 			=	100
	Server_MaxTargetSpeed 			=	0
	Server_minDamage				=	44
	Server_bAllowTargetInVehicleOrTurret	=	True
	Server_offensePointsPerStat		=	0
	Server_defensePointsPerStat		=	0
	Server_stylePointsPerStat		=	2
	Server_logLevel					=	3
	Server_Acronym					=	"SS"
	Server_Description				=	"Sweet shots"
	Server_awardDescription			=	"Most sweet shots"
	Server_PersonalMessageClass		=	Class'StatClasses.MPPersonalStatMessageDefault'
}
