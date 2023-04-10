IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorStatusInformationInsert')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorStatusInformationInsert'
		DROP Procedure TcssDonorStatusInformationInsert
	END
GO

PRINT 'Creating Procedure TcssDonorStatusInformationInsert'
GO

CREATE PROCEDURE dbo.TcssDonorStatusInformationInsert
(
	@TcssDonorStatusInformationId int output,
	@LastUpdateStatEmployeeId int,
	@StatEmployeeName varchar(100),
	@LastUpdateDate datetime = null,
	@TcssDonorId int,
	@DateTime smalldatetime = null,
	@StatEmployeeId int = null,
	@TcssListStatusId int = null,
	@Comment varchar(200) = null
)
AS
/***************************************************************************************************
**	Name: TcssDonorStatusInformationInsert
**	Desc: Insert Data into table TcssDonorStatusInformation
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	07/07/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

INSERT INTO dbo.TcssDonorStatusInformation
(
	LastUpdateStatEmployeeId,
	LastUpdateDate,
	TcssDonorId,
	DateTime,
	StatEmployeeId,
	TcssListStatusId,
	Comment
)
VALUES
(
	@LastUpdateStatEmployeeId,
	IsNull(@LastUpdateDate, GetUtcDate()),
	@TcssDonorId,
	@DateTime,
	@StatEmployeeId,
	@TcssListStatusId,
	@Comment
)

-- Return the new identity value
SET @TcssDonorStatusInformationId = @@Identity

GO

GRANT EXEC ON TcssDonorStatusInformationInsert TO PUBLIC
GO
