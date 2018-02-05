Class statHS extends xsExtendedStat config(xStats);

/**
 *	Since sniper is not an extended stat, distance will not work.
 */
defaultproperties
{
	showDistance=True
	stylePointsPerStat=1
    logLevel=2
    Acronym="HS"
	Description="Headshots"
    awardDescription="Most head shots"
    personalMessage="-Head Shot!-"
    PersonalMessageClass=Class'StatClasses.MPPersonalStatMessageDefault'
}