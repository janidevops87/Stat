SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Referral_ApproachCount]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spi_Referral_ApproachCount]
GO


CREATE PROCEDURE spi_Referral_ApproachCount

	@MonthID		int,
	@YearID			int

AS
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
/******************************************************************************
**		File: spi_Referral_ApproachCount.sql
**		Name: spi_Referral_ApproachCount
**		Desc: 
**              
**		Return values:
** 
**		Called by: DataWarehouse  
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		See Above
**
**		Auth: ccarroll  
**		Date: 08/01/2011
**
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------		-------------------------------------------
**      08/01/2010	ccarroll		Updated from Production
*******************************************************************************/

/*Updated w/tzCASE function 04.0700 [ttw]
  Updated to include use of RegistryStatus table for ver. 7.7.1.  10/13/2004 - SAP
  ccarroll 10/16/2006 - added case statements to prevent counts on referrals where service level
                        does not permit counting. StatTrac 8.0 Iteration2 release. 

spi_Referral_ApproachCount 3, 2000 */


DECLARE
	
	@ReferralCount		int,
        @DayLightStartDate      datetime,
        @DayLightEndDate        datetime,

	@strSelectLine		varchar(8000),
	@strSelectLine2		varchar(8000),
	@strTemp		varchar(2000)
	

        Exec spf_GetDayLightDates @YearID, @DayLightStartDate OUTPUT, @DayLightEndDate OUTPUT

	--Create the temp table
	CREATE TABLE #_Temp_Referral_ApproachCount
	(
	[YearID] [int] NOT NULL ,
	[MonthID] [int] NOT NULL ,
	[SourceCodeID] [int] NOT NULL ,
	[OrganizationID] [int] NOT NULL ,
	[PreRefFamilyApproach] [int] NULL DEFAULT (0),
	[PreRefFacilityApproach] [int] NULL DEFAULT (0),
	[PostRefApproach] [int] NULL DEFAULT (0),
	[NotApproached] [int] NULL DEFAULT (0),
	[UnknownApproach] [int] NULL DEFAULT (0),
	[RegistryApproach] [int] NULL DEFAULT (0),
	[O_PreRef_Approached_DR] [int] NULL DEFAULT (0),
	[O_PreRef_Approached_NonDR] [int] NULL DEFAULT (0),
	[O_PreRef_Consented_Family] [int] NULL DEFAULT (0),
	[O_PreRef_Consented_DR] [int] NULL DEFAULT (0),
	[O_PreRef_Consented_NonDR] [int] NULL DEFAULT (0),
	[O_PostRef_Approached_DR] [int] NULL DEFAULT (0),
	[O_PostRef_Approached_NonDR] [int] NULL DEFAULT (0),
	[O_PostRef_Consented_DR] [int] NULL DEFAULT (0),
	[O_PostRef_Consented_NonDR] [int] NULL DEFAULT (0),
	[T_PreRef_Approached_DR] [int] NULL DEFAULT (0),
	[T_PreRef_Approached_NonDR] [int] NULL DEFAULT (0),
	[T_PreRef_Consented_Family] [int] NULL DEFAULT (0),
	[T_PreRef_Consented_DR] [int] NULL DEFAULT (0),
	[T_PreRef_Consented_NonDR] [int] NULL DEFAULT (0),
	[T_PostRef_Approached_DR] [int] NULL DEFAULT (0),
	[T_PostRef_Approached_NonDR] [int] NULL DEFAULT (0),
	[T_PostRef_Consented_DR] [int] NULL DEFAULT (0),
	[T_PostRef_Consented_NonDR] [int] NULL DEFAULT (0),
	[E_PreRef_Approached_DR] [int] NULL DEFAULT (0),
	[E_PreRef_Approached_NonDR] [int] NULL DEFAULT (0),
	[E_PreRef_Consented_Family] [int] NULL DEFAULT (0),
	[E_PreRef_Consented_DR] [int] NULL DEFAULT (0),
	[E_PreRef_Consented_NonDR] [int] NULL DEFAULT (0),
	[E_PostRef_Approached_DR] [int] NULL DEFAULT (0),
	[E_PostRef_Approached_NonDR] [int] NULL DEFAULT (0),
	[E_PostRef_Consented_DR] [int] NULL DEFAULT (0),
	[E_PostRef_Consented_NonDR] [int] NULL DEFAULT (0),
	[A_PreRef_Approached_DR] [int] NULL DEFAULT (0),
	[A_PreRef_Approached_NonDR] [int] NULL DEFAULT (0),
	[A_PreRef_Consented_Family] [int] NULL DEFAULT (0),
	[A_PreRef_Consented_DR] [int] NULL DEFAULT (0),
	[A_PreRef_Consented_NonDR] [int] NULL DEFAULT (0),
	[A_PostRef_Approached_DR] [int] NULL DEFAULT (0),
	[A_PostRef_Approached_NonDR] [int] NULL DEFAULT (0),
	[A_PostRef_Consented_DR] [int] NULL DEFAULT (0),
	[A_PostRef_Consented_NonDR] [int] NULL DEFAULT (0),

	--drh 2/18/02
	[O_Registry_Approached] [int] NULL DEFAULT (0),
	[O_Registry_Consented] [int] NULL DEFAULT (0),
	[T_Registry_Approached] [int] NULL DEFAULT (0),
	[T_Registry_Consented] [int] NULL DEFAULT (0),
	[E_Registry_Approached] [int] NULL DEFAULT (0),
	[E_Registry_Consented] [int] NULL DEFAULT (0),
	[A_Registry_Approached] [int] NULL DEFAULT (0),
	[A_Registry_Consented] [int] NULL DEFAULT (0),

	[O_FamilyInitiated_Approached_DR] [int] NULL DEFAULT (0),
	[O_FamilyInitiated_Approached_NonDR] [int] NULL DEFAULT (0),
	[T_FamilyInitiated_Approached_DR] [int] NULL DEFAULT (0),
	[T_FamilyInitiated_Approached_NonDR] [int] NULL DEFAULT (0),
	[E_FamilyInitiated_Approached_DR] [int] NULL DEFAULT (0),
	[E_FamilyInitiated_Approached_NonDR] [int] NULL DEFAULT (0),
	[A_FamilyInitiated_Approached_DR] [int] NULL DEFAULT (0),
	[A_FamilyInitiated_Approached_NonDR] [int] NULL DEFAULT (0)
	)

	--Create the temp table
	CREATE TABLE #_Temp_Referral_ApproachSelect
	(
   	     [CallSourceCodeID] [int] NULL , 
             [ReferralCallerOrganizationID][int] NULL, 
             [ReferralApproachTypeID][int] NULL,  

             [ReferralOrganApproachID][int] NULL,
             [ReferralBoneApproachID][int] NULL,
             [ReferralTissueApproachID][int] NULL,
             [ReferralSkinApproachID][int] NULL,
             [ReferralValvesApproachID][int] NULL,
             [ReferralEyesTransApproachID][int] NULL,
             [ReferralEyesRschApproachID][int] NULL,

             [ReferralOrganConsentID][int] NULL,
             [ReferralBoneConsentID][int] NULL,
             [ReferralTissueConsentID][int] NULL,
             [ReferralSkinConsentID][int] NULL,
             [ReferralValvesConsentID][int] NULL,
             [ReferralEyesTransConsentID][int] NULL,
             [ReferralEyesRschConsentID][int] NULL,

             [ReferralGeneralConsent][int] NULL,

             [ReferralApproachedByPersonID][int] NULL,
             -- 9/17/04 - SAP
             [RegistryStatus][int] NULL
        )

	--Clean temp table
	TRUNCATE TABLE  #_Temp_Referral_ApproachCount
	TRUNCATE TABLE  #_Temp_Referral_ApproachSelect

	--Store TimeZone CASE string
	exec spf_tzCase 'TimeZoneAbbreviation','CallDateTime', @DayLightStartDate, @DayLightEndDate, @strTemp OUTPUT

	--Loop through list of organizations
	set @strSelectLine = 'INSERT INTO #_Temp_Referral_ApproachCount (YearID, MonthID, SourceCodeID, OrganizationID)'
	set @strSelectLine = @strSelectLine + ' SELECT DISTINCT DATEPART(yyyy, DATEADD(hour, '+@strTemp+', CallDateTime)) AS YearID,'
	set @strSelectLine = @strSelectLine + ' DATEPART(m, DATEADD(hour, '+@strTemp+', CallDateTime)) AS MonthID,'
	set @strSelectLine = @strSelectLine + ' _ReferralProdReport.dbo.Call.SourceCodeID,'	
	set @strSelectLine = @strSelectLine + ' ReferralCallerOrganizationID'

	set @strSelectLine = @strSelectLine + '	FROM _ReferralProdReport.dbo.Call JOIN _ReferralProdReport.dbo.Referral'
	set @strSelectLine = @strSelectLine + ' ON _ReferralProdReport.dbo.Referral.CallID = _ReferralProdReport.dbo.Call.CallID'
	set @strSelectLine = @strSelectLine + '	JOIN _ReferralProdReport.dbo.SourceCode ON _ReferralProdReport.dbo.Call.SourceCodeID = _ReferralProdReport.dbo.SourceCode.SourceCodeID'
	set @strSelectLine = @strSelectLine + '	JOIN _ReferralProdReport.dbo.Organization ON _ReferralProdReport.dbo.Referral.ReferralCallerOrganizationID = _ReferralProdReport.dbo.Organization.OrganizationID'
	set @strSelectLine = @strSelectLine + '	JOIN _ReferralProdReport.dbo.TimeZone ON _ReferralProdReport.dbo.Organization.TimeZoneID = _ReferralProdReport.dbo.TimeZone.TimeZoneID'

	set @strSelectLine2 = '	WHERE DATEPART(yyyy, DATEADD(hour, '+@strTemp+', CallDateTime)) = '+ltrim(str(@YearID))
	set @strSelectLine2 = @strSelectLine2 + ' AND DATEPART(m, DATEADD(hour, '+ @strTemp + ', CallDateTime)) = ' + ltrim(str(@MonthID))
	set @strSelectLine2 = @strSelectLine2 + ' ORDER BY _ReferralProdReport.dbo.Call.SourceCodeID, ReferralCallerOrganizationID'

	EXEC(@strSelectLine+@strSelectLine2)

        --

	set @strSelectLine = 'INSERT INTO #_Temp_Referral_ApproachSelect ( CallSourceCodeID, ReferralCallerOrganizationID,'
	set @strSelectLine = @strSelectLine + 'ReferralApproachTypeID, ReferralOrganApproachID, ReferralBoneApproachID, ReferralTissueApproachID, ReferralSkinApproachID, ReferralValvesApproachID, ReferralEyesTransApproachID, ReferralEyesRschApproachID,'
	set @strSelectLine = @strSelectLine + ' ReferralOrganConsentID, ReferralBoneConsentID, ReferralTissueConsentID, ReferralSkinConsentID,'
	set @strSelectLine = @strSelectLine + ' ReferralValvesConsentID, ReferralEyesTransConsentID, ReferralEyesRschConsentID, ReferralGeneralConsent, ReferralApproachedByPersonID, RegistryStatus)'

	set @strSelectLine = @strSelectLine + ' SELECT _ReferralProdReport.dbo.Call.SourceCodeID, ReferralCallerOrganizationID,'
	set @strSelectLine = @strSelectLine + ' ReferralApproachTypeID,'
	--  ccarroll 10/16/2006 - added case statements to prevent counts on referrals where service level
        --                        does not permit counting. StatTrac 8.0 Iteration2 release. 
 	set @strSelectLine = @strSelectLine + ' CASE WHEN ServiceLevelApproachOrgan = -1 THEN ReferralOrganApproachID ELSE 0 END AS ReferralOrganApproachID, '
	set @strSelectLine = @strSelectLine + ' CASE WHEN ServiceLevelApproachBone = -1 THEN ReferralBoneApproachID ELSE 0 END AS ReferralBoneApproachID, '
	set @strSelectLine = @strSelectLine + ' CASE WHEN ServiceLevelApproachTissue = -1 THEN ReferralTissueApproachID ELSE 0 END AS ReferralTissueApproachID, ' 
	set @strSelectLine = @strSelectLine + ' CASE WHEN ServiceLevelApproachSkin = -1 THEN ReferralSkinApproachID ELSE 0 END AS ReferralSkinApproachID, '
	set @strSelectLine = @strSelectLine + ' CASE WHEN ServiceLevelApproachValves = -1 THEN ReferralValvesApproachID ELSE 0 END AS ReferralValvesApproachID, '
	set @strSelectLine = @strSelectLine + ' CASE WHEN ServiceLevelApproachEyes = -1 THEN ReferralEyesTransApproachID ELSE 0 END AS ReferralEyesTransApproachID, '
	set @strSelectLine = @strSelectLine + ' CASE WHEN ServiceLevelApproachEyes = -1 THEN ReferralEyesRschApproachID ELSE 0 END AS ReferralEyesRschApproachID, '
	set @strSelectLine = @strSelectLine + ' CASE WHEN ServiceLevelConsentOrgan = -1 THEN ReferralOrganConsentID ELSE 0 END AS ReferralOrganConsentID, '
	set @strSelectLine = @strSelectLine + ' CASE WHEN ServiceLevelConsentBone = -1 THEN ReferralBoneConsentID ELSE 0 END AS ReferralBoneConsentID, '
	set @strSelectLine = @strSelectLine + ' CASE WHEN ServiceLevelConsentTissue = -1 THEN ReferralTissueConsentID ELSE 0 END AS ReferralTissueConsentID,'
	set @strSelectLine = @strSelectLine + ' CASE WHEN ServiceLevelConsentSkin = -1 THEN ReferralSkinConsentID ELSE 0 END AS ReferralSkinConsentID, '
	set @strSelectLine = @strSelectLine + ' CASE WHEN ServiceLevelConsentValves = -1 THEN ReferralValvesConsentID ELSE 0 END AS ReferralValvesConsentID, '
	set @strSelectLine = @strSelectLine + ' CASE WHEN ServiceLevelConsentEyes = -1 THEN ReferralEyesTransConsentID ELSE 0 END AS ReferralEyesTransConsentID, '
	set @strSelectLine = @strSelectLine + ' CASE WHEN ServiceLevelConsentEyes = -1 THEN ReferralEyesRschConsentID ELSE 0 END AS ReferralEyesRschConsentID, '
	set @strSelectLine = @strSelectLine + ' ReferralGeneralConsent, ReferralApproachedByPersonID,'
	set @strSelectLine = @strSelectLine + ' CASE _ReferralProdReport.dbo.RegistryStatus.RegistryStatus WHEN 1 THEN 1 WHEN 2 THEN 2 WHEN 4 THEN 4 ELSE 0 END AS RegistryStatus'
	set @strSelectLine = @strSelectLine + ' FROM _ReferralProdReport.dbo.Referral'
	set @strSelectLine = @strSelectLine + ' JOIN _ReferralProdReport.dbo.Call ON _ReferralProdReport.dbo.Call.CallID = _ReferralProdReport.dbo.Referral.CallID'

	-- ccarroll 10/16/2006 added join to ServiceLevel - Iteration2
	set @strSelectLine = @strSelectLine + ' JOIN _ReferralProdReport.dbo.CallCriteria ON _ReferralProdReport.dbo.CallCriteria.CallID = _ReferralProdReport.dbo.Call.CallID'
	set @strSelectLine = @strSelectLine + ' JOIN _ReferralProdReport.dbo.ServiceLevel ON _ReferralProdReport.dbo.ServiceLevel.ServiceLevelID = _ReferralProdReport.dbo.CallCriteria.ServiceLevelID'

	set @strSelectLine = @strSelectLine + '	JOIN _ReferralProdReport.dbo.SourceCode ON _ReferralProdReport.dbo.Call.SourceCodeID = _ReferralProdReport.dbo.SourceCode.SourceCodeID'
	set @strSelectLine = @strSelectLine + ' JOIN _ReferralProdReport.dbo.Organization ON _ReferralProdReport.dbo.Referral.ReferralCallerOrganizationID = _ReferralProdReport.dbo.Organization.OrganizationID'
	set @strSelectLine = @strSelectLine + '	JOIN _ReferralProdReport.dbo.TimeZone ON _ReferralProdReport.dbo.Organization.TimeZoneID = _ReferralProdReport.dbo.TimeZone.TimeZoneID'

	set @strSelectLine = @strSelectLine + ' LEFT JOIN _ReferralProdReport.dbo.RegistryStatus ON _ReferralProdReport.dbo.Referral.CallId = _ReferralProdReport.dbo.RegistryStatus.CallId'
	--JOIN   _ReferralProdReport.dbo.Person ON _ReferralProdReport.dbo.Person.PersonID = _ReferralProdReport.dbo.Referral.ReferralApproachedByPersonID'

	set @strSelectLine2 = '	WHERE DATEPART(yyyy, DATEADD(hour, '+@strTemp+', CallDateTime)) = '+ltrim(str(@YearID))
	set @strSelectLine2 = @strSelectLine2 + ' AND DATEPART(m, DATEADD(hour, '+ @strTemp + ', CallDateTime)) = ' + ltrim(str(@MonthID))

	EXEC(@strSelectLine+@strSelectLine2)

	-- update the count stats

/****************************************************************************************************************************************************************************************/
	-- PreRefFamilyApproach  Count
/****************************************************************************************************************************************************************************************/
	UPDATE	#_Temp_Referral_ApproachCount
	SET		PreRefFamilyApproach = CountTable.ReferralCount
	FROM		
	(
	SELECT 	        CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachSelect
	WHERE	        ReferralApproachTypeID = 6	
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		YearID = @YearID
	AND		MonthID = @MonthID

/****************************************************************************************************************************************************************************************/
	-- PreRefFacilityApproach  Count
/****************************************************************************************************************************************************************************************/
	UPDATE	#_Temp_Referral_ApproachCount
	SET		PreRefFacilityApproach = CountTable.ReferralCount
	FROM		
	(
	SELECT 	        CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachSelect
	WHERE	        (ReferralApproachTypeID = 2
			OR ReferralApproachTypeID = 3)
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		YearID = @YearID
	AND		MonthID = @MonthID

/****************************************************************************************************************************************************************************************/
	-- PostRefApproach  Count
/****************************************************************************************************************************************************************************************/
	UPDATE	#_Temp_Referral_ApproachCount
	SET		PostRefApproach = CountTable.ReferralCount

	FROM		
	(
	SELECT 	        CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachSelect
	WHERE	        (ReferralApproachTypeID = 4
			OR ReferralApproachTypeID = 5)

	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		YearID = @YearID
	AND		MonthID = @MonthID

/****************************************************************************************************************************************************************************************/
	-- NotApproached  Count
/****************************************************************************************************************************************************************************************/
	UPDATE	#_Temp_Referral_ApproachCount
	SET		NotApproached = CountTable.ReferralCount
	FROM		
	(
	SELECT 	        CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachSelect
	WHERE	        ReferralApproachTypeID = 1

	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		YearID = @YearID
	AND		MonthID = @MonthID

/****************************************************************************************************************************************************************************************/
	-- UnknownApproach  Count
/****************************************************************************************************************************************************************************************/
	UPDATE	#_Temp_Referral_ApproachCount
	SET		UnknownApproach = CountTable.ReferralCount
	FROM		
	(
	SELECT 	        CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachSelect
	WHERE	        ReferralApproachTypeID = 7

	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		YearID = @YearID
	AND		MonthID = @MonthID

/****************************************************************************************************************************************************************************************/
	-- RegistryApproach  Count
/****************************************************************************************************************************************************************************************/
	UPDATE	#_Temp_Referral_ApproachCount
	SET		RegistryApproach = CountTable.ReferralCount
	FROM		
	(
	SELECT 	        CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachSelect
	WHERE	   	ReferralApproachTypeID = 8
	OR			RegistryStatus > 0	

	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		YearID = @YearID
	AND		MonthID = @MonthID

/****************************************************************************************************************************************************************************************/
	-- O_PreRef_Approached_DR  Count
/****************************************************************************************************************************************************************************************/
	UPDATE	#_Temp_Referral_ApproachCount
	SET		O_PreRef_Approached_DR = CountTable.ReferralCount
	FROM		
	(
	SELECT 	        CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachSelect
        JOIN            _ReferralProdReport.dbo.Person ON _ReferralProdReport.dbo.Person.PersonID = #_Temp_Referral_ApproachSelect.ReferralApproachedByPersonID
	WHERE	        (ReferralApproachTypeID = 2 OR ReferralApproachTypeID = 3 OR ReferralApproachTypeID = 6)
	AND		ReferralOrganApproachID = 1
	AND		RegistryStatus = 0
	AND		PersonLast LIKE '%*'

	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		YearID = @YearID
	AND		MonthID = @MonthID

/****************************************************************************************************************************************************************************************/
	-- O_PreRef_Approached_NonDR  Count
/****************************************************************************************************************************************************************************************/
	UPDATE	#_Temp_Referral_ApproachCount
	SET		O_PreRef_Approached_NonDR = CountTable.ReferralCount
	FROM		
	(
	SELECT 	        CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachSelect
        JOIN            _ReferralProdReport.dbo.Person ON _ReferralProdReport.dbo.Person.PersonID = #_Temp_Referral_ApproachSelect.ReferralApproachedByPersonID
	WHERE	        (ReferralApproachTypeID = 2 OR ReferralApproachTypeID = 3 OR ReferralApproachTypeID = 6)
	AND		ReferralOrganApproachID = 1
	AND		RegistryStatus = 0
	AND		PersonLast NOT LIKE '%*'

	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		YearID = @YearID
	AND		MonthID = @MonthID

/****************************************************************************************************************************************************************************************/
	-- O_PreRef_Consented_Family  Count
/****************************************************************************************************************************************************************************************/
	UPDATE	#_Temp_Referral_ApproachCount
	SET		O_PreRef_Consented_Family = CountTable.ReferralCount
	FROM		
	(
	SELECT 	        CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachSelect
	WHERE	        ReferralApproachTypeID = 6
	AND		ReferralOrganConsentID = 1
	AND		RegistryStatus = 0

	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		YearID = @YearID
	AND		MonthID = @MonthID

/****************************************************************************************************************************************************************************************/
	-- O_PreRef_Consented_DR  Count
/****************************************************************************************************************************************************************************************/
	UPDATE	#_Temp_Referral_ApproachCount
	SET		O_PreRef_Consented_DR = CountTable.ReferralCount
	FROM		
	(
	SELECT 	        CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachSelect
        JOIN            _ReferralProdReport.dbo.Person ON _ReferralProdReport.dbo.Person.PersonID = #_Temp_Referral_ApproachSelect.ReferralApproachedByPersonID
	WHERE	        (ReferralApproachTypeID = 2 OR ReferralApproachTypeID = 3 OR ReferralApproachTypeID = 6)
	AND		ReferralOrganConsentID = 1
	AND		RegistryStatus = 0
	AND		PersonLast LIKE '%*'

	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		YearID = @YearID
	AND		MonthID = @MonthID

/****************************************************************************************************************************************************************************************/
	-- O_PreRef_Consented_NonDR  Count
/****************************************************************************************************************************************************************************************/
	UPDATE	#_Temp_Referral_ApproachCount
	SET		O_PreRef_Consented_NonDR = CountTable.ReferralCount
	FROM		
	(
	SELECT 	        CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachSelect
        JOIN            _ReferralProdReport.dbo.Person ON _ReferralProdReport.dbo.Person.PersonID = #_Temp_Referral_ApproachSelect.ReferralApproachedByPersonID
	WHERE	        (ReferralApproachTypeID = 2 OR ReferralApproachTypeID = 3 OR ReferralApproachTypeID = 6)
	AND		ReferralOrganConsentID = 1
	AND		RegistryStatus = 0
	AND		PersonLast NOT LIKE '%*'

	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		YearID = @YearID
	AND		MonthID = @MonthID

/****************************************************************************************************************************************************************************************/
	-- O_PostRef_Approached_DR  Count
/****************************************************************************************************************************************************************************************/
	UPDATE	#_Temp_Referral_ApproachCount
	SET		O_PostRef_Approached_DR = CountTable.ReferralCount
	FROM		
	(
	SELECT 	        CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachSelect
        JOIN            _ReferralProdReport.dbo.Person ON _ReferralProdReport.dbo.Person.PersonID = #_Temp_Referral_ApproachSelect.ReferralApproachedByPersonID
	WHERE	        (ReferralApproachTypeID = 4 OR ReferralApproachTypeID = 5)
	AND		ReferralOrganApproachID = 1
	AND		RegistryStatus = 0
	AND		PersonLast LIKE '%*'

	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		YearID = @YearID
	AND		MonthID = @MonthID

/****************************************************************************************************************************************************************************************/
	-- O_PostRef_Approached_NonDR  Count
/****************************************************************************************************************************************************************************************/
	UPDATE	#_Temp_Referral_ApproachCount
	SET		O_PostRef_Approached_NonDR = CountTable.ReferralCount
	FROM		
	(
	SELECT 	        CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachSelect
        JOIN            _ReferralProdReport.dbo.Person ON _ReferralProdReport.dbo.Person.PersonID = #_Temp_Referral_ApproachSelect.ReferralApproachedByPersonID
	WHERE	        (ReferralApproachTypeID = 4 OR ReferralApproachTypeID = 5)
	AND		ReferralOrganApproachID = 1
	AND		RegistryStatus = 0
	AND		PersonLast NOT LIKE '%*'

	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		YearID = @YearID
	AND		MonthID = @MonthID

/****************************************************************************************************************************************************************************************/
	-- O_PostRef_Consented_DR  Count
/****************************************************************************************************************************************************************************************/
	UPDATE	#_Temp_Referral_ApproachCount
	SET		O_PostRef_Consented_DR = CountTable.ReferralCount
	FROM		
	(
	SELECT 	        CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachSelect
        JOIN            _ReferralProdReport.dbo.Person ON _ReferralProdReport.dbo.Person.PersonID = #_Temp_Referral_ApproachSelect.ReferralApproachedByPersonID
	WHERE	        (ReferralApproachTypeID = 4 OR ReferralApproachTypeID = 5)
	AND		ReferralOrganConsentID = 1
	AND		RegistryStatus = 0
	AND		PersonLast LIKE '%*'


	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		YearID = @YearID
	AND		MonthID = @MonthID

-- Removed duplicate of update below for O_PostRef_Consented_NonDR.  11/18/04 - SAP
/****************************************************************************************************************************************************************************************/
	-- O_PostRef_Consented_NonDR  Count
/****************************************************************************************************************************************************************************************/
	UPDATE	#_Temp_Referral_ApproachCount
	SET		O_PostRef_Consented_NonDR = CountTable.ReferralCount
	FROM		
	(
	SELECT 	        CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachSelect
        JOIN            _ReferralProdReport.dbo.Person ON _ReferralProdReport.dbo.Person.PersonID = #_Temp_Referral_ApproachSelect.ReferralApproachedByPersonID
	WHERE	        (ReferralApproachTypeID = 4 OR ReferralApproachTypeID = 5)
	AND		ReferralOrganConsentID = 1
	AND		RegistryStatus = 0
	AND		PersonLast NOT LIKE '%*'


	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		YearID = @YearID
	AND		MonthID = @MonthID

/****************************************************************************************************************************************************************************************/
	-- T_PreRef_Approached_DR  Count
/****************************************************************************************************************************************************************************************/
	UPDATE	#_Temp_Referral_ApproachCount
	SET		T_PreRef_Approached_DR = CountTable.ReferralCount
	FROM		
	(
	SELECT 	        CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachSelect
        JOIN            _ReferralProdReport.dbo.Person ON _ReferralProdReport.dbo.Person.PersonID = #_Temp_Referral_ApproachSelect.ReferralApproachedByPersonID
	WHERE	        (ReferralApproachTypeID = 2 OR ReferralApproachTypeID = 3 OR ReferralApproachTypeID = 6)
	AND		(ReferralBoneApproachID = 1 OR ReferralTissueApproachID = 1 OR ReferralSkinApproachID = 1 OR ReferralValvesApproachID = 1)
	AND		RegistryStatus = 0
	AND		PersonLast LIKE '%*'

	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		YearID = @YearID
	AND		MonthID = @MonthID

/****************************************************************************************************************************************************************************************/
	-- T_PreRef_Approached_NonDR  Count
/****************************************************************************************************************************************************************************************/
	UPDATE	#_Temp_Referral_ApproachCount
	SET		T_PreRef_Approached_NonDR = CountTable.ReferralCount
	FROM		
	(
	SELECT 	        CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachSelect
        JOIN            _ReferralProdReport.dbo.Person ON _ReferralProdReport.dbo.Person.PersonID = #_Temp_Referral_ApproachSelect.ReferralApproachedByPersonID
	WHERE	        (ReferralApproachTypeID = 2 OR ReferralApproachTypeID = 3 OR ReferralApproachTypeID = 6)
	AND		(ReferralBoneApproachID = 1 OR ReferralTissueApproachID = 1 OR ReferralSkinApproachID = 1 OR ReferralValvesApproachID = 1)
	AND		RegistryStatus = 0
	AND		PersonLast NOT LIKE '%*'

	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		YearID = @YearID
	AND		MonthID = @MonthID

/****************************************************************************************************************************************************************************************/
	-- T_PreRef_Consented_Family  Count
/****************************************************************************************************************************************************************************************/
	UPDATE	#_Temp_Referral_ApproachCount
	SET		T_PreRef_Consented_Family = CountTable.ReferralCount
	FROM		
	(
	SELECT 	        CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachSelect
	WHERE	        ReferralApproachTypeID = 6
	AND		(ReferralBoneConsentID = 1 OR ReferralTissueConsentID = 1 OR ReferralSkinConsentID = 1 OR ReferralValvesConsentID = 1)
	AND		RegistryStatus = 0

	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		YearID = @YearID
	AND		MonthID = @MonthID

/****************************************************************************************************************************************************************************************/
	-- T_PreRef_Consented_DR  Count
/****************************************************************************************************************************************************************************************/
	UPDATE	#_Temp_Referral_ApproachCount
	SET		T_PreRef_Consented_DR = CountTable.ReferralCount
	FROM		
	(
	SELECT 	        CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachSelect
        JOIN            _ReferralProdReport.dbo.Person ON _ReferralProdReport.dbo.Person.PersonID = #_Temp_Referral_ApproachSelect.ReferralApproachedByPersonID
	WHERE	        (ReferralApproachTypeID = 2 OR ReferralApproachTypeID = 3 OR ReferralApproachTypeID = 6)
	AND		(ReferralBoneConsentID = 1 OR ReferralTissueConsentID = 1 OR ReferralSkinConsentID = 1 OR ReferralValvesConsentID = 1)
	AND		RegistryStatus = 0
	AND		PersonLast LIKE '%*'

	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable


	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		YearID = @YearID
	AND		MonthID = @MonthID

/****************************************************************************************************************************************************************************************/
	-- T_PreRef_Consented_NonDR  Count
/****************************************************************************************************************************************************************************************/
	UPDATE	#_Temp_Referral_ApproachCount
	SET		T_PreRef_Consented_NonDR = CountTable.ReferralCount
	FROM		
	(
	SELECT 	        CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachSelect
        JOIN            _ReferralProdReport.dbo.Person ON _ReferralProdReport.dbo.Person.PersonID = #_Temp_Referral_ApproachSelect.ReferralApproachedByPersonID
	WHERE	        (ReferralApproachTypeID = 2 OR ReferralApproachTypeID = 3 OR ReferralApproachTypeID = 6)
	AND		(ReferralBoneConsentID = 1 OR ReferralTissueConsentID = 1 OR ReferralSkinConsentID = 1 OR ReferralValvesConsentID = 1)
	AND		RegistryStatus = 0
	AND		PersonLast NOT LIKE '%*'

	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		YearID = @YearID
	AND		MonthID = @MonthID

/****************************************************************************************************************************************************************************************/
	-- T_PostRef_Approached_DR  Count
/****************************************************************************************************************************************************************************************/
	UPDATE	#_Temp_Referral_ApproachCount
	SET		T_PostRef_Approached_DR = CountTable.ReferralCount
	FROM		
	(
	SELECT 	        CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachSelect
        JOIN            _ReferralProdReport.dbo.Person ON _ReferralProdReport.dbo.Person.PersonID = #_Temp_Referral_ApproachSelect.ReferralApproachedByPersonID
	WHERE	        (ReferralApproachTypeID = 4 OR ReferralApproachTypeID = 5)
	AND		(ReferralBoneApproachID = 1 OR ReferralTissueApproachID = 1 OR ReferralSkinApproachID = 1 OR ReferralValvesApproachID = 1)
	AND		RegistryStatus = 0
	AND		PersonLast LIKE '%*'

	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		YearID = @YearID
	AND		MonthID = @MonthID

/****************************************************************************************************************************************************************************************/
	-- T_PostRef_Approached_NonDR  Count
/****************************************************************************************************************************************************************************************/
	UPDATE	#_Temp_Referral_ApproachCount
	SET		T_PostRef_Approached_NonDR = CountTable.ReferralCount
	FROM		

	(
	SELECT 	        CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachSelect
        JOIN            _ReferralProdReport.dbo.Person ON _ReferralProdReport.dbo.Person.PersonID = #_Temp_Referral_ApproachSelect.ReferralApproachedByPersonID
	WHERE	        (ReferralApproachTypeID = 4 OR ReferralApproachTypeID = 5)
	AND		(ReferralBoneApproachID = 1 OR ReferralTissueApproachID = 1 OR ReferralSkinApproachID = 1 OR ReferralValvesApproachID = 1)
	AND		RegistryStatus = 0
	AND		PersonLast NOT LIKE '%*'

	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		YearID = @YearID
	AND		MonthID = @MonthID

/****************************************************************************************************************************************************************************************/
	-- T_PostRef_Consented_DR  Count
/****************************************************************************************************************************************************************************************/
	UPDATE	#_Temp_Referral_ApproachCount
	SET		T_PostRef_Consented_DR = CountTable.ReferralCount
	FROM		
	(
	SELECT 	        CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachSelect
        JOIN            _ReferralProdReport.dbo.Person ON _ReferralProdReport.dbo.Person.PersonID = #_Temp_Referral_ApproachSelect.ReferralApproachedByPersonID
	WHERE	        (ReferralApproachTypeID = 4 OR ReferralApproachTypeID = 5)
	AND		(ReferralBoneConsentID = 1 OR ReferralTissueConsentID = 1 OR ReferralSkinConsentID = 1 OR ReferralValvesConsentID = 1)
	AND		RegistryStatus = 0
	AND		PersonLast LIKE '%*'


	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		YearID = @YearID
	AND		MonthID = @MonthID

/****************************************************************************************************************************************************************************************/
	-- T_PostRef_Consented_NonDR  Count
/****************************************************************************************************************************************************************************************/
	UPDATE	#_Temp_Referral_ApproachCount
	SET		T_PostRef_Consented_NonDR = CountTable.ReferralCount
	FROM		
	(
	SELECT 	        CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachSelect
        JOIN            _ReferralProdReport.dbo.Person ON _ReferralProdReport.dbo.Person.PersonID = #_Temp_Referral_ApproachSelect.ReferralApproachedByPersonID
	WHERE	        (ReferralApproachTypeID = 4 OR ReferralApproachTypeID = 5)
	AND		(ReferralBoneConsentID = 1 OR ReferralTissueConsentID = 1 OR ReferralSkinConsentID = 1 OR ReferralValvesConsentID = 1)
	AND		RegistryStatus = 0
	AND		PersonLast NOT LIKE '%*'


	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		YearID = @YearID
	AND		MonthID = @MonthID

/****************************************************************************************************************************************************************************************/
	-- T_PostRef_Consented_NonDR  Count
/****************************************************************************************************************************************************************************************/
	UPDATE	#_Temp_Referral_ApproachCount
	SET		T_PostRef_Consented_NonDR = CountTable.ReferralCount
	FROM		
	(
	SELECT 	        CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachSelect
        JOIN            _ReferralProdReport.dbo.Person ON _ReferralProdReport.dbo.Person.PersonID = #_Temp_Referral_ApproachSelect.ReferralApproachedByPersonID
	WHERE	        (ReferralApproachTypeID = 4 OR ReferralApproachTypeID = 5)
	AND		(ReferralBoneConsentID = 1 OR ReferralTissueConsentID = 1 OR ReferralSkinConsentID = 1 OR ReferralValvesConsentID = 1)
	AND		RegistryStatus = 0
	AND		PersonLast NOT LIKE '%*'


	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		YearID = @YearID
	AND		MonthID = @MonthID

/****************************************************************************************************************************************************************************************/
	-- E_PreRef_Approached_DR  Count
/****************************************************************************************************************************************************************************************/
	UPDATE	#_Temp_Referral_ApproachCount
	SET		E_PreRef_Approached_DR = CountTable.ReferralCount

	FROM		
	(
	SELECT 	        CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachSelect
        JOIN            _ReferralProdReport.dbo.Person ON _ReferralProdReport.dbo.Person.PersonID = #_Temp_Referral_ApproachSelect.ReferralApproachedByPersonID
	WHERE	        (ReferralApproachTypeID = 2 OR ReferralApproachTypeID = 3 OR ReferralApproachTypeID = 6)
	AND		ReferralEyesTransApproachID = 1
	AND		RegistryStatus = 0
	AND		PersonLast LIKE '%*'

	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		YearID = @YearID
	AND		MonthID = @MonthID

/****************************************************************************************************************************************************************************************/
	-- E_PreRef_Approached_NonDR  Count
/****************************************************************************************************************************************************************************************/
	UPDATE	#_Temp_Referral_ApproachCount
	SET		E_PreRef_Approached_NonDR = CountTable.ReferralCount
	FROM		
	(
	SELECT 	        CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachSelect
        JOIN            _ReferralProdReport.dbo.Person ON _ReferralProdReport.dbo.Person.PersonID = #_Temp_Referral_ApproachSelect.ReferralApproachedByPersonID
	WHERE	        (ReferralApproachTypeID = 2 OR ReferralApproachTypeID = 3 OR ReferralApproachTypeID = 6)
	AND		ReferralEyesTransApproachID = 1
	AND		RegistryStatus = 0
	AND		PersonLast NOT LIKE '%*'

	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		YearID = @YearID
	AND		MonthID = @MonthID

/****************************************************************************************************************************************************************************************/
	-- E_PreRef_Consented_Family  Count
/****************************************************************************************************************************************************************************************/
	UPDATE	#_Temp_Referral_ApproachCount
	SET		E_PreRef_Consented_Family = CountTable.ReferralCount
	FROM		
	(
	SELECT 	        CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachSelect
	WHERE	        ReferralApproachTypeID = 6
	AND		ReferralEyesTransConsentID = 1
	AND		RegistryStatus = 0

	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		YearID = @YearID
	AND		MonthID = @MonthID

/****************************************************************************************************************************************************************************************/
	-- E_PreRef_Consented_DR  Count
/****************************************************************************************************************************************************************************************/
	UPDATE	#_Temp_Referral_ApproachCount
	SET		E_PreRef_Consented_DR = CountTable.ReferralCount
	FROM		
	(
	SELECT 	        CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachSelect
        JOIN            _ReferralProdReport.dbo.Person ON _ReferralProdReport.dbo.Person.PersonID = #_Temp_Referral_ApproachSelect.ReferralApproachedByPersonID
	WHERE	        (ReferralApproachTypeID = 2 OR ReferralApproachTypeID = 3 OR ReferralApproachTypeID = 6)
	AND		ReferralEyesTransConsentID = 1
	AND		RegistryStatus = 0
	AND		PersonLast LIKE '%*'

	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		YearID = @YearID
	AND		MonthID = @MonthID

/****************************************************************************************************************************************************************************************/
	-- E_PreRef_Consented_NonDR  Count
/****************************************************************************************************************************************************************************************/
	UPDATE	#_Temp_Referral_ApproachCount
	SET		E_PreRef_Consented_NonDR = CountTable.ReferralCount
	FROM		
	(
	SELECT 	        CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachSelect
        JOIN            _ReferralProdReport.dbo.Person ON _ReferralProdReport.dbo.Person.PersonID = #_Temp_Referral_ApproachSelect.ReferralApproachedByPersonID
	WHERE	        (ReferralApproachTypeID = 2 OR ReferralApproachTypeID = 3 OR ReferralApproachTypeID = 6)
	AND		ReferralEyesTransConsentID = 1
	AND		RegistryStatus = 0
	AND		PersonLast NOT LIKE '%*'

	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		YearID = @YearID
	AND		MonthID = @MonthID

/****************************************************************************************************************************************************************************************/
	-- E_PostRef_Approached_DR  Count
/****************************************************************************************************************************************************************************************/
	UPDATE	#_Temp_Referral_ApproachCount
	SET		E_PostRef_Approached_DR = CountTable.ReferralCount
	FROM		
	(
	SELECT 	        CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachSelect
        JOIN            _ReferralProdReport.dbo.Person ON _ReferralProdReport.dbo.Person.PersonID = #_Temp_Referral_ApproachSelect.ReferralApproachedByPersonID
	WHERE	        (ReferralApproachTypeID = 4 OR ReferralApproachTypeID = 5)
	AND		ReferralEyesTransApproachID = 1
	AND		RegistryStatus = 0
	AND		PersonLast LIKE '%*'

	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		YearID = @YearID
	AND		MonthID = @MonthID

/****************************************************************************************************************************************************************************************/
	-- E_PostRef_Approached_NonDR  Count
/****************************************************************************************************************************************************************************************/
	UPDATE	#_Temp_Referral_ApproachCount
	SET		E_PostRef_Approached_NonDR = CountTable.ReferralCount
	FROM		
	(
	SELECT 	        CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachSelect
        JOIN            _ReferralProdReport.dbo.Person ON _ReferralProdReport.dbo.Person.PersonID = #_Temp_Referral_ApproachSelect.ReferralApproachedByPersonID
	WHERE	        (ReferralApproachTypeID = 4 OR ReferralApproachTypeID = 5)
	AND		ReferralEyesTransApproachID = 1
	AND		RegistryStatus = 0
	AND		PersonLast NOT LIKE '%*'

	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		YearID = @YearID
	AND		MonthID = @MonthID

/****************************************************************************************************************************************************************************************/
	-- E_PostRef_Consented_DR  Count
/****************************************************************************************************************************************************************************************/
	UPDATE	#_Temp_Referral_ApproachCount
	SET		E_PostRef_Consented_DR = CountTable.ReferralCount
	FROM		
	(
	SELECT 	        CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachSelect
        JOIN            _ReferralProdReport.dbo.Person ON _ReferralProdReport.dbo.Person.PersonID = #_Temp_Referral_ApproachSelect.ReferralApproachedByPersonID
	WHERE	        (ReferralApproachTypeID = 4 OR ReferralApproachTypeID = 5)
	AND		ReferralEyesTransConsentID = 1
	AND		RegistryStatus = 0
	AND		PersonLast LIKE '%*'


	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		YearID = @YearID
	AND		MonthID = @MonthID

/****************************************************************************************************************************************************************************************/
	-- E_PostRef_Consented_NonDR  Count
/****************************************************************************************************************************************************************************************/
	UPDATE	#_Temp_Referral_ApproachCount
	SET		E_PostRef_Consented_NonDR = CountTable.ReferralCount
	FROM		
	(
	SELECT 	        CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachSelect
        JOIN            _ReferralProdReport.dbo.Person ON _ReferralProdReport.dbo.Person.PersonID = #_Temp_Referral_ApproachSelect.ReferralApproachedByPersonID
	WHERE	        (ReferralApproachTypeID = 4 OR ReferralApproachTypeID = 5)
	AND		ReferralEyesTransConsentID = 1
	AND		RegistryStatus = 0
	AND		PersonLast NOT LIKE '%*'


	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		YearID = @YearID
	AND		MonthID = @MonthID

/****************************************************************************************************************************************************************************************/
	-- E_PostRef_Consented_NonDR  Count
/****************************************************************************************************************************************************************************************/
	UPDATE	#_Temp_Referral_ApproachCount
	SET		E_PostRef_Consented_NonDR = CountTable.ReferralCount
	FROM		
	(
	SELECT 	        CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachSelect
        JOIN            _ReferralProdReport.dbo.Person ON _ReferralProdReport.dbo.Person.PersonID = #_Temp_Referral_ApproachSelect.ReferralApproachedByPersonID
	WHERE	        (ReferralApproachTypeID = 4 OR ReferralApproachTypeID = 5)
	AND		ReferralEyesTransConsentID = 1
	AND		RegistryStatus = 0
	AND		PersonLast NOT LIKE '%*'


	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		YearID = @YearID
	AND		MonthID = @MonthID


/****************************************************************************************************************************************************************************************/
	-- A_PreRef_Approached_DR  Count
/****************************************************************************************************************************************************************************************/
	UPDATE	#_Temp_Referral_ApproachCount
	SET		A_PreRef_Approached_DR = CountTable.ReferralCount
	FROM		
	(
	SELECT 	        CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachSelect
        JOIN            _ReferralProdReport.dbo.Person ON _ReferralProdReport.dbo.Person.PersonID = #_Temp_Referral_ApproachSelect.ReferralApproachedByPersonID
	WHERE	        (ReferralApproachTypeID = 2 OR ReferralApproachTypeID = 3 OR ReferralApproachTypeID = 6)
	AND		PersonLast LIKE '%*'

	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		YearID = @YearID
	AND		MonthID = @MonthID

/****************************************************************************************************************************************************************************************/
	-- A_PreRef_Approached_NonDR  Count
/****************************************************************************************************************************************************************************************/
	UPDATE	#_Temp_Referral_ApproachCount
	SET		A_PreRef_Approached_NonDR = CountTable.ReferralCount
	FROM		
	(
	SELECT 	        CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachSelect
        JOIN            _ReferralProdReport.dbo.Person ON _ReferralProdReport.dbo.Person.PersonID = #_Temp_Referral_ApproachSelect.ReferralApproachedByPersonID
	WHERE	        (ReferralApproachTypeID = 2 OR ReferralApproachTypeID = 3 OR ReferralApproachTypeID = 6)
	AND		PersonLast NOT LIKE '%*'

	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		YearID = @YearID
	AND		MonthID = @MonthID

/****************************************************************************************************************************************************************************************/
	-- A_PreRef_Consented_Family  Count
/****************************************************************************************************************************************************************************************/
	UPDATE	#_Temp_Referral_ApproachCount
	SET		A_PreRef_Consented_Family = CountTable.ReferralCount
	FROM		
	(
	SELECT 	        CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachSelect
	WHERE	        ReferralApproachTypeID = 6
	AND		(ReferralGeneralConsent  = 1 OR ReferralGeneralConsent  = 2)
	AND		RegistryStatus = 0

	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		YearID = @YearID
	AND		MonthID = @MonthID

/****************************************************************************************************************************************************************************************/
	-- A_PreRef_Consented_DR  Count
/****************************************************************************************************************************************************************************************/
	UPDATE	#_Temp_Referral_ApproachCount
	SET		A_PreRef_Consented_DR = CountTable.ReferralCount
	FROM		
	(
	SELECT 	        CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachSelect
        JOIN            _ReferralProdReport.dbo.Person ON _ReferralProdReport.dbo.Person.PersonID = #_Temp_Referral_ApproachSelect.ReferralApproachedByPersonID
	WHERE	        (ReferralApproachTypeID = 2 OR ReferralApproachTypeID = 3 OR ReferralApproachTypeID = 6)
	AND		(ReferralGeneralConsent  = 1 OR ReferralGeneralConsent  = 2)
	AND		RegistryStatus = 0
	AND		PersonLast LIKE '%*'

	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		YearID = @YearID
	AND		MonthID = @MonthID

/****************************************************************************************************************************************************************************************/
	-- A_PreRef_Consented_NonDR  Count
/****************************************************************************************************************************************************************************************/
	UPDATE	#_Temp_Referral_ApproachCount
	SET		A_PreRef_Consented_NonDR = CountTable.ReferralCount
	FROM		
	(
	SELECT 	        CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachSelect
        JOIN            _ReferralProdReport.dbo.Person ON _ReferralProdReport.dbo.Person.PersonID = #_Temp_Referral_ApproachSelect.ReferralApproachedByPersonID
	WHERE	        (ReferralApproachTypeID = 2 OR ReferralApproachTypeID = 3 OR ReferralApproachTypeID = 6)
	AND		(ReferralGeneralConsent  = 1 OR ReferralGeneralConsent  = 2)
	AND		RegistryStatus = 0
	AND		PersonLast NOT LIKE '%*'

	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		YearID = @YearID
	AND		MonthID = @MonthID

/****************************************************************************************************************************************************************************************/
	-- A_PostRef_Approached_DR  Count
/****************************************************************************************************************************************************************************************/
	UPDATE	#_Temp_Referral_ApproachCount
	SET		A_PostRef_Approached_DR = CountTable.ReferralCount
	FROM		
	(
	SELECT 	        CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachSelect
        JOIN            _ReferralProdReport.dbo.Person ON _ReferralProdReport.dbo.Person.PersonID = #_Temp_Referral_ApproachSelect.ReferralApproachedByPersonID
	WHERE	        (ReferralApproachTypeID = 4 OR ReferralApproachTypeID = 5)
	AND		PersonLast LIKE '%*'

	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		YearID = @YearID
	AND		MonthID = @MonthID

/****************************************************************************************************************************************************************************************/
	-- A_PostRef_Approached_NonDR  Count
/****************************************************************************************************************************************************************************************/
	UPDATE	#_Temp_Referral_ApproachCount
	SET		A_PostRef_Approached_NonDR = CountTable.ReferralCount
	FROM		
	(
	SELECT 	        CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachSelect
        JOIN            _ReferralProdReport.dbo.Person ON _ReferralProdReport.dbo.Person.PersonID = #_Temp_Referral_ApproachSelect.ReferralApproachedByPersonID
	WHERE	        (ReferralApproachTypeID = 4 OR ReferralApproachTypeID = 5)
	AND		PersonLast NOT LIKE '%*'

	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		YearID = @YearID
	AND		MonthID = @MonthID

/****************************************************************************************************************************************************************************************/
	-- A_PostRef_Consented_DR  Count
/****************************************************************************************************************************************************************************************/
	UPDATE	#_Temp_Referral_ApproachCount
	SET		A_PostRef_Consented_DR = CountTable.ReferralCount
	FROM		
	(
	SELECT 	        CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachSelect
        JOIN            _ReferralProdReport.dbo.Person ON _ReferralProdReport.dbo.Person.PersonID = #_Temp_Referral_ApproachSelect.ReferralApproachedByPersonID
	WHERE	        (ReferralApproachTypeID = 4 OR ReferralApproachTypeID = 5)
	AND		(ReferralGeneralConsent  = 1 OR ReferralGeneralConsent  = 2)
	AND		RegistryStatus = 0
	AND		PersonLast LIKE '%*'


	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		YearID = @YearID
	AND		MonthID = @MonthID

/****************************************************************************************************************************************************************************************/
	-- A_PostRef_Consented_NonDR  Count
/****************************************************************************************************************************************************************************************/
	UPDATE	#_Temp_Referral_ApproachCount
	SET		A_PostRef_Consented_NonDR = CountTable.ReferralCount
	FROM		
	(
	SELECT 	        CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachSelect
        JOIN            _ReferralProdReport.dbo.Person ON _ReferralProdReport.dbo.Person.PersonID = #_Temp_Referral_ApproachSelect.ReferralApproachedByPersonID
	WHERE	        (ReferralApproachTypeID = 4 OR ReferralApproachTypeID = 5)
	AND		(ReferralGeneralConsent  = 1 OR ReferralGeneralConsent  = 2)
	AND		RegistryStatus = 0
	AND		PersonLast NOT LIKE '%*'


	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		YearID = @YearID
	AND		MonthID = @MonthID

/****************************************************************************************************************************************************************************************/
	-- A_PostRef_Consented_NonDR  Count
/****************************************************************************************************************************************************************************************/
	UPDATE	#_Temp_Referral_ApproachCount
	SET		A_PostRef_Consented_NonDR = CountTable.ReferralCount
	FROM		
	(
	SELECT 	        CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachSelect
        JOIN            _ReferralProdReport.dbo.Person ON _ReferralProdReport.dbo.Person.PersonID = #_Temp_Referral_ApproachSelect.ReferralApproachedByPersonID
	WHERE	        (ReferralApproachTypeID = 4 OR ReferralApproachTypeID = 5)
	AND		(ReferralGeneralConsent  = 1 OR ReferralGeneralConsent  = 2)
	AND		PersonLast NOT LIKE '%*'


	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		YearID = @YearID
	AND		MonthID = @MonthID

/****************************************************************************************************************************************************************************************/
	-- O_Registry_Approached  Count
/****************************************************************************************************************************************************************************************/
	UPDATE	#_Temp_Referral_ApproachCount
	SET		O_Registry_Approached = CountTable.ReferralCount
	FROM		
	(
	SELECT 	        CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachSelect
	WHERE	        ReferralApproachTypeID = 8
	AND		(ReferralOrganApproachID IN(12, 13)
	OR			RegistryStatus > 0)

	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		YearID = @YearID
	AND		MonthID = @MonthID

/****************************************************************************************************************************************************************************************/
	-- O_Registry_Consented  Count
/****************************************************************************************************************************************************************************************/
	UPDATE	#_Temp_Referral_ApproachCount
	SET		O_Registry_Consented = CountTable.ReferralCount
	FROM		
	(
	SELECT 	        CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachSelect
	WHERE		ReferralApproachTypeID = 8
	AND		((ReferralOrganApproachID IN(12, 13) AND ReferralOrganConsentID IN(7, 8))
	OR			(ReferralOrganConsentID = 1 AND RegistryStatus > 0))


	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		YearID = @YearID
	AND		MonthID = @MonthID


/****************************************************************************************************************************************************************************************/
	-- T_Registry_Approached  Count
/****************************************************************************************************************************************************************************************/
	UPDATE	#_Temp_Referral_ApproachCount
	SET		T_Registry_Approached = CountTable.ReferralCount
	FROM		
	(
	SELECT 	        CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachSelect
	WHERE		ReferralApproachTypeID = 8
	AND		(ReferralBoneApproachID IN(12, 13) OR ReferralTissueApproachID IN(12, 13) 
	OR 		ReferralSkinApproachID IN(12, 13) OR ReferralValvesApproachID IN(12, 13)
	OR			RegistryStatus > 0)
	

	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		YearID = @YearID
	AND		MonthID = @MonthID

/****************************************************************************************************************************************************************************************/
	--T_Registry_Consented  Count
/****************************************************************************************************************************************************************************************/
	UPDATE	#_Temp_Referral_ApproachCount
	SET		T_Registry_Consented = CountTable.ReferralCount
	FROM		
	(
	SELECT 	        CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachSelect

	WHERE 	ReferralApproachTypeID = 8 
	AND 		(((ReferralBoneApproachID IN(12, 13) OR ReferralTissueApproachID IN(12, 13) 
	OR 		ReferralSkinApproachID IN(12, 13) OR ReferralValvesApproachID IN(12, 13)) 
	AND 		(ReferralBoneConsentID IN(7, 8) OR ReferralTissueConsentID IN(7, 8) 
	OR 		ReferralSkinConsentID IN(7, 8) OR ReferralValvesConsentID IN(7, 8))) 
	OR 		((ReferralBoneConsentID =1 OR ReferralTissueConsentID =1 
	OR 		ReferralSkinConsentID =1 OR ReferralValvesConsentID =1) 
	AND 		RegistryStatus > 0))


	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		YearID = @YearID
	AND		MonthID = @MonthID


/****************************************************************************************************************************************************************************************/
	-- E_Registry_Approached  Count
/****************************************************************************************************************************************************************************************/
	UPDATE	#_Temp_Referral_ApproachCount
	SET		E_Registry_Approached = CountTable.ReferralCount
	FROM		
	(
	SELECT 	        CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachSelect
	WHERE	   ReferralApproachTypeID = 8
	AND		(ReferralEyesTransApproachID IN(12, 13)
	OR			RegistryStatus > 0)

	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		YearID = @YearID
	AND		MonthID = @MonthID

/****************************************************************************************************************************************************************************************/
	-- E_Registry_Consented  Count
/****************************************************************************************************************************************************************************************/
	UPDATE	#_Temp_Referral_ApproachCount
	SET		E_Registry_Consented = CountTable.ReferralCount
	FROM		
	(
	SELECT 	        CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachSelect
	WHERE	   ReferralApproachTypeID = 8
	AND		((ReferralEyesTransApproachID IN(12, 13)
	AND		ReferralEyesTransConsentID IN(7, 8))
	OR			(ReferralEyesTransConsentID = 1 
	AND		RegistryStatus > 0))



	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		YearID = @YearID
	AND		MonthID = @MonthID

/****************************************************************************************************************************************************************************************/
	-- A_Registry_Approached  Count
/****************************************************************************************************************************************************************************************/
	UPDATE	#_Temp_Referral_ApproachCount
	SET		A_Registry_Approached = CountTable.ReferralCount
	FROM		
	(
	SELECT 	        CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachSelect
	WHERE	        ReferralApproachTypeID = 8
	OR			RegistryStatus > 0
	

	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		YearID = @YearID
	AND		MonthID = @MonthID

/****************************************************************************************************************************************************************************************/
	-- A_Registry_Consented  Count
/****************************************************************************************************************************************************************************************/
	UPDATE	#_Temp_Referral_ApproachCount
	SET		A_Registry_Consented = CountTable.ReferralCount
	FROM		
	(
	SELECT 	        CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachSelect
	WHERE		(ReferralApproachTypeID = 8 OR RegistryStatus > 0)
	AND		(ReferralGeneralConsent  = 1 OR ReferralGeneralConsent  = 2)


	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		YearID = @YearID
	AND		MonthID = @MonthID

/****************************************************************************************************************************************************************************************/
	-- O_FamilyInitiated_Approached_DR  Count
/****************************************************************************************************************************************************************************************/
	UPDATE	#_Temp_Referral_ApproachCount
	SET		O_FamilyInitiated_Approached_DR = CountTable.ReferralCount
	FROM		
	(
	SELECT 	        CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachSelect
        JOIN            _ReferralProdReport.dbo.Person ON _ReferralProdReport.dbo.Person.PersonID = #_Temp_Referral_ApproachSelect.ReferralApproachedByPersonID
	WHERE	        (ReferralApproachTypeID = 6)
	AND		ReferralOrganApproachID = 1
	AND		RegistryStatus = 0
	AND		PersonLast LIKE '%*'

	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		YearID = @YearID
	AND		MonthID = @MonthID

/****************************************************************************************************************************************************************************************/
	-- O_FamilyInitiated_Approached_NonDR  Count
/****************************************************************************************************************************************************************************************/
	UPDATE	#_Temp_Referral_ApproachCount
	SET		O_FamilyInitiated_Approached_NonDR = CountTable.ReferralCount
	FROM		
	(
	SELECT 	        CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachSelect
        JOIN            _ReferralProdReport.dbo.Person ON _ReferralProdReport.dbo.Person.PersonID = #_Temp_Referral_ApproachSelect.ReferralApproachedByPersonID
	WHERE	        (ReferralApproachTypeID = 6)
	AND		ReferralOrganApproachID = 1
	AND		RegistryStatus = 0
	AND		PersonLast NOT LIKE '%*'

	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		YearID = @YearID
	AND		MonthID = @MonthID

/****************************************************************************************************************************************************************************************/
	-- T_FamilyInitiated_Approached_DR  Count
/****************************************************************************************************************************************************************************************/
	UPDATE	#_Temp_Referral_ApproachCount
	SET		T_FamilyInitiated_Approached_DR = CountTable.ReferralCount
	FROM		
	(
	SELECT 	        CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachSelect
        JOIN            _ReferralProdReport.dbo.Person ON _ReferralProdReport.dbo.Person.PersonID = #_Temp_Referral_ApproachSelect.ReferralApproachedByPersonID
	WHERE	        (ReferralApproachTypeID = 6)
	AND		(ReferralBoneApproachID = 1 OR ReferralTissueApproachID = 1 OR ReferralSkinApproachID = 1 OR ReferralValvesApproachID = 1)
	AND		RegistryStatus = 0
	AND		PersonLast LIKE '%*'

	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		YearID = @YearID
	AND		MonthID = @MonthID

/****************************************************************************************************************************************************************************************/
	-- T_FamilyInitiated_Approached_NonDR  Count
/****************************************************************************************************************************************************************************************/
	UPDATE	#_Temp_Referral_ApproachCount
	SET		T_FamilyInitiated_Approached_NonDR = CountTable.ReferralCount
	FROM		
	(
	SELECT 	        CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachSelect
        JOIN            _ReferralProdReport.dbo.Person ON _ReferralProdReport.dbo.Person.PersonID = #_Temp_Referral_ApproachSelect.ReferralApproachedByPersonID
	WHERE	        (ReferralApproachTypeID = 6)
	AND		(ReferralBoneApproachID = 1 OR ReferralTissueApproachID = 1 OR ReferralSkinApproachID = 1 OR ReferralValvesApproachID = 1)
	AND		RegistryStatus = 0
	AND		PersonLast NOT LIKE '%*'

	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		YearID = @YearID
	AND		MonthID = @MonthID

/****************************************************************************************************************************************************************************************/
	-- E_FamilyInitiated_Approached_DR  Count
/****************************************************************************************************************************************************************************************/
	UPDATE	#_Temp_Referral_ApproachCount
	SET		E_FamilyInitiated_Approached_DR = CountTable.ReferralCount
	FROM		
	(
	SELECT 	        CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachSelect
        JOIN            _ReferralProdReport.dbo.Person ON _ReferralProdReport.dbo.Person.PersonID = #_Temp_Referral_ApproachSelect.ReferralApproachedByPersonID
	WHERE	        (ReferralApproachTypeID = 6)
	AND		ReferralEyesTransApproachID = 1
	AND		RegistryStatus = 0
	AND		PersonLast LIKE '%*'

	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		YearID = @YearID
	AND		MonthID = @MonthID

/****************************************************************************************************************************************************************************************/
	-- E_FamilyInitiated_Approached_NonDR  Count
/****************************************************************************************************************************************************************************************/
	UPDATE	#_Temp_Referral_ApproachCount
	SET		E_FamilyInitiated_Approached_NonDR = CountTable.ReferralCount
	FROM		
	(
	SELECT 	        CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachSelect
        JOIN            _ReferralProdReport.dbo.Person ON _ReferralProdReport.dbo.Person.PersonID = #_Temp_Referral_ApproachSelect.ReferralApproachedByPersonID
	WHERE	        (ReferralApproachTypeID = 6)
	AND		ReferralEyesTransApproachID = 1
	AND		RegistryStatus = 0
	AND		PersonLast NOT LIKE '%*'

	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		YearID = @YearID
	AND		MonthID = @MonthID

/****************************************************************************************************************************************************************************************/
	-- A_FamilyInitiated_Approached_DR  Count
/****************************************************************************************************************************************************************************************/
	UPDATE	#_Temp_Referral_ApproachCount
	SET		A_FamilyInitiated_Approached_DR = CountTable.ReferralCount
	FROM		
	(
	SELECT 	        CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachSelect
        JOIN            _ReferralProdReport.dbo.Person ON _ReferralProdReport.dbo.Person.PersonID = #_Temp_Referral_ApproachSelect.ReferralApproachedByPersonID
	WHERE	        (ReferralApproachTypeID = 6)
	AND		PersonLast LIKE '%*'

	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		YearID = @YearID
	AND		MonthID = @MonthID

/****************************************************************************************************************************************************************************************/
	-- A_FamilyInitiated_Approached_NonDR  Count
/****************************************************************************************************************************************************************************************/
	UPDATE	#_Temp_Referral_ApproachCount
	SET		A_FamilyInitiated_Approached_NonDR = CountTable.ReferralCount
	FROM		
	(
	SELECT 	        CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachSelect
        JOIN            _ReferralProdReport.dbo.Person ON _ReferralProdReport.dbo.Person.PersonID = #_Temp_Referral_ApproachSelect.ReferralApproachedByPersonID
	WHERE	        (ReferralApproachTypeID = 6)
	AND		PersonLast NOT LIKE '%*'

	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		YearID = @YearID
	AND		MonthID = @MonthID

/****************************************************************************************************************************************************************************************/
	-- Transfer to table
/****************************************************************************************************************************************************************************************/

	-- Delete any records for the given month and year
	DELETE 	Referral_ApproachCount
	WHERE 	MonthID = @MonthID
	AND		YearID = @YearID

	--Update the count statistics
	INSERT INTO Referral_ApproachCount
	SELECT * FROM #_Temp_Referral_ApproachCount
	ORDER BY YearID, MonthID, SourceCodeID, OrganizationID

	--Select * from #_Temp_Referral_ApproachCount
	DROP TABLE #_Temp_Referral_ApproachCount
        DROP TABLE #_Temp_Referral_ApproachSelect





GO