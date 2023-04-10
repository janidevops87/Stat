

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'IndicationResponseUpdate')
	BEGIN
		PRINT 'Dropping Procedure IndicationResponseUpdate'
		DROP Procedure IndicationResponseUpdate
	END
GO

PRINT 'Creating Procedure IndicationResponseUpdate'
GO
CREATE Procedure IndicationResponseUpdate
(
		@IndicationResponseID int = null output,
		@IndicationResponseName nvarchar(50) = null,
		@LastModified datetime = null,
		@LastStatEmployeeID int = null,
		@AuditLogTypeID int = null					
)
AS
/******************************************************************************
**	File: IndicationResponseUpdate.sql
**	Name: IndicationResponseUpdate
**	Desc: Updates IndicationResponse Based on Id field 
**	Auth: ccarroll
**	Date: 11/20/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	11/20/2009		ccarroll			Initial Sproc Creation
**	07/12/2010		ccarroll			added this note for development build (GenerateSQL)
*******************************************************************************/

UPDATE
	dbo.IndicationResponse 	
SET 
		IndicationResponseName = @IndicationResponseName,
		LastModified = GetDate(),
		LastStatEmployeeID = @LastStatEmployeeID,
		AuditLogTypeID = ISNULL(@AuditLogTypeID, 3) /* 3 modified */
WHERE 
	IndicationResponseID = @IndicationResponseID 				

GO

GRANT EXEC ON IndicationResponseUpdate TO PUBLIC
GO
