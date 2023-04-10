

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'AlertSourceCodeUpdate')
	BEGIN
		PRINT 'Dropping Procedure AlertSourceCodeUpdate'
		DROP Procedure AlertSourceCodeUpdate
	END
GO

PRINT 'Creating Procedure AlertSourceCodeUpdate'
GO
CREATE Procedure AlertSourceCodeUpdate
(
		@AlertSourceCodeID int = null output,
		@AlertID int = null,		
		@SourceCodeID int = null,		
		@LastModified smalldatetime = null,
		@UpdatedFlag smallint = null					
)
AS
/******************************************************************************
**	File: AlertSourceCodeUpdate.sql
**	Name: AlertSourceCodeUpdate
**	Desc: Updates AlertSourceCode Based on Id field 
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

UPDATE
	dbo.AlertSourceCode 	
SET 
		AlertID = @AlertID,
		SourceCodeID = @SourceCodeID,
		LastModified = GetDate(),
		UpdatedFlag = @UpdatedFlag
WHERE 
	AlertSourceCodeID = @AlertSourceCodeID 				

GO

GRANT EXEC ON AlertSourceCodeUpdate TO PUBLIC
GO
