IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_rpt_AuditTrail_Message')
BEGIN
	PRINT 'Dropping Procedure sps_rpt_AuditTrail_Message';
	DROP PROCEDURE  sps_rpt_AuditTrail_Message;
END
GO

PRINT 'Creating Procedure sps_rpt_AuditTrail_Message';
GO

CREATE Procedure sps_rpt_AuditTrail_Message
	@CallID					INT			= NULL,
	@User					INT			= NULL,
	@ChangeStartDateTime	DATETIME	= NULL,
	@ChangeEndDateTime		DATETIME	= NULL,
	@SourceCodeName			INT			= NULL,
	@UserOrgID				INT			= NULL,
	@ImportOnly				INT			= NULL,
	@DisplayMT				INT			= NULL
AS
/******************************************************************************
**		File: sps_rpt_AuditTrail_Message.sql
**		Name: sps_rpt_AuditTrail_Message
**		Desc: 
**
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**      See above
**
**		Auth: christopher carroll 
**		Date: 08/22/2007
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**      08/22/2007		ccarroll				Initial release
**		08/31/2007		ccarroll				Check for matching Start-End datetime - Deleted
**		11/19/2007		ccarroll				Added time zone search parameter
**		05/29/2008		ccarroll				Added ILB functionality
**		06/24/2008		ccarroll				Added Deletes from Call Table
**		12/03/2008		ccarroll				Added reference to vwAuditTrail
**		10/30/2020		Mike Berenson			Refactored with temp tables to improve performance
**		11/4/2020		Mike Berenson			Removed order by fields
**		01/14/2021		James Gerberich			Corrected date range filtering
*******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

-- If Start & End DateTimes match, set them to null
IF @ChangeStartDateTime = @ChangeEndDateTime
BEGIN
	SELECT
		@ChangeStartDateTime = NULL,
		@ChangeEndDateTime = NULL;
END

-- Give StatLine(194) full organization access, otherwise restrict by OrganizationID
SELECT @UserOrgID = CASE WHEN @UserOrgID = 194 THEN NULL ELSE @UserOrgID END

-- Load appropriate values into #MessageTypes
DROP TABLE IF EXISTS #MessageTypes;
CREATE TABLE #MessageTypes (MessageTypeID INT);
IF @ImportOnly = 1
BEGIN
	INSERT INTO #MessageTypes (MessageTypeID) VALUES (2); 
	--2	Import Offer  
END
ELSE
BEGIN
	INSERT INTO #MessageTypes (MessageTypeID) VALUES (1), (3), (4); 
	--1	RFI / Public Ed.
	--3	General Message
	--4	Recipient Listing or Status Change
END

DROP TABLE IF EXISTS #ConvertedMessages;
DROP TABLE IF EXISTS #FilteredMessages;
DROP TABLE IF EXISTS #ConvertedCalls;
DROP TABLE IF EXISTS #FilteredCalls;

------------------------------
-- Load Message Temp Tables --
------------------------------

-- Load #ConvertedMessages with converted Message datetimes
SELECT
	m.CallID,
	m.LastModified,
	dbo.AuditTrailfn_rpt_ConvertDateTime(rm.OrganizationID, m.LastModified, @DisplayMT) AS 'ChangeDT'
INTO #ConvertedMessages
FROM 
	[Message] m
	LEFT JOIN vwAuditTrailMessage rm ON rm.CallID = m.CallID
WHERE
	m.CallID = @CallID
	AND (rm.OrganizationID = CASE WHEN @userOrgID IS NULL THEN rm.OrganizationID ELSE @userOrgID END);

-- Load #FilteredMessages with messages filtered after conversion
SELECT DISTINCT
	m.CallID,
	m.LastModified,
	m.ChangeDT
INTO #FilteredMessages
FROM
	#ConvertedMessages m
WHERE
	EXISTS (SELECT 1 FROM [Call] c WHERE c.CallID = m.CallID)
	AND (
			@ChangeStartDateTime IS NULL
		OR	m.ChangeDT >= @ChangeStartDateTime
		)
	AND (
			@ChangeStartDateTime IS NULL
		OR	m.ChangeDT <= @ChangeEndDateTime
		);

---------------------------
-- Load Call Temp Tables --
---------------------------

-- Load #ConvertedCalls with CallID and ChangeDT
SELECT
	c.CallID,
	dbo.AuditTrailfn_rpt_ConvertDateTime(rm.OrganizationID, c.LastModified, @DisplayMT) AS 'ChangeDT'
INTO #ConvertedCalls
FROM 
	[Call] c
	LEFT JOIN vwAuditTrailMessage rm ON rm.CallID = c.CallID
WHERE
		c.CallID = @CallID
	AND c.AuditLogTypeID = 4 -- deleted
	AND (rm.OrganizationID = CASE WHEN @userOrgID IS NULL THEN rm.OrganizationID ELSE @UserOrgID END);

-- Load #FilteredCalls with calls filtered after conversion
SELECT
	cc.CallID,
	cc.ChangeDT
INTO #FilteredCalls
FROM
	#ConvertedCalls cc
	JOIN [Call] c ON c.CallID = cc.CallID
WHERE
		c.AuditLogTypeID = 4 -- deleted
	AND (
			@ChangeStartDateTime IS NULL
		OR	cc.ChangeDT >= @ChangeStartDateTime
		)
	AND (
			@ChangeStartDateTime IS NULL
		OR	cc.ChangeDT <= @ChangeEndDateTime
		);
	
-- Run final select (with union all)
SELECT DISTINCT
	/*** Message *** - User Change Data */
	fm.ChangeDT,
	ISNULL(MessageChangePerson.PersonFirst, '') + ' ' + 
		ISNULL(MessageChangePerson.PersonLast, '')	AS 'ChangeUser',
	MessageChangeType.AuditLogTypeName				AS 'ChangeType',
	/* Caller Information */
	m.CallID,
	m.MessageCallerName								AS 'Name',
	m.MessageCallerPhone							AS 'Phone',
	m.MessageExtension								AS 'Extension',
	m.MessageCallerOrganization						AS 'From',
	/* Message Information */
	CASE WHEN m.MessageTypeID = -2 THEN 'ILB' 
		ELSE MessageType.MessageTypeName END		AS 'MessageType',
	CASE WHEN m.MessageUrgent = -1 THEN 'Yes' 
		WHEN m.MessageUrgent = 0 THEN 'No' 
		ELSE '' END									AS 'CallbackASAP',
	m.MessageDescription							AS 'Message',			
	/* Import Offer information */
	m.MessageImportCenter							AS 'TxCenter',
	m.MessageImportPatient							AS 'Patient',
	m.MessageImportUNOSID							AS 'UNOS_ID',
	/* Message For */
	CASE WHEN m.OrganizationID = -2 THEN 'ILB' 
		ELSE ForOrganization.OrganizationName END	AS 'ForOrg',
	CASE WHEN m.PersonID = -2 THEN 'ILB' 
		ELSE ISNULL(ForPerson.PersonFirst, '') + ' ' + 
			ISNULL(ForPerson.PersonLast, '') END	AS 'ForPersonName',
	CASE WHEN m.PersonID = -2 THEN 'ILB' 
		ELSE ForPersonType.PersonTypeName END		AS 'Role'
FROM 
	[Message] m
	JOIN #FilteredMessages fm							ON fm.CallID = m.CallID AND fm.LastModified = m.LastModified
	LEFT JOIN vwAuditTrailMessage RefMessage			ON RefMessage.CallID = m.CallID
	JOIN #MessageTypes fmt								ON fmt.MessageTypeID = RefMessage.MessageTypeID

	/* Message Change User */
	LEFT JOIN vwAuditTrailStatEmployee MessageChangeEmployee	ON MessageChangeEmployee.StatEmployeeID = m.LastStatEmployeeID 
	LEFT JOIN vwAuditTrailPerson MessageChangePerson			ON MessageChangePerson.PersonID = MessageChangeEmployee.PersonID
	LEFT JOIN vwAuditTrailAuditLogType MessageChangeType		ON MessageChangeType.AuditLogTypeID = m.AuditLogTypeID

	/* Message Information */
	LEFT JOIN vwAuditTrailMessageType MessageType		ON MessageType.MessageTypeID = m.MessageTypeID

	/* Message For */
	LEFT JOIN vwAuditTrailOrganization ForOrganization	ON ForOrganization.OrganizationID = m.OrganizationID
	LEFT JOIN vwAuditTrailPerson ForPerson				ON ForPerson.PersonID = m.PersonID
	LEFT JOIN vwAuditTrailPersonType ForPersonType		ON ForPersonType.PersonTypeID = ForPerson.PersonID

UNION ALL

-- Add Deleted records
SELECT DISTINCT
	/*** Message *** - User Change Data */
	fc.ChangeDT,
	ISNULL(MessageChangePerson.PersonFirst, '') + ' ' + 
		ISNULL(MessageChangePerson.PersonLast, '')	AS 'ChangeUser',
	MessageChangeType.AuditLogTypeName				AS 'ChangeType',
	/* Caller Information */
	c.CallID,
	NULL											AS 'Name',
	NULL											AS 'Phone',
	NULL											AS 'Extension',
	NULL											AS 'From',
	/* Message Information */
	NULL											AS 'MessageType',
	''												AS 'CallbackASAP',
	NULL											AS 'Message',			
	/* Import Offer information */
	NULL											AS 'TxCenter',
	NULL											AS 'Patient',
	NULL											AS 'UNOS_ID',
	/* Message For */
	NULL											AS 'ForOrg',
	''												AS 'ForPersonName',
	NULL											AS 'Role'
FROM 
	[Call] c
	JOIN #FilteredCalls fc										ON fc.CallID = c.CallID
	LEFT JOIN vwAuditTrailMessage RefMessage					ON RefMessage.CallID = c.CallID
	/* Message Change User */
	LEFT JOIN vwAuditTrailStatEmployee MessageChangeEmployee	ON MessageChangeEmployee.StatEmployeeID = c.CallSaveLastByID 
	LEFT JOIN vwAuditTrailPerson MessageChangePerson			ON MessageChangePerson.PersonID = MessageChangeEmployee.PersonID
	LEFT JOIN vwAuditTrailAuditLogType MessageChangeType		ON MessageChangeType.AuditLogTypeID = c.AuditLogTypeID
WHERE	
	c.AuditLogTypeID = 4 -- deleted;

DROP TABLE IF EXISTS #ConvertedMessages;
DROP TABLE IF EXISTS #FilteredMessages;
DROP TABLE IF EXISTS #ConvertedCalls;
DROP TABLE IF EXISTS #FilteredCalls;

GO
