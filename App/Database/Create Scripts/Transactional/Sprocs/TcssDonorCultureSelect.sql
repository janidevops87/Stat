IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorCultureSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorCultureSelect'
		DROP Procedure TcssDonorCultureSelect
	END
GO

PRINT 'Creating Procedure TcssDonorCultureSelect'
GO

CREATE PROCEDURE dbo.TcssDonorCultureSelect
(
	@TcssDonorId int,
	@TcssListCultureTypeId int = null
)
AS
/***************************************************************************************************
**	Name: TcssDonorCultureSelect
**	Desc: Update Data in table TcssDonorCulture
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	07/01/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tdc.TcssDonorCultureId,
	tdc.LastUpdateStatEmployeeId,
	tdc.LastUpdateDate,
	tdc.TcssDonorId,
	tdc.SampleDateTime,
	tdc.TcssListCultureTypeId,
	tdc.TcssListCultureResultId,
	tdc.Comment
FROM dbo.TcssDonorCulture tdc
WHERE
	tdc.TcssDonorId = @TcssDonorId
	AND (@TcssListCultureTypeId IS NULL OR tdc.TcssListCultureTypeId = @TcssListCultureTypeId)


GO

GRANT EXEC ON TcssDonorCultureSelect TO PUBLIC
GO
