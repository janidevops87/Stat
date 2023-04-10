IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorCompleteBloodCountUpdate')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorCompleteBloodCountUpdate'
		DROP Procedure TcssDonorCompleteBloodCountUpdate
	END
GO

PRINT 'Creating Procedure TcssDonorCompleteBloodCountUpdate'
GO

CREATE PROCEDURE dbo.TcssDonorCompleteBloodCountUpdate
(
	@TcssDonorCompleteBloodCountId int,
	@LastUpdateStatEmployeeId int,
	@LastUpdateDate datetime = null,
	@TcssDonorId int,
	@SampleDateTime smalldatetime = null,
	@Wbc varchar(50) = null,
	@Rbc varchar(50) = null,
	@Hgb varchar(50) = null,
	@Hct varchar(50) = null,
	@Plt varchar(50) = null,
	@Bands decimal(18,2) = null
)
AS
/***************************************************************************************************
**	Name: TcssDonorCompleteBloodCountUpdate
**	Desc: Update Data in table TcssDonorCompleteBloodCount
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	07/01/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

UPDATE dbo.TcssDonorCompleteBloodCount
SET
	LastUpdateStatEmployeeId = @LastUpdateStatEmployeeId,
	LastUpdateDate = IsNull(@LastUpdateDate, GetUtcDate()),
	TcssDonorId = @TcssDonorId,
	SampleDateTime = @SampleDateTime,
	Wbc = @Wbc,
	Rbc = @Rbc,
	Hgb = @Hgb,
	Hct = @Hct,
	Plt = @Plt,
	Bands = @Bands
WHERE
	TcssDonorCompleteBloodCountId = @TcssDonorCompleteBloodCountId
GO

GRANT EXEC ON TcssDonorCompleteBloodCountUpdate TO PUBLIC
GO
