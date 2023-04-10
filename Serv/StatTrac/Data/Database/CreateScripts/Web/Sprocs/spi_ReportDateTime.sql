IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'spi_ReportDateTime')
	BEGIN
		PRINT 'Dropping Procedure spi_ReportDateTime'
		DROP  Procedure  spi_ReportDateTime
	END

GO

PRINT 'Creating Procedure spi_ReportDateTime'
GO
CREATE Procedure spi_ReportDateTime
	@ReportDateTimeName VARCHAR(50)
AS

/******************************************************************************
**		File: spi_ReportDateTime.sql
**		Name: spi_ReportDateTime
**		Desc: 
**
**              
**		Return values:
**			see list
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**
**		Auth: Bret Knoll
**		Date: 7/26/07
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------	
**		07/26/07	Bret Knoll			initial
*******************************************************************************/

	INSERT
		ReportDateTime
			(ReportDateTimeName)
	VALUES
		(@ReportDateTimeName)
		
	SELECT     
		ReportDateTimeID, 
		ReportDateTimeName
	FROM         
		ReportDateTime
	WHERE
		ReportDateTimeID = SCOPE_IDENTITY()
GO

GRANT EXEC ON spi_ReportDateTime TO PUBLIC

GO
