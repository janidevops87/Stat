IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[SourceCodeByOrganizationIdListSelect]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[SourceCodeByOrganizationIdListSelect]
	PRINT 'Dropping Procedure: SourceCodeByOrganizationIdListSelect'
END
	PRINT 'Creating Procedure: SourceCodeByOrganizationIdListSelect'
GO

CREATE PROCEDURE [dbo].[SourceCodeByOrganizationIdListSelect]
(
	@StatEmployeeUserId int = null,
	@OrganizationId int = null
)
/******************************************************************************
**		File: SourceCodeByOrganizationIdListSelect.sql
**		Name: SourceCodeByOrganizationIdListSelect
**		Desc:  Calls SourceCodeListSelect
**
**		Called by:  
**              
**
**		Auth: bret
**		Date: 6/19/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		6/19/2009	bret		initial
**		2/16/2011	Bret		Removing StatEmployeeID 
**		6/10/2011	ccarroll	re-introduced StatEmployeeID parameter
*******************************************************************************/
AS
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 
	SET NOCOUNT ON 
	
	EXEC SourceCodeListSelect @StatEmployeeUserId, @OrganizationId


	RETURN @@Error
GO
 