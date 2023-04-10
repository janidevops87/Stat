 

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SourceCodeSelectDataSet')
	BEGIN
		PRINT 'Dropping Procedure SourceCodeSelectDataSet'
		DROP Procedure SourceCodeSelectDataSet
	END
GO

PRINT 'Creating Procedure SourceCodeSelectDataSet'
GO
CREATE Procedure SourceCodeSelectDataSet
(
		@SourceCodeID int = null output,
		@StatEmployeeID int = null					
)

AS

/******************************************************************************
**	File: SourceCodeSelectDataSet.sql
**	Name: SourceCodeSelectDataSet
**	Desc: Selects Data Set for Administration SourceCode 
**	Auth: ccarroll
**	Date: 10/30/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	10/30/2009		ccarroll			Initial Sproc Creation
**	07/12/2010		ccarroll			added this note for development build (GenerateSQL)
**	07/26/2010		ccarroll			added SourceCodeASP and parameters
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED


	EXEC dbo.SourceCodeSelect @SourceCodeID = @SourceCodeID
	--EXEC dbo.SourceCodeOrganizationSelect @SourceCodeID = @SourceCodeID
	EXEC dbo.AspSourceCodeMapSelect @SourceCodeID = @SourceCodeID
	EXEC dbo.DonorTracURLSelect @SourceCodeID = @SourceCodeID
	EXEC dbo.DonorTracIdentifierSelect @SourceCodeID = @SourceCodeID
	EXEC dbo.SourceCodeTransplantCenterSelect @SourceCodeID = @SourceCodeID
	EXEC dbo.SourceCodeASPSelect @SourceCodeID = @SourceCodeID

GO

GRANT EXEC ON SourceCodeSelectDataSet TO PUBLIC
GO
