IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorHlaLiverSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorHlaLiverSelect'
		DROP Procedure TcssDonorHlaLiverSelect
	END
GO

PRINT 'Creating Procedure TcssDonorHlaLiverSelect'
GO

CREATE PROCEDURE dbo.TcssDonorHlaLiverSelect
(
	@TcssDonorId int
)
AS
/***************************************************************************************************
**	Name: TcssDonorHlaLiverSelect
**	Desc: Update Data in table TcssDonorHlaLiver
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	07/07/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tdhl.TcssDonorHlaLiverId,
	tdhl.LastUpdateStatEmployeeId,
	tdhl.LastUpdateDate,
	tdhl.TcssDonorId,
	tdhl.TcssListPreliminaryCrossmatchId,
	tdhl.PreAdmissionHistory,
	tdhl.TcssListHlaA1Id,
	tdhl.TcssListHlaA2Id,
	tdhl.TcssListHlaB1Id,
	tdhl.TcssListHlaB2Id,
	tdhl.TcssListHlaBw4Id,
	tdhl.TcssListHlaBw6Id,
	tdhl.TcssListHlaC1Id,
	tdhl.TcssListHlaC2Id,
	tdhl.TcssListHlaDr1Id,
	tdhl.TcssListHlaDr2Id,
	tdhl.TcssListHlaDr51Id,
	tdhl.TcssListHlaDr52Id,
	tdhl.TcssListHlaDr53Id,
	tdhl.TcssListHlaDq1Id,
	tdhl.TcssListHlaDq2Id
FROM dbo.TcssDonorHlaLiver tdhl
WHERE
	tdhl.TcssDonorId = @TcssDonorId

GO

GRANT EXEC ON TcssDonorHlaLiverSelect TO PUBLIC
GO
