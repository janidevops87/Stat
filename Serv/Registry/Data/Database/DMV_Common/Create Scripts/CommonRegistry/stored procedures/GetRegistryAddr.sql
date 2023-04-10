IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[GetRegistryAddr]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[GetRegistryAddr]
	PRINT 'Dropping Procedure: GetRegistryAddr'
END
	PRINT 'Creating Procedure: GetRegistryAddr'
GO

CREATE PROCEDURE [dbo].[GetRegistryAddr]
(
	--@RegistryAddrID int = NULL,
	@RegistryID int = NULL,
	@AddrTypeID int = NULL
)
/******************************************************************************
**		File: GetRegistryAddr.sql
**		Name: GetRegistryAddr
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

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 

	SELECT
		[RegistryAddrID],
		[RegistryID],
		[AddrTypeID],
		[Addr1],
		IsNull([Addr2],'') AS 'Addr2',
		[City],
		[State],
		[Zip],
		[CreateDate],
		[LastModified],
		[LastStatEmployeeID],
		[AuditLogTypeID]
	
	FROM
			[RegistryAddr]
	WHERE 
			--[RegistryAddrID] = IsNull(@RegistryAddrID, RegistryAddrID) AND
			[RegistryID] = @RegistryID AND
			[AddrTypeID] = IsNull(@AddrTypeID, AddrTypeID)

	RETURN @@Error
GO
