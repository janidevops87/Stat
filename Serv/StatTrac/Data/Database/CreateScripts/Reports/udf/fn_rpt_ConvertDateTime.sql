IF EXISTS (SELECT * FROM sysobjects WHERE xtype = 'FN' AND name = 'fn_rpt_ConvertDateTime')
	BEGIN
		PRINT 'Dropping Function fn_rpt_ConvertDateTime'
		DROP  Function  fn_rpt_ConvertDateTime
	END

GO

PRINT 'Creating Function fn_rpt_ConvertDateTime'
GO
CREATE Function fn_rpt_ConvertDateTime (
		@vOrgID int,						/* Referral Facility OrganizationID/UserOrgId */
		@vDateTime datetime,				/* DateTime to convert */
		@vDisplayMountainTime int = Null	/* Option
												0 = Display Referral Facility/UserOrg Time
												1 = Display Mountain Time - Statline Employee */
)

RETURNS datetime AS 

/******************************************************************************
**		File: fn_rpt_ConvertDateTime.sql
**		Name: fn_rpt_ConvertDateTime
**		Desc: 
**
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		See Above
**
**		Auth: 
**		Date: 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------		-------------------------------------------
**      11/13/2007		ccarroll		initial
**		05/01/2011		Bret			Changed Code to look at TimeZone Table
*******************************************************************************/
 
 

BEGIN 
DECLARE
		@vOrgTZ as varchar(20),
		@vOrgTZdiff as int

/*
	Get Organization Time Zone from Organization ID
*/
SELECT @vOrgTZ = TimeZone.TimeZoneAbbreviation 
	from Organization 
	join TimeZone ON Organization.TimeZoneID = TimeZone.TimeZoneID
	where OrganizationID = @vOrgID


/*
	The following function determines if a Date is a DayLightSavings Date or Standard Time date. 
	For Time Zones that do not follow daylight savings the time difference is adjusted during 
	daylight savings. If a region does not follow daylight savings is in the Eastern Time Zone
	then during daylight savings, their time difference is only 1 hour.
*/

SELECT @vOrgTZdiff = dbo.fn_TimeZoneDifference(@vOrgTZ, @vDateTime)


/*
	If @vDisplayMountianTime is set to 1, the user running the report is a Statline
	Employee and the date/time will be displayed in mountian time. This is the default 
	for Statline Employee (userOrgID 194.) The Statline Employee may override this setting
	by opting to display date/time of the Referral Facility (@vDisplayMountainTime = 0)
	when it is required to match dates the client is viewing. 
*/
IF IsNull(@vDisplayMountainTime, 0) = 1
	BEGIN
	SET @vOrgTZdiff = 0
	END 

return DATEADD(hour, @vOrgTZdiff, @vDateTime)
END


GO

