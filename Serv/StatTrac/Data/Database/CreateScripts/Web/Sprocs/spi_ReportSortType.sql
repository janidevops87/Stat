 IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'spi_ReportSortType')
	BEGIN
		PRINT 'Dropping Procedure spi_ReportSortType'
		DROP  Procedure  spi_ReportSortType
	END

GO

PRINT 'Creating Procedure spi_ReportSortType'
GO
CREATE Procedure spi_ReportSortType
	@ReportSortTypeName varchar(50),
	@ReportSortTypeDisplayName varchar(50)
AS

/******************************************************************************
**		File: spi_ReportSortType.sql
**		Name: spi_ReportSortType
**		Desc: inserts records into the ReportSortType
**
**              
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		ReportSortTypeName
**		ReportSortTypeDisplayName
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
	ReportSortType (ReportSortTypeName, ReportSortTypeDisplayname )
VALUES (@ReportSortTypeName, @ReportSortTypeDisplayname )

SELECT 
	ReportSortTypeID
FROM 
	ReportSortType
WHERE
	ReportSortTypeID = SCOPE_IDENTITY( )	


GO

GRANT EXEC ON spi_ReportSortType TO PUBLIC

GO
