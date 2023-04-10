 IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'DashboardNoCallsSelect')
	BEGIN
		PRINT 'Dropping Procedure DashboardNoCallsSelect'
		DROP Procedure DashboardNoCallsSelect
	END
GO
PRINT 'Creating Procedure DashboardNoCallsSelect'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/******************************************************************************
**	File: DashboardNoCallsSelect.sql
**	Name: DashboardNoCallsSelect
**	Desc: List No Calls 
**	Auth: jth
**	Date: Sept. 2010
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
*******************************************************************************/

CREATE PROCEDURE DashboardNoCallsSelect
	-- Add the parameters for the stored procedure here
	@StartDateTime	DATETIME,
	@EndDateTime		DATETIME,
	@timezone			varchar(2),
	@callNumber			VARCHAR(11) = NULL,
	@noCallTypeName VARCHAR(50) = NULL,
	@noCallDescription VARCHAR(255) = NULL,
	@sourceCodeName VARCHAR(10) = NULL,
	@statEmployeeFirstName VARCHAR(50) = NULL,
	@statEmployeeLastName VARCHAR(50) = NULL,
	@userOrganizationID INT
AS
Begin
SET NOCOUNT ON;
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

IF ((LEN(@callNumber) = 7 OR LEN(@callNumber) = 8) AND PATINDEX('-', @callNumber)=0 )
BEGIN
	SET @callId = @callNumber
	SET @StartDateTime		= NULL
	SET @EndDatetime		= NULL
	SET @callNumber			= NULL
	SET @noCallTypeName = NULL
	SET @noCallDescription = NULL
	SET @sourceCodeName = NULL
	SET @statEmployeeFirstName = NULL
	SET @statEmployeeLastName = NULL
END
IF @userOrganizationID=194
BEGIN
	SET @userOrganizationID = NULL
SELECT DISTINCT 
Call.CallID, 
Call.CallNumber, 
Call.CallDateTime AS 'CallDateTime', 
NoCallType.NoCallTypeName, 
NoCall.NoCallDescription, 
SourceCodeName,
StatEmployeeFirstName,
StatEmployeeLastName,
Person.OrganizationID

FROM NoCall 
LEFT JOIN Call ON NoCall.CallID = Call.CallID 
LEFT JOIN NoCallType ON NoCall.NoCallTypeID = NoCallType.NoCallTypeID 
LEFT JOIN SourceCode ON SourceCode.SourceCodeID = Call.SourceCodeID 
LEFT JOIN StatEmployee ON StatEmployee.StatEmployeeID = Call.StatEmployeeID 
LEFT JOIN Person ON Person.PersonID = StatEmployee.PersonID

where
	CallDateTime <= ISNULL(@EndDatetime, CallDateTime )
AND 
	CallDateTime >= ISNULL(@StartDateTime, CallDateTime )
AND
	ISNULL(PATINDEX(@callNumber + '%', 
				ISNULL(Call.CallNumber, 0) 
			), -1) <> 0 
AND
	ISNULL(PATINDEX( @noCallTypeName + '%' ,
			  NoCallType.NoCallTypeName), -1) <> 0
AND
	ISNULL(PATINDEX( @noCallDescription + '%' ,
			  NoCall.NoCallDescription), -1) <> 0
AND
	ISNULL(PATINDEX(@sourceCodeName+ '%',
					ISNULL(SourceCode.SourceCodeName, 0)), -1) <> 0
AND
	ISNULL(PATINDEX(@statEmployeeFirstName + '%',
		   StatEmployee.StatEmployeeFirstName), -1) <> 0
AND
	ISNULL(PATINDEX(@statEmployeeLastName + '%',
		   StatEmployee.StatEmployeeLastName), -1) <> 0	
AND
	Call.CallID = ISNULL(@callId, Call.CallID)
ORDER BY CallDateTime DESC
END

IF @userOrganizationID<>194
BEGIN
SELECT DISTINCT 
Call.CallID, 
Call.CallNumber, 
Call.CallDateTime AS 'CallDateTime', 
NoCallType.NoCallTypeName, 
NoCall.NoCallDescription, 
SourceCodeName,
StatEmployeeFirstName,
StatEmployeeLastName,
Person.OrganizationID

FROM NoCall 
LEFT JOIN Call ON NoCall.CallID = Call.CallID 
LEFT JOIN NoCallType ON NoCall.NoCallTypeID = NoCallType.NoCallTypeID 
LEFT JOIN SourceCode ON SourceCode.SourceCodeID = Call.SourceCodeID 
LEFT JOIN StatEmployee ON StatEmployee.StatEmployeeID = Call.StatEmployeeID 
LEFT JOIN Person ON Person.PersonID = StatEmployee.PersonID

where
	CallDateTime <= ISNULL(@EndDatetime, CallDateTime )
AND 
	CallDateTime >= ISNULL(@StartDateTime, CallDateTime )
AND 
	Call.SourceCodeID IN
						(
							SELECT
								WebReportGroupSourceCode.SourceCodeID
							FROM
								WebReportGroup
							JOIN	
								WebReportGroupSourceCode ON WebReportGroupSourceCode.WebReportGroupID = WebReportGroup.WebReportGroupID 
							WHERE
								WebReportGroup.OrgHierarchyParentID = @userOrganizationID	
						)
AND
	ISNULL(PATINDEX(@callNumber + '%', 
				ISNULL(Call.CallNumber, 0) 
			), -1) <> 0 
AND
	ISNULL(PATINDEX( @noCallTypeName + '%' ,
			  NoCallType.NoCallTypeName), -1) <> 0
AND
	ISNULL(PATINDEX( @noCallDescription + '%' ,
			  NoCall.NoCallDescription), -1) <> 0
AND
	ISNULL(PATINDEX(@sourceCodeName+ '%',
					ISNULL(SourceCode.SourceCodeName, 0)), -1) <> 0
AND
	ISNULL(PATINDEX(@statEmployeeFirstName + '%',
		   StatEmployee.StatEmployeeFirstName), -1) <> 0
AND
	ISNULL(PATINDEX(@statEmployeeLastName + '%',
		   StatEmployee.StatEmployeeLastName), -1) <> 0	
AND
	Call.CallID = ISNULL(@callId, Call.CallID)
ORDER BY CallDateTime DESC
END
END

