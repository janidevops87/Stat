 IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'spi_ReportSortTypeConfiguration')
	BEGIN
		PRINT 'Dropping Procedure spi_ReportSortTypeConfiguration'
		DROP  Procedure  spi_ReportSortTypeConfiguration
	END

GO

PRINT 'Creating Procedure spi_ReportSortTypeConfiguration'
GO
CREATE Procedure spi_ReportSortTypeConfiguration
	@ReportID	INT,
	@ReportSortTypeID INT
AS

/******************************************************************************
**		File: spi_ReportSortTypeConfiguration.sql
**		Name: spi_ReportSortTypeConfiguration
**		Desc: inserts a record into the ReportSortTypeConfiguration table
**
**              
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		ReportID
**		ReportSortTypeID
**
**		Auth: Bret Knoll
**		Date: 4/12/2007
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**		4/23/2007		Bret Knoll				initial
*******************************************************************************/
INSERT
	ReportSortTypeConfiguration (ReportID , ReportSortTypeID )

VALUES
	(@ReportID	,
	@ReportSortTypeID )

SELECT 
	ReportSortTypeConfigurationID
FROM
	ReportSortTypeConfiguration
WHERE
	ReportSortTypeConfigurationID = SCOPE_IDENTITY()


GO

GRANT EXEC ON spi_ReportSortTypeConfiguration TO PUBLIC

GO
