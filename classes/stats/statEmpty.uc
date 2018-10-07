Class statEmpty extends xsExtendedStat config(xStats);

/** Stats with an empty description will not be displayed on endscreen summary
 */

defaultproperties
{
	statName						=	""

	minTargetAltitude 				=	0
	minDistance 					=	0
	MaxDistance 					=	0
	minDamage 						=	0
	stylePointsPerStat 				=	0
	logLevel 						=	0
	Acronym 						=	""
	Description 					=	""
	awardDescription 				=	""
	personalMessage 				=	""
	PersonalMessageClass 			=	None
	
	Server_minTargetAltitude		=	0
	Server_minDistance				=	0
	Server_MaxDistance				=	0
	Server_minDamage				=	0
	Server_MinTargetSpeed 			=	0
	Server_MaxTargetSpeed 			=	0
	Server_offensePointsPerStat		=	0
	Server_defensePointsPerStat		=	0
	Server_stylePointsPerStat		=	0
	Server_logLevel					=	0
	Server_Acronym					=	""
	Server_Description				=	""
	Server_awardDescription			=	""
	Server_PersonalMessageClass		=	None
}