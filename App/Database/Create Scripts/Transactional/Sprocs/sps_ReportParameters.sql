SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_ReportParameters]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_ReportParameters]
GO



CREATE PROCEDURE sps_ReportParameters

	@ReportTypeID		int

 AS

SELECT	ReportID,
		ReportDisplayName,
      		ReportFromDate,
       		ReportToDate,
       		ReportGroup,
       		ReportOrganization

FROM   	Report
WHERE  	ReportTypeID = @ReportTypeID

ORDER BY 	ReportID


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

