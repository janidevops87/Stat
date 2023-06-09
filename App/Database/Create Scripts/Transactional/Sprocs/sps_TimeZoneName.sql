SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_TimeZoneName]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_TimeZoneName]
GO





-- sps_TimeZoneName 'AT'
Create Procedure sps_TimeZoneName
     
     @TimeZone     varchar(2) = null

AS
	
	Declare @ZoneName varchar(20)	

               SELECT @ZoneName = CASE 
                       When @TimeZone = 'AT' or @ZoneName = 'AS' Then 'Atlantic Time'
                       When @TimeZone = 'ET' or @ZoneName = 'ES' Then 'Eastern Time'
		       When @TimeZone = 'CT' or @ZoneName = 'CS' Then 'Central Time'
/*
			When 'MT", "MS"
				ZoneName = "Mountain Time"
			When 'PT", "PS"
				ZoneName = "Pacific Time"
			When 'KT", "KS"
				ZoneName = "Alaska Time"							
			When 'HT", "HS"	
				ZoneName = "Hawaii Time"
			When 'ST", "SS"	
    			ZoneName = "Samoa Time"
*/			
		End 

   select @ZoneName


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

