SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_ReferralDetailList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_ReferralDetailList]
GO





CREATE PROCEDURE sps_ReferralDetailList

     @pvReportGroupID     int          = null,
     @pvStartDate         datetime     = null,  
     @pvEndDate           datetime     = null,
     @pvOrgID             int          = null,
     @vTZ                 varchar(2)   = null,
     @pvReferralTypeID    int          = null, 
     @pvOrderBy           varchar(60)  = null,
     @pvUserOrgID	  int	       = null,
     @pvCallID            int          = null	 

with recompile
AS

     DECLARE @QueryString varchar(8000)
     DECLARE @ReferralTypeStart int
     DECLARE @ReferralTypeEnd int
     DECLARE @TZ int          
     DECLARE @SourceCodeID int
     DECLARE @SCIList varchar(2000)	
     DECLARE @AccessOrgans int 
     DECLARE @AccessBone int          
     DECLARE @AccessTissue int
     DECLARE @AccessSkin int 
     DECLARE @AccessValves int
     DECLARE @AccessEyes int 
     DECLARE @AccessResearch int 
     

     Exec spf_TZDif @vTZ, @TZ OUTPUT, @pvStartDate
	
      
     SELECT @pvStartDate = DateAdd(hour,-@TZ,@pvStartDate)
     SELECT @pvEndDate = DateAdd(hour,-@TZ,@pvEndDate)     

     -- build sourcecode list
 	--DECLARE SourceCodeCursor CURSOR FOR
        Select @SCIList = ""
		IF @pvUserOrgID = 194
			BEGIN
                                DECLARE SourceCodeCursor CURSOR FOR
				SELECT DISTINCT SourceCodeID FROM WebReportGroupSourceCode 
			END
		ELSE
			BEGIN
                                DECLARE SourceCodeCursor CURSOR FOR
				SELECT DISTINCT SourceCodeID FROM WebReportGroupSourceCode WHERE WebReportGroupID = @pvReportGroupID
			END
	OPEN SourceCodeCursor

	FETCH NEXT FROM SourceCodeCursor 
	INTO @SourceCodeID
	 
	WHILE @@FETCH_STATUS = 0
	BEGIN
	
		--@SourceCodeID
                SELECT @SCIList = @SCIList +  RTRIM(converT(char(25),@SourceCodeID))

		FETCH NEXT FROM SourceCodeCursor 
		INTO @SourceCodeID
		
		IF @@FETCH_STATUS = 0
		BEGIN
                
                        SELECT @SCIList = @SCIList + ", "		
		END
		
	END

	CLOSE SourceCodeCursor
	DEALLOCATE SourceCodeCursor
    
       
       SELECT DISTINCT   @AccessOrgans = AccessOrgans, 
                         @AccessBone = AccessBone,           
                         @AccessTissue = AccessTissue, 
                         @AccessSkin = AccessSkin, 
                         @AccessValves = AccessValves,
                         @AccessEyes = AccessEyes, 
                         @AccessResearch = AccessResearch 
       
     FROM                WebReportGroupSourceCode 
     WHERE               WebReportGroupID = @pvReportGroupID


     --SELECT * FROM #SourceCodeLookUP
          SELECT @QueryString = ""
          SELECT @QueryString = "SELECT DISTINCT Referral.ReferralID, Call.CallID, CallNumber, DATEADD(hour, "
          SELECT @QueryString = @QueryString + Convert(char(2),@TZ,8)
          SELECT @QueryString = @QueryString + " , CallDateTime) AS CallDateTime, CONVERT(char(8), DATEADD(hour, "
          SELECT @QueryString = @QueryString + Convert(char(2),@TZ)
          SELECT @QueryString = @QueryString + " , CallDateTime), 1) AS CallDate, CONVERT(char(5), DATEADD(hour, "
          SELECT @QueryString = @QueryString + Convert(char(2),@TZ)     
          SELECT @QueryString = @QueryString + " , CallDateTime), 8) AS CallTime, StatPerson.PersonFirst AS StatPersonFirstName, StatPerson.PersonLast AS StatPersonLastName, ReferralDonorGender + ' ' + ReferralDonorAge + ' ' + ReferralDonorAgeUnit, "
          SELECT @QueryString = @QueryString + "Call.SourceCodeID, SourceCodeName, Referral.ReferralTypeID, ReferralTypeName, "
          SELECT @QueryString = @QueryString + "ReferralDonorLastName, ReferralDonorFirstName, OrganizationName, "
          SELECT @QueryString = @QueryString + "CallerPerson.PersonFirst AS CallPersonFirst, CallerPerson.PersonLast AS CallerPersonLast, CallPersonType.PersonTypeName AS CallerPersonTitle, "
         
          SELECT @QueryString = @QueryString + "SubLocationName, ReferralCallerSubLocationLevel, '(' + PhoneAreaCode + ') ' + PhonePrefix + '-' + PhoneNumber , ReferralCallerExtension, "

          SELECT @QueryString = @QueryString + "Case when ReferralDonorSSN is not null THEN ReferralDonorRecNumber + ' - ' + ReferralDonorSSN  ELSE ReferralDonorRecNumber  END AS ReferralDonorRecNumber, ReferralDonorAge, ReferralDonorAgeUnit, ReferralDonorGender, ReferralDonorWeight, "
          SELECT @QueryString = @QueryString + "ReferralDonorOnVentilator, convert(char(8),ReferralDonorAdmitDate,1), ReferralDonorAdmitTime, convert(char(8),ReferralDonorDeathDate,1), ReferralDonorDeathTime, "
          SELECT @QueryString = @QueryString + "ReferralNotesCase, RaceName, CauseOfDeathName, ApproachTypeName, ApproachPerson.PersonFirst AS ApproachPersonFirst, ApproachPerson.PersonLast AS ApproachPersonLast, "
          SELECT @QueryString = @QueryString + "ReferralApproachNOK, ReferralApproachRelation, ReferralNOKPhone, ReferralNOKAddress, ReferralCoronerName, ReferralCoronerOrganization, "
          SELECT @QueryString = @QueryString + "ReferralCoronerPhone, ReferralCoronerNote, Attending.PersonFirst AS AttendingFirst, Attending.PersonLast AS AttendingLast, "
          SELECT @QueryString = @QueryString + "Pronouncing.PersonFirst AS PronouncingFirst, Pronouncing.PersonLast AS PronouncingLast, "

          -- CHECK FOR ORGAN ACCESS
          IF @AccessOrgans = 1 
          BEGIN
               SELECT @QueryString = @QueryString + "AppropOrgan.AppropriateReportName AS AppropriateOrgan, ApproaOrgan.ApproachReportName AS ApproachOrgan, ConsentOrgan.ConsentReportName AS ConsentOrgan, RecoveryOrgan.ConversionReportName AS RecoveryOrgan, "
          END
          ELSE
          BEGIN
               SELECT @QueryString = @QueryString + "'' AS AppropriateOrgan, '' AS ApproachOrgan, '' AS ConsentOrgan , '' AS RecoveryOrgan, "
          END
          -- Check for bone access
          IF @AccessBone = 1
          BEGIN
               SELECT @QueryString = @QueryString + "AppropBone.AppropriateReportName AS AppropriateBone, ApproaBone.ApproachReportName AS ApproachBone, ConsentBone.ConsentReportName AS ConsentBone, RecoveryBone.ConversionReportName AS RecoveryBone, " 
          END
          ELSE
          BEGIN
               SELECT @QueryString = @QueryString + " '' AS AppropriateBone, '' AS ApproachBone, '' AS ConsentBone, '' AS RecoveryBone, " 
          END
          -- Check for Tissue access
          IF @AccessTissue = 1 
          BEGIN
               SELECT @QueryString = @QueryString + "AppropTissue.AppropriateReportName AS AppropriateTissue, ApproaTissue.ApproachReportName AS ApproachTissue, ConsentTissue.ConsentReportName AS ConsentTissue, RecoveryTissue.ConversionReportName AS RecoveryTissue,"
          END
          ELSE
          BEGIN
               SELECT @QueryString = @QueryString + "'' AS AppropriateTissue, '' AS ApproachTissue, '' AS ConsentTissue, '' AS RecoveryTissue,"     
          END
          -- Check for skin access
          IF @AccessSkin = 1
          BEGIN
               SELECT @QueryString = @QueryString + "AppropSkin.AppropriateReportName AS AppropriateSkin, ApproaSkin.ApproachReportName AS ApproachSkin, ConsentSkin.ConsentReportName AS ConsentSkin, RecoverySkin.ConversionReportName AS RecoverySkin, "
          END
          ELSE
          BEGIN
               SELECT @QueryString = @QueryString + "'' AS AppropriateSkin, '' AS ApproachSkin, '' AS ConsentSkin, '' AS RecoverySkin, "
          END

          -- Check for valves access
          IF @AccessValves = 1
          BEGIN
               SELECT @QueryString = @QueryString + "AppropValve.AppropriateReportName AS AppropriateValves, ApproaValve.ApproachReportName AS ApproachValves, ConsentValve.ConsentReportName AS ConsentValve, RecoveryValve.ConversionReportName AS RecoveryValve, "
          END
          ELSE
          BEGIN
               SELECT @QueryString = @QueryString + "'' AS AppropriateValves, '' AS ApproachValves, '' AS ConsentValve, '' AS RecoveryValve, "
          END
          
          --Check for eyes access
          IF @AccessEyes = 1
          BEGIN
               SELECT @QueryString = @QueryString + "AppropEyes.AppropriateReportName AS AppropriateEyes, ApproaEyes.ApproachReportName AS ApproachEyes, ConsentEyes.ConsentReportName AS ConsentEyes, RecoveryEyes.ConversionReportName AS RecoveryEyes, "
          END
          ELSE
          BEGIN
               SELECT @QueryString = @QueryString + "'' AS AppropriateEyes, '' AS ApproachEyes, '' AS ConsentEyes, '' AS RecoveryEyes, "
          END

          SELECT @QueryString = @QueryString + "'','','','', "

          SELECT @QueryString = @QueryString + "ReferralCallerOrganizationID AS OrganizationID, ReferralGeneralConsent, ReferralApproachTime, ReferralConsentTime, ReferralSecondaryHistory "
          SELECT @QueryString = @QueryString + ""
          SELECT @QueryString = @QueryString + "FROM Call LEFT JOIN Referral ON Referral.CallID = Call.CallID "
          SELECT @QueryString = @QueryString + "LEFT JOIN SourceCode ON SourceCode.SourceCodeID = Call.SourceCodeID "
          SELECT @QueryString = @QueryString + "LEFT JOIN Organization ON Organization.OrganizationID = Referral.ReferralCallerOrganizationID "
          SELECT @QueryString = @QueryString + "LEFT JOIN WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = ReferralCallerOrganizationID "
          SELECT @QueryString = @QueryString + "LEFT JOIN StatEmployee ON StatEmployee.StatEmployeeID = Call.StatEmployeeID "
          SELECT @QueryString = @QueryString + "LEFT JOIN Person StatPerson ON StatPerson.PersonID = StatEmployee.PersonID "
          SELECT @QueryString = @QueryString + "LEFT JOIN Person ON Person.PersonID = StatEmployee.PersonID "
          SELECT @QueryString = @QueryString + "LEFT JOIN Person CallerPerson ON CallerPerson.PersonID = Referral.ReferralCallerPersonID "
          SELECT @QueryString = @QueryString + "LEFT JOIN Person ApproachPerson ON ApproachPerson.PersonID = Referral.ReferralApproachedByPersonID "
          SELECT @QueryString = @QueryString + "LEFT JOIN Person Attending ON Attending.PersonID = Referral.ReferralAttendingMD "
          SELECT @QueryString = @QueryString + "LEFT JOIN Person Pronouncing ON Pronouncing.PersonID = Referral.ReferralPronouncingMD "
          SELECT @QueryString = @QueryString + "LEFT JOIN PersonType ON PersonType.PersonTypeID = Person.PersonTypeID "
          SELECT @QueryString = @QueryString + "LEFT JOIN PersonType CallPersonType ON CallPersonType.PersonTypeID = CallerPerson.PersonTypeID "
          SELECT @QueryString = @QueryString + "LEFT JOIN SubLocation ON SubLocation.SubLocationID = Referral.ReferralCallerSubLocationID "
          SELECT @QueryString = @QueryString + "LEFT JOIN Phone ON Phone.PhoneID = Referral.ReferralCallerPhoneID "
          SELECT @QueryString = @QueryString + "LEFT JOIN ReferralType ON ReferralType.ReferralTypeID = Referral.ReferralTypeID "
          SELECT @QueryString = @QueryString + "LEFT JOIN Race ON Race.RaceID = Referral.ReferralDonorRaceID "
          SELECT @QueryString = @QueryString + "LEFT JOIN CauseOfDeath ON CauseOfDeath.CauseOfDeathID = Referral.ReferralDonorCauseOfDeathID "
          SELECT @QueryString = @QueryString + "LEFT JOIN ApproachType ON ApproachType.ApproachTypeID = Referral.ReferralApproachTypeID "
          SELECT @QueryString = @QueryString + "LEFT JOIN Appropriate AppropOrgan ON AppropOrgan.AppropriateID = Referral.ReferralOrganAppropriateID "
          SELECT @QueryString = @QueryString + "LEFT JOIN Appropriate AppropBone ON AppropBone.AppropriateID = Referral.ReferralBoneAppropriateID "
          SELECT @QueryString = @QueryString + "LEFT JOIN Appropriate AppropTissue ON AppropTissue.AppropriateID = Referral.ReferralTissueAppropriateID "
          SELECT @QueryString = @QueryString + "LEFT JOIN Appropriate AppropSkin ON AppropSkin.AppropriateID = Referral.ReferralSkinAppropriateID "
          SELECT @QueryString = @QueryString + "LEFT JOIN Appropriate AppropValve ON AppropValve.AppropriateID = Referral.ReferralValvesAppropriateID "
          SELECT @QueryString = @QueryString + "LEFT JOIN Appropriate AppropEyes ON AppropEyes.AppropriateID = Referral.ReferralEyesTransAppropriateID "
          SELECT @QueryString = @QueryString + "LEFT JOIN Approach ApproaOrgan ON ApproaOrgan.ApproachID = Referral.ReferralOrganApproachID "
          SELECT @QueryString = @QueryString + "LEFT JOIN Approach ApproaBone ON ApproaBone.ApproachID = Referral.ReferralBoneApproachID "
          SELECT @QueryString = @QueryString + "LEFT JOIN Approach ApproaTissue ON ApproaTissue.ApproachID = Referral.ReferralTissueApproachID "
          SELECT @QueryString = @QueryString + "LEFT JOIN Approach ApproaSkin ON ApproaSkin.ApproachID = Referral.ReferralSkinApproachID "
          SELECT @QueryString = @QueryString + "LEFT JOIN Approach ApproaValve ON ApproaValve.ApproachID = Referral.ReferralValvesApproachID "
          SELECT @QueryString = @QueryString + "LEFT JOIN Approach ApproaEyes ON ApproaEyes.ApproachID = Referral.ReferralEyesTransApproachID "
          SELECT @QueryString = @QueryString + "LEFT JOIN Consent ConsentOrgan ON ConsentOrgan.ConsentID = Referral.ReferralOrganConsentID "
          SELECT @QueryString = @QueryString + "LEFT JOIN Consent ConsentBone ON ConsentBone.ConsentID = Referral.ReferralBoneConsentID "
          SELECT @QueryString = @QueryString + "LEFT JOIN Consent ConsentTissue ON ConsentTissue.ConsentID = Referral.ReferralTissueConsentID "
          SELECT @QueryString = @QueryString + "LEFT JOIN Consent ConsentSkin ON ConsentSkin.ConsentID = Referral.ReferralSkinConsentID "
          SELECT @QueryString = @QueryString + "LEFT JOIN Consent ConsentValve ON ConsentValve.ConsentID = Referral.ReferralValvesConsentID "
          SELECT @QueryString = @QueryString + "LEFT JOIN Consent ConsentEyes ON ConsentEyes.ConsentID = Referral.ReferralEyesTransConsentID "
          SELECT @QueryString = @QueryString + "LEFT JOIN Conversion RecoveryOrgan ON RecoveryOrgan.ConversionID = Referral.ReferralOrganConversionID "
          SELECT @QueryString = @QueryString + "LEFT JOIN Conversion RecoveryBone ON RecoveryBone.ConversionID = Referral.ReferralBoneConversionID "
          SELECT @QueryString = @QueryString + "LEFT JOIN Conversion RecoveryTissue ON RecoveryTissue.ConversionID = Referral.ReferralTissueConversionID "
          SELECT @QueryString = @QueryString + "LEFT JOIN Conversion RecoverySkin ON RecoverySkin.ConversionID = Referral.ReferralSkinConversionID "
          SELECT @QueryString = @QueryString + "LEFT JOIN Conversion RecoveryValve ON RecoveryValve.ConversionID = Referral.ReferralValvesConversionID "
          SELECT @QueryString = @QueryString + "LEFT JOIN Conversion RecoveryEyes ON RecoveryEyes.ConversionID = Referral.ReferralEyesTransConversionID "
          SELECT @QueryString = @QueryString + "LEFT JOIN ReferralSecondaryData ON ReferralSecondaryData.ReferralID = Referral.ReferralID "

     IF @pvCallID > 0
     BEGIN
          SELECT @QueryString = @QueryString + "WHERE Call.CALLID = " 
          SELECT @QueryString = @QueryString + CONVERT(VARCHAR(15),@pvCallID)
     END

     ELSE
     BEGIN
          SELECT @QueryString = @QueryString + "WHERE CallDateTime BETWEEN '"

          SELECT @QueryString = @QueryString + convert(varchar(20),@pvStartDate) --00/00/00 00:00:00
          SELECT @QueryString = @QueryString + "' AND '"
          SELECT @QueryString = @QueryString + convert(varchar(20), @pvEndDate )
          SELECT @QueryString = @QueryString + "' AND WebReportGroupOrg.WebReportGroupID = "
          SELECT @QueryString = @QueryString + convert(char(25),@pvReportGroupID)
     IF @pvUserOrgID <> 194
     BEGIN
          SELECT @QueryString = @QueryString + " AND CALL.SourceCodeID IN ( "
          SELECT @QueryString = @QueryString + @SCIList
--          SELECT @QueryString = @QueryString + convert(char(25), @pvReportGroupID)
          SELECT @QueryString = @QueryString + " ) "
     END

     IF @pvReferralTypeID > 0      
     BEGIN          
          SELECT @QueryString = @QueryString + "AND Referral.ReferralTypeID = "
          SELECT @QueryString = @QueryString + convert(char(1), @pvReferralTypeID )
     END
     
     IF @PvOrgID <> 0
          BEGIN
               SELECT @QueryString = @QueryString + " AND Referral.ReferralCallerOrganizationID = " 
               SELECT @QueryString = @QueryString + convert(char(25),@PvOrgID)
          END

          SELECT @QueryString = @QueryString + " ORDER BY "
          SELECT @QueryString = @QueryString + @pvOrderBy     
     END -- end CallID Exists   
    
     --select @QueryString
     EXEC(@QueryString )




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

