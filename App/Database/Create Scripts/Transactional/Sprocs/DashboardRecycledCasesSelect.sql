 IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'DashboardRecycledCasesSelect')
	BEGIN
		PRINT 'Dropping Procedure DashboardRecycledCasesSelect'
		DROP Procedure DashboardRecycledCasesSelect
	END
GO
PRINT 'Creating Procedure DashboardRecycledCasesSelect'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/******************************************************************************
**	File: DashboardRecycledCasesSelect.sql
**	Name: DashboardRecycledCasesSelect
**	Desc: List Recycled Calls
**	Auth: jth
**	Date: Sept. 2010
**	Called By: Dashboard
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
*******************************************************************************/

Create PROCEDURE [dbo].[DashboardRecycledCasesSelect]
	-- Add the parameters for the stored procedure here
	@StartDateTime	DATETIME,
	@EndDateTime		DATETIME,
	@timezone			varchar(2),
	@callNumber			VARCHAR(11) = NULL,
	@organizationName	VARCHAR(80) = NULL,
	@statAbbreviation	VARCHAR(2) = NULL,
	@referralDonorFirstName VARCHAR(40) = NULL,
	@referralDonorLastName VARCHAR(40) = NULL,
	@currentReferralTypeName VARCHAR(50) = NULL,
	@previousReferralTypeName VARCHAR(50) = NULL,
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
	SET @organizationName	= NULL
	SET @statAbbreviation	= NULL
	SET @referralDonorFirstName = NULL
	SET @referralDonorLastName = NULL
	SET @currentReferralTypeName = NULL
	SET @previousReferralTypeName = NULL
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
		Referral.ReferralDonorFirstName, 
		Referral.ReferralDonorLastName,
		Organization.OrganizationName,
		 
		CASE 
			WHEN (CAll.calltypeid = 1 and abs(Referral.ReferralTypeID) = 1) then 'OTE' 
			WHEN (CAll.calltypeid = 1 and Referral.ReferralTypeID = 2) THEN  'TE'
			when (CAll.calltypeid = 1 and Referral.ReferralTypeID = 3) then 'E'
			when (CAll.calltypeid = 1 and Referral.ReferralTypeID = 4) then 'RO' 
		END AS PrevReferralTypeName,
		/*CASE 
			WHEN (CAll.calltypeid = 1 and abs(Referral.CurrentReferralTypeID) = 1) then 'OTE' 
			WHEN (CAll.calltypeid = 1 and Referral.CurrentReferralTypeID = 2) THEN  'TE'
			when (CAll.calltypeid = 1 and Referral.CurrentReferralTypeID = 3) then 'E'
			when (CAll.calltypeid = 1 and Referral.CurrentReferralTypeID = 4) then 'RO' 
		END as ReferralTypeName,*/
		--(Select ReferralAbbreviation from referraltype where ReferralTypeID = abs(Referral.ReferralTypeID)) as PrevReferralTypeName,
		(Select ReferralAbbreviation from referraltype where ReferralTypeID = abs(Referral.CurrentReferralTypeID)) as ReferralTypeName,
		SourceCodeName, 
		StatEmployee.StatEmployeeFirstName,
		StatEmployee.StatEmployeeLastName,
		Person.OrganizationID,
		Call.LastModified
	FROM 	Referral  
	LEFT 
	JOIN 	CallRecycle Call  ON Call.CallID = Referral.CallID 
	LEFT 
	JOIN 	Organization  ON Organization.OrganizationID = Referral.ReferralCallerOrganizationID 
	LEFT 
	JOIN 	State  ON State.StateID = Organization.StateID 
	LEFT JOIN 
	ReferralType ON ReferralType.ReferralTypeID = Referral.CurrentReferralTypeID 
	LEFT JOIN	
	ReferralType PrevRefType ON Referral.ReferralTypeId = PrevRefType.ReferralTypeId 
	LEFT 
	JOIN 	SourceCode  ON SourceCode.SourceCodeID = Call.SourceCodeID 
	LEFT 
	JOIN 	StatEmployee  ON StatEmployee.StatEmployeeID = Call.StatEmployeeID 
	LEFT 
	JOIN 	Person  ON Person.PersonID = StatEmployee.PersonID 
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
	ISNULL(PATINDEX(@statAbbreviation + '%', 
			 ISNULL(State.StateAbbrv, 0)), -1) <> 0			
AND
	ISNULL(PATINDEX(@referralDonorFirstName + '%',
					ISNULL(Referral.ReferralDonorFirstName, 0)), -1) <> 0
AND
	ISNULL(PATINDEX(@referralDonorLastName + '%',
					ISNULL(Referral.ReferralDonorLastName, 0)), -1) <> 0
AND
	ISNULL(PATINDEX(@currentReferralTypeName + '%',
					ISNULL(ReferralType.ReferralAbbreviation, 0)), -1) <> 0
AND
	ISNULL(PATINDEX(@previousReferralTypeName + '%',
					ISNULL(PrevRefType.ReferralAbbreviation, 0)), -1) <> 0		
AND
	ISNULL(PATINDEX(@sourceCodeName+ '%',
					ISNULL(SourceCode.SourceCodeName, 0)), -1) <> 0
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
	Call.CallID = ISNULL(@callId, Call.CallID)	
	ORDER 
	BY 	Call.RecycleDateTime DESC;