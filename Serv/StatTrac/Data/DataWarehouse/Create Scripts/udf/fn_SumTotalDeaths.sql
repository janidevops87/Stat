SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[fn_SumTotalDeaths]') and xtype in (N'FN', N'IF', N'TF'))
drop function [dbo].[fn_SumTotalDeaths]
GO

CREATE FUNCTION [dbo].[fn_SumTotalDeaths] (@OrgID int, @vStartDate datetime, @vEndDate datetime)  
RETURNS Integer
AS

BEGIN 

-- Function takes an OrganizationId and start and end dates and gives a sum of Total Deaths for those months
-- (Used by sps_ReferralCompliance  11/5/04 - SAP)

DECLARE @vSum int, @firstMonth int, @lastMonth Int, @firstYear int, @lastYear int

SET @vSum = 0
SET @firstMonth = Month(@vStartDate)
SET @firstYear = Year(@vStartDate)
SET @lastMonth = Month(@vEndDate)
SET @lastYear = Year(@vEndDate)

WHILE @firstYear <= @lastYear AND @firstMonth <= @lastMonth
     BEGIN

	SET @vSum = @vSum + (SELECT IsNull(Max(TotalDeaths),0) FROM OrganizationDeaths WHERE OrganizationId = @OrgId AND YearId = @firstYear AND MonthId = @firstMonth)


	SET @firstMonth = @firstMonth + 1
	IF @firstMonth = 13
	     BEGIN
		SET @firstMonth = 1
		SET @firstYear = @firstYear + 1
	     END

     END

     RETURN @vSum
END








GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

