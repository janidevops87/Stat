SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Referral_AppropriateReasonCount]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spi_Referral_AppropriateReasonCount]
GO

/******************************************************************************
**		File: spi_Referral_AppropriateReasonCount.sql
**		Name: spi_Referral_AppropriateReasonCount
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


CREATE   PROCEDURE [dbo].[spi_Referral_AppropriateReasonCount]

	@MonthID	int,
	@YearID		int


AS
/******************************************************************************
**		File: spi_Referral_AppropriateReasonCount.sql
**		Name: spi_Referral_AppropriateReasonCount
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
**      11/17/2006	ccarroll		added No Neuro Injury
**		08/01/2010	ccarroll		Updated from Production
*******************************************************************************/

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
DECLARE

	@ReferralCount		int,
	@ReasonID		int,
	@DayLightStartDate   	datetime,
   	@DayLightEndDate     	datetime,

	@strSelectLine		varchar(8000),
	@strSelectLine2		varchar(8000),
	@strTemp		varchar(2000)
	

     Exec spf_GetDayLightDates @YearID, @DayLightStartDate OUTPUT, @DayLightEndDate OUTPUT
	
	--Create the temp table
	CREATE TABLE #_Temp_Referral_AppropriateReasonCount 
	(
	[YearID] [int] NULL ,
	[MonthID] [int] NULL ,
	[SourceCodeID] [int] NOT NULL ,
	[OrganizationID] [int] NULL ,
	[AllTypes] [int] NULL ,
	[AppropriateOrgan] [int] NULL Default(0) ,
	[AppropriateBone] [int] NULL Default(0) ,
	[AppropriateTissue] [int] NULL Default(0) ,
	[AppropriateSkin] [int] NULL Default(0) ,
	[AppropriateValves] [int] NULL Default(0) ,
	[AppropriateEyes] [int] NULL Default(0) ,
	[AppropriateOther] [int] NULL Default(0) ,
	[AppropriateAllTissue] [int] NULL Default(0) ,

	[AppropriateOrganUnAppropriate] [int] NULL Default(0) ,
	[AppropriateBoneUnAppropriate] [int] NULL Default(0) ,
	[AppropriateTissueUnAppropriate] [int] NULL Default(0) ,
	[AppropriateSkinUnAppropriate] [int] NULL Default(0) ,
	[AppropriateValvesUnAppropriate] [int] NULL Default(0) ,
	[AppropriateEyesUnAppropriate] [int] NULL Default(0) ,
	[AppropriateOtherUnAppropriate] [int] NULL Default(0) ,
	[AppropriateAllTissueUnAppropriate] [int] NULL Default(0) ,

	[AppropriateOrganAge] [int] NULL Default(0) ,
	[AppropriateBoneAge] [int] NULL Default(0) ,
	[AppropriateTissueAge] [int] NULL Default(0) ,
	[AppropriateSkinAge] [int] NULL Default(0) ,
	[AppropriateValvesAge] [int] NULL Default(0) ,
	[AppropriateEyesAge] [int] NULL Default(0) ,
	[AppropriateOtherAge] [int] NULL Default(0) ,
	[AppropriateAllTissueAge] [int] NULL Default(0) ,

	[AppropriateOrganHighRisk] [int] NULL Default(0) ,
	[AppropriateBoneHighRisk] [int] NULL Default(0) ,
	[AppropriateTissueHighRisk] [int] NULL Default(0) ,
	[AppropriateSkinHighRisk] [int] NULL Default(0) ,
	[AppropriateValvesHighRisk] [int] NULL Default(0) ,
	[AppropriateEyesHighRisk] [int] NULL Default(0) ,
	[AppropriateOtherHighRisk] [int] NULL Default(0) ,
	[AppropriateAllTissueHighRisk] [int] NULL Default(0) ,

	[AppropriateOrganMedRO] [int] NULL Default(0) ,
	[AppropriateBoneMedRO] [int] NULL Default(0) ,
	[AppropriateTissueMedRO] [int] NULL Default(0) ,
	[AppropriateSkinMedRO] [int] NULL Default(0) ,
	[AppropriateValvesMedRO] [int] NULL Default(0) ,
	[AppropriateEyesMedRO] [int] NULL Default(0) ,
	[AppropriateOtherMedRO] [int] NULL Default(0) ,
	[AppropriateAllTissueMedRO] [int] NULL Default(0) ,

	[AppropriateOrganNotAppropriate] [int] NULL Default(0) ,
	[AppropriateBoneNotAppropriate] [int] NULL Default(0) ,
	[AppropriateTissueNotAppropriate] [int] NULL Default(0) ,
	[AppropriateSkinNotAppropriate] [int] NULL Default(0) ,
	[AppropriateValvesNotAppropriate] [int] NULL Default(0) ,
	[AppropriateEyesNotAppropriate] [int] NULL Default(0) ,
	[AppropriateOtherNotAppropriate] [int] NULL Default(0) ,
	[AppropriateAllTissueNotAppropriate] [int] NULL Default(0) ,

	[AppropriateOrganPreviousVent] [int] NULL Default(0) ,
	[AppropriateBonePreviousVent] [int] NULL Default(0) ,
	[AppropriateTissuePreviousVent] [int] NULL Default(0) ,
	[AppropriateSkinPreviousVent] [int] NULL Default(0) ,
	[AppropriateValvesPreviousVent] [int] NULL Default(0) ,
	[AppropriateEyesPreviousVent] [int] NULL Default(0) ,
	[AppropriateOtherPreviousVent] [int] NULL Default(0) ,
	[AppropriateAllTissuePreviousVent] [int] NULL Default(0) ,
	[AppropriateRO] [int] NULL Default(0),

	--10/30/01 drh
	[AppropriateOrganReg] [int] NULL Default(0) ,
	[AppropriateBoneReg] [int] NULL Default(0) ,
	[AppropriateTissueReg] [int] NULL Default(0) ,
	[AppropriateSkinReg] [int] NULL Default(0) ,
	[AppropriateValvesReg] [int] NULL Default(0) ,
	[AppropriateEyesReg] [int] NULL Default(0) ,
	[AppropriateOtherReg] [int] NULL Default(0) ,
	[AppropriateAllTissueReg] [int] NULL Default(0) ,

	--10/30/01 drh
	[AppropriateOrganNReg] [int] NULL Default(0) ,
	[AppropriateBoneNReg] [int] NULL Default(0) ,
	[AppropriateTissueNReg] [int] NULL Default(0) ,
	[AppropriateSkinNReg] [int] NULL Default(0) ,
	[AppropriateValvesNReg] [int] NULL Default(0) ,
	[AppropriateEyesNReg] [int] NULL Default(0) ,
	[AppropriateOtherNReg] [int] NULL Default(0) ,
	[AppropriateAllTissueNReg] [int] NULL Default(0),
	--2/11/02 drh
	--[RegisteredRO] [int] NULL Default(0)

	--ccarroll 11/17/2006 added No Neuro Injury
	[AppropriateOrganNoNeuroInjury] [int] NULL Default(0) ,
	[AppropriateBoneNoNeuroInjury] [int] NULL Default(0) ,
	[AppropriateTissueNoNeuroInjury] [int] NULL Default(0) ,
	[AppropriateSkinNoNeuroInjury] [int] NULL Default(0) ,
	[AppropriateValvesNoNeuroInjury] [int] NULL Default(0) ,
	[AppropriateEyesNoNeuroInjury] [int] NULL Default(0) ,
	[AppropriateOtherNoNeuroInjury] [int] NULL Default(0) ,
	[AppropriateAllTissueNoNeuroInjury] [int] NULL Default(0) 

	)






CREATE TABLE #_Temp_Referral_AppropriateReasonSelect
   (
   [CallSourceCodeID] [int] NULL , 
   [ReferralCallerOrganizationID][int] NULL, 
   [ReferralID][int] NULL, 
   [ReferralOrganAppropriateID][int] NULL,
   [ReferralBoneAppropriateID][int] NULL,
   [ReferralTissueAppropriateID][int] NULL,
   [ReferralSkinAppropriateID][int] NULL,
   [ReferralValvesAppropriateID][int] NULL,
   [ReferralEyesTransAppropriateID][int] NULL,
   [ReferralEyesRschAppropriateID][int] NULL,
   [DonorRegistryType][int] NULL,
	-- 9/20/04 - SAP
	[RegistryStatus][int] NULL
   )
	--Clean temp table
	TRUNCATE TABLE  #_Temp_Referral_AppropriateReasonCount

--Store TimeZone CASE string
exec spf_tzCase 'TimeZoneAbbreviation','CallDateTime', @DayLightStartDate, @DayLightEndDate, @strTemp OUTPUT

	--Get the list of organizations
	set @strSelectLine = 'INSERT INTO #_Temp_Referral_AppropriateReasonCount'
	set @strSelectLine = @strSelectLine + ' (YearID, MonthID, SourceCodeID, OrganizationID)'
	set @strSelectLine = @strSelectLine + ' SELECT DISTINCT DATEPART(yyyy, DATEADD(hour, '+@strTemp+', CallDateTime)) AS YearID,'
	set @strSelectLine = @strSelectLine + ' DATEPART(m, DATEADD(hour, '+@strTemp+', CallDateTime)) AS MonthID,'
	set @strSelectLine = @strSelectLine + ' _ReferralProdReport.dbo.Call.SourceCodeID,'	
	set @strSelectLine = @strSelectLine + ' ReferralCallerOrganizationID'

	set @strSelectLine = @strSelectLine + '	FROM _ReferralProdReport.dbo.Call'
	set @strSelectLine = @strSelectLine + '	JOIN _ReferralProdReport.dbo.Referral ON _ReferralProdReport.dbo.Referral.CallID = _ReferralProdReport.dbo.Call.CallID'
	set @strSelectLine = @strSelectLine + '	JOIN _ReferralProdReport.dbo.SourceCode ON _ReferralProdReport.dbo.Call.SourceCodeID = _ReferralProdReport.dbo.SourceCode.SourceCodeID'
	set @strSelectLine = @strSelectLine + '	JOIN _ReferralProdReport.dbo.Organization ON _ReferralProdReport.dbo.Referral.ReferralCallerOrganizationID = _ReferralProdReport.dbo.Organization.OrganizationID'
	set @strSelectLine = @strSelectLine + '	JOIN _ReferralProdReport.dbo.TimeZone ON _ReferralProdReport.dbo.Organization.TimeZoneID = _ReferralProdReport.dbo.TimeZone.TimeZoneID'

	set @strSelectLine2 = '	WHERE DATEPART(yyyy, DATEADD(hour, '+@strTemp+', CallDateTime)) = '+ltrim(str(@YearID))
	set @strSelectLine2 = @strSelectLine2 + ' AND DATEPART(m, DATEADD(hour, '+ @strTemp + ', CallDateTime)) = ' + ltrim(str(@MonthID))

	set @strSelectLine2 = @strSelectLine2 + ' ORDER BY _ReferralProdReport.dbo.Call.SourceCodeID, ReferralCallerOrganizationID'

	EXEC(@strSelectLine+@strSelectLine2)


        --Build a TempTable
            --Clean #_Temp_Referral_AgeSelect
             TRUNCATE TABLE  #_Temp_Referral_AppropriateReasonSelect
            --Insert Data into #_Temp_Referral_AgeSelect based on agerange, gender, month and year
	set @strSelectLine = 'INSERT #_Temp_Referral_AppropriateReasonSelect'
	set @strSelectLine = @strSelectLine + ' (CallSourceCodeID, ReferralCallerOrganizationID, ReferralID, ReferralOrganAppropriateID, ReferralBoneAppropriateID, ReferralTissueAppropriateID, ReferralSkinAppropriateID, ReferralValvesAppropriateID, ReferralEyesTransAppropriateID, ReferralEyesRschAppropriateID, DonorRegistryType, RegistryStatus)'
	set @strSelectLine = @strSelectLine + ' SELECT  _ReferralProdReport.dbo.Call.SourceCodeID, ReferralCallerOrganizationID, ReferralID, ReferralOrganAppropriateID, ReferralBoneAppropriateID, ReferralTissueAppropriateID, ReferralSkinAppropriateID, ReferralValvesAppropriateID, ReferralEyesTransAppropriateID, ReferralEyesRschAppropriateID, isnull(DonorRegistryType, 0) as DonorRegistryType,'
	set @strSelectLine = @strSelectLine + ' CASE _ReferralProdReport.dbo.RegistryStatus.RegistryStatus WHEN 1 THEN 1 WHEN 2 THEN 2 WHEN 4 THEN 4 ELSE 0 END AS RegistryStatus'
	set @strSelectLine = @strSelectLine + '	FROM _ReferralProdReport.dbo.Referral'
	set @strSelectLine = @strSelectLine + '	JOIN _ReferralProdReport.dbo.Call ON _ReferralProdReport.dbo.Call.CallID = _ReferralProdReport.dbo.Referral.CallID'
	set @strSelectLine = @strSelectLine + '	JOIN _ReferralProdReport.dbo.SourceCode ON _ReferralProdReport.dbo.Call.SourceCodeID = _ReferralProdReport.dbo.SourceCode.SourceCodeID'
	set @strSelectLine = @strSelectLine + '	JOIN _ReferralProdReport.dbo.Organization ON _ReferralProdReport.dbo.Referral.ReferralCallerOrganizationID = _ReferralProdReport.dbo.Organization.OrganizationID'
	set @strSelectLine = @strSelectLine + '	JOIN _ReferralProdReport.dbo.TimeZone ON _ReferralProdReport.dbo.Organization.TimeZoneID = _ReferralProdReport.dbo.TimeZone.TimeZoneID'
	set @strSelectLine = @strSelectLine + '	LEFT JOIN _ReferralProdReport.dbo.RegistryStatus ON _ReferralProdReport.dbo.Referral.CallId = _ReferralProdReport.dbo.RegistryStatus.CallId'

	set @strSelectLine2 = '	WHERE DATEPART(yyyy, DATEADD(hour, '+@strTemp+', CallDateTime)) = '+ltrim(str(@YearID))
	set @strSelectLine2 = @strSelectLine2 + ' AND DATEPART(m, DATEADD(hour, '+ @strTemp + ', CallDateTime)) = ' + ltrim(str(@MonthID))

	EXEC(@strSelectLine+@strSelectLine2)


-------------------------------------------------Begin Appropiate------------------------------------------------------------

SET @ReasonID = 1
	-- update the count stats

--**************************************************************************************************************************************************************************************
	-- AppropriateOrgan
--**************************************************************************************************************************************************************************************

	UPDATE		#_Temp_Referral_AppropriateReasonCount

	SET		AppropriateOrgan = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_AppropriateReasonSelect
	WHERE		ReferralOrganAppropriateID = @ReasonID
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID


--**************************************************************************************************************************************************************************************
	-- AppropriateBone
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_AppropriateReasonCount
	SET		AppropriateBone = CountTable.ReferralCount
	FROM		
	(
	SELECT 		 CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_AppropriateReasonSelect
	WHERE		ReferralBoneAppropriateID = @ReasonID
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- AppropriateTissue
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_AppropriateReasonCount
	SET		AppropriateTissue = CountTable.ReferralCount
	FROM		
	(
	SELECT 		 CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_AppropriateReasonSelect
	WHERE		ReferralTissueAppropriateID = @ReasonID
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- AppropriateSkin
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_AppropriateReasonCount
	SET		AppropriateSkin = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_AppropriateReasonSelect
	WHERE		ReferralSkinAppropriateID = @ReasonID
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- AppropriateValves 
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_AppropriateReasonCount
	SET		AppropriateValves = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_AppropriateReasonSelect
	WHERE		ReferralValvesAppropriateID = @ReasonID
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- AppropriateEyes

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_AppropriateReasonCount
	SET		AppropriateEyes = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_AppropriateReasonSelect
	WHERE		ReferralEyesTransAppropriateID = @ReasonID
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- AppropriateOther

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_AppropriateReasonCount
	SET		AppropriateOther = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_AppropriateReasonSelect
	WHERE		ReferralEyesRschAppropriateID = @ReasonID
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- AppropriateAllTissue
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_AppropriateReasonCount
	SET		AppropriateAllTissue = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_AppropriateReasonSelect
	WHERE		(ReferralBoneAppropriateID = @ReasonID
	OR		ReferralTissueAppropriateID = @ReasonID
	OR		ReferralSkinAppropriateID = @ReasonID
	OR		ReferralValvesAppropriateID = @ReasonID)
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- AppropriateOrganReg
--**************************************************************************************************************************************************************************************

	UPDATE		#_Temp_Referral_AppropriateReasonCount

	SET		AppropriateOrganReg = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_AppropriateReasonSelect
	WHERE		ReferralOrganAppropriateID = @ReasonID
	AND			(DonorRegistryType IN(1, 2)
	OR				RegistryStatus > 0)
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND		OrganizationID = CountTable.ReferralCallerOrganizationID


--**************************************************************************************************************************************************************************************
	-- AppropriateBoneReg
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_AppropriateReasonCount
	SET		AppropriateBoneReg = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_AppropriateReasonSelect
	WHERE		ReferralBoneAppropriateID = @ReasonID
	AND			(DonorRegistryType IN(1, 2)
	OR				RegistryStatus > 0)
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- AppropriateTissueReg
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_AppropriateReasonCount
	SET		AppropriateTissueReg = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_AppropriateReasonSelect
	WHERE		ReferralTissueAppropriateID = @ReasonID
	AND			(DonorRegistryType IN(1, 2)
	OR				RegistryStatus > 0)
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- AppropriateSkinReg
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_AppropriateReasonCount
	SET		AppropriateSkinReg = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_AppropriateReasonSelect
	WHERE		ReferralSkinAppropriateID = @ReasonID
	AND			(DonorRegistryType IN(1, 2)
	OR				RegistryStatus > 0)
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- AppropriateValvesReg
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_AppropriateReasonCount
	SET		AppropriateValvesReg = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_AppropriateReasonSelect
	WHERE		ReferralValvesAppropriateID = @ReasonID
	AND			(DonorRegistryType IN(1, 2)
	OR				RegistryStatus > 0)
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- AppropriateEyesReg

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_AppropriateReasonCount
	SET		AppropriateEyesReg = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_AppropriateReasonSelect
	WHERE		ReferralEyesTransAppropriateID = @ReasonID
	AND			(DonorRegistryType IN(1, 2)
	OR				RegistryStatus > 0)
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- AppropriateOtherReg

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_AppropriateReasonCount
	SET		AppropriateOtherReg = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_AppropriateReasonSelect
	WHERE		ReferralEyesRschAppropriateID = @ReasonID
	AND			(DonorRegistryType IN(1, 2)
	OR				RegistryStatus > 0)
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- AppropriateAllTissueReg
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_AppropriateReasonCount
	SET		AppropriateAllTissueReg = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_AppropriateReasonSelect
	WHERE		(ReferralBoneAppropriateID = @ReasonID
	OR		ReferralTissueAppropriateID = @ReasonID
	OR		ReferralSkinAppropriateID = @ReasonID
	OR		ReferralValvesAppropriateID = @ReasonID)
	AND			(DonorRegistryType IN(1, 2)
	OR				RegistryStatus > 0)
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- AppropriateOrganNReg
--**************************************************************************************************************************************************************************************

	UPDATE		#_Temp_Referral_AppropriateReasonCount

	SET		AppropriateOrganNReg = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_AppropriateReasonSelect
	WHERE		ReferralOrganAppropriateID = @ReasonID
	AND			DonorRegistryType NOT IN(1, 2)
	AND			RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND		OrganizationID = CountTable.ReferralCallerOrganizationID


--**************************************************************************************************************************************************************************************
	-- AppropriateBoneNReg
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_AppropriateReasonCount
	SET		AppropriateBoneNReg = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_AppropriateReasonSelect
	WHERE		ReferralBoneAppropriateID = @ReasonID
	AND			DonorRegistryType NOT IN(1, 2)
	AND			RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- AppropriateTissueNReg
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_AppropriateReasonCount
	SET		AppropriateTissueNReg = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_AppropriateReasonSelect
	WHERE		ReferralTissueAppropriateID = @ReasonID
	AND			DonorRegistryType NOT IN(1, 2)
	AND			RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- AppropriateSkinNReg
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_AppropriateReasonCount
	SET		AppropriateSkinNReg = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_AppropriateReasonSelect
	WHERE		ReferralSkinAppropriateID = @ReasonID
	AND			DonorRegistryType NOT IN(1, 2)
	AND			RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- AppropriateValvesNReg
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_AppropriateReasonCount
	SET		AppropriateValvesNReg = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_AppropriateReasonSelect
	WHERE		ReferralValvesAppropriateID = @ReasonID
	AND			DonorRegistryType NOT IN(1, 2)
	AND			RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- AppropriateEyesNReg

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_AppropriateReasonCount
	SET		AppropriateEyesNReg = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_AppropriateReasonSelect
	WHERE		ReferralEyesTransAppropriateID = @ReasonID
	AND			DonorRegistryType NOT IN(1, 2)
	AND			RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- AppropriateOtherNReg

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_AppropriateReasonCount
	SET		AppropriateOtherNReg = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_AppropriateReasonSelect
	WHERE		ReferralEyesRschAppropriateID = @ReasonID
	AND			DonorRegistryType NOT IN(1, 2)
	AND			RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID

	AND		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- AppropriateAllTissueNReg
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_AppropriateReasonCount
	SET		AppropriateAllTissueNReg = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_AppropriateReasonSelect
	WHERE		(ReferralBoneAppropriateID = @ReasonID
	OR		ReferralTissueAppropriateID = @ReasonID
	OR		ReferralSkinAppropriateID = @ReasonID
	OR		ReferralValvesAppropriateID = @ReasonID)
	AND			DonorRegistryType NOT IN(1, 2)
	AND			RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND		OrganizationID = CountTable.ReferralCallerOrganizationID

--------------------------------------------------End Appropriate-------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------Begin UnAppropriate-----------------------------------------------------------------

	SET @ReasonID = 1
--**************************************************************************************************************************************************************************************
	-- AppropriateOrganUnAppropriate
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_AppropriateReasonCount
	SET		AppropriateOrganUnAppropriate = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_AppropriateReasonSelect
	WHERE		ReferralOrganAppropriateID <> @ReasonID
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND		OrganizationID = CountTable.ReferralCallerOrganizationID
	
--**************************************************************************************************************************************************************************************
	-- AppropriateBoneUnAppropriate
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_AppropriateReasonCount
	SET		AppropriateBoneUnAppropriate = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_AppropriateReasonSelect
	WHERE		ReferralBoneAppropriateID <> @ReasonID
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- AppropriateTissueUnAppropriate
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_AppropriateReasonCount
	SET		AppropriateTissueUnAppropriate = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_AppropriateReasonSelect
	WHERE		ReferralTissueAppropriateID <> @ReasonID
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- AppropriateSkinUnAppropriate
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_AppropriateReasonCount
	SET		AppropriateSkinUnAppropriate = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_AppropriateReasonSelect
	WHERE		ReferralSkinAppropriateID <> @ReasonID
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- AppropriateValvesUnAppropriate 
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_AppropriateReasonCount
	SET		AppropriateValvesUnAppropriate = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_AppropriateReasonSelect
	WHERE		ReferralValvesAppropriateID <> @ReasonID
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- AppropriateEyesUnAppropriate

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_AppropriateReasonCount
	SET		AppropriateEyesUnAppropriate = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_AppropriateReasonSelect
	WHERE		ReferralEyesTransAppropriateID <> @ReasonID
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- AppropriateOtherUnAppropriate

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_AppropriateReasonCount
	SET		AppropriateOtherUnAppropriate = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_AppropriateReasonSelect
	WHERE		ReferralEyesRschAppropriateID <> @ReasonID
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- AppropriateAllTissueUnAppropriate
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_AppropriateReasonCount
	SET		AppropriateAllTissueUnAppropriate = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_AppropriateReasonSelect
	WHERE		(ReferralBoneAppropriateID <> @ReasonID
	OR		ReferralTissueAppropriateID <> @ReasonID
	OR		ReferralSkinAppropriateID <> @ReasonID
	OR		ReferralValvesAppropriateID <> @ReasonID)
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND		OrganizationID = CountTable.ReferralCallerOrganizationID

--------------------------------------------------------End UnAppropriate----------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------Begin Age-----------------------------------------------------------------

	SET @ReasonID = 2
--**************************************************************************************************************************************************************************************
	-- AppropriateOrganAge
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_AppropriateReasonCount
	SET		AppropriateOrganAge = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_AppropriateReasonSelect
	WHERE		ReferralOrganAppropriateID = @ReasonID
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND		OrganizationID = CountTable.ReferralCallerOrganizationID
	
--**************************************************************************************************************************************************************************************
	-- AppropriateBoneAge
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_AppropriateReasonCount
	SET		AppropriateBoneAge = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_AppropriateReasonSelect
	WHERE		ReferralBoneAppropriateID = @ReasonID
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- AppropriateTissueAge
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_AppropriateReasonCount
	SET		AppropriateTissueAge = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_AppropriateReasonSelect
	WHERE		ReferralTissueAppropriateID = @ReasonID
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- AppropriateSkinAge
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_AppropriateReasonCount
	SET		AppropriateSkinAge = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_AppropriateReasonSelect
	WHERE		ReferralSkinAppropriateID = @ReasonID
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- AppropriateValvesAge 
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_AppropriateReasonCount
	SET		AppropriateValvesAge = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_AppropriateReasonSelect
	WHERE		ReferralValvesAppropriateID = @ReasonID
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- AppropriateEyesAge

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_AppropriateReasonCount
	SET		AppropriateEyesAge = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_AppropriateReasonSelect
	WHERE		ReferralEyesTransAppropriateID = @ReasonID
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- AppropriateOtherAge

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_AppropriateReasonCount
	SET		AppropriateOtherAge = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_AppropriateReasonSelect
	WHERE		ReferralEyesRschAppropriateID = @ReasonID

	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- AppropriateAllTissueAge
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_AppropriateReasonCount
	SET		AppropriateAllTissueAge = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_AppropriateReasonSelect
	WHERE		(ReferralBoneAppropriateID = @ReasonID
	OR		ReferralTissueAppropriateID = @ReasonID
	OR		ReferralSkinAppropriateID = @ReasonID
	OR		ReferralValvesAppropriateID = @ReasonID)
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND		OrganizationID = CountTable.ReferralCallerOrganizationID

--------------------------------------------------------End Age----------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------Begin HighRisk----------------------------------------------------------

	SET @ReasonID = 3

--**************************************************************************************************************************************************************************************
	-- AppropriateOrganHighRisk
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_AppropriateReasonCount
	SET		AppropriateOrganHighRisk = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_AppropriateReasonSelect
	WHERE		ReferralOrganAppropriateID = @ReasonID
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- AppropriateBoneHighRisk
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_AppropriateReasonCount
	SET		AppropriateBoneHighRisk = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_AppropriateReasonSelect
	WHERE		ReferralBoneAppropriateID = @ReasonID
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- AppropriateTissueHighRisk
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_AppropriateReasonCount
	SET		AppropriateTissueHighRisk = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_AppropriateReasonSelect
	WHERE		ReferralTissueAppropriateID = @ReasonID
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- AppropriateSkinHighRisk
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_AppropriateReasonCount
	SET		AppropriateSkinHighRisk = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_AppropriateReasonSelect
	WHERE		ReferralSkinAppropriateID = @ReasonID
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- AppropriateValvesHighRisk 
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_AppropriateReasonCount
	SET		AppropriateValvesHighRisk = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_AppropriateReasonSelect
	WHERE		ReferralValvesAppropriateID = @ReasonID
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- AppropriateEyesHighRisk

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_AppropriateReasonCount
	SET		AppropriateEyesHighRisk = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_AppropriateReasonSelect
	WHERE		ReferralEyesTransAppropriateID = @ReasonID
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- AppropriateOtherHighRisk

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_AppropriateReasonCount
	SET		AppropriateOtherHighRisk = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_AppropriateReasonSelect
	WHERE		ReferralEyesRschAppropriateID = @ReasonID
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- AppropriateAllTissueHighRisk
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_AppropriateReasonCount
	SET		AppropriateAllTissueHighRisk = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_AppropriateReasonSelect
	WHERE		(ReferralBoneAppropriateID = @ReasonID
	OR		ReferralTissueAppropriateID = @ReasonID
	OR		ReferralSkinAppropriateID = @ReasonID
	OR		ReferralValvesAppropriateID = @ReasonID)
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND		OrganizationID = CountTable.ReferralCallerOrganizationID

--------------------------------End HighRisk-------------------------------------------------------------
---------------------------------------------------------------------------------------------------------
--------------------------------Begin MedRO--------------------------------------------------------------

	SET @ReasonID = 4
--**************************************************************************************************************************************************************************************
	-- AppropriateOrganMedRO
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_AppropriateReasonCount
	SET		AppropriateOrganMedRO = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_AppropriateReasonSelect
	WHERE		ReferralOrganAppropriateID = @ReasonID
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND		OrganizationID = CountTable.ReferralCallerOrganizationID
	
--**************************************************************************************************************************************************************************************
	-- AppropriateBoneMedRO
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_AppropriateReasonCount
	SET		AppropriateBoneMedRO = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_AppropriateReasonSelect
	WHERE		ReferralBoneAppropriateID = @ReasonID
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- AppropriateTissueMedRO
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_AppropriateReasonCount
	SET		AppropriateTissueMedRO = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_AppropriateReasonSelect
	WHERE		ReferralTissueAppropriateID = @ReasonID
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- AppropriateSkinMedRO
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_AppropriateReasonCount
	SET		AppropriateSkinMedRO = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_AppropriateReasonSelect
	WHERE		ReferralSkinAppropriateID = @ReasonID
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND		OrganizationID = CountTable.ReferralCallerOrganizationID
		
--**************************************************************************************************************************************************************************************
	-- AppropriateValvesMedRO 
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_AppropriateReasonCount
	SET		AppropriateValvesMedRO = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_AppropriateReasonSelect
	WHERE		ReferralValvesAppropriateID = @ReasonID
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- AppropriateEyesMedRO

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_AppropriateReasonCount
	SET		AppropriateEyesMedRO = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_AppropriateReasonSelect
	WHERE		ReferralEyesTransAppropriateID = @ReasonID
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- AppropriateOtherMedRO

--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_AppropriateReasonCount
	SET		AppropriateOtherMedRO = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_AppropriateReasonSelect
	WHERE		ReferralEyesRschAppropriateID = @ReasonID
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- AppropriateAllTissueMedRO
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_AppropriateReasonCount
	SET		AppropriateAllTissueMedRO = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_AppropriateReasonSelect
	WHERE		(ReferralBoneAppropriateID = @ReasonID
	OR		ReferralTissueAppropriateID = @ReasonID
	OR		ReferralSkinAppropriateID = @ReasonID
	OR		ReferralValvesAppropriateID = @ReasonID)
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND		OrganizationID = CountTable.ReferralCallerOrganizationID

--------------------------------End MedRO-----------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------
--------------------------------Begin NotAppropriate-------------------------------------------------------

	SET @ReasonID = 5
--**************************************************************************************************************************************************************************************
	-- AppropriateOrganNotAppropriate
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_AppropriateReasonCount
	SET		AppropriateOrganNotAppropriate = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_AppropriateReasonSelect
	WHERE		ReferralOrganAppropriateID = @ReasonID
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND		OrganizationID = CountTable.ReferralCallerOrganizationID
	
--**************************************************************************************************************************************************************************************
	-- AppropriateBoneNotAppropriate
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_AppropriateReasonCount
	SET		AppropriateBoneNotAppropriate = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_AppropriateReasonSelect
	WHERE		ReferralBoneAppropriateID = @ReasonID
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- AppropriateTissueNotAppropriate
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_AppropriateReasonCount
	SET		AppropriateTissueNotAppropriate = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_AppropriateReasonSelect
	WHERE		ReferralTissueAppropriateID = @ReasonID
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- AppropriateSkinNotAppropriate
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_AppropriateReasonCount
	SET		AppropriateSkinNotAppropriate = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_AppropriateReasonSelect
	WHERE		ReferralSkinAppropriateID = @ReasonID
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- AppropriateValvesNotAppropriate 
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_AppropriateReasonCount
	SET		AppropriateValvesNotAppropriate = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_AppropriateReasonSelect
	WHERE		ReferralValvesAppropriateID = @ReasonID
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- AppropriateEyesNotAppropriate

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_AppropriateReasonCount
	SET		AppropriateEyesNotAppropriate = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_AppropriateReasonSelect
	WHERE		ReferralEyesTransAppropriateID = @ReasonID
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- AppropriateOtherNotAppropriate

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_AppropriateReasonCount
	SET		AppropriateOtherNotAppropriate = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_AppropriateReasonSelect
	WHERE		ReferralEyesRschAppropriateID = @ReasonID
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- AppropriateAllTissueNotAppropriate
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_AppropriateReasonCount
	SET		AppropriateAllTissueNotAppropriate = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_AppropriateReasonSelect
	WHERE		(ReferralBoneAppropriateID = @ReasonID
	OR		ReferralTissueAppropriateID = @ReasonID
	OR		ReferralSkinAppropriateID = @ReasonID
	OR		ReferralValvesAppropriateID = @ReasonID)
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND		OrganizationID = CountTable.ReferralCallerOrganizationID

--------------------------------End NotAppropriate----------------------------------------------------------
------------------------------------------------------------------------------------------------------------
--------------------------------Begin PreviousVent----------------------------------------------------------

	SET @ReasonID = 6
--**************************************************************************************************************************************************************************************
	-- AppropriateOrganPreviousVent
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_AppropriateReasonCount
	SET		AppropriateOrganPreviousVent = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_AppropriateReasonSelect
	WHERE		ReferralOrganAppropriateID = @ReasonID
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND		OrganizationID = CountTable.ReferralCallerOrganizationID
	
--**************************************************************************************************************************************************************************************
	-- AppropriateBonePreviousVent
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_AppropriateReasonCount
	SET		AppropriateBonePreviousVent = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_AppropriateReasonSelect
	WHERE		ReferralBoneAppropriateID = @ReasonID
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- AppropriateTissuePreviousVent
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_AppropriateReasonCount
	SET		AppropriateTissuePreviousVent = CountTable.ReferralCount
	FROM		
	(

	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_AppropriateReasonSelect
	WHERE		ReferralTissueAppropriateID = @ReasonID
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- AppropriateSkinPreviousVent
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_AppropriateReasonCount
	SET		AppropriateSkinPreviousVent = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_AppropriateReasonSelect
	WHERE		ReferralSkinAppropriateID = @ReasonID
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- AppropriateValvesPreviousVent 
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_AppropriateReasonCount
	SET		AppropriateValvesPreviousVent = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_AppropriateReasonSelect
	WHERE		ReferralValvesAppropriateID = @ReasonID
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- AppropriateEyesPreviousVent

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_AppropriateReasonCount
	SET		AppropriateEyesPreviousVent = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_AppropriateReasonSelect
	WHERE		ReferralEyesTransAppropriateID = @ReasonID
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- AppropriateOtherPreviousVent

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_AppropriateReasonCount
	SET		AppropriateOtherPreviousVent = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_AppropriateReasonSelect
	WHERE		ReferralEyesRschAppropriateID = @ReasonID
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- AppropriateAllTissuePreviousVent
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_AppropriateReasonCount
	SET		AppropriateAllTissuePreviousVent = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_AppropriateReasonSelect
	WHERE		(ReferralBoneAppropriateID = @ReasonID
	OR		ReferralTissueAppropriateID = @ReasonID
	OR		ReferralSkinAppropriateID = @ReasonID
	OR		ReferralValvesAppropriateID = @ReasonID)
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND		OrganizationID = CountTable.ReferralCallerOrganizationID

--------------------------------End PreviousVent----------------------------------------------------------

--------------------------------Begin NoNeuroInjury----------------------------------------------------------
	--ccarroll 11/17/2006 added No Neuro Injury

	SET @ReasonID = 7
--**************************************************************************************************************************************************************************************
	-- AppropriateOrganNoNeuroInjury
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_AppropriateReasonCount
	SET		AppropriateOrganNoNeuroInjury = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_AppropriateReasonSelect
	WHERE		ReferralOrganAppropriateID = @ReasonID
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND		OrganizationID = CountTable.ReferralCallerOrganizationID
	
--**************************************************************************************************************************************************************************************
	-- AppropriateBoneNoNeuroInjury
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_AppropriateReasonCount
	SET		AppropriateBoneNoNeuroInjury = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_AppropriateReasonSelect
	WHERE		ReferralBoneAppropriateID = @ReasonID
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- AppropriateTissueNoNeuroInjury
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_AppropriateReasonCount
	SET		AppropriateTissueNoNeuroInjury = CountTable.ReferralCount
	FROM		
	(

	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_AppropriateReasonSelect
	WHERE		ReferralTissueAppropriateID = @ReasonID
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- AppropriateSkinNoNeuroInjury
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_AppropriateReasonCount
	SET		AppropriateSkinNoNeuroInjury = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_AppropriateReasonSelect
	WHERE		ReferralSkinAppropriateID = @ReasonID
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- AppropriateValvesNoNeuroInjury
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_AppropriateReasonCount
	SET		AppropriateValvesNoNeuroInjury = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_AppropriateReasonSelect
	WHERE		ReferralValvesAppropriateID = @ReasonID
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- AppropriateEyesNoNeuroInjury

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_AppropriateReasonCount
	SET		AppropriateEyesNoNeuroInjury = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_AppropriateReasonSelect
	WHERE		ReferralEyesTransAppropriateID = @ReasonID
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- AppropriateOtherNoNeuroInjury

--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_AppropriateReasonCount
	SET		AppropriateOtherNoNeuroInjury = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
 			Count(ReferralCallerOrganizationID) AS ReferralCount  
	FROM		#_Temp_Referral_AppropriateReasonSelect
	WHERE		ReferralEyesRschAppropriateID = @ReasonID
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- AppropriateAllTissueNoNeuroInjury
--**************************************************************************************************************************************************************************************
	UPDATE		#_Temp_Referral_AppropriateReasonCount
	SET		AppropriateAllTissueNoNeuroInjury = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_AppropriateReasonSelect
	WHERE		(ReferralBoneAppropriateID = @ReasonID
	OR		ReferralTissueAppropriateID = @ReasonID
	OR		ReferralSkinAppropriateID = @ReasonID
	OR		ReferralValvesAppropriateID = @ReasonID)
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND		OrganizationID = CountTable.ReferralCallerOrganizationID

--------------------------------End NoNeuroInjury----------------------------------------------------------

























--************************************************************************************************************************************************************************************
	-- AppropriateRO Rule Out
--***************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_AppropriateReasonCount
	SET		AppropriateRO = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 

			Count(ReferralCallerOrganizationID) AS ReferralCount 
	FROM		#_Temp_Referral_AppropriateReasonSelect
	WHERE		(ReferralOrganAppropriateID <> 1 
	AND		ReferralBoneAppropriateID <> 1
	AND		ReferralTissueAppropriateID <> 1
	AND		ReferralSkinAppropriateID <> 1
	AND		ReferralValvesAppropriateID <> 1
	AND		ReferralEyesTransAppropriateID <>1
	AND		ReferralEyesRschAppropriateID <>1)
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND	OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- Transfer to table Referral_AppropriateReasonCount
--***************************************************************************************************************************************************************************************

	-- Delete any records for the given month and year
	DELETE 	Referral_AppropriateReasonCount
	WHERE 	MonthID = @MonthID
	AND	YearID = @YearID

	--Update the count statistics
	INSERT INTO Referral_AppropriateReasonCount
	SELECT * FROM #_Temp_Referral_AppropriateReasonCount 
	ORDER BY YearID, MonthID, SourceCodeID, OrganizationID

	--Select * From #_Temp_Referral_AppropriateReasonCount
	DROP TABLE #_Temp_Referral_AppropriateReasonCount
        DROP TABLE #_Temp_Referral_AppropriateReasonSelect
/*
--**************************************************************************************************************************************************************************************
	-- All Referrals Count
--***************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_AppropriateReasonCount
	SET		AllTypes = CountTable.ReferralCount
	FROM		
	(
	SELECT 		ReferralCallerOrganizationID, 
			ReferralApproachedByPersonID,
			Count(ReferralApproachedByPersonID) AS ReferralCount
	FROM		#_Temp_Referral_AppropriateReasonSelect
	WHERE		ReferralCallerOrganizationID, ReferralApproachedByPersonID
	) AS CountTable
	WHERE		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		ApproachPersonID = CountTable.ReferralApproachedByPersonID

*/





GO


