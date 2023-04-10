if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_SourceCodeNameList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_SourceCodeNameList]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

 
Create PROCEDURE sps_SourceCodeNameList
	@WebReportGroupID int = null,
	@SourceCodeTypeID int = null

AS
if (@WebReportGroupID = 0 ) SET @WebReportGroupID = NULL 

SELECT DISTINCT 
	SC.SourceCodeID,
	SC.SourceCodeName 
FROM 
	WebReportGroupSourceCode WRGSC
JOIN
	SourceCode SC ON SC.SourceCodeID = WRGSC.SourceCodeID
WHERE 
	WRGSC.WebReportGroupID = ISNULL(@WebReportGroupID, WRGSC.WebReportGroupID)
AND
	SC.SourceCodeType = ISNULL(@SourceCodeTypeID, SC.SourceCodeType)	
ORDER BY 
	SourceCodeName ASC

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

