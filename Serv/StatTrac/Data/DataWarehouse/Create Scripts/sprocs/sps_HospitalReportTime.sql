SET QUOTED_IDENTIFIER OFF;
GO
SET ANSI_NULLS ON;
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[sps_HospitalReportTime]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[sps_HospitalReportTime];
GO


CREATE PROCEDURE sps_HospitalReportTime

	@vStartMonth		INT, 
	@vStartYear			INT, 
	@vEndMonth			INT, 
	@vEndYear			INT, 
	@vReportGroupID		INT,	
	@vOrganizationID	INT = NULL

AS

/******************************************************************************
**		File: sps_HospitalReportTime.sql
**		Name: sps_HospitalReportTime
**		Desc: returns HospitalReportTimeCount totals grouped by OrganizationID, 
**					YearID, MonthID, and TimeRangeID
** 
**		Called by:   HospitalReportTime.rdl
**              
**		Parameters:
**		Input							Output
**     ----------						-----------
**		See above
**
**		Auth: Mike Berenson 
**		Date: 09/24/2020
**
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:				Description:
**		--------		--------			-------------------------------------------
**		09/24/2020		Mike Berenson		Initial creation
**		01/28/2021		Mike Berenson		Added OrgnizationID to select output
**		01/29/2021		James Gerberich		Added TimeRangeID to output
*******************************************************************************/
BEGIN

	DROP TABLE IF EXISTS #FilteredIDs;

	-- Load #FilteredIDs				
	SELECT 		
		hrtc.OrganizationID,
		hrtc.YearID,
		hrtc.MonthID,
		hrtc.TimeRangeID
	INTO #FilteredIDs
	FROM 		
		Referral_HospitalReportTimeCount hrtc
		JOIN _ReferralProdReport.dbo.SourceCode sc ON sc.SourceCodeID = hrtc.SourceCodeID
		JOIN _ReferralProdReport.dbo.WebReportGroupSourceCode wrgsc ON wrgsc.SourceCodeID = sc.SourceCodeID
		JOIN _ReferralProdReport.dbo.WebReportGroupOrg wrgo ON wrgo.OrganizationID = hrtc.OrganizationID
	WHERE
		wrgsc.WebReportGroupID = @vReportGroupID
		AND	wrgo.WebReportGroupID = @vReportGroupID
		AND (hrtc.YearID > @vStartYear OR (hrtc.YearID = @vStartYear AND hrtc.MonthID >= @vStartMonth))
		AND (hrtc.YearID < @vEndYear OR (hrtc.YearID = @vEndYear AND hrtc.MonthID <= @vEndMonth))
		AND (@vOrganizationID IS NULL OR hrtc.OrganizationID = @vOrganizationID);

	-- Select totals grouped by organization and year, month, time range
	SELECT 		
		o.OrganizationID,
		o.OrganizationName, 
		fids.YearID,      
		fids.MonthID,
		hrtr.HospitalReportTimeRangeID AS TimeRangeID,
		hrtr.TimeRangeName,
		SUM(hrtc.AllTypes) AS AllTypes,
		SUM(hrtc.AppropriateOrgan) AS AppropriateOrgan, 
		SUM(hrtc.AppropriateAllTissue) AS AppropriateAllTissue,
		SUM(hrtc.AppropriateEyes) AS AppropriateEyes,  
		SUM(hrtc.AppropriateRO) AS AppropriateRO
	FROM 		
		#FilteredIDs fids
		JOIN Referral_HospitalReportTimeCount hrtc	ON hrtc.OrganizationID = fids.OrganizationID 
														AND hrtc.YearID = fids.YearID 
														AND hrtc.MonthID = fids.MonthID 
														AND hrtc.TimeRangeID = fids.TimeRangeID
		JOIN HospitalReportTimeRange hrtr			ON hrtr.HospitalReportTimeRangeID = fids.TimeRangeID 
    	JOIN _ReferralProdReport.dbo.Organization o ON o.OrganizationID = fids.OrganizationID
	GROUP BY	
		o.OrganizationID,
		o.OrganizationName,
		fids.YearID,
		fids.MonthID,
		hrtr.HospitalReportTimeRangeID,
		hrtr.TimeRangeName
	ORDER BY 
		o.OrganizationName,
		fids.YearID, 
		fids.MonthID,
		hrtr.TimeRangeName;

	DROP TABLE IF EXISTS #FilteredIDs;

END
GO

SET QUOTED_IDENTIFIER OFF;
GO
SET ANSI_NULLS ON;
GO