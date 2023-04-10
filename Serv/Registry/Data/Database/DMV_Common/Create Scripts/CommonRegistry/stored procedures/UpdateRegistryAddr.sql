 IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[UpdateRegistryAddr]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[UpdateRegistryAddr]
	PRINT 'Dropping Procedure: UpdateRegistryAddr'
END
	PRINT 'Creating Procedure: UpdateRegistryAddr'
GO

CREATE PROCEDURE [dbo].[UpdateRegistryAddr]
(
	--@RegistryAddrID int,
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
**		File: UpdateRegistryAddr.sql
**		Name: UpdateRegistryAddr
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
	
	UPDATE [RegistryAddr]
	SET
		--[AddrTypeID] = IsNull(@AddrTypeID, AddrTypeID),
		[Addr1] = IsNull(@Addr1, Addr1),
		[Addr2] = IsNull(@Addr2, Addr2),
		[City] = IsNull(@City, City),
		[State] = IsNull(@State, State),
		[Zip] = IsNull(@Zip, Zip),
		[LastModified] = GetDate(),
		[LastStatEmployeeID] = IsNull(@LastStatEmployeeID, LastStatEmployeeID),
		[AuditLogTypeID] = 3 --Modify
	WHERE 
		--[RegistryAddrID] = @RegistryAddrID
		[RegistryID] = @RegistryID AND
		[AddrTypeID] = @AddrTypeID
	RETURN @@Error
GO