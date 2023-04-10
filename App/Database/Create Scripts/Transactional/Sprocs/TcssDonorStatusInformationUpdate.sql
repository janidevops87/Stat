IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorStatusInformationUpdate')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorStatusInformationUpdate'
		DROP Procedure TcssDonorStatusInformationUpdate
	END
GO

PRINT 'Creating Procedure TcssDonorStatusInformationUpdate'
GO

CREATE PROCEDURE dbo.TcssDonorStatusInformationUpdate
(
	@TcssDonorStatusInformationId int,
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
**	Name: TcssDonorStatusInformationUpdate
**	Desc: Update Data in table TcssDonorStatusInformation
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	07/07/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

UPDATE dbo.TcssDonorStatusInformation
SET
	LastUpdateStatEmployeeId = @LastUpdateStatEmployeeId,
	LastUpdateDate = IsNull(@LastUpdateDate, GetUtcDate()),
	TcssDonorId = @TcssDonorId,
	DateTime = @DateTime,
	StatEmployeeId = @StatEmployeeId,
	TcssListStatusId = @TcssListStatusId,
	Comment = @Comment
WHERE
	TcssDonorStatusInformationId = @TcssDonorStatusInformationId
GO

GRANT EXEC ON TcssDonorStatusInformationUpdate TO PUBLIC
GO
