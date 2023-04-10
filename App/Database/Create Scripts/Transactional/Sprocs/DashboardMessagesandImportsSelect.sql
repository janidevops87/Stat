 IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'DashboardMessagesandImportsSelect')
	BEGIN
		PRINT 'Dropping Procedure DashboardMessagesandImportsSelect'
		DROP Procedure DashboardMessagesandImportsSelect
	END
GO
PRINT 'Creating Procedure DashboardMessagesandImportsSelect'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/******************************************************************************
**	File: DashboardMessagesandImportsSelect.sql
**	Name: DashboardMessagesandImportsSelect
**	Desc: List messages and imports referrals
**	Auth: jth
**	Date: Sept. 2010
**	Called By: Dashboard
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
	09/10			jth						initial
	9/12/2019		mberenson				Added trim function to output of MessageImportUNOSID
**	11/12/2019		mberenson				Optimized where clauses for performance
*******************************************************************************/
CREATE PROCEDURE DashboardMessagesandImportsSelect
	-- Add the parameters for the stored procedure here
	@StartDateTime				DATETIME,
	@EndDateTime				DATETIME,
	@timezone					VARCHAR(2),
	@callNumber					VARCHAR(11) = NULL,
	@referralDonorFirstName		VARCHAR(40) = NULL,
	@referralDonorLastName		VARCHAR(40) = NULL,
	@organizationName			VARCHAR(80) = NULL,
	@messageType				VARCHAR(50) = NULL,
	@optn						VARCHAR(20) = NULL,
	@messageCallerName			VARCHAR(80) = NULL,
	@messageCallerOrganization	VARCHAR(80) = NULL,
	@sourceCodeName				VARCHAR(10) = NULL,
	@statEmployeeFirstName		VARCHAR(50) = NULL,
	@statEmployeeLastName		VARCHAR(50) = NULL,
	@userOrganizationID			INT
AS
BEGIN
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	DECLARE 
		@callId					INT,
		@stalineOrganizationID	INT = 194;

	SELECT
		@StartDateTime	= DATEADD(
									hh, 
									-dbo.fn_TimeZoneDifference
										(
											@TimeZone, 
											@startDateTime
										),
									@StartDateTime		
								),
		@EndDatetime = DATEADD(
									hh, 
									-dbo.fn_TimeZoneDifference
										(
											@TimeZone, 
											@EndDatetime
										),
									@EndDatetime
								);

	IF ((LEN(@callNumber) = 7 OR LEN(@callNumber) = 8) AND PATINDEX('-', @callNumber)=0 )
	BEGIN
		SELECT
			@callId						= @callNumber,
			@StartDateTime				= NULL,
			@EndDatetime				= NULL,
			@callNumber					= NULL,
			@organizationName			= NULL,
			@messageType				= NULL,
			@optn						= NULL,
			@messageCallerName			= NULL,
			@messageCallerOrganization	= NULL,
			@referralDonorFirstName		= NULL,
			@referralDonorLastName		= NULL,
			@sourceCodeName				= NULL,
			@statEmployeeFirstName		= NULL,
			@statEmployeeLastName		= NULL;
	END	

	DROP TABLE IF EXISTS #filteredCalls;

	--load a list of CallIDs
	SELECT 
		Call.CallID
	INTO #filteredCalls
	FROM [Call]
	WHERE 
		(
			(@callId IS NULL
				AND Call.CallDateTime >= @startDateTime
				AND Call.CallDateTime <= @endDatetime
			)
			OR
			Call.CallId = @callId
		);

	SELECT DISTINCT 
		Call.CallID, 
		Call.CallNumber, 
		Call.CallDateTime AS 'CallDateTime', 
		Person.PersonFirst,
		Person.PersonLast,
		Organization.OrganizationName,
		MessageType.MessageTypeName,
		LTRIM(RTRIM(MessageImportUNOSID)) AS MessageImportUNOSID,
		MessageCallerName,
		MessageCallerOrganization,
		SourceCodeName, 
		StatEmployeeFirstName,
		StatEmployeeLastName,
		PO.OrganizationID,
		Call.LastModified 
	FROM 
		Call 
	JOIN 
		#filteredCalls c ON Call.CallID = c.CallID
	JOIN 
		Message ON Call.CallID = Message.CallID 
	LEFT JOIN 
		Person ON Person.PersonID = Message.PersonID 
	LEFT JOIN 
		Organization ON Organization.OrganizationID = Message.OrganizationID 
	LEFT JOIN 
		State ON State.StateID = Organization.StateID 
	LEFT JOIN 
		MessageType ON MessageType.MessageTypeID = Message.MessageTypeID 
	LEFT JOIN 
		SourceCode ON SourceCode.SourceCodeID = Call.SourceCodeID 
	LEFT JOIN 
		StatEmployee ON StatEmployee.StatEmployeeID = Call.StatEmployeeID 
	LEFT JOIN 
		Person PO ON PO.PersonID = StatEmployee.PersonID 
	WHERE
		(@callNumber IS NULL OR Call.CallNumber IS NULL OR PATINDEX(@callNumber + '%', Call.CallNumber) <> 0)
	AND
		(@organizationName IS NULL OR Organization.OrganizationName IS NULL OR PATINDEX(@organizationName + '%', Organization.OrganizationName) <> 0)
	AND
		(@referralDonorFirstName IS NULL OR Person.PersonFirst IS NULL OR PATINDEX(@referralDonorFirstName + '%', Person.PersonFirst) <> 0)
	AND
		(@referralDonorLastName IS NULL OR Person.PersonLast IS NULL OR PATINDEX(@referralDonorLastName + '%', Person.PersonLast) <> 0)
	AND
		(@messageType IS NULL OR MessageType.MessageTypeName IS NULL OR PATINDEX(@messageType + '%', MessageType.MessageTypeName) <> 0)
	AND
		(@optn IS NULL OR MessageImportUNOSID IS NULL OR PATINDEX(@optn + '%', MessageImportUNOSID) <> 0)
	AND
		(@messageCallerName IS NULL OR MessageCallerName IS NULL OR PATINDEX(@messageCallerName + '%', MessageCallerName) <> 0)
	AND
		(@messageCallerOrganization IS NULL OR MessageCallerOrganization IS NULL OR PATINDEX(@messageCallerOrganization + '%', MessageCallerOrganization) <> 0)
	AND
		(@sourceCodeName IS NULL OR SourceCode.SourceCodeName IS NULL OR PATINDEX(@sourceCodeName + '%', SourceCode.SourceCodeName) <> 0)
	AND
		(@statEmployeeFirstName IS NULL OR StatEmployee.StatEmployeeFirstName IS NULL OR PATINDEX(@statEmployeeFirstName + '%', StatEmployee.StatEmployeeFirstName) <> 0)
	AND
		(@statEmployeeLastName IS NULL OR StatEmployee.StatEmployeeLastName IS NULL OR PATINDEX(@statEmployeeLastName + '%', StatEmployee.StatEmployeeLastName) <> 0)
	AND (
		@userOrganizationID = @stalineOrganizationID
		OR EXISTS (SELECT 1
					FROM WebReportGroup
					JOIN WebReportGroupSourceCode ON WebReportGroupSourceCode.WebReportGroupID = WebReportGroup.WebReportGroupID 
					WHERE WebReportGroup.OrgHierarchyParentID = @userOrganizationID
					AND WebReportGroupSourceCode.SourceCodeID = Call.SourceCodeID
					)
		)
	AND
		CallActive <> 0
	ORDER BY 
		CallDateTime DESC;		

	DROP TABLE IF EXISTS #filteredCalls;
END
