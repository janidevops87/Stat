if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_ReportParamConfiguration]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop procedure [dbo].[spi_ReportParamConfiguration]
	print 'dropping procedure spi_ReportParamConfiguration'
GO
print 'creating procedure spi_ReportParamConfiguration'
SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE spi_ReportParamConfiguration
(
	@ReportID			[int],
	@ReportControlID	[int])

AS 

INSERT INTO 
	[ReportParamConfiguration] 
	 (
		[ReportID],
		[ReportControlID]) 
 
VALUES 
	( 
	 @ReportID,
	 @ReportControlID
	 )
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

