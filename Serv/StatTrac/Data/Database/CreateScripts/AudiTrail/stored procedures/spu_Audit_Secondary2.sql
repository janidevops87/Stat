SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_Audit_Secondary2]') and OBJECTPROPERTY(id,
		N'IsProcedure') = 1)
drop procedure [dbo].[spu_Audit_Secondary2]
GO

create procedure "spu_Audit_Secondary2" 
	@c1 int,
	@c2 int,
	@c3 varchar(25),
	@c4 datetime,
	@c5 datetime,
	@c6 int,
	@c7 varchar(25),
	@c8 datetime,
	@c9 datetime,
	@c10 int,
	@c11 varchar(25),
	@c12 datetime,
	@c13 datetime,
	@c14 int,
	@c15 varchar(25),
	@c16 datetime,
	@c17 datetime,
	@c18 int,
	@c19 varchar(25),
	@c20 datetime,
	@c21 datetime,
	@c22 int,
	@c23 varchar(25),
	@c24 varchar(25),
	@c25 varchar(25),
	@c26 int,
	@c27 varchar(25),
	@c28 varchar(25),
	@c29 varchar(25),
	@c30 int,
	@c31 varchar(25),
	@c32 varchar(25),
	@c33 varchar(25),
	@c34 int,
	@c35 varchar(25),
	@c36 varchar(25),
	@c37 varchar(25),
	@c38 int,
	@c39 varchar(25),
	@c40 varchar(25),
	@c41 varchar(25),
	@c42 int,
	@c43 varchar(25),
	@c44 varchar(25),
	@c45 varchar(25),
	@c46 int,
	@c47 varchar(25),
	@c48 varchar(25),
	@c49 varchar(25),
	@c50 int,
	@c51 varchar(25),
	@c52 varchar(25),
	@c53 varchar(25),
	@c54 int,
	@c55 varchar(25),
	@c56 varchar(25),
	@c57 varchar(25),
	@c58 smalldatetime,
	@c59 varchar(25),
	@c60 varchar(25),
	@c61 smalldatetime,
	@c62 varchar(25),
	@c63 varchar(25),
	@c64 smalldatetime,
	@c65 varchar(25),
	@c66 varchar(25),
	@c67 varchar(25),
	@c68 smalldatetime,
	@c69 varchar(10),
	@c70 varchar(25),
	@c71 smalldatetime,
	@c72 varchar(10),
	@c73 varchar(25),
	@c74 smalldatetime,
	@c75 varchar(10),
	@c76 int,
	@c77 varchar(50),
	@c78 smalldatetime,
	@c79 varchar(25),
	@c80 int,
	@c81 varchar(50),
	@c82 smalldatetime,
	@c83 varchar(25),
	@c84 int,
	@c85 varchar(50),
	@c86 smalldatetime,
	@c87 varchar(25),
	@c88 int,
	@c89 smalldatetime,
	@c90 varchar(255),
	@c91 smalldatetime,
	@c92 varchar(255),
	@c93 smalldatetime,
	@c94 varchar(255),
	@c95 varchar(25),
	@c96 varchar(25),
	@c97 varchar(25),
	@c98 varchar(25),
	@c99 varchar(25),
	@c100 varchar(25),
	@c101 varchar(25),
	@c102 varchar(25),
	@c103 varchar(25),
	@c104 varchar(25),
	@c105 varchar(25),
	@c106 varchar(25),
	@c107 varchar(25),
	@c108 varchar(25),
	@c109 int,
	@c110 int,
	@c111 smalldatetime,
	@pkc1 int,
	@bitmap binary(14)
as
	DECLARE 
		@lastModified datetime,
		@LastStatEmployeeID int,
		@auditLogTypeID int
IF NOT (
		    SUBSTRING(@bitmap, 1, 1) & 1 <> 1 -- CallID
		AND SUBSTRING(@bitmap, 1, 1) & 2 <> 2 -- SecondaryAntibiotic1Name
		AND SUBSTRING(@bitmap, 1, 1) & 4 <> 4 -- SecondaryAntibiotic1Dose
		AND SUBSTRING(@bitmap, 1, 1) & 8 <> 8 -- SecondaryAntibiotic1StartDate
		AND SUBSTRING(@bitmap, 1, 1) & 16 <> 16 -- SecondaryAntibiotic1EndDate
		AND SUBSTRING(@bitmap, 1, 1) & 32 <> 32 -- SecondaryAntibiotic2Name
		AND SUBSTRING(@bitmap, 1, 1) & 64 <> 64 -- SecondaryAntibiotic2Dose
		AND SUBSTRING(@bitmap, 1, 1) & 128 <> 128 -- SecondaryAntibiotic2StartDate
		AND SUBSTRING(@bitmap, 2, 1) & 1 <> 1 -- SecondaryAntibiotic2EndDate
		AND SUBSTRING(@bitmap, 2, 1) & 2 <> 2 -- SecondaryAntibiotic3Name
		AND SUBSTRING(@bitmap, 2, 1) & 4 <> 4 -- SecondaryAntibiotic3Dose
		AND SUBSTRING(@bitmap, 2, 1) & 8 <> 8 -- SecondaryAntibiotic3StartDate
		AND SUBSTRING(@bitmap, 2, 1) & 16 <> 16 -- SecondaryAntibiotic3EndDate
		AND SUBSTRING(@bitmap, 2, 1) & 32 <> 32 -- SecondaryAntibiotic4Name
		AND SUBSTRING(@bitmap, 2, 1) & 64 <> 64 -- SecondaryAntibiotic4Dose
		AND SUBSTRING(@bitmap, 2, 1) & 128 <> 128 -- SecondaryAntibiotic4StartDate
		AND SUBSTRING(@bitmap, 3, 1) & 1 <> 1 -- SecondaryAntibiotic4EndDate
		AND SUBSTRING(@bitmap, 3, 1) & 2 <> 2 -- SecondaryAntibiotic5Name
		AND SUBSTRING(@bitmap, 3, 1) & 4 <> 4 -- SecondaryAntibiotic5Dose
		AND SUBSTRING(@bitmap, 3, 1) & 8 <> 8 -- SecondaryAntibiotic5StartDate
		AND SUBSTRING(@bitmap, 3, 1) & 16 <> 16 -- SecondaryAntibiotic5EndDate
		AND SUBSTRING(@bitmap, 3, 1) & 32 <> 32 -- SecondaryBloodProductsReceived1Type
		AND SUBSTRING(@bitmap, 3, 1) & 64 <> 64 -- SecondaryBloodProductsReceived1Units
		AND SUBSTRING(@bitmap, 3, 1) & 128 <> 128 -- SecondaryBloodProductsReceived1TypeCC
		AND SUBSTRING(@bitmap, 4, 1) & 1 <> 1 -- SecondaryBloodProductsReceived1TypeUnitGiven
		AND SUBSTRING(@bitmap, 4, 1) & 2 <> 2 -- SecondaryBloodProductsReceived2Type
		AND SUBSTRING(@bitmap, 4, 1) & 4 <> 4 -- SecondaryBloodProductsReceived2Units
		AND SUBSTRING(@bitmap, 4, 1) & 8 <> 8 -- SecondaryBloodProductsReceived2TypeCC
		AND SUBSTRING(@bitmap, 4, 1) & 16 <> 16 -- SecondaryBloodProductsReceived2TypeUnitGiven
		AND SUBSTRING(@bitmap, 4, 1) & 32 <> 32 -- SecondaryBloodProductsReceived3Type
		AND SUBSTRING(@bitmap, 4, 1) & 64 <> 64 -- SecondaryBloodProductsReceived3Units
		AND SUBSTRING(@bitmap, 4, 1) & 128 <> 128 -- SecondaryBloodProductsReceived3TypeCC
		AND SUBSTRING(@bitmap, 5, 1) & 1 <> 1 -- SecondaryBloodProductsReceived3TypeUnitGiven
		AND SUBSTRING(@bitmap, 5, 1) & 2 <> 2 -- SecondaryColloidsInfused1Type
		AND SUBSTRING(@bitmap, 5, 1) & 4 <> 4 -- SecondaryColloidsInfused1Units
		AND SUBSTRING(@bitmap, 5, 1) & 8 <> 8 -- SecondaryColloidsInfused1CC
		AND SUBSTRING(@bitmap, 5, 1) & 16 <> 16 -- SecondaryColloidsInfused1UnitGiven
		AND SUBSTRING(@bitmap, 5, 1) & 32 <> 32 -- SecondaryColloidsInfused2Type
		AND SUBSTRING(@bitmap, 5, 1) & 64 <> 64 -- SecondaryColloidsInfused2Units
		AND SUBSTRING(@bitmap, 5, 1) & 128 <> 128 -- SecondaryColloidsInfused2CC
		AND SUBSTRING(@bitmap, 6, 1) & 1 <> 1 -- SecondaryColloidsInfused2UnitGiven
		AND SUBSTRING(@bitmap, 6, 1) & 2 <> 2 -- SecondaryColloidsInfused3Type
		AND SUBSTRING(@bitmap, 6, 1) & 4 <> 4 -- SecondaryColloidsInfused3Units
		AND SUBSTRING(@bitmap, 6, 1) & 8 <> 8 -- SecondaryColloidsInfused3CC
		AND SUBSTRING(@bitmap, 6, 1) & 16 <> 16 -- SecondaryColloidsInfused3UnitGiven
		AND SUBSTRING(@bitmap, 6, 1) & 32 <> 32 -- SecondaryCrystalloids1Type
		AND SUBSTRING(@bitmap, 6, 1) & 64 <> 64 -- SecondaryCrystalloids1Units
		AND SUBSTRING(@bitmap, 6, 1) & 128 <> 128 -- SecondaryCrystalloids1CC
		AND SUBSTRING(@bitmap, 7, 1) & 1 <> 1 -- SecondaryCrystalloids1UnitGiven
		AND SUBSTRING(@bitmap, 7, 1) & 2 <> 2 -- SecondaryCrystalloids2Type
		AND SUBSTRING(@bitmap, 7, 1) & 4 <> 4 -- SecondaryCrystalloids2Units
		AND SUBSTRING(@bitmap, 7, 1) & 8 <> 8 -- SecondaryCrystalloids2CC
		AND SUBSTRING(@bitmap, 7, 1) & 16 <> 16 -- SecondaryCrystalloids2UnitGiven
		AND SUBSTRING(@bitmap, 7, 1) & 32 <> 32 -- SecondaryCrystalloids3Type
		AND SUBSTRING(@bitmap, 7, 1) & 64 <> 64 -- SecondaryCrystalloids3Units
		AND SUBSTRING(@bitmap, 7, 1) & 128 <> 128 -- SecondaryCrystalloids3CC
		AND SUBSTRING(@bitmap, 8, 1) & 1 <> 1 -- SecondaryCrystalloids3UnitGiven
		AND SUBSTRING(@bitmap, 8, 1) & 2 <> 2 -- SecondaryWBC1Date
		AND SUBSTRING(@bitmap, 8, 1) & 4 <> 4 -- SecondaryWBC1
		AND SUBSTRING(@bitmap, 8, 1) & 8 <> 8 -- SecondaryWBC1Bands
		AND SUBSTRING(@bitmap, 8, 1) & 16 <> 16 -- SecondaryWBC2Date
		AND SUBSTRING(@bitmap, 8, 1) & 32 <> 32 -- SecondaryWBC2
		AND SUBSTRING(@bitmap, 8, 1) & 64 <> 64 -- SecondaryWBC2Bands
		AND SUBSTRING(@bitmap, 8, 1) & 128 <> 128 -- SecondaryWBC3Date
		AND SUBSTRING(@bitmap, 9, 1) & 1 <> 1 -- SecondaryWBC3
		AND SUBSTRING(@bitmap, 9, 1) & 2 <> 2 -- SecondaryWBC3Bands
		AND SUBSTRING(@bitmap, 9, 1) & 4 <> 4 -- SecondaryLabTemp1
		AND SUBSTRING(@bitmap, 9, 1) & 8 <> 8 -- SecondaryLabTemp1Date
		AND SUBSTRING(@bitmap, 9, 1) & 16 <> 16 -- SecondaryLabTemp1Time
		AND SUBSTRING(@bitmap, 9, 1) & 32 <> 32 -- SecondaryLabTemp2
		AND SUBSTRING(@bitmap, 9, 1) & 64 <> 64 -- SecondaryLabTemp2Date
		AND SUBSTRING(@bitmap, 9, 1) & 128 <> 128 -- SecondaryLabTemp2Time
		AND SUBSTRING(@bitmap, 10, 1) & 1 <> 1 -- SecondaryLabTemp3
		AND SUBSTRING(@bitmap, 10, 1) & 2 <> 2 -- SecondaryLabTemp3Date
		AND SUBSTRING(@bitmap, 10, 1) & 4 <> 4 -- SecondaryLabTemp3Time
		AND SUBSTRING(@bitmap, 10, 1) & 8 <> 8 -- SecondaryCulture1Type
		AND SUBSTRING(@bitmap, 10, 1) & 16 <> 16 -- SecondaryCulture1Other
		AND SUBSTRING(@bitmap, 10, 1) & 32 <> 32 -- SecondaryCulture1DrawnDate
		AND SUBSTRING(@bitmap, 10, 1) & 64 <> 64 -- SecondaryCulture1Growth
		AND SUBSTRING(@bitmap, 10, 1) & 128 <> 128 -- SecondaryCulture2Type
		AND SUBSTRING(@bitmap, 11, 1) & 1 <> 1 -- SecondaryCulture2Other
		AND SUBSTRING(@bitmap, 11, 1) & 2 <> 2 -- SecondaryCulture2DrawnDate
		AND SUBSTRING(@bitmap, 11, 1) & 4 <> 4 -- SecondaryCulture2Growth
		AND SUBSTRING(@bitmap, 11, 1) & 8 <> 8 -- SecondaryCulture3Type
		AND SUBSTRING(@bitmap, 11, 1) & 16 <> 16 -- SecondaryCulture3Other
		AND SUBSTRING(@bitmap, 11, 1) & 32 <> 32 -- SecondaryCulture3DrawnDate
		AND SUBSTRING(@bitmap, 11, 1) & 64 <> 64 -- SecondaryCulture3Growth
		AND SUBSTRING(@bitmap, 11, 1) & 128 <> 128 -- SecondaryCXRAvailable
		AND SUBSTRING(@bitmap, 12, 1) & 1 <> 1 -- SecondaryCXR1Date
		AND SUBSTRING(@bitmap, 12, 1) & 2 <> 2 -- SecondaryCXR1Finding
		AND SUBSTRING(@bitmap, 12, 1) & 4 <> 4 -- SecondaryCXR2Date
		AND SUBSTRING(@bitmap, 12, 1) & 8 <> 8 -- SecondaryCXR2Finding
		AND SUBSTRING(@bitmap, 12, 1) & 16 <> 16 -- SecondaryCXR3Date
		AND SUBSTRING(@bitmap, 12, 1) & 32 <> 32 -- SecondaryCXR3Finding
		AND SUBSTRING(@bitmap, 12, 1) & 64 <> 64 -- SecondaryAntibiotic1NameOther
		AND SUBSTRING(@bitmap, 12, 1) & 128 <> 128 -- SecondaryAntibiotic2NameOther
		AND SUBSTRING(@bitmap, 13, 1) & 1 <> 1 -- SecondaryAntibiotic3NameOther
		AND SUBSTRING(@bitmap, 13, 1) & 2 <> 2 -- SecondaryAntibiotic4NameOther
		AND SUBSTRING(@bitmap, 13, 1) & 4 <> 4 -- SecondaryAntibiotic5NameOther
		AND SUBSTRING(@bitmap, 13, 1) & 8 <> 8 -- SecondaryBloodProductsReceived1TypeOther
		AND SUBSTRING(@bitmap, 13, 1) & 16 <> 16 -- SecondaryBloodProductsReceived2TypeOther
		AND SUBSTRING(@bitmap, 13, 1) & 32 <> 32 -- SecondaryBloodProductsReceived3TypeOther
		AND SUBSTRING(@bitmap, 13, 1) & 64 <> 64 -- SecondaryColloidsInfused1TypeOther
		AND SUBSTRING(@bitmap, 13, 1) & 128 <> 128 -- SecondaryColloidsInfused2TypeOther
		AND SUBSTRING(@bitmap, 14, 1) & 1 <> 1 -- SecondaryColloidsInfused3TypeOther
		AND SUBSTRING(@bitmap, 14, 1) & 2 <> 2 -- SecondaryCrystalloids1TypeOther
		AND SUBSTRING(@bitmap, 14, 1) & 4 <> 4 -- SecondaryCrystalloids2TypeOther
		AND SUBSTRING(@bitmap, 14, 1) & 8 <> 8 -- SecondaryCrystalloids3TypeOther
		AND SUBSTRING(@bitmap, 14, 1) & 16 <> 16 -- LastStatEmployeeID
		AND SUBSTRING(@bitmap, 14, 1) & 32 <> 32 -- AuditLogTypeID
		AND SUBSTRING(@bitmap, 14, 1) & 64 = 64 -- LastModified

	   )
BEGIN	   

	SELECT TOP 1
		@lastModified = LastModified,
		@LastStatEmployeeID = LastStatEmployeeID,
		@auditLogTypeID = ISNULL(@c110, AuditLogTypeID)
	FROM
		Secondary2
	WHERE 
		CallID = 	@pkc1
	ORDER BY
		LastModified DESC	

	-- check to see if the AuditLogTypeID should be a review or Modify
	-- only LastModified and LastStatEmployee have changed AuditLogType is Review
IF
	(
		SUBSTRING(@bitmap, 1, 1) & 1 <> 1 -- CallID
	AND SUBSTRING(@bitmap, 1, 1) & 2 <> 2 -- SecondaryAntibiotic1Name
	AND SUBSTRING(@bitmap, 1, 1) & 4 <> 4 -- SecondaryAntibiotic1Dose
	AND SUBSTRING(@bitmap, 1, 1) & 8 <> 8 -- SecondaryAntibiotic1StartDate
	AND SUBSTRING(@bitmap, 1, 1) & 16 <> 16 -- SecondaryAntibiotic1EndDate
	AND SUBSTRING(@bitmap, 1, 1) & 32 <> 32 -- SecondaryAntibiotic2Name
	AND SUBSTRING(@bitmap, 1, 1) & 64 <> 64 -- SecondaryAntibiotic2Dose
	AND SUBSTRING(@bitmap, 1, 1) & 128 <> 128 -- SecondaryAntibiotic2StartDate
	AND SUBSTRING(@bitmap, 2, 1) & 1 <> 1 -- SecondaryAntibiotic2EndDate
	AND SUBSTRING(@bitmap, 2, 1) & 2 <> 2 -- SecondaryAntibiotic3Name
	AND SUBSTRING(@bitmap, 2, 1) & 4 <> 4 -- SecondaryAntibiotic3Dose
	AND SUBSTRING(@bitmap, 2, 1) & 8 <> 8 -- SecondaryAntibiotic3StartDate
	AND SUBSTRING(@bitmap, 2, 1) & 16 <> 16 -- SecondaryAntibiotic3EndDate
	AND SUBSTRING(@bitmap, 2, 1) & 32 <> 32 -- SecondaryAntibiotic4Name
	AND SUBSTRING(@bitmap, 2, 1) & 64 <> 64 -- SecondaryAntibiotic4Dose
	AND SUBSTRING(@bitmap, 2, 1) & 128 <> 128 -- SecondaryAntibiotic4StartDate
	AND SUBSTRING(@bitmap, 3, 1) & 1 <> 1 -- SecondaryAntibiotic4EndDate
	AND SUBSTRING(@bitmap, 3, 1) & 2 <> 2 -- SecondaryAntibiotic5Name
	AND SUBSTRING(@bitmap, 3, 1) & 4 <> 4 -- SecondaryAntibiotic5Dose
	AND SUBSTRING(@bitmap, 3, 1) & 8 <> 8 -- SecondaryAntibiotic5StartDate
	AND SUBSTRING(@bitmap, 3, 1) & 16 <> 16 -- SecondaryAntibiotic5EndDate
	AND SUBSTRING(@bitmap, 3, 1) & 32 <> 32 -- SecondaryBloodProductsReceived1Type
	AND SUBSTRING(@bitmap, 3, 1) & 64 <> 64 -- SecondaryBloodProductsReceived1Units
	AND SUBSTRING(@bitmap, 3, 1) & 128 <> 128 -- SecondaryBloodProductsReceived1TypeCC
	AND SUBSTRING(@bitmap, 4, 1) & 1 <> 1 -- SecondaryBloodProductsReceived1TypeUnitGiven
	AND SUBSTRING(@bitmap, 4, 1) & 2 <> 2 -- SecondaryBloodProductsReceived2Type
	AND SUBSTRING(@bitmap, 4, 1) & 4 <> 4 -- SecondaryBloodProductsReceived2Units
	AND SUBSTRING(@bitmap, 4, 1) & 8 <> 8 -- SecondaryBloodProductsReceived2TypeCC
	AND SUBSTRING(@bitmap, 4, 1) & 16 <> 16 -- SecondaryBloodProductsReceived2TypeUnitGiven
	AND SUBSTRING(@bitmap, 4, 1) & 32 <> 32 -- SecondaryBloodProductsReceived3Type
	AND SUBSTRING(@bitmap, 4, 1) & 64 <> 64 -- SecondaryBloodProductsReceived3Units
	AND SUBSTRING(@bitmap, 4, 1) & 128 <> 128 -- SecondaryBloodProductsReceived3TypeCC
	AND SUBSTRING(@bitmap, 5, 1) & 1 <> 1 -- SecondaryBloodProductsReceived3TypeUnitGiven
	AND SUBSTRING(@bitmap, 5, 1) & 2 <> 2 -- SecondaryColloidsInfused1Type
	AND SUBSTRING(@bitmap, 5, 1) & 4 <> 4 -- SecondaryColloidsInfused1Units
	AND SUBSTRING(@bitmap, 5, 1) & 8 <> 8 -- SecondaryColloidsInfused1CC
	AND SUBSTRING(@bitmap, 5, 1) & 16 <> 16 -- SecondaryColloidsInfused1UnitGiven
	AND SUBSTRING(@bitmap, 5, 1) & 32 <> 32 -- SecondaryColloidsInfused2Type
	AND SUBSTRING(@bitmap, 5, 1) & 64 <> 64 -- SecondaryColloidsInfused2Units
	AND SUBSTRING(@bitmap, 5, 1) & 128 <> 128 -- SecondaryColloidsInfused2CC
	AND SUBSTRING(@bitmap, 6, 1) & 1 <> 1 -- SecondaryColloidsInfused2UnitGiven
	AND SUBSTRING(@bitmap, 6, 1) & 2 <> 2 -- SecondaryColloidsInfused3Type
	AND SUBSTRING(@bitmap, 6, 1) & 4 <> 4 -- SecondaryColloidsInfused3Units
	AND SUBSTRING(@bitmap, 6, 1) & 8 <> 8 -- SecondaryColloidsInfused3CC
	AND SUBSTRING(@bitmap, 6, 1) & 16 <> 16 -- SecondaryColloidsInfused3UnitGiven
	AND SUBSTRING(@bitmap, 6, 1) & 32 <> 32 -- SecondaryCrystalloids1Type
	AND SUBSTRING(@bitmap, 6, 1) & 64 <> 64 -- SecondaryCrystalloids1Units
	AND SUBSTRING(@bitmap, 6, 1) & 128 <> 128 -- SecondaryCrystalloids1CC
	AND SUBSTRING(@bitmap, 7, 1) & 1 <> 1 -- SecondaryCrystalloids1UnitGiven
	AND SUBSTRING(@bitmap, 7, 1) & 2 <> 2 -- SecondaryCrystalloids2Type
	AND SUBSTRING(@bitmap, 7, 1) & 4 <> 4 -- SecondaryCrystalloids2Units
	AND SUBSTRING(@bitmap, 7, 1) & 8 <> 8 -- SecondaryCrystalloids2CC
	AND SUBSTRING(@bitmap, 7, 1) & 16 <> 16 -- SecondaryCrystalloids2UnitGiven
	AND SUBSTRING(@bitmap, 7, 1) & 32 <> 32 -- SecondaryCrystalloids3Type
	AND SUBSTRING(@bitmap, 7, 1) & 64 <> 64 -- SecondaryCrystalloids3Units
	AND SUBSTRING(@bitmap, 7, 1) & 128 <> 128 -- SecondaryCrystalloids3CC
	AND SUBSTRING(@bitmap, 8, 1) & 1 <> 1 -- SecondaryCrystalloids3UnitGiven
	AND SUBSTRING(@bitmap, 8, 1) & 2 <> 2 -- SecondaryWBC1Date
	AND SUBSTRING(@bitmap, 8, 1) & 4 <> 4 -- SecondaryWBC1
	AND SUBSTRING(@bitmap, 8, 1) & 8 <> 8 -- SecondaryWBC1Bands
	AND SUBSTRING(@bitmap, 8, 1) & 16 <> 16 -- SecondaryWBC2Date
	AND SUBSTRING(@bitmap, 8, 1) & 32 <> 32 -- SecondaryWBC2
	AND SUBSTRING(@bitmap, 8, 1) & 64 <> 64 -- SecondaryWBC2Bands
	AND SUBSTRING(@bitmap, 8, 1) & 128 <> 128 -- SecondaryWBC3Date
	AND SUBSTRING(@bitmap, 9, 1) & 1 <> 1 -- SecondaryWBC3
	AND SUBSTRING(@bitmap, 9, 1) & 2 <> 2 -- SecondaryWBC3Bands
	AND SUBSTRING(@bitmap, 9, 1) & 4 <> 4 -- SecondaryLabTemp1
	AND SUBSTRING(@bitmap, 9, 1) & 8 <> 8 -- SecondaryLabTemp1Date
	AND SUBSTRING(@bitmap, 9, 1) & 16 <> 16 -- SecondaryLabTemp1Time
	AND SUBSTRING(@bitmap, 9, 1) & 32 <> 32 -- SecondaryLabTemp2
	AND SUBSTRING(@bitmap, 9, 1) & 64 <> 64 -- SecondaryLabTemp2Date
	AND SUBSTRING(@bitmap, 9, 1) & 128 <> 128 -- SecondaryLabTemp2Time
	AND SUBSTRING(@bitmap, 10, 1) & 1 <> 1 -- SecondaryLabTemp3
	AND SUBSTRING(@bitmap, 10, 1) & 2 <> 2 -- SecondaryLabTemp3Date
	AND SUBSTRING(@bitmap, 10, 1) & 4 <> 4 -- SecondaryLabTemp3Time
	AND SUBSTRING(@bitmap, 10, 1) & 8 <> 8 -- SecondaryCulture1Type
	AND SUBSTRING(@bitmap, 10, 1) & 16 <> 16 -- SecondaryCulture1Other
	AND SUBSTRING(@bitmap, 10, 1) & 32 <> 32 -- SecondaryCulture1DrawnDate
	AND SUBSTRING(@bitmap, 10, 1) & 64 <> 64 -- SecondaryCulture1Growth
	AND SUBSTRING(@bitmap, 10, 1) & 128 <> 128 -- SecondaryCulture2Type
	AND SUBSTRING(@bitmap, 11, 1) & 1 <> 1 -- SecondaryCulture2Other
	AND SUBSTRING(@bitmap, 11, 1) & 2 <> 2 -- SecondaryCulture2DrawnDate
	AND SUBSTRING(@bitmap, 11, 1) & 4 <> 4 -- SecondaryCulture2Growth
	AND SUBSTRING(@bitmap, 11, 1) & 8 <> 8 -- SecondaryCulture3Type
	AND SUBSTRING(@bitmap, 11, 1) & 16 <> 16 -- SecondaryCulture3Other
	AND SUBSTRING(@bitmap, 11, 1) & 32 <> 32 -- SecondaryCulture3DrawnDate
	AND SUBSTRING(@bitmap, 11, 1) & 64 <> 64 -- SecondaryCulture3Growth
	AND SUBSTRING(@bitmap, 11, 1) & 128 <> 128 -- SecondaryCXRAvailable
	AND SUBSTRING(@bitmap, 12, 1) & 1 <> 1 -- SecondaryCXR1Date
	AND SUBSTRING(@bitmap, 12, 1) & 2 <> 2 -- SecondaryCXR1Finding
	AND SUBSTRING(@bitmap, 12, 1) & 4 <> 4 -- SecondaryCXR2Date
	AND SUBSTRING(@bitmap, 12, 1) & 8 <> 8 -- SecondaryCXR2Finding
	AND SUBSTRING(@bitmap, 12, 1) & 16 <> 16 -- SecondaryCXR3Date
	AND SUBSTRING(@bitmap, 12, 1) & 32 <> 32 -- SecondaryCXR3Finding
	AND SUBSTRING(@bitmap, 12, 1) & 64 <> 64 -- SecondaryAntibiotic1NameOther
	AND SUBSTRING(@bitmap, 12, 1) & 128 <> 128 -- SecondaryAntibiotic2NameOther
	AND SUBSTRING(@bitmap, 13, 1) & 1 <> 1 -- SecondaryAntibiotic3NameOther
	AND SUBSTRING(@bitmap, 13, 1) & 2 <> 2 -- SecondaryAntibiotic4NameOther
	AND SUBSTRING(@bitmap, 13, 1) & 4 <> 4 -- SecondaryAntibiotic5NameOther
	AND SUBSTRING(@bitmap, 13, 1) & 8 <> 8 -- SecondaryBloodProductsReceived1TypeOther
	AND SUBSTRING(@bitmap, 13, 1) & 16 <> 16 -- SecondaryBloodProductsReceived2TypeOther
	AND SUBSTRING(@bitmap, 13, 1) & 32 <> 32 -- SecondaryBloodProductsReceived3TypeOther
	AND SUBSTRING(@bitmap, 13, 1) & 64 <> 64 -- SecondaryColloidsInfused1TypeOther
	AND SUBSTRING(@bitmap, 13, 1) & 128 <> 128 -- SecondaryColloidsInfused2TypeOther
	AND SUBSTRING(@bitmap, 14, 1) & 1 <> 1 -- SecondaryColloidsInfused3TypeOther
	AND SUBSTRING(@bitmap, 14, 1) & 2 <> 2 -- SecondaryCrystalloids1TypeOther
	AND SUBSTRING(@bitmap, 14, 1) & 4 <> 4 -- SecondaryCrystalloids2TypeOther
	AND SUBSTRING(@bitmap, 14, 1) & 8 <> 8 -- SecondaryCrystalloids3TypeOther
	AND SUBSTRING(@bitmap, 14, 1) & 16 <> 16 -- LastStatEmployeeID
	AND SUBSTRING(@bitmap, 14, 1) & 32 <> 32 -- AuditLogTypeID
	AND SUBSTRING(@bitmap, 14, 1) & 64 <> 64 -- LastModified
	AND @auditLogTypeID = 3	
	)
BEGIN
	SET @auditLogTypeID = 2	-- Review
END


insert into 
	"Secondary2"
	( 
		CallID,  --c1
		SecondaryAntibiotic1Name,  --c2
		SecondaryAntibiotic1Dose,  --c3
		SecondaryAntibiotic1StartDate,  --c4
		SecondaryAntibiotic1EndDate,  --c5
		SecondaryAntibiotic2Name,  --c6
		SecondaryAntibiotic2Dose,  --c7
		SecondaryAntibiotic2StartDate,  --c8
		SecondaryAntibiotic2EndDate,  --c9
		SecondaryAntibiotic3Name,  --c10
		SecondaryAntibiotic3Dose,  --c11
		SecondaryAntibiotic3StartDate,  --c12
		SecondaryAntibiotic3EndDate,  --c13
		SecondaryAntibiotic4Name,  --c14
		SecondaryAntibiotic4Dose,  --c15
		SecondaryAntibiotic4StartDate,  --c16
		SecondaryAntibiotic4EndDate,  --c17
		SecondaryAntibiotic5Name,  --c18
		SecondaryAntibiotic5Dose,  --c19
		SecondaryAntibiotic5StartDate,  --c20
		SecondaryAntibiotic5EndDate,  --c21
		SecondaryBloodProductsReceived1Type,  --c22
		SecondaryBloodProductsReceived1Units,  --c23
		SecondaryBloodProductsReceived1TypeCC,  --c24
		SecondaryBloodProductsReceived1TypeUnitGiven,  --c25
		SecondaryBloodProductsReceived2Type,  --c26
		SecondaryBloodProductsReceived2Units,  --c27
		SecondaryBloodProductsReceived2TypeCC,  --c28
		SecondaryBloodProductsReceived2TypeUnitGiven,  --c29
		SecondaryBloodProductsReceived3Type,  --c30
		SecondaryBloodProductsReceived3Units,  --c31
		SecondaryBloodProductsReceived3TypeCC,  --c32
		SecondaryBloodProductsReceived3TypeUnitGiven,  --c33
		SecondaryColloidsInfused1Type,  --c34
		SecondaryColloidsInfused1Units,  --c35
		SecondaryColloidsInfused1CC,  --c36
		SecondaryColloidsInfused1UnitGiven,  --c37
		SecondaryColloidsInfused2Type,  --c38
		SecondaryColloidsInfused2Units,  --c39
		SecondaryColloidsInfused2CC,  --c40
		SecondaryColloidsInfused2UnitGiven,  --c41
		SecondaryColloidsInfused3Type,  --c42
		SecondaryColloidsInfused3Units,  --c43
		SecondaryColloidsInfused3CC,  --c44
		SecondaryColloidsInfused3UnitGiven,  --c45
		SecondaryCrystalloids1Type,  --c46
		SecondaryCrystalloids1Units,  --c47
		SecondaryCrystalloids1CC,  --c48
		SecondaryCrystalloids1UnitGiven,  --c49
		SecondaryCrystalloids2Type,  --c50
		SecondaryCrystalloids2Units,  --c51
		SecondaryCrystalloids2CC,  --c52
		SecondaryCrystalloids2UnitGiven,  --c53
		SecondaryCrystalloids3Type,  --c54
		SecondaryCrystalloids3Units,  --c55
		SecondaryCrystalloids3CC,  --c56
		SecondaryCrystalloids3UnitGiven,  --c57
		SecondaryWBC1Date,  --c58
		SecondaryWBC1,  --c59
		SecondaryWBC1Bands,  --c60
		SecondaryWBC2Date,  --c61
		SecondaryWBC2,  --c62
		SecondaryWBC2Bands,  --c63
		SecondaryWBC3Date,  --c64
		SecondaryWBC3,  --c65
		SecondaryWBC3Bands,  --c66
		SecondaryLabTemp1,  --c67
		SecondaryLabTemp1Date,  --c68
		SecondaryLabTemp1Time,  --c69
		SecondaryLabTemp2,  --c70
		SecondaryLabTemp2Date,  --c71
		SecondaryLabTemp2Time,  --c72
		SecondaryLabTemp3,  --c73
		SecondaryLabTemp3Date,  --c74
		SecondaryLabTemp3Time,  --c75
		SecondaryCulture1Type,  --c76
		SecondaryCulture1Other,  --c77
		SecondaryCulture1DrawnDate,  --c78
		SecondaryCulture1Growth,  --c79
		SecondaryCulture2Type,  --c80
		SecondaryCulture2Other,  --c81
		SecondaryCulture2DrawnDate,  --c82
		SecondaryCulture2Growth,  --c83
		SecondaryCulture3Type,  --c84
		SecondaryCulture3Other,  --c85
		SecondaryCulture3DrawnDate,  --c86
		SecondaryCulture3Growth,  --c87
		SecondaryCXRAvailable,  --c88
		SecondaryCXR1Date,  --c89
		SecondaryCXR1Finding,  --c90
		SecondaryCXR2Date,  --c91
		SecondaryCXR2Finding,  --c92
		SecondaryCXR3Date,  --c93
		SecondaryCXR3Finding,  --c94
		SecondaryAntibiotic1NameOther,  --c95
		SecondaryAntibiotic2NameOther,  --c96
		SecondaryAntibiotic3NameOther,  --c97
		SecondaryAntibiotic4NameOther,  --c98
		SecondaryAntibiotic5NameOther,  --c99
		SecondaryBloodProductsReceived1TypeOther,  --c100
		SecondaryBloodProductsReceived2TypeOther,  --c101
		SecondaryBloodProductsReceived3TypeOther,  --c102
		SecondaryColloidsInfused1TypeOther,  --c103
		SecondaryColloidsInfused2TypeOther,  --c104
		SecondaryColloidsInfused3TypeOther,  --c105
		SecondaryCrystalloids1TypeOther,  --c106
		SecondaryCrystalloids2TypeOther,  --c107
		SecondaryCrystalloids3TypeOther,  --c108
		LastStatEmployeeID,  --c109
		AuditLogTypeID,  --c110
		LastModified  --c111

 )

values 
	( 
		@pkc1,
		CASE WHEN /*SecondaryAntibiotic1Name*/ SUBSTRING(@bitmap, 1, 1) & 2 = 2 AND IsNull(@c2, -1) IN ( -1, 0) THEN -2 ELSE @c2 END,
		CASE WHEN /*SecondaryAntibiotic1Dose*/ SUBSTRING(@bitmap, 1, 1) & 4 = 4 AND IsNull(@c3, '') = '' THEN 'ILB' ELSE @c3 END,
		CASE WHEN /*SecondaryAntibiotic1StartDate*/ SUBSTRING(@bitmap, 1, 1) & 8 = 8 AND IsNull(@c4, '') = '' THEN '01/01/1900' ELSE @c4 END,
		CASE WHEN /*SecondaryAntibiotic1EndDate*/ SUBSTRING(@bitmap, 1, 1) & 16 = 16 AND IsNull(@c5, '') = '' THEN '01/01/1900' ELSE @c5 END,
		CASE WHEN /*SecondaryAntibiotic2Name*/ SUBSTRING(@bitmap, 1, 1) & 32 = 32 AND IsNull(@c6, -1) IN ( -1, 0) THEN -2 ELSE @c6 END,
		CASE WHEN /*SecondaryAntibiotic2Dose*/ SUBSTRING(@bitmap, 1, 1) & 64 = 64 AND IsNull(@c7, '') = '' THEN 'ILB' ELSE @c7 END,
		CASE WHEN /*SecondaryAntibiotic2StartDate*/ SUBSTRING(@bitmap, 1, 1) & 128 = 128 AND IsNull(@c8, '') = '' THEN '01/01/1900' ELSE @c8 END,
		CASE WHEN /*SecondaryAntibiotic2EndDate*/ SUBSTRING(@bitmap, 2, 1) & 1 = 1 AND IsNull(@c9, '') = '' THEN '01/01/1900' ELSE @c9 END,
		CASE WHEN /*SecondaryAntibiotic3Name*/ SUBSTRING(@bitmap, 2, 1) & 2 = 2 AND IsNull(@c10, -1) IN ( -1, 0) THEN -2 ELSE @c10 END,
		CASE WHEN /*SecondaryAntibiotic3Dose*/ SUBSTRING(@bitmap, 2, 1) & 4 = 4 AND IsNull(@c11, '') = '' THEN 'ILB' ELSE @c11 END,
		CASE WHEN /*SecondaryAntibiotic3StartDate*/ SUBSTRING(@bitmap, 2, 1) & 8 = 8 AND IsNull(@c12, '') = '' THEN '01/01/1900' ELSE @c12 END,
		CASE WHEN /*SecondaryAntibiotic3EndDate*/ SUBSTRING(@bitmap, 2, 1) & 16 = 16 AND IsNull(@c13, '') = '' THEN '01/01/1900' ELSE @c13 END,
		CASE WHEN /*SecondaryAntibiotic4Name*/ SUBSTRING(@bitmap, 2, 1) & 32 = 32 AND IsNull(@c14, -1) IN ( -1, 0) THEN -2 ELSE @c14 END,
		CASE WHEN /*SecondaryAntibiotic4Dose*/ SUBSTRING(@bitmap, 2, 1) & 64 = 64 AND IsNull(@c15, '') = '' THEN 'ILB' ELSE @c15 END,
		CASE WHEN /*SecondaryAntibiotic4StartDate*/ SUBSTRING(@bitmap, 2, 1) & 128 = 128 AND IsNull(@c16, '') = '' THEN '01/01/1900' ELSE @c16 END,
		CASE WHEN /*SecondaryAntibiotic4EndDate*/ SUBSTRING(@bitmap, 3, 1) & 1 = 1 AND IsNull(@c17, '') = '' THEN '01/01/1900' ELSE @c17 END,
		CASE WHEN /*SecondaryAntibiotic5Name*/ SUBSTRING(@bitmap, 3, 1) & 2 = 2 AND IsNull(@c18, -1) IN ( -1, 0) THEN -2 ELSE @c18 END,
		CASE WHEN /*SecondaryAntibiotic5Dose*/ SUBSTRING(@bitmap, 3, 1) & 4 = 4 AND IsNull(@c19, '') = '' THEN 'ILB' ELSE @c19 END,
		CASE WHEN /*SecondaryAntibiotic5StartDate*/ SUBSTRING(@bitmap, 3, 1) & 8 = 8 AND IsNull(@c20, '') = '' THEN '01/01/1900' ELSE @c20 END,
		CASE WHEN /*SecondaryAntibiotic5EndDate*/ SUBSTRING(@bitmap, 3, 1) & 16 = 16 AND IsNull(@c21, '') = '' THEN '01/01/1900' ELSE @c21 END,
		CASE WHEN /*SecondaryBloodProductsReceived1Type*/ SUBSTRING(@bitmap, 3, 1) & 32 = 32 AND IsNull(@c22, -1) IN ( -1, 0) THEN -2 ELSE @c22 END,
		CASE WHEN /*SecondaryBloodProductsReceived1Units*/ SUBSTRING(@bitmap, 3, 1) & 64 = 64 AND IsNull(@c23, '') = '' THEN 'ILB' ELSE @c23 END,
		CASE WHEN /*SecondaryBloodProductsReceived1TypeCC*/ SUBSTRING(@bitmap, 3, 1) & 128 = 128 AND IsNull(@c24, '') = '' THEN 'ILB' ELSE @c24 END,
		CASE WHEN /*SecondaryBloodProductsReceived1TypeUnitGiven*/ SUBSTRING(@bitmap, 4, 1) & 1 = 1 AND IsNull(@c25, '') = '' THEN 'ILB' ELSE @c25 END,
		CASE WHEN /*SecondaryBloodProductsReceived2Type*/ SUBSTRING(@bitmap, 4, 1) & 2 = 2 AND IsNull(@c26, -1) IN ( -1, 0) THEN -2 ELSE @c26 END,
		CASE WHEN /*SecondaryBloodProductsReceived2Units*/ SUBSTRING(@bitmap, 4, 1) & 4 = 4 AND IsNull(@c27, '') = '' THEN 'ILB' ELSE @c27 END,
		CASE WHEN /*SecondaryBloodProductsReceived2TypeCC*/ SUBSTRING(@bitmap, 4, 1) & 8 = 8 AND IsNull(@c28, '') = '' THEN 'ILB' ELSE @c28 END,
		CASE WHEN /*SecondaryBloodProductsReceived2TypeUnitGiven*/ SUBSTRING(@bitmap, 4, 1) & 16 = 16 AND IsNull(@c29, '') = '' THEN 'ILB' ELSE @c29 END,
		CASE WHEN /*SecondaryBloodProductsReceived3Type*/ SUBSTRING(@bitmap, 4, 1) & 32 = 32 AND IsNull(@c30, -1) IN ( -1, 0) THEN -2 ELSE @c30 END,
		CASE WHEN /*SecondaryBloodProductsReceived3Units*/ SUBSTRING(@bitmap, 4, 1) & 64 = 64 AND IsNull(@c31, '') = '' THEN 'ILB' ELSE @c31 END,
		CASE WHEN /*SecondaryBloodProductsReceived3TypeCC*/ SUBSTRING(@bitmap, 4, 1) & 128 = 128 AND IsNull(@c32, '') = '' THEN 'ILB' ELSE @c32 END,
		CASE WHEN /*SecondaryBloodProductsReceived3TypeUnitGiven*/ SUBSTRING(@bitmap, 5, 1) & 1 = 1 AND IsNull(@c33, '') = '' THEN 'ILB' ELSE @c33 END,
		CASE WHEN /*SecondaryColloidsInfused1Type*/ SUBSTRING(@bitmap, 5, 1) & 2 = 2 AND IsNull(@c34, -1) IN ( -1, 0) THEN -2 ELSE @c34 END,
		CASE WHEN /*SecondaryColloidsInfused1Units*/ SUBSTRING(@bitmap, 5, 1) & 4 = 4 AND IsNull(@c35, '') = '' THEN 'ILB' ELSE @c35 END,
		CASE WHEN /*SecondaryColloidsInfused1CC*/ SUBSTRING(@bitmap, 5, 1) & 8 = 8 AND IsNull(@c36, '') = '' THEN 'ILB' ELSE @c36 END,
		CASE WHEN /*SecondaryColloidsInfused1UnitGiven*/ SUBSTRING(@bitmap, 5, 1) & 16 = 16 AND IsNull(@c37, '') = '' THEN 'ILB' ELSE @c37 END,
		CASE WHEN /*SecondaryColloidsInfused2Type*/ SUBSTRING(@bitmap, 5, 1) & 32 = 32 AND IsNull(@c38, -1) IN ( -1, 0) THEN -2 ELSE @c38 END,
		CASE WHEN /*SecondaryColloidsInfused2Units*/ SUBSTRING(@bitmap, 5, 1) & 64 = 64 AND IsNull(@c39, '') = '' THEN 'ILB' ELSE @c39 END,
		CASE WHEN /*SecondaryColloidsInfused2CC*/ SUBSTRING(@bitmap, 5, 1) & 128 = 128 AND IsNull(@c40, '') = '' THEN 'ILB' ELSE @c40 END,
		CASE WHEN /*SecondaryColloidsInfused2UnitGiven*/ SUBSTRING(@bitmap, 6, 1) & 1 = 1 AND IsNull(@c41, '') = '' THEN 'ILB' ELSE @c41 END,
		CASE WHEN /*SecondaryColloidsInfused3Type*/ SUBSTRING(@bitmap, 6, 1) & 2 = 2 AND IsNull(@c42, -1) IN ( -1, 0) THEN -2 ELSE @c42 END,
		CASE WHEN /*SecondaryColloidsInfused3Units*/ SUBSTRING(@bitmap, 6, 1) & 4 = 4 AND IsNull(@c43, '') = '' THEN 'ILB' ELSE @c43 END,
		CASE WHEN /*SecondaryColloidsInfused3CC*/ SUBSTRING(@bitmap, 6, 1) & 8 = 8 AND IsNull(@c44, '') = '' THEN 'ILB' ELSE @c44 END,
		CASE WHEN /*SecondaryColloidsInfused3UnitGiven*/ SUBSTRING(@bitmap, 6, 1) & 16 = 16 AND IsNull(@c45, '') = '' THEN 'ILB' ELSE @c45 END,
		CASE WHEN /*SecondaryCrystalloids1Type*/ SUBSTRING(@bitmap, 6, 1) & 32 = 32 AND IsNull(@c46, -1) IN ( -1, 0) THEN -2 ELSE @c46 END,
		CASE WHEN /*SecondaryCrystalloids1Units*/ SUBSTRING(@bitmap, 6, 1) & 64 = 64 AND IsNull(@c47, '') = '' THEN 'ILB' ELSE @c47 END,
		CASE WHEN /*SecondaryCrystalloids1CC*/ SUBSTRING(@bitmap, 6, 1) & 128 = 128 AND IsNull(@c48, '') = '' THEN 'ILB' ELSE @c48 END,
		CASE WHEN /*SecondaryCrystalloids1UnitGiven*/ SUBSTRING(@bitmap, 7, 1) & 1 = 1 AND IsNull(@c49, '') = '' THEN 'ILB' ELSE @c49 END,
		CASE WHEN /*SecondaryCrystalloids2Type*/ SUBSTRING(@bitmap, 7, 1) & 2 = 2 AND IsNull(@c50, -1) IN ( -1, 0) THEN -2 ELSE @c50 END,
		CASE WHEN /*SecondaryCrystalloids2Units*/ SUBSTRING(@bitmap, 7, 1) & 4 = 4 AND IsNull(@c51, '') = '' THEN 'ILB' ELSE @c51 END,
		CASE WHEN /*SecondaryCrystalloids2CC*/ SUBSTRING(@bitmap, 7, 1) & 8 = 8 AND IsNull(@c52, '') = '' THEN 'ILB' ELSE @c52 END,
		CASE WHEN /*SecondaryCrystalloids2UnitGiven*/ SUBSTRING(@bitmap, 7, 1) & 16 = 16 AND IsNull(@c53, '') = '' THEN 'ILB' ELSE @c53 END,
		CASE WHEN /*SecondaryCrystalloids3Type*/ SUBSTRING(@bitmap, 7, 1) & 32 = 32 AND IsNull(@c54, -1) IN ( -1, 0) THEN -2 ELSE @c54 END,
		CASE WHEN /*SecondaryCrystalloids3Units*/ SUBSTRING(@bitmap, 7, 1) & 64 = 64 AND IsNull(@c55, '') = '' THEN 'ILB' ELSE @c55 END,
		CASE WHEN /*SecondaryCrystalloids3CC*/ SUBSTRING(@bitmap, 7, 1) & 128 = 128 AND IsNull(@c56, '') = '' THEN 'ILB' ELSE @c56 END,
		CASE WHEN /*SecondaryCrystalloids3UnitGiven*/ SUBSTRING(@bitmap, 8, 1) & 1 = 1 AND IsNull(@c57, '') = '' THEN 'ILB' ELSE @c57 END,
		CASE WHEN /*SecondaryWBC1Date*/ SUBSTRING(@bitmap, 8, 1) & 2 = 2 AND IsNull(@c58, '') = '' THEN '01/01/1900' ELSE @c58 END,
		CASE WHEN /*SecondaryWBC1*/ SUBSTRING(@bitmap, 8, 1) & 4 = 4 AND IsNull(@c59, '') = '' THEN 'ILB' ELSE @c59 END,
		CASE WHEN /*SecondaryWBC1Bands*/ SUBSTRING(@bitmap, 8, 1) & 8 = 8 AND IsNull(@c60, '') = '' THEN 'ILB' ELSE @c60 END,
		CASE WHEN /*SecondaryWBC2Date*/ SUBSTRING(@bitmap, 8, 1) & 16 = 16 AND IsNull(@c61, '') = '' THEN '01/01/1900' ELSE @c61 END,
		CASE WHEN /*SecondaryWBC2*/ SUBSTRING(@bitmap, 8, 1) & 32 = 32 AND IsNull(@c62, '') = '' THEN 'ILB' ELSE @c62 END,
		CASE WHEN /*SecondaryWBC2Bands*/ SUBSTRING(@bitmap, 8, 1) & 64 = 64 AND IsNull(@c63, '') = '' THEN 'ILB' ELSE @c63 END,
		CASE WHEN /*SecondaryWBC3Date*/ SUBSTRING(@bitmap, 8, 1) & 128 = 128 AND IsNull(@c64, '') = '' THEN '01/01/1900' ELSE @c64 END,
		CASE WHEN /*SecondaryWBC3*/ SUBSTRING(@bitmap, 9, 1) & 1 = 1 AND IsNull(@c65, '') = '' THEN 'ILB' ELSE @c65 END,
		CASE WHEN /*SecondaryWBC3Bands*/ SUBSTRING(@bitmap, 9, 1) & 2 = 2 AND IsNull(@c66, '') = '' THEN 'ILB' ELSE @c66 END,
		CASE WHEN /*SecondaryLabTemp1*/ SUBSTRING(@bitmap, 9, 1) & 4 = 4 AND IsNull(@c67, '') = '' THEN 'ILB' ELSE @c67 END,
		CASE WHEN /*SecondaryLabTemp1Date*/ SUBSTRING(@bitmap, 9, 1) & 8 = 8 AND IsNull(@c68, '') = '' THEN '01/01/1900' ELSE @c68 END,
		CASE WHEN /*SecondaryLabTemp1Time*/ SUBSTRING(@bitmap, 9, 1) & 16 = 16 AND IsNull(@c69, '') = '' THEN 'ILB' ELSE @c69 END,
		CASE WHEN /*SecondaryLabTemp2*/ SUBSTRING(@bitmap, 9, 1) & 32 = 32 AND IsNull(@c70, '') = '' THEN 'ILB' ELSE @c70 END,
		CASE WHEN /*SecondaryLabTemp2Date*/ SUBSTRING(@bitmap, 9, 1) & 64 = 64 AND IsNull(@c71, '') = '' THEN '01/01/1900' ELSE @c71 END,
		CASE WHEN /*SecondaryLabTemp2Time*/ SUBSTRING(@bitmap, 9, 1) & 128 = 128 AND IsNull(@c72, '') = '' THEN 'ILB' ELSE @c72 END,
		CASE WHEN /*SecondaryLabTemp3*/ SUBSTRING(@bitmap, 10, 1) & 1 = 1 AND IsNull(@c73, '') = '' THEN 'ILB' ELSE @c73 END,
		CASE WHEN /*SecondaryLabTemp3Date*/ SUBSTRING(@bitmap, 10, 1) & 2 = 2 AND IsNull(@c74, '') = '' THEN '01/01/1900' ELSE @c74 END,
		CASE WHEN /*SecondaryLabTemp3Time*/ SUBSTRING(@bitmap, 10, 1) & 4 = 4 AND IsNull(@c75, '') = '' THEN 'ILB' ELSE @c75 END,
		CASE WHEN /*SecondaryCulture1Type*/ SUBSTRING(@bitmap, 10, 1) & 8 = 8 AND IsNull(@c76, -1) IN ( -1, 0) THEN -2 ELSE @c76 END,
		CASE WHEN /*SecondaryCulture1Other*/ SUBSTRING(@bitmap, 10, 1) & 16 = 16 AND IsNull(@c77, '') = '' THEN 'ILB' ELSE @c77 END,
		CASE WHEN /*SecondaryCulture1DrawnDate*/ SUBSTRING(@bitmap, 10, 1) & 32 = 32 AND IsNull(@c78, '') = '' THEN '01/01/1900' ELSE @c78 END,
		CASE WHEN /*SecondaryCulture1Growth*/ SUBSTRING(@bitmap, 10, 1) & 64 = 64 AND IsNull(@c79, '') = '' THEN 'ILB' ELSE @c79 END,
		CASE WHEN /*SecondaryCulture2Type*/ SUBSTRING(@bitmap, 10, 1) & 128 = 128 AND IsNull(@c80, -1) IN ( -1, 0) THEN -2 ELSE @c80 END,
		CASE WHEN /*SecondaryCulture2Other*/ SUBSTRING(@bitmap, 11, 1) & 1 = 1 AND IsNull(@c81, '') = '' THEN 'ILB' ELSE @c81 END,
		CASE WHEN /*SecondaryCulture2DrawnDate*/ SUBSTRING(@bitmap, 11, 1) & 2 = 2 AND IsNull(@c82, '') = '' THEN '01/01/1900' ELSE @c82 END,
		CASE WHEN /*SecondaryCulture2Growth*/ SUBSTRING(@bitmap, 11, 1) & 4 = 4 AND IsNull(@c83, '') = '' THEN 'ILB' ELSE @c83 END,
		CASE WHEN /*SecondaryCulture3Type*/ SUBSTRING(@bitmap, 11, 1) & 8 = 8 AND IsNull(@c84, -1) IN ( -1, 0) THEN -2 ELSE @c84 END,
		CASE WHEN /*SecondaryCulture3Other*/ SUBSTRING(@bitmap, 11, 1) & 16 = 16 AND IsNull(@c85, '') = '' THEN 'ILB' ELSE @c85 END,
		CASE WHEN /*SecondaryCulture3DrawnDate*/ SUBSTRING(@bitmap, 11, 1) & 32 = 32 AND IsNull(@c86, '') = '' THEN '01/01/1900' ELSE @c86 END,
		CASE WHEN /*SecondaryCulture3Growth*/ SUBSTRING(@bitmap, 11, 1) & 64 = 64 AND IsNull(@c87, '') = '' THEN 'ILB' ELSE @c87 END,
		CASE WHEN /*SecondaryCXRAvailable*/ SUBSTRING(@bitmap, 11, 1) & 128 = 128 AND IsNull(@c88, -1) IN ( -1, 0) THEN -2 ELSE @c88 END,
		CASE WHEN /*SecondaryCXR1Date*/ SUBSTRING(@bitmap, 12, 1) & 1 = 1 AND IsNull(@c89, '') = '' THEN '01/01/1900' ELSE @c89 END,
		CASE WHEN /*SecondaryCXR1Finding*/ SUBSTRING(@bitmap, 12, 1) & 2 = 2 AND IsNull(@c90, '') = '' THEN 'ILB' ELSE @c90 END,
		CASE WHEN /*SecondaryCXR2Date*/ SUBSTRING(@bitmap, 12, 1) & 4 = 4 AND IsNull(@c91, '') = '' THEN '01/01/1900' ELSE @c91 END,
		CASE WHEN /*SecondaryCXR2Finding*/ SUBSTRING(@bitmap, 12, 1) & 8 = 8 AND IsNull(@c92, '') = '' THEN 'ILB' ELSE @c92 END,
		CASE WHEN /*SecondaryCXR3Date*/ SUBSTRING(@bitmap, 12, 1) & 16 = 16 AND IsNull(@c93, '') = '' THEN '01/01/1900' ELSE @c93 END,
		CASE WHEN /*SecondaryCXR3Finding*/ SUBSTRING(@bitmap, 12, 1) & 32 = 32 AND IsNull(@c94, '') = '' THEN 'ILB' ELSE @c94 END,
		CASE WHEN /*SecondaryAntibiotic1NameOther*/ SUBSTRING(@bitmap, 12, 1) & 64 = 64 AND IsNull(@c95, '') = '' THEN 'ILB' ELSE @c95 END,
		CASE WHEN /*SecondaryAntibiotic2NameOther*/ SUBSTRING(@bitmap, 12, 1) & 128 = 128 AND IsNull(@c96, '') = '' THEN 'ILB' ELSE @c96 END,
		CASE WHEN /*SecondaryAntibiotic3NameOther*/ SUBSTRING(@bitmap, 13, 1) & 1 = 1 AND IsNull(@c97, '') = '' THEN 'ILB' ELSE @c97 END,
		CASE WHEN /*SecondaryAntibiotic4NameOther*/ SUBSTRING(@bitmap, 13, 1) & 2 = 2 AND IsNull(@c98, '') = '' THEN 'ILB' ELSE @c98 END,
		CASE WHEN /*SecondaryAntibiotic5NameOther*/ SUBSTRING(@bitmap, 13, 1) & 4 = 4 AND IsNull(@c99, '') = '' THEN 'ILB' ELSE @c99 END,
		CASE WHEN /*SecondaryBloodProductsReceived1TypeOther*/ SUBSTRING(@bitmap, 13, 1) & 8 = 8 AND IsNull(@c100, '') = '' THEN 'ILB' ELSE @c100 END,
		CASE WHEN /*SecondaryBloodProductsReceived2TypeOther*/ SUBSTRING(@bitmap, 13, 1) & 16 = 16 AND IsNull(@c101, '') = '' THEN 'ILB' ELSE @c101 END,
		CASE WHEN /*SecondaryBloodProductsReceived3TypeOther*/ SUBSTRING(@bitmap, 13, 1) & 32 = 32 AND IsNull(@c102, '') = '' THEN 'ILB' ELSE @c102 END,
		CASE WHEN /*SecondaryColloidsInfused1TypeOther*/ SUBSTRING(@bitmap, 13, 1) & 64 = 64 AND IsNull(@c103, '') = '' THEN 'ILB' ELSE @c103 END,
		CASE WHEN /*SecondaryColloidsInfused2TypeOther*/ SUBSTRING(@bitmap, 13, 1) & 128 = 128 AND IsNull(@c104, '') = '' THEN 'ILB' ELSE @c104 END,
		CASE WHEN /*SecondaryColloidsInfused3TypeOther*/ SUBSTRING(@bitmap, 14, 1) & 1 = 1 AND IsNull(@c105, '') = '' THEN 'ILB' ELSE @c105 END,
		CASE WHEN /*SecondaryCrystalloids1TypeOther*/ SUBSTRING(@bitmap, 14, 1) & 2 = 2 AND IsNull(@c106, '') = '' THEN 'ILB' ELSE @c106 END,
		CASE WHEN /*SecondaryCrystalloids2TypeOther*/ SUBSTRING(@bitmap, 14, 1) & 4 = 4 AND IsNull(@c107, '') = '' THEN 'ILB' ELSE @c107 END,
		CASE WHEN /*SecondaryCrystalloids3TypeOther*/ SUBSTRING(@bitmap, 14, 1) & 8 = 8 AND IsNull(@c108, '') = '' THEN 'ILB' ELSE @c108 END,
		ISNULL(@c109, @LastStatEmployeeID),
		@auditLogTypeID,
		ISNULL(@c111, @lastModified)
	)

END

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

