IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[GetRegistryOwnerGrantedAccess]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[GetRegistryOwnerGrantedAccess]
	PRINT 'Dropping Procedure: GetRegistryOwnerGrantedAccess'
END
	PRINT 'Creating Procedure: GetRegistryOwnerGrantedAccess'
GO

CREATE PROCEDURE [dbo].[GetRegistryOwnerGrantedAccess]
(
	@RegistryOwnerID int = NULL
)
/******************************************************************************
**		File: GetRegistryOwnerGrantedAccess.sql
**		Name: GetRegistryOwnerGrantedAccess
**		Desc:  National Web Registry
**
**		Called by:  
**              
**
**		Auth: ccarroll
**		Date: 02/19/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		02/19/2009	ccarroll	initial
*******************************************************************************/
AS

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 

	SELECT
		[RegistryOwnerGrantedAccessID],
		[RegistryOwnerID],
		[RegistryGrantedOwnerID],
		[CreateDate],
		[LastModified],
		[LastStatEmployeeID],
		[AuditLogTypeID]
	
	FROM
			[RegistryOwnerGrantedAccess]
	WHERE 
		[RegistryOwnerID] = IsNull(@RegistryOwnerID, RegistryOwnerID)


	RETURN @@Error
GO

