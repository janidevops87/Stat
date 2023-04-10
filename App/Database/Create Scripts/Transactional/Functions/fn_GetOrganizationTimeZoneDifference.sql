  IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[fn_GetOrganizationTimeZoneDifference]') AND xtype in (N'FN', N'IF', N'TF'))
	BEGIN
		PRINT 'Dropping Function fn_GetOrganizationTimeZoneDifference'
		DROP Function fn_GetOrganizationTimeZoneDifference
	END
GO

PRINT 'Creating Function fn_GetOrganizationTimeZoneDifference' 
GO

CREATE FUNCTION dbo.fn_GetOrganizationTimeZoneDifference
	(
		@vOrgTZ VARCHAR(2)
	)
RETURNS int
AS
	BEGIN
		DECLARE @OrgTZDif INT
		
		SELECT @OrgTZDif =	CASE @vOrgTZ
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

	RETURN @OrgTZDif
	END

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

