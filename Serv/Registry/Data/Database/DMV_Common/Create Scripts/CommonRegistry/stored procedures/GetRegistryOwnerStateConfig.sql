IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[GetRegistryOwnerStateConfig]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[GetRegistryOwnerStateConfig]
	PRINT 'Dropping Procedure: GetRegistryOwnerStateConfig'
END
	PRINT 'Creating Procedure: GetRegistryOwnerStateConfig'
GO

CREATE PROCEDURE [dbo].[GetRegistryOwnerStateConfig]
(
	@RegistryOwnerStateConfigID int = NULL,
	@RegistryOwnerID int = NULL,
	@DisplayAllStates smallint = NULL
)
/******************************************************************************
**		File: GetRegistryOwnerStateConfig.sql
**		Name: GetRegistryOwnerStateConfig
**		Desc: Common Web Registry
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
**		03/26/2010	ccarroll	added @DisplayAllStates parameter
**									1. 0 = Display only active DRDSN states
**									2. 1 = Display All registry owner states 
*******************************************************************************/
AS

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 

IF @RegistryOwnerID = -1 /* Return all States */
BEGIN
	SET @RegistryOwnerID = Null
END


IF IsNull(@DisplayAllStates, 0) = 1
BEGIN
	SET @DisplayAllStates = Null /* Return all States */
END
ELSE
BEGIN
	SET @DisplayAllStates = 0 /* Return only states which have active DRDSN (valid databases) */
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
		IsNull(DisableDMVSearchOption, 0) = IsNull(@DisplayAllStates, IsNull(DisableDMVSearchOption, 0)) -- Display active database DMV States
	ORDER BY
	[RegistryOwnerStateAbbrv]



	RETURN @@Error
GO
