IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'DashboardRecycleRestoreReferralsSelect')
	BEGIN
		PRINT 'Dropping Procedure DashboardRecycleRestoreReferralsSelect'
		DROP Procedure DashboardRecycleRestoreReferralsSelect
	END
GO
PRINT 'Creating Procedure DashboardRecycleRestoreReferralsSelect'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/******************************************************************************
**	File: DashboardRecycleRestoreReferralsSelect.sql
**	Name: DashboardRecycleRestoreReferralsSelect
**	Desc: List data before call is restored
**	Auth: jth
**	Date: Feb 2011
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
*******************************************************************************/

CREATE PROCEDURE DashboardRecycleRestoreReferralsSelect
	@callID INT
AS

	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 

SELECT 
   ReferralDonorFirstName,ReferralDonorLastName,ReferralDonorRecNumber,ReferralDonorNameMI, 
   LogEvent.LogEventDateTime,PersonFirst + ' ' + SUBSTRING(PersonLast,1,1) CreatedBy,
   LogEventTypeName,LogEventOrg,LogEventDesc,LogEventNumber,LogEventName
FROM LogEvent 
LEFT JOIN LogEventType ON LogEventType.LogEventTypeID = LogEvent.LogEventTypeID 
JOIN StatEmployee ON LogEvent.StatEmployeeID = StatEmployee.StatEmployeeID 
JOIN Person ON Person.PersonID = StatEmployee.PersonID 
left join Referral on Referral.CallID = LogEvent.CallID
where LogEvent.CallID = @callID
ORDER BY 
	LogEventDateTime ,
	LogEventNumber ; 