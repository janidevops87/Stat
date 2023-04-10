IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[UpdateRegistryOwnerStateConfig]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[UpdateRegistryOwnerStateConfig]
	PRINT 'Dropping Procedure: UpdateRegistryOwnerStateConfig'
END
	PRINT 'Creating Procedure: UpdateRegistryOwnerStateConfig'
GO

CREATE PROCEDURE [dbo].[UpdateRegistryOwnerStateConfig]
(
	@RegistryOwnerStateConfigID int,
	@RegistryOwnerID int = NULL,
	@RegistryOwnerStateID bit = NULL,
	@RegistryOwnerStateAbbrv varchar(2) = NULL,
	@RegistryOwnerStateName varchar(50) = NULL,
	@RegistryOwnerStateVerificationForm varchar(50) = NULL,
	@RegistryOwnerStateDMVDSN varchar(25) = NULL,
	@RegistryOwnerStateActive bit = NULL,
	@LastStatEmployeeID int = NULL
)
/******************************************************************************
**		File: UpdateRegistryOwnerStateConfig.sql
**		Name: UpdateRegistryOwnerStateConfig
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
	SET NOCOUNT ON
	
	UPDATE [RegistryOwnerStateConfig]
	SET
		[RegistryOwnerID] = IsNull(@RegistryOwnerID, RegistryOwnerID),
		[RegistryOwnerStateID] = IsNull(@RegistryOwnerStateID, RegistryOwnerStateID),
		[RegistryOwnerStateAbbrv] = IsNull(@RegistryOwnerStateAbbrv, RegistryOwnerStateAbbrv),
		[RegistryOwnerStateName] = IsNull(@RegistryOwnerStateName, RegistryOwnerStateName),
		[RegistryOwnerStateVerificationForm] = IsNull(@RegistryOwnerStateVerificationForm, RegistryOwnerStateVerificationForm),
		[RegistryOwnerStateDMVDSN] = IsNull(@RegistryOwnerStateDMVDSN, RegistryOwnerStateDMVDSN),
		[RegistryOwnerStateActive] = IsNull(@RegistryOwnerStateActive, RegistryOwnerStateActive),
		[LastModified] = GetDate(),
		[LastStatEmployeeID] = IsNull(@LastStatEmployeeID, LastStatEmployeeID),
		[AuditLogTypeID] = 3 --Modify
	WHERE 
		[RegistryOwnerStateConfigID] = @RegistryOwnerStateConfigID


	RETURN @@Error
GO
