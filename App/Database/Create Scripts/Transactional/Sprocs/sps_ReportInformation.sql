SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_ReportInformation]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_ReportInformation]
GO


CREATE PROCEDURE sps_ReportInformation

	@ReportID		int

 AS

SELECT ReportDisplayName, 
	ReportVirtualURL 
FROM Report
WHERE ReportID = @ReportID


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

