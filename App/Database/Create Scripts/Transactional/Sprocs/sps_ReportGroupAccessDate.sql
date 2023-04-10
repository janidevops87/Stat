SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_ReportGroupAccessDate]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_ReportGroupAccessDate]
GO






/****** Object:  Stored Procedure dbo.sps_ReportGroupAccessDate    Script Date: 2/24/99 1:12:46 AM ******/
CREATE PROCEDURE sps_ReportGroupAccessDate

	@vReportGroupID	int		= null
AS

	SELECT	WebReportGroupAccessDateID, AccessStartDate, AccessEndDate
    	FROM 		WebReportGroupAccessDate 
    	WHERE 	WebReportGroupID = @vReportGroupID
    	ORDER BY 	AccessStartDate ASC





GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

