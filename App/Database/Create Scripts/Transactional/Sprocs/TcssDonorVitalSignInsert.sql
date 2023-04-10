IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorVitalSignInsert')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorVitalSignInsert'
		DROP Procedure TcssDonorVitalSignInsert
	END
GO

PRINT 'Creating Procedure TcssDonorVitalSignInsert'
GO

CREATE PROCEDURE dbo.TcssDonorVitalSignInsert
(
	@TcssDonorVitalSignId int output,
	@LastUpdateStatEmployeeId int,
	@LastUpdateDate datetime = null,
	@TcssDonorId int,
	@FromDateTime smalldatetime = null,
	@ToDateTime smalldatetime = null
)
AS
/***************************************************************************************************
**	Name: TcssDonorVitalSignInsert
**	Desc: Insert Data into table TcssDonorVitalSign
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	07/01/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

INSERT INTO dbo.TcssDonorVitalSign
(
	LastUpdateStatEmployeeId,
	LastUpdateDate,
	TcssDonorId,
	FromDateTime,
	ToDateTime
)
VALUES
(
	@LastUpdateStatEmployeeId,
	IsNull(@LastUpdateDate, GetUtcDate()),
	@TcssDonorId,
	@FromDateTime,
	@ToDateTime
)

-- Return the new identity value
SET @TcssDonorVitalSignId = @@Identity

GO

GRANT EXEC ON TcssDonorVitalSignInsert TO PUBLIC
GO
