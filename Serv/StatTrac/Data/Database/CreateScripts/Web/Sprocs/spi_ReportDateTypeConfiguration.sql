IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'spi_ReportDateTypeConfiguration')
	BEGIN
		PRINT 'Dropping Procedure spi_ReportDateTypeConfiguration'
		DROP  Procedure  spi_ReportDateTypeConfiguration
	END

GO

PRINT 'Creating Procedure spi_ReportDateTypeConfiguration'
GO
CREATE Procedure spi_ReportDateTypeConfiguration
	@ReportID	INT,
	@ReportDateTypeID INT,
	@ReportDateTypeConfigurationIsDefault BIT = 0
AS

/******************************************************************************
**		File: spi_ReportDateTypeConfiguration.sql
**		Name: spi_ReportDateTypeConfiguration
**		Desc: inserts a record into the ReportDateTypeConfiguration table
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
**		ReportDateTypeID
**
**		Auth: Bret Knoll
**		Date: 4/12/2007
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**		4/12/2007		Bret Knoll				initial
*******************************************************************************/
INSERT
	ReportDateTypeConfiguration 
	(
		ReportID , 
		ReportDateTypeID, 
		ReportDateTypeConfigurationIsDefault 
	)

VALUES
	(
		@ReportID	,
		@ReportDateTypeID ,
		@ReportDateTypeConfigurationIsDefault
	)

SELECT 
	ReportDateTypeConfigurationID
FROM
	ReportDateTypeConfiguration
WHERE
	ReportDateTypeConfigurationID = SCOPE_IDENTITY()


GO

GRANT EXEC ON spi_ReportDateTypeConfiguration TO PUBLIC

GO
