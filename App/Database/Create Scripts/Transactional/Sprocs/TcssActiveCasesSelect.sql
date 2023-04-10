IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssActiveCasesSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssActiveCasesSelect'
		DROP Procedure TcssActiveCasesSelect
	END
GO

PRINT 'Creating Procedure TcssActiveCasesSelect'
GO

CREATE PROCEDURE dbo.TcssActiveCasesSelect
(
	@StatEmployeeId int,
	@CallId varchar(50) = null,
	@MinLastUpdatDate datetime = null,
	@MaxLastUpdatDate datetime = null,
	@Client varchar(100) = null,
	@ImportOfferNumber varchar(100) = null,
	@ReferralNumber varchar(50) = null,
	@OrganType varchar(100) = null,
	@OptnNumber varchar(100) = null,
	@MatchId varchar(100) = null,
	@TransplantSurgeonContact varchar(100) = null,
	@ClinicalCoordinator varchar(100) = null,
	@CoordinatorFirstName varchar(100) = null,
	@CoordinatorLastName varchar(100) = null,
	@MostRecentStatus varchar(100) = null,
	@MostRecentComment varchar(200) = null,
	@IsDisplayClosed bit = null,
	@userOrganizationID INT
)
AS
/***************************************************************************************************
**	Name: TcssActiveCasesSelect
**	Desc: Get Data for TcssActiveCases
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	04/01/2009	Tanvir Ather	Initial Sproc Creation 
**	12/15/2009	Bret Knoll		Changed Referral Number to use ReferralNumber and not CallID
** 12/15/2009	Bret Knoll		Added SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 
** 12/18/2009	Bret Knoll		modified to use OrganizationName instead of ClientId
** 06/05/2010	Tanvir Ather	Add the other search criteria
** 12/2010      jth             added call active = 1 criteria in conjunction with "recycling" calls
** 2/11/11      jth             added nulling out other parms if callid is entered
** 4/11         jth				added timer stuff and userorgid parm
** 5/11			jth				totally reworked how closed is handled
** 5/11			jth				do search based on call last modified instead of RecentOfferStatusInformation.LastUpdateDate
***************************************************************************************************/
SET NOCOUNT ON;
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 

Declare @SearchOpenandClosed bit = 0,
		@pendingexpirationminutes int,
		@expirationminutes int 
SELECT TOP 1 @pendingexpirationminutes = [expirationminutes] FROM OrganizationDashBoardTimer
	   where DashBoardWindowId=4 and DashBoardTimerTypeID = 4 and OrganizationID = @userOrganizationID

SELECT TOP 1 @expirationminutes = [expirationminutes] FROM OrganizationDashBoardTimer 
	   where DashBoardWindowId=4 and DashBoardTimerTypeID = 1 and OrganizationID = @userOrganizationID
--IF(@MostRecentStatus = 'closed')
--Begin
--	set @MostRecentStatus = NULL
--end
IF( LEN(@CallId) = 7 AND PATINDEX('-', @CallId)=0 )
BEGIN
	SET @MinLastUpdatDate		= NULL
	SET @MaxLastUpdatDate		= NULL
	SET @Client			= NULL
	SET @ImportOfferNumber = NULL
	SET @ReferralNumber = NULL
	SET @OrganType = NULL
	SET @OptnNumber = NULL
	SET @MatchId = NULL
	SET @TransplantSurgeonContact = NULL
	SET @ClinicalCoordinator = NULL
	SET @CoordinatorFirstName = NULL
	SET @CoordinatorLastName = NULL
	SET @MostRecentStatus = NULL
	SET @MostRecentComment = NULL
	set @SearchOpenandClosed= 1
END

--Select @OrganizationId = dbo.GetOrganizationsByStatEmployeeId(@StatEmployeeId)
IF(@MostRecentStatus is null )
BEGIN
SELECT
	troi.CallId,
	td.TcssDonorId,
	tr.TcssRecipientId,
	c.LastModified,
	--td.LastUpdateDate,
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
	TcssListStatus.FieldValue AS MostRecentStatus,
	RecentOfferStatusInformation.Comment AS MostRecentComment,
	@pendingexpirationminutes as pendingexpirationminutes,
	@expirationminutes as expirationminutes
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
	LEFT JOIN StatEmployee RecentCoordinator ON RecentOfferStatusInformation.CoordinatorId = RecentCoordinator.StatEmployeeId
	LEFT JOIN TcssListOrganType ON troi.TcssListOrganTypeId = TcssListOrganType.TcssListOrganTypeId
	LEFT JOIN TcssListStatus ON RecentOfferStatusInformation.TcssListStatusId = TcssListStatus.TcssListStatusId
	LEFT JOIN Organization Client ON troi.ClientId = Client.OrganizationID
WHERE
	(@CallId IS NULL OR troi.CallId like @CallId + '%')
	--AND (@MinLastUpdatDate IS NULL OR RecentOfferStatusInformation.LastUpdateDate >= @MinLastUpdatDate)
	--AND (@MaxLastUpdatDate IS NULL OR RecentOfferStatusInformation.LastUpdateDate <= @MaxLastUpdatDate)
	AND (@MinLastUpdatDate IS NULL OR c.LastModified >= @MinLastUpdatDate)
	AND (@MaxLastUpdatDate IS NULL OR c.LastModified <= @MaxLastUpdatDate)
	AND (@Client IS NULL OR Client.OrganizationName like @Client + '%')
	AND (@ImportOfferNumber IS NULL OR troi.ImportOfferNumber like @ImportOfferNumber + '%')
	AND (@ReferralNumber IS NULL OR troi.ReferralNumber like @ReferralNumber + '%')
	AND (@OrganType IS NULL OR TcssListOrganType.FieldValue like @OrganType + '%')
	AND (@OptnNumber IS NULL OR td.OptnNumber like @OptnNumber + '%')
	AND (@MatchId IS NULL OR troi.MatchId like @MatchId + '%')
	AND (@TransplantSurgeonContact IS NULL OR trdi.TransplantSurgeonContactOther like @TransplantSurgeonContact + '%')
	AND (@ClinicalCoordinator IS NULL OR trdi.ClinicalCoordinatorOther like @ClinicalCoordinator + '%')
	AND (@CoordinatorFirstName IS NULL OR RecentCoordinator.StatEmployeeFirstName like @CoordinatorFirstName + '%')
	AND (@CoordinatorLastName IS NULL OR RecentCoordinator.StatEmployeeLastName like @CoordinatorLastName + '%')
	AND (@MostRecentStatus IS NULL OR TcssListStatus.FieldValue like @MostRecentStatus + '%')
	AND (@MostRecentComment IS NULL OR RecentOfferStatusInformation.Comment like @MostRecentComment + '%')
	AND ((@IsDisplayClosed IS NULL AND troi.TcssListCloseReason2Id IS NULL) OR
		 (@IsDisplayClosed IS NOT NULL AND troi.TcssListCloseReason2Id IS NOT NULL) or
		 (@IsDisplayClosed IS NULL AND @SearchOpenandClosed=1))
	AND
		CallActive = 1
	and
	(
		TcssListStatus.FieldValue <> 'Closed' and @SearchOpenandClosed = 0
		or
		@SearchOpenandClosed = 1
	)
	
ORDER BY Client, c.LastModified
END

IF(@MostRecentStatus is not null )
BEGIN
SELECT
	troi.CallId,
	td.TcssDonorId,
	tr.TcssRecipientId,
	c.LastModified,
	--td.LastUpdateDate,
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
	TcssListStatus.FieldValue AS MostRecentStatus,
	RecentOfferStatusInformation.Comment AS MostRecentComment,
	@pendingexpirationminutes as pendingexpirationminutes,
	@expirationminutes as expirationminutes
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
	LEFT JOIN StatEmployee RecentCoordinator ON RecentOfferStatusInformation.CoordinatorId = RecentCoordinator.StatEmployeeId
	LEFT JOIN TcssListOrganType ON troi.TcssListOrganTypeId = TcssListOrganType.TcssListOrganTypeId
	LEFT JOIN TcssListStatus ON RecentOfferStatusInformation.TcssListStatusId = TcssListStatus.TcssListStatusId
	LEFT JOIN Organization Client ON troi.ClientId = Client.OrganizationID
WHERE
	(@CallId IS NULL OR troi.CallId like @CallId + '%')
	--AND (@MinLastUpdatDate IS NULL OR RecentOfferStatusInformation.LastUpdateDate >= @MinLastUpdatDate)
	--AND (@MaxLastUpdatDate IS NULL OR RecentOfferStatusInformation.LastUpdateDate <= @MaxLastUpdatDate)
	AND (@MinLastUpdatDate IS NULL OR c.LastModified >= @MinLastUpdatDate)
	AND (@MaxLastUpdatDate IS NULL OR c.LastModified <= @MaxLastUpdatDate)
	AND (@Client IS NULL OR Client.OrganizationName like @Client + '%')
	AND (@ImportOfferNumber IS NULL OR troi.ImportOfferNumber like @ImportOfferNumber + '%')
	AND (@ReferralNumber IS NULL OR troi.ReferralNumber like @ReferralNumber + '%')
	AND (@OrganType IS NULL OR TcssListOrganType.FieldValue like @OrganType + '%')
	AND (@OptnNumber IS NULL OR td.OptnNumber like @OptnNumber + '%')
	AND (@MatchId IS NULL OR troi.MatchId like @MatchId + '%')
	AND (@TransplantSurgeonContact IS NULL OR trdi.TransplantSurgeonContactOther like @TransplantSurgeonContact + '%')
	AND (@ClinicalCoordinator IS NULL OR trdi.ClinicalCoordinatorOther like @ClinicalCoordinator + '%')
	AND (@CoordinatorFirstName IS NULL OR RecentCoordinator.StatEmployeeFirstName like @CoordinatorFirstName + '%')
	AND (@CoordinatorLastName IS NULL OR RecentCoordinator.StatEmployeeLastName like @CoordinatorLastName + '%')
	and TcssListStatus.FieldValue = @MostRecentStatus
	AND (@MostRecentComment IS NULL OR RecentOfferStatusInformation.Comment like @MostRecentComment + '%')
	--AND ((@IsDisplayClosed IS not NULL AND troi.TcssListCloseReason2Id IS not NULL) OR
	--	 (@IsDisplayClosed IS NULL AND troi.TcssListCloseReason2Id IS  NULL) )
	--	 (@IsDisplayClosed IS NULL AND @SearchOpenandClosed=1))
	--AND
	--	CallActive = 1
	
ORDER BY Client, c.LastModified
END

GRANT EXEC ON TcssActiveCasesSelect TO PUBLIC
GO
