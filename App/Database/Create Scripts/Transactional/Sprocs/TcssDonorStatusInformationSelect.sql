IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorStatusInformationSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorStatusInformationSelect'
		DROP Procedure TcssDonorStatusInformationSelect
	END
GO

PRINT 'Creating Procedure TcssDonorStatusInformationSelect'
GO

CREATE PROCEDURE dbo.TcssDonorStatusInformationSelect
(
	@TcssDonorId int
)
AS
/***************************************************************************************************
**	Name: TcssDonorStatusInformationSelect
**	Desc: Update Data in table TcssDonorStatusInformation
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	07/07/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tdsi.TcssDonorStatusInformationId,
	tdsi.LastUpdateStatEmployeeId,
	isnull(StatEmployeeFirstName + ' ', '') + isnull(StatEmployeeLastName, '') AS StatEmployeeName,
	tdsi.LastUpdateDate,
	tdsi.TcssDonorId,
	tdsi.DateTime,
	tdsi.StatEmployeeId,
	tdsi.TcssListStatusId,
	tdsi.Comment
FROM dbo.TcssDonorStatusInformation tdsi
	LEFT JOIN dbo.StatEmployee se ON tdsi.StatEmployeeId = se.StatEmployeeId
WHERE
	tdsi.TcssDonorId = @TcssDonorId
ORDER BY tdsi.DateTime DESC

GO

GRANT EXEC ON TcssDonorStatusInformationSelect TO PUBLIC
GO
