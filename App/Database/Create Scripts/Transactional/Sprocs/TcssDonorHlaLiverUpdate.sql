IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorHlaLiverUpdate')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorHlaLiverUpdate'
		DROP Procedure TcssDonorHlaLiverUpdate
	END
GO

PRINT 'Creating Procedure TcssDonorHlaLiverUpdate'
GO

CREATE PROCEDURE dbo.TcssDonorHlaLiverUpdate
(
	@TcssDonorHlaLiverId int,
	@LastUpdateStatEmployeeId int,
	@LastUpdateDate datetime = null,
	@TcssDonorId int,
	@TcssListPreliminaryCrossmatchId int = null,
	@PreAdmissionHistory varchar(500) = null,
	@TcssListHlaA1Id int = null,
	@TcssListHlaA2Id int = null,
	@TcssListHlaB1Id int = null,
	@TcssListHlaB2Id int = null,
	@TcssListHlaBw4Id int = null,
	@TcssListHlaBw6Id int = null,
	@TcssListHlaC1Id int = null,
	@TcssListHlaC2Id int = null,
	@TcssListHlaDr1Id int = null,
	@TcssListHlaDr2Id int = null,
	@TcssListHlaDr51Id int = null,
	@TcssListHlaDr52Id int = null,
	@TcssListHlaDr53Id int = null,
	@TcssListHlaDq1Id int = null,
	@TcssListHlaDq2Id int = null
)
AS
/***************************************************************************************************
**	Name: TcssDonorHlaLiverUpdate
**	Desc: Update Data in table TcssDonorHlaLiver
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	07/07/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

UPDATE dbo.TcssDonorHlaLiver
SET
	LastUpdateStatEmployeeId = @LastUpdateStatEmployeeId,
	LastUpdateDate = IsNull(@LastUpdateDate, GetUtcDate()),
	TcssDonorId = @TcssDonorId,
	TcssListPreliminaryCrossmatchId = @TcssListPreliminaryCrossmatchId,
	PreAdmissionHistory = @PreAdmissionHistory,
	TcssListHlaA1Id = @TcssListHlaA1Id,
	TcssListHlaA2Id = @TcssListHlaA2Id,
	TcssListHlaB1Id = @TcssListHlaB1Id,
	TcssListHlaB2Id = @TcssListHlaB2Id,
	TcssListHlaBw4Id = @TcssListHlaBw4Id,
	TcssListHlaBw6Id = @TcssListHlaBw6Id,
	TcssListHlaC1Id = @TcssListHlaC1Id,
	TcssListHlaC2Id = @TcssListHlaC2Id,
	TcssListHlaDr1Id = @TcssListHlaDr1Id,
	TcssListHlaDr2Id = @TcssListHlaDr2Id,
	TcssListHlaDr51Id = @TcssListHlaDr51Id,
	TcssListHlaDr52Id = @TcssListHlaDr52Id,
	TcssListHlaDr53Id = @TcssListHlaDr53Id,
	TcssListHlaDq1Id = @TcssListHlaDq1Id,
	TcssListHlaDq2Id = @TcssListHlaDq2Id
WHERE
	TcssDonorHlaLiverId = @TcssDonorHlaLiverId
GO

GRANT EXEC ON TcssDonorHlaLiverUpdate TO PUBLIC
GO
