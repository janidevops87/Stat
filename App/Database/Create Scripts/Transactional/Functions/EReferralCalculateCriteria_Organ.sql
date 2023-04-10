
IF EXISTS (SELECT * FROM sysobjects WHERE  name = 'EReferralCalculateCriteria_Organ')
	BEGIN
		PRINT 'Dropping Function EReferralCalculateCriteria_Organ'
		DROP Function EReferralCalculateCriteria_Organ
	END
GO

PRINT 'Creating Function EReferralCalculateCriteria_Organ' 
GO 

CREATE FUNCTION dbo.EReferralCalculateCriteria_Organ 
(
	@Age INT,
	@AgeUnit INT, 
	@Gender INT, 
	@Weight INT, 
	@HivId INT,
	@AidsId INT,
	@HepBId INT,
	@HepCId INT,
	@Ivdaid INT,
	@HeartbeatId INT,
	@Vented INT,
	@OrganizationId INT,
	@SourceCodeID INT 
)  
RETURNS @Approriate TABLE
(
	OrganAppropriateId INT,
	BoneAppropriateId INT,
	SoftTissueAppropriateId INT,
	SkinAppropriateId INT,
	ValvesAppropriateId INT,
	EyesAppropriateId INT,
	OtherAppropriateId INT,
	PreviousReferralTypeID INT,
	CurrentReferralTypeID INT
) 	
AS

BEGIN
	DECLARE
	@CriteriaStatusId INT = 1,
	@TriageServiceLevel INT,
	@OrganAgeAppropriate BIT = 1,
	@ServiceLevelId INT;
--Constants
	DECLARE
	@HIV VARCHAR(25) = 'HIV',
	@AIDS VARCHAR(25) = 'AIDS',
	@HEPB VARCHAR(25) = 'Hep B',
	@HEPC VARCHAR(25) = 'Hep C',
	@IVDA VARCHAR(25) = 'IVDA',
	@NOT_APPROPRIATE INT = 5,
	@PreviousVented INT = 6,
	@NOT_AGE_APPROPRIATE INT = 2,
	@MED_RO INT = 4,
	@HIGH_RISK INT = 3,
	@APPROPRIATE_YES INT = 1,
	@MALE INT = 1,
	@FEMALE INT = 2,
	@YES INT = 1,
	@NO INT = 0,
	@ORGAN_DONOR_CATEGORY INT = 1,
	@BONE_DONOR_CATEGORY INT = 2,
	@SOFTTISSUE_DONOR_CATEGORY INT = 3,
	@SKIN_DONOR_CATEGORY INT = 4,
	@VALVES_DONOR_CATEGORY INT = 5,
	@EYES_DONOR_CATEGORY INT = 6,
	@OTHER_DONOR_CATEGORY INT = 7,
	@VENT_PREVIOUSLY INT = 1;

	DECLARE @Category TABLE (
		DonorCategoryId int,
		AppropriateId int
	)
	DECLARE @Criteria TABLE(
		CriteriaId INT, 
		DonorCategoryID INT, 
		CriteriaMaleLowerAge SMALLINT, 
		CriteriaMaleLowerAgeUnit VARCHAR(6), 
		CriteriaMaleUpperAge SMALLINT, 
		CriteriaMaleUpperAgeUnit VARCHAR(6), 
		CriteriaMaleLowerWeight FLOAT, 
		CriteriaMaleLowerWeightUnit NVARCHAR(20), 
		CriteriaMaleUpperWeightUnit NVARCHAR(20) , 
		CriteriaMaleUpperWeight FLOAT, 
		CriteriaMaleNotAppropriate SMALLINT,
		CriteriaFemaleLowerAge SMALLINT, 
		CriteriaFemaleLowerAgeUnit VARCHAR(6), 
		CriteriaFemaleUpperAge SMALLINT, 
		CriteriaFemaleUpperAgeUnit VARCHAR(6), 
		CriteriaFemaleLowerWeight FLOAT, 
		CriteriaFemaleLowerWeightUnit VARCHAR(6), 
		CriteriaFemaleUpperWeightUnit VARCHAR(6), 
		CriteriaFemaleUpperWeight FLOAT, 
		CriteriaFemaleNotAppropriate SMALLINT,
		CriteriaLowerWeight FLOAT,
		CriteriaUpperWeight FLOAT
	)
	DECLARE @CriteriaIndication TABLE(
		DonorCategoryID INT, 
		IndicationName VARCHAR(80), 
		IndicationNote VARCHAR(255), 
		IndicationHighRisk INT 
	)

	

	/*
	Public Const VENT_ONLY As Short = 0
		Public Const AGE_ONLY As Short = 1
		Public Const VENT_AGE_ONLY As Short = 2
		Public Const VENT_AGE_MRO As Short = 3
	
		*/
	SELECT @ServiceLevelId = serviceLevelId,
		@TriageServiceLevel = servicelevelTriageLevel
	FROM serviceLevel 
	WHERE ServiceLevelId = (
	SELECT DISTINCT ServiceLevel30Organization.ServiceLevelID 
	FROM ServiceLevel30Organization 
	JOIN ServiceLevel ON ServiceLevel.ServiceLevelID = ServiceLevel30Organization.ServiceLevelID 
	JOIN ServiceLevelSourceCode ON ServiceLevelSourceCode.ServiceLevelID = ServiceLevel30Organization.ServiceLevelID 
	WHERE OrganizationID = @OrganizationId 
	AND ServiceLevelSourceCode.SourceCodeID = @SourceCodeId
	AND ServiceLevelStatus = 1)


	INSERT INTO @Criteria
	SELECT DISTINCT Criteria.CriteriaId, Criteria.DonorCategoryID, Criteria.CriteriaMaleLowerAge, Criteria.CriteriaMaleLowerAgeUnit, Criteria.CriteriaMaleUpperAge, Criteria.CriteriaMaleUpperAgeUnit, Criteria.CriteriaMaleLowerWeight, 
		Criteria.CriteriaMaleLowerWeightUnit, Criteria.CriteriaMaleUpperWeightUnit, Criteria.CriteriaMaleUpperWeight, Criteria.CriteriaMaleNotAppropriate,
		Criteria.CriteriaFemaleLowerAge, Criteria.CriteriaFemaleLowerAgeUnit, Criteria.CriteriaFemaleUpperAge, Criteria.CriteriaFemaleUpperAgeUnit, Criteria.CriteriaFemaleLowerWeight, 
		Criteria.CriteriaFemaleLowerWeightUnit, Criteria.CriteriaFemaleUpperWeightUnit, Criteria.CriteriaFemaleUpperWeight, Criteria.CriteriaFemaleNotAppropriate,
		Criteria.CriteriaLowerWeight, CriteriaUpperWeight
	FROM Criteria (nolock) 
	INNER JOIN CriteriaOrganization (nolock) ON Criteria.CriteriaID = CriteriaOrganization.CriteriaID 
	INNER JOIN CriteriaSourceCode (nolock) ON CriteriaSourceCode.CriteriaID = Criteria.CriteriaID 
	WHERE 
		CriteriaOrganization.OrganizationID = @OrganizationID
	AND CriteriaSourceCode.SourceCodeID = @SourceCodeID
	AND Criteria.CriteriaStatus = @CriteriaStatusID
	AND Criteria.DonorCategoryID >= 1 AND Criteria.DonorCategoryID <= 7

	--insert into category table the categories configured for the organizatioin and source code
	INSERT INTO @Category (DonorCategoryId)
	SELECT DonorCategoryID
	FROM @Criteria;

	--set organ -- if heartbeat = No, then set to not appropriate
	IF @HeartbeatId = 0
	BEGIN
	UPDATE @Category
	SET AppropriateId = @NOT_APPROPRIATE
	WHERE DonorCategoryId = @ORGAN_DONOR_CATEGORY;
	END
	ELSE IF @HeartbeatId = @NO AND @Vented = @VENT_PREVIOUSLY
	BEGIN
		UPDATE @Category
		SET AppropriateId = @PreviousVented
		WHERE DonorCategoryId = @ORGAN_DONOR_CATEGORY;
	END

	--First Criteria to look at is age
	IF @TriageServiceLevel > 0
	BEGIN
		UPDATE @Category
		SET AppropriateId = @NOT_APPROPRIATE
		FROM @Category t
		INNER JOIN @Criteria c ON t.DonorCategoryId = c.DonorCategoryID
		WHERE
		(@Gender = @MALE AND c.CriteriaMaleNotAppropriate = -1)
		OR (@Gender = @FEMALE AND c.CriteriaFemaleNotAppropriate = -1)
		AND t.AppropriateId IS NULL
	
	 
		UPDATE @Category 
		SET AppropriateId = @NOT_AGE_APPROPRIATE
		FROM @Category t
		INNER JOIN  @Criteria c on t.DonorCategoryId = c.DonorCategoryID
		WHERE
			(@Gender = @MALE AND @AgeUnit = 1 AND 
				((c.CriteriaMaleLowerAgeUnit = 'Years' AND CriteriaMaleLowerAge > @Age)
				OR
				(CriteriaMaleLowerAgeUnit = 'Months' AND CriteriaMaleLowerAge > (@Age * 12))
				)
				OR
				(c.CriteriaMaleUpperAgeUnit = 'Years' AND CriteriaMaleUpperAge < @Age)
				OR
				(CriteriaMaleUpperAgeUnit = 'Months' AND CriteriaMaleUpperAge < (@Age * 12)) 
			)
			OR
			(@Gender = @MALE AND @AgeUnit = 2 AND 
				((c.CriteriaMaleUpperAgeUnit = 'Years' AND (CriteriaMaleUpperAge *12) < @Age)
				OR
				(CriteriaMaleUpperAgeUnit = 'Months' AND CriteriaMaleUpperAge < @Age) 
				OR
				(c.CriteriaMaleUpperAgeUnit = 'Years' AND (CriteriaMaleUpperAge * 12) < @Age)
				OR
				(CriteriaMaleUpperAgeUnit = 'Months' AND CriteriaMaleUpperAge < @Age ) 
				)
			)
			OR
			(@Gender = @FEMALE AND @AgeUnit = 1 AND 
				((c.CriteriaFemaleLowerAgeUnit = 'Years' AND CriteriaFemaleLowerAge > @Age)
				OR
				(CriteriaFemaleLowerAgeUnit = 'Months' AND CriteriaFemaleLowerAge > (@Age * 12))
				)
				OR
				(c.CriteriaFemaleUpperAgeUnit = 'Years' AND CriteriaFemaleUpperAge < @Age)
				OR
				(CriteriaFemaleUpperAgeUnit = 'Months' AND CriteriaFemaleUpperAge < (@Age * 12)) 
			)
			OR
			(@Gender = @FEMALE AND @AgeUnit = 2 AND 
				((c.CriteriaFemaleUpperAgeUnit = 'Years' AND (CriteriaFemaleUpperAge *12) < @Age)
				OR
				(CriteriaFemaleUpperAgeUnit = 'Months' AND CriteriaFemaleUpperAge < @Age) 
				OR
				(c.CriteriaFemaleUpperAgeUnit = 'Years' AND (CriteriaFemaleUpperAge * 12) < @Age)
				OR
				(CriteriaFemaleUpperAgeUnit = 'Months' AND CriteriaFemaleUpperAge < @Age ) 
				)
			)
			AND t.AppropriateId IS NULL;

			UPDATE @Category
			SET AppropriateId = @MED_RO
			FROM @Category T
			INNER JOIN @Criteria c on t.DonorCategoryId = c.DonorCategoryID
			WHERE (@Gender = @MALE
			AND (c.CriteriaMaleLowerWeight > @Weight OR c.CriteriaMaleUpperWeight < @Weight)
			)
			OR
			(@Gender = @FEMALE
			AND (c.CriteriaFemaleLowerWeight > @Weight OR c.CriteriaFemaleUpperWeight < @Weight)
			)
			OR (c.CriteriaLowerWeight > @Weight OR c.CriteriaUpperWeight < @Weight)
			AND t.AppropriateId IS NULL;

		END
	IF @TriageServiceLevel =3
	BEGIN
			--get mro for aids, hiv, hep b, hep c, and ivda
			INSERT INTO @CriteriaIndication
			SELECT DISTINCT c.DonorCategoryID, Indication.IndicationName, Indication.IndicationNote, Indication.IndicationHighRisk 
			FROM CriteriaIndication 
			INNER JOIN Indication ON CriteriaIndication.IndicationID = Indication.IndicationID 
			INNER JOIN @Criteria c ON CriteriaIndication.CriteriaID = c.CriteriaId
			WHERE (Indication.IndicationName = @AIDS
			OR Indication.IndicationName = @HIV
			OR Indication.IndicationName = @HEPB
			OR Indication.IndicationName = @HEPC
			OR Indication.IndicationName like '%' +@IVDA + '%'
			);

			--check high risk first
			UPDATE @Category
			SET AppropriateId = @HIGH_RISK
			FROM @Category c
			INNER JOIN @CriteriaIndication ci on c.DonorCategoryId = ci.DonorCategoryID
			WHERE IndicationHighRisk = -1
			AND IndicationNote IS NULL
			AND AppropriateId IS NULL
			AND (
					(ci.IndicationName = @HIV AND @HivId = @YES)
					OR (ci.IndicationName = @AIDS AND @AidsId = @YES)
					OR (ci.IndicationName = @HEPB AND @HepBId = @YES)
					OR (ci.IndicationName = @HEPC AND @HepCId = @YES)
					OR (ci.IndicationName like '%' +@IVDA + '%' AND @Ivdaid = @YES)
				);

			--check mro
			UPDATE @Category
			set AppropriateId = @MED_RO
			FROM @Category c
			INNER JOIN @CriteriaIndication ci on c.DonorCategoryId = ci.DonorCategoryID
			WHERE IndicationHighRisk = 0
			AND IndicationNote IS NULL
			AND AppropriateId IS NULL
			AND (
					(ci.IndicationName = @HIV AND @HivId = @YES)
					OR (ci.IndicationName = @AIDS AND @AidsId = @YES)
					OR (ci.IndicationName = @HEPB AND @HepBId = @YES)
					OR (ci.IndicationName = @HEPC AND @HepCId = @YES)
					OR (ci.IndicationName like '%' +@IVDA + '%' AND @Ivdaid = @YES)
				);
	END
			 
	--update to appropriate, or leave blank if there are indication notes
	UPDATE @Category
	SET AppropriateId = CASE 
							WHEN  IndicationName = @HIV AND @HivId = @YES AND ci.IndicationNote IS NOT NULL THEN NULL
							WHEN  IndicationName = @AIDS AND @AidsId = @YES AND ci.IndicationNote IS NOT NULL THEN NULL
							WHEN  IndicationName = @HEPB AND @HepBId = @YES AND ci.IndicationNote IS NOT NULL THEN NULL
							WHEN  IndicationName = @HEPC AND @HepCId = @YES AND ci.IndicationNote IS NOT NULL THEN NULL
							WHEN  IndicationName like '%' +@IVDA + '%' AND @Ivdaid = @YES AND ci.IndicationNote IS NOT NULL THEN NULL
							ELSE @APPROPRIATE_YES	
						END
	FROM @Category c
	LEFT JOIN @CriteriaIndication ci on c.DonorCategoryId = ci.DonorCategoryID AND IndicationNote IS NOT NULL
	WHERE AppropriateId IS NULL;


	INSERT INTO @Approriate
	SELECT
		MAX(CASE DonorCategoryId WHEN @ORGAN_DONOR_CATEGORY THEN AppropriateId END) AS OrganAppropriateId,
		MAX(CASE DonorCategoryId WHEN @BONE_DONOR_CATEGORY THEN AppropriateId END) AS BoneAppropriateId,
		MAX(CASE DonorCategoryId WHEN @SOFTTISSUE_DONOR_CATEGORY THEN AppropriateId END) AS SoftTissueAppropriateId,
		MAX(CASE DonorCategoryId WHEN @SKIN_DONOR_CATEGORY THEN AppropriateId END) AS SkinAppropriateId,
		MAX(CASE DonorCategoryId WHEN @VALVES_DONOR_CATEGORY THEN AppropriateId END) AS ValvesAppropriateId,
		MAX(CASE DonorCategoryId WHEN @EYES_DONOR_CATEGORY THEN AppropriateId END) AS EyesAppropriateId,
		MAX(CASE DonorCategoryId WHEN @OTHER_DONOR_CATEGORY THEN AppropriateId END) AS OtherAppropriateId,
		4, --ruleout
		4 --ruleout
	FROM @Category

--Determine Referral Type
DECLARE	 
	@ReferralOrganAppropriateID			INT = -1,
	@ReferralOrganApproachID			INT = -1,
	@ReferralOrganConsentID				INT = -1,
	@ReferralOrganRecoveryID			INT = -1,
	@ReferralBoneAppropriateID			INT = -1,
	@ReferralBoneApproachID				INT = -1,
	@ReferralBoneConsentID				INT = -1,
	@ReferralBoneRecoveryID				INT = -1,
	@ReferralTissueAppropriateID		INT = -1,
	@ReferralTissueApproachID			INT = -1,
	@ReferralTissueConsentID			INT = -1,
	@ReferralTissueRecoveryID			INT = -1,
	@ReferralSkinAppropriateID			INT = -1,
	@ReferralSkinApproachID				INT = -1,
	@ReferralSkinConsentID				INT = -1,
	@ReferralSkinRecoveryID				INT = -1,
	@ReferralValvesAppropriateID		INT = -1,
	@ReferralValvesApproachID			INT = -1,
	@ReferralValvesConsentID			INT = -1,
	@ReferralValvesRecoveryID			INT = -1,	
	@ReferralResearchAppropriateID		INT = -1,
	@ReferralResearchApproachID			INT = -1,
	@ReferralResearchConsentID			INT = -1,
	@ReferralResearchRecoveryID			INT = -1,
	@ReferralEyesAppropriateID			INT = -1,
	@ReferralEyesApproachID				INT = -1,
	@ReferralEyesConsentID				INT = -1,
	@ReferralEyesRecoveryID				INT = -1,
	@ServiceLevelAppropriateOrganID		INT,
	@ServiceLevelAppropriateBoneID		INT,
	@ServiceLevelAppropriateTissueID	INT,
	@ServiceLevelAppropriateSkinID		INT,
	@ServiceLevelAppropriateValvesID	INT,
	@ServiceLevelAppropriateEyesID		INT,
	@CurrentReferralTypeIdOriginal		INT,
	@CurrentReferralTypeIdNew			INT = 4, --Ruleout
	@CurrentReferralTypeIdNewList		VARCHAR(10) = '4',
	@ReferralTypeEyeOnly				INT = 3,
	@ReferralTypeOrgan					INT = 7,
	@ReferralTypeTissue					INT = 8;

SELECT @ReferralOrganAppropriateID = IsNull(OrganAppropriateId,1),
	@ReferralBoneAppropriateID = IsNull(BoneAppropriateId,1),
	@ReferralTissueAppropriateID = IsNull(SoftTissueAppropriateId,1),
	@ReferralSkinAppropriateID = IsNull(SkinAppropriateId,1),
	@ReferralValvesAppropriateID = IsNull(ValvesAppropriateId,1),
	@ReferralEyesAppropriateID = IsNull(EyesAppropriateId,1)
FROM @Approriate  

--Look up service level data
SELECT TOP (1)
	@ServiceLevelAppropriateOrganID = ServiceLevelAppropriateOrgan,
	@ServiceLevelAppropriateBoneID = ServiceLevelAppropriateBone,
	@ServiceLevelAppropriateTissueID = ServiceLevelAppropriateTissue,
	@ServiceLevelAppropriateSkinID = ServiceLevelAppropriateSkin,
	@ServiceLevelAppropriateValvesID = ServiceLevelAppropriateValves,
	@ServiceLevelAppropriateEyesID = ServiceLevelAppropriateEyes
FROM ServiceLevel
WHERE ServiceLevelID = @ServiceLevelID;

--Make sure we have an appropriate service level value
IF (@ServiceLevelAppropriateOrganID = -1 OR @ServiceLevelAppropriateBoneID = -1 OR @ServiceLevelAppropriateTissueID = -1 OR @ServiceLevelAppropriateSkinID = -1 OR @ServiceLevelAppropriateValvesID = -1 OR @ServiceLevelAppropriateEyesID = -1)
BEGIN
	DECLARE @returnValue BIT;

	--Check Organ
	EXEC @returnValue = dbo.fn_CreateReferralType @RecoveryId = @ReferralOrganRecoveryID, @ConsentID = @ReferralOrganConsentID, @AppropriateId = @ReferralOrganAppropriateID, @ApproachId = @ReferralOrganApproachID;
	IF @returnValue = 1
	BEGIN
		SELECT @CurrentReferralTypeIdNew = @ReferralTypeOrgan, @CurrentReferralTypeIdNewList = @ReferralTypeOrgan;
	END

	--Check Tissue
	IF (SELECT COUNT(1) FROM @Category WHERE DonorCategoryId = 3) > 0
	BEGIN
		EXEC @returnValue = dbo.fn_CreateReferralType @RecoveryId = @ReferralTissueRecoveryID, @ConsentID = @ReferralTissueConsentID, @AppropriateId = @ReferralTissueAppropriateID, @ApproachId = @ReferralTissueApproachID;
		IF @returnValue = 1
		BEGIN
			SELECT @CurrentReferralTypeIdNew = @ReferralTypeTissue, @CurrentReferralTypeIdNewList = @CurrentReferralTypeIdNewList + CAST(@ReferralTypeTissue AS VARCHAR);
		END
	END

	--Check Bone
	IF (SELECT COUNT(1) FROM @Category WHERE DonorCategoryId = 2) > 0
	BEGIN
		IF @CurrentReferralTypeIdNew <> @ReferralTypeTissue
		BEGIN
			EXEC @returnValue = dbo.fn_CreateReferralType @RecoveryId = @ReferralBoneRecoveryID, @ConsentID = @ReferralBoneConsentID, @AppropriateId = @ReferralBoneAppropriateID, @ApproachId = @ReferralBoneApproachID;
			IF @returnValue = 1
			BEGIN
				SELECT @CurrentReferralTypeIdNew = @ReferralTypeTissue, @CurrentReferralTypeIdNewList = @CurrentReferralTypeIdNewList + CAST(@ReferralTypeTissue AS VARCHAR);
			END
		END
	END

	--Check Skin
	IF (SELECT COUNT(1) FROM @Category WHERE DonorCategoryId = 4) > 0
	BEGIN
		IF @CurrentReferralTypeIdNew <> @ReferralTypeTissue
		BEGIN
			EXEC @returnValue = dbo.fn_CreateReferralType @RecoveryId = @ReferralSkinRecoveryID, @ConsentID = @ReferralSkinConsentID, @AppropriateId = @ReferralSkinAppropriateID, @ApproachId = @ReferralSkinApproachID;
			IF @returnValue = 1
			BEGIN
				SELECT @CurrentReferralTypeIdNew = @ReferralTypeTissue, @CurrentReferralTypeIdNewList = @CurrentReferralTypeIdNewList + CAST(@ReferralTypeTissue AS VARCHAR);
			END
		END	
	END
	
	--Check Valves
	IF (SELECT COUNT(1) FROM @Category WHERE DonorCategoryId = 5) > 0
	BEGIN
		IF @CurrentReferralTypeIdNew <> @ReferralTypeTissue
		BEGIN
			EXEC @returnValue = dbo.fn_CreateReferralType @RecoveryId = @ReferralValvesRecoveryID, @ConsentID = @ReferralValvesConsentID, @AppropriateId = @ReferralValvesAppropriateID, @ApproachId = @ReferralValvesApproachID;
			IF @returnValue = 1
			BEGIN
				SELECT @CurrentReferralTypeIdNew = @ReferralTypeTissue, @CurrentReferralTypeIdNewList = @CurrentReferralTypeIdNewList + CAST(@ReferralTypeTissue AS VARCHAR);
			END
		END
	END
	
	--Check Research
	IF @CurrentReferralTypeIdNew <> @ReferralTypeTissue
	BEGIN
		EXEC @returnValue = dbo.fn_CreateReferralType @RecoveryId = @ReferralResearchRecoveryID, @ConsentID = @ReferralResearchConsentID, @AppropriateId = @ReferralResearchAppropriateID, @ApproachId = @ReferralResearchApproachID;
		IF @returnValue = 1
		BEGIN
			SELECT @CurrentReferralTypeIdNew = @ReferralTypeTissue, @CurrentReferralTypeIdNewList = @CurrentReferralTypeIdNewList + CAST(@ReferralTypeTissue AS VARCHAR);
		END
	END
	
	--Check Eyes
	IF (SELECT COUNT(1) FROM @Category WHERE DonorCategoryId = 6) > 0
	BEGIN
		EXEC @returnValue = dbo.fn_CreateReferralType @RecoveryId = @ReferralEyesRecoveryID, @ConsentID = @ReferralEyesConsentID, @AppropriateId = @ReferralEyesAppropriateID, @ApproachId = @ReferralEyesApproachID;
		IF @returnValue = 1
		BEGIN
			SELECT @CurrentReferralTypeIdNew = @ReferralTypeEyeOnly, @CurrentReferralTypeIdNewList = @CurrentReferralTypeIdNewList + CAST(@ReferralTypeEyeOnly AS VARCHAR);
		END
	END

END

--now the fun part...translate the end product...what was concatenated, make one of 8 referral types
SELECT @CurrentReferralTypeIdNew = 
	CASE @CurrentReferralTypeIdNewList
		WHEN '783' THEN 1 -- Organ/Tissue/Eye
		WHEN '78' THEN 5 -- Organ/Tissue
		WHEN '73' THEN 6 -- Organ/Eye
		WHEN '7' THEN 7 -- Organ
		WHEN '48' THEN 8 -- Tissue
		WHEN '483' THEN 2 -- Tissue/Eye
		WHEN '43' THEN 3 -- Eyes Only
		ELSE @CurrentReferralTypeIdNew
	END;


UPDATE @Approriate
SET CurrentReferralTypeID = @CurrentReferralTypeIdNew,
--only certain types are good for previous referral type
	PreviousReferralTypeID = CASE @CurrentReferralTypeIdNew
								WHEN 1 THEN 1
								WHEN 5 THEN 1
								WHEN 6 THEN 1
								WHEN 7 THEN 1
								WHEN 8 THEN 2
								WHEN 2 THEN 2
								WHEN 3 THEN 3
								ELSE 4
							END;


	RETURN 
END
GO







