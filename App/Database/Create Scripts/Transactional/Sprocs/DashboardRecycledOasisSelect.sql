 IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'DashboardRecycledOasisSelect')
	BEGIN
		PRINT 'Dropping Procedure DashboardRecycledOasisSelect'
		DROP Procedure DashboardRecycledOasisSelect
	END
GO
PRINT 'Creating Procedure DashboardRecycledOasisSelect'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/******************************************************************************
**	File: DashboardRecycledOasisSelect.sql
**	Name: DashboardRecycledOasisSelect
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

Create PROCEDURE [dbo].[DashboardRecycledOasisSelect]
	-- Add the parameters for the stored procedure here
	@StartDateTime		DATETIME,
	@EndDateTime		DATETIME,
	@timezone			varchar(2),
	@callNumber			VARCHAR(11) = NULL,
	@organizationName	VARCHAR(80) = NULL,
	@client				VARCHAR(80) = NULL,
	@importOfferNumber	VARCHAR(50) = NULL,
	@referralNumber	int = NULL,
	@organType	VARCHAR(100) = NULL,
	@optnNumber VARCHAR(20) = NULL,
	@matchId VARCHAR(50) = NULL,
	@transplantSurgeonContact VARCHAR(100) = NULL,
	@clinicalCoordinator VARCHAR(100) = NULL,
	@referralDonorFirstName VARCHAR(40) = NULL,
	@referralDonorLastName VARCHAR(40) = NULL,
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
IF( LEN(@callNumber) = 7 AND PATINDEX('-', @callNumber)=0 )
BEGIN
	SET @callId = @callNumber
	SET @startDateTime		= NULL
	SET @endDatetime		= NULL
	SET @callNumber			= NULL
	SET @organizationName	= NULL
	Set @client				= Null
	Set @importOfferNumber  = Null
	Set @referralNumber  = Null
	Set @organType  = Null
	Set @optnNumber  = NULL
	Set @matchId  = NULL
	Set @transplantSurgeonContact  = NULL
	Set @clinicalCoordinator  = NULL
	SET @referralDonorFirstName = NULL
	SET @referralDonorLastName = NULL
	SET @statEmployeeFirstName = NULL
	SET @statEmployeeLastName = NULL
END
IF(@userOrganizationID=194 )
BEGIN
	SET @userOrganizationID = NULL
END
	SELECT
	troi.CallId,
	C.LastModified AS 'CallDateTime',
	Client.OrganizationName AS Client,
	troi.ImportOfferNumber,
	troi.ReferralNumber,
	TcssListOrganType.FieldValue AS OrganType,
	td.OptnNumber,
	troi.MatchId,
	trdi.TransplantSurgeonContactOther AS TransplantSurgeonContact,
	trdi.ClinicalCoordinatorOther AS ClinicalCoordinator,
	RecentCoordinator.StatEmployeeFirstName AS CoordinatorFirstName,
	RecentCoordinator.StatEmployeeLastName AS CoordinatorLastName,
	tr.TcssRecipientId,
	td.TcssDonorId
FROM dbo.TcssDonor td
	INNER JOIN TcssDonorToRecipient tdr ON td.TcssDonorId = tdr.TcssDonorId
	INNER JOIN TcssRecipient tr ON tr.TcssRecipientId = tdr.TcssRecipientId
	INNER JOIN TcssRecipientOfferInformation troi ON troi.TcssRecipientId = tr.TcssRecipientId
	INNER JOIN TcssRecipientOfferStatusInformation RecentOfferStatusInformation ON 
		(
			RecentOfferStatusInformation.TcssRecipientId = tr.TcssRecipientId
			AND RecentOfferStatusInformation.LastUpdateDate = (Select Max(LastUpdateDate) From TcssRecipientOfferStatusInformation Where TcssRecipientId = tr.TcssRecipientId)
		)
	LEFT JOIN TcssDonorContactInformation trdi ON trdi.TcssDonorId = td.TcssDonorId
	LEFT JOIN dbo.Call c ON troi.CallId = c.CallId
	LEFT JOIN dbo.Referral r ON troi.CallId = r.CallId
	LEFT JOIN StatEmployee RecentCoordinator ON RecentCoordinator.StatEmployeeID = c.StatEmployeeId
	LEFT JOIN TcssListOrganType ON troi.TcssListOrganTypeId = TcssListOrganType.TcssListOrganTypeId
	LEFT JOIN TcssListStatus ON RecentOfferStatusInformation.TcssListStatusId = TcssListStatus.TcssListStatusId
	LEFT JOIN Organization Client ON troi.ClientId = Client.OrganizationID
	LEFT JOIN Person ON Person.PersonID = RecentCoordinator.PersonID 
where
	C.LastModified <= ISNULL(@EndDatetime, C.LastModified )
AND 
	C.LastModified >= ISNULL(@StartDateTime, C.LastModified )
	AND
	ISNULL(PATINDEX(@callNumber + '%',ISNULL(C.CallNumber, 0)), -1) <> 0 
AND
	ISNULL(PATINDEX( @organizationName + '%' ,
			  Client.OrganizationName), -1) <> 0
AND
	ISNULL(PATINDEX(@client + '%' ,ISNULL(Client.OrganizationName,0)), -1) <> 0
AND
	ISNULL(PATINDEX(@importOfferNumber + '%' ,
			  troi.ImportOfferNumber), -1) <> 0
--AND
	--troi.ReferralNumber = ISNULL(@referralNumber,troi.ReferralNumber)
AND
	ISNULL(PATINDEX(@organType + '%',
					ISNULL(TcssListOrganType.FieldValue, 0)), -1) <> 0
AND
	ISNULL(PATINDEX(@optnNumber + '%',
					ISNULL(td.OptnNumber, 0)), -1) <> 0
AND
	ISNULL(PATINDEX(@matchId + '%',
					ISNULL(troi.MatchId, 0)), -1) <> 0
AND
	ISNULL(PATINDEX(@transplantSurgeonContact + '%',
					ISNULL(trdi.TransplantSurgeonContactOther, 0)), -1) <> 0
AND
	ISNULL(PATINDEX(@clinicalCoordinator+ '%',
					ISNULL(trdi.ClinicalCoordinatorOther, 0)), -1) <> 0					
AND
	ISNULL(PATINDEX(@referralDonorFirstName + '%',
					ISNULL(R.ReferralDonorFirstName, 0)), -1) <> 0
AND
	ISNULL(PATINDEX(@referralDonorLastName + '%',
					ISNULL(R.ReferralDonorLastName, 0)), -1) <> 0
AND
	ISNULL(PATINDEX(@statEmployeeFirstName + '%',
		   isnull(RecentCoordinator.StatEmployeeFirstName,0)), -1) <> 0
	AND
	ISNULL(PATINDEX(@statEmployeeLastName + '%',
		   isnull(RecentCoordinator.StatEmployeeLastName,0)), -1) <> 0
AND	
	(	
		@userOrganizationID is null
		or 
		Person.OrganizationID  =  @userOrganizationID
	)
AND
	C.CallID = ISNULL(@callId, C.CallID)
and
	CallActive = 0		
	ORDER 
	BY 	C.CallDateTime DESC;