if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_ReportParameterConfiguration]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_ReportParameterConfiguration]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE sps_ReportParameterConfiguration
	@ReportID INT = NULL
 AS 
 

SELECT DISTINCT
	c.ReportID,
	rc.ReportControlName, 
	rs.ReportParamSectionName
FROM 
	ReportParamConfiguration c
JOIN 
	ReportControl rc ON rc.ReportControlID = c.ReportControlID
JOIN
	ReportParamSection rs ON rs.ReportParamSectionID = rc.ReportParamSectionID
WHERE 
	c.ReportID = ISNULL(@ReportID, 0)
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

	