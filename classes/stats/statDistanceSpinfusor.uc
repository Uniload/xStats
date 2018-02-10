Class statDistanceSpinfusor extends xStats.statDistance config(xStats);

defaultproperties
{
	statName						=	"statDistanceSpinfusor"

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
	PersonalMessageClass=Class'xStats.xsDistanceStatMessage'
	
	Server_minTargetAltitude		=	0
	Server_minDistance				=	4000
	Server_MaxDistance				=	0
	Server_minDamage				=	1
	Server_MinTargetSpeed 			=	0
	Server_MaxTargetSpeed 			=	0
	Server_offensePointsPerStat		=	0
	Server_defensePointsPerStat		=	0
	Server_stylePointsPerStat		=	0
	Server_logLevel					=	3
	Server_Acronym					=	"DMAD"
	Server_Description				=	"Longest Disc midair"
	Server_awardDescription			=	"Longest Disc midair"
	Server_PersonalMessageClass		=	Class'xStats.xsDistanceStatMessage'
	
	Server_targetMessageClass		=	class'xStats.xsTargetDistanceStatMessage'
}