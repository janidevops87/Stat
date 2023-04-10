IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorLabValuesInsert')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorLabValuesInsert'
		DROP Procedure TcssDonorLabValuesInsert
	END
GO

PRINT 'Creating Procedure TcssDonorLabValuesInsert'
GO

CREATE PROCEDURE dbo.TcssDonorLabValuesInsert
(
	@TcssDonorLabValuesId int output,
	@LastUpdateStatEmployeeId int,
	@LastUpdateDate datetime = null,
	@TcssDonorId int,
	@SampleDateTime smalldatetime = null,
	@Cpk varchar(50) = null,
	@Ckmb varchar(50) = null,
	@TroponinL varchar(50) = null,
	@TroponinT varchar(50) = null
)
AS
/***************************************************************************************************
**	Name: TcssDonorLabValuesInsert
**	Desc: Insert Data into table TcssDonorLabValues
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	07/01/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

INSERT INTO dbo.TcssDonorLabValues
(
	LastUpdateStatEmployeeId,
	LastUpdateDate,
	TcssDonorId,
	SampleDateTime,
	Cpk,
	Ckmb,
	TroponinL,
	TroponinT
)
VALUES
(
	@LastUpdateStatEmployeeId,
	IsNull(@LastUpdateDate, GetUtcDate()),
	@TcssDonorId,
	@SampleDateTime,
	@Cpk,
	@Ckmb,
	@TroponinL,
	@TroponinT
)

-- Return the new identity value
SET @TcssDonorLabValuesId = @@Identity

GO

GRANT EXEC ON TcssDonorLabValuesInsert TO PUBLIC
GO
