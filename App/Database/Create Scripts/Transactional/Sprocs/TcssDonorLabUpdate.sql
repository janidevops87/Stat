IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorLabUpdate')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorLabUpdate'
		DROP Procedure TcssDonorLabUpdate
	END
GO

PRINT 'Creating Procedure TcssDonorLabUpdate'
GO

CREATE PROCEDURE dbo.TcssDonorLabUpdate
(
	@TcssDonorLabId int,
	@LastUpdateStatEmployeeId int,
	@LastUpdateDate datetime = null,
	@TcssDonorId int,
	@TcssListToxicologyScreenId int = null,
	@Results varchar(500) = null,
	@OtherLabs varchar(500) = null,
	@HbA1c dec(18,1) = null,
	@HbA1cDateTime smalldatetime = null
)
AS
/***************************************************************************************************
**	Name: TcssDonorLabUpdate
**	Desc: Update Data in table TcssDonorLab
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	07/01/2009	Tanvir Ather	Initial Sproc Creation
**  11/2010     jth				added HbA1c fields
***************************************************************************************************/

UPDATE dbo.TcssDonorLab
SET
	LastUpdateStatEmployeeId = @LastUpdateStatEmployeeId,
	LastUpdateDate = IsNull(@LastUpdateDate, GetUtcDate()),
	TcssDonorId = @TcssDonorId,
	TcssListToxicologyScreenId = @TcssListToxicologyScreenId,
	Results = @Results,
	OtherLabs = @OtherLabs,
	HbA1c = @HbA1c,
    HbA1cDateTime = @HbA1cDateTime
WHERE
	TcssDonorLabId = @TcssDonorLabId
GO

GRANT EXEC ON TcssDonorLabUpdate TO PUBLIC
GO
