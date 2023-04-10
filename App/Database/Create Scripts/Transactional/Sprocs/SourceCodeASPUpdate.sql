

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'SourceCodeASPUpdate')
	BEGIN
		PRINT 'Dropping Procedure SourceCodeASPUpdate'
		DROP Procedure SourceCodeASPUpdate
	END
GO

PRINT 'Creating Procedure SourceCodeASPUpdate'
GO
CREATE Procedure SourceCodeASPUpdate
(
		@SourceCodeASPId int = null output,
		@SourceCodeId int = null,
		@ASP bit = null,
		@LastModified datetime = null,
		@LastStatEmployeeID int = null,
		@AuditLogTypeID int = null					
)
AS
/******************************************************************************
**	File: SourceCodeASPUpdate.sql
**	Name: SourceCodeASPUpdate
**	Desc: Updates SourceCodeASP Based on Id field 
**	Auth: ccarroll
**	Date: 7/26/2010
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	7/26/2010		ccarroll			Initial Sproc Creation
*******************************************************************************/

UPDATE
	dbo.SourceCodeASP 	
SET 
		SourceCodeId = @SourceCodeId,
		ASP = @ASP,
		LastModified = GetDate(),
		LastStatEmployeeID = @LastStatEmployeeID,
		AuditLogTypeID = ISNULL(@AuditLogTypeID, 3) /* 3 modified */
WHERE 
	SourceCodeASPId = @SourceCodeASPId 				

GO

GRANT EXEC ON SourceCodeASPUpdate TO PUBLIC
GO
