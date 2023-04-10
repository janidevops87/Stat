IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorAbgInsert')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorAbgInsert'
		DROP Procedure TcssDonorAbgInsert
	END
GO

PRINT 'Creating Procedure TcssDonorAbgInsert'
GO

CREATE PROCEDURE dbo.TcssDonorAbgInsert
(
	@TcssDonorAbgId int output,
	@LastUpdateStatEmployeeId int,
	@LastUpdateDate datetime = null,
	@TcssDonorId int,
	@SampleDateTime smalldatetime = null,
	@Ph decimal(18,2) = null,
	@Pco2 decimal(18,2) = null,
	@Po2 decimal(18,2) = null,
	@Hco3 decimal(18,2) = null,
	@O2sat decimal(18,2) = null,
	@TcssListVentSettingModeId int = null,
	@ModeOther varchar(50) = null,
	@Fio2 decimal(18,2) = null,
	@Rate decimal(18,2) = null,
	@Vt decimal(18,2) = null,
	@Peep decimal(18,2) = null,
	@Pip decimal(18,2) = null
)
AS
/***************************************************************************************************
**	Name: TcssDonorAbgInsert
**	Desc: Insert Data into table TcssDonorAbg
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	07/01/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

INSERT INTO dbo.TcssDonorAbg
(
	LastUpdateStatEmployeeId,
	LastUpdateDate,
	TcssDonorId,
	SampleDateTime,
	Ph,
	Pco2,
	Po2,
	Hco3,
	O2sat,
	TcssListVentSettingModeId,
	ModeOther,
	Fio2,
	Rate,
	Vt,
	Peep,
	Pip
)
VALUES
(
	@LastUpdateStatEmployeeId,
	IsNull(@LastUpdateDate, GetUtcDate()),
	@TcssDonorId,
	@SampleDateTime,
	@Ph,
	@Pco2,
	@Po2,
	@Hco3,
	@O2sat,
	@TcssListVentSettingModeId,
	@ModeOther,
	@Fio2,
	@Rate,
	@Vt,
	@Peep,
	@Pip
)

-- Return the new identity value
SET @TcssDonorAbgId = @@Identity

GO

GRANT EXEC ON TcssDonorAbgInsert TO PUBLIC
GO
