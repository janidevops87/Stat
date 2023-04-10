 IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[BillToDelete]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[BillToDelete]
	PRINT 'Dropping Procedure: BillToDelete'
END
	PRINT 'Creating Procedure: BillToDelete'
GO

CREATE PROCEDURE [dbo].[BillToDelete]
(
	@BillToID int = NULL,
	@OrganizationID int = NULL,
	@LastStatEmployeeId int,
	@LastModified datetime = null,
	@AuditLogTypeId int = null
)
/******************************************************************************
**		File: BillToDelete.sql
**		Name: BillToDelete
**		Desc:  Used on QA Update Tab, Web UI
**
**		Called by:   
**              
**
**		Auth: bret
**		Date: 7/6/2009
*******************************************************************************
**		Change History
*******************************************************************************
**	Date:			Author:		Description:
**	--------		--------	-------------------------------------------
**	7/6/2009		bret		initial
**  01/18/2011		Bret Knoll	Updated to handle cascade delete from Organization
*******************************************************************************/
AS

	SET NOCOUNT ON
	IF(COALESCE(@BillToID, 0) <> 0 OR COALESCE(@OrganizationID, 0) <> 0)
	BEGIN

		UPDATE
			[BillTo]
		SET
			LastModified = COALESCE(@LastModified ,GetDate()),
			LastStatEmployeeID = @LastStatEmployeeId,
			AuditLogTypeID = COALESCE(@AuditLogTypeId, 4)  -- @AuditLogTypeID 4 = Delete 
		WHERE 			
			[BillToID] = Coalesce(@BillToID, BillToID)
		AND
			[OrganizationID]= COALESCE(@OrganizationID, OrganizationID)

		DELETE 
		FROM   
			[BillTo]
		WHERE  
		(
			[BillToID] = Coalesce(@BillToID, BillToID)
		AND
			[OrganizationID]= COALESCE(@OrganizationID, OrganizationID)
		)
	END
	RETURN @@Error
GO