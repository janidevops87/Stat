IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[sps_rpt_MessageDetail_EventLog_Select]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	PRINT 'Dropping Procedure: sps_rpt_MessageDetail_EventLog_Select';
	DROP  Procedure  sps_rpt_MessageDetail_EventLog_Select;
END
GO

PRINT 'Creating Procedure: sps_rpt_MessageDetail_EventLog_Select';
GO

CREATE PROCEDURE sps_rpt_MessageDetail_EventLog_Select
     @CallID    INT = NULL,
     @DisplayMT	INT = NULL

AS

/******************************************************************************
**		File: sps_rpt_MessageDetail_EventLog_Select.sql
**		Name: sps_rpt_MessageDetail_EventLog_Select
**		Desc: This sproc returns log event notes for ReferralDetail report
**
**              
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------						-----------
**
**		Auth: jth
**		Date: 5/08
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	-------				-------------------------------------------
**		10/01/2008	ccarroll			Added for Archive and Production databases
**		12/08/2009	ccarroll			Removed table alias in ORDER BY for SQL Server 2008 update
**		03/16/2010	ccarroll			Added this note for inclusion in release
**      10/28/2020  Mike Berenson       Added table aliases and applied formatting
**      10/28/2020  Mike Berenson       Fixed bad alias
*******************************************************************************/

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

SELECT
	le.CallID,
	le.LogEventNumber,
	CONVERT(CHAR(10),dbo.fn_rpt_ConvertDateTime(m.OrganizationID, le.LogEventDateTime,	@DisplayMT),1) + 
        SUBSTRING(CONVERT(CHAR(10),dbo.fn_rpt_ConvertDateTime(m.OrganizationID, le.LogEventDateTime,	@DisplayMT),8),1,5) 
        AS LogEventDateTime,
    LEFT(p.PersonFirst,1) + CASE  WHEN p.PersonMI IS NULL THEN '' ELSE p.PersonMI END + LEFT(p.PersonLast,1) AS 'LogEventBy',
    let.LogEventTypeName, 
    le.LogEventOrg,
    le.LogEventName AS 'LogEventToFrom',
	le.LogEventDesc
FROM      
    LogEvent le
    LEFT JOIN Message m ON m.CallID = le.CallID
    LEFT JOIN LogEventType let ON let.LogEventTypeID = le.LogEventTypeID
    LEFT JOIN StatEmployee se ON se.StatEmployeeID = le.StatEmployeeID
    LEFT JOIN Person p ON p.PersonID = se.PersonID
WHERE     
    le.CallID = @CallID
    AND (le.LogEventDeleted IS NULL OR le.LogEventDeleted <> 1)
ORDER BY  
    le.LogEventDateTime,
	le.LogEventNumber;


GO


 