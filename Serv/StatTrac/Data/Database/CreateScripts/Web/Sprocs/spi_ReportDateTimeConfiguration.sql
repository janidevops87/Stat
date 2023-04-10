IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'spi_ReportDateTimeConfiguration')
	BEGIN
		PRINT 'Dropping Procedure spi_ReportDateTimeConfiguration'
		DROP  Procedure  spi_ReportDateTimeConfiguration
	END

GO

PRINT 'Creating Procedure spi_ReportDateTimeConfiguration'
GO
CREATE Procedure spi_ReportDateTimeConfiguration
	@ReportID	INT,
	@ReportDateTimeID INT,
	@IsArchived BIT = 0,
	@IsDateOnly BIT = 0
AS

/******************************************************************************
**		File: 
**		Name: spi_ReportDateTimeConfiguration
**		Desc: 
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
**		09/25/08	Bret Knoll			Add IsArchived to Reporting site, allowing for 
**										params page to notify users what they are querying
*******************************************************************************/
INSERT
	ReportDateTimeConfiguration 
	(
		ReportID  
		, ReportDateTimeID
		, IsArchived 
		, IsDateOnly
	)
VALUES
	(
		@ReportID	
		, @ReportDateTimeID 
		, @IsArchived
		, @IsDateOnly
	)

SELECT     
	ReportDateTimeConfigurationID, 
	ReportID, 
	ReportDateTimeID,
	IsArchived,
	IsDateOnly
FROM         
	ReportDateTimeConfiguration
WHERE     
	(ReportDateTimeConfigurationID = SCOPE_IDENTITY())



GO

GRANT EXEC ON spi_ReportDateTimeConfiguration TO PUBLIC

GO
