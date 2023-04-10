IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[GetRegistryOwnerStateDMVSearchOptions]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[GetRegistryOwnerStateDMVSearchOptions]
	PRINT 'Dropping Procedure: GetRegistryOwnerStateDMVSearchOptions'
END
	PRINT 'Creating Procedure: GetRegistryOwnerStateDMVSearchOptions'
GO

CREATE PROCEDURE [dbo].[GetRegistryOwnerStateDMVSearchOptions]
(
	@RegistryOwnerStateConfigID int = NULL,
	@RegistryOwnerID int = NULL
)
/******************************************************************************
**		File: GetRegistryOwnerStateDMVSearchOptions.sql
**		Name: GetRegistryOwnerStateDMVSearchOptions
**		Desc: Common Web Registry
**
**		Called by:  
**              
**
**		Auth: ccarroll
**		Date: 02/17/2010
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		02/17/2010	ccarroll	initial
*******************************************************************************/
AS

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 
	
	IF @RegistryOwnerID = -1 /* Return all States */
	BEGIN
		SET @RegistryOwnerID = Null
	END

	SELECT
		[RegistryOwnerStateConfigID],
		[RegistryOwnerID],
		[RegistryOwnerStateID],
		[RegistryOwnerStateAbbrv],
		[RegistryOwnerStateName],
		[RegistryOwnerStateVerificationForm],
		[RegistryOwnerStateDMVDSN],
		[RegistryOwnerStateActive],
		[CreateDate],
		[LastModified],
		[LastStatEmployeeID],
		[AuditLogTypeID]
	
	FROM
			[RegistryOwnerStateConfig]
	WHERE 
		[RegistryOwnerStateConfigID] = IsNull(@RegistryOwnerStateConfigID, RegistryOwnerStateConfigID) AND
		[RegistryOwnerID] = IsNull(@RegistryOwnerID, RegistryOwnerID) AND
		IsNull([RegistryOwnerStateActive],0) = 1 AND --Active
		IsNull(DisableDMVSearchOption, 0) = 0 -- Display all states not disabled
	ORDER BY
	[RegistryOwnerStateAbbrv]

	RETURN @@Error
GO
