SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Referral_MessageCountSummary_Archive]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spi_Referral_MessageCountSummary_Archive]
GO



-- Updated w/tzCASE function 04.0700 [ttw]

CREATE PROCEDURE spi_Referral_MessageCountSummary_Archive
   @DayID	int, 	
   @MonthID	int,
   @YearID	int

AS

DECLARE
   
   @ReferralCount	int,
   @CurrentAgeRangeID	int,
   @CurrentAgeStart	int,
   @CurrentAgeEnd	int, 
   @DayLightStartDate   datetime,
   @DayLightEndDate     datetime,
   @strSelectLine	varchar(8000),
   @strSelectLine2	varchar(8000),
   @strTemp		varchar(2000)


   Exec spf_GetDayLightDates @YearID, @DayLightStartDate OUTPUT, @DayLightEndDate OUTPUT
/******************************************************************************
**		File: 
**		Name: spi_Referral_MessageCountSummary_Archive
**		Desc: insert proc to build message counts for billable report
**
**		This template can be customized:
**              
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**
**		Auth: jth
**		Date: 03/08
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**      11/12/2010	ccarroll  Updated Archive sproc to latest version
*******************************************************************************/

--Create the temp table
CREATE TABLE #_Temp_Referral_MessageCountSummary 
   (
   	[YearID] [int] NULL ,
   	[MonthID] [int] NULL  ,
   	[DayID] [int] NULL  ,
   	[OrganizationID] [int]  ,
   	[SourceCodeID] [int] NULL ,
	[TotalMessages] [smallint] DEFAULT(0) ,
	[TotalImports] [smallint] DEFAULT(0) 
   )

CREATE TABLE #_Temp_Referral_MessageCountSummarySelect
   (
	
	[OrganizationID][int] NULL, 
	[SourceCodeID] [int] NULL ,
	[MessageID][int] NULL, 
	[MessageTypeID] [int] NULL

   )
	
--Store TimeZone CASE string
exec spf_tzCase 'TimeZoneAbbreviation','CallDateTime', @DayLightStartDate, @DayLightEndDate, @strTemp OUTPUT

	--TRUNCATE TABLE #_Temp_Referral_AgeDemo
	TRUNCATE TABLE #_Temp_Referral_MessageCountSummary
      --Get the list of organizations
	set @strSelectLine = 'INSERT #_Temp_Referral_MessageCountSummary'
	set @strSelectLine = @strSelectLine + ' (YearID, MonthID, DayID, OrganizationID, SourceCodeID)'

	set @strSelectLine = @strSelectLine + ' SELECT DISTINCT DATEPART(yyyy, CallDateTime) AS YearID,'
	set @strSelectLine = @strSelectLine + ' DATEPART(m, CallDateTime) AS MonthID,'
	set @strSelectLine = @strSelectLine + ' DATEPART(d, CallDateTime) AS DayID,'
	set @strSelectLine = @strSelectLine + ' _ReferralProdArchive.dbo.Message.OrganizationID, ' 
	set @strSelectLine = @strSelectLine + ' _ReferralProdArchive.dbo.Call.SourceCodeID ' 

	set @strSelectLine = @strSelectLine + ' FROM _ReferralProdArchive.dbo.Message'
	set @strSelectLine = @strSelectLine + ' JOIN _ReferralProdArchive.dbo.Call ON _ReferralProdArchive.dbo.Call.CallID = _ReferralProdArchive.dbo.Message.CallID' 
	set @strSelectLine = @strSelectLine + ' JOIN _ReferralProdArchive.dbo.Organization ON _ReferralProdArchive.dbo.Message.OrganizationID = _ReferralProdArchive.dbo.Organization.OrganizationID'
	set @strSelectLine = @strSelectLine + '	JOIN _ReferralProdArchive.dbo.TimeZone ON _ReferralProdArchive.dbo.Organization.TimeZoneID = _ReferralProdArchive.dbo.TimeZone.TimeZoneID'
	-- ccarroll 07/29/2011 Added Join to TimeZone  
	
	set @strSelectLine2 = ' WHERE DATEPART(yyyy, CallDateTime) = '+ltrim(str(@YearID))
	set @strSelectLine2 = @strSelectLine2 + ' AND DATEPART(m, CallDateTime) = ' + ltrim(str(@MonthID))
	set @strSelectLine2 = @strSelectLine2 + ' AND DATEPART(d, CallDateTime) = ' + ltrim(str(@DayID))
	set @strSelectLine2 = @strSelectLine2 + ' ORDER BY _ReferralProdArchive.dbo.Message.OrganizationID, _ReferralProdArchive.dbo.Call.SourceCodeID '

	EXEC(@strSelectLine+@strSelectLine2)
--select @strSelectLine+@strSelectLine2



        --Build a TempTable
            --Clean #_Temp_Referral_MessageCountSummarySelect
               TRUNCATE TABLE #_Temp_Referral_MessageCountSummarySelect
            --Insert Data into #_Temp_Referral_MessageCountSummarySelect based on agerange, gender, month and year
		set @strSelectLine = 'INSERT #_Temp_Referral_MessageCountSummarySelect (OrganizationID,SourceCodeID,MessageID, MessageTypeID)'
		set @strSelectLine = @strSelectLine + ' SELECT _ReferralProdArchive.dbo.Message.OrganizationID,'
		set @strSelectLine = @strSelectLine + ' _ReferralProdArchive.dbo.Call.SourceCodeID, ' 
		set @strSelectLine = @strSelectLine + ' MessageID, MessageTypeID'
		set @strSelectLine = @strSelectLine + ' FROM _ReferralProdArchive.dbo.Message'
		set @strSelectLine = @strSelectLine + ' JOIN _ReferralProdArchive.dbo.Call ON _ReferralProdArchive.dbo.Call.CallID = _ReferralProdArchive.dbo.Message.CallID' 
		set @strSelectLine = @strSelectLine + ' JOIN _ReferralProdArchive.dbo.Organization ON _ReferralProdArchive.dbo.Message.OrganizationID = _ReferralProdArchive.dbo.Organization.OrganizationID'
		set @strSelectLine = @strSelectLine + '	JOIN _ReferralProdArchive.dbo.TimeZone ON _ReferralProdArchive.dbo.Organization.TimeZoneID = _ReferralProdArchive.dbo.TimeZone.TimeZoneID'
		-- ccarroll 07/29/2011 Added Join to TimeZone  

		set @strSelectLine2 = ' WHERE DATEPART(yyyy, CallDateTime) = '+ltrim(str(@YearID))
		set @strSelectLine2 = @strSelectLine2 + ' AND DATEPART(m, CallDateTime) = ' + ltrim(str(@MonthID))
		set @strSelectLine2 = @strSelectLine2 + ' AND DATEPART(d, CallDateTime) = ' + ltrim(str(@DayID))
		set @strSelectLine2 = @strSelectLine2 + ' ORDER BY _ReferralProdArchive.dbo.Message.OrganizationID, _ReferralProdArchive.dbo.Call.SourceCodeID '

	EXEC(@strSelectLine+@strSelectLine2)
--select @strSelectLine+@strSelectLine2
	
	-- update the count stats


--**************************************************************************************************************************************************************************************
	-- TotalMessages
--***************************************************************************************************************************************************************************************
            UPDATE   #_Temp_Referral_MessageCountSummary
	    SET      TotalMessages = CountTable.ReferralCount
	    FROM		
	    (
		SELECT 	OrganizationID, 
			SourceCodeID,
			Count(MessageID) AS  ReferralCount
		FROM 	#_Temp_Referral_MessageCountSummarySelect
		WHERE 	MessageTypeID <> 2 

		GROUP BY OrganizationID, SourceCodeID
	    
	   ) AS CountTable
	   WHERE	#_Temp_Referral_MessageCountSummary.OrganizationID = CountTable.OrganizationID
	   AND		#_Temp_Referral_MessageCountSummary.SourceCodeID  = CountTable.SourceCodeID
	   AND		YearID = @YearID
	   AND		MonthID = @MonthID
	   AND		DayID = @DayID
	
--**************************************************************************************************************************************************************************************
	-- TotalImports
--***************************************************************************************************************************************************************************************
            UPDATE   #_Temp_Referral_MessageCountSummary
	    SET      TotalImports = CountTable.ReferralCount
	    FROM		
	    (
		SELECT 	OrganizationID, 
			SourceCodeID,
			Count(MessageID) AS  ReferralCount
		FROM 	#_Temp_Referral_MessageCountSummarySelect
		WHERE 	MessageTypeID = 2 

		GROUP BY OrganizationID, SourceCodeID
	    
	   ) AS CountTable
	   WHERE	#_Temp_Referral_MessageCountSummary.OrganizationID = CountTable.OrganizationID
	   AND		#_Temp_Referral_MessageCountSummary.SourceCodeID  = CountTable.SourceCodeID
	   AND		YearID = @YearID
	   AND		MonthID = @MonthID
	   AND		DayID = @DayID
	   

--**************************************************************************************************************************************************************************************
	-- Transfer to table Referral_CallerPersonCount
--***************************************************************************************************************************************************************************************

	-- Delete any records for the given month and year
	DELETE 	Referral_MessageCountSummary
	WHERE 	YearID = @YearID
	AND	MonthID = @MonthID
	AND		DayID = @DayID

	--Update the count statistics
	INSERT INTO Referral_MessageCountSummary
	SELECT * FROM #_Temp_Referral_MessageCountSummary 
	ORDER BY YearID, MonthID, DayID, OrganizationID, SourceCodeID
        
	DROP TABLE #_Temp_Referral_MessageCountSummarySelect             
	DROP TABLE #_Temp_Referral_MessageCountSummary


return 0



















GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

