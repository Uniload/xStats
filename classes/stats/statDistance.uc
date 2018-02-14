Class statDistance extends xsExtendedStat config(xStats);

defaultproperties
{
	statName						=	"statDistance"

	minTargetAltitude=0
	minDistance=0
	MaxDistance=0
	minDamage=1.000000
	stylePointsPerStat=0
	logLevel=2
	Acronym="DMA"
	Description="Longest midair"
	awardDescription="Longest midair"
	personalMessage="%1 units"
	PersonalMessageClass=Class'xStats_b1.xsDistanceStatMessage'
	
	Server_minTargetAltitude		=	0
	Server_minDistance				=	0
	Server_MaxDistance				=	0
	Server_minDamage				=	1
	Server_MinTargetSpeed 			=	0
	Server_MaxTargetSpeed 			=	0
	Server_offensePointsPerStat		=	0
	Server_defensePointsPerStat		=	0
	Server_stylePointsPerStat		=	0
	Server_logLevel					=	3
	Server_Acronym					=	"DMA"
	Server_Description				=	"Longest hit"
	Server_awardDescription			=	"Longest hit"
	Server_PersonalMessageClass		=	Class'xStats_b1.xsDistanceStatMessage'
	
	Server_targetMessageClass		=	class'xStats_b1.xsTargetDistanceStatMessage'
}