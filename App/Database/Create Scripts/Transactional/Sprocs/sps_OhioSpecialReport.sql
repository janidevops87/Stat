SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_OhioSpecialReport]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_OhioSpecialReport]
GO


CREATE PROCEDURE [sps_OhioSpecialReport] 
	@vCallID int =0,
	@vOrganizationID int = 0,
	@vStartDate datetime = null,
	@vEndDate datetime = null,
	@vReportGroupID int = 0

AS

SET NOCOUNT ON

--Create Table Main Selection
Create Table #_TempMain
	 (
		OrganizationID   int,
         		OrganizationName varchar(80),
                          SourceCodeID int,     
                          StateID int,
                          DeathDate varchar(10),
         		PersonName varchar(50),
             		ReferralDOA smallint,
		ReferralGeneralConsent int,
		ReferralApproachTypeID int,

		ReferralOrganAppropriateID int,
         		ReferralBoneAppropriateID int,
		ReferralTissueAppropriateID int,
         		ReferralSkinAppropriateID int,
	         	ReferralValvesAppropriateID int,
         		ReferralEyesTransAppropriateID int,
         
         		ReferralOrganApproachID int,
         		ReferralBoneApproachID int,
         		ReferralTissueApproachID int,
         		ReferralSkinApproachID int,
         		ReferralValvesApproachID int,
	         	ReferralEyesTransApproachID int,

		ReferralOrganConsentID int,
         		ReferralBoneConsentID int,
         		ReferralTissueConsentID int,
         		ReferralSkinConsentID int,
         		ReferralValvesConsentID int,
         		ReferralEyesTransConsentID int,

		ReferralOrganConversionID int,
         		ReferralBoneConversionID int,
         		ReferralTissueConversionID int,
		ReferralSkinConversionID int,
         		ReferralValvesConversionID int,
         		ReferralEyesTransConversionID int,

		AppropriateOrgan varchar(50),
         		AppropriateBone varchar(50),         
         		AppropriateTissue varchar(50),
         		AppropriateSkin varchar(50),         
         		AppropriateValves varchar(50),         
         		AppropriateEyes varchar(50),

		ApproachOrgan varchar(50),
         		ApproachBone varchar(50),         
         		ApproachTissue varchar(50),
         		ApproachSkin varchar(50),         
         		ApproachValves varchar(50),         
         		ApproachEyes varchar(50),

         		ConsentOrgan varchar(50),
         		ConsentBone varchar(50),         
         		ConsentTissue varchar(50),
         		ConsentSkin varchar(50),         
         		ConsentValves varchar(50),         
         		ConsentEyes varchar(50),

         		ConversionOrgan varchar(50),
         		ConversionBone varchar(50),         
         		ConversionTissue varchar(50),
         		ConversionSkin varchar(50),         		
		ConversionValves varchar(50),         
         		ConversionEyes varchar(50)           
	 )

--Create Table for Organ Procurement
Create Table #_TempOrganAssigned
  	 (
      		OrganizationID int,
      		Assigned       varchar(80),
      		StateID        int,
      		SourceCodeID   int
   	)
--Create Table for Tissue Procurement
Create Table #_TempTissueAssigned
   	(
      		OrganizationID int,
      		Assigned       varchar(80),
      		StateID        int,
      		SourceCodeID   int
   	)
--Create Table for EYE Procurement
Create Table #_TempEyeAssigned
   	(
      		OrganizationID int,
     		 Assigned       varchar(80),
      		StateID        int,
      		SourceCodeID   int
   	)	


IF @vCallID > 0
	BEGIN
		INSERT #_TEMPMain	
		SELECT  
		   		O.OrganizationID,
         				O.OrganizationName,
				C.SourceCodeID,     
                                        	O.StateID,
         				Convert(char,ReferralDonorDeathDate,101)as DeathDate,
         				P.PersonLast + ", " + P.PersonFirst AS PersonName,
             				ReferralDOA,
				ReferralGeneralConsent,
				ReferralApproachTypeID,

         				ReferralOrganAppropriateID,
         				ReferralBoneAppropriateID,
				ReferralTissueAppropriateID,
         				ReferralSkinAppropriateID,
	         			ReferralValvesAppropriateID,
         				ReferralEyesTransAppropriateID,
         
         				ReferralOrganApproachID,
         				ReferralBoneApproachID,
         				ReferralTissueApproachID,
         				ReferralSkinApproachID,
         				ReferralValvesApproachID,
	         			ReferralEyesTransApproachID,

         				ReferralOrganConsentID,
         				ReferralBoneConsentID,
         				ReferralTissueConsentID,
         				ReferralSkinConsentID,
         				ReferralValvesConsentID,
         				ReferralEyesTransConsentID,

         				ReferralOrganConversionID,
         				ReferralBoneConversionID,
         				ReferralTissueConversionID,
         				ReferralSkinConversionID,
         				ReferralValvesConversionID,
         				ReferralEyesTransConversionID,

         				AO.AppropriateName as AppropriateOrgan,
         				AB.AppropriateName as AppropriateBone,         
         				ATI.AppropriateName as AppropriateTissue,
         				ASK.AppropriateName as AppropriateSkin,         
         				AV.AppropriateName as AppropriateValves,         
         				AE.AppropriateName as AppropriateEyes,

         				APO.ApproachName as ApproachOrgan,
         				APB.ApproachName as ApproachBone,         
         				APTI.ApproachName as ApproachTissue,
         				APSK.ApproachName as ApproachSkin,         
         				APV.ApproachName as ApproachValves,         
         				APE.ApproachName as ApproachEyes,

         				CO.ConsentName as ConsentOrgan,
         				CB.ConsentName as ConsentBone,         
         				CTI.ConsentName as ConsentTissue,
         				CSK.ConsentName as ConsentSkin,         
         				CV.ConsentName as ConsentValves,         
         				CE.ConsentName as ConsentEyes,

         				RO.ConversionName as ConversionOrgan,
         				RB.ConversionName as ConversionBone,         
         				RTI.ConversionName as ConversionTissue,
         				RSK.ConversionName as ConversionSkin,         
         				RV.ConversionName as ConversionValves,         
         				RE.ConversionName as ConversionEyes                                  
     
				FROM Referral R
				LEFT JOIN Appropriate AO ON R.ReferralOrganAppropriateID = AO.AppropriateID
				LEFT JOIN Appropriate AB ON R.ReferralBoneAppropriateID = AB.AppropriateID
				LEFT JOIN Appropriate ATI ON R.ReferralTissueAppropriateID = ATI.AppropriateID
				LEFT JOIN Appropriate ASK ON R.ReferralSkinAppropriateID = ASK.AppropriateID
				LEFT JOIN Appropriate AV ON R.ReferralValvesAppropriateID = AV.AppropriateID
				LEFT JOIN Appropriate AE ON R.ReferralEyesTransAppropriateID = AE.AppropriateID

				LEFT JOIN Approach APO ON R.ReferralOrganApproachID = APO.ApproachID
				LEFT JOIN Approach APB ON R.ReferralBoneApproachID = APB.ApproachID
				LEFT JOIN Approach APTI ON R.ReferralTissueApproachID = APTI.ApproachID
				LEFT JOIN Approach APSK ON R.ReferralSkinApproachID = APSK.ApproachID
				LEFT JOIN Approach APV ON R.ReferralValvesApproachID = APV.ApproachID 
				LEFT JOIN Approach APE ON R.ReferralEyesTransApproachID = APE.ApproachID

				LEFT JOIN Consent CO ON R.ReferralOrganConsentID = CO.ConsentID
				LEFT JOIN Consent CB ON R.ReferralBoneConsentID = CB.ConsentID
				LEFT JOIN Consent CTI ON R.ReferralTissueConsentID = CTI.ConsentID
				LEFT JOIN Consent CSK ON R.ReferralSkinConsentID = CSK.ConsentID
				LEFT JOIN Consent CV ON R.ReferralValvesConsentID = CV.ConsentID 
				LEFT JOIN Consent CE ON R.ReferralEyesTransConsentID = CE.ConsentID

				LEFT JOIN Conversion RO ON R.ReferralOrganConversionID = RO.ConversionID
				LEFT JOIN Conversion RB ON R.ReferralBoneConversionID = RB.ConversionID
				LEFT JOIN Conversion RTI ON R.ReferralTissueConversionID = RTI.ConversionID
				LEFT JOIN Conversion RSK ON R.ReferralSkinConversionID = RSK.ConversionID
				LEFT JOIN Conversion RV ON R.ReferralValvesConversionID = RV.ConversionID 
				LEFT JOIN Conversion RE ON R.ReferralEyesTransConversionID = RE.ConversionID

				LEFT JOIN Organization O ON R.ReferralCallerOrganizationID = O.OrganizationID
				LEFT JOIN Person P ON R.ReferralCallerPersonID = P.PersonID
				JOIN Call C ON R.CallID = C.CallID
				WHERE 	C.CALLID = @vCallID 

	END

IF @vCallID = 0 AND @vOrganizationID > 0 
	Begin
		   INSERT #_TEMPMain
		   SELECT  
			         	O.OrganizationID,
         				O.OrganizationName,
				C.SourceCodeID,     
                                        	O.StateID,	
         				Convert(char,ReferralDonorDeathDate,101)as DeathDate,
         				P.PersonLast + ", " + P.PersonFirst AS PersonName,
             				ReferralDOA,
				ReferralGeneralConsent,
				ReferralApproachTypeID,

         				ReferralOrganAppropriateID,
         				ReferralBoneAppropriateID,
				ReferralTissueAppropriateID,
         				ReferralSkinAppropriateID,
	         			ReferralValvesAppropriateID,
         				ReferralEyesTransAppropriateID,
         
         				ReferralOrganApproachID,
         				ReferralBoneApproachID,
         				ReferralTissueApproachID,
         				ReferralSkinApproachID,
         				ReferralValvesApproachID,
	         			ReferralEyesTransApproachID,

         				ReferralOrganConsentID,
         				ReferralBoneConsentID,
         				ReferralTissueConsentID,
         				ReferralSkinConsentID,
         				ReferralValvesConsentID,
         				ReferralEyesTransConsentID,

         				ReferralOrganConversionID,
         				ReferralBoneConversionID,
         				ReferralTissueConversionID,
         				ReferralSkinConversionID,
         				ReferralValvesConversionID,
         				ReferralEyesTransConversionID,

         				AO.AppropriateName as AppropriateOrgan,
         				AB.AppropriateName as AppropriateBone,         
         				ATI.AppropriateName as AppropriateTissue,
         				ASK.AppropriateName as AppropriateSkin,         
         				AV.AppropriateName as AppropriateValves,         
         				AE.AppropriateName as AppropriateEyes,

         				APO.ApproachName as ApproachOrgan,
         				APB.ApproachName as ApproachBone,         
         				APTI.ApproachName as ApproachTissue,
         				APSK.ApproachName as ApproachSkin,         
         				APV.ApproachName as ApproachValves,         
         				APE.ApproachName as ApproachEyes,

         				CO.ConsentName as ConsentOrgan,
         				CB.ConsentName as ConsentBone,         
         				CTI.ConsentName as ConsentTissue,
         				CSK.ConsentName as ConsentSkin,         
         				CV.ConsentName as ConsentValves,         
         				CE.ConsentName as ConsentEyes,

         				RO.ConversionName as ConversionOrgan,
         				RB.ConversionName as ConversionBone,         
         				RTI.ConversionName as ConversionTissue,
         				RSK.ConversionName as ConversionSkin,         
         				RV.ConversionName as ConversionValves,         
         				RE.ConversionName as ConversionEyes                                  
     
				FROM Referral R
				LEFT JOIN Appropriate AO ON R.ReferralOrganAppropriateID = AO.AppropriateID
				LEFT JOIN Appropriate AB ON R.ReferralBoneAppropriateID = AB.AppropriateID
				LEFT JOIN Appropriate ATI ON R.ReferralTissueAppropriateID = ATI.AppropriateID
				LEFT JOIN Appropriate ASK ON R.ReferralSkinAppropriateID = ASK.AppropriateID
				LEFT JOIN Appropriate AV ON R.ReferralValvesAppropriateID = AV.AppropriateID
				LEFT JOIN Appropriate AE ON R.ReferralEyesTransAppropriateID = AE.AppropriateID

				LEFT JOIN Approach APO ON R.ReferralOrganApproachID = APO.ApproachID
				LEFT JOIN Approach APB ON R.ReferralBoneApproachID = APB.ApproachID
				LEFT JOIN Approach APTI ON R.ReferralTissueApproachID = APTI.ApproachID
				LEFT JOIN Approach APSK ON R.ReferralSkinApproachID = APSK.ApproachID
				LEFT JOIN Approach APV ON R.ReferralValvesApproachID = APV.ApproachID 
				LEFT JOIN Approach APE ON R.ReferralEyesTransApproachID = APE.ApproachID

				LEFT JOIN Consent CO ON R.ReferralOrganConsentID = CO.ConsentID
				LEFT JOIN Consent CB ON R.ReferralBoneConsentID = CB.ConsentID
				LEFT JOIN Consent CTI ON R.ReferralTissueConsentID = CTI.ConsentID
				LEFT JOIN Consent CSK ON R.ReferralSkinConsentID = CSK.ConsentID
				LEFT JOIN Consent CV ON R.ReferralValvesConsentID = CV.ConsentID 
				LEFT JOIN Consent CE ON R.ReferralEyesTransConsentID = CE.ConsentID

				LEFT JOIN Conversion RO ON R.ReferralOrganConversionID = RO.ConversionID
				LEFT JOIN Conversion RB ON R.ReferralBoneConversionID = RB.ConversionID
				LEFT JOIN Conversion RTI ON R.ReferralTissueConversionID = RTI.ConversionID
				LEFT JOIN Conversion RSK ON R.ReferralSkinConversionID = RSK.ConversionID
				LEFT JOIN Conversion RV ON R.ReferralValvesConversionID = RV.ConversionID 
				LEFT JOIN Conversion RE ON R.ReferralEyesTransConversionID = RE.ConversionID

				LEFT JOIN Organization O ON R.ReferralCallerOrganizationID = O.OrganizationID
				LEFT JOIN Person P ON R.ReferralCallerPersonID = P.PersonID
				JOIN Call C ON R.CallID = C.CallID
				WHERE O.OrganizationID = @vOrganizationID
				AND	C.CallDateTime >= @vStartDate
				AND	C.CallDateTime <= @vEndDate

	End

IF @vCallID = 0 AND @vOrganizationID = 0 AND @vReportGroupID > 0
	Begin	   
		   INSERT #_TEMPMain				
		   SELECT  
			         	O.OrganizationID,
         				O.OrganizationName,
				C.SourceCodeID,     
                                        	O.StateID,
         				Convert(char,ReferralDonorDeathDate,101)as DeathDate,
         				P.PersonLast + ", " + P.PersonFirst AS PersonName,
             				ReferralDOA,
				ReferralGeneralConsent,
				ReferralApproachTypeID,

         				ReferralOrganAppropriateID,
         				ReferralBoneAppropriateID,
				ReferralTissueAppropriateID,
         				ReferralSkinAppropriateID,
	         			ReferralValvesAppropriateID,
         				ReferralEyesTransAppropriateID,
         
         				ReferralOrganApproachID,
         				ReferralBoneApproachID,
         				ReferralTissueApproachID,
         				ReferralSkinApproachID,
         				ReferralValvesApproachID,
	         			ReferralEyesTransApproachID,

         				ReferralOrganConsentID,
         				ReferralBoneConsentID,
         				ReferralTissueConsentID,
         				ReferralSkinConsentID,
         				ReferralValvesConsentID,
         				ReferralEyesTransConsentID,

         				ReferralOrganConversionID,
         				ReferralBoneConversionID,
         				ReferralTissueConversionID,
         				ReferralSkinConversionID,
         				ReferralValvesConversionID,
         				ReferralEyesTransConversionID,

         				AO.AppropriateName as AppropriateOrgan,
         				AB.AppropriateName as AppropriateBone,         
         				ATI.AppropriateName as AppropriateTissue,
         				ASK.AppropriateName as AppropriateSkin,         
         				AV.AppropriateName as AppropriateValves,         
         				AE.AppropriateName as AppropriateEyes,

         				APO.ApproachName as ApproachOrgan,
         				APB.ApproachName as ApproachBone,         
         				APTI.ApproachName as ApproachTissue,
         				APSK.ApproachName as ApproachSkin,         
         				APV.ApproachName as ApproachValves,         
         				APE.ApproachName as ApproachEyes,

         				CO.ConsentName as ConsentOrgan,
         				CB.ConsentName as ConsentBone,         
         				CTI.ConsentName as ConsentTissue,
         				CSK.ConsentName as ConsentSkin,         
         				CV.ConsentName as ConsentValves,         
         				CE.ConsentName as ConsentEyes,

         				RO.ConversionName as ConversionOrgan,
         				RB.ConversionName as ConversionBone,         
         				RTI.ConversionName as ConversionTissue,
         				RSK.ConversionName as ConversionSkin,         
         				RV.ConversionName as ConversionValves,         
         				RE.ConversionName as ConversionEyes                                  
     
				FROM Referral R
				LEFT JOIN Appropriate AO ON R.ReferralOrganAppropriateID = AO.AppropriateID
				LEFT JOIN Appropriate AB ON R.ReferralBoneAppropriateID = AB.AppropriateID
				LEFT JOIN Appropriate ATI ON R.ReferralTissueAppropriateID = ATI.AppropriateID
				LEFT JOIN Appropriate ASK ON R.ReferralSkinAppropriateID = ASK.AppropriateID
				LEFT JOIN Appropriate AV ON R.ReferralValvesAppropriateID = AV.AppropriateID
				LEFT JOIN Appropriate AE ON R.ReferralEyesTransAppropriateID = AE.AppropriateID

				LEFT JOIN Approach APO ON R.ReferralOrganApproachID = APO.ApproachID
				LEFT JOIN Approach APB ON R.ReferralBoneApproachID = APB.ApproachID
				LEFT JOIN Approach APTI ON R.ReferralTissueApproachID = APTI.ApproachID
				LEFT JOIN Approach APSK ON R.ReferralSkinApproachID = APSK.ApproachID
				LEFT JOIN Approach APV ON R.ReferralValvesApproachID = APV.ApproachID 
				LEFT JOIN Approach APE ON R.ReferralEyesTransApproachID = APE.ApproachID

				LEFT JOIN Consent CO ON R.ReferralOrganConsentID = CO.ConsentID
				LEFT JOIN Consent CB ON R.ReferralBoneConsentID = CB.ConsentID
				LEFT JOIN Consent CTI ON R.ReferralTissueConsentID = CTI.ConsentID
				LEFT JOIN Consent CSK ON R.ReferralSkinConsentID = CSK.ConsentID
				LEFT JOIN Consent CV ON R.ReferralValvesConsentID = CV.ConsentID 
				LEFT JOIN Consent CE ON R.ReferralEyesTransConsentID = CE.ConsentID

				LEFT JOIN Conversion RO ON R.ReferralOrganConversionID = RO.ConversionID
				LEFT JOIN Conversion RB ON R.ReferralBoneConversionID = RB.ConversionID
				LEFT JOIN Conversion RTI ON R.ReferralTissueConversionID = RTI.ConversionID
				LEFT JOIN Conversion RSK ON R.ReferralSkinConversionID = RSK.ConversionID
				LEFT JOIN Conversion RV ON R.ReferralValvesConversionID = RV.ConversionID 
				LEFT JOIN Conversion RE ON R.ReferralEyesTransConversionID = RE.ConversionID

				LEFT JOIN Organization O ON R.ReferralCallerOrganizationID = O.OrganizationID
				LEFT JOIN Person P ON R.ReferralCallerPersonID = P.PersonID
				JOIN WebReportGroupOrg W ON  R.ReferralCallerOrganizationID = W.OrganizationID
				JOIN Call C ON R.CallID = C.CallID
				WHERE W.WebReportGroupID = @vReportGroupID
				AND	C.CallDateTime >= @vStartDate
				AND	C.CallDateTime <= @vEndDate
	End

--datafill table Organ Procurement
INSERT          	#_TempOrganAssigned
SELECT 
DISTINCT 	Organization.OrganizationID, 
		OrganizationAssigned.OrganizationName AS Assigned,
	        	Organization.StateID,
                	ScheduleGroupSourceCode.SourceCodeID

FROM 		Organization 
JOIN 		ScheduleGroupOrganization ON Organization.OrganizationID = ScheduleGroupOrganization.OrganizationID 
JOIN 		ScheduleGroup ON ScheduleGroupOrganization.ScheduleGroupID = ScheduleGroup.ScheduleGroupID
JOIN 		Organization AS OrganizationAssigned ON ScheduleGroup.OrganizationID = OrganizationAssigned.OrganizationID 
		
JOIN 		CriteriaScheduleGroup ON ScheduleGroup.ScheduleGroupID = CriteriaScheduleGroup.ScheduleGroupID 
JOIN 		CriteriaOrganization ON CriteriaOrganization.CriteriaID = CriteriaScheduleGroup.CriteriaID
JOIN 		Criteria ON CriteriaScheduleGroup.CriteriaID = Criteria.CriteriaID
JOIN		ScheduleGroupSourceCode ON ScheduleGroupSourceCode.ScheduleGroupID = ScheduleGroupOrganization.ScheduleGroupID
JOIN		SourceCode ON ScheduleGroupSourceCode.SourceCodeID = SourceCode.SourceCodeID 
AND 		ScheduleGroupOrganization.OrganizationID = CriteriaOrganization.OrganizationID
JOIN            	WebReportGroupOrg W ON  Organization.OrganizationID = W.OrganizationID

WHERE 	Criteria.DonorCategoryID = 1
AND             	W.WebReportGroupID =  @vReportGroupID	

--DATA FILL TABLE Tissue Procurement
insert 		#_TempTissueAssigned
SELECT 
DISTINCT 	Organization.OrganizationID, 
		OrganizationAssigned.OrganizationName AS Assigned,
                	Organization.StateID,
                	ScheduleGroupSourceCode.SourceCodeID

FROM 		Organization 
JOIN 		ScheduleGroupOrganization ON Organization.OrganizationID = ScheduleGroupOrganization.OrganizationID 
JOIN 		ScheduleGroup ON ScheduleGroupOrganization.ScheduleGroupID = ScheduleGroup.ScheduleGroupID
JOIN 		Organization AS OrganizationAssigned ON ScheduleGroup.OrganizationID = OrganizationAssigned.OrganizationID 
		
JOIN 		CriteriaScheduleGroup ON ScheduleGroup.ScheduleGroupID = CriteriaScheduleGroup.ScheduleGroupID 
JOIN 		CriteriaOrganization ON CriteriaOrganization.CriteriaID = CriteriaScheduleGroup.CriteriaID
JOIN 		Criteria ON CriteriaScheduleGroup.CriteriaID = Criteria.CriteriaID
JOIN		ScheduleGroupSourceCode ON ScheduleGroupSourceCode.ScheduleGroupID = ScheduleGroupOrganization.ScheduleGroupID
JOIN		SourceCode ON ScheduleGroupSourceCode.SourceCodeID = SourceCode.SourceCodeID 
AND 		ScheduleGroupOrganization.OrganizationID = CriteriaOrganization.OrganizationID
JOIN            	WebReportGroupOrg W ON  Organization.OrganizationID = W.OrganizationID	

WHERE 	Criteria.DonorCategoryID Between 2 AND 5		   
AND             	W.WebReportGroupID = @vReportGroupID	

--DATA FILL TABLE Eye Procurement
insert          	#_TempEyeAssigned
SELECT 
DISTINCT 	Organization.OrganizationID, 
		OrganizationAssigned.OrganizationName AS Assigned,
                	Organization.StateID,
                	ScheduleGroupSourceCode.SourceCodeID

FROM 		Organization 
JOIN 		ScheduleGroupOrganization ON Organization.OrganizationID = ScheduleGroupOrganization.OrganizationID 
JOIN 		ScheduleGroup ON ScheduleGroupOrganization.ScheduleGroupID = ScheduleGroup.ScheduleGroupID
JOIN 		Organization AS OrganizationAssigned ON ScheduleGroup.OrganizationID = OrganizationAssigned.OrganizationID 
		
JOIN 		CriteriaScheduleGroup ON ScheduleGroup.ScheduleGroupID = CriteriaScheduleGroup.ScheduleGroupID 
JOIN 		CriteriaOrganization ON CriteriaOrganization.CriteriaID = CriteriaScheduleGroup.CriteriaID
JOIN 		Criteria ON CriteriaScheduleGroup.CriteriaID = Criteria.CriteriaID
JOIN		ScheduleGroupSourceCode ON ScheduleGroupSourceCode.ScheduleGroupID = ScheduleGroupOrganization.ScheduleGroupID
JOIN		SourceCode ON ScheduleGroupSourceCode.SourceCodeID = SourceCode.SourceCodeID 
AND 		ScheduleGroupOrganization.OrganizationID = CriteriaOrganization.OrganizationID
JOIN            	WebReportGroupOrg W ON  Organization.OrganizationID = W.OrganizationID	

WHERE 	Criteria.DonorCategoryID = 6
AND             	W.WebReportGroupID = @vReportGroupID	

SELECT	#_TEMPMain.OrganizationID,
         		OrganizationName,
         		--#_TEMPMain.SourceCodeID,     
         		--#_TEMPMain.StateID,
                           #_TempOrganAssigned.Assigned AS OrganAssigned,
                           #_TempTissueAssigned.Assigned AS TissueAssigned,
                           #_TempEyeAssigned.Assigned AS EyeAssigned ,
         		DeathDate,
         		PersonName,
             		ReferralDOA,
		ReferralGeneralConsent,
		ReferralApproachTypeID,


         		ReferralOrganAppropriateID,
         		ReferralBoneAppropriateID,

         		ReferralTissueAppropriateID,

         		ReferralSkinAppropriateID,

         		ReferralValvesAppropriateID,
         		ReferralEyesTransAppropriateID,
         
		ReferralOrganApproachID,
		ReferralBoneApproachID,
		ReferralTissueApproachID,
		ReferralSkinApproachID,
		ReferralValvesApproachID,
		ReferralEyesTransApproachID,

		ReferralOrganConsentID,
		ReferralBoneConsentID,
		ReferralTissueConsentID,
		ReferralSkinConsentID,
		ReferralValvesConsentID,
		ReferralEyesTransConsentID,

		ReferralOrganConversionID,
		ReferralBoneConversionID,
		ReferralTissueConversionID,
		ReferralSkinConversionID,
		ReferralValvesConversionID,
		ReferralEyesTransConversionID,

		AppropriateOrgan,
		AppropriateBone,         
		AppropriateTissue,
		AppropriateSkin,         
		AppropriateValves,         
		AppropriateEyes,

		ApproachOrgan,
		ApproachBone,         
		ApproachTissue,
		ApproachSkin,         
		ApproachValves,         
		ApproachEyes,

		ConsentOrgan,
		ConsentBone,         
		ConsentTissue,
		ConsentSkin,         
		ConsentValves,         
		ConsentEyes,

		ConversionOrgan,
		ConversionBone,         
		ConversionTissue,
		ConversionSkin,         
		ConversionValves,         
		ConversionEyes                  

FROM   	#_TEMPMain 

LEFT JOIN 	#_TempOrganAssigned ON #_TempOrganAssigned.StateID =  #_TEMPMain.StateID
AND   		#_TEMPMain.OrganizationID = #_TempOrganAssigned.OrganizationID
AND   		#_TEMPMain.SourceCodeID = #_TempOrganAssigned.SourceCodeID 
LEFT JOIN 	#_TempTissueAssigned ON #_TempTissueAssigned.StateID = #_TEMPMain.StateID
AND   		#_TEMPMain.OrganizationID = #_TempTissueAssigned.OrganizationID
AND   		#_TEMPMain.SourceCodeID = #_TempTissueAssigned.SourceCodeID 
LEFT JOIN 	#_TempEyeAssigned ON #_TempEyeAssigned.StateID = #_TEMPMain.StateID
AND   		#_TEMPMain.OrganizationID = #_TempEyeAssigned.OrganizationID
AND   		#_TEMPMain.SourceCodeID = #_TempEyeAssigned.SourceCodeID 

DROP TABLE #_TempOrganAssigned
DROP TABLE #_TEMPMain
DROP TABLE #_TempTissueAssigned
DROP TABLE #_TempEyeAssigned
















GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

