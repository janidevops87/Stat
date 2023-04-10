 IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'DashboardRecycledMessagesSelect')
	BEGIN
		PRINT 'Dropping Procedure DashboardRecycledMessagesSelect'
		DROP Procedure DashboardRecycledMessagesSelect
	END
GO
PRINT 'Creating Procedure DashboardRecycledMessagesSelect'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/******************************************************************************
**	File: DashboardRecycledMessagesSelect.sql
**	Name: DashboardRecycledMessagesSelect
**	Desc: List Recycled Calls
**	Auth: jth
**	Date: Dec. 2010
**	Called By: Dashboard
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
*******************************************************************************/

Create PROCEDURE [dbo].[DashboardRecycledMessagesSelect]
	-- Add the parameters for the stored procedure here
	@StartDateTime		DATETIME,
	@EndDateTime		DATETIME,
	@timezone			varchar(2),
	@callNumber			VARCHAR(11) = NULL,
	@organizationName	VARCHAR(80) = NULL,
	@referralDonorFirstName VARCHAR(40) = NULL,
	@referralDonorLastName VARCHAR(40) = NULL,
	@currentReferralTypeName VARCHAR(50) = NULL,
	@optn VARCHAR(20) = NULL,
	@messageCallerName	VARCHAR(80) = NULL,
	@messageCallerOrganization	VARCHAR(80) = NULL,
	@sourceCodeName VARCHAR(10) = NULL,
	@statEmployeeFirstName VARCHAR(50) = NULL,
	@statEmployeeLastName VARCHAR(50) = NULL,
	@userOrganizationID INT,
	@vReturnLimit 	int = 0
AS

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
DECLARE @callId INT
SET @StartDateTime	= DATEADD(
									hh, 
									-dbo.fn_TimeZoneDifference
										(
											@TimeZone, 
											@startDateTime
										),
									@StartDateTime		
								)	

	SET @EndDatetime = DATEADD(
									hh, 
									-dbo.fn_TimeZoneDifference
										(
											@TimeZone, 
											@EndDatetime
										),
									@EndDatetime		)

	IF @vReturnLimit > 0
    BEGIN
		SET ROWCOUNT @vReturnLimit 

		-- Limit the date range to 10 days, since only 200 are coming back anyway
		IF DateDiff(d, @StartDateTime, @EndDateTime) > 10
	    BEGIN
			SET @StartDateTime = DateAdd(d, -10, @EndDateTime)
	    END

		SET ROWCOUNT @vReturnLimit
    END
IF ((LEN(@callNumber) = 7 OR LEN(@callNumber) = 8) AND PATINDEX('-', @callNumber)=0 )
BEGIN
	SET @callId = @callNumber
	SET @startDateTime		= NULL
	SET @endDatetime		= NULL
	SET @callNumber			= NULL
	SET @optn				= NULL
	SET @organizationName	= NULL
	SET @referralDonorFirstName = NULL
	SET @referralDonorLastName = NULL
	SET @currentReferralTypeName = NULL
	SET @messageCallerName		= NULL
	SET @messageCallerOrganization	= NULL
	SET @sourceCodeName = NULL
	SET @statEmployeeFirstName = NULL
	SET @statEmployeeLastName = NULL
END
IF(@userOrganizationID=194 )
BEGIN
	SET @userOrganizationID = NULL
END
	SELECT DISTINCT 
		Call.CallID, 
		Call.CallNumber, 
		Call.RecycleDateTime AS 'CallDateTime', 
		Person.PersonFirst, 
		Person.PersonLast,
		Organization.OrganizationName, 
		MessageType.MessageTypeName,
		MessageImportUNOSID, 
		SourceCodeName,
		MessageCallerName,
		MessageCallerOrganization,
		StatEmployee.StatEmployeeFirstName,
		StatEmployee.StatEmployeeLastName,
		PO.OrganizationID,
		Call.LastModified
FROM Message 
LEFT JOIN 
CallRecycle Call ON Call.CallID = Message.CallID
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
where
	Call.RecycleDateTime <= ISNULL(@EndDatetime, RecycleDateTime )
AND 
	Call.RecycleDateTime >= ISNULL(@StartDateTime, RecycleDateTime )
AND
	ISNULL(PATINDEX(@callNumber + '%', 
				ISNULL(Call.CallNumber, 0) 
			), -1) <> 0 
AND
	ISNULL(PATINDEX( @organizationName + '%' ,
			  Organization.OrganizationName), -1) <> 0
AND
	ISNULL(PATINDEX(@referralDonorFirstName + '%',
					ISNULL(Person.PersonFirst, 0)), -1) <> 0
AND
	ISNULL(PATINDEX(@referralDonorLastName + '%',
					ISNULL(Person.PersonLast , 0)), -1) <> 0
AND
	ISNULL(PATINDEX(@currentReferralTypeName + '%',
					ISNULL(MessageType.MessageTypeName, 0)), -1) <> 0
AND
	ISNULL(PATINDEX(@sourceCodeName+ '%',
					ISNULL(SourceCode.SourceCodeName, 0)), -1) <> 0
AND
	ISNULL(PATINDEX( @optn + '%' ,
			  MessageImportUNOSID), -1) <> 0
AND
	ISNULL(PATINDEX( @messageCallerName + '%' ,
			  MessageCallerName), -1) <> 0
AND
	ISNULL(PATINDEX( @messageCallerOrganization + '%' ,
			  MessageCallerOrganization), -1) <> 0
AND
	ISNULL(PATINDEX(@statEmployeeFirstName + '%',
		   isnull(StatEmployee.StatEmployeeFirstName,0)), -1) <> 0
AND
	ISNULL(PATINDEX(@statEmployeeLastName + '%',
		   isnull(StatEmployee.StatEmployeeLastName,0)), -1) <> 0
AND	
	(	
		@userOrganizationID is null
		or 
		Person.OrganizationID  =  @userOrganizationID
	)
--AND
	--Call.CallID = ISNULL(@callId, Call.CallID)
--AND 
	--CallActive <> 0 
AND Message.MessageTypeID <> 2
and Message.CallID = ISNULL(@callId, Message.CallID)	
	Union all
	Select Distinct
Call.CallID, 
		Call.CallNumber, 
		Call.RecycleDateTime AS 'CallDateTime', 
		Person.PersonFirst, 
		Person.PersonLast,
		Organization.OrganizationName, 
		MessageType.MessageTypeName,
		MessageImportUNOSID, 
		SourceCodeName,
		MessageCallerName,
		MessageCallerOrganization,
		StatEmployee.StatEmployeeFirstName,
		StatEmployee.StatEmployeeLastName,
		PO.OrganizationID,
		Call.LastModified
FROM Message 
LEFT JOIN 
CallRecycle Call ON Call.CallID = Message.CallID
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
where
	Call.RecycleDateTime <= ISNULL(@EndDatetime, RecycleDateTime )
AND 
	Call.RecycleDateTime >= ISNULL(@StartDateTime, RecycleDateTime )
AND
	ISNULL(PATINDEX(@callNumber + '%', 
				ISNULL(Call.CallNumber, 0) 
			), -1) <> 0 
AND
	ISNULL(PATINDEX( @organizationName + '%' ,
			  Organization.OrganizationName), -1) <> 0
AND
	ISNULL(PATINDEX(@referralDonorFirstName + '%',
					ISNULL(Person.PersonFirst, 0)), -1) <> 0
AND
	ISNULL(PATINDEX(@referralDonorLastName + '%',
					ISNULL(Person.PersonLast , 0)), -1) <> 0
AND
	ISNULL(PATINDEX(@currentReferralTypeName + '%',
					ISNULL(MessageType.MessageTypeName, 0)), -1) <> 0
AND
	ISNULL(PATINDEX(@sourceCodeName+ '%',
					ISNULL(SourceCode.SourceCodeName, 0)), -1) <> 0
AND
	ISNULL(PATINDEX( @optn + '%' ,
			  MessageImportUNOSID), -1) <> 0
AND
	ISNULL(PATINDEX( @messageCallerName + '%' ,
			  MessageCallerName), -1) <> 0
AND
	ISNULL(PATINDEX( @messageCallerOrganization + '%' ,
			  MessageCallerOrganization), -1) <> 0
AND
	ISNULL(PATINDEX(@statEmployeeFirstName + '%',
		   isnull(StatEmployee.StatEmployeeFirstName,0)), -1) <> 0
AND
	ISNULL(PATINDEX(@statEmployeeLastName + '%',
		   isnull(StatEmployee.StatEmployeeLastName,0)), -1) <> 0
AND	
	(	
		@userOrganizationID is null
		or 
		Person.OrganizationID  =  @userOrganizationID
	)

AND 
	Message.MessageTypeID = 2 
and Message.CallID = ISNULL(@callId, Message.CallID)	 		 		
	ORDER 
	BY 	CallDateTime DESC;