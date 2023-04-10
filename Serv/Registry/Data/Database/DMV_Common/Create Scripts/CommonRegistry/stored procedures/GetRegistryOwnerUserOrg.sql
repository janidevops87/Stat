IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[GetRegistryOwnerUserOrg]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[GetRegistryOwnerUserOrg]
	PRINT 'Dropping Procedure: GetRegistryOwnerUserOrg'
END
	PRINT 'Creating Procedure: GetRegistryOwnerUserOrg'
GO

CREATE PROCEDURE [dbo].[GetRegistryOwnerUserOrg]
(
	@UserOrgID int = NULL,
	@returnVal	int OUTPUT
)
/******************************************************************************
**		File: GetRegistryOwnerUserOrg.sql
**		Name: GetRegistryOwnerUserOrg
**		Desc:  National Web Registry
**
**		Called by:  
**              
**
**		Auth: ccarroll
**		Date: 05/19/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		05/19/2009	ccarroll	initial
*******************************************************************************/
AS

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 

IF @UserOrgID = 194
	BEGIN
		SET @ReturnVal = -1
	END
ELSE
	BEGIN
		IF (SELECT Count(*) FROM RegistryOwnerUserOrg WHERE UserOrgID = @UserOrgID) = 0
		BEGIN
			SET @ReturnVal = 0
		END
		ELSE
		BEGIN
			SET @ReturnVal =
				(SELECT TOP 1
					RegistryOwnerID 
				FROM
					RegistryOwnerUserOrg
				WHERE 
					UserOrgID = @UserOrgID
				)
		END
	END

RETURN ISNull(@ReturnVal, 0) 

GO