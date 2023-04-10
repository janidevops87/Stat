IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorSelect'
		DROP Procedure TcssDonorSelect
	END
GO

PRINT 'Creating Procedure TcssDonorSelect'
GO

CREATE PROCEDURE dbo.TcssDonorSelect
(
	@TcssDonorId int,
	@TcssRecipientId int
)
AS
/***************************************************************************************************
**	Name: TcssDonorSelect
**	Desc: Update Data in table TcssDonor
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	02/22/2010	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/
SET NOCOUNT ON;

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 
SELECT 
	td.TcssDonorId,
	td.LastUpdateStatEmployeeId,
	td.LastUpdateDate,
	td.OptnNumber,
	(select StatEmployeeFirstName + ' ' + StatEmployeeLastName from StatEmployee where StatEmployeeID = (Select top 1 LastUpdateStatEmployeeId From TcssRecipientOfferStatusInformation Where TcssRecipientId = @TcssRecipientId order by 1 asc)) as CallTakenBy
FROM dbo.TcssDonor td
WHERE
	td.TcssDonorId = @TcssDonorId
GO

GRANT EXEC ON TcssDonorSelect TO PUBLIC
GO
