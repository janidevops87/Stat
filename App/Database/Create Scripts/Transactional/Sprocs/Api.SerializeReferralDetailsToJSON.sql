IF NOT EXISTS (SELECT schema_name FROM information_schema.schemata WHERE   schema_name = 'Api' ) 
BEGIN
	EXEC sp_executesql N'CREATE SCHEMA Api'
END
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SerializeReferralDetailsToJSON')
	BEGIN
		PRINT 'Dropping Procedure SerializeReferralDetailsToJSON'
		DROP Procedure [Api].[SerializeReferralDetailsToJSON]
	END
GO

PRINT 'Creating Procedure SerializeReferralDetailsToJSON'
GO

CREATE PROCEDURE [Api].[SerializeReferralDetailsToJSON] (@XML AS VARCHAR(MAX),  @JSONOUTPUT VARCHAR(MAX) OUTPUT)
AS
		/******************************************************************************
		**	File: Api.SerializeReferralDetailsToJSON.sql 
		**	Name: SerializeReferralDetailsToJSON
		**	Desc: Generate Json 
		**	Auth: Ilya Osipov
		**	Date: 9/28/2017
		*******************************************************************************/

BEGIN
    DECLARE 
			@JSON NVARCHAR(MAX),			
			@XML_DATA xml;

	IF OBJECT_ID('tempdb.dbo.#tmpDetailsRows') IS NOT NULL
	DROP TABLE #tmpDetailsRows;
			 	 
 CREATE TABLE #tmpDetailsRows
        (
          Data1 NVARCHAR(MAX),
		  Data2 NVARCHAR(MAX),
		  Data3 NVARCHAR(MAX),
		  Data4 NVARCHAR(MAX) 
        )    

	SELECT @XML_DATA = CAST(CAST(@XML AS varchar(MAX)) AS XML); 
	
	INSERT INTO #tmpDetailsRows(Data1,Data2,Data3,Data4)
	SELECT  '{' 	
		    + '"ApproachBy" : "' + x.RowRef.query('./ApproachBy').value('.', 'nvarchar(255)') + '",'
			+ '"ApproachTypeName" : "' + x.RowRef.query('./ApproachTypeName').value('.', 'nvarchar(255)') + '",' 
			+ '"AttendingPhysician" : "' + x.RowRef.query('./AttendingPhysician').value('.', 'nvarchar(255)') + '",'
			+ '"CallDateTime" : "' + x.RowRef.query('./CallDateTime').value('.', 'nvarchar(30)') + '",' 
 			+ '"Caller" : "' + x.RowRef.query('./Caller').value('.', 'nvarchar(255)') + '",' 
 			+ '"CallerOrganizationUnit" : "' + x.RowRef.query('./CallerOrganizationUnit').value('.', 'nvarchar(255)') + '",' 
			+ '"CallerPhone" : "' + x.RowRef.query('./CallerPhone').value('.', 'nvarchar(255)') + '",' 
			+ '"CallNumber" : "' + x.RowRef.query('./CallNumber').value('.', 'nvarchar(255)') + '",' 
			+ '"CauseOfDeathName" : "' + x.RowRef.query('./CauseOfDeathName').value('.', 'nvarchar(255)') + '",' 
			+ '"CoronerName" : "' + x.RowRef.query('./CoronerName').value('.', 'nvarchar(80)') + '",' 
			+ '"CoronerNote" : "' + x.RowRef.query('./CoronerNote').value('.', 'nvarchar(255)') + '",' 
			+ '"CoronerOrganization" : "' + x.RowRef.query('./CoronerOrganization').value('.', 'nvarchar(80)') + '",' 
			+ '"CoronerPhone" : "' + x.RowRef.query('./CoronerPhone').value('.', 'nvarchar(14)') + '",' 
			+ '"CoronerState" : "' + x.RowRef.query('./CoronerState').value('.', 'nvarchar(255)') + '",' 
			+ '"CoronorsCase" : "' + x.RowRef.query('./CoronorsCase').value('.', 'nvarchar(10)') + '",' 
			+ '"CountyName" : "' + x.RowRef.query('./CountyName').value('.', 'nvarchar(255)') + '",' 
			+ '"CurrentReferralTypeId" : '+ CASE WHEN  LEN( x.RowRef.query('./CurrentReferralTypeID').value('.', 'nvarchar(10)')) = 0 then 'null' else  x.RowRef.query('./CurrentReferralTypeID').value('.', 'nvarchar(10)') END  + ',' 
			+ '"CustomField_1" : "' + x.RowRef.query('./customField_1').value('.', 'nvarchar(40)') + '",' 
			+ '"CustomField_2" : "' + x.RowRef.query('./customField_2').value('.', 'nvarchar(40)') + '",' 
			+ '"CustomField_3" : "' + x.RowRef.query('./customField_3').value('.', 'nvarchar(40)') + '",' 
			+ '"CustomField_4" : "' + x.RowRef.query('./customField_4').value('.', 'nvarchar(40)') + '",' 
			+ '"CustomField_5" : "' + x.RowRef.query('./customField_5').value('.', 'nvarchar(40)') + '",' 
			+ '"CustomField_6" : "' + x.RowRef.query('./customField_6').value('.', 'nvarchar(40)') + '",' 
			+ '"CustomField_7" : "' + x.RowRef.query('./customField_7').value('.', 'nvarchar(255)') + '",' 
			+ '"CustomField_8" : "' + x.RowRef.query('./customField_8').value('.', 'nvarchar(255)') + '",' 
			+ '"CustomField_9" : "' + x.RowRef.query('./customField_9').value('.', 'nvarchar(40)') + '",' 
			+ '"CustomField_10" : "' + x.RowRef.query('./customField_10').value('.', 'nvarchar(40)') + '",' 
			+ '"CustomField_11" : "' + x.RowRef.query('./customField_11').value('.', 'nvarchar(40)') + '",' 
			+ '"CustomField_12" : "' + x.RowRef.query('./customField_12').value('.', 'nvarchar(40)') + '",' 
			+ '"CustomField_13" : "' + x.RowRef.query('./customField_13').value('.', 'nvarchar(40)') + '",'
			+ '"CustomField_14" : "' + x.RowRef.query('./customField_14').value('.', 'nvarchar(40)') + '",' 
			+ '"CustomField_15" : "' + x.RowRef.query('./customField_15').value('.', 'nvarchar(40)') + '",' 
			+ '"CustomField_16" : "' + x.RowRef.query('./customField_16').value('.', 'nvarchar(40)') + '",' ,
			'"DOA" : "' + x.RowRef.query('./DOA').value('.', 'nvarchar(255)') + '",' 
			+ '"CallLastModified" : "' + x.RowRef.query('./CallLastModified').value('.', 'nvarchar(255)') + '",' 
			+ '"MedicalHistory" : "' + x.RowRef.query('./MedicalHistory').value('.', 'nvarchar(255)') + '",' 
			+ '"NOKCity" : "' + x.RowRef.query('./NOKCity').value('.', 'nvarchar(255)') + '",'
 			+ '"NOKFirstName" : "' + x.RowRef.query('./NOKFirstName').value('.', 'nvarchar(255)') + '",' 
 			+ '"NOKLastName" : "' + x.RowRef.query('./NOKLastName').value('.', 'nvarchar(255)') + '",' 
 			+ '"NOKPhone" : "' + x.RowRef.query('./NOKPhone').value('.', 'nvarchar(255)') + '",' 
 			+ '"NOKState" : "' + x.RowRef.query('./NOKState').value('.', 'nvarchar(255)') + '",' 
 			+ '"NOKZip" : "' + x.RowRef.query('./NOKZip').value('.', 'nvarchar(255)') + '",' 
 			+ '"OrganizationName" : "' + x.RowRef.query('./OrganizationName').value('.', 'nvarchar(255)') + '",' 
			+ '"OrganizationUserCode" : "' + x.RowRef.query('./OrganizationUserCode').value('.', 'nvarchar(255)') + '",' 
			+ '"PatientHasHeartbeat" : "' + x.RowRef.query('./PatientHasHeartbeat').value('.', 'nvarchar(255)') + '",'
			+ '"PatientWeight_Decimal" : "' + x.RowRef.query('./PatientWeight_Decimal').value('.', 'nvarchar(255)') + '",'
			+ '"PersonTypeName" : "' + x.RowRef.query('./PersonTypeName').value('.', 'nvarchar(255)') + '",'
			+ '"PronouncingPhysician" : "' + x.RowRef.query('./PronouncingPhysician').value('.', 'nvarchar(255)') + '",'
			+ '"RaceName" : "' + x.RowRef.query('./RaceName').value('.', 'nvarchar(255)') + '",'
			+ '"ReferralAllTissueDispositionId" : '+ CASE WHEN  LEN( x.RowRef.query('./ReferralAllTissueDispositionID').value('.', 'nvarchar(10)')) = 0 then 'null' else  x.RowRef.query('./ReferralAllTissueDispositionID').value('.', 'nvarchar(10)') END  + ','
			+ '"ReferralApproachNOK" : "' + x.RowRef.query('./ReferralApproachNOK').value('.', 'nvarchar(255)') + '",'
			+ '"ReferralApproachRelation" : "' + x.RowRef.query('./ReferralApproachRelation').value('.', 'nvarchar(255)') + '",'
			+ '"ReferralApproachTypeId" : ' + CASE WHEN  LEN( x.RowRef.query('./ReferralApproachTypeID').value('.', 'nvarchar(10)')) = 0 then 'null' else  x.RowRef.query('./ReferralApproachTypeID').value('.', 'nvarchar(10)') END  + ','
			+ '"ReferralAttendingMDPhone" : "' + x.RowRef.query('./ReferralAttendingMDPhone').value('.', 'nvarchar(255)') + '",'
			+ '"ReferralBoneApproachId" : ' + CASE WHEN  LEN( x.RowRef.query('./ReferralBoneApproachID').value('.', 'nvarchar(10)')) = 0 then 'null' else  x.RowRef.query('./ReferralBoneApproachID').value('.', 'nvarchar(10)') END  + ','
			+ '"ReferralBoneAppropriateId" : ' + CASE WHEN  LEN( x.RowRef.query('./ReferralBoneAppropriateID').value('.', 'nvarchar(10)')) = 0 then 'null' else  x.RowRef.query('./ReferralBoneAppropriateID').value('.', 'nvarchar(10)') END  + ','
			+ '"ReferralBoneConsentId" : ' + CASE WHEN  LEN( x.RowRef.query('./ReferralBoneConsentID').value('.', 'nvarchar(10)')) = 0 then 'null' else  x.RowRef.query('./ReferralBoneConsentID').value('.', 'nvarchar(10)') END  + ','
			+ '"ReferralBoneConversionId" : ' + CASE WHEN  LEN( x.RowRef.query('./ReferralBoneConversionID').value('.', 'nvarchar(10)')) = 0 then 'null' else  x.RowRef.query('./ReferralBoneConversionID').value('.', 'nvarchar(10)') END  + ','
			+ '"ReferralBoneDispositionId" : ' + CASE WHEN  LEN( x.RowRef.query('./ReferralBoneDispositionID').value('.', 'nvarchar(10)')) = 0 then 'null' else  x.RowRef.query('./ReferralBoneDispositionID').value('.', 'nvarchar(10)') END  + ','
			+ '"ReferralCallerExtension" : "' + x.RowRef.query('./ReferralCallerExtension').value('.', 'nvarchar(255)') + '",'
			+ '"ReferralCoronersCase" : ' + x.RowRef.query('./ReferralCoronersCase').value('.', 'nvarchar(255)') + ','
			+ '"ReferralDOB" : "'+ x.RowRef.query('./ReferralDOB').value('.', 'nvarchar(255)') + '",'
			+ '"ReferralDonor_ILB" : ' + x.RowRef.query('./ReferralDonor_ILB').value('.', 'nvarchar(255)') + ',' 
			+ '"ReferralDonorAdmitDate" : ' + CASE WHEN  LEN( x.RowRef.query('./ReferralDonorAdmitDate').value('.', 'nvarchar(20)')) = 0 then 'null' else '"'+ x.RowRef.query('./ReferralDonorAdmitDate').value('.', 'nvarchar(20)') +'"' END  + ',' 
			+ '"ReferralDonorAdmitTime" : "' + x.RowRef.query('./ReferralDonorAdmitTime').value('.', 'nvarchar(255)') + '",' 
			+ '"ReferralDonorAge" : "' + x.RowRef.query('./ReferralDonorAge').value('.', 'nvarchar(255)') + '",' 
			+ '"ReferralDonorAgeUnit" : "' + x.RowRef.query('./ReferralDonorAgeUnit').value('.', 'nvarchar(255)') + '",' 
			+ '"ReferralDonorBrainDeathDate" : ' + CASE WHEN  LEN( x.RowRef.query('./ReferralDonorBrainDeathDate').value('.', 'nvarchar(20)')) = 0 then 'null' else '"'+  x.RowRef.query('./ReferralDonorBrainDeathDate').value('.', 'nvarchar(20)') +'"'  END  + ',' 
			+ '"ReferralDonorBrainDeathTime" : "' + x.RowRef.query('./ReferralDonorBrainDeathTime').value('.', 'nvarchar(255)') + '",' 
			+ '"ReferralDonorCauseOfDeathId" : '+ CASE WHEN  LEN( x.RowRef.query('./ReferralDonorCauseOfDeathID').value('.', 'nvarchar(10)')) = 0 then 'null' else  x.RowRef.query('./ReferralDonorCauseOfDeathID').value('.', 'nvarchar(10)') END  + ',' 
			+ '"ReferralDonorDeathDate" : "' + x.RowRef.query('./ReferralDonorDeathDate').value('.', 'nvarchar(20)') + '",' 
			+ '"ReferralDonorDeathTime" : "' + x.RowRef.query('./ReferralDonorDeathTime').value('.', 'nvarchar(10)') + '",' 
			+ '"ReferralDonorFirstName" : "' + x.RowRef.query('./ReferralDonorFirstName').value('.', 'nvarchar(255)') + '",' 
			+ '"ReferralDonorGender" : "' + x.RowRef.query('./ReferralDonorGender').value('.', 'nvarchar(10)') + '",' 
			+ '"ReferralDonorLastName" : "' + x.RowRef.query('./ReferralDonorLastName').value('.', 'nvarchar(255)') + '",' 
			+ '"ReferralDonorLSADate" : '+ CASE WHEN  LEN( x.RowRef.query('./ReferralDonorLSADate').value('.', 'nvarchar(20)')) = 0 then 'null' else '"'+ x.RowRef.query('./ReferralDonorLSADate').value('.', 'nvarchar(20)') +'"' END  + ',' 
 			+ '"ReferralDonorLSATime" : "' + x.RowRef.query('./ReferralDonorLSATime').value('.', 'nvarchar(255)') + '",'
 			+ '"ReferralDonorNameMI" : "' + x.RowRef.query('./ReferralDonorNameMI').value('.', 'nvarchar(255)') + '",' ,
 			'"ReferralDonorOnVentilator" : "' + x.RowRef.query('./ReferralDonorOnVentilator').value('.', 'nvarchar(255)') + '",' 
 			+ '"ReferralDonorRaceId" : '+ CASE WHEN  LEN( x.RowRef.query('./ReferralDonorRaceID').value('.', 'nvarchar(10)')) = 0 then 'null' else  x.RowRef.query('./ReferralDonorRaceID').value('.', 'nvarchar(10)') END  + ',' 
 			+ '"ReferralDonorRecNumber" : "' + x.RowRef.query('./ReferralDonorRecNumber').value('.', 'nvarchar(255)') + '",' 
 			+ '"ReferralDonorSpecificCOD" : "' + x.RowRef.query('./ReferralDonorSpecificCOD').value('.', 'nvarchar(255)') + '",'
			+ '"ReferralDonorSSN" : "' + x.RowRef.query('./ReferralDonorSSN').value('.', 'nvarchar(255)') + '",'
			+ '"ReferralDonorWeight" : "' + x.RowRef.query('./ReferralDonorWeight').value('.', 'nvarchar(255)') + '",'
			+ '"ReferralExtubated" : "' + x.RowRef.query('./ReferralExtubated').value('.', 'nvarchar(255)') + '",'
			+ '"ReferralEyesDispositionId" : '+ CASE WHEN  LEN( x.RowRef.query('./ReferralEyesDispositionID').value('.', 'nvarchar(10)')) = 0 then 'null' else  x.RowRef.query('./ReferralEyesDispositionID').value('.', 'nvarchar(10)') END  + ','
			+ '"ReferralEyesRschApproachId" : '+ CASE WHEN  LEN( x.RowRef.query('./ReferralEyesRschApproachID').value('.', 'nvarchar(10)')) = 0 then 'null' else  x.RowRef.query('./ReferralEyesRschApproachID').value('.', 'nvarchar(10)') END  + ','
			+ '"ReferralEyesRschAppropriateId" : '+ CASE WHEN  LEN( x.RowRef.query('./ReferralEyesTransAppropriateID').value('.', 'nvarchar(10)')) = 0 then 'null' else  x.RowRef.query('./ReferralEyesTransAppropriateID').value('.', 'nvarchar(10)') END  + ','
			+ '"ReferralEyesRschConsentId" : '+ CASE WHEN  LEN( x.RowRef.query('./ReferralEyesRschConsentID').value('.', 'nvarchar(10)')) = 0 then 'null' else  x.RowRef.query('./ReferralEyesRschConsentID').value('.', 'nvarchar(10)') END  + ','
			+ '"ReferralEyesRschConversionId" : '+ CASE WHEN  LEN( x.RowRef.query('./ReferralEyesRschConversionID').value('.', 'nvarchar(10)')) = 0 then 'null' else  x.RowRef.query('./ReferralEyesRschConversionID').value('.', 'nvarchar(10)') END  + ','
			+ '"ReferralEyesTransApproachId" : '+ CASE WHEN  LEN( x.RowRef.query('./ReferralEyesTransApproachID').value('.', 'nvarchar(10)')) = 0 then 'null' else  x.RowRef.query('./ReferralEyesTransApproachID').value('.', 'nvarchar(10)') END  + ','
			+ '"ReferralEyesTransAppropriateId" : '+ CASE WHEN  LEN( x.RowRef.query('./ReferralEyesTransAppropriateID').value('.', 'nvarchar(10)')) = 0 then 'null' else  x.RowRef.query('./ReferralEyesTransAppropriateID').value('.', 'nvarchar(10)') END  + ','
			+ '"ReferralEyesTransConsentId" : '+ CASE WHEN  LEN( x.RowRef.query('./ReferralEyesTransConsentID').value('.', 'nvarchar(10)')) = 0 then 'null' else  x.RowRef.query('./ReferralEyesTransConsentID').value('.', 'nvarchar(10)') END  + ','
			+ '"ReferralEyesTransConversionId" : '+ CASE WHEN  LEN( x.RowRef.query('./ReferralEyesTransConversionID').value('.', 'nvarchar(10)')) = 0 then 'null' else  x.RowRef.query('./ReferralEyesTransConversionID').value('.', 'nvarchar(10)') END  + ','
			+ '"ReferralGeneralConsent" : '+ CASE WHEN  LEN( x.RowRef.query('./ReferralGeneralConsent').value('.', 'nvarchar(10)')) = 0 then 'null' else  x.RowRef.query('./ReferralGeneralConsent').value('.', 'nvarchar(10)') END  + ','
			+ '"ReferralId" : ' + x.RowRef.query('./ReferralID').value('.', 'nvarchar(255)') + ','
			+ '"ReferralLastModified" : "'+ CASE WHEN  LEN( x.RowRef.query('./ReferralLastModified').value('.', 'nvarchar(10)')) = 0 then 'null' else  x.RowRef.query('./ReferralLastModified').value('.', 'nvarchar(10)') END  + '",' 
			+ '"ReferralNOKAddress" : "' + x.RowRef.query('./ReferralNOKAddress').value('.', 'nvarchar(255)') + '",'
 			+ '"ReferralNotesCase" : "' + x.RowRef.query('./ReferralNotesCase').value('.', 'nvarchar(255)') + '",'
 			+ '"ReferralOrganApproachId" : '+ CASE WHEN  LEN( x.RowRef.query('./ReferralOrganApproachID').value('.', 'nvarchar(10)')) = 0 then 'null' else  x.RowRef.query('./ReferralOrganApproachID').value('.', 'nvarchar(10)') END  + ','
			+ '"ReferralOrganAppropriateId" : '+ CASE WHEN  LEN( x.RowRef.query('./ReferralOrganAppropriateID').value('.', 'nvarchar(10)')) = 0 then 'null' else  x.RowRef.query('./ReferralOrganAppropriateID').value('.', 'nvarchar(10)') END  + ','
			+ '"ReferralOrganConsentId" : '+ CASE WHEN  LEN( x.RowRef.query('./ReferralOrganConsentID').value('.', 'nvarchar(10)')) = 0 then 'null' else  x.RowRef.query('./ReferralOrganConsentID').value('.', 'nvarchar(10)') END  + ','
			+ '"ReferralOrganConversionId" : '+ CASE WHEN  LEN( x.RowRef.query('./ReferralOrganConversionID').value('.', 'nvarchar(10)')) = 0 then 'null' else  x.RowRef.query('./ReferralOrganConversionID').value('.', 'nvarchar(10)') END  + ','
			+ '"ReferralOrganDispositionId" : '+ CASE WHEN  LEN( x.RowRef.query('./ReferralOrganDispositionID').value('.', 'nvarchar(10)')) = 0 then 'null' else  x.RowRef.query('./ReferralOrganDispositionID').value('.', 'nvarchar(10)') END  + ','
			+ '"ReferralPronouncingMDPhone" : "' + x.RowRef.query('./ReferralPronouncingMDPhone').value('.', 'nvarchar(255)') + '",'
			+ '"ReferralRschDispositionId" : '+ CASE WHEN  LEN( x.RowRef.query('./ReferralRschDispositionID').value('.', 'nvarchar(10)')) = 0 then 'null' else  x.RowRef.query('./ReferralRschDispositionID').value('.', 'nvarchar(10)') END  + ','
 			+ '"ReferralSkinApproachId" : '+ CASE WHEN  LEN( x.RowRef.query('./ReferralSkinApproachID').value('.', 'nvarchar(10)')) = 0 then 'null' else  x.RowRef.query('./ReferralSkinApproachID').value('.', 'nvarchar(10)') END  + ','
 			+ '"ReferralSkinAppropriateId" : '+ CASE WHEN  LEN( x.RowRef.query('./ReferralSkinAppropriateID').value('.', 'nvarchar(10)')) = 0 then 'null' else  x.RowRef.query('./ReferralSkinAppropriateID').value('.', 'nvarchar(10)') END  + ','
			+ '"ReferralSkinConsentId" : '+ CASE WHEN  LEN( x.RowRef.query('./ReferralSkinConsentID').value('.', 'nvarchar(10)')) = 0 then 'null' else  x.RowRef.query('./ReferralSkinConsentID').value('.', 'nvarchar(10)') END  + ','
			+ '"ReferralSkinConversionId" : '+ CASE WHEN  LEN( x.RowRef.query('./ReferralSkinConversionID').value('.', 'nvarchar(10)')) = 0 then 'null' else  x.RowRef.query('./ReferralSkinConversionID').value('.', 'nvarchar(10)') END  + ','
			+ '"ReferralSkinDispositionId" : '+ CASE WHEN  LEN( x.RowRef.query('./ReferralSkinDispositionID').value('.', 'nvarchar(10)')) = 0 then 'null' else  x.RowRef.query('./ReferralSkinDispositionID').value('.', 'nvarchar(10)') END  + ','
			+ '"ReferralStatus" : "' + x.RowRef.query('./ReferralStatus').value('.', 'nvarchar(255)') + '",'
 			+ '"ReferralStatusId" : ' + x.RowRef.query('./ReferralStatusID').value('.', 'nvarchar(255)') + ','  
 			+ '"ReferralTissueApproachId" : '+ CASE WHEN  LEN( x.RowRef.query('./ReferralTissueApproachID').value('.', 'nvarchar(10)')) = 0 then 'null' else  x.RowRef.query('./ReferralTissueApproachID').value('.', 'nvarchar(10)') END  + ',' 
			+ '"ReferralTissueAppropriateId" : '+ CASE WHEN  LEN( x.RowRef.query('./ReferralTissueAppropriateID').value('.', 'nvarchar(10)')) = 0 then 'null' else  x.RowRef.query('./ReferralTissueAppropriateID').value('.', 'nvarchar(10)') END  + ',' 
			+ '"ReferralTissueConsentId" : '+ CASE WHEN  LEN( x.RowRef.query('./ReferralTissueConsentID').value('.', 'nvarchar(10)')) = 0 then 'null' else  x.RowRef.query('./ReferralTissueConsentID').value('.', 'nvarchar(10)') END  + ',' 
			+ '"ReferralTissueConversionId" : '+ CASE WHEN  LEN( x.RowRef.query('./ReferralTissueConversionID').value('.', 'nvarchar(10)')) = 0 then 'null' else  x.RowRef.query('./ReferralTissueConversionID').value('.', 'nvarchar(10)') END  + ',' 
			+ '"ReferralTissueDispositionId" : '+ CASE WHEN  LEN( x.RowRef.query('./ReferralTissueDispositionID').value('.', 'nvarchar(10)')) = 0 then 'null' else  x.RowRef.query('./ReferralTissueDispositionID').value('.', 'nvarchar(10)') END  + ','
			+ '"ReferralTypeId" : '+ CASE WHEN  LEN( x.RowRef.query('./ReferralTypeID').value('.', 'nvarchar(10)')) = 0 then 'null' else  x.RowRef.query('./ReferralTypeID').value('.', 'nvarchar(10)') END  + ',' 	
			+ '"ReferralTypeName" : "' + x.RowRef.query('./ReferralTypeName').value('.', 'nvarchar(255)') + '",' 
			+ '"ReferralValvesApproachId" : '+ CASE WHEN  LEN( x.RowRef.query('./ReferralValvesApproachID').value('.', 'nvarchar(10)')) = 0 then 'null' else  x.RowRef.query('./ReferralValvesApproachID').value('.', 'nvarchar(10)') END  + ','
			+ '"ReferralValvesAppropriateId" : '+ CASE WHEN  LEN( x.RowRef.query('./ReferralValvesAppropriateID').value('.', 'nvarchar(10)')) = 0 then 'null' else  x.RowRef.query('./ReferralValvesAppropriateID').value('.', 'nvarchar(10)') END  + ',' 
			+ '"ReferralValvesConsentId" : '+ CASE WHEN  LEN( x.RowRef.query('./ReferralValvesConsentID').value('.', 'nvarchar(10)')) = 0 then 'null' else  x.RowRef.query('./ReferralValvesConsentID').value('.', 'nvarchar(10)') END  + ',' 
			+ '"ReferralValvesConversionId" : '+ CASE WHEN  LEN( x.RowRef.query('./ReferralValvesConversionID').value('.', 'nvarchar(10)')) = 0 then 'null' else  x.RowRef.query('./ReferralValvesConversionID').value('.', 'nvarchar(10)') END  + ','
 			+ '"ReferralValvesDispositionId" : '+ CASE WHEN  LEN( x.RowRef.query('./ReferralValvesDispositionID').value('.', 'nvarchar(10)')) = 0 then 'null' else  x.RowRef.query('./ReferralValvesDispositionID').value('.', 'nvarchar(10)') END  + ','
			+ '"RegistryStatusId" : '+ CASE WHEN  LEN( x.RowRef.query('./RegistryStatusID').value('.', 'nvarchar(10)')) = 0 then 'null' else  x.RowRef.query('./RegistryStatusID').value('.', 'nvarchar(10)') END  + ','
 			+ '"RegistryStatusType" : "' + x.RowRef.query('./RegistryStatusType').value('.', 'nvarchar(255)') + '",',
			 '"ServiceLevelCustomFieldLabel_1" : "' +  x.RowRef.query('./ServiceLevelCustomFieldLabel_1').value('.', 'nvarchar(40)') + '",'
			+ '"ServiceLevelCustomFieldLabel_2" : "' +  x.RowRef.query('./ServiceLevelCustomFieldLabel_2').value('.', 'nvarchar(40)') + '",'
			+ '"ServiceLevelCustomFieldLabel_3" : "' +  x.RowRef.query('./ServiceLevelCustomFieldLabel_3').value('.', 'nvarchar(40)') + '",'
			+ '"ServiceLevelCustomFieldLabel_4" : "' +  x.RowRef.query('./ServiceLevelCustomFieldLabel_4').value('.', 'nvarchar(40)') + '",'
			+ '"ServiceLevelCustomFieldLabel_5" : "' +  x.RowRef.query('./ServiceLevelCustomFieldLabel_5').value('.', 'nvarchar(40)') + '",'
			+ '"ServiceLevelCustomFieldLabel_6" : "' +  x.RowRef.query('./ServiceLevelCustomFieldLabel_6').value('.', 'nvarchar(40)') + '",'
			+ '"ServiceLevelCustomFieldLabel_7" : "' +  x.RowRef.query('./ServiceLevelCustomFieldLabel_7').value('.', 'nvarchar(40)') + '",' 
			+ '"ServiceLevelCustomFieldLabel_8" : "' +  x.RowRef.query('./ServiceLevelCustomFieldLabel_8').value('.', 'nvarchar(40)') + '",' 
			+ '"ServiceLevelCustomFieldLabel_9" : "' +  x.RowRef.query('./ServiceLevelCustomFieldLabel_9').value('.', 'nvarchar(40)') + '",' 
			+ '"ServiceLevelCustomFieldLabel_10" : "' +  x.RowRef.query('./ServiceLevelCustomFieldLabel_10').value('.', 'nvarchar(40)') + '",' 
			+ '"ServiceLevelCustomFieldLabel_11" : "' +  x.RowRef.query('./ServiceLevelCustomFieldLabel_11').value('.', 'nvarchar(40)') + '",' 
			+ '"ServiceLevelCustomFieldLabel_12" : "' +  x.RowRef.query('./ServiceLevelCustomFieldLabel_12').value('.', 'nvarchar(40)') + '",' 
			+ '"ServiceLevelCustomFieldLabel_13" : "' +  x.RowRef.query('./ServiceLevelCustomFieldLabel_13').value('.', 'nvarchar(40)') + '",' 
			+ '"ServiceLevelCustomFieldLabel_14" : "' +  x.RowRef.query('./ServiceLevelCustomFieldLabel_14').value('.', 'nvarchar(40)') + '",'
			+ '"ServiceLevelCustomFieldLabel_15" : "' +  x.RowRef.query('./ServiceLevelCustomFieldLabel_15').value('.', 'nvarchar(40)') + '",'
			+ '"ServiceLevelCustomFieldLabel_16" : "' +  x.RowRef.query('./ServiceLevelCustomFieldLabel_16').value('.', 'nvarchar(40)') + '",'
			+ '"StatEmployee" : "' + x.RowRef.query('./StatEmployee').value('.', 'nvarchar(255)') + '",'
 			+ '"WebReportGroupId" : ' + x.RowRef.query('./WebReportGroupID').value('.', 'nvarchar(255)')+ ','
			+ '"ReferralLogEvents" : "--EventLogToReplace--"'
			+ '},'	 		 
	FROM @XML_DATA.nodes('/referral/row') as x(RowRef);   
  
    SET @JSON = '';


  
   IF EXISTS(SELECT * FROM #tmpDetailsRows)
	BEGIN
		WHILE EXISTS (SELECT * FROM #tmpDetailsRows) 
			BEGIN 			
				SELECT @JSON = (@JSON + Data1 + Data2 + Data3 + Data4) FROM #tmpDetailsRows;

				DELETE TOP(1) FROM #tmpDetailsRows
			END
	END


    IF LEN(@JSON) > 0
        SET @JSON = SubString(@JSON, 0, LEN(@JSON));
    SET @JSON = '[' + @JSON + ']';
 
    DROP TABLE #tmpDetailsRows;

    SELECT @JSONOUTPUT = @JSON;
END
