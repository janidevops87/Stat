

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'AlertSourceCodeInsert')
	BEGIN
		PRINT 'Dropping Procedure AlertSourceCodeInsert'
		DROP Procedure AlertSourceCodeInsert
	END
GO

PRINT 'Creating Procedure AlertSourceCodeInsert'
GO
CREATE Procedure AlertSourceCodeInsert
(
		@AlertSourceCodeID int = null output,
		@AlertID int = null,		
		@SourceCodeID int = null,		
		@LastModified smalldatetime = null,
		@UpdatedFlag smallint = null					
)
AS
/******************************************************************************
**	File: AlertSourceCodeInsert.sql
**	Name: AlertSourceCodeInsert
**	Desc: Inserts AlertSourceCode Based on Id field 
**	Auth: Bret Knoll
**	Date: 1/26/2011
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	1/26/2011		Bret Knoll			Initial Sproc Creation (9376)
*******************************************************************************/

INSERT	AlertSourceCode
	(
		AlertID,
		SourceCodeID,
		LastModified,
		UpdatedFlag
	)
VALUES
	(
		@AlertID,
		@SourceCodeID,
		@LastModified,
		@UpdatedFlag
	)

SET @AlertSourceCodeID = SCOPE_IDENTITY()

EXEC AlertSourceCodeSelect @AlertSourceCodeID

GO

GRANT EXEC ON AlertSourceCodeInsert TO PUBLIC
GO
