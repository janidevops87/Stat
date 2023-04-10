IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDuplicateReferalsSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssDuplicateReferalsSelect'
		DROP Procedure TcssDuplicateReferalsSelect
	END
GO

PRINT 'Creating Procedure TcssDuplicateReferalsSelect'
GO

CREATE PROCEDURE dbo.TcssDuplicateReferalsSelect
(
	@CurrentCallId int,
	@SourceCodeId int,
	@TcssListOrganTypeId int,
	@MatchId varchar(100),
	@OptnNumber varchar(100),
	@OrgID int
)
AS
/***************************************************************************************************
**	Name: TcssDuplicateReferalsSelect
**	Desc: Select Data for FamilyServices
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	04/01/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT
	troi.CallId,
	td.TcssDonorId,
	tr.TcssRecipientId,
	td.LastUpdateDate,
	troi.ImportOfferNumber,
	troi.ReferralNumber,
	SourceCode.SourceCodeName,
	Client.OrganizationName AS Client,
	TcssListStatus.FieldValue AS MostRecentStatus
FROM dbo.TcssDonor td
	INNER JOIN TcssDonorToRecipient tdr ON td.TcssDonorId = tdr.TcssDonorId
	INNER JOIN TcssRecipient tr ON tr.TcssRecipientId = tdr.TcssRecipientId
	INNER JOIN TcssRecipientOfferInformation troi ON troi.TcssRecipientId = tr.TcssRecipientId
	INNER JOIN TcssRecipientOfferStatusInformation RecentOfferStatusInformation ON 
		(
			RecentOfferStatusInformation.TcssRecipientId = tr.TcssRecipientId
			AND RecentOfferStatusInformation.LastUpdateDate = (Select Max(LastUpdateDate) From TcssRecipientOfferStatusInformation Where TcssRecipientId = tr.TcssRecipientId)
		)
	LEFT JOIN TcssListStatus ON RecentOfferStatusInformation.TcssListStatusId = TcssListStatus.TcssListStatusId
	LEFT JOIN Organization Client ON troi.ClientId = Client.OrganizationID
	LEFT JOIN dbo.Call c ON troi.CallId = c.CallId
	LEFT JOIN SourceCode ON c.SourceCodeId = SourceCode.SourceCodeID
WHERE
	troi.TcssListOrganTypeId = @TcssListOrganTypeId
	AND troi.MatchId = @MatchId
	AND td.OptnNumber = @OptnNumber
	AND troi.CallId != @CurrentCallId
	and (select NumberOfDaysToSearch FROM OrganizationDuplicateSearchRule where DuplicateSearchRuleId = 5 and CallTypeID = 6 and OrganizationId = @OrgID) > datediff(d,c.CallDateTime,GETDATE()) 
ORDER BY c.SourceCodeId, Client.OrganizationName

GO

GRANT EXEC ON TcssDuplicateReferalsSelect TO PUBLIC
GO
 