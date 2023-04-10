IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_rpt_ImportOfferActivity_Select')
BEGIN
	PRINT 'Dropping Procedure sps_rpt_ImportOfferActivity_Select';
	DROP PROCEDURE [dbo].[sps_rpt_ImportOfferActivity_Select];
END  
GO

PRINT 'Creating Procedure sps_rpt_ImportOfferActivity_Select';
SET QUOTED_IDENTIFIER ON;
GO

SET ANSI_NULLS ON;
GO

CREATE PROCEDURE sps_rpt_ImportOfferActivity_Select
    @UserOrgID					INT			= NULL,
    @ReportGroupID				INT			= NULL,
    @CallID						INT			= NULL,
    @ImportOfferStartDateTime	DATETIME	= NULL,
    @ImportOfferEndDateTime		DATETIME	= NULL,
    @SourceCodeName				VARCHAR(50),
    @MessageCallerOrganization	VARCHAR(50),
    @MessageFor					VARCHAR(50),
    @MessageForOrganizationID	INT			= NULL,
    @DisplayMT					INT			= NULL
AS

  /******************************************************************************
**		File: 
**		Name: sps_rpt_ImportOfferActivity_Select
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
**		09/29/2008	ccarroll			Added Select sproc for Archive data
**		10/14/2008	Bret				removed distinct and change how alerts are queried
**      10/21/08    jth                 added  MessageForOrganizationID
**      02/09       JTH                 limit message org id to user org id
**		10/29/2020	Mike Berenson		Refactored to eliminate need for parent sproc and 
**											run faster with temp tables
**      11/3/2020   Mike Berenson       Removed CustomCode logic
**		02/19/2021	James Gerberich		Applied Report Group parameter to limit records. TFS 72897
*******************************************************************************/
SET TRANSACTION ISOLATION  LEVEL  READ  UNCOMMITTED;
  
DECLARE @MessageOrganizationID	INT;

-- CHECK FOR STATLINE AND SET PARAM
SELECT @MessageOrganizationID = CASE WHEN @UserOrgID = 194 THEN NULL ELSE @UserOrgID END;

-- If CallerOrganization is provided, replace the wildcards
IF @MessageCallerOrganization IS NOT NULL
BEGIN
	SET @MessageCallerOrganization = REPLACE(@MessageCallerOrganization,'*','%');
END

-- If CallID is provided, set DateTimes to NULL
IF ISNULL(@CallID,0) <> 0
BEGIN
    SELECT
		@ImportOfferStartDateTime = NULL,
		@ImportOfferEndDateTime = NULL,
		@MessageCallerOrganization = NULL,
		@MessageFor = NULL;
END
	
DROP TABLE IF EXISTS #SourceCodes;
DROP TABLE IF EXISTS #FilteredCalls;
DROP TABLE IF EXISTS #Alerts;

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
			@ImportOfferStartDateTime,
			@ImportOfferEndDateTime,
			@DisplayMT
		);

-- Load #Alerts
SELECT     
	a.AlertID, 
	a.AlertGroupName, 
	ao.OrganizationID, 
	alsc.SourceCodeID
INTO #Alerts
FROM         
	Alert a
	INNER JOIN AlertOrganization ao	ON a.AlertID = ao.AlertID
	INNER JOIN AlertSourceCode alsc	ON a.AlertID = alsc.AlertID 
	INNER JOIN #SourceCodes fsc		ON fsc.SourceCodeID = alsc.SourceCodeID
WHERE AlertTypeID = 4;
   
-- Run Final Select
SELECT 
	c.CallID,
	mt.MessageTypeName,
	c.CallNumber,
	o.OrganizationName,
	m.MessageCallerName,
	m.MessageCallerOrganization,
	m.MessageCallerPhone,
	fc.CallDateTime						AS BasedOnDT1,
	p.PersonLast                        AS MessageForLastName,
	pt.PersonTypeName,
	p.PersonFirst + ' ' + p.PersonLast	AS PersonName,
	m.MessageImportUNOSID, 
	m.MessageImportCenter, 
	m.MessageImportPatient,
	a.AlertGroupName,
	a.AlertID
FROM      
	[Call] c
	INNER JOIN #FilteredCalls fc		ON fc.CallID = c.CallID
	INNER JOIN #SourceCodes fsc			ON fsc.SourceCodeID = c.SourceCodeID
	INNER JOIN [Message] m				ON m.CallID = c.CallID 
	INNER JOIN WebReportGroupOrg wrgo	ON wrgo.OrganizationID = m.OrganizationID 
	INNER JOIN MessageType mt			ON mt.MessageTypeID = m.MessageTypeID      
	INNER JOIN SourceCode sc			ON sc.SourceCodeID = fsc.SourceCodeID
	LEFT JOIN Organization o			ON o.OrganizationID = m.OrganizationID 
	LEFT JOIN Person p					ON p.PersonID = m.PersonID 
	LEFT JOIN PersonType pt				ON p.PersonTypeID = pt.PersonTypeID  
	LEFT JOIN #Alerts a					ON a.OrganizationID = m.OrganizationID AND a.SourceCodeID = fsc.SourceCodeID
WHERE  
	wrgo.WebReportGroupID = @ReportGroupID
	AND	(@CallID IS NULL OR c.CallID = @CallID)
	-- Search - Organization message for
	AND (@MessageForOrganizationID IS NULL OR @MessageForOrganizationID = 0 OR m.OrganizationID = @MessageForOrganizationID)
	AND (@MessageCallerOrganization IS NULL OR (m.MessageCallerOrganization IS NOT NULL AND PATINDEX(@MessageCallerOrganization, m.MessageCallerOrganization) > 0))
    AND (@MessageFor IS NULL OR @MessageFor = 0 OR p.PersonID = @MessageFor)         
    -- LIMIT Message.OrganizationID
	AND (@MessageOrganizationID IS NULL OR m.OrganizationID = @MessageOrganizationID)                     
    AND m.MessageTypeID = 2;
	
DROP TABLE IF EXISTS #SourceCodes;
DROP TABLE IF EXISTS #FilteredCalls;
DROP TABLE IF EXISTS #Alerts;

GO