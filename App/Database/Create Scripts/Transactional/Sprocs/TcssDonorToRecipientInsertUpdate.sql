IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorToRecipientInsertUpdate')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorToRecipientInsertUpdate'
		DROP Procedure TcssDonorToRecipientInsertUpdate
	END
GO

PRINT 'Creating Procedure TcssDonorToRecipientInsertUpdate'
GO

CREATE PROCEDURE dbo.TcssDonorToRecipientInsertUpdate
(
	@TcssDonorToRecipientId int output,
	@LastUpdateStatEmployeeId int,
	@LastUpdateDate datetime = null,
	@TcssDonorId int,
	@TcssRecipientId int,
	@CallId int,
	@ClientName  varchar(100),
	@TcssListOrganType varchar(100)
)
AS
/***************************************************************************************************
**	Name: TcssDonorToRecipientInsertUpdate
**	Desc: Insert Data into table TcssDonorToRecipient
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	07/01/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM TcssDonorToRecipient WHERE TcssRecipientId = @TcssRecipientId)
BEGIN
	-- INSERT
	INSERT INTO dbo.TcssDonorToRecipient
	(
		LastUpdateStatEmployeeId,
		LastUpdateDate,
		TcssDonorId,
		TcssRecipientId
	)
	VALUES
	(
		@LastUpdateStatEmployeeId,
		IsNull(@LastUpdateDate, GetUtcDate()),
		@TcssDonorId,
		@TcssRecipientId
	)
	
	-- Return the new identity value
	SET @TcssDonorToRecipientId = @@Identity

END
ELSE
BEGIN

	DECLARE @CopyFromTcssDonorId int,
		@CopyToTcssDonorToRecipientId int

	-- Get the DonorId for the callId so that we can associate multiple reciepient for one donor
	SELECT @CopyFromTcssDonorId = dtr.TcssDonorId
	FROM TcssRecipientOfferInformation roi
		INNER JOIN TcssDonorToRecipient dtr ON roi.TcssRecipientId = dtr.TcssRecipientId
	WHERE roi.CallId = @CallId
	
	IF(@CopyFromTcssDonorId IS NULL)
	BEGIN
		DECLARE @ErrorMsg varchar(100) = cast(@CallId as varchar(20)) + ' is not a valid Oasis# in associated DonorCard'
		RAISERROR (@ErrorMsg, 
					16, -- Severity.
					1 -- State.
					);
		RETURN
	END

	-- The the row id for the current recipietn record
	SELECT @CopyToTcssDonorToRecipientId = dtr.TcssDonorToRecipientId
	FROM TcssDonorToRecipient dtr
	WHERE dtr.TcssRecipientId = @TcssRecipientId
		
	-- UPDATE
	UPDATE dbo.TcssDonorToRecipient
	SET
		LastUpdateStatEmployeeId = @LastUpdateStatEmployeeId,
		LastUpdateDate = IsNull(@LastUpdateDate, GetUtcDate()),
		TcssDonorId = @CopyFromTcssDonorId
	WHERE
		TcssDonorToRecipientId = @CopyToTcssDonorToRecipientId

	-- we need to update @TcssDonorToRecipientId so that the dataset does not have unique id conflict
	SELECT @TcssDonorToRecipientId = dtr.TcssDonorToRecipientId
	FROM TcssRecipientOfferInformation roi
		INNER JOIN TcssDonorToRecipient dtr ON roi.TcssRecipientId = dtr.TcssRecipientId
	WHERE roi.CallId = @CallId
		AND dtr.TcssDonorId = @CopyFromTcssDonorId

END

GO

GRANT EXEC ON TcssDonorToRecipientInsertUpdate TO PUBLIC
GO
 