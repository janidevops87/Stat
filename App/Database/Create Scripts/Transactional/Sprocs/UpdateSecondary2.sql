IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'UpdateSecondary2')
	BEGIN
		PRINT 'Dropping Procedure UpdateSecondary2'
		DROP  Procedure  UpdateSecondary2
	END

GO

PRINT 'Creating Procedure UpdateSecondary2'
GO
CREATE Procedure UpdateSecondary2
	@CallID int, 
	@SecondaryAntibiotic1Name int = NULL, 
	@SecondaryAntibiotic1Dose varchar(25) = NULL, 
	@SecondaryAntibiotic1StartDate datetime = NULL, 
	@SecondaryAntibiotic1EndDate datetime = NULL, 
	@SecondaryAntibiotic2Name int = NULL, 
	@SecondaryAntibiotic2Dose varchar(25) = NULL, 
	@SecondaryAntibiotic2StartDate datetime = NULL, 
	@SecondaryAntibiotic2EndDate datetime = NULL, 
	@SecondaryAntibiotic3Name int = NULL, 
	@SecondaryAntibiotic3Dose varchar(25) = NULL, 
	@SecondaryAntibiotic3StartDate datetime = NULL, 
	@SecondaryAntibiotic3EndDate datetime = NULL, 
	@SecondaryAntibiotic4Name int = NULL, 
	@SecondaryAntibiotic4Dose varchar(25) = NULL, 
	@SecondaryAntibiotic4StartDate datetime = NULL, 
	@SecondaryAntibiotic4EndDate datetime = NULL, 
	@SecondaryAntibiotic5Name int = NULL, 
	@SecondaryAntibiotic5Dose varchar(25) = NULL, 
	@SecondaryAntibiotic5StartDate datetime = NULL, 
	@SecondaryAntibiotic5EndDate datetime = NULL, 
	@SecondaryBloodProductsReceived1Type int = NULL, 
	@SecondaryBloodProductsReceived1Units varchar(25) = NULL, 
	@SecondaryBloodProductsReceived1TypeCC varchar(25) = NULL, 
	@SecondaryBloodProductsReceived1TypeUnitGiven varchar(25) = NULL, 
	@SecondaryBloodProductsReceived2Type int = NULL, 
	@SecondaryBloodProductsReceived2Units varchar(25) = NULL, 
	@SecondaryBloodProductsReceived2TypeCC varchar(25) = NULL, 
	@SecondaryBloodProductsReceived2TypeUnitGiven varchar(25) = NULL, 
	@SecondaryBloodProductsReceived3Type int = NULL, 
	@SecondaryBloodProductsReceived3Units varchar(25) = NULL, 
	@SecondaryBloodProductsReceived3TypeCC varchar(25) = NULL, 
	@SecondaryBloodProductsReceived3TypeUnitGiven varchar(25) = NULL, 
	@SecondaryColloidsInfused1Type int = NULL, 
	@SecondaryColloidsInfused1Units varchar(25) = NULL, 
	@SecondaryColloidsInfused1CC varchar(25) = NULL, 
	@SecondaryColloidsInfused1UnitGiven varchar(25) = NULL, 
	@SecondaryColloidsInfused2Type int = NULL, 
	@SecondaryColloidsInfused2Units varchar(25) = NULL, 
	@SecondaryColloidsInfused2CC varchar(25) = NULL, 
	@SecondaryColloidsInfused2UnitGiven varchar(25) = NULL, 
	@SecondaryColloidsInfused3Type int = NULL, 
	@SecondaryColloidsInfused3Units varchar(25) = NULL, 
	@SecondaryColloidsInfused3CC varchar(25) = NULL, 
	@SecondaryColloidsInfused3UnitGiven varchar(25) = NULL, 
	@SecondaryCrystalloids1Type int = NULL, 
	@SecondaryCrystalloids1Units varchar(25) = NULL, 
	@SecondaryCrystalloids1CC varchar(25) = NULL, 
	@SecondaryCrystalloids1UnitGiven varchar(25) = NULL, 
	@SecondaryCrystalloids2Type int = NULL, 
	@SecondaryCrystalloids2Units varchar(25) = NULL, 
	@SecondaryCrystalloids2CC varchar(25) = NULL, 
	@SecondaryCrystalloids2UnitGiven varchar(25) = NULL, 
	@SecondaryCrystalloids3Type int = NULL, 
	@SecondaryCrystalloids3Units varchar(25) = NULL, 
	@SecondaryCrystalloids3CC varchar(25) = NULL, 
	@SecondaryCrystalloids3UnitGiven varchar(25) = NULL, 
	@SecondaryWBC1Date smalldatetime = NULL, 
	@SecondaryWBC1 varchar(25) = NULL, 
	@SecondaryWBC1Bands varchar(25) = NULL, 
	@SecondaryWBC2Date smalldatetime = NULL, 
	@SecondaryWBC2 varchar(25) = NULL, 
	@SecondaryWBC2Bands varchar(25) = NULL, 
	@SecondaryWBC3Date smalldatetime = NULL, 
	@SecondaryWBC3 varchar(25) = NULL, 
	@SecondaryWBC3Bands varchar(25) = NULL, 
	@SecondaryLabTemp1 varchar(25) = NULL, 
	@SecondaryLabTemp1Date smalldatetime = NULL, 
	@SecondaryLabTemp1Time varchar(10) = NULL, 
	@SecondaryLabTemp2 varchar(25) = NULL, 
	@SecondaryLabTemp2Date smalldatetime = NULL, 
	@SecondaryLabTemp2Time varchar(10) = NULL, 
	@SecondaryLabTemp3 varchar(25) = NULL, 
	@SecondaryLabTemp3Date smalldatetime = NULL, 
	@SecondaryLabTemp3Time varchar(10) = NULL, 
	@SecondaryCulture1Type int = NULL, 
	@SecondaryCulture1Other varchar(50) = NULL, 
	@SecondaryCulture1DrawnDate smalldatetime = NULL, 
	@SecondaryCulture1Growth varchar(25) = NULL, 
	@SecondaryCulture2Type int = NULL, 
	@SecondaryCulture2Other varchar(50) = NULL, 
	@SecondaryCulture2DrawnDate smalldatetime = NULL, 
	@SecondaryCulture2Growth varchar(25) = NULL, 
	@SecondaryCulture3Type int = NULL, 
	@SecondaryCulture3Other varchar(50) = NULL, 
	@SecondaryCulture3DrawnDate smalldatetime = NULL, 
	@SecondaryCulture3Growth varchar(25) = NULL, 
	@SecondaryCXRAvailable int = NULL, 
	@SecondaryCXR1Date smalldatetime = NULL, 
	@SecondaryCXR1Finding varchar(255) = NULL, 
	@SecondaryCXR2Date smalldatetime = NULL, 
	@SecondaryCXR2Finding varchar(255) = NULL, 
	@SecondaryCXR3Date smalldatetime = NULL, 
	@SecondaryCXR3Finding varchar(255) = NULL, 
	@SecondaryAntibiotic1NameOther varchar(25) = NULL, 
	@SecondaryAntibiotic2NameOther varchar(25) = NULL, 
	@SecondaryAntibiotic3NameOther varchar(25) = NULL, 
	@SecondaryAntibiotic4NameOther varchar(25) = NULL, 
	@SecondaryAntibiotic5NameOther varchar(25) = NULL, 
	@SecondaryBloodProductsReceived1TypeOther varchar(25) = NULL, 
	@SecondaryBloodProductsReceived2TypeOther varchar(25) = NULL, 
	@SecondaryBloodProductsReceived3TypeOther varchar(25) = NULL, 
	@SecondaryColloidsInfused1TypeOther varchar(25) = NULL, 
	@SecondaryColloidsInfused2TypeOther varchar(25) = NULL, 
	@SecondaryColloidsInfused3TypeOther varchar(25) = NULL, 
	@SecondaryCrystalloids1TypeOther varchar(25) = NULL, 
	@SecondaryCrystalloids2TypeOther varchar(25) = NULL, 
	@SecondaryCrystalloids3TypeOther varchar(25) = NULL, 
	@LastStatEmployeeID int, 
	@AuditLogTypeID int = NULL

AS

/******************************************************************************
**		File: UpdateSecondary2.sql
**		Name: UpdateSecondary2
**		Desc: 
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
**     see list above
**
**		Auth: Bret Knoll
**		Date: 5/30/2007
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**      5/30/2007	Bret Knoll			8.4.3.8 AuditTrail
*******************************************************************************/
UPDATE 
	Secondary2 
SET 
	SecondaryAntibiotic1Name = ISNULL(@SecondaryAntibiotic1Name, SecondaryAntibiotic1Name), 
	SecondaryAntibiotic1Dose = @SecondaryAntibiotic1Dose, 
	SecondaryAntibiotic1StartDate = ISNULL(@SecondaryAntibiotic1StartDate, SecondaryAntibiotic1StartDate), 
	SecondaryAntibiotic1EndDate = ISNULL(@SecondaryAntibiotic1EndDate, SecondaryAntibiotic1EndDate), 
	SecondaryAntibiotic2Name = ISNULL(@SecondaryAntibiotic2Name, SecondaryAntibiotic2Name), 
	SecondaryAntibiotic2Dose = @SecondaryAntibiotic2Dose, 
	SecondaryAntibiotic2StartDate = ISNULL(@SecondaryAntibiotic2StartDate, SecondaryAntibiotic2StartDate), 
	SecondaryAntibiotic2EndDate = ISNULL(@SecondaryAntibiotic2EndDate, SecondaryAntibiotic2EndDate), 
	SecondaryAntibiotic3Name = ISNULL(@SecondaryAntibiotic3Name, SecondaryAntibiotic3Name), 
	SecondaryAntibiotic3Dose = @SecondaryAntibiotic3Dose, 
	SecondaryAntibiotic3StartDate = ISNULL(@SecondaryAntibiotic3StartDate, SecondaryAntibiotic3StartDate), 
	SecondaryAntibiotic3EndDate = ISNULL(@SecondaryAntibiotic3EndDate, SecondaryAntibiotic3EndDate), 
	SecondaryAntibiotic4Name = ISNULL(@SecondaryAntibiotic4Name, SecondaryAntibiotic4Name), 
	SecondaryAntibiotic4Dose = @SecondaryAntibiotic4Dose, 
	SecondaryAntibiotic4StartDate = ISNULL(@SecondaryAntibiotic4StartDate, SecondaryAntibiotic4StartDate), 
	SecondaryAntibiotic4EndDate = ISNULL(@SecondaryAntibiotic4EndDate, SecondaryAntibiotic4EndDate), 
	SecondaryAntibiotic5Name = ISNULL(@SecondaryAntibiotic5Name, SecondaryAntibiotic5Name), 
	SecondaryAntibiotic5Dose = @SecondaryAntibiotic5Dose, 
	SecondaryAntibiotic5StartDate = ISNULL(@SecondaryAntibiotic5StartDate, SecondaryAntibiotic5StartDate), 
	SecondaryAntibiotic5EndDate = ISNULL(@SecondaryAntibiotic5EndDate, SecondaryAntibiotic5EndDate), 
	SecondaryBloodProductsReceived1Type = ISNULL(@SecondaryBloodProductsReceived1Type, SecondaryBloodProductsReceived1Type), 
	SecondaryBloodProductsReceived1Units = @SecondaryBloodProductsReceived1Units, 
	SecondaryBloodProductsReceived1TypeCC = @SecondaryBloodProductsReceived1TypeCC, 
	SecondaryBloodProductsReceived1TypeUnitGiven = @SecondaryBloodProductsReceived1TypeUnitGiven, 
	SecondaryBloodProductsReceived2Type = ISNULL(@SecondaryBloodProductsReceived2Type, SecondaryBloodProductsReceived2Type), 
	SecondaryBloodProductsReceived2Units = @SecondaryBloodProductsReceived2Units, 
	SecondaryBloodProductsReceived2TypeCC = @SecondaryBloodProductsReceived2TypeCC, 
	SecondaryBloodProductsReceived2TypeUnitGiven = @SecondaryBloodProductsReceived2TypeUnitGiven, 
	SecondaryBloodProductsReceived3Type = ISNULL(@SecondaryBloodProductsReceived3Type, SecondaryBloodProductsReceived3Type), 
	SecondaryBloodProductsReceived3Units = @SecondaryBloodProductsReceived3Units, 
	SecondaryBloodProductsReceived3TypeCC = @SecondaryBloodProductsReceived3TypeCC, 
	SecondaryBloodProductsReceived3TypeUnitGiven = @SecondaryBloodProductsReceived3TypeUnitGiven, 
	SecondaryColloidsInfused1Type = ISNULL(@SecondaryColloidsInfused1Type, SecondaryColloidsInfused1Type), 
	SecondaryColloidsInfused1Units = @SecondaryColloidsInfused1Units, 
	SecondaryColloidsInfused1CC = @SecondaryColloidsInfused1CC, 
	SecondaryColloidsInfused1UnitGiven = @SecondaryColloidsInfused1UnitGiven, 
	SecondaryColloidsInfused2Type = ISNULL(@SecondaryColloidsInfused2Type, SecondaryColloidsInfused2Type), 
	SecondaryColloidsInfused2Units = @SecondaryColloidsInfused2Units, 
	SecondaryColloidsInfused2CC = @SecondaryColloidsInfused2CC, 
	SecondaryColloidsInfused2UnitGiven = @SecondaryColloidsInfused2UnitGiven, 
	SecondaryColloidsInfused3Type = ISNULL(@SecondaryColloidsInfused3Type, SecondaryColloidsInfused3Type), 
	SecondaryColloidsInfused3Units = @SecondaryColloidsInfused3Units, 
	SecondaryColloidsInfused3CC = @SecondaryColloidsInfused3CC, 
	SecondaryColloidsInfused3UnitGiven = @SecondaryColloidsInfused3UnitGiven, 
	SecondaryCrystalloids1Type = ISNULL(@SecondaryCrystalloids1Type, SecondaryCrystalloids1Type), 
	SecondaryCrystalloids1Units = @SecondaryCrystalloids1Units, 
	SecondaryCrystalloids1CC = @SecondaryCrystalloids1CC, 
	SecondaryCrystalloids1UnitGiven = @SecondaryCrystalloids1UnitGiven, 
	SecondaryCrystalloids2Type = ISNULL(@SecondaryCrystalloids2Type, SecondaryCrystalloids2Type), 
	SecondaryCrystalloids2Units = @SecondaryCrystalloids2Units, 
	SecondaryCrystalloids2CC = @SecondaryCrystalloids2CC, 
	SecondaryCrystalloids2UnitGiven = @SecondaryCrystalloids2UnitGiven, 
	SecondaryCrystalloids3Type = ISNULL(@SecondaryCrystalloids3Type, SecondaryCrystalloids3Type), 
	SecondaryCrystalloids3Units = @SecondaryCrystalloids3Units, 
	SecondaryCrystalloids3CC = @SecondaryCrystalloids3CC, 
	SecondaryCrystalloids3UnitGiven = @SecondaryCrystalloids3UnitGiven, 
	SecondaryWBC1Date = ISNULL(@SecondaryWBC1Date, SecondaryWBC1Date), 
	SecondaryWBC1 = @SecondaryWBC1, 
	SecondaryWBC1Bands = @SecondaryWBC1Bands, 
	SecondaryWBC2Date = ISNULL(@SecondaryWBC2Date, SecondaryWBC2Date), 
	SecondaryWBC2 = @SecondaryWBC2, 
	SecondaryWBC2Bands = @SecondaryWBC2Bands, 
	SecondaryWBC3Date = ISNULL(@SecondaryWBC3Date, SecondaryWBC3Date), 
	SecondaryWBC3 = @SecondaryWBC3, 
	SecondaryWBC3Bands = @SecondaryWBC3Bands, 
	SecondaryLabTemp1 = @SecondaryLabTemp1, 
	SecondaryLabTemp1Date = ISNULL(@SecondaryLabTemp1Date, SecondaryLabTemp1Date), 
	SecondaryLabTemp1Time = @SecondaryLabTemp1Time, 
	SecondaryLabTemp2 = @SecondaryLabTemp2, 
	SecondaryLabTemp2Date = ISNULL(@SecondaryLabTemp2Date, SecondaryLabTemp2Date), 
	SecondaryLabTemp2Time = @SecondaryLabTemp2Time, 
	SecondaryLabTemp3 = @SecondaryLabTemp3, 
	SecondaryLabTemp3Date = ISNULL(@SecondaryLabTemp3Date, SecondaryLabTemp3Date), 
	SecondaryLabTemp3Time = @SecondaryLabTemp3Time, 
	SecondaryCulture1Type = ISNULL(@SecondaryCulture1Type, SecondaryCulture1Type), 
	SecondaryCulture1Other = @SecondaryCulture1Other, 
	SecondaryCulture1DrawnDate = ISNULL(@SecondaryCulture1DrawnDate, SecondaryCulture1DrawnDate), 
	SecondaryCulture1Growth = @SecondaryCulture1Growth, 
	SecondaryCulture2Type = ISNULL(@SecondaryCulture2Type, SecondaryCulture2Type), 
	SecondaryCulture2Other = @SecondaryCulture2Other, 
	SecondaryCulture2DrawnDate = ISNULL(@SecondaryCulture2DrawnDate, SecondaryCulture2DrawnDate), 
	SecondaryCulture2Growth = @SecondaryCulture2Growth, 
	SecondaryCulture3Type = ISNULL(@SecondaryCulture3Type, SecondaryCulture3Type), 
	SecondaryCulture3Other = @SecondaryCulture3Other, 
	SecondaryCulture3DrawnDate = ISNULL(@SecondaryCulture3DrawnDate, SecondaryCulture3DrawnDate), 
	SecondaryCulture3Growth = @SecondaryCulture3Growth, 
	SecondaryCXRAvailable = ISNULL(@SecondaryCXRAvailable, SecondaryCXRAvailable), 
	SecondaryCXR1Date = ISNULL(@SecondaryCXR1Date, SecondaryCXR1Date), 
	SecondaryCXR1Finding = @SecondaryCXR1Finding, 
	SecondaryCXR2Date = ISNULL(@SecondaryCXR2Date, SecondaryCXR2Date), 
	SecondaryCXR2Finding = @SecondaryCXR2Finding, 
	SecondaryCXR3Date = ISNULL(@SecondaryCXR3Date, SecondaryCXR3Date), 
	SecondaryCXR3Finding = @SecondaryCXR3Finding, 
	SecondaryAntibiotic1NameOther = @SecondaryAntibiotic1NameOther, 
	SecondaryAntibiotic2NameOther = @SecondaryAntibiotic2NameOther, 
	SecondaryAntibiotic3NameOther = @SecondaryAntibiotic3NameOther, 
	SecondaryAntibiotic4NameOther = @SecondaryAntibiotic4NameOther, 
	SecondaryAntibiotic5NameOther = @SecondaryAntibiotic5NameOther, 
	SecondaryBloodProductsReceived1TypeOther = @SecondaryBloodProductsReceived1TypeOther, 
	SecondaryBloodProductsReceived2TypeOther = @SecondaryBloodProductsReceived2TypeOther, 
	SecondaryBloodProductsReceived3TypeOther = @SecondaryBloodProductsReceived3TypeOther, 
	SecondaryColloidsInfused1TypeOther = @SecondaryColloidsInfused1TypeOther, 
	SecondaryColloidsInfused2TypeOther = @SecondaryColloidsInfused2TypeOther, 
	SecondaryColloidsInfused3TypeOther = @SecondaryColloidsInfused3TypeOther, 
	SecondaryCrystalloids1TypeOther = @SecondaryCrystalloids1TypeOther, 
	SecondaryCrystalloids2TypeOther = @SecondaryCrystalloids2TypeOther, 
	SecondaryCrystalloids3TypeOther = @SecondaryCrystalloids3TypeOther, 
	LastStatEmployeeID = @LastStatEmployeeID, 
	AuditLogTypeID = ISNULL(@AuditLogTypeID, 3), --  3 = Modify
	LastModified = GetDate() 
WHERE 
	CallID = @CallID




GO

GRANT EXEC ON UpdateSecondary2 TO PUBLIC

GO
