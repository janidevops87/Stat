IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssHeaderSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssHeaderSelect'
		DROP Procedure TcssHeaderSelect
	END
GO

PRINT 'Creating Procedure TcssHeaderSelect'
GO

CREATE PROCEDURE dbo.TcssHeaderSelect
(
	@TcssRecipientId int
)
AS
/***************************************************************************************************
**	Name: TcssHeaderSelect
**	Desc: Get Data for TcssHeaderSelect
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	04/01/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT
	'' AS RecipientName,
	1 AS SequenceNumber,
	--IsNull(tr.RecipientFirstName + ' ', '') + IsNull(tr.RecipientLastName, '') AS RecipientName,
	--tr.SequenceNumber AS SequenceNumber,
	TcssListOrganType.FieldValue AS OrganType,
	sc.SourceCodeName AS SourceCode,
	troi.ClientId AS Client,
	td.OptnNumber AS OptnNumber,
	troi.MatchId AS MatchId,
	tr.TcssRecipientId AS TcssRecipientId,
	td.LastUpdateDate AS UpdatedDateTime,
	troi.ImportOfferNumber AS ImportNumber,
	c.CallId AS ReferralNumber,
	TcssListStatus.FieldValue AS MostRecentStatus
FROM dbo.TcssDonor td 
	INNER JOIN TcssRecipient tr ON td.TcssDonorId = tr.TcssRecipientId
	INNER JOIN TcssRecipientOfferInformation troi ON troi.TcssRecipientId = tr.TcssRecipientId
	INNER JOIN TcssDonorStatusInformation recentStatus ON 
		(
			recentStatus.TcssDonorId = td.TcssDonorId
			AND recentStatus.LastUpdateDate = (Select Max(LastUpdateDate) From TcssDonorStatusInformation Where TcssDonorId = td.TcssDonorId)
		)
	LEFT JOIN dbo.Call c ON troi.CallId = c.CallId
	LEFT JOIN dbo.SourceCode sc ON c.SourceCodeId = sc.SourceCodeId

	LEFT JOIN Person recentStatusPerson ON recentStatus.StatEmployeeId = recentStatusPerson.PersonId
	LEFT JOIN TcssListOrganType ON troi.TcssListOrganTypeId = TcssListOrganType.TcssListOrganTypeId
	LEFT JOIN TcssListStatus ON recentStatus.TcssListStatusId = TcssListStatus.TcssListStatusId
WHERE tr.TcssRecipientId = @TcssRecipientId
GO

GRANT EXEC ON TcssHeaderSelect TO PUBLIC
GO
 