  IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'CriteriaProcessorUpdate')
	BEGIN
		PRINT 'Dropping Procedure CriteriaProcessorUpdate'
		DROP Procedure CriteriaProcessorUpdate
	END
GO

PRINT 'Creating Procedure CriteriaProcessorUpdate'
GO
CREATE Procedure CriteriaProcessorUpdate
(
		@CriteriaProcessorID int = null output,
		@CriteriaID int = null,
		@OrganizationID int = null,
		@LastModified datetime = null,
		@UpdatedFlag smallint = null,
		@LastStatEmployeeID int = null,
		@AuditLogTypeID int = null					
)
AS
/******************************************************************************
**	File: CriteriaProcessorUpdate.sql
**	Name: CriteriaProcessorUpdate
**	Desc: Updates CriteriaProcessor Based on Id field 
**	Auth: ccarroll
**	Date: 12/18/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	12/18/2009		ccarroll			Initial Sproc Creation
**	07/09/2010		ccarroll			added this note for development build (GenerateSQL)
*******************************************************************************/

UPDATE
	dbo.CriteriaProcessor 	
SET 
		CriteriaID = @CriteriaID,
		OrganizationID = @OrganizationID,
		LastModified = GetDate(),
		UpdatedFlag = @UpdatedFlag,
		LastStatEmployeeID = @LastStatEmployeeID,
		AuditLogTypeID = ISNULL(@AuditLogTypeID, 3) /* 3 modified */
WHERE 
	CriteriaProcessorID = @CriteriaProcessorID 				

GO

GRANT EXEC ON CriteriaProcessorUpdate TO PUBLIC
GO
