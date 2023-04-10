IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_rpt_ImportOfferDetail_Select')
BEGIN
    PRINT 'Dropping Procedure sps_rpt_ImportOfferDetail_Select';
	DROP PROCEDURE  sps_rpt_ImportOfferDetail_Select;
END
GO

PRINT 'Creating Procedure sps_rpt_ImportOfferDetail_Select';
GO

CREATE PROCEDURE [dbo].[sps_rpt_ImportOfferDetail_Select]
    @UserOrgID      INT         = NULL,
    @ReportGroupID  INT         = NULL,
    @CallID         INT         = NULL,
    @StartDateTime  DATETIME    = NULL,
    @EndDateTime    DATETIME    = NULL,
    @SourceCodeName VARCHAR(50),
    @DisplayMT      INT         = NULL
AS

  /******************************************************************************
**		File: sps_rpt_ImportOfferDetail_Select.sql
**		Name: sps_rpt_ImportOfferDetail_Select
**		Desc: 
**
**		This template can be customized:
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
**		10/01/2008	ccarroll			Created for Archive and Production databases
**      02/09       JTH                 limit message org id to user org id 	
**		03/14/2010	James Gerberich		Added phone extension to MessageCallerPhone
**										column. HS #22712
**		10/30/2020	Mike Berenson		Refactored to eliminate need for parent sproc and 
**											run faster with temp tables
**      11/3/2020   Mike Berenson       Removed CustomCode logic
**		02/19/2021	James Gerberich		Applied Report Group parameter to limit records. TFS 72897
*******************************************************************************/
SET TRANSACTION ISOLATION  LEVEL  READ  UNCOMMITTED;
  
DECLARE @MessageOrganizationID	INT;

-- CHECK FOR STATLINE AND SET PARAM
SELECT @MessageOrganizationID = CASE WHEN @UserOrgID = 194 THEN NULL ELSE @UserOrgID END;

-- If CallID is provided, set DateTimes to NULL
IF ISNULL(@CallID,0) <> 0
BEGIN
    SELECT
		@StartDateTime = NULL,
		@EndDateTime = NULL;
END
	
DROP TABLE IF EXISTS #SourceCodes;
DROP TABLE IF EXISTS #FilteredCalls;

-- Load #SourceCodes
SELECT 
	SourceCodeID
INTO #SourceCodes
FROM 
	dbo.fn_SourceCodeList
		(
			@ReportGroupID, 
			@SourceCodeName
		);

-- Load #FilteredCalls
SELECT 		
	CallID, 
	CallDateTime
INTO #FilteredCalls
FROM
	dbo.fn_rpt_MessageDateTimeConversion 
		(
			@CallID,
			@StartDateTime,
			@EndDateTime,
			@DisplayMT
		);

-- Run Final Select
SELECT DISTINCT 
    c.CallID,
    mt.MessageTypeName,
    c.CallNumber,
    o.OrganizationName,
    m.MessageCallerName,
    m.MessageCallerOrganization,
    m.MessageCallerPhone + ISNULL(' x' + CAST(m.MessageExtension AS VARCHAR(20)), ' No Ext') AS MessageCallerPhone,
    fc.CallDateTime AS CallDateTime,
    m.MessageUrgent,
    m.MessageDescription,
    p.PersonLast                            AS MessageForLastName,
    pt.PersonTypeName,
    p.PersonFirst + ' ' + p.PersonLast      AS PersonName,
    sc.SourceCodeName,
    (
        SELECT TOP (1) Person.PersonFirst + ' ' + Person.PersonLast
        FROM LogEvent
            LEFT OUTER JOIN StatEmployee    ON StatEmployee.StatEmployeeID = LogEvent.STATEMPLOYEEID
            LEFT OUTER JOIN Person          ON Person.PersonID = StatEmployee.PersonID
        WHERE LogEvent.CallID = c.CallID
    ) AS TriageCoord,
    m.MessageImportUNOSID, 
    m.MessageImportCenter, 
    m.MessageImportPatient
FROM      
	[Call] c
	INNER JOIN #FilteredCalls fc	    ON fc.CallID = c.CallID
	INNER JOIN #SourceCodes fsc		    ON fsc.SourceCodeID = c.SourceCodeID
	INNER JOIN [Message] m			    ON m.CallID = c.CallID 
    INNER JOIN Organization o           ON o.OrganizationID = m.OrganizationID
    INNER JOIN MessageType mt           ON mt.MessageTypeID = m.MessageTypeID
    LEFT JOIN Person p                 ON p.PersonID = m.PersonID
    LEFT JOIN PersonType pt            ON pt.PersonTypeID = p.PersonTypeID
    INNER JOIN WebReportGroupOrg wrgo   ON wrgo.OrganizationID = m.OrganizationID 
    INNER JOIN SourceCode sc            ON sc.SourceCodeID = c.SourceCodeID
WHERE  
	wrgo.WebReportGroupID = @ReportGroupID
	AND	(@CallID IS NULL OR c.CallID = @CallID)         
    --LIMIT Message.OrganizationID
    AND (@MessageOrganizationID IS NULL OR m.OrganizationID = @MessageOrganizationID)
    AND (m.MessageTypeID = 2);
    
DROP TABLE IF EXISTS #SourceCodes;
DROP TABLE IF EXISTS #FilteredCalls;

GO


