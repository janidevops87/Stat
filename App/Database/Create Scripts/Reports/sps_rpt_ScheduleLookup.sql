IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sps_rpt_ScheduleLookup')
BEGIN
	PRINT 'Dropping Procedure sps_rpt_ScheduleLookup';
	DROP Procedure sps_rpt_ScheduleLookup;
END
GO

PRINT 'Creating Procedure sps_rpt_ScheduleLookup';
GO
CREATE Procedure [dbo].[sps_rpt_ScheduleLookup]
	@ScheduleStartDateTime		datetime	= NULL,
	@ScheduleEndDateTime		datetime  	= NULL,
	@ScheduleOrganization		int			= NULL,
	@ScheduleGroup				int			= NULL,
	@DisplayMT					int			= NULL 


AS
	-- set transaction isolation level
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
/******************************************************************************
**		File: sps_rpt_ScheduleLookup.sql
**		Name: sps_rpt_ScheduleLookup
**		Desc: This sproc is used for ScheduleLookup and ScheduledContacts.
**
**		IMPORTANT: Please test both reports when any changes are made to this query.
**
**		Return values:
** 
**		Parameters:	See Above
**
**		Auth: ccarroll
**		Date: 07/18/2008
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:		Description:
**		--------		--------	-------------------------------------------
**		07/18/2008		ccarroll	Initial Release
**		08/24/2011		ccarroll	Corrected issue with datetime calculation	
**		06/21/2020		mberenson	Added to source control
**		06/21/2020		mberenson	Fixed logic & label for StartDT
**		02/17/2021		jegerberich	Added PersonIds for new combination report. TFS 72485
****************************************************************************/

SELECT
		ScheduleGroup.ScheduleGroupName,
		ScheduleItemName AS 'ShiftName',

		/* Schedule Item StartDT */
		CONVERT(varchar, dbo.fn_rpt_ConvertDateTime(@ScheduleOrganization, CAST(ScheduleItemStartDate + ' ' + ScheduleItemStartTime AS datetime), @DisplayMT), 101) + ' ' + 
		RIGHT('00' + CAST( DatePart(hh, dbo.fn_rpt_ConvertDateTime(@ScheduleOrganization, CAST(ScheduleItemStartDate + ' ' + ScheduleItemStartTime AS datetime), @DisplayMT)) AS varchar(2)), 2) + ':' +
		RIGHT('00' + CAST( DatePart(mi, dbo.fn_rpt_ConvertDateTime(@ScheduleOrganization, CAST(ScheduleItemStartDate + ' ' + ScheduleItemStartTime AS datetime), @DisplayMT)) AS varchar(2)), 2) + ', ' +
		LEFT( dbo.fn_ConvertDateToDayOfWeek(CONVERT(varchar, dbo.fn_rpt_ConvertDateTime(@ScheduleOrganization, CAST(ScheduleItemStartDate + ' ' + ScheduleItemStartTime AS datetime), @DisplayMT), 101)), 3) AS 'StartDT',

		/* Schedule Item EndDT */
		CONVERT(varchar, dbo.fn_rpt_ConvertDateTime(@ScheduleOrganization, CAST(ScheduleItemEndDate + ' ' + ScheduleItemEndTime AS datetime), @DisplayMT), 101) + ' ' + 
		RIGHT('00' + CAST( DatePart(hh, dbo.fn_rpt_ConvertDateTime(@ScheduleOrganization, CAST(ScheduleItemEndDate + ' ' + ScheduleItemEndTime AS datetime), @DisplayMT)) AS varchar(2)), 2) + ':' +
		RIGHT('00' + CAST( DatePart(mi, dbo.fn_rpt_ConvertDateTime(@ScheduleOrganization, CAST(ScheduleItemEndDate + ' ' + ScheduleItemEndTime AS datetime), @DisplayMT)) AS varchar(2)), 2) + ', ' +
		LEFT( dbo.fn_ConvertDateToDayOfWeek(CONVERT(varchar, dbo.fn_rpt_ConvertDateTime(@ScheduleOrganization, CAST(ScheduleItemEndDate + ' ' + ScheduleItemEndTime AS datetime), @DisplayMT), 101)), 3) AS 'EndDT',
		
		Person1.PersonID AS Person1Id,
		CASE WHEN Person1.Inactive = 1 
				THEN '(Inactive) ' + Person1.PersonFirst + ' '+ Person1.PersonLast 
				ELSE Person1.PersonFirst + ' '+ Person1.PersonLast
			END  AS 'OnCall1',

		Person2.PersonID AS Person2Id,
		CASE WHEN Person2.Inactive = 1 
				THEN '(Inactive) ' + Person2.PersonFirst + ' '+ Person2.PersonLast 
				ELSE Person2.PersonFirst + ' '+ Person2.PersonLast
		END  AS 'OnCall2',

		Person3.PersonID AS Person3Id,
		CASE WHEN Person3.Inactive = 1 
				THEN '(Inactive) ' + Person3.PersonFirst + ' '+ Person3.PersonLast 
				ELSE Person3.PersonFirst + ' '+ Person3.PersonLast 
		END  AS 'OnCall3',

		Person4.PersonID AS Person4Id,
		CASE WHEN Person4.Inactive = 1 
				THEN '(Inactive) ' + Person4.PersonFirst + ' '+ Person4.PersonLast 
				ELSE Person4.PersonFirst + ' '+ Person4.PersonLast 
		END  AS 'OnCall4',

		Person5.PersonID AS Person5Id,
		CASE WHEN Person5.Inactive = 1 
				THEN '(Inactive) ' + Person5.PersonFirst + ' '+ Person5.PersonLast 
				ELSE Person5.PersonFirst + ' '+ Person5.PersonLast 
		END  AS 'OnCall5',

		Person6.PersonID AS Person6Id,
		CASE WHEN Person6.Inactive = 1 
				THEN '(Inactive) ' + Person6.PersonFirst + ' '+ Person6.PersonLast 
				ELSE Person6.PersonFirst + ' '+ Person6.PersonLast 
		END  AS 'OnCall6'

FROM ScheduleItem
	LEFT JOIN ScheduleGroup ON ScheduleItem.ScheduleGroupID = ScheduleGroup.ScheduleGroupID
	
	/* OnCall joins*/
	LEFT JOIN ScheduleItemPerson AS PersonOnCall1 ON ScheduleItem.ScheduleItemID = PersonOnCall1.ScheduleItemID AND (PersonOnCall1.Priority = 1)
	LEFT JOIN Person AS Person1 ON Person1.PersonID = PersonOnCall1.PersonID 

	LEFT JOIN ScheduleItemPerson AS PersonOnCall2 ON ScheduleItem.ScheduleItemID = PersonOnCall2.ScheduleItemID AND (PersonOnCall2.Priority = 2)
	LEFT JOIN Person AS Person2 ON Person2.PersonID = PersonOnCall2.PersonID 

	LEFT JOIN ScheduleItemPerson AS PersonOnCall3 ON ScheduleItem.ScheduleItemID = PersonOnCall3.ScheduleItemID AND (PersonOnCall3.Priority = 3)
	LEFT JOIN Person AS Person3 ON Person3.PersonID = PersonOnCall3.PersonID

	LEFT JOIN ScheduleItemPerson AS PersonOnCall4 ON ScheduleItem.ScheduleItemID = PersonOnCall4.ScheduleItemID AND (PersonOnCall4.Priority = 4)
	LEFT JOIN Person AS Person4 ON Person4.PersonID = PersonOnCall4.PersonID  

	LEFT JOIN ScheduleItemPerson AS PersonOnCall5 ON ScheduleItem.ScheduleItemID = PersonOnCall5.ScheduleItemID AND (PersonOnCall5.Priority = 5)
	LEFT JOIN Person AS Person5 ON Person5.PersonID = PersonOnCall5.PersonID  

	LEFT JOIN ScheduleItemPerson AS PersonOnCall6 ON ScheduleItem.ScheduleItemID = PersonOnCall6.ScheduleItemID AND (PersonOnCall6.Priority = 6)
	LEFT JOIN Person AS Person6 ON Person6.PersonID = PersonOnCall6.PersonID  

WHERE 
	ScheduleItem.ScheduleGroupID = @ScheduleGroup
	AND ((ScheduleItemStartDate >= @ScheduleStartDateTime AND ScheduleItemStartDate <= @ScheduleEndDateTime) 
		OR (ScheduleItemEndDate >= @ScheduleStartDateTime AND ScheduleItemEndDate <= @ScheduleEndDateTime)) 

ORDER BY 
	ScheduleItemStartDate + ' ' + ScheduleItemStartTime;
	
GO

GRANT EXEC ON sps_rpt_ScheduleLookup TO PUBLIC;
GO