IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorCompleteBloodCountInsert')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorCompleteBloodCountInsert'
		DROP Procedure TcssDonorCompleteBloodCountInsert
	END
GO

PRINT 'Creating Procedure TcssDonorCompleteBloodCountInsert'
GO

CREATE PROCEDURE dbo.TcssDonorCompleteBloodCountInsert
(
	@TcssDonorCompleteBloodCountId int output,
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
**	Name: TcssDonorCompleteBloodCountInsert
**	Desc: Insert Data into table TcssDonorCompleteBloodCount
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	07/01/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

INSERT INTO dbo.TcssDonorCompleteBloodCount
(
	LastUpdateStatEmployeeId,
	LastUpdateDate,
	TcssDonorId,
	SampleDateTime,
	Wbc,
	Rbc,
	Hgb,
	Hct,
	Plt,
	Bands
)
VALUES
(
	@LastUpdateStatEmployeeId,
	IsNull(@LastUpdateDate, GetUtcDate()),
	@TcssDonorId,
	@SampleDateTime,
	@Wbc,
	@Rbc,
	@Hgb,
	@Hct,
	@Plt,
	@Bands
)

-- Return the new identity value
SET @TcssDonorCompleteBloodCountId = @@Identity

GO

GRANT EXEC ON TcssDonorCompleteBloodCountInsert TO PUBLIC
GO
