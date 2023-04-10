 IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[InsertRegistryAddr]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
	BEGIN
			DROP PROCEDURE [dbo].[InsertRegistryAddr]
			PRINT 'Dropping Procedure: InsertRegistryAddr'
	END

PRINT 'Creating Procedure: InsertRegistryAddr'
GO

CREATE PROCEDURE [dbo].[InsertRegistryAddr]
(
	@RegistryAddrID int = NULL OUTPUT,
	@RegistryID int = NULL,
	@AddrTypeID int = NULL,
	@Addr1 varchar(40) = NULL,
	@Addr2 varchar(20) = NULL,
	@City varchar(25) = NULL,
	@State varchar(2) = NULL,
	@Zip varchar(10) = NULL,
	@LastStatEmployeeID int = NULL
)
/******************************************************************************
**		File: InsertRegistryAddr.sql
**		Name: InsertRegistryAddr
**		Desc: 
**
**		Called by:   
**              
**
**		Auth: ccarroll
**		Date: 03/02/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		03/02/2009	ccarroll	initial
*******************************************************************************/
AS
	SET NOCOUNT ON

	INSERT INTO [RegistryAddr]
	(
		[RegistryID],
		[AddrTypeID],
		[Addr1],
		[Addr2],
		[City],
		[State],
		[Zip],
		[CreateDate],
		[LastModified],
		[LastStatEmployeeID],
		[AuditLogTypeID]
	)
	VALUES
	(
		@RegistryID,
		@AddrTypeID,
		@Addr1,
		@Addr2,
		@City,
		@State,
		@Zip,
		GetDate(),	--@CreateDate,
		GetDate(),	--@LastModified,
		@LastStatEmployeeID,
		1			--Create, @AuditLogTypeID
	)

	SELECT @RegistryAddrID = SCOPE_IDENTITY();

	RETURN @@Error
GO
