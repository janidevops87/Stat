SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[fn_StatFile_ConvertDateTime]') and xtype in (N'FN', N'IF', N'TF'))
drop function [dbo].[fn_StatFile_ConvertDateTime]
GO

CREATE FUNCTION fn_StatFile_ConvertDateTime(
		@vOrgID int,
		@vDateTime datetime
)

RETURNS datetime AS  

BEGIN 
DECLARE
		@vOrgTZ as varchar(20),
		@vOrgTZdiff as int


SELECT @vOrgTZ = TimeZone.TimeZoneAbbreviation 
		from Organization 
		join TimeZone ON Organization.TimeZoneID = TimeZone.TimeZoneID
		where OrganizationID = @vOrgID
		
SELECT @vOrgTZdiff = 
                    CASE @vOrgTZ
                    When 'AT' Then 3                    
                    When 'AS' Then 3                    
                    When 'ET' Then 2
                    When 'ES' Then 2
                    When 'CT' Then 1
                    When 'CS' Then 1
                    When 'MT' Then 0
                    When 'MS' Then 0
                    When 'PT' Then -1
                    When 'PS' Then -1
                    When 'KT' Then -2
                    When 'KS' Then -2
                    When 'HT' Then -3
                    When 'HS' Then -3
                    When 'ST' Then -4                                                              
                    When 'SS' Then -4                                                              
                    END

return DATEADD(hour, @vOrgTZdiff, @vDateTime)

END

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

