
		IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'ReferralDelete')
			BEGIN
				PRINT 'Dropping Procedure ReferralDelete'
				DROP Procedure ReferralDelete
			END
		GO

		PRINT 'Creating Procedure ReferralDelete'
		GO

		CREATE PROCEDURE dbo.ReferralDelete
		(	
			@ReferralID int,					
			@LastStatEmployeeId int = null,
			@LastModified datetime = null,
			@AuditLogTypeId int = null
		)
		AS
		/******************************************************************************
		**	File: ReferralDelete.sql 
		**	Name: ReferralDelete
		**	Desc: Updates and Deletes a row of Referral, updating AuditTrail
		**	Auth: Bret Knoll
		**	Date: 1/7/2011
		**	Called By: 
		*******************************************************************************
		**	Change History
		*******************************************************************************
		**	Date:			Author:				Description:
		**	--------		--------			----------------------------------
		**	1/7/2011		Bret Knoll			Initial Sproc Creation
		*******************************************************************************/
		DECLARE @callId INT
		SELECT @callId = Referral.CallID FROM Referral WHERE Referral.ReferralID = @ReferralID
		
		EXEC spi_CallRecycleSuspend
			@callId	= @callId,
			@callSaveLastByID = @LastStatEmployeeId

		GO

		GRANT EXEC ON ReferralDelete TO PUBLIC
		GO
		