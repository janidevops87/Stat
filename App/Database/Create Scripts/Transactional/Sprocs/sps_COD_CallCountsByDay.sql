SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_COD_CallCountsByDay]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_COD_CallCountsByDay]
GO


CREATE PROCEDURE sps_COD_CallCountsByDay
	@vOrgID	int		=null,
	@vStartDate	datetime	= null,
	@vEndDate	datetime	= null
AS

SET NOCOUNT ON

IF @vOrgID = ''

	begin

	SELECT CONVERT(varchar(20),b.CallDateTime,1) AS CallDate, c.SourceCodeName, count(*) as CallCount
	FROM CODCaller a 
	JOIN Call b ON b.CallID = a.CallID
	JOIN SourceCode c ON c.SourceCodeID = b.SourceCodeID
	WHERE CallDateTime >= @vStartDate
	AND CallDateTime <= @vEndDate
	GROUP BY CONVERT(varchar(20),b.CallDateTime,1), c.SourceCodeName
	ORDER BY CONVERT(varchar(20),b.CallDateTime,1), c.SourceCodeName ASC

	end

ELSE
	begin

	SELECT CONVERT(varchar(20),b.CallDateTime,1) AS CallDate, c.SourceCodeName, count(*) as CallCount
	FROM CODCaller a 
	JOIN Call b ON b.CallID = a.CallID
	JOIN SourceCode c ON c.SourceCodeID = b.SourceCodeID
	WHERE CallDateTime >= @vStartDate
	AND CallDateTime <= @vEndDate
	AND a.OrganizationID = @vOrgID
	GROUP BY CONVERT(varchar(20),b.CallDateTime,1), c.SourceCodeName
	ORDER BY CONVERT(varchar(20),b.CallDateTime,1), c.SourceCodeName ASC

	end






GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

