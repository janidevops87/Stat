

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'SourceCodeASPInsert')
	BEGIN
		PRINT 'Dropping Procedure SourceCodeASPInsert'
		DROP Procedure SourceCodeASPInsert
	END
GO

PRINT 'Creating Procedure SourceCodeASPInsert'
GO
CREATE Procedure SourceCodeASPInsert
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
**	File: SourceCodeASPInsert.sql
**	Name: SourceCodeASPInsert
**	Desc: Inserts SourceCodeASP Based on Id field 
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

INSERT	SourceCodeASP
	(
		SourceCodeId,
		ASP,
		LastModified,
		LastStatEmployeeID,
		AuditLogTypeID
	)
VALUES
	(
		@SourceCodeId,
		@ASP,
		@LastModified,
		@LastStatEmployeeID,
		ISNULL(@AuditLogTypeID, 1) /* insert */
	)

SET @SourceCodeASPID = SCOPE_IDENTITY()

EXEC SourceCodeASPSelect @SourceCodeASPID

GO

GRANT EXEC ON SourceCodeASPInsert TO PUBLIC
GO
