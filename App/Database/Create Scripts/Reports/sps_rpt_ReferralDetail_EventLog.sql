IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[sps_rpt_ReferralDetail_EventLog]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
	BEGIN
		PRINT 'Dropping Procedure: sps_rpt_ReferralDetail_EventLog';
		DROP  PROCEDURE  sps_rpt_ReferralDetail_EventLog;
	END

GO

PRINT 'Creating Procedure: sps_rpt_ReferralDetail_EventLog'
GO

SET QUOTED_IDENTIFIER OFF;
GO
SET ANSI_NULLS ON;
GO

CREATE PROCEDURE [dbo].[sps_rpt_ReferralDetail_EventLog]
(
	@CallID		int,
	@DisplayMT	int = NULL
)
AS

/******************************************************************************
**	File: sps_rpt_ReferralDetail_EventLog.sql
**	Name: sps_rpt_ReferralDetail_EventLog
**	Desc: This sproc returns log event notes for ReferralDetail report
**	
**	
**	Return values:
**	
**	Called by: ReferralDetail.rdl
**	
**	Parameters:
**	Input				Output
**	----------			-----------
**	@CallID		int
**	@DisplayMT	int
**	
**	
**	Auth: ccarroll
**	Date: 06/14/2007
**	
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:		Author:			Description:
**	--------	--------		-------------------------------------------
**	06/20/2007	ccarroll		Initial release
**	06/21/2007	ccarroll		StatTrac 8.4 release, deleted events
**	11/14/2007	ccarroll		updates for converting date/time
**	10/02/2008	ccarroll		Added select sproc for Archive and Production db
**	12/08/2009	ccarroll		Removed table alias in ORDER BY for SQL 2008 Server update
**	03/16/2010	ccarroll		Added this note for inclusion in release
**	06/15/2011	ccarroll		Added SortByEventDateTime field (not displayed on report) Was sorting by string datetime HS:26589
**	08/04/2020	James Gerberich	Refactored. VS 69297
*******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SET NOCOUNT ON;

SELECT
	LogEvent.CallID,
	LogEvent.LogEventNumber,
	dbo.fn_rpt_ConvertDateTime(Referral.ReferralCallerOrganizationID, LogEventDateTime, @DisplayMT) AS LogEventDateTime,
	LEFT(PersonFirst,1) +  IsNULL(PersonMI, '') + LEFT(PersonLast,1) AS 'LogEventBy',
	LogEventTypeName,
	LogEventOrg,
	LogEventName AS 'LogEventToFrom',
	LogEventDesc
FROM
	LogEvent
	LEFT JOIN Referral ON Referral.CallID = LogEvent.CallID
	LEFT JOIN LogEventType ON LogEventType.LogEventTypeID = LogEvent.LogEventTypeID
	LEFT JOIN StatEmployee ON StatEmployee.StatEmployeeID = LogEvent.StatEmployeeID
	LEFT JOIN Person ON Person.PersonID = StatEmployee.PersonID
WHERE
	LogEvent.CallID = @CallID
AND	(
		LogEventDeleted IS NULL
	OR	LogEventDeleted = 0
	)
ORDER BY
	LogEventDateTime,
	LogEventNumber;

GO
SET QUOTED_IDENTIFIER OFF;
GO
SET ANSI_NULLS ON;
GO
