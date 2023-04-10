

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'CriteriaSourceCodeUpdate')
	BEGIN
		PRINT 'Dropping Procedure CriteriaSourceCodeUpdate'
		DROP Procedure CriteriaSourceCodeUpdate
	END
GO

PRINT 'Creating Procedure CriteriaSourceCodeUpdate'
GO
CREATE Procedure CriteriaSourceCodeUpdate
(
		@CriteriaSourceCodeID int = null output,
		@CriteriaID int = null,
		@SourceCodeID int = null,
		@LastModified smalldatetime = null,
		@UpdatedFlag smallint = null,
		@LastStatEmployeeID int = null,
		@AuditLogTypeID int = null,
		@SourceCodeName varchar(10)					
)
AS
/******************************************************************************
**	File: CriteriaSourceCodeUpdate.sql
**	Name: CriteriaSourceCodeUpdate
**	Desc: Updates CriteriaSourceCode Based on Id field 
**	Auth: ccarroll
**	Date: 12/21/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	12/21/2009		ccarroll			Initial Sproc Creation
**	07/12/2010		ccarroll			added this note for development build (GenerateSQL)
*******************************************************************************/

UPDATE
	dbo.CriteriaSourceCode 	
SET 
		CriteriaID = @CriteriaID,
		SourceCodeID = @SourceCodeID,
		LastModified = GetDate(),
		UpdatedFlag = @UpdatedFlag,
		LastStatEmployeeID = @LastStatEmployeeID,
		AuditLogTypeID = ISNULL(@AuditLogTypeID, 3) /* 3 modified */
WHERE 
	CriteriaSourceCodeID = @CriteriaSourceCodeID 				

GO

GRANT EXEC ON CriteriaSourceCodeUpdate TO PUBLIC
GO
