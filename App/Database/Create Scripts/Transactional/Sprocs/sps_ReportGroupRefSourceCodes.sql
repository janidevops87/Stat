SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_ReportGroupRefSourceCodes]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_ReportGroupRefSourceCodes]
GO






/****** Object:  Stored Procedure dbo.sps_ReportGroupRefSourceCodes    Script Date: 2/24/99 1:12:46 AM ******/
CREATE PROCEDURE sps_ReportGroupRefSourceCodes

	@vReportGroupID	int		= null

AS

	SELECT	SourceCode.SourceCodeID, SourceCodeName
	FROM		SourceCode
	JOIN		WebReportGroupSourceCode ON WebReportGroupSourceCode.SourceCodeID = SourceCode.SourceCodeID
	WHERE	WebReportGroupID = @vReportGroupID
	AND		SourceCodeType = 1
	ORDER BY	 SourceCode.SourceCodeID





GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

