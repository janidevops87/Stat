SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SPS_ReportGroupSourceCodeList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SPS_ReportGroupSourceCodeList]
GO


CREATE PROCEDURE SPS_ReportGroupSourceCodeList 
AS
SELECT WebReportGroupID, WebReportGroupSourceCode.SourceCodeID, SourceCodeName 
FROM WebReportGroupSourceCode
JOIN SourceCode ON SourceCode.SourceCodeID = WebReportGroupSourceCode.SourceCodeID
ORDER BY WebReportGroupID


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

