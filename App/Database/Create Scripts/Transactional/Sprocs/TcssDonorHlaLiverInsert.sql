IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorHlaLiverInsert')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorHlaLiverInsert'
		DROP Procedure TcssDonorHlaLiverInsert
	END
GO

PRINT 'Creating Procedure TcssDonorHlaLiverInsert'
GO

CREATE PROCEDURE dbo.TcssDonorHlaLiverInsert
(
	@TcssDonorHlaLiverId int output,
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
**	Name: TcssDonorHlaLiverInsert
**	Desc: Insert Data into table TcssDonorHlaLiver
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	07/07/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

INSERT INTO dbo.TcssDonorHlaLiver
(
	LastUpdateStatEmployeeId,
	LastUpdateDate,
	TcssDonorId,
	TcssListPreliminaryCrossmatchId,
	PreAdmissionHistory,
	TcssListHlaA1Id,
	TcssListHlaA2Id,
	TcssListHlaB1Id,
	TcssListHlaB2Id,
	TcssListHlaBw4Id,
	TcssListHlaBw6Id,
	TcssListHlaC1Id,
	TcssListHlaC2Id,
	TcssListHlaDr1Id,
	TcssListHlaDr2Id,
	TcssListHlaDr51Id,
	TcssListHlaDr52Id,
	TcssListHlaDr53Id,
	TcssListHlaDq1Id,
	TcssListHlaDq2Id
)
VALUES
(
	@LastUpdateStatEmployeeId,
	IsNull(@LastUpdateDate, GetUtcDate()),
	@TcssDonorId,
	@TcssListPreliminaryCrossmatchId,
	@PreAdmissionHistory,
	@TcssListHlaA1Id,
	@TcssListHlaA2Id,
	@TcssListHlaB1Id,
	@TcssListHlaB2Id,
	@TcssListHlaBw4Id,
	@TcssListHlaBw6Id,
	@TcssListHlaC1Id,
	@TcssListHlaC2Id,
	@TcssListHlaDr1Id,
	@TcssListHlaDr2Id,
	@TcssListHlaDr51Id,
	@TcssListHlaDr52Id,
	@TcssListHlaDr53Id,
	@TcssListHlaDq1Id,
	@TcssListHlaDq2Id
)

-- Return the new identity value
SET @TcssDonorHlaLiverId = @@Identity

GO

GRANT EXEC ON TcssDonorHlaLiverInsert TO PUBLIC
GO
