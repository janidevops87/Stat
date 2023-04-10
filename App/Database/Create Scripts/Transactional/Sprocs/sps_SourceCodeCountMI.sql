SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_SourceCodeCountMI]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_SourceCodeCountMI]
GO






/****** Object:  Stored Procedure dbo.sps_SourceCodeCountMI    Script Date: 2/24/99 1:12:46 AM ******/
CREATE PROCEDURE sps_SourceCodeCountMI AS

	SELECT DISTINCT SourceCodeName 
	INTO 		#TempCount
	FROM 		SourceCode 
	WHERE 		SourceCodeType = 2 OR SourceCodeType = 4
	SELECT Count(SourceCodeName) AS CodeCount
	FROM #TempCount




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

