 IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[GetExportFileConfiguration]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[GetExportFileConfiguration]
	PRINT 'Dropping Procedure: GetExportFileConfiguration'
END
	PRINT 'Creating Procedure: GetExportFileConfiguration'
GO

CREATE PROCEDURE [dbo].[GetExportFileConfiguration]
(
	@ExportFileConfigurationID int = NULL,
	@OrganizationID int = NULL
)
/******************************************************************************
**		File: GetExportFileConfiguration.sql
**		Name: GetExportFileConfiguration
**		Desc:  Used on StatFile
**
**		Called by:  
**              
**
**		Auth: Bret Knoll
**		Date: 02/25/2008
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		02/25/2008	Bret Knoll	initial
*******************************************************************************/
AS

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 
	
	EXEC GetExportFileXslt
	EXEC GetExportFileDataType
	EXEC GetExportFileType	
    EXEC GetExportFile @ExportFileConfigurationID , @OrganizationID 


GO

 
 
