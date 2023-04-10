IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorLabValuesUpdate')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorLabValuesUpdate'
		DROP Procedure TcssDonorLabValuesUpdate
	END
GO

PRINT 'Creating Procedure TcssDonorLabValuesUpdate'
GO

CREATE PROCEDURE dbo.TcssDonorLabValuesUpdate
(
	@TcssDonorLabValuesId int,
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
**	Name: TcssDonorLabValuesUpdate
**	Desc: Update Data in table TcssDonorLabValues
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	07/01/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

UPDATE dbo.TcssDonorLabValues
SET
	LastUpdateStatEmployeeId = @LastUpdateStatEmployeeId,
	LastUpdateDate = IsNull(@LastUpdateDate, GetUtcDate()),
	TcssDonorId = @TcssDonorId,
	SampleDateTime = @SampleDateTime,
	Cpk = @Cpk,
	Ckmb = @Ckmb,
	TroponinL = @TroponinL,
	TroponinT = @TroponinT
WHERE
	TcssDonorLabValuesId = @TcssDonorLabValuesId
GO

GRANT EXEC ON TcssDonorLabValuesUpdate TO PUBLIC
GO
