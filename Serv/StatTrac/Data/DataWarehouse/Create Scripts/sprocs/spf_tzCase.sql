SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spf_tzCase]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spf_tzCase]
GO



-- spf_tzCase 'OrganizationTimeZone','CallDateTime', '4/7/00', '4/6/00', ''@strTemp
-- spf_tzCase 'OrganizationTimeZone','CallDateTime', @DayLightStartDate, @DayLightEndDate, @strTemp
-- sp_Help 
CREATE PROCEDURE spf_tzCase
	@varOrganizationTimeZone 	varchar(50),
	@varCallDateTime		varchar(50),
	@DayLightStartDate      	datetime,
        @DayLightEndDate        	datetime,
	@strCase			varchar(2000) OUTPUT

AS

DECLARE
	@chrSingleQuote		varchar(1),
	@strTemp1		varchar(32),
	@strTemp2		varchar(32)

set @strTemp1	=	@DayLightStartDate
set @strTemp2	=	@DayLightEndDate

set @chrSingleQuote = CHAR(39)
set @strCase = '(CASE When '+@varOrganizationTimeZone+' = '+@chrSingleQuote+'AT'+@chrSingleQuote+' Then 3'
set @strCase = @strCase +' When '+@varOrganizationTimeZone+' = '+@chrSingleQuote+'ET'+@chrSingleQuote+' Then 2'
set @strCase = @strCase +' When '+@varOrganizationTimeZone+' = '+@chrSingleQuote+'CT'+@chrSingleQuote+' Then 1'
set @strCase = @strCase +' When '+@varOrganizationTimeZone+' = '+@chrSingleQuote+'MT'+@chrSingleQuote+' Then 0'
set @strCase = @strCase +' When '+@varOrganizationTimeZone+' = '+@chrSingleQuote+'PT'+@chrSingleQuote+' Then -1'
set @strCase = @strCase +' When '+@varOrganizationTimeZone+' = '+@chrSingleQuote+'KT'+@chrSingleQuote+' Then -2'
set @strCase = @strCase +' When '+@varOrganizationTimeZone+' = '+@chrSingleQuote+'HT'+@chrSingleQuote+' Then -3'
set @strCase = @strCase +' When '+@varOrganizationTimeZone+' = '+@chrSingleQuote+'ST'+@chrSingleQuote+' Then -4'
set @strCase = @strCase +' When '+@varOrganizationTimeZone+' = '+@chrSingleQuote+'AS'+@chrSingleQuote+' Then (case when '+@varCallDateTime+' between '+@chrSingleQuote+@strTemp1+@chrSingleQuote+' and '+@chrSingleQuote+@strTemp2+@chrSingleQuote+' Then 2 Else 3 End)'
set @strCase = @strCase +' When '+@varOrganizationTimeZone+' = '+@chrSingleQuote+'ES'+@chrSingleQuote+' Then (case when '+@varCallDateTime+' between '+@chrSingleQuote+@strTemp1+@chrSingleQuote+' and '+@chrSingleQuote+@strTemp2+@chrSingleQuote+' Then 1 Else 2 End)'
set @strCase = @strCase +' When '+@varOrganizationTimeZone+' = '+@chrSingleQuote+'CS'+@chrSingleQuote+' Then (case when '+@varCallDateTime+' between '+@chrSingleQuote+@strTemp1+@chrSingleQuote+' and '+@chrSingleQuote+@strTemp2+@chrSingleQuote+' Then 0 Else 1 End)'
set @strCase = @strCase +' When '+@varOrganizationTimeZone+' = '+@chrSingleQuote+'MS'+@chrSingleQuote+' Then (case when '+@varCallDateTime+' between '+@chrSingleQuote+@strTemp1+@chrSingleQuote+' and '+@chrSingleQuote+@strTemp2+@chrSingleQuote+' Then -1 Else 0 End)'
set @strCase = @strCase +' When '+@varOrganizationTimeZone+' = '+@chrSingleQuote+'PS'+@chrSingleQuote+' Then (case when '+@varCallDateTime+' between '+@chrSingleQuote+@strTemp1+@chrSingleQuote+' and '+@chrSingleQuote+@strTemp2+@chrSingleQuote+' Then -2 Else -1 End)'
set @strCase = @strCase +' When '+@varOrganizationTimeZone+' = '+@chrSingleQuote+'KS'+@chrSingleQuote+' Then (case when '+@varCallDateTime+' between '+@chrSingleQuote+@strTemp1+@chrSingleQuote+' and '+@chrSingleQuote+@strTemp2+@chrSingleQuote+' Then -3 Else -2 End)'
set @strCase = @strCase +' When '+@varOrganizationTimeZone+' = '+@chrSingleQuote+'HS'+@chrSingleQuote+' Then (case when '+@varCallDateTime+' between '+@chrSingleQuote+@strTemp1+@chrSingleQuote+' and '+@chrSingleQuote+@strTemp2+@chrSingleQuote+' Then -4 Else -3 End)'
set @strCase = @strCase +' When '+@varOrganizationTimeZone+' = '+@chrSingleQuote+'SS'+@chrSingleQuote+' Then (case when '+@varCallDateTime+' between '+@chrSingleQuote+@strTemp1+@chrSingleQuote+' and '+@chrSingleQuote+@strTemp2+@chrSingleQuote+' Then -5 Else -4 End)'
set @strCase = @strCase +' END )'

-- select LEN(@strCase), @strCase




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

