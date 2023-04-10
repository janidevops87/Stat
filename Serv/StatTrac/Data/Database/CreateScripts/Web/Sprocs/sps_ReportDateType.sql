if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_ReportDateType]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_ReportDateType]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

 CREATE PROCEDURE sps_ReportDateType
	@ReportID INT = NULL
 AS 


 SELECT 
	rdtc.ReportID,
	rdt.ReportDateTypeName ,
	rdt.ReportDateTypeDisplayname ,
	rdtc.ReportDateTypeConfigurationIsDefault
FROM	
	ReportDateTypeConfiguration rdtc
JOIN
	ReportDateType rdt ON rdt.ReportDateTypeID = rdtc.ReportDateTypeID
WHERE
	rdtc.Reportid = ISNULL(@ReportID, 0)
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

	