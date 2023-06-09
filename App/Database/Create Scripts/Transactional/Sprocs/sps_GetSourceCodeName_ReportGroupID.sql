SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_GetSourceCodeName_ReportGroupID]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_GetSourceCodeName_ReportGroupID]
GO


CREATE PROCEDURE sps_GetSourceCodeName_ReportGroupID
	@WebReportGroupID INT =NULL

AS
	SELECT	DISTINCT SC.SourceCodeName 
	FROM 	SourceCode SC, WebReportGroupSourceCode WSC

	WHERE 	WSC.SourceCodeID = SC.SourceCodeID
	AND	WSC.WebReportGroupID = @WebReportGroupID


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

