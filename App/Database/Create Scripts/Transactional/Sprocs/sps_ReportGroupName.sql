SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_ReportGroupName]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_ReportGroupName]
GO






/****** Object:  Stored Procedure dbo.sps_ReportGroupName    Script Date: 2/24/99 1:12:46 AM ******/
CREATE PROCEDURE sps_ReportGroupName

	@vReportGroupID	int		= null

AS

SELECT	WebReportGroupName
FROM		WebReportGroup
WHERE 	WebReportGroupID = @vReportGroupID





GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

