IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'spi_ReportDateType')
	BEGIN
		PRINT 'Dropping Procedure spi_ReportDateType'
		DROP  Procedure  spi_ReportDateType
	END

GO

PRINT 'Creating Procedure spi_ReportDateType'
GO
CREATE Procedure spi_ReportDateType
	@ReportDateTypeName varchar(50),
	@ReportDateTypeDisplayName varchar(50)
AS

/******************************************************************************
**		File: spi_ReportDateType.sql
**		Name: spi_ReportDateType
**		Desc: inserts records into the ReportDateType
**
**              
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		ReportDateTypeName
**		ReportDateTypeDisplayName
**
**		Auth: Bret Knoll
**		Date: 04/12/2007
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**    04/12/2007		Bret Knoll				initial 
*******************************************************************************/


INSERT 
	ReportDateType (ReportDateTypeName, ReportDateTypeDisplayname )
VALUES (@ReportDateTypeName, @ReportDateTypeDisplayname )

SELECT 
	ReportDateTypeID
FROM 
	ReportDateType
WHERE
	ReportDateTypeID = SCOPE_IDENTITY( )	


GO

GRANT EXEC ON spi_ReportDateType TO PUBLIC

GO
