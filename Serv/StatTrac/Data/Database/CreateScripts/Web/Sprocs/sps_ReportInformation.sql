if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_ReportInformation]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_ReportInformation]
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


CREATE PROCEDURE sps_ReportInformation

	@ReportID		int = NULL

 AS

SELECT 
	ReportID,
	ReportDisplayName, 
	ReportVirtualURL 
FROM 
	Report
WHERE 
	ReportID = ISNULL(@ReportID, 0)


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

