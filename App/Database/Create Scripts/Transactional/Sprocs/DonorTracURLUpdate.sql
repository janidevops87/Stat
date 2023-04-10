IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'DonorTracURLUpdate')
	BEGIN
		PRINT 'Dropping Procedure DonorTracURLUpdate'
		DROP Procedure DonorTracURLUpdate
	END
GO

PRINT 'Creating Procedure DonorTracURLUpdate'
GO
CREATE Procedure DonorTracURLUpdate
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
**	File: DonorTracURLUpdate.sql
**	Name: DonorTracURLUpdate
**	Desc: Updates DonorTracURL Based on Id field 
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

UPDATE
	dbo.DonorTracURL 	
SET 
		DonorTracProductionURL = @DonorTracProductionURL,
		SourceCode = @SourceCode,
		SourceCodeID = @SourceCodeID,
		LastModified = GetDate(),
		LastStatEmployeeID = @LastStatEmployeeID,
		AuditLogTypeID = ISNULL(@AuditLogTypeID, 3) /* 3 modified */
WHERE 
	DonorTracURLID = @DonorTracURLID 				

GO

GRANT EXEC ON DonorTracURLUpdate TO PUBLIC
GO
