IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'DonorTracURLInsert')
	BEGIN
		PRINT 'Dropping Procedure DonorTracURLInsert'
		DROP Procedure DonorTracURLInsert
	END
GO

PRINT 'Creating Procedure DonorTracURLInsert'
GO
CREATE Procedure DonorTracURLInsert
(
		@DonorTracURLID int = null output,
		@DonorTracProductionURL varchar(100) = null,
		@SourceCode varchar(50) = null,
		@SourceCodeID int = null,
		@LastModified datetime = null,
		@LastStatEmployeeID int = null,
		@AuditLogTypeID int = null					
)
AS
/******************************************************************************
**	File: DonorTracURLInsert.sql
**	Name: DonorTracURLInsert
**	Desc: Inserts DonorTracURL Based on Id field 
**	Auth: ccarroll
**	Date: 10/23/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	10/23/2009		ccarroll			Initial Sproc Creation
**	07/12/2010		ccarroll			added this note for development build (GenerateSQL)
*******************************************************************************/

INSERT	DonorTracURL
	(
		DonorTracProductionURL,
		SourceCode,
		SourceCodeID,
		LastModified,
		LastStatEmployeeID,
		AuditLogTypeID
	)
VALUES
	(
		@DonorTracProductionURL,
		@SourceCode,
		@SourceCodeID,
		@LastModified,
		@LastStatEmployeeID,
		ISNULL(@AuditLogTypeID, 1) /* insert */
	)

SET @DonorTracURLID = SCOPE_IDENTITY()

EXEC DonorTracURLSelect @DonorTracURLID

GO

GRANT EXEC ON DonorTracURLInsert TO PUBLIC
GO
