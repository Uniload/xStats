Class statDistanceSniper extends xStats.statDistance config(xStats);

defaultproperties
{
	minTargetAltitude=0
	minDistance=0
	MaxDistance=0
	minDamage=1.000000
	stylePointsPerStat=0
	logLevel=2
	Acronym="DMA"
	Description="Longest sniper rifle shot"
	awardDescription="Longest sniper rifle shot"
	personalMessage="%1 units"
	PersonalMessageClass=Class'xStats.xsDistanceStatMessage'
	
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
	Server_Acronym					=	"DMAS"
	Server_Description				=	"Longest sniper rifle shot"
	Server_awardDescription			=	"Longest sniper rifle shot"
	Server_PersonalMessageClass		=	Class'xStats.xsDistanceStatMessage'
	
	Server_targetMessageClass		=	class'xStats.xsTargetDistanceStatMessage'
}