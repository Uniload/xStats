Class statDistance extends xsExtendedStat config(xStats);

defaultproperties
{
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
	Server_minDistance				=	0
	Server_MaxDistance				=	0
	Server_minDamage				=	50
	Server_offensePointsPerStat		=	0
	Server_defensePointsPerStat		=	0
	Server_stylePointsPerStat		=	0
	Server_logLevel					=	3
	Server_Acronym					=	"DMA"
	Server_Description				=	"Longest DISC midair"
	Server_awardDescription			=	"Longest DISC midair"
	Server_personalMessage			=	"%1 units"
	Server_PersonalMessageClass		=	Class'xStats.xsDistanceStatMessage'
}