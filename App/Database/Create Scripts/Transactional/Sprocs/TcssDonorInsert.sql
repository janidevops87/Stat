IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorInsert')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorInsert'
		DROP Procedure TcssDonorInsert
	END
GO

PRINT 'Creating Procedure TcssDonorInsert'
GO

CREATE PROCEDURE dbo.TcssDonorInsert
(
	@TcssDonorId int output,
	@LastUpdateStatEmployeeId int,
	@LastUpdateDate datetime = null,
	@OptnNumber varchar(20) = null,
	@CallTakenBy varchar(20) = null
)
AS
/***************************************************************************************************
**	Name: TcssDonorInsert
**	Desc: Insert Data into table TcssDonor
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	02/22/2010	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

INSERT INTO dbo.TcssDonor
(
	LastUpdateStatEmployeeId,
	LastUpdateDate,
	OptnNumber
)
VALUES
(
	@LastUpdateStatEmployeeId,
	IsNull(@LastUpdateDate, GetUtcDate()),
	@OptnNumber
)

-- Return the new identity value
SET @TcssDonorId = @@Identity

GO

GRANT EXEC ON TcssDonorInsert TO PUBLIC
GO
