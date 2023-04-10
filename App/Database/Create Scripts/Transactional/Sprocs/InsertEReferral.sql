IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[InsertEReferral]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
	BEGIN
			DROP PROCEDURE [dbo].[InsertEReferral];
			PRINT 'Dropping Procedure: InsertEReferral';
	END

PRINT 'Creating Procedure: InsertEReferral'
GO

CREATE PROCEDURE dbo.InsertEReferral(
	@CallDateTime datetime = NULL,  
	@SourceCodeID int = NULL,  
	@StatEmployeeID int = NULL,
	@TimeZoneId int = NULL,
	@HeartbeatId int = NULL, 
	@HeartbeatName varchar(20) = NULL,
	@CurrentlyOnVentilatorId int = NULL,
	@CurrentlyOnVentilatorName varchar(20) = NULL,
	@ExtubationDate datetime = NULL,  
	@ContactFirstName varchar(40) = NULL,
	@ContactLastName varchar(40) = NULL,
	@ContactTitleId int = NULL,  
	@ContactTitleName varchar(50) = NULL,
	@CallbackPhoneNumber varchar(12) = NULL,
	@Extension varchar(5) = NULL,
	@ReferralFacilityId int = NULL,
	@ReferralFacilityName varchar(80) = NULL,
	@HospitalUnitId int  = NULL,  
	@HospitalUnitName varchar(50) = NULL,
	@Floor varchar(4) = NULL,    
	@MedicalRecordNumber varchar(30) = NULL,
	@PatientFirstName varchar(40) = NULL,
	@PatientLastName varchar(40) = NULL,
	@IdentityUnknown int = NULL,
	@CardiacDeathDateTime datetime = NULL, 
	@AdmitDateTime datetime = NULL,
	@DateOfBirth date = NULL,
	@Age varchar(4) = NULL,
	@AgeUnitId int = NULL,
	@AgeUnitName varchar(10) = NULL,
	@AgeIsEstimate int =NULL,
	@RaceId int = NULL, 
	@RaceName varchar(50) = NULL,
	@GenderId int = NULL,
	@GenderName varchar(1) = NULL, 
	@Weight decimal(6,1)=NULL, 
	@WeightUnitId int = NULL,
	@WeightUnitName varchar(50) = NULL,  
	@WeightIsEstimate int = NULL,
	@AdmittingDiagnosis varchar(950) = NULL,
	@PastMedicalHistory varchar(950) = NULL,
	@HivId int = NULL,
	@HivName varchar(50) = NULL,
	@AidsId int = NULL,
	@AidsName varchar(50) = NULL,
	@HepBId int = NULL,
	@HepBName varchar(50) = NULL,
	@HepCId int = NULL,
	@HepCName varchar(50) = NULL,
	@IvdaInLast5YearsId int = NULL,
	@IvdaInLast5YearsName varchar(50) = NULL,
	@CauseOfDeathID int = NULL, 
	@Ret varchar(25) OUTPUT
)

AS
/******************************************************************************
**		File: InsertEReferral.sql
**		Name: InsertEReferral
**		Desc:  Used in EReferral
**
**		Called by:   
**              
**
**		Auth: Pam Scheichenost
**		Date: 06/25/2020
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			----------------------------------------
**		06/25/2020	Pam Scheichenost	initial
*******************************************************************************/

/*
SELECT
	@CallDateTime = GETDATE(),  
	@SourceCodeID  = 194,  
	@StatEmployeeID  = 2940, 
	@HeartbeatId  = 2,
	@HeartbeatName  = 'No',
	@CurrentlyOnVentilatorId  = 2,
	@CurrentlyOnVentilatorName  = 'No, Previously',
	@ExtubationDate  = '06/15/2020',  
	@ContactFirstName = 'Contact',
	@ContactLastName  ='NewTest',
	@ContactTitleId  = 25,  --personTypeId
	@ContactTitleName  = 'Hospital Development (Procurement)',
	@CallbackPhoneNumber  = '615-151-5566',
	@Extension  ='2323',
	@ReferralFacilityId  = 6140,
	@ReferralFacilityName  = 'Castle Medical Center',
	@HospitalUnitId  = 106,  --sublocation
	@HospitalUnitName = '1-1 Ambulatory Care',
	@Floor  = '1',  --sublocationlevel  
	@MedicalRecordNumber  = '1234567980',
	@PatientFirstName ='Donor',
	@PatientLastName  = 'Tester3',
	@IdentityUnknown = 1,
	@CardiacDeathDateTime  = '06/22/2020 02:25',--todo split date and time, time needs tz
	@AdmitDateTime  = '06/21/2020 15:15',  --todo split date and time, time needs tz
	@DateOfBirth  = '01/01/1971',
	@Age  = '57',
	@AgeUnitId  = '1',
	@AgeUnitName  = 'Years',
	@AgeIsEstimate = 1,
	@RaceId  = 5,  --native american
	@RaceName  = 'Native American',
	@GenderId  = 2,
	@GenderName  = 'Female', 
	@Weight  = '56.5',  --to do, will have to convert
	@WeightUnitId  = 1,  --to do, might have to convert to was stattrac is expecting
	@WeightUnitName = 'kg',  --kg, g, lbs, oz
	@WeightIsEstimate = 1,
	@AdmittingDiagnosis  = 'Admitting test dislfjsldkfj sdlkfj sklfj dslkfj slkdjf kldsfj dsklfj dslkfj dlskjf lskjf lksdjf lksdjf lsdfj lsdjk fldks jflkdsj fklsdf jlkdsjf lkdsjf lkdsj flksj flksdj f',
	@PastMedicalHistory  = 'Past med hx sldfjlds kfj lskdfj lksdfj lksdjflksdjf lsdkjf ldskfj ldskjf lkdsjf lkdsjf lkdsj flkdsj fldskf jlkdjf kdsjf lkdsfj klsdfj kdsjf lksdjf lkdsj flkdsj fklsdjf lkdsjf klsfj ',
	@HivId = 0 ,
	@HivName = 'N/A',
	@AidsId = 2,
	@AidsName = 'No',
	@HepBId =3,
	@HepBName = 'Unknown',
	@HepCId = 1,
	@HepCName = 'Yes',
	@IvdaInLast5YearsId = 1,
	@IvdaInLast5YearsName = 'Yes'
*/

DECLARE
@CallId int,
@CallNumber varchar(15),
@ContactId int,
@ContactFullName varchar(80),
@PhoneAreaCode varchar(3) = null,   
@PhonePrefix varchar(3) = null,   
@PhoneNumber varchar(4) = null, 
@PhoneNumberId int,
@DonorName varchar(80),
@AdmitDate date,
@AdmitTime varchar(10),
@DeathDate date,
@DeathTime varchar(10),
@ExtubationDateString varchar(15),
@ReferralFacilityTimeZone varchar(2),
@WeightKg decimal(6,1),
@WeightString varchar(7),
@MedicalHistory varchar(400),
@OrganAppropriateId INT,
@BoneAppropriateId INT,
@SoftTissueAppropriateId INT,
@SkinAppropriateId INT,
@ValvesAppropriateId INT,
@EyesAppropriateId INT,
@OtherAppropriateId INT,
@PreviousReferralTypeID INT,
@CurrentReferralTypeID INT,
@ReferralTypeAbbreviation varchar(3),
@UKNOWNID INT = 7;

--call date/time in mt
SELECT @CallDateTime = GETDATE();
--Make sure facility name is filled in
IF (@ReferralFacilityName IS NULL OR @ReferralFacilityName = '')
BEGIN
	SELECT @ReferralFacilityName = OrganizationName
	FROM Organization
	WHERE OrganizationID = @ReferralFacilityId;
END

IF @CallbackPhoneNumber IS NOT NULL
BEGIN
	
	
	EXEC OrganizationPhoneNewCallInsert
		@OrganizationID = @ReferralFacilityId,
		@Phone  = @CallbackPhoneNumber,
		@LastStatEmployeeId = @StatEmployeeId,
		@SubLocationID = @HospitalUnitId,
		@SubLocationLevel = @Floor;

	SELECT   
		@PhoneAreaCode = PhoneAreaCode,   
		@PhonePrefix = PhonePrefix,   
		@PhoneNumber = PhoneNumber   
	 FROM  
	  fn_PhoneParse(@CallbackPhoneNumber);
	  
	  SELECT
		@PhoneNumberId = PhoneID FROM dbo.Phone where PhoneAreaCode = @PhoneAreaCode AND PhonePrefix = @PhonePrefix AND @PhoneNumber = @PhoneNumber;  


END

--Check if contact in person table
--Question -- what happens if they put in a different title?  new record??
IF ((SELECT COUNT(*) FROM dbo.Person WHERE PersonFirst = @ContactFirstName AND PersonLast = @ContactLastName AND OrganizationId = @ReferralFacilityId)= 0)
BEGIN
	EXEC dbo.PersonInsert
		@PersonFirst = @ContactFirstName,
		@PersonLast = @ContactLastName,
		@OrganizationId = @ReferralFacilityId,
		@PersonTypeId = @ContactTitleId,
		@Inactive = 0,
		@LastStatEmployeeID = @StatEmployeeID,
		@PersonID = @ContactId OUTPUT;


END
ELSE
BEGIN
	SELECT @ContactId = PersonId
	FROM dbo.Person
	WHERE PersonFirst = @ContactFirstName 
	AND PersonLast = @ContactLastName 
	AND OrganizationId = @ReferralFacilityId;
END		


CREATE TABLE #tblCallId (
	CallID int  , 
	CallNumber varchar(15)  , 
	CallTypeID int  , 
	CallDateTime smalldatetime  , 
	StatEmployeeID smallint  , 
	CallTotalTime varchar(15)  , 
	CallTempExclusive smallint  , 
	CallSeconds smallint  , 
	CallTemp smallint  , 
	SourceCodeID int  , 
	CallOpenByID int  , 
	CallTempSavedByID int  , 
	CallExtension numeric  ,    
	RecycleNCFlag smallint  , 
	CallActive smallint  , 
	CallSaveLastByID int );

INSERT INTO #tblCallId
EXEC INSERTCall 
	@CallTypeID = 1, 
	@CallDateTime = @CallDateTime,  
	@StatEmployeeID = @StatEmployeeID, 
	@CallTotalTime = '00:00:00', 
	@CallSeconds = 0,  
	@CallTemp = -1, 
	@SourceCodeID = @SourceCodeID, 
	@CallOpenByID = -1, 
	@CallTempExclusive = -1, 
	@CallTempSavedByID = 
	@StatEmployeeID, 
	@RecycleNCFlag = -1, 
	@CallActive = -1, 
	@CallSaveLastByID = @StatEmployeeID, 
	@CallExtension = @Extension, 
	@CallID = NULL;


select @CallId=CallId,
	@CallNumber = CallNumber from #tblCallId;

SELECT @DonorName = IsNull(@PatientFirstName + ' ', '') + IsNull(@PatientLastName,'');

SELECT @ReferralFacilityTimeZone = OrganizationTimeZone FROM dbo.Organization where OrganizationID = @ReferralFacilityId;

IF (@AdmitDateTime is not null)
BEGIN
	SELECT @AdmitDate = Cast(Convert(varchar(10), @AdmitDateTime, 101) as date),
			@AdmitTime = Convert(varchar(5), @AdmitDateTime, 14) + ISNULL(' ' + @ReferralFacilityTimeZone, '');  
END

IF (@CardiacDeathDateTime is not null)
BEGIN
	SELECT @DeathDate = Cast(Convert(varchar(10), @CardiacDeathDateTime, 101) as date),
			@DeathTime = Convert(varchar(5), @CardiacDeathDateTime, 14) + ISNULL(' ' + @ReferralFacilityTimeZone, '');
END

IF (@ExtubationDate IS NOT NULL)
BEGIN
	SELECT @ExtubationDateString = IsNull(Convert(varchar(10), @ExtubationDate, 1) + ' ','') + IsNull(Convert(Varchar(5), @ExtubationDate, 108),'');
END

IF (@CurrentlyOnVentilatorName = 'Yes, currently')
BEGIN
	SET @CurrentlyOnVentilatorName = 'Currently';
END
ELSE IF (@CurrentlyOnVentilatorName = 'No, previously')
BEGIN
	SET @CurrentlyOnVentilatorName = 'Previously';
END

IF (@GenderId = 2)
BEGIN
	SET @GenderName = 'F';
END
ELSE IF (@GenderId = 1)
BEGIN
	SET @GenderName = 'M';
END

--weight
IF (@Weight IS NOT NULL AND @Weight > 0)
BEGIN
	IF (@WeightUnitName = 'kg')
	BEGIN
		SELECT @WeightKg = @Weight;
	END
	ELSE IF (@WeightUnitName = 'lbs' )
	BEGIN	
		SELECT @WeightKg = ROUND(@Weight/2.20462,1);
	END
	ELSE IF (@WeightUnitName = 'oz')
	BEGIN
		SELECT @WeightKg = ROUND((@Weight/35.274),1);
	END
	ELSE IF (@WeightUnitName = 'g')
	BEGIN
		SELECT @WeightKg = ROUND(@Weight/1000,1);
	END

	SELECT @WeightString = CONVERT(varchar(7), @WeightKg);
END

IF (@HivId = 1)
BEGIN
	SELECT @MedicalHistory = 'HIV';
END
IF (@AidsId = 1)
BEGIN
	SELECT @MedicalHistory = IsNull(@MedicalHistory + ', ','') + 'AIDS'; 
END
IF (@HepBId = 1)
BEGIN
	SELECT @MedicalHistory = IsNull(@MedicalHistory + ', ','') + 'Hep B'; 
END

IF (@HepCId = 1)
BEGIN
	SELECT @MedicalHistory = IsNull(@MedicalHistory + ', ','') + 'Hep C'; 
END

IF (@IvdaInLast5YearsId = 1)
BEGIN
	SELECT @MedicalHistory = IsNull(@MedicalHistory + ', ','') + 'IVDA in last 5 years' ;
END

--check heartbeat -- ereferral 2 = no, stattrac no will be a 0
IF (@HeartBeatId = 2)
BEGIN
	SET @HeartBeatId = 0;
END

SELECT 
	@OrganAppropriateId = OrganAppropriateId,
	@BoneAppropriateId = BoneAppropriateId,
	@SoftTissueAppropriateId = SoftTissueAppropriateId,
	@SkinAppropriateId = SkinAppropriateId,
	@ValvesAppropriateId = ValvesAppropriateId,
	@EyesAppropriateId = EyesAppropriateId,
	@OtherAppropriateId = OtherAppropriateId ,
	@PreviousReferralTypeID = PreviousReferralTypeID,
	@CurrentReferralTypeID = CurrentReferralTypeID
FROM dbo.EReferralCalculateCriteria(@Age, @AgeUnitId,@GenderId, @Weight, @HivId, @AidsId, @HepBId, @HepCId, @IvdaInLast5YearsId, @ReferralFacilityId, @SourceCodeID);


EXEC InsertReferral 
	@CallID = @CallId,
	@ReferralCallerPhoneID = @PhoneNumberId, 
	@ReferralCallerExtension = @Extension,
	@ReferralCallerOrganizationID = @ReferralFacilityId, 
	@ReferralCallerSubLocationID = @HospitalUnitId,  --hospital Unit
	@ReferralCallerSubLocationLevel = @Floor,  
	@ReferralCallerLevelID = -1,  --?
	@ReferralCallerPersonID = @ContactId, 
	@ReferralDonorName = @DonorName,
	@ReferralDonorFirstName = @PatientFirstName, 
    @ReferralDonorLastName = @PatientLastName, 
	@ReferralDonorAge = @Age,
	@ReferralDonorAgeUnit = @AgeUnitName,
	@ReferralDonorRaceID = @RaceId, 
	@ReferralDonorGender = @GenderName , 
	@ReferralDonorWeight  = @WeightString , 
    @ReferralDonorAdmitDate = @AdmitDate, 
	@ReferralDonorAdmitTime = @AdmitTime , 
	@ReferralDonorDeathDate = @DeathDate, 
	@ReferralDonorDeathTime = @DeathTime ,
	@ReferralDonorHeartBeat = @HeartbeatId,
	@ReferralDonorOnVentilator = @CurrentlyOnVentilatorName,
	@ReferralExtubated = @ExtubationDateString,
	@ReferralDonorRecNumber = @MedicalRecordNumber,
	@ReferralDOB = @DateOfBirth,
	@ReferralNotesCase = @MedicalHistory,
	@LastStatEmployeeID = @StatEmployeeID,
	@ReferralOrganAppropriateID = @OrganAppropriateId,
	@ReferralBoneAppropriateID = @BoneAppropriateId,
	@ReferralTissueAppropriateID = @SoftTissueAppropriateId,
	@ReferralSkinAppropriateID = @SkinAppropriateId,
	@ReferralEyesTransAppropriateID = @EyesAppropriateId,
	@ReferralValvesAppropriateID = @ValvesAppropriateId,
	@ReferralEyesRschAppropriateID = @OtherAppropriateId,
	@ReferralQAReviewComplete = 0,
	@CurrentReferralTypeId = @PreviousReferralTypeID,
	@ReferralApproachTypeID = @UKNOWNID,
	@Hiv = @HivId,
	@Aids = @AidsId,
	@HepB = @HepBId,
	@HepC = @HepCId,
	@Ivda = @IvdaInLast5YearsId,
	@IdentityUnknown = @IdentityUnknown,
	@AgeEstimated = @AgeIsEstimate,
	@WeightEstimated = @WeightIsEstimate,
	@PastMedicalHistory = @PastMedicalHistory,
	@AdmittingDiagnosis = @AdmittingDiagnosis,
	@ReferralDonorCauseOfDeathID = @CauseOfDeathID;

UPDATE dbo.Referral
	SET 
		CurrentReferralTypeID = @CurrentReferralTypeID,
		IsERferralCase = 1,
		LastModified = GetDate(),
		LastStatEmployeeID = @StatEmployeeID
WHERE CallId = @CallId;

--registry status
EXEC dbo.InsertRegistryStatus
	@RegistryStatus = 5, 
	@CallID = @CallId, 
	@LastStatEmployeeID = @StatEmployeeID; 

--Add incoming E-Referral Event
SELECT @ContactFullName = IsNull(@ContactFirstName + ' ','')  + IsNull(@ContactLastName,'');

EXEC INSERTLogEvent 
		@CallID = @CallId,
		@LogEventTypeID = 54,  --Incoming E-Referral
		@LogEventPhone = NULL,
		@LogEventName = @ContactFullName,
		@OrganizationID = @ReferralFacilityId,
		@LogEventOrg = @ReferralFacilityName,
		@LogEventDesc = 'Incoming E-Referral',
		@StatEmployeeID = @StatEmployeeID,
		@LogEventDateTime = @CallDateTime,  
		@LogEventCallbackPending = 0,
		@ScheduleGroupID = -1,
		@PersonID = @ContactId,
		@PhoneID = -1,
		@LogEventContactConfirmed = 0,
		@LogEventCalloutDateTime = NULL,
		@LogEventNumber = NULL,
		@LastStatEmployeeID = @StatEmployeeID,
		@LogEventDeleted = 0,
		@LogEventID = NULL;

IF (@CurrentReferralTypeID <> 4)
BEGIN
	EXEC INSERTLogEvent 
		@CallID = @CallId,
		@LogEventTypeID = 55,  --Pending E-Referral
		@LogEventPhone = NULL,
		@LogEventName = @ContactFullName,
		@OrganizationID = @ReferralFacilityId,
		@LogEventOrg = @ReferralFacilityName,
		@LogEventDesc = 'Pending E-Referral',
		@StatEmployeeID = @StatEmployeeID,
		@LogEventDateTime = @CallDateTime,  
		@LogEventCallbackPending = -1,
		@ScheduleGroupID = -1,
		@PersonID = @ContactId,
		@PhoneID = -1,
		@LogEventContactConfirmed = 0,
		@LogEventCalloutDateTime = NULL,
		@LogEventNumber = NULL,
		@LastStatEmployeeID = @StatEmployeeID,
		@LogEventDeleted = 0,
		@LogEventID = NULL;
END

IF (@AdmittingDiagnosis IS NOT NULL)
BEGIN
	SELECT @AdmittingDiagnosis = 'Admitting Diagnosis/Admission Course: ' + @AdmittingDiagnosis;
	EXEC INSERTLogEvent 
		@CallID = @CallId,
		@LogEventTypeID = 1,  --Note
		@LogEventPhone = NULL,
		@LogEventOrg = NULL,
		@LogEventDesc = @AdmittingDiagnosis,
		@StatEmployeeID = @StatEmployeeID,
		@LogEventDateTime = @CallDateTime,  
		@LogEventCallbackPending = 0,
		@OrganizationID = -1,
		@ScheduleGroupID = -1,
		@PersonID = -1,
		@PhoneID = -1,
		@LogEventContactConfirmed = 0,
		@LogEventCalloutDateTime = NULL,
		@LogEventNumber = NULL,
		@LastStatEmployeeID = @StatEmployeeID,
		@LogEventDeleted = 0,
		@LogEventID = NULL;
END

IF (@PastMedicalHistory IS NOT NULL)
BEGIN
	SELECT @PastMedicalHistory = 'Past Medical History: ' + @PastMedicalHistory;

	EXEC INSERTLogEvent 
		@CallID = @CallId,
		@LogEventTypeID = 1,  --Note
		@LogEventPhone = NULL,
		@LogEventOrg = NULL,
		@LogEventDesc = @PastMedicalHistory,
		@StatEmployeeID = @StatEmployeeID,
		@LogEventDateTime = @CallDateTime,  
		@LogEventCallbackPending = 0,
		@OrganizationID = -1,
		@ScheduleGroupID = -1,
		@PersonID = -1,
		@PhoneID = -1,
		@LogEventContactConfirmed = 0,
		@LogEventCalloutDateTime = NULL,
		@LogEventNumber = NULL,
		@LastStatEmployeeID = @StatEmployeeID,
		@LogEventDeleted = 0,
		@LogEventID = NULL;
END

EXEC UpdateCallIncompleteDate 
	@CallID = @CallId, 
	@StatEmployeeID = @StatEmployeeID, 
	@IncompleteChecked = True;

drop table #tblCallId;

SELECT @ReferralTypeAbbreviation = ReferralAbbreviation
FROM dbo.ReferralType
WHERE REferralTypeId = @CurrentReferralTypeId;

SELECT @Ret = @ReferralTypeAbbreviation + ',' + Cast(@CallId as varchar(20)); 


GO