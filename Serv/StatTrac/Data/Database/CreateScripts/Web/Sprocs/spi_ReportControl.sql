if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_ReportControl]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spi_ReportControl]
print 'dropping procedure spi_ReportControl'
GO
print 'creating procedure spi_ReportControl'
SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
 CREATE PROCEDURE spi_ReportControl
	(@ReportControlID 		[int] OUTPUT,
	 @ReportControlName 	[varchar](50),
	 @ReportParamSectionID 	[int])

AS 

INSERT INTO 
	[ReportControl] 
	 ( 
	 [ReportControlName],
	 [ReportParamSectionID]) 
 
VALUES 
	(
	 @ReportControlName,
	 @ReportParamSectionID)
	 
SELECT @ReportControlID = SCOPE_IDENTITY()
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

