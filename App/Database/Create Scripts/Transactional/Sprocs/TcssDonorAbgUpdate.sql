IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorAbgUpdate')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorAbgUpdate'
		DROP Procedure TcssDonorAbgUpdate
	END
GO

PRINT 'Creating Procedure TcssDonorAbgUpdate'
GO

CREATE PROCEDURE dbo.TcssDonorAbgUpdate
(
	@TcssDonorAbgId int,
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
**	Name: TcssDonorAbgUpdate
**	Desc: Update Data in table TcssDonorAbg
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	07/01/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

UPDATE dbo.TcssDonorAbg
SET
	LastUpdateStatEmployeeId = @LastUpdateStatEmployeeId,
	LastUpdateDate = IsNull(@LastUpdateDate, GetUtcDate()),
	TcssDonorId = @TcssDonorId,
	SampleDateTime = @SampleDateTime,
	Ph = @Ph,
	Pco2 = @Pco2,
	Po2 = @Po2,
	Hco3 = @Hco3,
	O2sat = @O2sat,
	TcssListVentSettingModeId = @TcssListVentSettingModeId,
	ModeOther = @ModeOther,
	Fio2 = @Fio2,
	Rate = @Rate,
	Vt = @Vt,
	Peep = @Peep,
	Pip = @Pip
WHERE
	TcssDonorAbgId = @TcssDonorAbgId
GO

GRANT EXEC ON TcssDonorAbgUpdate TO PUBLIC
GO
