SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_SourceCodeList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_SourceCodeList]
GO



CREATE PROCEDURE sps_SourceCodeList
	--added to fix on website
	@variable1 varchar(10) = null

AS

SELECT DISTINCT SourceCodeID, SourceCodeName 
FROM SourceCode 
WHERE SourceCodeName <> ''
AND   SourceCodeType = ISNULL(@variable1,SourceCodeType)
ORDER BY SourceCodeName ASC







GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

