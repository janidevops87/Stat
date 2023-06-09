SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Referral_FSTypeCount_Archive]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spi_Referral_FSTypeCount_Archive]
GO



CREATE PROCEDURE spi_Referral_FSTypeCount_Archive @YearID  INT,
                                          @MonthID INT AS
SET NOCOUNT ON

DECLARE @ReferralCount		int
DECLARE @DayLightStartDate   	datetime
DECLARE @DayLightEndDate     	datetime
DECLARE @sql1			varchar(8000)
DECLARE @sql2			varchar(8000)
DECLARE @sql3			varchar(8000)
DECLARE @strTemp		varchar(2000)
	
IF EXISTS (SELECT * FROM tempdb..sysobjects WHERE id = object_id('tempdb..#_Temp_FSReferral_TypeCount'))  DROP TABLE #_Temp_FSReferral_TypeCount
IF EXISTS (SELECT * FROM tempdb..sysobjects WHERE id = object_id('tempdb..#_Temp_FSReferral_TypeSelect')) DROP TABLE #_Temp_FSReferral_TypeSelect

EXEC spf_GetDayLightDates @YearID, @DayLightStartDate OUTPUT, @DayLightEndDate OUTPUT
EXEC spf_tzCase 'TimeZoneAbbreviation','CallDateTime', @DayLightStartDate, @DayLightEndDate, @strTemp OUTPUT

CREATE TABLE #_Temp_FSReferral_TypeCount (YearID         INT NOT NULL,
                                          MonthID        INT NOT NULL,
                                          OrganizationID INT NOT NULL,
                                          SourceCodeID   INT NULL,
                                          FST            INT NULL DEFAULT (0),
                                          fsSecondary    INT NULL DEFAULT (0), 
                                          fsApproach     INT NULL DEFAULT (0), 
                                          fsBillMedSoc   INT NULL DEFAULT (0))


	set @sql1 = 'INSERT INTO #_Temp_FSReferral_TypeCount(YearID, MonthID, OrganizationID, SourceCodeID)'

	set @sql1 = @sql1 + ' SELECT DISTINCT DATEPART(yyyy, DATEADD(hour, '+@strTemp+', c.CallDateTime)) AS YearID,'
	set @sql1 = @sql1 + ' DATEPART(m, DATEADD(hour, '+@strTemp+', c.CallDateTime)) AS MonthID,'
	set @sql1 = @sql1 + ' r.ReferralCallerOrganizationID,'
	set @sql1 = @sql1 + ' c.SourceCodeID'

	set @sql1 = @sql1 + ' FROM _ReferralProdArchive.dbo.Organization o'
	set @sql1 = @sql1 + ' JOIN _ReferralProdArchive.dbo.TimeZone ON _ReferralProdArchive.dbo.Organization.TimeZoneID = _ReferralProdArchive.dbo.TimeZone.TimeZoneID'
	-- ccarroll 08/01/2011 Added Join to TimeZone  
	
	set @sql1 = @sql1 + ' INNER JOIN _ReferralProdArchive.dbo.Referral r ON o.OrganizationID = r.ReferralCallerOrganizationID'
	set @sql1 = @sql1 + ' RIGHT OUTER JOIN _ReferralProdArchive.dbo.Call c'
	set @sql1 = @sql1 + ' RIGHT OUTER JOIN _ReferralProdArchive.dbo.FSCase fsc ON c.CallID = fsc.CallID ON r.CallID = fsc.CallID'

	set @sql2 = '	WHERE DATEPART(yyyy, DATEADD(hour, '+@strTemp+', c.CallDateTime)) = '+ltrim(str(@YearID))
	set @sql2 = @sql2 + ' AND DATEPART(m, DATEADD(hour, '+ @strTemp + ', c.CallDateTime)) = ' + ltrim(str(@MonthID))

	set @sql2 = @sql2 + ' ORDER BY r.ReferralCallerOrganizationID, c.SourceCodeID'

	EXEC(@sql1+@sql2)

CREATE TABLE #_Temp_FSReferral_TypeSelect(CallID                          INT,
                                          ReferralCallerOrganizationID    INT,
                                          SourceCodeID                    INT,
                                          ReferralTypeID                  INT,
                                          FSCaseBillSecondaryUserID       INT,
                                          FSCaseBillApproachUserID        INT,
                                          FSCaseBillMedSocUserID          INT,
                                          CallDateTime                    DATETIME)

	set @sql1 = ' INSERT #_Temp_FSReferral_TypeSelect(CallID,   ReferralCallerOrganizationID,   SourceCodeID,   ReferralTypeID,     FSCaseBillSecondaryUserID,     FSCaseBillApproachUserID,     FSCaseBillMedSocUserID,   CallDateTime)'
	set @sql2 = ' SELECT                          fsc.CallID, r.ReferralCallerOrganizationID, c.SourceCodeID, r.ReferralTypeID, fsc.FSCaseBillSecondaryUserID, fsc.FSCaseBillApproachUserID, fsc.FSCaseBillMedSocUserID, c.CallDateTime'

	--set @strSelectLine = @strSelectLine + '	FROM _ReferralProdArchive.dbo.Referral'
	--set @strSelectLine = @strSelectLine + '	JOIN _ReferralProdArchive.dbo.Call ON _ReferralProdArchive.dbo.Call.CallID = _ReferralProdArchive.dbo.Referral.CallID'
	--set @strSelectLine = @strSelectLine + '	JOIN _ReferralProdArchive.dbo.Organization ON _ReferralProdArchive.dbo.Referral.ReferralCallerOrganizationID = _ReferralProdArchive.dbo.Organization.OrganizationID'

	set @sql2 = @sql2 + '	FROM _ReferralProdArchive.dbo.M Call c'
	set @sql2 = @sql2 + '	RIGHT OUTER JOI_ReferralProdArchive.dbo.N FSCase fsc ON c.CallID = fsc.CallID'
	set @sql2 = @sql2 + '	LEFT OUTER JOI_ReferralProdArchive.dbo.N Secondary s ON fsc.CallID = s.CallID'
	set @sql2 = @sql2 + '	LEFT OUTER JOI_ReferralProdArchive.dbo.N Referral r'
	set @sql2 = @sql2 + '	INNER JOI_ReferralProdArchive.dbo.N Organization o ON r.ReferralCallerOrganizationID = o.OrganizationID ON fsc.CallID = r.CallID'
	set @sql1 = @sql1 + '   JOIN _ReferralProdArchive.dbo.TimeZone ON _ReferralProdArchive.dbo.Organization.TimeZoneID = _ReferralProdArchive.dbo.TimeZone.TimeZoneID'
	-- ccarroll 08/01/2011 Added Join to TimeZone  

	set @sql3 = ' WHERE DATEPART(yyyy, DATEADD(hour, '+@strTemp+', c.CallDateTime)) = '+ltrim(str(@YearID))
	set @sql3 = @sql3 + ' AND DATEPART(m, DATEADD(hour, '+ @strTemp + ', c.CallDateTime)) = ' + ltrim(str(@MonthID))

	set @sql3 = @sql3 + ' ORDER BY s.CallID'

	EXEC(@sql1+@sql2+@sql3)


UPDATE #_Temp_FSReferral_TypeCount
SET FST = ts.cnt
FROM (SELECT ReferralCallerOrganizationID, SourceCodeID, Count(CallID) AS cnt
      FROM #_Temp_FSReferral_TypeSelect
      GROUP BY ReferralCallerOrganizationID, SourceCodeID) ts
WHERE #_Temp_FSReferral_TypeCount.OrganizationID = ts.ReferralCallerOrganizationID
AND   #_Temp_FSReferral_TypeCount.SourceCodeID   = ts.SourceCodeID

UPDATE #_Temp_FSReferral_TypeCount
SET fsSecondary = ts.cnt
FROM (SELECT ReferralCallerOrganizationID, SourceCodeID, Count(CallID) AS cnt
      FROM #_Temp_FSReferral_TypeSelect
      WHERE FSCaseBillSecondaryUserID IS NOT NULL
      AND   FSCaseBillSecondaryUserID <> 0
      GROUP BY ReferralCallerOrganizationID, SourceCodeID) ts
WHERE #_Temp_FSReferral_TypeCount.OrganizationID = ts.ReferralCallerOrganizationID
AND   #_Temp_FSReferral_TypeCount.SourceCodeID   = ts.SourceCodeID

UPDATE #_Temp_FSReferral_TypeCount
SET fsApproach = ts.cnt
FROM (SELECT ReferralCallerOrganizationID, SourceCodeID, Count(CallID) AS cnt
      FROM #_Temp_FSReferral_TypeSelect
      WHERE FSCaseBillApproachUserID IS NOT NULL
      AND   FSCaseBillApproachUserID <> 0
      GROUP BY ReferralCallerOrganizationID, SourceCodeID) ts
WHERE #_Temp_FSReferral_TypeCount.OrganizationID = ts.ReferralCallerOrganizationID
AND   #_Temp_FSReferral_TypeCount.SourceCodeID   = ts.SourceCodeID

UPDATE #_Temp_FSReferral_TypeCount
SET fsBillMedSoc = ts.cnt
FROM (SELECT ReferralCallerOrganizationID, SourceCodeID, Count(CallID) AS cnt
      FROM #_Temp_FSReferral_TypeSelect
      WHERE FSCaseBillMedSocUserID IS NOT NULL
      AND   FSCaseBillMedSocUserID <> 0
      GROUP BY ReferralCallerOrganizationID, SourceCodeID) ts
WHERE #_Temp_FSReferral_TypeCount.OrganizationID = ts.ReferralCallerOrganizationID
AND   #_Temp_FSReferral_TypeCount.SourceCodeID   = ts.SourceCodeID

select * from #_Temp_FSReferral_TypeCount
select * from #_Temp_FSReferral_TypeSelect

DELETE 	FSReferral_TypeCount                                                                       -- Delete any records for the given month and year
WHERE 	MonthID = @MonthID
AND	YearID = @YearID

INSERT INTO Referral_FSTypeCount                                                                   --Update the count statistics
SELECT * FROM #_Temp_FSReferral_TypeCount 
ORDER BY YearID, MonthID, OrganizationID

DROP TABLE #_Temp_FSReferral_TypeCount
DROP TABLE #_Temp_FSReferral_TypeSelect

















GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

