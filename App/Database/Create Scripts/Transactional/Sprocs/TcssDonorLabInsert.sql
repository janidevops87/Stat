IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorLabInsert')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorLabInsert'
		DROP Procedure TcssDonorLabInsert
	END
GO

PRINT 'Creating Procedure TcssDonorLabInsert'
GO

CREATE PROCEDURE dbo.TcssDonorLabInsert
(
	@TcssDonorLabId int output,
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
**	Name: TcssDonorLabInsert
**	Desc: Insert Data into table TcssDonorLab
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	07/01/2009	Tanvir Ather	Initial Sproc Creation 
**  2/2011      jth				added HbA1c fields
***************************************************************************************************/

INSERT INTO dbo.TcssDonorLab
(
	LastUpdateStatEmployeeId,
	LastUpdateDate,
	TcssDonorId,
	TcssListToxicologyScreenId,
	Results,
	OtherLabs,
	HbA1c,
    HbA1cDateTime
)
VALUES
(
	@LastUpdateStatEmployeeId,
	IsNull(@LastUpdateDate, GetUtcDate()),
	@TcssDonorId,
	@TcssListToxicologyScreenId,
	@Results,
	@OtherLabs,
	@HbA1c,
    @HbA1cDateTime
)

-- Return the new identity value
SET @TcssDonorLabId = @@Identity

GO

GRANT EXEC ON TcssDonorLabInsert TO PUBLIC
GO
