  

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'WebReportGroupOrgSelectDataSet')
	BEGIN
		PRINT 'Dropping Procedure WebReportGroupOrgSelectDataSet'
		DROP Procedure WebReportGroupOrgSelectDataSet
	END
GO

PRINT 'Creating Procedure WebReportGroupOrgSelectDataSet'
GO
CREATE Procedure WebReportGroupOrgSelectDataSet
(
		@WebReportGroupOrgID int = null output,
		@StatEmployeeID int = null					
)

AS

/******************************************************************************
**	File: WebReportGroupOrgSelectDataSet.sql
**	Name: WebReportGroupOrgSelectDataSet
**	Desc: Selects Data Set for Administration SourceCode 
**	Auth: ccarroll
**	Date: 05/16/2011
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	05/16/2011		ccarroll			Initial Sproc Creation
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED


	EXEC dbo.WebReportGroupOrgSelect @WebReportGroupOrgID = @WebReportGroupOrgID

GO
	
GRANT EXEC ON WebReportGroupOrgSelectDataSet TO PUBLIC
GO
