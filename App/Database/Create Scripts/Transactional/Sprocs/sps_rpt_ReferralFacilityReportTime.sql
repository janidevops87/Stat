IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'sps_rpt_ReferralFacilityReportTime')
	BEGIN
		PRINT 'Dropping Procedure sps_rpt_ReferralFacilityReportTime'
		DROP Procedure sps_rpt_ReferralFacilityReportTime
	END
GO

PRINT 'Creating Procedure sps_rpt_ReferralFacilityReportTime'
GO
Create procedure sps_rpt_ReferralFacilityReportTime
AS
/******************************************************************************
**	File: sps_rpt_ReferralFacilityReportTime.sql
**	Name: sps_rpt_ReferralFacilityReportTime
**	Desc: 
**	Auth: Susan Dabrini
**	Date: 1/26/2011
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	1/18/2011		Bret Knoll			Initial Sproc Creation (9376)
**	12/03/2012		James Gerberich		Archive database is being turned off, so
**										this sproc is modified to eliminate
**										the database selection
*******************************************************************************/

DECLARE
	@ReferralStartDateTime	DateTime,
	@ReferralEndDateTime	DateTime,
	@CardiacStartDateTime	DateTime,
	@CardiacEndDateTime		DateTime,
	@ReportGroupID			Int,
	@OrganizationTypeId		Int,
	@OrganizationID			Int,
	@SourceCodeName			VarChar(15),
	@DisplayMT				Bit,
	@LowerAgeLimit			Int,
	@UpperAgeLimit			Int,
	@ReferralDonorGender	varchar(15),
	@StartRange1			INT,
	@uom1					bit,
	@EndRange1				INT,
	@StartRange2			INT, 
	@uom2					bit,
	@EndRange2				INT,
	@StartRange3			INT,
	@uom3					bit,
	@EndRange3				INT,
	@StartRange4			INT, 
	@uom4					bit,
	@EndRange4				INT,
	@StartRange5			INT,
	@uom5					bit,
	@EndRange5				INT,
	@StartRange6			INT,
	@uom6					bit,
	@EndRange6				INT,
	@StartRange7			INT, 
	@uom7					bit,
	@EndRange7				INT,
	@StartRange8			INT,
	@uom8					bit,
	@EndRange8				INT,
	@StartRange9			INT,
	@uom9					bit,
	@EndRange9				INT,
	@StartRange10			INT, 
	@uom10					bit,
	@EndRange10				INT,
	@StartRange11			INT,
	@uom11					bit,
	@EndRange11				INT,
	@StartRange12			INT,
	@uom12					bit,
	@EndRange12				INT,
	@StartRange13			INT, 
	@uom13					bit,
	@EndRange13				INT,
	@StartRange14			INT, 
	@uom14					bit,
	@EndRange14				INT,
	@StartRange15			INT,
	@uom15					bit,
	@EndRange15				INT,
	@StartRange16			INT,
	@uom16					bit,
	@EndRange16				INT,
	@StartRange17			INT,
	@uom17					bit,
	@EndRange17				INT,
	@StartRange18			INT,
	@uom18					bit,
	@EndRange18				INT,
	@StartRange19			INT,
	@uom19					bit,
	@EndRange19				INT,
	@StartRange20			INT,
	@uom20					bit,
	@EndRange20				INT
	

SELECT
	@ReferralStartDateTime	= '2010-01-01 12:00:00', --CAST (DATEPART(yyyy,GETDATE())AS VarChar) + '-' + RIGHT('0' + CONVERT(VarChar,DATEPART(mm,GETDATE())),2) + '-' + '01',
	@ReferralEndDateTime	= '2010-01-10 12:00:00', --CAST (DATEPART(yyyy,GETDATE())AS VarChar) + '-' + RIGHT('0' + CONVERT(VarChar,DATEPART(mm,GETDATE())),2)  + '-' + RIGHT('0' + CONVERT(VarChar,DATEPART(dd,GETDATE())),2)
	@CardiacStartDateTime	=  NULL,
	@CardiacEndDateTime		=  NULL,
	@ReportGroupID			=  1937,
	@OrganizationTypeId		=  Null,
	@OrganizationID			=  NULL,
	@SourceCodeName			=  'CASD',
	@DisplayMT				=  0, --1,
	@LowerAgeLimit			=  NULL,
	@UpperAgeLimit			=  NULL,
	@ReferralDonorGender	=  'F', -- M or F
	@StartRange1			=  60,--0,
	@UOM1					=  1,
	@EndRange1				=  70,  -- 60,
	@StartRange2			=  71, --180,
	@UOM2					=  1,
	@EndRange2				=  81,	 --360
	@StartRange3			=  82,
	@uom3					=  1, 
	@EndRange3				=  92, 
	@StartRange4			=  93,
	@uom4					=  1,  
	@EndRange4				=  103, 
	@StartRange5			=  104, 
	@uom5					=  1,  
	@EndRange5				=  114, 
	@StartRange6			=  115,
	@uom6					=  1,   
	@EndRange6				=  125, 
	@StartRange7			=  126,
	@uom7					=  1,  
	@EndRange7				=  136, 
	@StartRange8			=  137,
	@uom8					=  1,   
	@EndRange8				=  138, 
	@StartRange9			=  139, 
	@uom9					=  1,  
	@EndRange9				=  149, 
	@StartRange10			=  150, 
	@uom10					=  1,  
	@EndRange10				=  160, 
	@StartRange11			=  161,
	@uom11					=  1,  
	@EndRange11				=  171, 
	@StartRange12			=  172,
	@uom12					=  1,   
	@EndRange12				=  182, 
	@StartRange13			=  183,
	@uom13					=  1,  
	@EndRange13				=  193, 
	@StartRange14			=  194, 
	@uom14					=  1,  
	@EndRange14				=  204, 
	@StartRange15			=  205,
	@uom15					=  1,   
	@EndRange15				=  215, 
	@StartRange16			=  216, 
	@uom16					=  1, 
	@EndRange16				=  226, 
	@StartRange17			=  227,  
	@uom17					=  1, 
	@EndRange17				=  237, 
	@StartRange18			=  238,  
	@uom18					=  1, 
	@EndRange18				=  248, 
	@StartRange19			=  249, 
	@uom19					=  1,  
	@EndRange19				=  259, 
	@StartRange20			=  260, 
	@uom20					=  1, 
	@EndRange20				=  270
	
	
----------------------------------------------------------------------------

----Get all of the initial data for the subsequent calculations

CREATE TABLE #Staging
	(
StartRange1					int,
EndRange1					int,
StartRange2					INT, 
EndRange2					INT,
StartRange3					INT,
EndRange3					INT,
StartRange4					INT, 
EndRange4					INT,
StartRange5					INT,
EndRange5					INT,
StartRange6					INT,
EndRange6					INT,
StartRange7					INT, 
EndRange7					INT,
StartRange8					INT,
EndRange8					INT,
StartRange9					INT,
EndRange9					INT,
StartRange10				INT, 
EndRange10					INT,
StartRange11				INT,
EndRange11					INT,
StartRange12				INT,
EndRange12					INT,
StartRange13				INT, 
EndRange13					INT,
StartRange14				INT, 
EndRange14					INT,
StartRange15				INT,
EndRange15					INT,
StartRange16				INT,
EndRange16					INT,
StartRange17				INT,
EndRange17					INT,
StartRange18				INT,
EndRange18					INT,
StartRange19				INT,
EndRange19					INT,
StartRange20				INT,
EndRange20					INT,
Minutes						int,
callid						int,
calldatetime				datetime,
ReferraldonorDeathdatetime	datetime,
ReferralDonorGender			char(10),
ReferralDOB					datetime,
ReferralDonorAge			varchar(4),
ReferralDonorAgeUnit		varchar(10),
OrganizationType			Varchar(50),
OrganizationName			varchar(80),
ReferralDonorCauseOfDeathID int,
registrytypeid				int,
registrytype				varchar(50),
currentreferraltypeid		int,
referraltypename			varchar(50),
Organ						varchar(50),
Bone						varchar(50),
Tissue						varchar(50),
Skin						varchar(50),
EyesTrans					varchar(50),
EyesRsch					varchar(50),
Valves						varchar(50)

)
	

----------------------------------------------------------------------------

--DECLARE
--	@Source_DB int  
--SET
--	@Source_DB = 1 /* SET database to production (default) */

----------------------------------------------------------------------------

----Determine if date range is in Archive db

--DECLARE
--	@MaxTableDate DateTime
--SELECT
--	@MaxTableDate = MAX(TableDate)
--FROM
--	ArchiveStatus

--IF
--	IsNull(@ReferralStartDateTime,@CardiacStartDateTime) > @MaxTableDate
--AND DB_NAME() NOT LIKE '%archive%'
--		BEGIN
--			SET @Source_DB = 1
--		END 

--IF
--	IsNull(@ReferralStartDateTime,@CardiacStartDateTime) < @MaxTableDate 
--AND IsNull(@ReferralEndDateTime,@CardiacEndDateTime) < @maxTableDate
--AND DB_NAME() NOT LIKE '%archive%'
--		BEGIN
--			SET @Source_DB = 2
--		END 

--IF
--	IsNull(@ReferralStartDateTime,@CardiacStartDateTime) < @MaxTableDate 
--AND	IsNull(@ReferralEndDateTime,@CardiacEndDateTime) > @maxTableDate
--AND DB_NAME() NOT LIKE '%archive%'
--		BEGIN
--			SET @Source_DB = 3
--		END

----------------------------------------------------------------------------

--IF
--	@Source_DB = 3 /* Need to run in both archive and production databases */
--BEGIN
--	/* run in Archive database */	
--	INSERT
--		#Staging 
--	EXEC
--		_ReferralProdArchive..sps_rpt_ReferralFacilityReportTime_Select
--			@ReferralStartDateTime,
--			@ReferralEndDateTime,
--			@CardiacStartDateTime,
--			@CardiacEndDateTime,
--			@ReportGroupID,
--			@OrganizationTypeId,
--			@OrganizationID,
--			@SourceCodeName,
--			@DisplayMT,
--			@LowerAgeLimit,
--			@UpperAgeLimit,
--			@ReferralDonorGender,
--			@StartRange1,
--			@UOM1,
--			@EndRange1,
--			@StartRange2,
--			@UOM2, 
--			@EndRange2,
--			@StartRange3,
--			@UOM3,
--			@EndRange3,
--			@StartRange4, 
--			@UOM4,
--			@EndRange4,
--			@StartRange5,
--			@UOM5,
--			@EndRange5,
--			@StartRange6,
--			@UOM6,
--			@EndRange6,
--			@StartRange7, 
--			@UOM7,
--			@EndRange7,
--			@StartRange8,
--			@UOM8,
--			@EndRange8,
--			@StartRange9,
--			@UOM9,
--			@EndRange9,
--			@StartRange10,
--			@UOM10, 
--			@EndRange10,
--			@StartRange11,
--			@UOM11,
--			@EndRange11,
--			@StartRange12,
--			@UOM12,
--			@EndRange12,
--			@StartRange13, 
--			@UOM13,
--			@EndRange13,
--			@StartRange14, 
--			@UOM14,
--			@EndRange14,
--			@StartRange15,
--			@UOM15,
--			@EndRange15,
--			@StartRange16,
--			@UOM16,
--			@EndRange16,
--			@StartRange17,
--			@UOM17,
--			@EndRange17,
--			@StartRange18,
--			@UOM18,
--			@EndRange18,
--			@StartRange19,
--			@UOM19,
--			@EndRange19,
--			@StartRange20,
--			@UOM20,
--			@EndRange20	
			
			


--	/* run in production database */
--	INSERT
--		#Staging 
--	EXEC
--		sps_rpt_ReferralFacilityReportTime_Select
--			@ReferralStartDateTime,
--			@ReferralEndDateTime,
--			@CardiacStartDateTime,
--			@CardiacEndDateTime,
--			@ReportGroupID,
--			@OrganizationTypeId,
--			@OrganizationID,
--			@SourceCodeName,
--			@DisplayMT,
--			@LowerAgeLimit,
--			@UpperAgeLimit,
--			@ReferralDonorGender,
--			@StartRange1,
--			@UOM1,
--			@EndRange1,
--			@StartRange2,
--			@UOM2, 
--			@EndRange2,
--			@StartRange3,
--			@UOM3,
--			@EndRange3,
--			@StartRange4, 
--			@UOM4,
--			@EndRange4,
--			@StartRange5,
--			@UOM5,
--			@EndRange5,
--			@StartRange6,
--			@UOM6,
--			@EndRange6,
--			@StartRange7, 
--			@UOM7,
--			@EndRange7,
--			@StartRange8,
--			@UOM8,
--			@EndRange8,
--			@StartRange9,
--			@UOM9,
--			@EndRange9,
--			@StartRange10,
--			@UOM10, 
--			@EndRange10,
--			@StartRange11,
--			@UOM11,
--			@EndRange11,
--			@StartRange12,
--			@UOM12,
--			@EndRange12,
--			@StartRange13, 
--			@UOM13,
--			@EndRange13,
--			@StartRange14, 
--			@UOM14,
--			@EndRange14,
--			@StartRange15,
--			@UOM15,
--			@EndRange15,
--			@StartRange16,
--			@UOM16,
--			@EndRange16,
--			@StartRange17,
--			@UOM17,
--			@EndRange17,
--			@StartRange18,
--			@UOM18,
--			@EndRange18,
--			@StartRange19,
--			@UOM19,
--			@EndRange19,
--			@StartRange20,
--			@UOM20,
--			@EndRange20	

			
--END

------------------------------------------------------------------------------

--IF
--	@Source_DB = 2 /* run in Archive database only */	
--BEGIN
--	INSERT
--		#Staging 
--	EXEC _ReferralProdArchive..sps_rpt_ReferralFacilityReportTime_Select
--			@ReferralStartDateTime,
--			@ReferralEndDateTime,
--			@CardiacStartDateTime,
--			@CardiacEndDateTime,
--			@ReportGroupID,
--			@OrganizationTypeId,
--			@OrganizationID,
--			@SourceCodeName,
--			@DisplayMT,
--			@LowerAgeLimit,
--			@UpperAgeLimit,
--			@ReferralDonorGender,
--			@StartRange1,
--			@UOM1,
--			@EndRange1,
--			@StartRange2,
--			@UOM2, 
--			@EndRange2,
--			@StartRange3,
--			@UOM3,
--			@EndRange3,
--			@StartRange4, 
--			@UOM4,
--			@EndRange4,
--			@StartRange5,
--			@UOM5,
--			@EndRange5,
--			@StartRange6,
--			@UOM6,
--			@EndRange6,
--			@StartRange7, 
--			@UOM7,
--			@EndRange7,
--			@StartRange8,
--			@UOM8,
--			@EndRange8,
--			@StartRange9,
--			@UOM9,
--			@EndRange9,
--			@StartRange10,
--			@UOM10, 
--			@EndRange10,
--			@StartRange11,
--			@UOM11,
--			@EndRange11,
--			@StartRange12,
--			@UOM12,
--			@EndRange12,
--			@StartRange13, 
--			@UOM13,
--			@EndRange13,
--			@StartRange14, 
--			@UOM14,
--			@EndRange14,
--			@StartRange15,
--			@UOM15,
--			@EndRange15,
--			@StartRange16,
--			@UOM16,
--			@EndRange16,
--			@StartRange17,
--			@UOM17,
--			@EndRange17,
--			@StartRange18,
--			@UOM18,
--			@EndRange18,
--			@StartRange19,
--			@UOM19,
--			@EndRange19,
--			@StartRange20,
--			@UOM20,
--			@EndRange20	
			
--END

------------------------------------------------------------------------------

--IF
--	@Source_DB = 1 /* run in production database only */
--BEGIN
	INSERT
		#Staging 
	EXEC
		sps_rpt_ReferralFacilityReportTime_Select
			@ReferralStartDateTime,
			@ReferralEndDateTime,
			@CardiacStartDateTime,
			@CardiacEndDateTime,
			@ReportGroupID,
			@OrganizationTypeId,
			@OrganizationID,
			@SourceCodeName,
			@DisplayMT,
			@LowerAgeLimit,
			@UpperAgeLimit,
			@ReferralDonorGender,
			@StartRange1,
			@UOM1,
			@EndRange1,
			@StartRange2,
			@UOM2, 
			@EndRange2,
			@StartRange3,
			@UOM3,
			@EndRange3,
			@StartRange4, 
			@UOM4,
			@EndRange4,
			@StartRange5,
			@UOM5,
			@EndRange5,
			@StartRange6,
			@UOM6,
			@EndRange6,
			@StartRange7, 
			@UOM7,
			@EndRange7,
			@StartRange8,
			@UOM8,
			@EndRange8,
			@StartRange9,
			@UOM9,
			@EndRange9,
			@StartRange10,
			@UOM10, 
			@EndRange10,
			@StartRange11,
			@UOM11,
			@EndRange11,
			@StartRange12,
			@UOM12,
			@EndRange12,
			@StartRange13, 
			@UOM13,
			@EndRange13,
			@StartRange14, 
			@UOM14,
			@EndRange14,
			@StartRange15,
			@UOM15,
			@EndRange15,
			@StartRange16,
			@UOM16,
			@EndRange16,
			@StartRange17,
			@UOM17,
			@EndRange17,
			@StartRange18,
			@UOM18,
			@EndRange18,
			@StartRange19,
			@UOM19,
			@EndRange19,
			@StartRange20,
			@UOM20,
			@EndRange20	

			
--END

------------------------------------------------------------------------------

----Temp table to hold the calculated values

CREATE TABLE #Results
	(
		
		StartRange1			Int,
		EndRange1			Int,
		StartRange2			Int, 
		EndRange2			int,
		StartRange3			Int default null,
		EndRange3			Int default null,
		StartRange4			Int, 
		EndRange4			Int,
		StartRange5			Int,
		EndRange5			Int,
		StartRange6			Int,
		EndRange6			Int,
		StartRange7			Int, 
		EndRange7			Int,
		StartRange8			Int,
		EndRange8			Int,
		StartRange9			Int,
		EndRange9			Int,
		StartRange10		Int, 
		EndRange10			Int,
		StartRange11		Int,
		EndRange11			Int,
		StartRange12		Int,
		EndRange12			Int,
		StartRange13		Int, 
		EndRange13			Int,
		StartRange14		Int, 
		EndRange14			Int,
		StartRange15		Int,
		EndRange15			Int,
		StartRange16		Int,
		EndRange16			Int,
		StartRange17		Int,
		EndRange17			Int,
		StartRange18		Int,
		EndRange18			Int,
		StartRange19		Int,
		EndRange19			Int,
		StartRange20		Int,
		EndRange20			Int,
		OrganizationType	Varchar(50),
		OrganizationName	VarChar(80),
		ReferralDonorGender varchar(80),
		TotalReferrals		Int	DEFAULT 0,
		TotalNoCTOD			Int	DEFAULT 0,
		TotalCTOD			Int	DEFAULT 0,
		TotalRegistered		Int	DEFAULT 0,
		TotalTissue			Int	DEFAULT 0,
		Total_TE			Int	DEFAULT 0,
		TotalEyesOnly		Int	DEFAULT 0,
		TotalOtherEye		Int	DEFAULT 0,
		TotalOther			Int	DEFAULT 0,
		TotalAgeRO			Int	DEFAULT 0,
		TotalMedRO			Int	DEFAULT 0,
		TotalAvgTime		Int	DEFAULT 0,
		PercentOneHour		Int	DEFAULT 0
		
	)


-----------Begin Range 1

INSERT INTO

	#Results
		(
			
			StartRange1,
			EndRange1,
			ReferralDonorGender,
			OrganizationName
		)
					
		Select Distinct
			
		@StartRange1,
		@EndRange1,
		ReferralDonorGender,
		r.OrganizationName

FROM	#Staging r
where r.ReferralDonorGender = ReferralDonorGender
 and r.OrganizationName = OrganizationName
and Minutes between @StartRange1 and @EndRange1
------------------------
-------Range 2

INSERT INTO

	#Results
		(
			
			StartRange2,
			EndRange2,
			ReferralDonorGender,
			OrganizationName
		)
					
		Select Distinct
			
		@StartRange2,
		@EndRange2,
		ReferralDonorGender,
		r.OrganizationName

FROM	#Staging r
where r.ReferralDonorGender = ReferralDonorGender
and r.OrganizationName = OrganizationName
and Minutes between @StartRange2 and @EndRange2
------------------

-------Range 3

INSERT INTO

	#Results
		(
			
			StartRange3,
			EndRange3,
			ReferralDonorGender,
			OrganizationName
		)
					
		Select Distinct
			
		@StartRange3,
		@EndRange3,
		ReferralDonorGender,
		r.OrganizationName

FROM	#Staging r
where r.ReferralDonorGender = ReferralDonorGender
and r.OrganizationName = OrganizationName
and Minutes between @StartRange3 and @EndRange3
------------------

-------Range 4

INSERT INTO

	#Results
		(
			
			StartRange4,
			EndRange4,
			ReferralDonorGender,
			OrganizationName
		)
					
		Select Distinct
			
		@StartRange4,
		@EndRange4,
		ReferralDonorGender,
		r.OrganizationName

FROM	#Staging r
where r.ReferralDonorGender = ReferralDonorGender
and r.OrganizationName = OrganizationName
and Minutes between @StartRange4 and @EndRange4
------------------

-------Range 5

INSERT INTO

	#Results
		(
			
			StartRange5,
			EndRange5,
			ReferralDonorGender,
			OrganizationName
		)
					
		Select Distinct
			
		@StartRange5,
		@EndRange5,
		ReferralDonorGender,
		r.OrganizationName

FROM	#Staging r
where r.ReferralDonorGender = ReferralDonorGender
and r.OrganizationName = OrganizationName
and Minutes between @StartRange5 and @EndRange5
------------------

-------Range 6

INSERT INTO

	#Results
		(
			
			StartRange6,
			EndRange6,
			ReferralDonorGender,
			OrganizationName
		)
					
		Select Distinct
			
		@StartRange6,
		@EndRange6,
		ReferralDonorGender,
		r.OrganizationName

FROM	#Staging r
where r.ReferralDonorGender = ReferralDonorGender
and r.OrganizationName = OrganizationName
and Minutes between @StartRange6 and @EndRange6
------------------

-------Range 7

INSERT INTO

	#Results
		(
			
			StartRange7,
			EndRange7,
			ReferralDonorGender,
			OrganizationName
		)
					
		Select Distinct
			
		@StartRange7,
		@EndRange7,
		ReferralDonorGender,
		r.OrganizationName

FROM	#Staging r
where r.ReferralDonorGender = ReferralDonorGender
and r.OrganizationName = OrganizationName
and Minutes between @StartRange7 and @EndRange7
------------------

-------Range 8

INSERT INTO

	#Results
		(
			
			StartRange8,
			EndRange8,
			ReferralDonorGender,
			OrganizationName
		)
					
		Select Distinct
			
		@StartRange8,
		@EndRange8,
		ReferralDonorGender,
		r.OrganizationName

FROM	#Staging r
where r.ReferralDonorGender = ReferralDonorGender
and r.OrganizationName = OrganizationName
and Minutes between @StartRange8 and @EndRange8
------------------

-------Range 9

INSERT INTO

	#Results
		(
			
			StartRange9,
			EndRange9,
			ReferralDonorGender,
			OrganizationName
		)
					
		Select Distinct
			
		@StartRange9,
		@EndRange9,
		ReferralDonorGender,
		r.OrganizationName

FROM	#Staging r
where r.ReferralDonorGender = ReferralDonorGender
and r.OrganizationName = OrganizationName
and Minutes between @StartRange9 and @EndRange9
------------------

-------Range 10

INSERT INTO

	#Results
		(
			
			StartRange10,
			EndRange10,
			ReferralDonorGender,
			OrganizationName
		)
					
		Select Distinct
			
		@StartRange10,
		@EndRange10,
		ReferralDonorGender,
		r.OrganizationName

FROM	#Staging r
where r.ReferralDonorGender = ReferralDonorGender
and r.OrganizationName = OrganizationName
and Minutes between @StartRange10 and @EndRange10
------------------

-------Range 11

INSERT INTO

	#Results
		(
			
			StartRange11,
			EndRange11,
			ReferralDonorGender,
			OrganizationName
		)
					
		Select Distinct
			
		@StartRange11,
		@EndRange11,
		ReferralDonorGender,
		r.OrganizationName

FROM	#Staging r
where r.ReferralDonorGender = ReferralDonorGender
and r.OrganizationName = OrganizationName
and Minutes between @StartRange11 and @EndRange11
------------------

-------Range 12

INSERT INTO

	#Results
		(
			
			StartRange12,
			EndRange12,
			ReferralDonorGender,
			OrganizationName
		)
					
		Select Distinct
			
		@StartRange12,
		@EndRange12,
		ReferralDonorGender,
		r.OrganizationName

FROM	#Staging r
where r.ReferralDonorGender = ReferralDonorGender
and r.OrganizationName = OrganizationName
and Minutes between @StartRange12 and @EndRange12
------------------

-------Range 13

INSERT INTO

	#Results
		(
			
			StartRange13,
			EndRange13,
			ReferralDonorGender,
			OrganizationName
		)
					
		Select Distinct
			
		@StartRange13,
		@EndRange13,
		ReferralDonorGender,
		r.OrganizationName

FROM	#Staging r
where r.ReferralDonorGender = ReferralDonorGender
and r.OrganizationName = OrganizationName
and Minutes between @StartRange13 and @EndRange13
------------------

-------Range 14

INSERT INTO

	#Results
		(
			
			StartRange14,
			EndRange14,
			ReferralDonorGender,
			OrganizationName
		)
					
		Select Distinct
			
		@StartRange14,
		@EndRange14,
		ReferralDonorGender,
		r.OrganizationName

FROM	#Staging r
where r.ReferralDonorGender = ReferralDonorGender
and r.OrganizationName = OrganizationName
and Minutes between @StartRange14 and @EndRange14
------------------

-------Range 15

INSERT INTO

	#Results
		(
			
			StartRange15,
			EndRange15,
			ReferralDonorGender,
			OrganizationName
		)
					
		Select Distinct
			
		@StartRange15,
		@EndRange15,
		ReferralDonorGender,
		r.OrganizationName

FROM	#Staging r
where r.ReferralDonorGender = ReferralDonorGender
and r.OrganizationName = OrganizationName
and Minutes between @StartRange15 and @EndRange15
------------------

-------Range 16

INSERT INTO

	#Results
		(
			
			StartRange16,
			EndRange16,
			ReferralDonorGender,
			OrganizationName
		)
					
		Select Distinct
			
		@StartRange16,
		@EndRange16,
		ReferralDonorGender,
		r.OrganizationName

FROM	#Staging r
where r.ReferralDonorGender = ReferralDonorGender
and r.OrganizationName = OrganizationName
and Minutes between @StartRange16 and @EndRange16
------------------

-------Range 17

INSERT INTO

	#Results
		(
			
			StartRange17,
			EndRange17,
			ReferralDonorGender,
			OrganizationName
		)
					
		Select Distinct
			
		@StartRange17,
		@EndRange17,
		ReferralDonorGender,
		r.OrganizationName

FROM	#Staging r
where r.ReferralDonorGender = ReferralDonorGender
and r.OrganizationName = OrganizationName
and Minutes between @StartRange17 and @EndRange17
------------------

-------Range 18

INSERT INTO

	#Results
		(
			
			StartRange18,
			EndRange18,
			ReferralDonorGender,
			OrganizationName
		)
					
		Select Distinct
			
		@StartRange18,
		@EndRange18,
		ReferralDonorGender,
		r.OrganizationName

FROM	#Staging r
where r.ReferralDonorGender = ReferralDonorGender
and r.OrganizationName = OrganizationName
and Minutes between @StartRange18 and @EndRange18
------------------

-------Range 19

INSERT INTO

	#Results
		(
			
			StartRange19,
			EndRange19,
			ReferralDonorGender,
			OrganizationName
		)
					
		Select Distinct
			
		@StartRange19,
		@EndRange19,
		ReferralDonorGender,
		r.OrganizationName

FROM	#Staging r
where r.ReferralDonorGender = ReferralDonorGender
and r.OrganizationName = OrganizationName
and Minutes between @StartRange19 and @EndRange19
------------------

-------Range 20

INSERT INTO

	#Results
		(
			
			StartRange20,
			EndRange20,
			ReferralDonorGender,
			OrganizationName
		)
					
		Select Distinct
			
		@StartRange20,
		@EndRange20,
		ReferralDonorGender,
		r.OrganizationName

FROM	#Staging r
where r.ReferralDonorGender = ReferralDonorGender
and r.OrganizationName = OrganizationName
and Minutes between @StartRange20 and @EndRange20

----Begin populating the table with the  major categories of the report's purpose.
	
--------------------------------------------------------------------------------

------------Insert Rows for Total Referrals-----------------------

UPDATE
	#Results
		SET
			TotalReferrals = x.cnt
		FROM
			(
			
				SELECT
				
					COUNT(distinct callid) AS Cnt,
					OrganizationName
					
					
				FROM
					#Staging r
					
				where (Minutes between @StartRange1 and @EndRange1)
				
				
				
				
							Group by Organizationname
				) AS x
				
				Where   #Results.OrganizationName = x.OrganizationName
				
				
-------------------------------------------------------------------------------


----Calculate the number of Referrals Without Initial CTOD-------TotalReferrals	

UPDATE
	#Results
		SET
			TotalNoCTOD = x.cnt
		FROM
			(
				SELECT
				
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
				
					
				FROM
					#Staging r
				WHERE(Minutes between @StartRange1 and @EndRange1)
			
					  and  (ReferraldonorDeathdatetime IS NULL 
					 OR ReferraldonorDeathdatetime >calldatetime)
					 
				Group by Organizationname
				) AS x
				
				Where  #Results.OrganizationName = x.OrganizationName
						
--------------------------------------------------------------------------------

----Calculate the number of Referrals With Initial CTOD	

UPDATE
	#Results
		SET
			TotalCTOD = x.cnt
		FROM
			(
				SELECT
					
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
				FROM
					#Staging r
				WHERE(Minutes between @StartRange1 and @EndRange1)
							
				and	 ReferraldonorDeathdatetime <= calldatetime
					 
				Group by OrganizationName
				) AS x
				
				Where  #Results.OrganizationName = x.OrganizationName
				
--------------------------------------------------------------------------------

----Calculate the number of Referrals where the Donor was a Registered Donor

UPDATE
	#Results
		SET
			TotalRegistered = x.cnt
		FROM
			(
				SELECT
					
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
									
				FROM
					#Staging r
				WHERE (Minutes between @StartRange1 and @EndRange1)
								
					and r.registrytypeid IN (1,2,4)
					and ReferraldonorDeathdatetime <= calldatetime
					
				Group by Organizationname
				) AS x
				
				Where #Results.OrganizationName = x.OrganizationName

--------------------------------------------------------------------------------

----Calculate the number of Tissue Referrals 

UPDATE
	#Results
		SET
			TotalTissue = x.cnt
		FROM
			(
				SELECT
					
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
								
				FROM
					#Staging r
				WHERE (Minutes between @StartRange1 and @EndRange1)
							
				and	R.ReferraldonorDeathdatetime <= calldatetime
					
				AND
					r.currentReferralTypeID = 2
				AND	
					(
						Organ <> 'Yes'
						or Organ is null
					
					)
				AND	
					(
						EyesTrans <> 'Yes'
						or EyesTrans is null
					
					)
				AND
					(
						Bone	= 'Yes'
					OR	Tissue	= 'Yes'
					OR	Skin	= 'Yes'
					OR	Valves	= 'Yes'
					)
				Group by Organizationname
			) AS x
		WHERE #Results.OrganizationName = x.OrganizationName
			
--------------------------------------------------------------------------------

----Calculate the number of Tissue/Eye Referrals

UPDATE
	#Results
		SET
			Total_TE = x.cnt
		FROM
			(
				SELECT
				
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
								 
				FROM
					#Staging r
				WHERE (Minutes between @StartRange1 and @EndRange1)
				
				and	ReferraldonorDeathdatetime <= calldatetime
					
				AND
					R.currentreferraltypeid = 2
				AND	
					(
						Organ <> 'Yes'
					
					)
				AND	EyesTrans = 'Yes'
				AND
					(
						Bone	= 'Yes'
					OR	Tissue	= 'Yes'
					OR	Skin	= 'Yes'
					OR	Valves	= 'Yes'
					)
				GROUP BY
					Organizationname
			) AS x
		WHERE #Results.OrganizationName = x.OrganizationName
			
------------------------------------------------------------------------------

----Calculate the number of Eye Referrals

UPDATE
	#Results
		SET
			TotalEyesOnly = x.cnt
		FROM
			(
				SELECT
				
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
										
				FROM
					#Staging r
				WHERE (Minutes between @StartRange1 and @EndRange1)
							
				and	r.currentreferraltypeid = 3
				
				AND	
				    ReferraldonorDeathdatetime <= calldatetime	
				    
				AND
					(
						Organ <> 'Yes'
						or Organ is null
					
					)
				AND		EyesTrans = 'Yes'
						or EyesTrans is null
				AND	
					(
						Bone <> 'Yes'
						or Bone is null
					)
				AND	
					(
						Tissue	<> 'Yes'
						or Tissue is null
					)
				AND	
					(
						Skin <> 'Yes'
						or Skin is null
					)
				AND	
					(
						Valves	<> 'Yes'
						or Valves is null
					)
				AND
					(
						EyesRsch	<> 'Yes'
						or EyesRsch is null
					
					)
				GROUP BY
					Organizationname
			) AS x
		WHERE   #Results.OrganizationName = x.OrganizationName
				
--------------------------------------------------------------------------------

----Calculate the number of Other/Eye Referrals

UPDATE
	#Results
		SET
			TotalOtherEye = x.cnt
		FROM
			(
				SELECT
				
					
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
										
				FROM
					#Staging r
				WHERE (Minutes between @StartRange1 and @EndRange1)
								
				and	currentreferraltypeid IN (3,4)
				AND	
				    ReferraldonorDeathdatetime <= calldatetime	
				    
				AND
					(
						Organ <> 'Yes'
					OR	Organ IS NULL
					)
				AND		EyesTrans = 'Yes'
				AND	
					(
						Bone <> 'Yes'
					OR	Bone IS NULL
					)
				AND	
					(
						Tissue	<> 'Yes'
					OR	Tissue IS NULL
					)
				AND	
					(
						Skin <> 'Yes'
					OR	Skin IS NULL
					)
				AND	
					(
						Valves	<> 'Yes'
					OR	Valves IS NULL
					)
				AND		EyesRsch = 'Yes'
				GROUP BY
					Organizationname
			) AS x
		WHERE  #Results.OrganizationName = x.OrganizationName
		
--------------------------------------------------------------------------------

----Calculate the number of Other Referrals

UPDATE
	#Results
		SET
			TotalOther = x.cnt
		FROM
			(
				SELECT
				
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
									
				FROM
					#Staging r
				WHERE (Minutes between @StartRange1 and @EndRange1)
								
				and	
					currentreferraltypeid = 4
				
				AND	
				    ReferraldonorDeathdatetime <= calldatetime	
				    
				AND
					(
						Organ <> 'Yes'
					OR	Organ IS NULL
					)
				AND
					(
						EyesTrans <> 'Yes'
					OR	EyesTrans IS NULL
					)
				AND
					(
						Bone <> 'Yes'
					OR	Bone IS NULL
					)
				AND	
					(
						Tissue	<> 'Yes'
					OR	Tissue IS NULL
					)
				AND	
					(
						Skin <> 'Yes'
					OR	Skin IS NULL
					)
				AND	
					(
						Valves	<> 'Yes'
					OR	Valves IS NULL
					)
				AND		EyesRsch = 'Yes'
				GROUP BY
					Organizationname
			) AS x
		WHERE  #Results.OrganizationName = x.OrganizationName
				
--------------------------------------------------------------------------------

----Calculate the number of Age Rule Out Referrals

UPDATE
	#Results
		SET
			TotalAgeRO = x.cnt
		FROM
			(
				SELECT
				
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
									
				FROM
					#Staging r
				WHERE (Minutes between @StartRange1 and @EndRange1)
							
				and	
					currentreferraltypeid = 4
				
				AND	
				    ReferraldonorDeathdatetime <= calldatetime	
				    
				AND
					(
						EyesTrans NOT IN ('Med RO','High Risk')
					OR	EyesTrans IS NULL
					)
				AND
					(
						Bone NOT IN ('Med RO','High Risk')
					OR	Bone IS NULL
					)
				AND	
					(
						Tissue NOT IN ('Med RO','High Risk')
					OR	Tissue IS NULL
					)
				AND	
					(
						Skin NOT IN ('Med RO','High Risk')
					OR	Skin IS NULL
					)
				AND	
					(
						Valves NOT IN ('Med RO','High Risk')
					OR	Valves IS NULL
					)
				AND
					(
						EyesRsch <> 'Yes'
					OR	EyesRsch IS NULL
					)
				GROUP BY
					Organizationname
			) AS x
		WHERE  #Results.OrganizationName = x.OrganizationName
		
--------------------------------------------------------------------------------
----Calculate the number of Medical Rule Out Referrals

UPDATE
	#Results
		SET
			TotalMedRO = x.cnt
		FROM
			(
				SELECT
					
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
				
				FROM
					#Staging r
				WHERE (Minutes between @StartRange1 and @EndRange1)
			
				and
					currentreferraltypeid = 4
				
				AND	
				    ReferraldonorDeathdatetime <= calldatetime
				    
				AND
					(
						EyesTrans	IN ('Med RO','High Risk')
					OR	Bone		IN ('Med RO','High Risk')
					OR	Tissue		IN ('Med RO','High Risk')
					OR	Skin		IN ('Med RO','High Risk')
					OR	Valves		IN ('Med RO','High Risk')
					)
				AND
					(
						EyesRsch <> 'Yes'
					OR	EyesRsch IS NULL
					)
				GROUP BY
					Organizationname
			) AS x
		WHERE  #Results.OrganizationName = x.OrganizationName
		

--------------------------------------------------------------------------------
--UPDATE
--	#Results
--		SET
--			TotalReferrals = (SELECT SUM(TotalReferrals) FROM #Results),
--			TotalNoCTOD = (SELECT SUM(TotalNoCTOD) FROM #Results),
--			TotalCTOD = (SELECT SUM(TotalCTOD) FROM #Results),
--			TotalRegistered = (SELECT SUM(TotalRegistered) FROM #Results),
--			TotalTissue = (SELECT SUM(TotalTissue) FROM #Results),
--			Total_TE = (SELECT SUM(Total_TE) FROM #Results),
--			TotalEyesOnly = (SELECT SUM(TotalEyesOnly) FROM #Results),
--			TotalOtherEye = (SELECT SUM(TotalOtherEye) FROM #Results),
--			TotalOther = (SELECT SUM(TotalOther) FROM #Results),
--			TotalAgeRO = (SELECT SUM(TotalAgeRO) FROM #Results),
--			TotalMedRO = (SELECT SUM(TotalMedRO) FROM #Results),
--			TotalAvgTime = (SELECT SUM(TotalAvgTime) FROM #Results),
--			PercentOneHour = (SELECT SUM(PercentOneHour) FROM #Results)
			
--				Where 
--				 #Results.ReferralDonorGender = 'All(Female, Male, Unknown)'
--				and #Results.OrganizationName = OrganizationName
--				and #Results.StartRange1 = @StartRange1
--				and #Results.EndRange1 = @EndRange1
				
				 
				
				
				 
				 
			

------------------------------------------------------------------------------------	
--------------Begin Range 2



------------Insert Rows for Total Referrals-----------------------

UPDATE
	#Results
		SET
			TotalReferrals = x.cnt
		FROM
			(
			
				SELECT
				
					COUNT(distinct R.callid) AS Cnt,
					OrganizationName
									
				FROM
					#Staging r
					
				where (Minutes between @StartRange2 and @EndRange2)
				
				
							Group by Organizationname
				) AS x
				
				Where  #Results.OrganizationName = x.OrganizationName
				

--------------------------------------------------------------------------------

----Calculate the number of Referrals Without Initial CTOD-------TotalReferrals	

UPDATE
	#Results
		SET
			TotalNoCTOD = x.cnt
		FROM
			(
				SELECT
				
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
						
					
				FROM
					#Staging r
				WHERE(Minutes between @StartRange2 and @EndRange2)
									 
					  and  (ReferraldonorDeathdatetime IS NULL 
					 OR ReferraldonorDeathdatetime >calldatetime)
					 
				Group by Organizationname
				) AS x
				
				Where  #Results.OrganizationName = x.OrganizationName
						
--------------------------------------------------------------------------------

----Calculate the number of Referrals With Initial CTOD	

UPDATE
	#Results
		SET
			TotalCTOD = x.cnt
		FROM
			(
				SELECT
					
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
					
				FROM
					#Staging r
				WHERE(Minutes between @StartRange2 and @EndRange2)
							
				and	 ReferraldonorDeathdatetime <= calldatetime
					 
				Group by Organizationname
				) AS x
				
				Where #Results.OrganizationName = x.OrganizationName
				
--------------------------------------------------------------------------------

----Calculate the number of Referrals where the Donor was a Registered Donor

UPDATE
	#Results
		SET
			TotalRegistered = x.cnt
		FROM
			(
				SELECT
					
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
								
				FROM
					#Staging r
				WHERE (Minutes between @StartRange2 and @EndRange2)
									
					and r.registrytypeid IN (1,2,4)
					and ReferraldonorDeathdatetime <= calldatetime
					
				Group by Organizationname
				) AS x
				
				Where  #Results.OrganizationName = x.OrganizationName

--------------------------------------------------------------------------------

----Calculate the number of Tissue Referrals 

UPDATE
	#Results
		SET
			TotalTissue = x.cnt
		FROM
			(
				SELECT
					
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
										
				FROM
					#Staging r
				WHERE (Minutes between @StartRange2 and @EndRange2)
							
				and	R.ReferraldonorDeathdatetime <= calldatetime
					
				AND
					r.currentReferralTypeID = 2
				AND	
					(
						Organ <> 'Yes'
						or Organ is null
					
					)
				AND	
					(
						EyesTrans <> 'Yes'
						or EyesTrans is null
					
					)
				AND
					(
						Bone	= 'Yes'
					OR	Tissue	= 'Yes'
					OR	Skin	= 'Yes'
					OR	Valves	= 'Yes'
					)
				Group by Organizationname
			) AS x
		WHERE  #Results.OrganizationName = x.OrganizationName
			
--------------------------------------------------------------------------------

----Calculate the number of Tissue/Eye Referrals

UPDATE
	#Results
		SET
			Total_TE = x.cnt
		FROM
			(
				SELECT
				
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
										
				FROM
					#Staging r
				WHERE (Minutes between @StartRange2 and @EndRange2)
					
				and	ReferraldonorDeathdatetime <= calldatetime
					
				AND
					R.currentreferraltypeid = 2
				AND	
					(
						Organ <> 'Yes'
					
					)
				AND	EyesTrans = 'Yes'
				AND
					(
						Bone	= 'Yes'
					OR	Tissue	= 'Yes'
					OR	Skin	= 'Yes'
					OR	Valves	= 'Yes'
					)
				GROUP BY
					Organizationname
			) AS x
		WHERE  #Results.OrganizationName = x.OrganizationName
			
------------------------------------------------------------------------------

----Calculate the number of Eye Referrals

UPDATE
	#Results
		SET
			TotalEyesOnly = x.cnt
		FROM
			(
				SELECT
				
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
			
					
				FROM
					#Staging r
				WHERE (Minutes between @StartRange2 and @EndRange2)
			
				
				and	r.currentreferraltypeid = 3
				
				AND	
				    ReferraldonorDeathdatetime <= calldatetime	
				    
				AND
					(
						Organ <> 'Yes'
						or Organ is null
					
					)
				AND		EyesTrans = 'Yes'
						or EyesTrans is null
				AND	
					(
						Bone <> 'Yes'
						or Bone is null
					)
				AND	
					(
						Tissue	<> 'Yes'
						or Tissue is null
					)
				AND	
					(
						Skin <> 'Yes'
						or Skin is null
					)
				AND	
					(
						Valves	<> 'Yes'
						or Valves is null
					)
				AND
					(
						EyesRsch	<> 'Yes'
						or EyesRsch is null
					
					)
				GROUP BY
					Organizationname
			) AS x
		WHERE  #Results.OrganizationName = x.OrganizationName
				
--------------------------------------------------------------------------------

----Calculate the number of Other/Eye Referrals

UPDATE
	#Results
		SET
			TotalOtherEye = x.cnt
		FROM
			(
				SELECT
				
					
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
								
				FROM
					#Staging r
				WHERE (Minutes between @StartRange2 and @EndRange2)
				
				
				and	currentreferraltypeid IN (3,4)
				AND	
				    ReferraldonorDeathdatetime <= calldatetime	
				    
				AND
					(
						Organ <> 'Yes'
					OR	Organ IS NULL
					)
				AND		EyesTrans = 'Yes'
				AND	
					(
						Bone <> 'Yes'
					OR	Bone IS NULL
					)
				AND	
					(
						Tissue	<> 'Yes'
					OR	Tissue IS NULL
					)
				AND	
					(
						Skin <> 'Yes'
					OR	Skin IS NULL
					)
				AND	
					(
						Valves	<> 'Yes'
					OR	Valves IS NULL
					)
				AND		EyesRsch = 'Yes'
				GROUP BY
					Organizationname
			) AS x
		WHERE   #Results.OrganizationName = x.OrganizationName
		
--------------------------------------------------------------------------------

----Calculate the number of Other Referrals

UPDATE
	#Results
		SET
			TotalOther = x.cnt
		FROM
			(
				SELECT
				
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
				
					
				FROM
					#Staging r
				WHERE (Minutes between @StartRange2 and @EndRange2)
							
				and	
					currentreferraltypeid = 4
				
				AND	
				    ReferraldonorDeathdatetime <= calldatetime	
				    
				AND
					(
						Organ <> 'Yes'
					OR	Organ IS NULL
					)
				AND
					(
						EyesTrans <> 'Yes'
					OR	EyesTrans IS NULL
					)
				AND
					(
						Bone <> 'Yes'
					OR	Bone IS NULL
					)
				AND	
					(
						Tissue	<> 'Yes'
					OR	Tissue IS NULL
					)
				AND	
					(
						Skin <> 'Yes'
					OR	Skin IS NULL
					)
				AND	
					(
						Valves	<> 'Yes'
					OR	Valves IS NULL
					)
				AND		EyesRsch = 'Yes'
				GROUP BY
					Organizationname
			) AS x
		WHERE  #Results.OrganizationName = x.OrganizationName
				
--------------------------------------------------------------------------------

----Calculate the number of Age Rule Out Referrals

UPDATE
	#Results
		SET
			TotalAgeRO = x.cnt
		FROM
			(
				SELECT
				
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
				FROM
					#Staging r
				WHERE (Minutes between @StartRange2 and @EndRange2)
				
				and	
					currentreferraltypeid = 4
				
				AND	
				    ReferraldonorDeathdatetime <= calldatetime	
				    
				AND
					(
						EyesTrans NOT IN ('Med RO','High Risk')
					OR	EyesTrans IS NULL
					)
				AND
					(
						Bone NOT IN ('Med RO','High Risk')
					OR	Bone IS NULL
					)
				AND	
					(
						Tissue NOT IN ('Med RO','High Risk')
					OR	Tissue IS NULL
					)
				AND	
					(
						Skin NOT IN ('Med RO','High Risk')
					OR	Skin IS NULL
					)
				AND	
					(
						Valves NOT IN ('Med RO','High Risk')
					OR	Valves IS NULL
					)
				AND
					(
						EyesRsch <> 'Yes'
					OR	EyesRsch IS NULL
					)
				GROUP BY
					Organizationname
			) AS x
		WHERE  #Results.OrganizationName = x.OrganizationName
		
--------------------------------------------------------------------------------

----Calculate the number of Medical Rule Out Referrals

UPDATE
	#Results
		SET
			TotalMedRO = x.cnt
		FROM
			(
				SELECT
					
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
									
				FROM
					#Staging r
				WHERE (Minutes between @StartRange2 and @EndRange2)
					
				and
					currentreferraltypeid = 4
				
				AND	
				    ReferraldonorDeathdatetime <= calldatetime
				    
				AND
					(
						EyesTrans	IN ('Med RO','High Risk')
					OR	Bone		IN ('Med RO','High Risk')
					OR	Tissue		IN ('Med RO','High Risk')
					OR	Skin		IN ('Med RO','High Risk')
					OR	Valves		IN ('Med RO','High Risk')
					)
				AND
					(
						EyesRsch <> 'Yes'
					OR	EyesRsch IS NULL
					)
				GROUP BY
					Organizationname--,ReferralDonorGender
			) AS x
		WHERE   #Results.OrganizationName = x.OrganizationName

				
------------------------------------------------------------------------------------	
--------------Begin Range 3---------------

		
		
----Begin populating the table with the  major categories of the report's purpose.
	
--------------------------------------------------------------------------------

------------Insert Rows for Total Referrals-----------------------

UPDATE
	#Results
		SET
			TotalReferrals = x.cnt
		FROM
			(
			
				SELECT
				
					COUNT(distinct R.callid) AS Cnt,
					OrganizationName
				
					
				FROM
					#Staging r
					
				where (Minutes between @StartRange3 and @EndRange3)
			
				
							Group by Organizationname
				) AS x
				
				Where #Results.OrganizationName = x.OrganizationName
-------------------------------------------------------------------------------

----Calculate the number of Referrals Without Initial CTOD-------TotalReferrals	

UPDATE
	#Results
		SET
			TotalNoCTOD = x.cnt
		FROM
			(
				SELECT
				
					
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
				FROM
					#Staging r
				WHERE(Minutes between @StartRange3 and @EndRange3)
			
					 
					  and  (ReferraldonorDeathdatetime IS NULL 
					 OR ReferraldonorDeathdatetime >calldatetime)
					 
				Group by Organizationname
				) AS x
				
				Where #Results.OrganizationName = x.OrganizationName
--------------------------------------------------------------------------------

----Calculate the number of Referrals With Initial CTOD	

UPDATE
	#Results
		SET
			TotalCTOD = x.cnt
		FROM
			(
				SELECT
					
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
				FROM
					#Staging r
				WHERE(Minutes between @StartRange3 and @EndRange3)
				
				and	 ReferraldonorDeathdatetime <= calldatetime
					 
				Group by Organizationname
				) AS x
				
				Where #Results.OrganizationName = x.OrganizationName
				
--------------------------------------------------------------------------------

----Calculate the number of Referrals where the Donor was a Registered Donor

UPDATE
	#Results
		SET
			TotalRegistered = x.cnt
		FROM
			(
				SELECT
				
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
				FROM
					#Staging r
				WHERE (Minutes between @StartRange3 and @EndRange3)
									
					and r.registrytypeid IN (1,2,4)
					and ReferraldonorDeathdatetime <= calldatetime
					
				Group by Organizationname
				) AS x
				
				Where  #Results.OrganizationName = x.OrganizationName

--------------------------------------------------------------------------------
----Calculate the number of Tissue Referrals 

UPDATE
	#Results
		SET
			TotalTissue = x.cnt
		FROM
			(
				SELECT
					
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
				FROM
					#Staging r
				WHERE (Minutes between @StartRange3 and @EndRange3)
				
				and	R.ReferraldonorDeathdatetime <= calldatetime
					
				AND
					r.currentReferralTypeID = 2
				AND	
					(
						Organ <> 'Yes'
						or Organ is null
					
					)
				AND	
					(
						EyesTrans <> 'Yes'
						or EyesTrans is null
					
					)
				AND
					(
						Bone	= 'Yes'
					OR	Tissue	= 'Yes'
					OR	Skin	= 'Yes'
					OR	Valves	= 'Yes'
					)
				Group by Organizationname
			) AS x
		WHERE #Results.OrganizationName = x.OrganizationName
			
--------------------------------------------------------------------------------

----Calculate the number of Tissue/Eye Referrals

UPDATE
	#Results
		SET
			Total_TE = x.cnt
		FROM
			(
				SELECT
				
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
					
				FROM
					#Staging r
				WHERE (Minutes between @StartRange3 and @EndRange3)
								
				and	ReferraldonorDeathdatetime <= calldatetime
					
				AND
					R.currentreferraltypeid = 2
				AND	
					(
						Organ <> 'Yes'
					
					)
				AND	EyesTrans = 'Yes'
				AND
					(
						Bone	= 'Yes'
					OR	Tissue	= 'Yes'
					OR	Skin	= 'Yes'
					OR	Valves	= 'Yes'
					)
				GROUP BY
					Organizationname
			) AS x
		WHERE  #Results.OrganizationName = x.OrganizationName
			
------------------------------------------------------------------------------

----Calculate the number of Eye Referrals

UPDATE
	#Results
		SET
			TotalEyesOnly = x.cnt
		FROM
			(
				SELECT
				
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
				FROM
					#Staging r
				WHERE (Minutes between @StartRange3 and @EndRange3)
				
				and	r.currentreferraltypeid = 3
				
				AND	
				    ReferraldonorDeathdatetime <= calldatetime	
				    
				AND
					(
						Organ <> 'Yes'
						or Organ is null
					
					)
				AND		EyesTrans = 'Yes'
						or EyesTrans is null
				AND	
					(
						Bone <> 'Yes'
						or Bone is null
					)
				AND	
					(
						Tissue	<> 'Yes'
						or Tissue is null
					)
				AND	
					(
						Skin <> 'Yes'
						or Skin is null
					)
				AND	
					(
						Valves	<> 'Yes'
						or Valves is null
					)
				AND
					(
						EyesRsch	<> 'Yes'
						or EyesRsch is null
					
					)
				GROUP BY
					Organizationname
			) AS x
		WHERE  #Results.OrganizationName = x.OrganizationName
				

--------------------------------------------------------------------------------

----Calculate the number of Other/Eye Referrals

UPDATE
	#Results
		SET
			TotalOtherEye = x.cnt
		FROM
			(
				SELECT
				
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
										
				FROM
					#Staging r
				WHERE (Minutes between @StartRange3 and @EndRange3)
				
				and	currentreferraltypeid IN (3,4)
				AND	
				    ReferraldonorDeathdatetime <= calldatetime	
				    
				AND
					(
						Organ <> 'Yes'
					OR	Organ IS NULL
					)
				AND		EyesTrans = 'Yes'
				AND	
					(
						Bone <> 'Yes'
					OR	Bone IS NULL
					)
				AND	
					(
						Tissue	<> 'Yes'
					OR	Tissue IS NULL
					)
				AND	
					(
						Skin <> 'Yes'
					OR	Skin IS NULL
					)
				AND	
					(
						Valves	<> 'Yes'
					OR	Valves IS NULL
					)
				AND		EyesRsch = 'Yes'
				GROUP BY
					Organizationname
			) AS x
		WHERE #Results.OrganizationName = x.OrganizationName
--------------------------------------------------------------------------------

----Calculate the number of Other Referrals

UPDATE
	#Results
		SET
			TotalOther = x.cnt
		FROM
			(
				SELECT
				
					
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
				FROM
					#Staging r
				WHERE (Minutes between @StartRange3 and @EndRange3)
				
				and	
					currentreferraltypeid = 4
				
				AND	
				    ReferraldonorDeathdatetime <= calldatetime	
				    
				AND
					(
						Organ <> 'Yes'
					OR	Organ IS NULL
					)
				AND
					(
						EyesTrans <> 'Yes'
					OR	EyesTrans IS NULL
					)
				AND
					(
						Bone <> 'Yes'
					OR	Bone IS NULL
					)
				AND	
					(
						Tissue	<> 'Yes'
					OR	Tissue IS NULL
					)
				AND	
					(
						Skin <> 'Yes'
					OR	Skin IS NULL
					)
				AND	
					(
						Valves	<> 'Yes'
					OR	Valves IS NULL
					)
				AND		EyesRsch = 'Yes'
				GROUP BY
					Organizationname
			) AS x
		WHERE #Results.OrganizationName = x.OrganizationName
--------------------------------------------------------------------------------

----Calculate the number of Age Rule Out Referrals

UPDATE
	#Results
		SET
			TotalAgeRO = x.cnt
		FROM
			(
				SELECT
				
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
				FROM
					#Staging r
				WHERE (Minutes between @StartRange3 and @EndRange3)
				
				and	
					currentreferraltypeid = 4
				
				AND	
				    ReferraldonorDeathdatetime <= calldatetime	
				    
				AND
					(
						EyesTrans NOT IN ('Med RO','High Risk')
					OR	EyesTrans IS NULL
					)
				AND
					(
						Bone NOT IN ('Med RO','High Risk')
					OR	Bone IS NULL
					)
				AND	
					(
						Tissue NOT IN ('Med RO','High Risk')
					OR	Tissue IS NULL
					)
				AND	
					(
						Skin NOT IN ('Med RO','High Risk')
					OR	Skin IS NULL
					)
				AND	
					(
						Valves NOT IN ('Med RO','High Risk')
					OR	Valves IS NULL
					)
				AND
					(
						EyesRsch <> 'Yes'
					OR	EyesRsch IS NULL
					)
				GROUP BY
					Organizationname
			) AS x
		WHERE  #Results.OrganizationName = x.OrganizationName
		
--------------------------------------------------------------------------------

----Calculate the number of Medical Rule Out Referrals

UPDATE
	#Results
		SET
			TotalMedRO = x.cnt
		FROM
			(
				SELECT
				
					
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
				FROM
					#Staging r
				WHERE (Minutes between @StartRange3 and @EndRange3)
				
				and
					currentreferraltypeid = 4
				
				AND	
				    ReferraldonorDeathdatetime <= calldatetime
				    
				AND
					(
						EyesTrans	IN ('Med RO','High Risk')
					OR	Bone		IN ('Med RO','High Risk')
					OR	Tissue		IN ('Med RO','High Risk')
					OR	Skin		IN ('Med RO','High Risk')
					OR	Valves		IN ('Med RO','High Risk')
					)
				AND
					(
						EyesRsch <> 'Yes'
					OR	EyesRsch IS NULL
					)
				GROUP BY
					Organizationname
			) AS x
		WHERE  #Results.OrganizationName = x.OrganizationName
		
--------------------------------------------------------------------------------
------------  Range 4  ---------------

----Begin populating the table with the  major categories of the report's purpose.
	
--------------------------------------------------------------------------------

------------Insert Rows for Total Referrals-----------------------

UPDATE
	#Results
		SET
			TotalReferrals = x.cnt
		FROM
			(
			
				SELECT
				
					COUNT(distinct R.callid) AS Cnt,
					OrganizationName
				FROM
					#Staging r
					
				where (Minutes between @StartRange4 and @EndRange4)
				
				
							Group by Organizationname
				) AS x
				
				Where  #Results.OrganizationName = x.OrganizationName
-------------------------------------------------------------------------------

----Calculate the number of Referrals Without Initial CTOD-------TotalReferrals	

UPDATE
	#Results
		SET
			TotalNoCTOD = x.cnt
		FROM
			(
				SELECT
				
					
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
				FROM
					#Staging r
				WHERE(Minutes between @StartRange4 and @EndRange4)
								 
					  and  (ReferraldonorDeathdatetime IS NULL 
					 OR ReferraldonorDeathdatetime >calldatetime)
					 
				Group by Organizationname
				) AS x
				
				Where #Results.OrganizationName = x.OrganizationName
--------------------------------------------------------------------------------

----Calculate the number of Referrals With Initial CTOD	

UPDATE
	#Results
		SET
			TotalCTOD = x.cnt
		FROM
			(
				SELECT
					
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
				FROM
					#Staging r
				WHERE(Minutes between @StartRange4 and @EndRange4)
				
				and	 ReferraldonorDeathdatetime <= calldatetime
					 
				Group by Organizationname
				) AS x
				
				Where #Results.OrganizationName = x.OrganizationName
				
--------------------------------------------------------------------------------

----Calculate the number of Referrals where the Donor was a Registered Donor

UPDATE
	#Results
		SET
			TotalRegistered = x.cnt
		FROM
			(
				SELECT
				
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
				FROM
					#Staging r
				WHERE (Minutes between @StartRange4 and @EndRange4)
									
					and r.registrytypeid IN (1,2,4)
					and ReferraldonorDeathdatetime <= calldatetime
					
				Group by Organizationname
				) AS x
				
				Where  #Results.OrganizationName = x.OrganizationName

--------------------------------------------------------------------------------
----Calculate the number of Tissue Referrals 

UPDATE
	#Results
		SET
			TotalTissue = x.cnt
		FROM
			(
				SELECT
					
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
				FROM
					#Staging r
				WHERE (Minutes between @StartRange4 and @EndRange4)
			
				and	R.ReferraldonorDeathdatetime <= calldatetime
					
				AND
					r.currentReferralTypeID = 2
				AND	
					(
						Organ <> 'Yes'
						or Organ is null
					
					)
				AND	
					(
						EyesTrans <> 'Yes'
						or EyesTrans is null
					
					)
				AND
					(
						Bone	= 'Yes'
					OR	Tissue	= 'Yes'
					OR	Skin	= 'Yes'
					OR	Valves	= 'Yes'
					)
				Group by Organizationname
			) AS x
		WHERE	#Results.OrganizationName = x.OrganizationName
			
--------------------------------------------------------------------------------

----Calculate the number of Tissue/Eye Referrals

UPDATE
	#Results
		SET
			Total_TE = x.cnt
		FROM
			(
				SELECT
				
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
				FROM
					#Staging r
				WHERE (Minutes between @StartRange4 and @EndRange4)
				
				
				and	ReferraldonorDeathdatetime <= calldatetime
					
				AND
					R.currentreferraltypeid = 2
				AND	
					(
						Organ <> 'Yes'
					
					)
				AND	EyesTrans = 'Yes'
				AND
					(
						Bone	= 'Yes'
					OR	Tissue	= 'Yes'
					OR	Skin	= 'Yes'
					OR	Valves	= 'Yes'
					)
				GROUP BY
					Organizationname
			) AS x
		WHERE  #Results.OrganizationName = x.OrganizationName
			
------------------------------------------------------------------------------

----Calculate the number of Eye Referrals

UPDATE
	#Results
		SET
			TotalEyesOnly = x.cnt
		FROM
			(
				SELECT
				
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
				FROM
					#Staging r
				WHERE (Minutes between @StartRange4 and @EndRange4)
								
				and	r.currentreferraltypeid = 3
				
				AND	
				    ReferraldonorDeathdatetime <= calldatetime	
				    
				AND
					(
						Organ <> 'Yes'
						or Organ is null
					
					)
				AND		EyesTrans = 'Yes'
						or EyesTrans is null
				AND	
					(
						Bone <> 'Yes'
						or Bone is null
					)
				AND	
					(
						Tissue	<> 'Yes'
						or Tissue is null
					)
				AND	
					(
						Skin <> 'Yes'
						or Skin is null
					)
				AND	
					(
						Valves	<> 'Yes'
						or Valves is null
					)
				AND
					(
						EyesRsch	<> 'Yes'
						or EyesRsch is null
					
					)
				GROUP BY
					Organizationname
			) AS x
		WHERE  #Results.OrganizationName = x.OrganizationName
				

--------------------------------------------------------------------------------

----Calculate the number of Other/Eye Referrals

UPDATE
	#Results
		SET
			TotalOtherEye = x.cnt
		FROM
			(
				SELECT
				
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
					
				FROM
					#Staging r
				WHERE (Minutes between @StartRange4 and @EndRange4)
				
				and	currentreferraltypeid IN (3,4)
				AND	
				    ReferraldonorDeathdatetime <= calldatetime	
				    
				AND
					(
						Organ <> 'Yes'
					OR	Organ IS NULL
					)
				AND		EyesTrans = 'Yes'
				AND	
					(
						Bone <> 'Yes'
					OR	Bone IS NULL
					)
				AND	
					(
						Tissue	<> 'Yes'
					OR	Tissue IS NULL
					)
				AND	
					(
						Skin <> 'Yes'
					OR	Skin IS NULL
					)
				AND	
					(
						Valves	<> 'Yes'
					OR	Valves IS NULL
					)
				AND		EyesRsch = 'Yes'
				GROUP BY
					Organizationname
			) AS x
		WHERE  #Results.OrganizationName = x.OrganizationName
--------------------------------------------------------------------------------

----Calculate the number of Other Referrals

UPDATE
	#Results
		SET
			TotalOther = x.cnt
		FROM
			(
				SELECT
				
					
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
				FROM
					#Staging r
				WHERE (Minutes between @StartRange4 and @EndRange4)
								
				and	
					currentreferraltypeid = 4
				
				AND	
				    ReferraldonorDeathdatetime <= calldatetime	
				    
				AND
					(
						Organ <> 'Yes'
					OR	Organ IS NULL
					)
				AND
					(
						EyesTrans <> 'Yes'
					OR	EyesTrans IS NULL
					)
				AND
					(
						Bone <> 'Yes'
					OR	Bone IS NULL
					)
				AND	
					(
						Tissue	<> 'Yes'
					OR	Tissue IS NULL
					)
				AND	
					(
						Skin <> 'Yes'
					OR	Skin IS NULL
					)
				AND	
					(
						Valves	<> 'Yes'
					OR	Valves IS NULL
					)
				AND		EyesRsch = 'Yes'
				GROUP BY
					Organizationname
			) AS x
		WHERE  #Results.OrganizationName = x.OrganizationName
--------------------------------------------------------------------------------

----Calculate the number of Age Rule Out Referrals

UPDATE
	#Results
		SET
			TotalAgeRO = x.cnt
		FROM
			(
				SELECT
				
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
				FROM
					#Staging r
				WHERE (Minutes between @StartRange4 and @EndRange4)
			
				and	
					currentreferraltypeid = 4
				
				AND	
				    ReferraldonorDeathdatetime <= calldatetime	
				    
				AND
					(
						EyesTrans NOT IN ('Med RO','High Risk')
					OR	EyesTrans IS NULL
					)
				AND
					(
						Bone NOT IN ('Med RO','High Risk')
					OR	Bone IS NULL
					)
				AND	
					(
						Tissue NOT IN ('Med RO','High Risk')
					OR	Tissue IS NULL
					)
				AND	
					(
						Skin NOT IN ('Med RO','High Risk')
					OR	Skin IS NULL
					)
				AND	
					(
						Valves NOT IN ('Med RO','High Risk')
					OR	Valves IS NULL
					)
				AND
					(
						EyesRsch <> 'Yes'
					OR	EyesRsch IS NULL
					)
				GROUP BY
					Organizationname 
			) AS x
		WHERE  #Results.OrganizationName = x.OrganizationName
		
--------------------------------------------------------------------------------

----Calculate the number of Medical Rule Out Referrals

UPDATE
	#Results
		SET
			TotalMedRO = x.cnt
		FROM
			(
				SELECT
				
					
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
										
				FROM
					#Staging r
				WHERE (Minutes between @StartRange4 and @EndRange4)
								
				and
					currentreferraltypeid = 4
				
				AND	
				    ReferraldonorDeathdatetime <= calldatetime
				    
				AND
					(
						EyesTrans	IN ('Med RO','High Risk')
					OR	Bone		IN ('Med RO','High Risk')
					OR	Tissue		IN ('Med RO','High Risk')
					OR	Skin		IN ('Med RO','High Risk')
					OR	Valves		IN ('Med RO','High Risk')
					)
				AND
					(
						EyesRsch <> 'Yes'
					OR	EyesRsch IS NULL
					)
				GROUP BY
					Organizationname
			) AS x
		WHERE #Results.OrganizationName = x.OrganizationName
		
---------------------------------------------------------------------------------------------------------------------------------
--------------------  Range 5 ------------------
		
----Begin populating the table with the  major categories of the report's purpose.
	
--------------------------------------------------------------------------------

------------Insert Rows for Total Referrals-----------------------

UPDATE
	#Results
		SET
			TotalReferrals = x.cnt
		FROM
			(
			
				SELECT
				
					COUNT(distinct R.callid) AS Cnt,
					OrganizationName
					
				FROM
					#Staging r
					
				where (Minutes between @StartRange5 and @EndRange5)
								
							Group by Organizationname
				) AS x
				
				Where  #Results.OrganizationName = x.OrganizationName
-------------------------------------------------------------------------------

----Calculate the number of Referrals Without Initial CTOD-------TotalReferrals	

UPDATE
	#Results
		SET
			TotalNoCTOD = x.cnt
		FROM
			(
				SELECT
				
					
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
				FROM
					#Staging r
				WHERE(Minutes between @StartRange5 and @EndRange5)
									 
					  and  (ReferraldonorDeathdatetime IS NULL 
					 OR ReferraldonorDeathdatetime >calldatetime)
					 
				Group by Organizationname
				) AS x
				
				Where #Results.OrganizationName = x.OrganizationName
--------------------------------------------------------------------------------

----Calculate the number of Referrals With Initial CTOD	

UPDATE
	#Results
		SET
			TotalCTOD = x.cnt
		FROM
			(
				SELECT
					
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
				FROM
					#Staging r
				WHERE(Minutes between @StartRange5 and @EndRange5)
			
				and	 ReferraldonorDeathdatetime <= calldatetime
					 
				Group by Organizationname
				) AS x
				
				Where  #Results.OrganizationName = x.OrganizationName
				
--------------------------------------------------------------------------------

----Calculate the number of Referrals where the Donor was a Registered Donor

UPDATE
	#Results
		SET
			TotalRegistered = x.cnt
		FROM
			(
				SELECT
				
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
				FROM
					#Staging r
				WHERE (Minutes between @StartRange5 and @EndRange5)
				
					
					and r.registrytypeid IN (1,2,4)
					and ReferraldonorDeathdatetime <= calldatetime
					
				Group by Organizationname
				) AS x
				
				Where  #Results.OrganizationName = x.OrganizationName

--------------------------------------------------------------------------------
----Calculate the number of Tissue Referrals 

UPDATE
	#Results
		SET
			TotalTissue = x.cnt
		FROM
			(
				SELECT
					
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
				FROM
					#Staging r
				WHERE (Minutes between @StartRange5 and @EndRange5)
								
				and	R.ReferraldonorDeathdatetime <= calldatetime
					
				AND
					r.currentReferralTypeID = 2
				AND	
					(
						Organ <> 'Yes'
						or Organ is null
					
					)
				AND	
					(
						EyesTrans <> 'Yes'
						or EyesTrans is null
					
					)
				AND
					(
						Bone	= 'Yes'
					OR	Tissue	= 'Yes'
					OR	Skin	= 'Yes'
					OR	Valves	= 'Yes'
					)
				Group by Organizationname
			) AS x
		WHERE	#Results.OrganizationName = x.OrganizationName
			
--------------------------------------------------------------------------------

----Calculate the number of Tissue/Eye Referrals

UPDATE
	#Results
		SET
			Total_TE = x.cnt
		FROM
			(
				SELECT
				
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
				FROM
					#Staging r
				WHERE (Minutes between @StartRange5 and @EndRange5)
			
				and	ReferraldonorDeathdatetime <= calldatetime
					
				AND
					R.currentreferraltypeid = 2
				AND	
					(
						Organ <> 'Yes'
					
					)
				AND	EyesTrans = 'Yes'
				AND
					(
						Bone	= 'Yes'
					OR	Tissue	= 'Yes'
					OR	Skin	= 'Yes'
					OR	Valves	= 'Yes'
					)
				GROUP BY
					Organizationname
			) AS x
		WHERE  #Results.OrganizationName = x.OrganizationName
			
------------------------------------------------------------------------------

----Calculate the number of Eye Referrals

UPDATE
	#Results
		SET
			TotalEyesOnly = x.cnt
		FROM
			(
				SELECT
				
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
				FROM
					#Staging r
				WHERE (Minutes between @StartRange5 and @EndRange5)
				
				
				and	r.currentreferraltypeid = 3
				
				AND	
				    ReferraldonorDeathdatetime <= calldatetime	
				    
				AND
					(
						Organ <> 'Yes'
						or Organ is null
					
					)
				AND		EyesTrans = 'Yes'
						or EyesTrans is null
				AND	
					(
						Bone <> 'Yes'
						or Bone is null
					)
				AND	
					(
						Tissue	<> 'Yes'
						or Tissue is null
					)
				AND	
					(
						Skin <> 'Yes'
						or Skin is null
					)
				AND	
					(
						Valves	<> 'Yes'
						or Valves is null
					)
				AND
					(
						EyesRsch	<> 'Yes'
						or EyesRsch is null
					
					)
				GROUP BY
					Organizationname
			) AS x
		WHERE #Results.OrganizationName = x.OrganizationName
				

--------------------------------------------------------------------------------

----Calculate the number of Other/Eye Referrals

UPDATE
	#Results
		SET
			TotalOtherEye = x.cnt
		FROM
			(
				SELECT
				
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
				FROM
					#Staging r
				WHERE (Minutes between @StartRange5 and @EndRange5)
							
				and	currentreferraltypeid IN (3,4)
				AND	
				    ReferraldonorDeathdatetime <= calldatetime	
				    
				AND
					(
						Organ <> 'Yes'
					OR	Organ IS NULL
					)
				AND		EyesTrans = 'Yes'
				AND	
					(
						Bone <> 'Yes'
					OR	Bone IS NULL
					)
				AND	
					(
						Tissue	<> 'Yes'
					OR	Tissue IS NULL
					)
				AND	
					(
						Skin <> 'Yes'
					OR	Skin IS NULL
					)
				AND	
					(
						Valves	<> 'Yes'
					OR	Valves IS NULL
					)
				AND		EyesRsch = 'Yes'
				GROUP BY
					Organizationname
			) AS x
		WHERE   #Results.OrganizationName = x.OrganizationName
--------------------------------------------------------------------------------

----Calculate the number of Other Referrals

UPDATE
	#Results
		SET
			TotalOther = x.cnt
		FROM
			(
				SELECT
				
					
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
				FROM
					#Staging r
				WHERE (Minutes between @StartRange5 and @EndRange5)
				
				
				and	
					currentreferraltypeid = 4
				
				AND	
				    ReferraldonorDeathdatetime <= calldatetime	
				    
				AND
					(
						Organ <> 'Yes'
					OR	Organ IS NULL
					)
				AND
					(
						EyesTrans <> 'Yes'
					OR	EyesTrans IS NULL
					)
				AND
					(
						Bone <> 'Yes'
					OR	Bone IS NULL
					)
				AND	
					(
						Tissue	<> 'Yes'
					OR	Tissue IS NULL
					)
				AND	
					(
						Skin <> 'Yes'
					OR	Skin IS NULL
					)
				AND	
					(
						Valves	<> 'Yes'
					OR	Valves IS NULL
					)
				AND		EyesRsch = 'Yes'
				GROUP BY
					Organizationname
			) AS x
		WHERE #Results.OrganizationName = x.OrganizationName
--------------------------------------------------------------------------------

----Calculate the number of Age Rule Out Referrals

UPDATE
	#Results
		SET
			TotalAgeRO = x.cnt
		FROM
			(
				SELECT
				
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
				FROM
					#Staging r
				WHERE (Minutes between @StartRange5 and @EndRange5)
								
				and	
					currentreferraltypeid = 4
				
				AND	
				    ReferraldonorDeathdatetime <= calldatetime	
				    
				AND
					(
						EyesTrans NOT IN ('Med RO','High Risk')
					OR	EyesTrans IS NULL
					)
				AND
					(
						Bone NOT IN ('Med RO','High Risk')
					OR	Bone IS NULL
					)
				AND	
					(
						Tissue NOT IN ('Med RO','High Risk')
					OR	Tissue IS NULL
					)
				AND	
					(
						Skin NOT IN ('Med RO','High Risk')
					OR	Skin IS NULL
					)
				AND	
					(
						Valves NOT IN ('Med RO','High Risk')
					OR	Valves IS NULL
					)
				AND
					(
						EyesRsch <> 'Yes'
					OR	EyesRsch IS NULL
					)
				GROUP BY
					Organizationname
			) AS x
		WHERE   #Results.OrganizationName = x.OrganizationName
		
--------------------------------------------------------------------------------

----Calculate the number of Medical Rule Out Referrals

UPDATE
	#Results
		SET
			TotalMedRO = x.cnt
		FROM
			(
				SELECT
				
					
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
					
				FROM
					#Staging r
				WHERE (Minutes between @StartRange5 and @EndRange5)
								
				and
					currentreferraltypeid = 4
				
				AND	
				    ReferraldonorDeathdatetime <= calldatetime
				    
				AND
					(
						EyesTrans	IN ('Med RO','High Risk')
					OR	Bone		IN ('Med RO','High Risk')
					OR	Tissue		IN ('Med RO','High Risk')
					OR	Skin		IN ('Med RO','High Risk')
					OR	Valves		IN ('Med RO','High Risk')
					)
				AND
					(
						EyesRsch <> 'Yes'
					OR	EyesRsch IS NULL
					)
				GROUP BY
					Organizationname
			) AS x
		WHERE  #Results.OrganizationName = x.OrganizationName
		

-------------------------------------------------------------------------------------------------------------------------
------------------  Range 6 -------------------

		
----Begin populating the table with the  major categories of the report's purpose.
	
--------------------------------------------------------------------------------

------------Insert Rows for Total Referrals-----------------------

UPDATE
	#Results
		SET
			TotalReferrals = x.cnt
		FROM
			(
			
				SELECT
				
					COUNT(distinct R.callid) AS Cnt,
					OrganizationName
					
				FROM
					#Staging r
					
				where (Minutes between @StartRange6 and @EndRange6)
				
				
							Group by Organizationname,ReferralDonorGender
				) AS x
				
				Where  #Results.OrganizationName = x.OrganizationName
-------------------------------------------------------------------------------

----Calculate the number of Referrals Without Initial CTOD-------TotalReferrals	

UPDATE
	#Results
		SET
			TotalNoCTOD = x.cnt
		FROM
			(
				SELECT
				
					
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
				FROM
					#Staging r
				WHERE(Minutes between @StartRange6 and @EndRange6)
				
					  and  (ReferraldonorDeathdatetime IS NULL 
					 OR ReferraldonorDeathdatetime >calldatetime)
					 
				Group by Organizationname
				) AS x
				
				Where #Results.OrganizationName = x.OrganizationName
--------------------------------------------------------------------------------

----Calculate the number of Referrals With Initial CTOD	

UPDATE
	#Results
		SET
			TotalCTOD = x.cnt
		FROM
			(
				SELECT
					
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
				FROM
					#Staging r
				WHERE(Minutes between @StartRange6 and @EndRange6)
								
				and	 ReferraldonorDeathdatetime <= calldatetime
					 
				Group by Organizationname
				) AS x
				
				Where  #Results.OrganizationName = x.OrganizationName
				
--------------------------------------------------------------------------------

----Calculate the number of Referrals where the Donor was a Registered Donor

UPDATE
	#Results
		SET
			TotalRegistered = x.cnt
		FROM
			(
				SELECT
				
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
				FROM
					#Staging r
				WHERE (Minutes between @StartRange6 and @EndRange6)
									
					and r.registrytypeid IN (1,2,4)
					and ReferraldonorDeathdatetime <= calldatetime
					
				Group by Organizationname
				) AS x
				
				Where  #Results.OrganizationName = x.OrganizationName

--------------------------------------------------------------------------------
----Calculate the number of Tissue Referrals 

UPDATE
	#Results
		SET
			TotalTissue = x.cnt
		FROM
			(
				SELECT
					
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
				FROM
					#Staging r
				WHERE (Minutes between @StartRange6 and @EndRange6)
				
				and	R.ReferraldonorDeathdatetime <= calldatetime
					
				AND
					r.currentReferralTypeID = 2
				AND	
					(
						Organ <> 'Yes'
						or Organ is null
					
					)
				AND	
					(
						EyesTrans <> 'Yes'
						or EyesTrans is null
					
					)
				AND
					(
						Bone	= 'Yes'
					OR	Tissue	= 'Yes'
					OR	Skin	= 'Yes'
					OR	Valves	= 'Yes'
					)
				Group by Organizationname
			) AS x
		WHERE #Results.OrganizationName = x.OrganizationName
			
--------------------------------------------------------------------------------

----Calculate the number of Tissue/Eye Referrals

UPDATE
	#Results
		SET
			Total_TE = x.cnt
		FROM
			(
				SELECT
				
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
				FROM
					#Staging r
				WHERE (Minutes between @StartRange6 and @EndRange6)
							
				and	ReferraldonorDeathdatetime <= calldatetime
					
				AND
					R.currentreferraltypeid = 2
				AND	
					(
						Organ <> 'Yes'
					
					)
				AND	EyesTrans = 'Yes'
				AND
					(
						Bone	= 'Yes'
					OR	Tissue	= 'Yes'
					OR	Skin	= 'Yes'
					OR	Valves	= 'Yes'
					)
				GROUP BY
					Organizationname
			) AS x
		WHERE  #Results.OrganizationName = x.OrganizationName
			
------------------------------------------------------------------------------

----Calculate the number of Eye Referrals

UPDATE
	#Results
		SET
			TotalEyesOnly = x.cnt
		FROM
			(
				SELECT
				
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
				FROM
					#Staging r
				WHERE (Minutes between @StartRange6 and @EndRange6)
								
				and	r.currentreferraltypeid = 3
				
				AND	
				    ReferraldonorDeathdatetime <= calldatetime	
				    
				AND
					(
						Organ <> 'Yes'
						or Organ is null
					
					)
				AND		EyesTrans = 'Yes'
						or EyesTrans is null
				AND	
					(
						Bone <> 'Yes'
						or Bone is null
					)
				AND	
					(
						Tissue	<> 'Yes'
						or Tissue is null
					)
				AND	
					(
						Skin <> 'Yes'
						or Skin is null
					)
				AND	
					(
						Valves	<> 'Yes'
						or Valves is null
					)
				AND
					(
						EyesRsch	<> 'Yes'
						or EyesRsch is null
					
					)
				GROUP BY
					Organizationname
			) AS x
		WHERE  #Results.OrganizationName = x.OrganizationName
				

--------------------------------------------------------------------------------

----Calculate the number of Other/Eye Referrals

UPDATE
	#Results
		SET
			TotalOtherEye = x.cnt
		FROM
			(
				SELECT
				
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
				FROM
					#Staging r
				WHERE (Minutes between @StartRange6 and @EndRange6)
								
				and	currentreferraltypeid IN (3,4)
				AND	
				    ReferraldonorDeathdatetime <= calldatetime	
				    
				AND
					(
						Organ <> 'Yes'
					OR	Organ IS NULL
					)
				AND		EyesTrans = 'Yes'
				AND	
					(
						Bone <> 'Yes'
					OR	Bone IS NULL
					)
				AND	
					(
						Tissue	<> 'Yes'
					OR	Tissue IS NULL
					)
				AND	
					(
						Skin <> 'Yes'
					OR	Skin IS NULL
					)
				AND	
					(
						Valves	<> 'Yes'
					OR	Valves IS NULL
					)
				AND		EyesRsch = 'Yes'
				GROUP BY
					Organizationname
			) AS x
		WHERE  #Results.OrganizationName = x.OrganizationName
--------------------------------------------------------------------------------

----Calculate the number of Other Referrals

UPDATE
	#Results
		SET
			TotalOther = x.cnt
		FROM
			(
				SELECT
				
					
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
				FROM
					#Staging r
				WHERE (Minutes between @StartRange6 and @EndRange6)
			
				and	
					currentreferraltypeid = 4
				
				AND	
				    ReferraldonorDeathdatetime <= calldatetime	
				    
				AND
					(
						Organ <> 'Yes'
					OR	Organ IS NULL
					)
				AND
					(
						EyesTrans <> 'Yes'
					OR	EyesTrans IS NULL
					)
				AND
					(
						Bone <> 'Yes'
					OR	Bone IS NULL
					)
				AND	
					(
						Tissue	<> 'Yes'
					OR	Tissue IS NULL
					)
				AND	
					(
						Skin <> 'Yes'
					OR	Skin IS NULL
					)
				AND	
					(
						Valves	<> 'Yes'
					OR	Valves IS NULL
					)
				AND		EyesRsch = 'Yes'
				GROUP BY
					Organizationname
			) AS x
		WHERE #Results.OrganizationName = x.OrganizationName
--------------------------------------------------------------------------------

----Calculate the number of Age Rule Out Referrals

UPDATE
	#Results
		SET
			TotalAgeRO = x.cnt
		FROM
			(
				SELECT
				
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
				FROM
					#Staging r
				WHERE (Minutes between @StartRange6 and @EndRange6)
								
				and	
					currentreferraltypeid = 4
				
				AND	
				    ReferraldonorDeathdatetime <= calldatetime	
				    
				AND
					(
						EyesTrans NOT IN ('Med RO','High Risk')
					OR	EyesTrans IS NULL
					)
				AND
					(
						Bone NOT IN ('Med RO','High Risk')
					OR	Bone IS NULL
					)
				AND	
					(
						Tissue NOT IN ('Med RO','High Risk')
					OR	Tissue IS NULL
					)
				AND	
					(
						Skin NOT IN ('Med RO','High Risk')
					OR	Skin IS NULL
					)
				AND	
					(
						Valves NOT IN ('Med RO','High Risk')
					OR	Valves IS NULL
					)
				AND
					(
						EyesRsch <> 'Yes'
					OR	EyesRsch IS NULL
					)
				GROUP BY
					Organizationname
			) AS x
		WHERE #Results.OrganizationName = x.OrganizationName
		
--------------------------------------------------------------------------------

----Calculate the number of Medical Rule Out Referrals

UPDATE
	#Results
		SET
			TotalMedRO = x.cnt
		FROM
			(
				SELECT
				
					
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
				FROM
					#Staging r
				WHERE (Minutes between @StartRange6 and @EndRange6)
							
				and
					currentreferraltypeid = 4
				
				AND	
				    ReferraldonorDeathdatetime <= calldatetime
				    
				AND
					(
						EyesTrans	IN ('Med RO','High Risk')
					OR	Bone		IN ('Med RO','High Risk')
					OR	Tissue		IN ('Med RO','High Risk')
					OR	Skin		IN ('Med RO','High Risk')
					OR	Valves		IN ('Med RO','High Risk')
					)
				AND
					(
						EyesRsch <> 'Yes'
					OR	EyesRsch IS NULL
					)
				GROUP BY
					Organizationname
			) AS x
		WHERE  #Results.OrganizationName = x.OrganizationName
		
--------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------------------------
------------------- Range 7 ------------

		
----Begin populating the table with the  major categories of the report's purpose.
	
--------------------------------------------------------------------------------

------------Insert Rows for Total Referrals-----------------------

UPDATE
	#Results
		SET
			TotalReferrals = x.cnt
		FROM
			(
			
				SELECT
				
					COUNT(distinct R.callid) AS Cnt,
					OrganizationName
					
					
				FROM
					#Staging r
					
				where (Minutes between @StartRange7 and @EndRange7)
			
				
							Group by Organizationname
				) AS x
				
				Where  #Results.OrganizationName = x.OrganizationName
-------------------------------------------------------------------------------

----Calculate the number of Referrals Without Initial CTOD-------TotalReferrals	

UPDATE
	#Results
		SET
			TotalNoCTOD = x.cnt
		FROM
			(
				SELECT
				
					
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
										
				FROM
					#Staging r
				WHERE(Minutes between @StartRange7 and @EndRange7)
				
					  and  (ReferraldonorDeathdatetime IS NULL 
					 OR ReferraldonorDeathdatetime >calldatetime)
					 
				Group by Organizationname
				) AS x
				
				Where #Results.OrganizationName = x.OrganizationName
--------------------------------------------------------------------------------

----Calculate the number of Referrals With Initial CTOD	

UPDATE
	#Results
		SET
			TotalCTOD = x.cnt
		FROM
			(
				SELECT
					
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
					
				FROM
					#Staging r
				WHERE(Minutes between @StartRange7 and @EndRange7)
							
				and	 ReferraldonorDeathdatetime <= calldatetime
					 
				Group by Organizationname
				) AS x
				
				Where #Results.OrganizationName = x.OrganizationName
				
--------------------------------------------------------------------------------

----Calculate the number of Referrals where the Donor was a Registered Donor

UPDATE
	#Results
		SET
			TotalRegistered = x.cnt
		FROM
			(
				SELECT
				
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
				FROM
					#Staging r
				WHERE (Minutes between @StartRange7 and @EndRange7)
			
					and r.registrytypeid IN (1,2,4)
					and ReferraldonorDeathdatetime <= calldatetime
					
				Group by Organizationname
				) AS x
				
				Where  #Results.OrganizationName = x.OrganizationName

--------------------------------------------------------------------------------
----Calculate the number of Tissue Referrals 

UPDATE
	#Results
		SET
			TotalTissue = x.cnt
		FROM
			(
				SELECT
					
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
				FROM
					#Staging r
				WHERE (Minutes between @StartRange7 and @EndRange7)
							
				and	R.ReferraldonorDeathdatetime <= calldatetime
					
				AND
					r.currentReferralTypeID = 2
				AND	
					(
						Organ <> 'Yes'
						or Organ is null
					
					)
				AND	
					(
						EyesTrans <> 'Yes'
						or EyesTrans is null
					
					)
				AND
					(
						Bone	= 'Yes'
					OR	Tissue	= 'Yes'
					OR	Skin	= 'Yes'
					OR	Valves	= 'Yes'
					)
				Group by Organizationname,ReferralDonorGender
			) AS x
		WHERE #Results.OrganizationName = x.OrganizationName
			
--------------------------------------------------------------------------------

----Calculate the number of Tissue/Eye Referrals

UPDATE
	#Results
		SET
			Total_TE = x.cnt
		FROM
			(
				SELECT
				
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
				
					
					
				FROM
					#Staging r
				WHERE (Minutes between @StartRange7 and @EndRange7)
				
				
				and	ReferraldonorDeathdatetime <= calldatetime
					
				AND
					R.currentreferraltypeid = 2
				AND	
					(
						Organ <> 'Yes'
					
					)
				AND	EyesTrans = 'Yes'
				AND
					(
						Bone	= 'Yes'
					OR	Tissue	= 'Yes'
					OR	Skin	= 'Yes'
					OR	Valves	= 'Yes'
					)
				GROUP BY
					Organizationname
			) AS x
		WHERE  #Results.OrganizationName = x.OrganizationName
			
------------------------------------------------------------------------------

----Calculate the number of Eye Referrals

UPDATE
	#Results
		SET
			TotalEyesOnly = x.cnt
		FROM
			(
				SELECT
				
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
				FROM
					#Staging r
				WHERE (Minutes between @StartRange7 and @EndRange7)
				
				
				and	r.currentreferraltypeid = 3
				
				AND	
				    ReferraldonorDeathdatetime <= calldatetime	
				    
				AND
					(
						Organ <> 'Yes'
						or Organ is null
					
					)
				AND		EyesTrans = 'Yes'
						or EyesTrans is null
				AND	
					(
						Bone <> 'Yes'
						or Bone is null
					)
				AND	
					(
						Tissue	<> 'Yes'
						or Tissue is null
					)
				AND	
					(
						Skin <> 'Yes'
						or Skin is null
					)
				AND	
					(
						Valves	<> 'Yes'
						or Valves is null
					)
				AND
					(
						EyesRsch	<> 'Yes'
						or EyesRsch is null
					
					)
				GROUP BY
					Organizationname
			) AS x
		WHERE #Results.OrganizationName = x.OrganizationName
				

--------------------------------------------------------------------------------

----Calculate the number of Other/Eye Referrals

UPDATE
	#Results
		SET
			TotalOtherEye = x.cnt
		FROM
			(
				SELECT
				
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
										
				FROM
					#Staging r
				WHERE (Minutes between @StartRange7 and @EndRange7)
							
				and	currentreferraltypeid IN (3,4)
				AND	
				    ReferraldonorDeathdatetime <= calldatetime	
				    
				AND
					(
						Organ <> 'Yes'
					OR	Organ IS NULL
					)
				AND		EyesTrans = 'Yes'
				AND	
					(
						Bone <> 'Yes'
					OR	Bone IS NULL
					)
				AND	
					(
						Tissue	<> 'Yes'
					OR	Tissue IS NULL
					)
				AND	
					(
						Skin <> 'Yes'
					OR	Skin IS NULL
					)
				AND	
					(
						Valves	<> 'Yes'
					OR	Valves IS NULL
					)
				AND		EyesRsch = 'Yes'
				GROUP BY
					Organizationname
			) AS x
		WHERE  #Results.OrganizationName = x.OrganizationName
--------------------------------------------------------------------------------

----Calculate the number of Other Referrals

UPDATE
	#Results
		SET
			TotalOther = x.cnt
		FROM
			(
				SELECT
				
					
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
								
				FROM
					#Staging r
				WHERE (Minutes between @StartRange7 and @EndRange7)
				
				and	
					currentreferraltypeid = 4
				
				AND	
				    ReferraldonorDeathdatetime <= calldatetime	
				    
				AND
					(
						Organ <> 'Yes'
					OR	Organ IS NULL
					)
				AND
					(
						EyesTrans <> 'Yes'
					OR	EyesTrans IS NULL
					)
				AND
					(
						Bone <> 'Yes'
					OR	Bone IS NULL
					)
				AND	
					(
						Tissue	<> 'Yes'
					OR	Tissue IS NULL
					)
				AND	
					(
						Skin <> 'Yes'
					OR	Skin IS NULL
					)
				AND	
					(
						Valves	<> 'Yes'
					OR	Valves IS NULL
					)
				AND		EyesRsch = 'Yes'
				GROUP BY
					Organizationname
			) AS x
		WHERE #Results.OrganizationName = x.OrganizationName
--------------------------------------------------------------------------------

----Calculate the number of Age Rule Out Referrals

UPDATE
	#Results
		SET
			TotalAgeRO = x.cnt
		FROM
			(
				SELECT
				
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
				FROM
					#Staging r
				WHERE (Minutes between @StartRange7 and @EndRange7)
						
				and	
					currentreferraltypeid = 4
				
				AND	
				    ReferraldonorDeathdatetime <= calldatetime	
				    
				AND
					(
						EyesTrans NOT IN ('Med RO','High Risk')
					OR	EyesTrans IS NULL
					)
				AND
					(
						Bone NOT IN ('Med RO','High Risk')
					OR	Bone IS NULL
					)
				AND	
					(
						Tissue NOT IN ('Med RO','High Risk')
					OR	Tissue IS NULL
					)
				AND	
					(
						Skin NOT IN ('Med RO','High Risk')
					OR	Skin IS NULL
					)
				AND	
					(
						Valves NOT IN ('Med RO','High Risk')
					OR	Valves IS NULL
					)
				AND
					(
						EyesRsch <> 'Yes'
					OR	EyesRsch IS NULL
					)
				GROUP BY
					Organizationname
			) AS x
		WHERE #Results.OrganizationName = x.OrganizationName
		
--------------------------------------------------------------------------------

----Calculate the number of Medical Rule Out Referrals

UPDATE
	#Results
		SET
			TotalMedRO = x.cnt
		FROM
			(
				SELECT
				
					
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
									
				FROM
					#Staging r
				WHERE (Minutes between @StartRange7 and @EndRange7)
				
				and
					currentreferraltypeid = 4
				
				AND	
				    ReferraldonorDeathdatetime <= calldatetime
				    
				AND
					(
						EyesTrans	IN ('Med RO','High Risk')
					OR	Bone		IN ('Med RO','High Risk')
					OR	Tissue		IN ('Med RO','High Risk')
					OR	Skin		IN ('Med RO','High Risk')
					OR	Valves		IN ('Med RO','High Risk')
					)
				AND
					(
						EyesRsch <> 'Yes'
					OR	EyesRsch IS NULL
					)
				GROUP BY
					Organizationname
			) AS x
		WHERE #Results.OrganizationName = x.OrganizationName
		
--------------------------------------------------------------------------------

----------------- Range 8 ----------------


		
----Begin populating the table with the  major categories of the report's purpose.
	
--------------------------------------------------------------------------------

------------Insert Rows for Total Referrals-----------------------

UPDATE
	#Results
		SET
			TotalReferrals = x.cnt
		FROM
			(
			
				SELECT
				
					COUNT(distinct R.callid) AS Cnt,
					OrganizationName
					
				FROM
					#Staging r
					
				where (Minutes between @StartRange8 and @EndRange8)
							
							Group by Organizationname,ReferralDonorGender
				) AS x
				
				Where  #Results.OrganizationName = x.OrganizationName
-------------------------------------------------------------------------------

----Calculate the number of Referrals Without Initial CTOD-------TotalReferrals	

UPDATE
	#Results
		SET
			TotalNoCTOD = x.cnt
		FROM
			(
				SELECT
				
					
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
				
				FROM
					#Staging r
				WHERE(Minutes between @StartRange8 and @EndRange8)
			
					  and  (ReferraldonorDeathdatetime IS NULL 
					 OR ReferraldonorDeathdatetime >calldatetime)
					 
				Group by Organizationname,ReferralDonorGender
				) AS x
				
				Where #Results.OrganizationName = x.OrganizationName
--------------------------------------------------------------------------------

----Calculate the number of Referrals With Initial CTOD	

UPDATE
	#Results
		SET
			TotalCTOD = x.cnt
		FROM
			(
				SELECT
					
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
				
				FROM
					#Staging r
				WHERE(Minutes between @StartRange8 and @EndRange8)
		
				and	 ReferraldonorDeathdatetime <= calldatetime
					 
				Group by Organizationname--,ReferralDonorGender
				) AS x
				
				Where #Results.OrganizationName = x.OrganizationName
				
--------------------------------------------------------------------------------

----Calculate the number of Referrals where the Donor was a Registered Donor

UPDATE
	#Results
		SET
			TotalRegistered = x.cnt
		FROM
			(
				SELECT
				
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
		
				FROM
					#Staging r
				WHERE (Minutes between @StartRange8 and @EndRange8)
			
					and r.registrytypeid IN (1,2,4)
					and ReferraldonorDeathdatetime <= calldatetime
					
				Group by Organizationname
				) AS x
				
				Where #Results.OrganizationName = x.OrganizationName

--------------------------------------------------------------------------------
----Calculate the number of Tissue Referrals 

UPDATE
	#Results
		SET
			TotalTissue = x.cnt
		FROM
			(
				SELECT
					
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
				FROM
					#Staging r
				WHERE (Minutes between @StartRange8 and @EndRange8)
			
				and	R.ReferraldonorDeathdatetime <= calldatetime
					
				AND
					r.currentReferralTypeID = 2
				AND	
					(
						Organ <> 'Yes'
						or Organ is null
					
					)
				AND	
					(
						EyesTrans <> 'Yes'
						or EyesTrans is null
					
					)
				AND
					(
						Bone	= 'Yes'
					OR	Tissue	= 'Yes'
					OR	Skin	= 'Yes'
					OR	Valves	= 'Yes'
					)
				Group by Organizationname
			) AS x
		WHERE #Results.OrganizationName = x.OrganizationName
			
--------------------------------------------------------------------------------

----Calculate the number of Tissue/Eye Referrals

UPDATE
	#Results
		SET
			Total_TE = x.cnt
		FROM
			(
				SELECT
				
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
								
				FROM
					#Staging r
				WHERE (Minutes between @StartRange8 and @EndRange8)
				
				and	ReferraldonorDeathdatetime <= calldatetime
					
				AND
					R.currentreferraltypeid = 2
				AND	
					(
						Organ <> 'Yes'
					
					)
				AND	EyesTrans = 'Yes'
				AND
					(
						Bone	= 'Yes'
					OR	Tissue	= 'Yes'
					OR	Skin	= 'Yes'
					OR	Valves	= 'Yes'
					)
				GROUP BY
					Organizationname
			) AS x
		WHERE  #Results.OrganizationName = x.OrganizationName
			
------------------------------------------------------------------------------

----Calculate the number of Eye Referrals

UPDATE
	#Results
		SET
			TotalEyesOnly = x.cnt
		FROM
			(
				SELECT
				
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
				
				FROM
					#Staging r
				WHERE (Minutes between @StartRange8 and @EndRange8)
			
				and	r.currentreferraltypeid = 3
				
				AND	
				    ReferraldonorDeathdatetime <= calldatetime	
				    
				AND
					(
						Organ <> 'Yes'
						or Organ is null
					
					)
				AND		EyesTrans = 'Yes'
						or EyesTrans is null
				AND	
					(
						Bone <> 'Yes'
						or Bone is null
					)
				AND	
					(
						Tissue	<> 'Yes'
						or Tissue is null
					)
				AND	
					(
						Skin <> 'Yes'
						or Skin is null
					)
				AND	
					(
						Valves	<> 'Yes'
						or Valves is null
					)
				AND
					(
						EyesRsch	<> 'Yes'
						or EyesRsch is null
					
					)
				GROUP BY
					Organizationname
			) AS x
		WHERE #Results.OrganizationName = x.OrganizationName
				

--------------------------------------------------------------------------------

----Calculate the number of Other/Eye Referrals

UPDATE
	#Results
		SET
			TotalOtherEye = x.cnt
		FROM
			(
				SELECT
				
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
				
					
				FROM
					#Staging r
				WHERE (Minutes between @StartRange8 and @EndRange8)
			
				and	currentreferraltypeid IN (3,4)
				AND	
				    ReferraldonorDeathdatetime <= calldatetime	
				    
				AND
					(
						Organ <> 'Yes'
					OR	Organ IS NULL
					)
				AND		EyesTrans = 'Yes'
				AND	
					(
						Bone <> 'Yes'
					OR	Bone IS NULL
					)
				AND	
					(
						Tissue	<> 'Yes'
					OR	Tissue IS NULL
					)
				AND	
					(
						Skin <> 'Yes'
					OR	Skin IS NULL
					)
				AND	
					(
						Valves	<> 'Yes'
					OR	Valves IS NULL
					)
				AND		EyesRsch = 'Yes'
				GROUP BY
					Organizationname
			) AS x
		WHERE   #Results.OrganizationName = x.OrganizationName
--------------------------------------------------------------------------------

----Calculate the number of Other Referrals

UPDATE
	#Results
		SET
			TotalOther = x.cnt
		FROM
			(
				SELECT
				
					
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
				
				FROM
					#Staging r
				WHERE (Minutes between @StartRange8 and @EndRange8)
				
				and	
					currentreferraltypeid = 4
				
				AND	
				    ReferraldonorDeathdatetime <= calldatetime	
				    
				AND
					(
						Organ <> 'Yes'
					OR	Organ IS NULL
					)
				AND
					(
						EyesTrans <> 'Yes'
					OR	EyesTrans IS NULL
					)
				AND
					(
						Bone <> 'Yes'
					OR	Bone IS NULL
					)
				AND	
					(
						Tissue	<> 'Yes'
					OR	Tissue IS NULL
					)
				AND	
					(
						Skin <> 'Yes'
					OR	Skin IS NULL
					)
				AND	
					(
						Valves	<> 'Yes'
					OR	Valves IS NULL
					)
				AND		EyesRsch = 'Yes'
				GROUP BY
					Organizationname
			) AS x
		WHERE #Results.OrganizationName = x.OrganizationName
--------------------------------------------------------------------------------

----Calculate the number of Age Rule Out Referrals

UPDATE
	#Results
		SET
			TotalAgeRO = x.cnt
		FROM
			(
				SELECT
				
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
				
				FROM
					#Staging r
				WHERE (Minutes between @StartRange8 and @EndRange8)
			
				and	
					currentreferraltypeid = 4
				
				AND	
				    ReferraldonorDeathdatetime <= calldatetime	
				    
				AND
					(
						EyesTrans NOT IN ('Med RO','High Risk')
					OR	EyesTrans IS NULL
					)
				AND
					(
						Bone NOT IN ('Med RO','High Risk')
					OR	Bone IS NULL
					)
				AND	
					(
						Tissue NOT IN ('Med RO','High Risk')
					OR	Tissue IS NULL
					)
				AND	
					(
						Skin NOT IN ('Med RO','High Risk')
					OR	Skin IS NULL
					)
				AND	
					(
						Valves NOT IN ('Med RO','High Risk')
					OR	Valves IS NULL
					)
				AND
					(
						EyesRsch <> 'Yes'
					OR	EyesRsch IS NULL
					)
				GROUP BY
					Organizationname
			) AS x
		WHERE #Results.OrganizationName = x.OrganizationName
		
--------------------------------------------------------------------------------

----Calculate the number of Medical Rule Out Referrals

UPDATE
	#Results
		SET
			TotalMedRO = x.cnt
		FROM
			(
				SELECT
				
					
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
								
				FROM
					#Staging r
				WHERE (Minutes between @StartRange8 and @EndRange8)
			
				and
					currentreferraltypeid = 4
				
				AND	
				    ReferraldonorDeathdatetime <= calldatetime
				    
				AND
					(
						EyesTrans	IN ('Med RO','High Risk')
					OR	Bone		IN ('Med RO','High Risk')
					OR	Tissue		IN ('Med RO','High Risk')
					OR	Skin		IN ('Med RO','High Risk')
					OR	Valves		IN ('Med RO','High Risk')
					)
				AND
					(
						EyesRsch <> 'Yes'
					OR	EyesRsch IS NULL
					)
				GROUP BY
					Organizationname
			) AS x
		WHERE #Results.OrganizationName = x.OrganizationName
		
				
-------------------------------------------------------------------------------------------------------------------------
------------ Range 9 ---------------

------------Insert Rows for Total Referrals-----------------------

UPDATE
	#Results
		SET
			TotalReferrals = x.cnt
		FROM
			(
			
				SELECT
				
					COUNT(distinct R.callid) AS Cnt,
					OrganizationName
			
				FROM
					#Staging r
					
				where (Minutes between @StartRange9 and @EndRange9)
						
							Group by Organizationname,ReferralDonorGender
				) AS x
				
				Where #Results.OrganizationName = x.OrganizationName
-------------------------------------------------------------------------------

----Calculate the number of Referrals Without Initial CTOD-------TotalReferrals	

UPDATE
	#Results
		SET
			TotalNoCTOD = x.cnt
		FROM
			(
				SELECT
				
					
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
				
				FROM
					#Staging r
				WHERE(Minutes between @StartRange9 and @EndRange9)
				
					  and  (ReferraldonorDeathdatetime IS NULL 
					 OR ReferraldonorDeathdatetime >calldatetime)
					 
				Group by Organizationname,ReferralDonorGender
				) AS x
				
				Where  #Results.OrganizationName = x.OrganizationName
--------------------------------------------------------------------------------

----Calculate the number of Referrals With Initial CTOD	

UPDATE
	#Results
		SET
			TotalCTOD = x.cnt
		FROM
			(
				SELECT
					
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
								
				FROM
					#Staging r
				WHERE(Minutes between @StartRange9 and @EndRange9)
			
				and	 ReferraldonorDeathdatetime <= calldatetime
					 
				Group by Organizationname,ReferralDonorGender
				) AS x
				
				Where  #Results.OrganizationName = x.OrganizationName
				
--------------------------------------------------------------------------------

----Calculate the number of Referrals where the Donor was a Registered Donor

UPDATE
	#Results
		SET
			TotalRegistered = x.cnt
		FROM
			(
				SELECT
				
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
				
				FROM
					#Staging r
				WHERE (Minutes between @StartRange9 and @EndRange9)
			
					and r.registrytypeid IN (1,2,4)
					and ReferraldonorDeathdatetime <= calldatetime
					
				Group by Organizationname,ReferralDonorGender
				) AS x
				
				Where  #Results.OrganizationName = x.OrganizationName

--------------------------------------------------------------------------------
----Calculate the number of Tissue Referrals 

UPDATE
	#Results
		SET
			TotalTissue = x.cnt
		FROM
			(
				SELECT
					
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
									
				FROM
					#Staging r
				WHERE (Minutes between @StartRange9 and @EndRange9)
			
				and	R.ReferraldonorDeathdatetime <= calldatetime
					
				AND
					r.currentReferralTypeID = 2
				AND	
					(
						Organ <> 'Yes'
						or Organ is null
					
					)
				AND	
					(
						EyesTrans <> 'Yes'
						or EyesTrans is null
					
					)
				AND
					(
						Bone	= 'Yes'
					OR	Tissue	= 'Yes'
					OR	Skin	= 'Yes'
					OR	Valves	= 'Yes'
					)
				Group by Organizationname
			) AS x
		WHERE #Results.OrganizationName = x.OrganizationName
			
--------------------------------------------------------------------------------

----Calculate the number of Tissue/Eye Referrals

UPDATE
	#Results
		SET
			Total_TE = x.cnt
		FROM
			(
				SELECT
				
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
								
				FROM
					#Staging r
				WHERE (Minutes between @StartRange9 and @EndRange9)
							
				and	ReferraldonorDeathdatetime <= calldatetime
					
				AND
					R.currentreferraltypeid = 2
				AND	
					(
						Organ <> 'Yes'
					
					)
				AND	EyesTrans = 'Yes'
				AND
					(
						Bone	= 'Yes'
					OR	Tissue	= 'Yes'
					OR	Skin	= 'Yes'
					OR	Valves	= 'Yes'
					)
				GROUP BY
					Organizationname
			) AS x
		WHERE   #Results.OrganizationName = x.OrganizationName
			
------------------------------------------------------------------------------

----Calculate the number of Eye Referrals

UPDATE
	#Results
		SET
			TotalEyesOnly = x.cnt
		FROM
			(
				SELECT
				
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
				
				FROM
					#Staging r
				WHERE (Minutes between @StartRange9 and @EndRange9)
		
				and	r.currentreferraltypeid = 3
				
				AND	
				    ReferraldonorDeathdatetime <= calldatetime	
				    
				AND
					(
						Organ <> 'Yes'
						or Organ is null
					
					)
				AND		EyesTrans = 'Yes'
						or EyesTrans is null
				AND	
					(
						Bone <> 'Yes'
						or Bone is null
					)
				AND	
					(
						Tissue	<> 'Yes'
						or Tissue is null
					)
				AND	
					(
						Skin <> 'Yes'
						or Skin is null
					)
				AND	
					(
						Valves	<> 'Yes'
						or Valves is null
					)
				AND
					(
						EyesRsch	<> 'Yes'
						or EyesRsch is null
					
					)
				GROUP BY
					Organizationname
			) AS x
		WHERE  #Results.OrganizationName = x.OrganizationName
				

--------------------------------------------------------------------------------

----Calculate the number of Other/Eye Referrals

UPDATE
	#Results
		SET
			TotalOtherEye = x.cnt
		FROM
			(
				SELECT
				
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
				
				FROM
					#Staging r
				WHERE (Minutes between @StartRange9 and @EndRange9)
		
				and	currentreferraltypeid IN (3,4)
				AND	
				    ReferraldonorDeathdatetime <= calldatetime	
				    
				AND
					(
						Organ <> 'Yes'
					OR	Organ IS NULL
					)
				AND		EyesTrans = 'Yes'
				AND	
					(
						Bone <> 'Yes'
					OR	Bone IS NULL
					)
				AND	
					(
						Tissue	<> 'Yes'
					OR	Tissue IS NULL
					)
				AND	
					(
						Skin <> 'Yes'
					OR	Skin IS NULL
					)
				AND	
					(
						Valves	<> 'Yes'
					OR	Valves IS NULL
					)
				AND		EyesRsch = 'Yes'
				GROUP BY
					Organizationname
			) AS x
		WHERE   #Results.OrganizationName = x.OrganizationName
--------------------------------------------------------------------------------

----Calculate the number of Other Referrals

UPDATE
	#Results
		SET
			TotalOther = x.cnt
		FROM
			(
				SELECT
				
					
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
				
				FROM
					#Staging r
				WHERE (Minutes between @StartRange9 and @EndRange9)
				
				and	
					currentreferraltypeid = 4
				
				AND	
				    ReferraldonorDeathdatetime <= calldatetime	
				    
				AND
					(
						Organ <> 'Yes'
					OR	Organ IS NULL
					)
				AND
					(
						EyesTrans <> 'Yes'
					OR	EyesTrans IS NULL
					)
				AND
					(
						Bone <> 'Yes'
					OR	Bone IS NULL
					)
				AND	
					(
						Tissue	<> 'Yes'
					OR	Tissue IS NULL
					)
				AND	
					(
						Skin <> 'Yes'
					OR	Skin IS NULL
					)
				AND	
					(
						Valves	<> 'Yes'
					OR	Valves IS NULL
					)
				AND		EyesRsch = 'Yes'
				GROUP BY
					Organizationname
			) AS x
		WHERE  #Results.OrganizationName = x.OrganizationName
--------------------------------------------------------------------------------

----Calculate the number of Age Rule Out Referrals

UPDATE
	#Results
		SET
			TotalAgeRO = x.cnt
		FROM
			(
				SELECT
				
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
				
				FROM
					#Staging r
				WHERE (Minutes between @StartRange9 and @EndRange9)
				
				and	
					currentreferraltypeid = 4
				
				AND	
				    ReferraldonorDeathdatetime <= calldatetime	
				    
				AND
					(
						EyesTrans NOT IN ('Med RO','High Risk')
					OR	EyesTrans IS NULL
					)
				AND
					(
						Bone NOT IN ('Med RO','High Risk')
					OR	Bone IS NULL
					)
				AND	
					(
						Tissue NOT IN ('Med RO','High Risk')
					OR	Tissue IS NULL
					)
				AND	
					(
						Skin NOT IN ('Med RO','High Risk')
					OR	Skin IS NULL
					)
				AND	
					(
						Valves NOT IN ('Med RO','High Risk')
					OR	Valves IS NULL
					)
				AND
					(
						EyesRsch <> 'Yes'
					OR	EyesRsch IS NULL
					)
				GROUP BY
					Organizationname
			) AS x
		WHERE #Results.OrganizationName = x.OrganizationName
		
--------------------------------------------------------------------------------

----Calculate the number of Medical Rule Out Referrals

UPDATE
	#Results
		SET
			TotalMedRO = x.cnt
		FROM
			(
				SELECT
				
					
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
										
				FROM
					#Staging r
				WHERE (Minutes between @StartRange9 and @EndRange9)
		
				and
					currentreferraltypeid = 4
				
				AND	
				    ReferraldonorDeathdatetime <= calldatetime
				    
				AND
					(
						EyesTrans	IN ('Med RO','High Risk')
					OR	Bone		IN ('Med RO','High Risk')
					OR	Tissue		IN ('Med RO','High Risk')
					OR	Skin		IN ('Med RO','High Risk')
					OR	Valves		IN ('Med RO','High Risk')
					)
				AND
					(
						EyesRsch <> 'Yes'
					OR	EyesRsch IS NULL
					)
				GROUP BY
					Organizationname
			) AS x
		WHERE   #Results.OrganizationName = x.OrganizationName
		
--------------------------------------------------------------------------------

------------- Range 10 ----------------

		
----Begin populating the table with the  major categories of the report's purpose.
	
--------------------------------------------------------------------------------

------------Insert Rows for Total Referrals-----------------------

UPDATE
	#Results
		SET
			TotalReferrals = x.cnt
		FROM
			(
			
				SELECT
				
					COUNT(distinct R.callid) AS Cnt,
					OrganizationName
				
				FROM
					#Staging r
					
				where (Minutes between @StartRange10 and @EndRange10)
							
							Group by Organizationname--,ReferralDonorGender
				) AS x
				
				Where  #Results.OrganizationName = x.OrganizationName
-------------------------------------------------------------------------------

----Calculate the number of Referrals Without Initial CTOD-------TotalReferrals	

UPDATE
	#Results
		SET
			TotalNoCTOD = x.cnt
		FROM
			(
				SELECT
				
					
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
				
				FROM
					#Staging r
				WHERE(Minutes between @StartRange10 and @EndRange10)
				
					  and  (ReferraldonorDeathdatetime IS NULL 
					 OR ReferraldonorDeathdatetime >calldatetime)
					 
				Group by Organizationname,ReferralDonorGender
				) AS x
				
				Where #Results.OrganizationName = x.OrganizationName
--------------------------------------------------------------------------------

----Calculate the number of Referrals With Initial CTOD	

UPDATE
	#Results
		SET
			TotalCTOD = x.cnt
		FROM
			(
				SELECT
					
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
				
				FROM
					#Staging r
				WHERE(Minutes between @StartRange10 and @EndRange10)
			
				and	 ReferraldonorDeathdatetime <= calldatetime
					 
				Group by Organizationname,ReferralDonorGender
				) AS x
				
				Where   #Results.OrganizationName = x.OrganizationName
				
--------------------------------------------------------------------------------

----Calculate the number of Referrals where the Donor was a Registered Donor

UPDATE
	#Results
		SET
			TotalRegistered = x.cnt
		FROM
			(
				SELECT
				
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
				
				FROM
					#Staging r
				WHERE (Minutes between @StartRange10 and @EndRange10)
				
					and r.registrytypeid IN (1,2,4)
					and ReferraldonorDeathdatetime <= calldatetime
					
				Group by Organizationname,ReferralDonorGender
				) AS x
				
				Where  #Results.OrganizationName = x.OrganizationName

--------------------------------------------------------------------------------
----Calculate the number of Tissue Referrals 

UPDATE
	#Results
		SET
			TotalTissue = x.cnt
		FROM
			(
				SELECT
					
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
				
				FROM
					#Staging r
				WHERE (Minutes between @StartRange10 and @EndRange10)
				
				and	R.ReferraldonorDeathdatetime <= calldatetime
					
				AND
					r.currentReferralTypeID = 2
				AND	
					(
						Organ <> 'Yes'
						or Organ is null
					
					)
				AND	
					(
						EyesTrans <> 'Yes'
						or EyesTrans is null
					
					)
				AND
					(
						Bone	= 'Yes'
					OR	Tissue	= 'Yes'
					OR	Skin	= 'Yes'
					OR	Valves	= 'Yes'
					)
				Group by Organizationname,ReferralDonorGender
			) AS x
		WHERE #Results.OrganizationName = x.OrganizationName
			
--------------------------------------------------------------------------------

----Calculate the number of Tissue/Eye Referrals

UPDATE
	#Results
		SET
			Total_TE = x.cnt
		FROM
			(
				SELECT
				
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
									
				FROM
					#Staging r
				WHERE (Minutes between @StartRange10 and @EndRange10)
			
				and	ReferraldonorDeathdatetime <= calldatetime
					
				AND
					R.currentreferraltypeid = 2
				AND	
					(
						Organ <> 'Yes'
					
					)
				AND	EyesTrans = 'Yes'
				AND
					(
						Bone	= 'Yes'
					OR	Tissue	= 'Yes'
					OR	Skin	= 'Yes'
					OR	Valves	= 'Yes'
					)
				GROUP BY
					Organizationname
			) AS x
		WHERE   #Results.OrganizationName = x.OrganizationName
			
------------------------------------------------------------------------------

----Calculate the number of Eye Referrals

UPDATE
	#Results
		SET
			TotalEyesOnly = x.cnt
		FROM
			(
				SELECT
				
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
				FROM
					#Staging r
				WHERE (Minutes between @StartRange10 and @EndRange10)
			
				and	r.currentreferraltypeid = 3
				
				AND	
				    ReferraldonorDeathdatetime <= calldatetime	
				    
				AND
					(
						Organ <> 'Yes'
						or Organ is null
					
					)
				AND		EyesTrans = 'Yes'
						or EyesTrans is null
				AND	
					(
						Bone <> 'Yes'
						or Bone is null
					)
				AND	
					(
						Tissue	<> 'Yes'
						or Tissue is null
					)
				AND	
					(
						Skin <> 'Yes'
						or Skin is null
					)
				AND	
					(
						Valves	<> 'Yes'
						or Valves is null
					)
				AND
					(
						EyesRsch	<> 'Yes'
						or EyesRsch is null
					
					)
				GROUP BY
					Organizationname
			) AS x
		WHERE #Results.OrganizationName = x.OrganizationName
				

--------------------------------------------------------------------------------

----Calculate the number of Other/Eye Referrals

UPDATE
	#Results
		SET
			TotalOtherEye = x.cnt
		FROM
			(
				SELECT
				
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
				FROM
					#Staging r
				WHERE (Minutes between @StartRange10 and @EndRange10)
			
				and	currentreferraltypeid IN (3,4)
				AND	
				    ReferraldonorDeathdatetime <= calldatetime	
				    
				AND
					(
						Organ <> 'Yes'
					OR	Organ IS NULL
					)
				AND		EyesTrans = 'Yes'
				AND	
					(
						Bone <> 'Yes'
					OR	Bone IS NULL
					)
				AND	
					(
						Tissue	<> 'Yes'
					OR	Tissue IS NULL
					)
				AND	
					(
						Skin <> 'Yes'
					OR	Skin IS NULL
					)
				AND	
					(
						Valves	<> 'Yes'
					OR	Valves IS NULL
					)
				AND		EyesRsch = 'Yes'
				GROUP BY
					Organizationname
			) AS x
		WHERE  #Results.OrganizationName = x.OrganizationName
--------------------------------------------------------------------------------

----Calculate the number of Other Referrals

UPDATE
	#Results
		SET
			TotalOther = x.cnt
		FROM
			(
				SELECT
				
					
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
				FROM
					#Staging r
				WHERE (Minutes between @StartRange10 and @EndRange10)
			
				and	
					currentreferraltypeid = 4
				
				AND	
				    ReferraldonorDeathdatetime <= calldatetime	
				    
				AND
					(
						Organ <> 'Yes'
					OR	Organ IS NULL
					)
				AND
					(
						EyesTrans <> 'Yes'
					OR	EyesTrans IS NULL
					)
				AND
					(
						Bone <> 'Yes'
					OR	Bone IS NULL
					)
				AND	
					(
						Tissue	<> 'Yes'
					OR	Tissue IS NULL
					)
				AND	
					(
						Skin <> 'Yes'
					OR	Skin IS NULL
					)
				AND	
					(
						Valves	<> 'Yes'
					OR	Valves IS NULL
					)
				AND		EyesRsch = 'Yes'
				GROUP BY
					Organizationname
			) AS x
		WHERE #Results.OrganizationName = x.OrganizationName
--------------------------------------------------------------------------------

----Calculate the number of Age Rule Out Referrals

UPDATE
	#Results
		SET
			TotalAgeRO = x.cnt
		FROM
			(
				SELECT
				
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
			
				FROM
					#Staging r
				WHERE (Minutes between @StartRange10 and @EndRange10)
			
				and	
					currentreferraltypeid = 4
				
				AND	
				    ReferraldonorDeathdatetime <= calldatetime	
				    
				AND
					(
						EyesTrans NOT IN ('Med RO','High Risk')
					OR	EyesTrans IS NULL
					)
				AND
					(
						Bone NOT IN ('Med RO','High Risk')
					OR	Bone IS NULL
					)
				AND	
					(
						Tissue NOT IN ('Med RO','High Risk')
					OR	Tissue IS NULL
					)
				AND	
					(
						Skin NOT IN ('Med RO','High Risk')
					OR	Skin IS NULL
					)
				AND	
					(
						Valves NOT IN ('Med RO','High Risk')
					OR	Valves IS NULL
					)
				AND
					(
						EyesRsch <> 'Yes'
					OR	EyesRsch IS NULL
					)
				GROUP BY
					Organizationname
			) AS x
		WHERE   #Results.OrganizationName = x.OrganizationName
		
--------------------------------------------------------------------------------

----Calculate the number of Medical Rule Out Referrals

UPDATE
	#Results
		SET
			TotalMedRO = x.cnt
		FROM
			(
				SELECT
				
					
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
								
				FROM
					#Staging r
				WHERE (Minutes between @StartRange10 and @EndRange10)
			
				and
					currentreferraltypeid = 4
				
				AND	
				    ReferraldonorDeathdatetime <= calldatetime
				    
				AND
					(
						EyesTrans	IN ('Med RO','High Risk')
					OR	Bone		IN ('Med RO','High Risk')
					OR	Tissue		IN ('Med RO','High Risk')
					OR	Skin		IN ('Med RO','High Risk')
					OR	Valves		IN ('Med RO','High Risk')
					)
				AND
					(
						EyesRsch <> 'Yes'
					OR	EyesRsch IS NULL
					)
				GROUP BY
					Organizationname
			) AS x
		WHERE   #Results.OrganizationName = x.OrganizationName
		

----------------------------------------------------------------------------------------------------------------------------------
----------- Range 11 -----------------
		
----Begin populating the table with the  major categories of the report's purpose.
	
--------------------------------------------------------------------------------

------------Insert Rows for Total Referrals-----------------------

UPDATE
	#Results
		SET
			TotalReferrals = x.cnt
		FROM
			(
			
				SELECT
				
					COUNT(distinct R.callid) AS Cnt,
					OrganizationName
				
					
				FROM
					#Staging r
					
				where (Minutes between @StartRange11 and @EndRange11)
			
				
							Group by Organizationname,ReferralDonorGender
				) AS x
				
				Where   #Results.OrganizationName = x.OrganizationName
-------------------------------------------------------------------------------

----Calculate the number of Referrals Without Initial CTOD-------TotalReferrals	

UPDATE
	#Results
		SET
			TotalNoCTOD = x.cnt
		FROM
			(
				SELECT
				
					
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
				FROM
					#Staging r
				WHERE(Minutes between @StartRange11 and @EndRange11)
				
					  and  (ReferraldonorDeathdatetime IS NULL 
					 OR ReferraldonorDeathdatetime >calldatetime)
					 
				Group by Organizationname
				) AS x
				
				Where #Results.OrganizationName = x.OrganizationName
--------------------------------------------------------------------------------

----Calculate the number of Referrals With Initial CTOD	

UPDATE
	#Results
		SET
			TotalCTOD = x.cnt
		FROM
			(
				SELECT
					
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
				FROM
					#Staging r
				WHERE(Minutes between @StartRange11 and @EndRange11)
			
				and	 ReferraldonorDeathdatetime <= calldatetime
					 
				Group by Organizationname
				) AS x
				
				Where  #Results.OrganizationName = x.OrganizationName
				
--------------------------------------------------------------------------------

----Calculate the number of Referrals where the Donor was a Registered Donor

UPDATE
	#Results
		SET
			TotalRegistered = x.cnt
		FROM
			(
				SELECT
				
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
										
				FROM
					#Staging r
				WHERE (Minutes between @StartRange11 and @EndRange11)
				
					
					and r.registrytypeid IN (1,2,4)
					and ReferraldonorDeathdatetime <= calldatetime
					
				Group by Organizationname
				) AS x
				
				Where  #Results.OrganizationName = x.OrganizationName

--------------------------------------------------------------------------------
----Calculate the number of Tissue Referrals 

UPDATE
	#Results
		SET
			TotalTissue = x.cnt
		FROM
			(
				SELECT
					
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
			
				FROM
					#Staging r
				WHERE (Minutes between @StartRange11 and @EndRange11)
							
				and	R.ReferraldonorDeathdatetime <= calldatetime
					
				AND
					r.currentReferralTypeID = 2
				AND	
					(
						Organ <> 'Yes'
						or Organ is null
					
					)
				AND	
					(
						EyesTrans <> 'Yes'
						or EyesTrans is null
					
					)
				AND
					(
						Bone	= 'Yes'
					OR	Tissue	= 'Yes'
					OR	Skin	= 'Yes'
					OR	Valves	= 'Yes'
					)
				Group by Organizationname
			) AS x
		WHERE #Results.OrganizationName = x.OrganizationName
			
--------------------------------------------------------------------------------

----Calculate the number of Tissue/Eye Referrals

UPDATE
	#Results
		SET
			Total_TE = x.cnt
		FROM
			(
				SELECT
				
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
										
				FROM
					#Staging r
				WHERE (Minutes between @StartRange11 and @EndRange11)
				
				and	ReferraldonorDeathdatetime <= calldatetime
					
				AND
					R.currentreferraltypeid = 2
				AND	
					(
						Organ <> 'Yes'
					
					)
				AND	EyesTrans = 'Yes'
				AND
					(
						Bone	= 'Yes'
					OR	Tissue	= 'Yes'
					OR	Skin	= 'Yes'
					OR	Valves	= 'Yes'
					)
				GROUP BY
					Organizationname
			) AS x
		WHERE  #Results.OrganizationName = x.OrganizationName
			
------------------------------------------------------------------------------

----Calculate the number of Eye Referrals

UPDATE
	#Results
		SET
			TotalEyesOnly = x.cnt
		FROM
			(
				SELECT
				
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
				FROM
					#Staging r
				WHERE (Minutes between @StartRange11 and @EndRange11)
				
				and	r.currentreferraltypeid = 3
				
				AND	
				    ReferraldonorDeathdatetime <= calldatetime	
				    
				AND
					(
						Organ <> 'Yes'
						or Organ is null
					
					)
				AND		EyesTrans = 'Yes'
						or EyesTrans is null
				AND	
					(
						Bone <> 'Yes'
						or Bone is null
					)
				AND	
					(
						Tissue	<> 'Yes'
						or Tissue is null
					)
				AND	
					(
						Skin <> 'Yes'
						or Skin is null
					)
				AND	
					(
						Valves	<> 'Yes'
						or Valves is null
					)
				AND
					(
						EyesRsch	<> 'Yes'
						or EyesRsch is null
					
					)
				GROUP BY
					Organizationname
			) AS x
		WHERE  #Results.OrganizationName = x.OrganizationName
				

--------------------------------------------------------------------------------

----Calculate the number of Other/Eye Referrals

UPDATE
	#Results
		SET
			TotalOtherEye = x.cnt
		FROM
			(
				SELECT
				
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
									
				FROM
					#Staging r
				WHERE (Minutes between @StartRange11 and @EndRange11)
								
				and	currentreferraltypeid IN (3,4)
				AND	
				    ReferraldonorDeathdatetime <= calldatetime	
				    
				AND
					(
						Organ <> 'Yes'
					OR	Organ IS NULL
					)
				AND		EyesTrans = 'Yes'
				AND	
					(
						Bone <> 'Yes'
					OR	Bone IS NULL
					)
				AND	
					(
						Tissue	<> 'Yes'
					OR	Tissue IS NULL
					)
				AND	
					(
						Skin <> 'Yes'
					OR	Skin IS NULL
					)
				AND	
					(
						Valves	<> 'Yes'
					OR	Valves IS NULL
					)
				AND		EyesRsch = 'Yes'
				GROUP BY
					Organizationname
			) AS x
		WHERE   #Results.OrganizationName = x.OrganizationName
--------------------------------------------------------------------------------

----Calculate the number of Other Referrals

UPDATE
	#Results
		SET
			TotalOther = x.cnt
		FROM
			(
				SELECT
				
					
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
			
				FROM
					#Staging r
				WHERE (Minutes between @StartRange11 and @EndRange11)
			
				and	
					currentreferraltypeid = 4
				
				AND	
				    ReferraldonorDeathdatetime <= calldatetime	
				    
				AND
					(
						Organ <> 'Yes'
					OR	Organ IS NULL
					)
				AND
					(
						EyesTrans <> 'Yes'
					OR	EyesTrans IS NULL
					)
				AND
					(
						Bone <> 'Yes'
					OR	Bone IS NULL
					)
				AND	
					(
						Tissue	<> 'Yes'
					OR	Tissue IS NULL
					)
				AND	
					(
						Skin <> 'Yes'
					OR	Skin IS NULL
					)
				AND	
					(
						Valves	<> 'Yes'
					OR	Valves IS NULL
					)
				AND		EyesRsch = 'Yes'
				GROUP BY
					Organizationname
			) AS x
		WHERE  #Results.OrganizationName = x.OrganizationName
--------------------------------------------------------------------------------

----Calculate the number of Age Rule Out Referrals

UPDATE
	#Results
		SET
			TotalAgeRO = x.cnt
		FROM
			(
				SELECT
				
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
				
				FROM
					#Staging r
				WHERE (Minutes between @StartRange11 and @EndRange11)
				
				and	
					currentreferraltypeid = 4
				
				AND	
				    ReferraldonorDeathdatetime <= calldatetime	
				    
				AND
					(
						EyesTrans NOT IN ('Med RO','High Risk')
					OR	EyesTrans IS NULL
					)
				AND
					(
						Bone NOT IN ('Med RO','High Risk')
					OR	Bone IS NULL
					)
				AND	
					(
						Tissue NOT IN ('Med RO','High Risk')
					OR	Tissue IS NULL
					)
				AND	
					(
						Skin NOT IN ('Med RO','High Risk')
					OR	Skin IS NULL
					)
				AND	
					(
						Valves NOT IN ('Med RO','High Risk')
					OR	Valves IS NULL
					)
				AND
					(
						EyesRsch <> 'Yes'
					OR	EyesRsch IS NULL
					)
				GROUP BY
					Organizationname
			) AS x
		WHERE #Results.OrganizationName = x.OrganizationName
		
--------------------------------------------------------------------------------

----Calculate the number of Medical Rule Out Referrals

UPDATE
	#Results
		SET
			TotalMedRO = x.cnt
		FROM
			(
				SELECT
				
					
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
				FROM
					#Staging r
				WHERE (Minutes between @StartRange11 and @EndRange11)
		
				and
					currentreferraltypeid = 4
				
				AND	
				    ReferraldonorDeathdatetime <= calldatetime
				    
				AND
					(
						EyesTrans	IN ('Med RO','High Risk')
					OR	Bone		IN ('Med RO','High Risk')
					OR	Tissue		IN ('Med RO','High Risk')
					OR	Skin		IN ('Med RO','High Risk')
					OR	Valves		IN ('Med RO','High Risk')
					)
				AND
					(
						EyesRsch <> 'Yes'
					OR	EyesRsch IS NULL
					)
				GROUP BY
					Organizationname
			) AS x
		WHERE  #Results.OrganizationName = x.OrganizationName
		
--------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------------------------
----------- Range 12 -----------

----Begin populating the table with the  major categories of the report's purpose.
	

------------Insert Rows for Total Referrals-----------------------

UPDATE
	#Results
		SET
			TotalReferrals = x.cnt
		FROM
			(
			
				SELECT
				
					COUNT(distinct R.callid) AS Cnt,
					OrganizationName
					
				FROM
					#Staging r
					
				where (Minutes between @StartRange12 and @EndRange12)
								
							Group by Organizationname
				) AS x
				
				Where  #Results.OrganizationName = x.OrganizationName
-------------------------------------------------------------------------------

----Calculate the number of Referrals Without Initial CTOD-------TotalReferrals	

UPDATE
	#Results
		SET
			TotalNoCTOD = x.cnt
		FROM
			(
				SELECT
				
					
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
				FROM
					#Staging r
				WHERE(Minutes between @StartRange12 and @EndRange12)
				
					  and  (ReferraldonorDeathdatetime IS NULL 
					 OR ReferraldonorDeathdatetime >calldatetime)
					 
				Group by Organizationname
				) AS x
				
				Where  #Results.OrganizationName = x.OrganizationName
--------------------------------------------------------------------------------

----Calculate the number of Referrals With Initial CTOD	

UPDATE
	#Results
		SET
			TotalCTOD = x.cnt
		FROM
			(
				SELECT
					
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
			
				FROM
					#Staging r
				WHERE(Minutes between @StartRange12 and @EndRange12)
				
				and	 ReferraldonorDeathdatetime <= calldatetime
					 
				Group by Organizationname
				) AS x
				
				Where #Results.OrganizationName = x.OrganizationName
				
--------------------------------------------------------------------------------

----Calculate the number of Referrals where the Donor was a Registered Donor

UPDATE
	#Results
		SET
			TotalRegistered = x.cnt
		FROM
			(
				SELECT
				
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
				FROM
					#Staging r
				WHERE (Minutes between @StartRange12 and @EndRange12)
			
					and r.registrytypeid IN (1,2,4)
					and ReferraldonorDeathdatetime <= calldatetime
					
				Group by Organizationname
				) AS x
				
				Where #Results.OrganizationName = x.OrganizationName

--------------------------------------------------------------------------------
----Calculate the number of Tissue Referrals 

UPDATE
	#Results
		SET
			TotalTissue = x.cnt
		FROM
			(
				SELECT
					
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
				FROM
					#Staging r
				WHERE (Minutes between @StartRange12 and @EndRange12)
				
				and	R.ReferraldonorDeathdatetime <= calldatetime
					
				AND
					r.currentReferralTypeID = 2
				AND	
					(
						Organ <> 'Yes'
						or Organ is null
					
					)
				AND	
					(
						EyesTrans <> 'Yes'
						or EyesTrans is null
					
					)
				AND
					(
						Bone	= 'Yes'
					OR	Tissue	= 'Yes'
					OR	Skin	= 'Yes'
					OR	Valves	= 'Yes'
					)
			GROUP BY
					Organizationname
			) AS x
		WHERE   #Results.OrganizationName = x.OrganizationName
			
--------------------------------------------------------------------------------

----Calculate the number of Tissue/Eye Referrals

UPDATE
	#Results
		SET
			Total_TE = x.cnt
		FROM
			(
				SELECT
				
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
				FROM
					#Staging r
				WHERE (Minutes between @StartRange12 and @EndRange12)
				
				and	ReferraldonorDeathdatetime <= calldatetime
					
				AND
					R.currentreferraltypeid = 2
				AND	
					(
						Organ <> 'Yes'
					
					)
				AND	EyesTrans = 'Yes'
				AND
					(
						Bone	= 'Yes'
					OR	Tissue	= 'Yes'
					OR	Skin	= 'Yes'
					OR	Valves	= 'Yes'
					)
				GROUP BY
					Organizationname
			) AS x
		WHERE   #Results.OrganizationName = x.OrganizationName
			
------------------------------------------------------------------------------

----Calculate the number of Eye Referrals

UPDATE
	#Results
		SET
			TotalEyesOnly = x.cnt
		FROM
			(
				SELECT
				
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
				FROM
					#Staging r
				WHERE (Minutes between @StartRange12 and @EndRange12)
				
				and	r.currentreferraltypeid = 3
				
				AND	
				    ReferraldonorDeathdatetime <= calldatetime	
				    
				AND
					(
						Organ <> 'Yes'
						or Organ is null
					
					)
				AND		EyesTrans = 'Yes'
						or EyesTrans is null
				AND	
					(
						Bone <> 'Yes'
						or Bone is null
					)
				AND	
					(
						Tissue	<> 'Yes'
						or Tissue is null
					)
				AND	
					(
						Skin <> 'Yes'
						or Skin is null
					)
				AND	
					(
						Valves	<> 'Yes'
						or Valves is null
					)
				AND
					(
						EyesRsch	<> 'Yes'
						or EyesRsch is null
					
					)
				GROUP BY
					Organizationname
			) AS x
		WHERE  #Results.OrganizationName = x.OrganizationName
				

--------------------------------------------------------------------------------

----Calculate the number of Other/Eye Referrals

UPDATE
	#Results
		SET
			TotalOtherEye = x.cnt
		FROM
			(
				SELECT
				
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
				FROM
					#Staging r
				WHERE (Minutes between @StartRange12 and @EndRange12)
			
				and	currentreferraltypeid IN (3,4)
				AND	
				    ReferraldonorDeathdatetime <= calldatetime	
				    
				AND
					(
						Organ <> 'Yes'
					OR	Organ IS NULL
					)
				AND		EyesTrans = 'Yes'
				AND	
					(
						Bone <> 'Yes'
					OR	Bone IS NULL
					)
				AND	
					(
						Tissue	<> 'Yes'
					OR	Tissue IS NULL
					)
				AND	
					(
						Skin <> 'Yes'
					OR	Skin IS NULL
					)
				AND	
					(
						Valves	<> 'Yes'
					OR	Valves IS NULL
					)
				AND		EyesRsch = 'Yes'
				GROUP BY
					Organizationname
			) AS x
		WHERE  #Results.OrganizationName = x.OrganizationName
--------------------------------------------------------------------------------

----Calculate the number of Other Referrals

UPDATE
	#Results
		SET
			TotalOther = x.cnt
		FROM
			(
				SELECT
				
					
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
				FROM
					#Staging r
				WHERE (Minutes between @StartRange12 and @EndRange12)
				
				and	
					currentreferraltypeid = 4
				
				AND	
				    ReferraldonorDeathdatetime <= calldatetime	
				    
				AND
					(
						Organ <> 'Yes'
					OR	Organ IS NULL
					)
				AND
					(
						EyesTrans <> 'Yes'
					OR	EyesTrans IS NULL
					)
				AND
					(
						Bone <> 'Yes'
					OR	Bone IS NULL
					)
				AND	
					(
						Tissue	<> 'Yes'
					OR	Tissue IS NULL
					)
				AND	
					(
						Skin <> 'Yes'
					OR	Skin IS NULL
					)
				AND	
					(
						Valves	<> 'Yes'
					OR	Valves IS NULL
					)
				AND		EyesRsch = 'Yes'
				GROUP BY
					Organizationname
			) AS x
		WHERE #Results.OrganizationName = x.OrganizationName
--------------------------------------------------------------------------------

----Calculate the number of Age Rule Out Referrals

UPDATE
	#Results
		SET
			TotalAgeRO = x.cnt
		FROM
			(
				SELECT
				
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
				FROM
					#Staging r
				WHERE (Minutes between @StartRange12 and @EndRange12)
				
				and	
					currentreferraltypeid = 4
				
				AND	
				    ReferraldonorDeathdatetime <= calldatetime	
				    
				AND
					(
						EyesTrans NOT IN ('Med RO','High Risk')
					OR	EyesTrans IS NULL
					)
				AND
					(
						Bone NOT IN ('Med RO','High Risk')
					OR	Bone IS NULL
					)
				AND	
					(
						Tissue NOT IN ('Med RO','High Risk')
					OR	Tissue IS NULL
					)
				AND	
					(
						Skin NOT IN ('Med RO','High Risk')
					OR	Skin IS NULL
					)
				AND	
					(
						Valves NOT IN ('Med RO','High Risk')
					OR	Valves IS NULL
					)
				AND
					(
						EyesRsch <> 'Yes'
					OR	EyesRsch IS NULL
					)
				GROUP BY
					Organizationname
			) AS x
		WHERE  #Results.OrganizationName = x.OrganizationName
		
--------------------------------------------------------------------------------

----Calculate the number of Medical Rule Out Referrals

UPDATE
	#Results
		SET
			TotalMedRO = x.cnt
		FROM
			(
				SELECT
				
					
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
				FROM
					#Staging r
				WHERE (Minutes between @StartRange12 and @EndRange12)
				
				and
					currentreferraltypeid = 4
				
				AND	
				    ReferraldonorDeathdatetime <= calldatetime
				    
				AND
					(
						EyesTrans	IN ('Med RO','High Risk')
					OR	Bone		IN ('Med RO','High Risk')
					OR	Tissue		IN ('Med RO','High Risk')
					OR	Skin		IN ('Med RO','High Risk')
					OR	Valves		IN ('Med RO','High Risk')
					)
				AND
					(
						EyesRsch <> 'Yes'
					OR	EyesRsch IS NULL
					)
				GROUP BY
					Organizationname
			) AS x
		WHERE  #Results.OrganizationName = x.OrganizationName
		
--------------------------------------------------------------------------------
------------ Range 13 --------------
	
		
----Begin populating the table with the  major categories of the report's purpose.
	
--------------------------------------------------------------------------------

------------Insert Rows for Total Referrals-----------------------

UPDATE
	#Results
		SET
			TotalReferrals = x.cnt
		FROM
			(
			
				SELECT
				
					COUNT(distinct R.callid) AS Cnt,
					OrganizationName
					
				FROM
					#Staging r
					
				where (Minutes between @StartRange13 and @EndRange13)
			
				
							Group by Organizationname
				) AS x
				
				Where #Results.OrganizationName = x.OrganizationName
-------------------------------------------------------------------------------

----Calculate the number of Referrals Without Initial CTOD-------TotalReferrals	

UPDATE
	#Results
		SET
			TotalNoCTOD = x.cnt
		FROM
			(
				SELECT
				
					
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
				FROM
					#Staging r
				WHERE(Minutes between @StartRange13 and @EndRange13)
					 
					  and  (ReferraldonorDeathdatetime IS NULL 
					 OR ReferraldonorDeathdatetime >calldatetime)
					 
				Group by Organizationname
				) AS x
				
				Where  #Results.OrganizationName = x.OrganizationName
--------------------------------------------------------------------------------

----Calculate the number of Referrals With Initial CTOD	

UPDATE
	#Results
		SET
			TotalCTOD = x.cnt
		FROM
			(
				SELECT
					
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
				FROM
					#Staging r
				WHERE(Minutes between @StartRange13 and @EndRange13)
				
				and	 ReferraldonorDeathdatetime <= calldatetime
					 
				Group by Organizationname
				) AS x
				
				Where   #Results.OrganizationName = x.OrganizationName
				
--------------------------------------------------------------------------------

----Calculate the number of Referrals where the Donor was a Registered Donor

UPDATE
	#Results
		SET
			TotalRegistered = x.cnt
		FROM
			(
				SELECT
				
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
				FROM
					#Staging r
				WHERE (Minutes between @StartRange13 and @EndRange13)
					
					and r.registrytypeid IN (1,2,4)
					and ReferraldonorDeathdatetime <= calldatetime
					
				Group by Organizationname
				) AS x
				
				Where #Results.OrganizationName = x.OrganizationName

--------------------------------------------------------------------------------
----Calculate the number of Tissue Referrals 

UPDATE
	#Results
		SET
			TotalTissue = x.cnt
		FROM
			(
				SELECT
					
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
				FROM
					#Staging r
				WHERE (Minutes between @StartRange13 and @EndRange13)
			
				and	R.ReferraldonorDeathdatetime <= calldatetime
					
				AND
					r.currentReferralTypeID = 2
				AND	
					(
						Organ <> 'Yes'
						or Organ is null
					
					)
				AND	
					(
						EyesTrans <> 'Yes'
						or EyesTrans is null
					
					)
				AND
					(
						Bone	= 'Yes'
					OR	Tissue	= 'Yes'
					OR	Skin	= 'Yes'
					OR	Valves	= 'Yes'
					)
				Group by Organizationname
			) AS x
		WHERE  #Results.OrganizationName = x.OrganizationName
			
--------------------------------------------------------------------------------

----Calculate the number of Tissue/Eye Referrals

UPDATE
	#Results
		SET
			Total_TE = x.cnt
		FROM
			(
				SELECT
				
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
			
				FROM
					#Staging r
				WHERE (Minutes between @StartRange13 and @EndRange13)
			
				and	ReferraldonorDeathdatetime <= calldatetime
					
				AND
					R.currentreferraltypeid = 2
				AND	
					(
						Organ <> 'Yes'
					
					)
				AND	EyesTrans = 'Yes'
				AND
					(
						Bone	= 'Yes'
					OR	Tissue	= 'Yes'
					OR	Skin	= 'Yes'
					OR	Valves	= 'Yes'
					)
				GROUP BY
					Organizationname
			) AS x
		WHERE #Results.OrganizationName = x.OrganizationName
			
------------------------------------------------------------------------------

----Calculate the number of Eye Referrals

UPDATE
	#Results
		SET
			TotalEyesOnly = x.cnt
		FROM
			(
				SELECT
				
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
				FROM
					#Staging r
				WHERE (Minutes between @StartRange13 and @EndRange13)
				
				and	r.currentreferraltypeid = 3
				
				AND	
				    ReferraldonorDeathdatetime <= calldatetime	
				    
				AND
					(
						Organ <> 'Yes'
						or Organ is null
					
					)
				AND		EyesTrans = 'Yes'
						or EyesTrans is null
				AND	
					(
						Bone <> 'Yes'
						or Bone is null
					)
				AND	
					(
						Tissue	<> 'Yes'
						or Tissue is null
					)
				AND	
					(
						Skin <> 'Yes'
						or Skin is null
					)
				AND	
					(
						Valves	<> 'Yes'
						or Valves is null
					)
				AND
					(
						EyesRsch	<> 'Yes'
						or EyesRsch is null
					
					)
				GROUP BY
					Organizationname
			) AS x
		WHERE  #Results.OrganizationName = x.OrganizationName
				

--------------------------------------------------------------------------------

----Calculate the number of Other/Eye Referrals

UPDATE
	#Results
		SET
			TotalOtherEye = x.cnt
		FROM
			(
				SELECT
				
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
				FROM
					#Staging r
				WHERE (Minutes between @StartRange13 and @EndRange13)
				
				and	currentreferraltypeid IN (3,4)
				AND	
				    ReferraldonorDeathdatetime <= calldatetime	
				    
				AND
					(
						Organ <> 'Yes'
					OR	Organ IS NULL
					)
				AND		EyesTrans = 'Yes'
				AND	
					(
						Bone <> 'Yes'
					OR	Bone IS NULL
					)
				AND	
					(
						Tissue	<> 'Yes'
					OR	Tissue IS NULL
					)
				AND	
					(
						Skin <> 'Yes'
					OR	Skin IS NULL
					)
				AND	
					(
						Valves	<> 'Yes'
					OR	Valves IS NULL
					)
				AND		EyesRsch = 'Yes'
				GROUP BY
					Organizationname
			) AS x
		WHERE   #Results.OrganizationName = x.OrganizationName
--------------------------------------------------------------------------------

----Calculate the number of Other Referrals

UPDATE
	#Results
		SET
			TotalOther = x.cnt
		FROM
			(
				SELECT
				
					
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
				FROM
					#Staging r
				WHERE (Minutes between @StartRange13 and @EndRange13)
				
				and	
					currentreferraltypeid = 4
				
				AND	
				    ReferraldonorDeathdatetime <= calldatetime	
				    
				AND
					(
						Organ <> 'Yes'
					OR	Organ IS NULL
					)
				AND
					(
						EyesTrans <> 'Yes'
					OR	EyesTrans IS NULL
					)
				AND
					(
						Bone <> 'Yes'
					OR	Bone IS NULL
					)
				AND	
					(
						Tissue	<> 'Yes'
					OR	Tissue IS NULL
					)
				AND	
					(
						Skin <> 'Yes'
					OR	Skin IS NULL
					)
				AND	
					(
						Valves	<> 'Yes'
					OR	Valves IS NULL
					)
				AND		EyesRsch = 'Yes'
				GROUP BY
					Organizationname
			) AS x
		WHERE  #Results.OrganizationName = x.OrganizationName
--------------------------------------------------------------------------------

----Calculate the number of Age Rule Out Referrals

UPDATE
	#Results
		SET
			TotalAgeRO = x.cnt
		FROM
			(
				SELECT
				
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
				FROM
					#Staging r
				WHERE (Minutes between @StartRange13 and @EndRange13)
				
				and	
					currentreferraltypeid = 4
				
				AND	
				    ReferraldonorDeathdatetime <= calldatetime	
				    
				AND
					(
						EyesTrans NOT IN ('Med RO','High Risk')
					OR	EyesTrans IS NULL
					)
				AND
					(
						Bone NOT IN ('Med RO','High Risk')
					OR	Bone IS NULL
					)
				AND	
					(
						Tissue NOT IN ('Med RO','High Risk')
					OR	Tissue IS NULL
					)
				AND	
					(
						Skin NOT IN ('Med RO','High Risk')
					OR	Skin IS NULL
					)
				AND	
					(
						Valves NOT IN ('Med RO','High Risk')
					OR	Valves IS NULL
					)
				AND
					(
						EyesRsch <> 'Yes'
					OR	EyesRsch IS NULL
					)
				GROUP BY
					Organizationname
			) AS x
		WHERE  #Results.OrganizationName = x.OrganizationName
		
--------------------------------------------------------------------------------

----Calculate the number of Medical Rule Out Referrals

UPDATE
	#Results
		SET
			TotalMedRO = x.cnt
		FROM
			(
				SELECT
				
					
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
				
				FROM
					#Staging r
				WHERE (Minutes between @StartRange13 and @EndRange13)
				
				and
					currentreferraltypeid = 4
				
				AND	
				    ReferraldonorDeathdatetime <= calldatetime
				    
				AND
					(
						EyesTrans	IN ('Med RO','High Risk')
					OR	Bone		IN ('Med RO','High Risk')
					OR	Tissue		IN ('Med RO','High Risk')
					OR	Skin		IN ('Med RO','High Risk')
					OR	Valves		IN ('Med RO','High Risk')
					)
				AND
					(
						EyesRsch <> 'Yes'
					OR	EyesRsch IS NULL
					)
				GROUP BY
					Organizationname
			) AS x
		WHERE  #Results.OrganizationName = x.OrganizationName
		
--------------------------------------------------------------------------------
----------- Range 14 ------------
		
----Begin populating the table with the  major categories of the report's purpose.
	
--------------------------------------------------------------------------------

------------Insert Rows for Total Referrals-----------------------

UPDATE
	#Results
		SET
			TotalReferrals = x.cnt
		FROM
			(
			
				SELECT
				
					COUNT(distinct R.callid) AS Cnt,
					OrganizationName
					
				FROM
					#Staging r
					
				where (Minutes between @StartRange14 and @EndRange14)
				
							Group by Organizationname
				) AS x
				
				Where   #Results.OrganizationName = x.OrganizationName
-------------------------------------------------------------------------------

----Calculate the number of Referrals Without Initial CTOD-------TotalReferrals	

UPDATE
	#Results
		SET
			TotalNoCTOD = x.cnt
		FROM
			(
				SELECT
				
					
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
				
				FROM
					#Staging r
				WHERE(Minutes between @StartRange14 and @EndRange14)
			
					  and  (ReferraldonorDeathdatetime IS NULL 
					 OR ReferraldonorDeathdatetime >calldatetime)
					 
				Group by Organizationname
				) AS x
				
				Where #Results.OrganizationName = x.OrganizationName
--------------------------------------------------------------------------------

----Calculate the number of Referrals With Initial CTOD	

UPDATE
	#Results
		SET
			TotalCTOD = x.cnt
		FROM
			(
				SELECT
					
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
				FROM
					#Staging r
				WHERE(Minutes between @StartRange14 and @EndRange14)
			
				and	 ReferraldonorDeathdatetime <= calldatetime
					 
				Group by Organizationname
				) AS x
				
				Where  #Results.OrganizationName = x.OrganizationName
				
--------------------------------------------------------------------------------

----Calculate the number of Referrals where the Donor was a Registered Donor

UPDATE
	#Results
		SET
			TotalRegistered = x.cnt
		FROM
			(
				SELECT
				
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
				FROM
					#Staging r
				WHERE (Minutes between @StartRange14 and @EndRange14)
					
					and r.registrytypeid IN (1,2,4)
					and ReferraldonorDeathdatetime <= calldatetime
					
				Group by Organizationname
				) AS x
				
				Where #Results.OrganizationName = x.OrganizationName

--------------------------------------------------------------------------------
----Calculate the number of Tissue Referrals 

UPDATE
	#Results
		SET
			TotalTissue = x.cnt
		FROM
			(
				SELECT
					
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
				FROM
					#Staging r
				WHERE (Minutes between @StartRange14 and @EndRange14)
			
				and	R.ReferraldonorDeathdatetime <= calldatetime
					
				AND
					r.currentReferralTypeID = 2
				AND	
					(
						Organ <> 'Yes'
						or Organ is null
					
					)
				AND	
					(
						EyesTrans <> 'Yes'
						or EyesTrans is null
					
					)
				AND
					(
						Bone	= 'Yes'
					OR	Tissue	= 'Yes'
					OR	Skin	= 'Yes'
					OR	Valves	= 'Yes'
					)
				Group by Organizationname
			) AS x
		WHERE #Results.OrganizationName = x.OrganizationName
			
--------------------------------------------------------------------------------

----Calculate the number of Tissue/Eye Referrals

UPDATE
	#Results
		SET
			Total_TE = x.cnt
		FROM
			(
				SELECT
				
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
				FROM
					#Staging r
				WHERE (Minutes between @StartRange14 and @EndRange14)
			
				and	ReferraldonorDeathdatetime <= calldatetime
					
				AND
					R.currentreferraltypeid = 2
				AND	
					(
						Organ <> 'Yes'
					
					)
				AND	EyesTrans = 'Yes'
				AND
					(
						Bone	= 'Yes'
					OR	Tissue	= 'Yes'
					OR	Skin	= 'Yes'
					OR	Valves	= 'Yes'
					)
				GROUP BY
					Organizationname
			) AS x
		WHERE  #Results.OrganizationName = x.OrganizationName
			
------------------------------------------------------------------------------

----Calculate the number of Eye Referrals

UPDATE
	#Results
		SET
			TotalEyesOnly = x.cnt
		FROM
			(
				SELECT
				
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
			
				FROM
					#Staging r
				WHERE (Minutes between @StartRange14 and @EndRange14)
				
				and	r.currentreferraltypeid = 3
				
				AND	
				    ReferraldonorDeathdatetime <= calldatetime	
				    
				AND
					(
						Organ <> 'Yes'
						or Organ is null
					
					)
				AND		EyesTrans = 'Yes'
						or EyesTrans is null
				AND	
					(
						Bone <> 'Yes'
						or Bone is null
					)
				AND	
					(
						Tissue	<> 'Yes'
						or Tissue is null
					)
				AND	
					(
						Skin <> 'Yes'
						or Skin is null
					)
				AND	
					(
						Valves	<> 'Yes'
						or Valves is null
					)
				AND
					(
						EyesRsch	<> 'Yes'
						or EyesRsch is null
					
					)
				GROUP BY
					Organizationname
			) AS x
		WHERE  #Results.OrganizationName = x.OrganizationName
				

--------------------------------------------------------------------------------

----Calculate the number of Other/Eye Referrals

UPDATE
	#Results
		SET
			TotalOtherEye = x.cnt
		FROM
			(
				SELECT
				
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
			
				FROM
					#Staging r
				WHERE (Minutes between @StartRange14 and @EndRange14)
			
				and	currentreferraltypeid IN (3,4)
				AND	
				    ReferraldonorDeathdatetime <= calldatetime	
				    
				AND
					(
						Organ <> 'Yes'
					OR	Organ IS NULL
					)
				AND		EyesTrans = 'Yes'
				AND	
					(
						Bone <> 'Yes'
					OR	Bone IS NULL
					)
				AND	
					(
						Tissue	<> 'Yes'
					OR	Tissue IS NULL
					)
				AND	
					(
						Skin <> 'Yes'
					OR	Skin IS NULL
					)
				AND	
					(
						Valves	<> 'Yes'
					OR	Valves IS NULL
					)
				AND		EyesRsch = 'Yes'
				GROUP BY
					Organizationname
			) AS x
		WHERE  #Results.OrganizationName = x.OrganizationName
--------------------------------------------------------------------------------

----Calculate the number of Other Referrals

UPDATE
	#Results
		SET
			TotalOther = x.cnt
		FROM
			(
				SELECT
				
					
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
				
				FROM
					#Staging r
				WHERE (Minutes between @StartRange14 and @EndRange14)
				
				and	
					currentreferraltypeid = 4
				
				AND	
				    ReferraldonorDeathdatetime <= calldatetime	
				    
				AND
					(
						Organ <> 'Yes'
					OR	Organ IS NULL
					)
				AND
					(
						EyesTrans <> 'Yes'
					OR	EyesTrans IS NULL
					)
				AND
					(
						Bone <> 'Yes'
					OR	Bone IS NULL
					)
				AND	
					(
						Tissue	<> 'Yes'
					OR	Tissue IS NULL
					)
				AND	
					(
						Skin <> 'Yes'
					OR	Skin IS NULL
					)
				AND	
					(
						Valves	<> 'Yes'
					OR	Valves IS NULL
					)
				AND		EyesRsch = 'Yes'
				GROUP BY
					Organizationname
			) AS x
		WHERE #Results.OrganizationName = x.OrganizationName
--------------------------------------------------------------------------------

----Calculate the number of Age Rule Out Referrals

UPDATE
	#Results
		SET
			TotalAgeRO = x.cnt
		FROM
			(
				SELECT
				
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
				
				FROM
					#Staging r
				WHERE (Minutes between @StartRange14 and @EndRange14)
				
				and	
					currentreferraltypeid = 4
				
				AND	
				    ReferraldonorDeathdatetime <= calldatetime	
				    
				AND
					(
						EyesTrans NOT IN ('Med RO','High Risk')
					OR	EyesTrans IS NULL
					)
				AND
					(
						Bone NOT IN ('Med RO','High Risk')
					OR	Bone IS NULL
					)
				AND	
					(
						Tissue NOT IN ('Med RO','High Risk')
					OR	Tissue IS NULL
					)
				AND	
					(
						Skin NOT IN ('Med RO','High Risk')
					OR	Skin IS NULL
					)
				AND	
					(
						Valves NOT IN ('Med RO','High Risk')
					OR	Valves IS NULL
					)
				AND
					(
						EyesRsch <> 'Yes'
					OR	EyesRsch IS NULL
					)
				GROUP BY
					Organizationname
			) AS x
		WHERE  #Results.OrganizationName = x.OrganizationName
		
--------------------------------------------------------------------------------

----Calculate the number of Medical Rule Out Referrals

UPDATE
	#Results
		SET
			TotalMedRO = x.cnt
		FROM
			(
				SELECT
				
					
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
			
				FROM
					#Staging r
				WHERE (Minutes between @StartRange14 and @EndRange14)
				
				and
					currentreferraltypeid = 4
				
				AND	
				    ReferraldonorDeathdatetime <= calldatetime
				    
				AND
					(
						EyesTrans	IN ('Med RO','High Risk')
					OR	Bone		IN ('Med RO','High Risk')
					OR	Tissue		IN ('Med RO','High Risk')
					OR	Skin		IN ('Med RO','High Risk')
					OR	Valves		IN ('Med RO','High Risk')
					)
				AND
					(
						EyesRsch <> 'Yes'
					OR	EyesRsch IS NULL
					)
				GROUP BY
					Organizationname
			) AS x
		WHERE  #Results.OrganizationName = x.OrganizationName
		

----------------------------------------------------------------------------------------------------------------------------------
--------------- Range 15 --------------
		
----Begin populating the table with the  major categories of the report's purpose.
	
--------------------------------------------------------------------------------

------------Insert Rows for Total Referrals-----------------------

UPDATE
	#Results
		SET
			TotalReferrals = x.cnt
		FROM
			(
			
				SELECT
				
					COUNT(distinct R.callid) AS Cnt,
					OrganizationName
					
				FROM
					#Staging r
					
				where (Minutes between @StartRange15 and @EndRange15)
	
							Group by Organizationname--,ReferralDonorGender
				) AS x
				
				Where   #Results.OrganizationName = x.OrganizationName
-------------------------------------------------------------------------------

----Calculate the number of Referrals Without Initial CTOD-------TotalReferrals	

UPDATE
	#Results
		SET
			TotalNoCTOD = x.cnt
		FROM
			(
				SELECT
				
					
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
				
				FROM
					#Staging r
				WHERE(Minutes between @StartRange15 and @EndRange15)
					 
					  and  (ReferraldonorDeathdatetime IS NULL 
					 OR ReferraldonorDeathdatetime >calldatetime)
					 
				Group by Organizationname
				) AS x
				
				Where #Results.OrganizationName = x.OrganizationName
--------------------------------------------------------------------------------

----Calculate the number of Referrals With Initial CTOD	

UPDATE
	#Results
		SET
			TotalCTOD = x.cnt
		FROM
			(
				SELECT
					
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
				
				FROM
					#Staging r
				WHERE(Minutes between @StartRange15 and @EndRange15)
				
				and	 ReferraldonorDeathdatetime <= calldatetime
					 
				Group by Organizationname
				) AS x
				
				Where  #Results.OrganizationName = x.OrganizationName
				
--------------------------------------------------------------------------------

----Calculate the number of Referrals where the Donor was a Registered Donor

UPDATE
	#Results
		SET
			TotalRegistered = x.cnt
		FROM
			(
				SELECT
				
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
				FROM
					#Staging r
				WHERE (Minutes between @StartRange15 and @EndRange15)
				
					and r.registrytypeid IN (1,2,4)
					and ReferraldonorDeathdatetime <= calldatetime
					
				Group by Organizationname
				) AS x
				
				Where  #Results.OrganizationName = x.OrganizationName

--------------------------------------------------------------------------------
----Calculate the number of Tissue Referrals 

UPDATE
	#Results
		SET
			TotalTissue = x.cnt
		FROM
			(
				SELECT
					
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
				FROM
					#Staging r
				WHERE (Minutes between @StartRange15 and @EndRange15)
				
				and	R.ReferraldonorDeathdatetime <= calldatetime
					
				AND
					r.currentReferralTypeID = 2
				AND	
					(
						Organ <> 'Yes'
						or Organ is null
					
					)
				AND	
					(
						EyesTrans <> 'Yes'
						or EyesTrans is null
					
					)
				AND
					(
						Bone	= 'Yes'
					OR	Tissue	= 'Yes'
					OR	Skin	= 'Yes'
					OR	Valves	= 'Yes'
					)
				Group by Organizationname
			) AS x
		WHERE #Results.OrganizationName = x.OrganizationName
			
--------------------------------------------------------------------------------

----Calculate the number of Tissue/Eye Referrals

UPDATE
	#Results
		SET
			Total_TE = x.cnt
		FROM
			(
				SELECT
				
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
				
				FROM
					#Staging r
				WHERE (Minutes between @StartRange15 and @EndRange15)
				
				and	ReferraldonorDeathdatetime <= calldatetime
					
				AND
					R.currentreferraltypeid = 2
				AND	
					(
						Organ <> 'Yes'
					
					)
				AND	EyesTrans = 'Yes'
				AND
					(
						Bone	= 'Yes'
					OR	Tissue	= 'Yes'
					OR	Skin	= 'Yes'
					OR	Valves	= 'Yes'
					)
				GROUP BY
					Organizationname
			) AS x
		WHERE #Results.OrganizationName = x.OrganizationName
			
------------------------------------------------------------------------------

----Calculate the number of Eye Referrals

UPDATE
	#Results
		SET
			TotalEyesOnly = x.cnt
		FROM
			(
				SELECT
				
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
				FROM
					#Staging r
				WHERE (Minutes between @StartRange15 and @EndRange15)
			
				and	r.currentreferraltypeid = 3
				
				AND	
				    ReferraldonorDeathdatetime <= calldatetime	
				    
				AND
					(
						Organ <> 'Yes'
						or Organ is null
					
					)
				AND		EyesTrans = 'Yes'
						or EyesTrans is null
				AND	
					(
						Bone <> 'Yes'
						or Bone is null
					)
				AND	
					(
						Tissue	<> 'Yes'
						or Tissue is null
					)
				AND	
					(
						Skin <> 'Yes'
						or Skin is null
					)
				AND	
					(
						Valves	<> 'Yes'
						or Valves is null
					)
				AND
					(
						EyesRsch	<> 'Yes'
						or EyesRsch is null
					
					)
				GROUP BY
					Organizationname
			) AS x
		WHERE  #Results.OrganizationName = x.OrganizationName
				

--------------------------------------------------------------------------------

----Calculate the number of Other/Eye Referrals

UPDATE
	#Results
		SET
			TotalOtherEye = x.cnt
		FROM
			(
				SELECT
				
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
				FROM
					#Staging r
				WHERE (Minutes between @StartRange15 and @EndRange15)
				
				and	currentreferraltypeid IN (3,4)
				AND	
				    ReferraldonorDeathdatetime <= calldatetime	
				    
				AND
					(
						Organ <> 'Yes'
					OR	Organ IS NULL
					)
				AND		EyesTrans = 'Yes'
				AND	
					(
						Bone <> 'Yes'
					OR	Bone IS NULL
					)
				AND	
					(
						Tissue	<> 'Yes'
					OR	Tissue IS NULL
					)
				AND	
					(
						Skin <> 'Yes'
					OR	Skin IS NULL
					)
				AND	
					(
						Valves	<> 'Yes'
					OR	Valves IS NULL
					)
				AND		EyesRsch = 'Yes'
				GROUP BY
					Organizationname
			) AS x
		WHERE   #Results.OrganizationName = x.OrganizationName
--------------------------------------------------------------------------------

----Calculate the number of Other Referrals

UPDATE
	#Results
		SET
			TotalOther = x.cnt
		FROM
			(
				SELECT
				
					
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
				
				FROM
					#Staging r
				WHERE (Minutes between @StartRange15 and @EndRange15)
			
				and	
					currentreferraltypeid = 4
				
				AND	
				    ReferraldonorDeathdatetime <= calldatetime	
				    
				AND
					(
						Organ <> 'Yes'
					OR	Organ IS NULL
					)
				AND
					(
						EyesTrans <> 'Yes'
					OR	EyesTrans IS NULL
					)
				AND
					(
						Bone <> 'Yes'
					OR	Bone IS NULL
					)
				AND	
					(
						Tissue	<> 'Yes'
					OR	Tissue IS NULL
					)
				AND	
					(
						Skin <> 'Yes'
					OR	Skin IS NULL
					)
				AND	
					(
						Valves	<> 'Yes'
					OR	Valves IS NULL
					)
				AND		EyesRsch = 'Yes'
				GROUP BY
					Organizationname
			) AS x
		WHERE #Results.OrganizationName = x.OrganizationName
--------------------------------------------------------------------------------

----Calculate the number of Age Rule Out Referrals

UPDATE
	#Results
		SET
			TotalAgeRO = x.cnt
		FROM
			(
				SELECT
				
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
				
				FROM
					#Staging r
				WHERE (Minutes between @StartRange15 and @EndRange15)
				
				and	
					currentreferraltypeid = 4
				
				AND	
				    ReferraldonorDeathdatetime <= calldatetime	
				    
				AND
					(
						EyesTrans NOT IN ('Med RO','High Risk')
					OR	EyesTrans IS NULL
					)
				AND
					(
						Bone NOT IN ('Med RO','High Risk')
					OR	Bone IS NULL
					)
				AND	
					(
						Tissue NOT IN ('Med RO','High Risk')
					OR	Tissue IS NULL
					)
				AND	
					(
						Skin NOT IN ('Med RO','High Risk')
					OR	Skin IS NULL
					)
				AND	
					(
						Valves NOT IN ('Med RO','High Risk')
					OR	Valves IS NULL
					)
				AND
					(
						EyesRsch <> 'Yes'
					OR	EyesRsch IS NULL
					)
				GROUP BY
					Organizationname
			) AS x
		WHERE   #Results.OrganizationName = x.OrganizationName
		
--------------------------------------------------------------------------------

----Calculate the number of Medical Rule Out Referrals

UPDATE
	#Results
		SET
			TotalMedRO = x.cnt
		FROM
			(
				SELECT
				
					
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
				FROM
					#Staging r
				WHERE (Minutes between @StartRange15 and @EndRange15)
			
				and
					currentreferraltypeid = 4
				
				AND	
				    ReferraldonorDeathdatetime <= calldatetime
				    
				AND
					(
						EyesTrans	IN ('Med RO','High Risk')
					OR	Bone		IN ('Med RO','High Risk')
					OR	Tissue		IN ('Med RO','High Risk')
					OR	Skin		IN ('Med RO','High Risk')
					OR	Valves		IN ('Med RO','High Risk')
					)
				AND
					(
						EyesRsch <> 'Yes'
					OR	EyesRsch IS NULL
					)
				GROUP BY
					Organizationname
			) AS x
		WHERE   #Results.OrganizationName = x.OrganizationName
		
		
--------------------------------------------------------------------------------------------------------------------------------
--------- Range 16 -----------------
		
		
----Begin populating the table with the  major categories of the report's purpose.
	
--------------------------------------------------------------------------------

------------Insert Rows for Total Referrals-----------------------

UPDATE
	#Results
		SET
			TotalReferrals = x.cnt
		FROM
			(
			
				SELECT
				
					COUNT(distinct R.callid) AS Cnt,
					OrganizationName
				
				FROM
					#Staging r
					
				where (Minutes between @StartRange16 and @EndRange16)
			
							Group by Organizationname
				) AS x
				
				Where  #Results.OrganizationName = x.OrganizationName
-------------------------------------------------------------------------------

----Calculate the number of Referrals Without Initial CTOD-------TotalReferrals	

UPDATE
	#Results
		SET
			TotalNoCTOD = x.cnt
		FROM
			(
				SELECT
				
					
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
				FROM
					#Staging r
				WHERE(Minutes between @StartRange16 and @EndRange16)
					 
					  and  (ReferraldonorDeathdatetime IS NULL 
					 OR ReferraldonorDeathdatetime >calldatetime)
					 
				Group by Organizationname
				) AS x
				
				Where #Results.OrganizationName = x.OrganizationName
--------------------------------------------------------------------------------

----Calculate the number of Referrals With Initial CTOD	

UPDATE
	#Results
		SET
			TotalCTOD = x.cnt
		FROM
			(
				SELECT
					
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
				
				FROM
					#Staging r
				WHERE(Minutes between @StartRange16 and @EndRange16)
				
				and	 ReferraldonorDeathdatetime <= calldatetime
					 
				Group by Organizationname
				) AS x
				
				Where  #Results.OrganizationName = x.OrganizationName
				
--------------------------------------------------------------------------------

----Calculate the number of Referrals where the Donor was a Registered Donor

UPDATE
	#Results
		SET
			TotalRegistered = x.cnt
		FROM
			(
				SELECT
				
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
				FROM
					#Staging r
				WHERE (Minutes between @StartRange16 and @EndRange16)
					
					and r.registrytypeid IN (1,2,4)
					and ReferraldonorDeathdatetime <= calldatetime
					
				Group by Organizationname
				) AS x
				
				Where #Results.OrganizationName = x.OrganizationName

--------------------------------------------------------------------------------
----Calculate the number of Tissue Referrals 

UPDATE
	#Results
		SET
			TotalTissue = x.cnt
		FROM
			(
				SELECT
					
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
				FROM
					#Staging r
				WHERE (Minutes between @StartRange16 and @EndRange16)
				
				and	R.ReferraldonorDeathdatetime <= calldatetime
					
				AND
					r.currentReferralTypeID = 2
				AND	
					(
						Organ <> 'Yes'
						or Organ is null
					
					)
				AND	
					(
						EyesTrans <> 'Yes'
						or EyesTrans is null
					
					)
				AND
					(
						Bone	= 'Yes'
					OR	Tissue	= 'Yes'
					OR	Skin	= 'Yes'
					OR	Valves	= 'Yes'
					)
				Group by Organizationname
			) AS x
		WHERE #Results.OrganizationName = x.OrganizationName
			
--------------------------------------------------------------------------------

----Calculate the number of Tissue/Eye Referrals

UPDATE
	#Results
		SET
			Total_TE = x.cnt
		FROM
			(
				SELECT
				
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
				FROM
					#Staging r
				WHERE (Minutes between @StartRange16 and @EndRange16)
				
				and	ReferraldonorDeathdatetime <= calldatetime
					
				AND
					R.currentreferraltypeid = 2
				AND	
					(
						Organ <> 'Yes'
					
					)
				AND	EyesTrans = 'Yes'
				AND
					(
						Bone	= 'Yes'
					OR	Tissue	= 'Yes'
					OR	Skin	= 'Yes'
					OR	Valves	= 'Yes'
					)
				GROUP BY
					Organizationname
			) AS x
		WHERE  #Results.OrganizationName = x.OrganizationName
			
------------------------------------------------------------------------------

----Calculate the number of Eye Referrals

UPDATE
	#Results
		SET
			TotalEyesOnly = x.cnt
		FROM
			(
				SELECT
				
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
				
				FROM
					#Staging r
				WHERE (Minutes between @StartRange16 and @EndRange16)
				and ReferralDonorgender = ReferralDonorGender
				
				and	r.currentreferraltypeid = 3
				
				AND	
				    ReferraldonorDeathdatetime <= calldatetime	
				    
				AND
					(
						Organ <> 'Yes'
						or Organ is null
					
					)
				AND		EyesTrans = 'Yes'
						or EyesTrans is null
				AND	
					(
						Bone <> 'Yes'
						or Bone is null
					)
				AND	
					(
						Tissue	<> 'Yes'
						or Tissue is null
					)
				AND	
					(
						Skin <> 'Yes'
						or Skin is null
					)
				AND	
					(
						Valves	<> 'Yes'
						or Valves is null
					)
				AND
					(
						EyesRsch	<> 'Yes'
						or EyesRsch is null
					
					)
				GROUP BY
					Organizationname
			) AS x
		WHERE  #Results.OrganizationName = x.OrganizationName
				

--------------------------------------------------------------------------------

----Calculate the number of Other/Eye Referrals

UPDATE
	#Results
		SET
			TotalOtherEye = x.cnt
		FROM
			(
				SELECT
				
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
				FROM
					#Staging r
				WHERE (Minutes between @StartRange16 and @EndRange16)
				
				and	currentreferraltypeid IN (3,4)
				AND	
				    ReferraldonorDeathdatetime <= calldatetime	
				    
				AND
					(
						Organ <> 'Yes'
					OR	Organ IS NULL
					)
				AND		EyesTrans = 'Yes'
				AND	
					(
						Bone <> 'Yes'
					OR	Bone IS NULL
					)
				AND	
					(
						Tissue	<> 'Yes'
					OR	Tissue IS NULL
					)
				AND	
					(
						Skin <> 'Yes'
					OR	Skin IS NULL
					)
				AND	
					(
						Valves	<> 'Yes'
					OR	Valves IS NULL
					)
				AND		EyesRsch = 'Yes'
				GROUP BY
					Organizationname
			) AS x
		WHERE  #Results.OrganizationName = x.OrganizationName
--------------------------------------------------------------------------------

----Calculate the number of Other Referrals

UPDATE
	#Results
		SET
			TotalOther = x.cnt
		FROM
			(
				SELECT
				
					
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
				FROM
					#Staging r
				WHERE (Minutes between @StartRange16 and @EndRange16)
				
				and	
					currentreferraltypeid = 4
				
				AND	
				    ReferraldonorDeathdatetime <= calldatetime	
				    
				AND
					(
						Organ <> 'Yes'
					OR	Organ IS NULL
					)
				AND
					(
						EyesTrans <> 'Yes'
					OR	EyesTrans IS NULL
					)
				AND
					(
						Bone <> 'Yes'
					OR	Bone IS NULL
					)
				AND	
					(
						Tissue	<> 'Yes'
					OR	Tissue IS NULL
					)
				AND	
					(
						Skin <> 'Yes'
					OR	Skin IS NULL
					)
				AND	
					(
						Valves	<> 'Yes'
					OR	Valves IS NULL
					)
				AND		EyesRsch = 'Yes'
				GROUP BY
					Organizationname
			) AS x
		WHERE #Results.OrganizationName = x.OrganizationName
--------------------------------------------------------------------------------

----Calculate the number of Age Rule Out Referrals

UPDATE
	#Results
		SET
			TotalAgeRO = x.cnt
		FROM
			(
				SELECT
				
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
				FROM
					#Staging r
				WHERE (Minutes between @StartRange16 and @EndRange16)
				
				and	
					currentreferraltypeid = 4
				
				AND	
				    ReferraldonorDeathdatetime <= calldatetime	
				    
				AND
					(
						EyesTrans NOT IN ('Med RO','High Risk')
					OR	EyesTrans IS NULL
					)
				AND
					(
						Bone NOT IN ('Med RO','High Risk')
					OR	Bone IS NULL
					)
				AND	
					(
						Tissue NOT IN ('Med RO','High Risk')
					OR	Tissue IS NULL
					)
				AND	
					(
						Skin NOT IN ('Med RO','High Risk')
					OR	Skin IS NULL
					)
				AND	
					(
						Valves NOT IN ('Med RO','High Risk')
					OR	Valves IS NULL
					)
				AND
					(
						EyesRsch <> 'Yes'
					OR	EyesRsch IS NULL
					)
				GROUP BY
					Organizationname
			) AS x
		WHERE  #Results.OrganizationName = x.OrganizationName
		
--------------------------------------------------------------------------------

----Calculate the number of Medical Rule Out Referrals

UPDATE
	#Results
		SET
			TotalMedRO = x.cnt
		FROM
			(
				SELECT
				
					
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
			
				FROM
					#Staging r
				WHERE (Minutes between @StartRange16 and @EndRange16)
			
				and
					currentreferraltypeid = 4
				
				AND	
				    ReferraldonorDeathdatetime <= calldatetime
				    
				AND
					(
						EyesTrans	IN ('Med RO','High Risk')
					OR	Bone		IN ('Med RO','High Risk')
					OR	Tissue		IN ('Med RO','High Risk')
					OR	Skin		IN ('Med RO','High Risk')
					OR	Valves		IN ('Med RO','High Risk')
					)
				AND
					(
						EyesRsch <> 'Yes'
					OR	EyesRsch IS NULL
					)
				GROUP BY
					Organizationname
			) AS x
		WHERE  #Results.OrganizationName = x.OrganizationName
		

----------------------------------------------------------------------------------------------------------------------------------
------------ Range 17 ---------------
		
----Begin populating the table with the  major categories of the report's purpose.
	
--------------------------------------------------------------------------------

------------Insert Rows for Total Referrals-----------------------

UPDATE
	#Results
		SET
			TotalReferrals = x.cnt
		FROM
			(
			
				SELECT
				
					COUNT(distinct R.callid) AS Cnt,
					OrganizationName
				
				FROM
					#Staging r
					
				where (Minutes between @StartRange17 and @EndRange17)
							
							Group by Organizationname
				) AS x
				
				Where #Results.OrganizationName = x.OrganizationName
-------------------------------------------------------------------------------

----Calculate the number of Referrals Without Initial CTOD-------TotalReferrals	

UPDATE
	#Results
		SET
			TotalNoCTOD = x.cnt
		FROM
			(
				SELECT
				
					
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
				FROM
					#Staging r
				WHERE(Minutes between @StartRange17 and @EndRange17)
				 
					  and  (ReferraldonorDeathdatetime IS NULL 
					 OR ReferraldonorDeathdatetime >calldatetime)
					 
				Group by Organizationname
				) AS x
				
				Where #Results.OrganizationName = x.OrganizationName
--------------------------------------------------------------------------------

----Calculate the number of Referrals With Initial CTOD	

UPDATE
	#Results
		SET
			TotalCTOD = x.cnt
		FROM
			(
				SELECT
					
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
				
				FROM
					#Staging r
				WHERE(Minutes between @StartRange17 and @EndRange17)
			
				and	 ReferraldonorDeathdatetime <= calldatetime
					 
				Group by Organizationname
				) AS x
				
				Where #Results.OrganizationName = x.OrganizationName
				
--------------------------------------------------------------------------------

----Calculate the number of Referrals where the Donor was a Registered Donor

UPDATE
	#Results
		SET
			TotalRegistered = x.cnt
		FROM
			(
				SELECT
				
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
				
				FROM
					#Staging r
				WHERE (Minutes between @StartRange17 and @EndRange17)
				
					and r.registrytypeid IN (1,2,4)
					and ReferraldonorDeathdatetime <= calldatetime
					
				Group by Organizationname
				) AS x
				
				Where  #Results.OrganizationName = x.OrganizationName

--------------------------------------------------------------------------------
----Calculate the number of Tissue Referrals 

UPDATE
	#Results
		SET
			TotalTissue = x.cnt
		FROM
			(
				SELECT
					
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
				FROM
					#Staging r
				WHERE (Minutes between @StartRange17 and @EndRange17)
				
				and	R.ReferraldonorDeathdatetime <= calldatetime
					
				AND
					r.currentReferralTypeID = 2
				AND	
					(
						Organ <> 'Yes'
						or Organ is null
					
					)
				AND	
					(
						EyesTrans <> 'Yes'
						or EyesTrans is null
					
					)
				AND
					(
						Bone	= 'Yes'
					OR	Tissue	= 'Yes'
					OR	Skin	= 'Yes'
					OR	Valves	= 'Yes'
					)
				Group by Organizationname
			) AS x
		WHERE #Results.OrganizationName = x.OrganizationName
			
--------------------------------------------------------------------------------

----Calculate the number of Tissue/Eye Referrals

UPDATE
	#Results
		SET
			Total_TE = x.cnt
		FROM
			(
				SELECT
				
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
				FROM
					#Staging r
				WHERE (Minutes between @StartRange17 and @EndRange17)
				
				and	ReferraldonorDeathdatetime <= calldatetime
					
				AND
					R.currentreferraltypeid = 2
				AND	
					(
						Organ <> 'Yes'
					
					)
				AND	EyesTrans = 'Yes'
				AND
					(
						Bone	= 'Yes'
					OR	Tissue	= 'Yes'
					OR	Skin	= 'Yes'
					OR	Valves	= 'Yes'
					)
				GROUP BY
					Organizationname
			) AS x
		WHERE  #Results.OrganizationName = x.OrganizationName
			
------------------------------------------------------------------------------

----Calculate the number of Eye Referrals

UPDATE
	#Results
		SET
			TotalEyesOnly = x.cnt
		FROM
			(
				SELECT
				
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
				
				FROM
					#Staging r
				WHERE (Minutes between @StartRange17 and @EndRange17)
			
				and	r.currentreferraltypeid = 3
				
				AND	
				    ReferraldonorDeathdatetime <= calldatetime	
				    
				AND
					(
						Organ <> 'Yes'
						or Organ is null
					
					)
				AND		EyesTrans = 'Yes'
						or EyesTrans is null
				AND	
					(
						Bone <> 'Yes'
						or Bone is null
					)
				AND	
					(
						Tissue	<> 'Yes'
						or Tissue is null
					)
				AND	
					(
						Skin <> 'Yes'
						or Skin is null
					)
				AND	
					(
						Valves	<> 'Yes'
						or Valves is null
					)
				AND
					(
						EyesRsch	<> 'Yes'
						or EyesRsch is null
					
					)
				GROUP BY
					Organizationname
			) AS x
		WHERE #Results.OrganizationName = x.OrganizationName
				

--------------------------------------------------------------------------------

----Calculate the number of Other/Eye Referrals

UPDATE
	#Results
		SET
			TotalOtherEye = x.cnt
		FROM
			(
				SELECT
				
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
			
				FROM
					#Staging r
				WHERE (Minutes between @StartRange17 and @EndRange17)
				
				and	currentreferraltypeid IN (3,4)
				AND	
				    ReferraldonorDeathdatetime <= calldatetime	
				    
				AND
					(
						Organ <> 'Yes'
					OR	Organ IS NULL
					)
				AND		EyesTrans = 'Yes'
				AND	
					(
						Bone <> 'Yes'
					OR	Bone IS NULL
					)
				AND	
					(
						Tissue	<> 'Yes'
					OR	Tissue IS NULL
					)
				AND	
					(
						Skin <> 'Yes'
					OR	Skin IS NULL
					)
				AND	
					(
						Valves	<> 'Yes'
					OR	Valves IS NULL
					)
				AND		EyesRsch = 'Yes'
				GROUP BY
					Organizationname
			) AS x
		WHERE  #Results.OrganizationName = x.OrganizationName
--------------------------------------------------------------------------------

----Calculate the number of Other Referrals

UPDATE
	#Results
		SET
			TotalOther = x.cnt
		FROM
			(
				SELECT
				
					
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
				
				FROM
					#Staging r
				WHERE (Minutes between @StartRange17 and @EndRange17)
				
				and	
					currentreferraltypeid = 4
				
				AND	
				    ReferraldonorDeathdatetime <= calldatetime	
				    
				AND
					(
						Organ <> 'Yes'
					OR	Organ IS NULL
					)
				AND
					(
						EyesTrans <> 'Yes'
					OR	EyesTrans IS NULL
					)
				AND
					(
						Bone <> 'Yes'
					OR	Bone IS NULL
					)
				AND	
					(
						Tissue	<> 'Yes'
					OR	Tissue IS NULL
					)
				AND	
					(
						Skin <> 'Yes'
					OR	Skin IS NULL
					)
				AND	
					(
						Valves	<> 'Yes'
					OR	Valves IS NULL
					)
				AND		EyesRsch = 'Yes'
				GROUP BY
					Organizationname
			) AS x
		WHERE  #Results.OrganizationName = x.OrganizationName
--------------------------------------------------------------------------------

----Calculate the number of Age Rule Out Referrals

UPDATE
	#Results
		SET
			TotalAgeRO = x.cnt
		FROM
			(
				SELECT
				
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
				
				FROM
					#Staging r
				WHERE (Minutes between @StartRange17 and @EndRange17)
				
				and	
					currentreferraltypeid = 4
				
				AND	
				    ReferraldonorDeathdatetime <= calldatetime	
				    
				AND
					(
						EyesTrans NOT IN ('Med RO','High Risk')
					OR	EyesTrans IS NULL
					)
				AND
					(
						Bone NOT IN ('Med RO','High Risk')
					OR	Bone IS NULL
					)
				AND	
					(
						Tissue NOT IN ('Med RO','High Risk')
					OR	Tissue IS NULL
					)
				AND	
					(
						Skin NOT IN ('Med RO','High Risk')
					OR	Skin IS NULL
					)
				AND	
					(
						Valves NOT IN ('Med RO','High Risk')
					OR	Valves IS NULL
					)
				AND
					(
						EyesRsch <> 'Yes'
					OR	EyesRsch IS NULL
					)
				GROUP BY
					Organizationname
			) AS x
		WHERE  #Results.OrganizationName = x.OrganizationName
		
--------------------------------------------------------------------------------

----Calculate the number of Medical Rule Out Referrals

UPDATE
	#Results
		SET
			TotalMedRO = x.cnt
		FROM
			(
				SELECT
				
					
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
				FROM
					#Staging r
				WHERE (Minutes between @StartRange17 and @EndRange17)
				
				and
					currentreferraltypeid = 4
				
				AND	
				    ReferraldonorDeathdatetime <= calldatetime
				    
				AND
					(
						EyesTrans	IN ('Med RO','High Risk')
					OR	Bone		IN ('Med RO','High Risk')
					OR	Tissue		IN ('Med RO','High Risk')
					OR	Skin		IN ('Med RO','High Risk')
					OR	Valves		IN ('Med RO','High Risk')
					)
				AND
					(
						EyesRsch <> 'Yes'
					OR	EyesRsch IS NULL
					)
				GROUP BY
					Organizationname
			) AS x
		WHERE  #Results.OrganizationName = x.OrganizationName
		

---------------------------------------------------------------------------------------------------------------------------------
---------------- Range 18 -------------------
		
----Begin populating the table with the  major categories of the report's purpose.
	
--------------------------------------------------------------------------------

------------Insert Rows for Total Referrals-----------------------

UPDATE
	#Results
		SET
			TotalReferrals = x.cnt
		FROM
			(
			
				SELECT
				
					COUNT(distinct R.callid) AS Cnt,
					OrganizationName
					
				FROM
					#Staging r
					
				where (Minutes between @StartRange18 and @EndRange18)
				
							Group by Organizationname
				) AS x
				
				Where  #Results.OrganizationName = x.OrganizationName
-------------------------------------------------------------------------------

----Calculate the number of Referrals Without Initial CTOD-------TotalReferrals	

UPDATE
	#Results
		SET
			TotalNoCTOD = x.cnt
		FROM
			(
				SELECT
				
					
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
				FROM
					#Staging r
				WHERE(Minutes between @StartRange18 and @EndRange18)
				 
					  and  (ReferraldonorDeathdatetime IS NULL 
					 OR ReferraldonorDeathdatetime >calldatetime)
					 
				Group by Organizationname
				) AS x
				
				Where  #Results.OrganizationName = x.OrganizationName
--------------------------------------------------------------------------------

----Calculate the number of Referrals With Initial CTOD	

UPDATE
	#Results
		SET
			TotalCTOD = x.cnt
		FROM
			(
				SELECT
					
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
				FROM
					#Staging r
				WHERE(Minutes between @StartRange18 and @EndRange18)
				
				and	 ReferraldonorDeathdatetime <= calldatetime
					 
				Group by Organizationname
				) AS x
				
				Where  #Results.OrganizationName = x.OrganizationName
				
--------------------------------------------------------------------------------

----Calculate the number of Referrals where the Donor was a Registered Donor

UPDATE
	#Results
		SET
			TotalRegistered = x.cnt
		FROM
			(
				SELECT
				
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
				
				FROM
					#Staging r
				WHERE (Minutes between @StartRange18 and @EndRange18)
			
					and r.registrytypeid IN (1,2,4)
					and ReferraldonorDeathdatetime <= calldatetime
					
				Group by Organizationname
				) AS x
				
				Where  #Results.OrganizationName = x.OrganizationName

--------------------------------------------------------------------------------
----Calculate the number of Tissue Referrals 

UPDATE
	#Results
		SET
			TotalTissue = x.cnt
		FROM
			(
				SELECT
					
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
				FROM
					#Staging r
				WHERE (Minutes between @StartRange18 and @EndRange18)
			
				and	R.ReferraldonorDeathdatetime <= calldatetime
					
				AND
					r.currentReferralTypeID = 2
				AND	
					(
						Organ <> 'Yes'
						or Organ is null
					
					)
				AND	
					(
						EyesTrans <> 'Yes'
						or EyesTrans is null
					
					)
				AND
					(
						Bone	= 'Yes'
					OR	Tissue	= 'Yes'
					OR	Skin	= 'Yes'
					OR	Valves	= 'Yes'
					)
				Group by Organizationname
			) AS x
		WHERE	#Results.OrganizationName = x.OrganizationName
			
--------------------------------------------------------------------------------

----Calculate the number of Tissue/Eye Referrals

UPDATE
	#Results
		SET
			Total_TE = x.cnt
		FROM
			(
				SELECT
				
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
			
				FROM
					#Staging r
				WHERE (Minutes between @StartRange18 and @EndRange18)
			
				and	ReferraldonorDeathdatetime <= calldatetime
					
				AND
					R.currentreferraltypeid = 2
				AND	
					(
						Organ <> 'Yes'
					
					)
				AND	EyesTrans = 'Yes'
				AND
					(
						Bone	= 'Yes'
					OR	Tissue	= 'Yes'
					OR	Skin	= 'Yes'
					OR	Valves	= 'Yes'
					)
				GROUP BY
					Organizationname
			) AS x
		WHERE  #Results.OrganizationName = x.OrganizationName
			
------------------------------------------------------------------------------

----Calculate the number of Eye Referrals

UPDATE
	#Results
		SET
			TotalEyesOnly = x.cnt
		FROM
			(
				SELECT
				
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
				
				FROM
					#Staging r
				WHERE (Minutes between @StartRange18 and @EndRange18)
				
				and	r.currentreferraltypeid = 3
				
				AND	
				    ReferraldonorDeathdatetime <= calldatetime	
				    
				AND
					(
						Organ <> 'Yes'
						or Organ is null
					
					)
				AND		EyesTrans = 'Yes'
						or EyesTrans is null
				AND	
					(
						Bone <> 'Yes'
						or Bone is null
					)
				AND	
					(
						Tissue	<> 'Yes'
						or Tissue is null
					)
				AND	
					(
						Skin <> 'Yes'
						or Skin is null
					)
				AND	
					(
						Valves	<> 'Yes'
						or Valves is null
					)
				AND
					(
						EyesRsch	<> 'Yes'
						or EyesRsch is null
					
					)
				GROUP BY
					Organizationname
			) AS x
		WHERE  #Results.OrganizationName = x.OrganizationName
				

--------------------------------------------------------------------------------

----Calculate the number of Other/Eye Referrals

UPDATE
	#Results
		SET
			TotalOtherEye = x.cnt
		FROM
			(
				SELECT
				
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
				
				FROM
					#Staging r
				WHERE (Minutes between @StartRange18 and @EndRange18)
				
				and	currentreferraltypeid IN (3,4)
				AND	
				    ReferraldonorDeathdatetime <= calldatetime	
				    
				AND
					(
						Organ <> 'Yes'
					OR	Organ IS NULL
					)
				AND		EyesTrans = 'Yes'
				AND	
					(
						Bone <> 'Yes'
					OR	Bone IS NULL
					)
				AND	
					(
						Tissue	<> 'Yes'
					OR	Tissue IS NULL
					)
				AND	
					(
						Skin <> 'Yes'
					OR	Skin IS NULL
					)
				AND	
					(
						Valves	<> 'Yes'
					OR	Valves IS NULL
					)
				AND		EyesRsch = 'Yes'
				GROUP BY
					Organizationname
			) AS x
		WHERE #Results.OrganizationName = x.OrganizationName
--------------------------------------------------------------------------------

----Calculate the number of Other Referrals

UPDATE
	#Results
		SET
			TotalOther = x.cnt
		FROM
			(
				SELECT
				
					
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
				
				FROM
					#Staging r
				WHERE (Minutes between @StartRange18 and @EndRange18)
				
				and	
					currentreferraltypeid = 4
				
				AND	
				    ReferraldonorDeathdatetime <= calldatetime	
				    
				AND
					(
						Organ <> 'Yes'
					OR	Organ IS NULL
					)
				AND
					(
						EyesTrans <> 'Yes'
					OR	EyesTrans IS NULL
					)
				AND
					(
						Bone <> 'Yes'
					OR	Bone IS NULL
					)
				AND	
					(
						Tissue	<> 'Yes'
					OR	Tissue IS NULL
					)
				AND	
					(
						Skin <> 'Yes'
					OR	Skin IS NULL
					)
				AND	
					(
						Valves	<> 'Yes'
					OR	Valves IS NULL
					)
				AND		EyesRsch = 'Yes'
				GROUP BY
					Organizationname
			) AS x
		WHERE  #Results.OrganizationName = x.OrganizationName
--------------------------------------------------------------------------------

----Calculate the number of Age Rule Out Referrals

UPDATE
	#Results
		SET
			TotalAgeRO = x.cnt
		FROM
			(
				SELECT
				
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
				
				FROM
					#Staging r
				WHERE (Minutes between @StartRange18 and @EndRange18)
				
				and	
					currentreferraltypeid = 4
				
				AND	
				    ReferraldonorDeathdatetime <= calldatetime	
				    
				AND
					(
						EyesTrans NOT IN ('Med RO','High Risk')
					OR	EyesTrans IS NULL
					)
				AND
					(
						Bone NOT IN ('Med RO','High Risk')
					OR	Bone IS NULL
					)
				AND	
					(
						Tissue NOT IN ('Med RO','High Risk')
					OR	Tissue IS NULL
					)
				AND	
					(
						Skin NOT IN ('Med RO','High Risk')
					OR	Skin IS NULL
					)
				AND	
					(
						Valves NOT IN ('Med RO','High Risk')
					OR	Valves IS NULL
					)
				AND
					(
						EyesRsch <> 'Yes'
					OR	EyesRsch IS NULL
					)
				GROUP BY
					Organizationname
			) AS x
		WHERE   #Results.OrganizationName = x.OrganizationName
		
--------------------------------------------------------------------------------

----Calculate the number of Medical Rule Out Referrals

UPDATE
	#Results
		SET
			TotalMedRO = x.cnt
		FROM
			(
				SELECT
				
					
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
				FROM
					#Staging r
				WHERE (Minutes between @StartRange18 and @EndRange18)
				
				and
					currentreferraltypeid = 4
				
				AND	
				    ReferraldonorDeathdatetime <= calldatetime
				    
				AND
					(
						EyesTrans	IN ('Med RO','High Risk')
					OR	Bone		IN ('Med RO','High Risk')
					OR	Tissue		IN ('Med RO','High Risk')
					OR	Skin		IN ('Med RO','High Risk')
					OR	Valves		IN ('Med RO','High Risk')
					)
				AND
					(
						EyesRsch <> 'Yes'
					OR	EyesRsch IS NULL
					)
				GROUP BY
					Organizationname
			) AS x
		WHERE   #Results.OrganizationName = x.OrganizationName
		

-----------------------------------------------------------------------------------------------------------------------------------
----------------- Range 19 ----------------

----Begin populating the table with the  major categories of the report's purpose.
	
--------------------------------------------------------------------------------

------------Insert Rows for Total Referrals-----------------------

UPDATE
	#Results
		SET
			TotalReferrals = x.cnt
		FROM
			(
			
				SELECT
				
					COUNT(distinct R.callid) AS Cnt,
					OrganizationName
				
				FROM
					#Staging r
					
				where (Minutes between @StartRange19 and @EndRange19)
				
							Group by Organizationname
				) AS x
				
				Where #Results.OrganizationName = x.OrganizationName
-------------------------------------------------------------------------------

----Calculate the number of Referrals Without Initial CTOD-------TotalReferrals	

UPDATE
	#Results
		SET
			TotalNoCTOD = x.cnt
		FROM
			(
				SELECT
				
					
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
				FROM
					#Staging r
				WHERE(Minutes between @StartRange19 and @EndRange19)
				 
					  and  (ReferraldonorDeathdatetime IS NULL 
					 OR ReferraldonorDeathdatetime >calldatetime)
					 
				Group by Organizationname
				) AS x
				
				Where  #Results.OrganizationName = x.OrganizationName
--------------------------------------------------------------------------------

----Calculate the number of Referrals With Initial CTOD	

UPDATE
	#Results
		SET
			TotalCTOD = x.cnt
		FROM
			(
				SELECT
					
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
				
				FROM
					#Staging r
				WHERE(Minutes between @StartRange19 and @EndRange19)
				
				and	 ReferraldonorDeathdatetime <= calldatetime
					 
				Group by Organizationname
				) AS x
				
				Where  #Results.OrganizationName = x.OrganizationName
				
--------------------------------------------------------------------------------

----Calculate the number of Referrals where the Donor was a Registered Donor

UPDATE
	#Results
		SET
			TotalRegistered = x.cnt
		FROM
			(
				SELECT
				
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
				FROM
					#Staging r
				WHERE (Minutes between @StartRange19 and @EndRange19)
				
					and r.registrytypeid IN (1,2,4)
					and ReferraldonorDeathdatetime <= calldatetime
					
				Group by Organizationname
				) AS x
				
				Where   #Results.OrganizationName = x.OrganizationName

--------------------------------------------------------------------------------
----Calculate the number of Tissue Referrals 

UPDATE
	#Results
		SET
			TotalTissue = x.cnt
		FROM
			(
				SELECT
					
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
				FROM
					#Staging r
				WHERE (Minutes between @StartRange19 and @EndRange19)
				
				and	R.ReferraldonorDeathdatetime <= calldatetime
					
				AND
					r.currentReferralTypeID = 2
				AND	
					(
						Organ <> 'Yes'
						or Organ is null
					
					)
				AND	
					(
						EyesTrans <> 'Yes'
						or EyesTrans is null
					
					)
				AND
					(
						Bone	= 'Yes'
					OR	Tissue	= 'Yes'
					OR	Skin	= 'Yes'
					OR	Valves	= 'Yes'
					)
				Group by Organizationname
			) AS x
		WHERE  #Results.OrganizationName = x.OrganizationName
			
--------------------------------------------------------------------------------

----Calculate the number of Tissue/Eye Referrals

UPDATE
	#Results
		SET
			Total_TE = x.cnt
		FROM
			(
				SELECT
				
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
				FROM
					#Staging r
				WHERE (Minutes between @StartRange19 and @EndRange19)
				
				and	ReferraldonorDeathdatetime <= calldatetime
					
				AND
					R.currentreferraltypeid = 2
				AND	
					(
						Organ <> 'Yes'
					
					)
				AND	EyesTrans = 'Yes'
				AND
					(
						Bone	= 'Yes'
					OR	Tissue	= 'Yes'
					OR	Skin	= 'Yes'
					OR	Valves	= 'Yes'
					)
				GROUP BY
					Organizationname
			) AS x
		WHERE  #Results.OrganizationName = x.OrganizationName
			
------------------------------------------------------------------------------

----Calculate the number of Eye Referrals

UPDATE
	#Results
		SET
			TotalEyesOnly = x.cnt
		FROM
			(
				SELECT
				
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
				FROM
					#Staging r
				WHERE (Minutes between @StartRange19 and @EndRange19)
			
				and	r.currentreferraltypeid = 3
				
				AND	
				    ReferraldonorDeathdatetime <= calldatetime	
				    
				AND
					(
						Organ <> 'Yes'
						or Organ is null
					
					)
				AND		EyesTrans = 'Yes'
						or EyesTrans is null
				AND	
					(
						Bone <> 'Yes'
						or Bone is null
					)
				AND	
					(
						Tissue	<> 'Yes'
						or Tissue is null
					)
				AND	
					(
						Skin <> 'Yes'
						or Skin is null
					)
				AND	
					(
						Valves	<> 'Yes'
						or Valves is null
					)
				AND
					(
						EyesRsch	<> 'Yes'
						or EyesRsch is null
					
					)
				GROUP BY
					Organizationname
			) AS x
		WHERE #Results.OrganizationName = x.OrganizationName
				

--------------------------------------------------------------------------------

----Calculate the number of Other/Eye Referrals

UPDATE
	#Results
		SET
			TotalOtherEye = x.cnt
		FROM
			(
				SELECT
				
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
				FROM
					#Staging r
				WHERE (Minutes between @StartRange19 and @EndRange19)
			
				and	currentreferraltypeid IN (3,4)
				AND	
				    ReferraldonorDeathdatetime <= calldatetime	
				    
				AND
					(
						Organ <> 'Yes'
					OR	Organ IS NULL
					)
				AND		EyesTrans = 'Yes'
				AND	
					(
						Bone <> 'Yes'
					OR	Bone IS NULL
					)
				AND	
					(
						Tissue	<> 'Yes'
					OR	Tissue IS NULL
					)
				AND	
					(
						Skin <> 'Yes'
					OR	Skin IS NULL
					)
				AND	
					(
						Valves	<> 'Yes'
					OR	Valves IS NULL
					)
				AND		EyesRsch = 'Yes'
				GROUP BY
					Organizationname
			) AS x
		WHERE   #Results.OrganizationName = x.OrganizationName
--------------------------------------------------------------------------------

----Calculate the number of Other Referrals

UPDATE
	#Results
		SET
			TotalOther = x.cnt
		FROM
			(
				SELECT
				
					
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
				
				FROM
					#Staging r
				WHERE (Minutes between @StartRange19 and @EndRange19)
				
				and	
					currentreferraltypeid = 4
				
				AND	
				    ReferraldonorDeathdatetime <= calldatetime	
				    
				AND
					(
						Organ <> 'Yes'
					OR	Organ IS NULL
					)
				AND
					(
						EyesTrans <> 'Yes'
					OR	EyesTrans IS NULL
					)
				AND
					(
						Bone <> 'Yes'
					OR	Bone IS NULL
					)
				AND	
					(
						Tissue	<> 'Yes'
					OR	Tissue IS NULL
					)
				AND	
					(
						Skin <> 'Yes'
					OR	Skin IS NULL
					)
				AND	
					(
						Valves	<> 'Yes'
					OR	Valves IS NULL
					)
				AND		EyesRsch = 'Yes'
				GROUP BY
					Organizationname
			) AS x
		WHERE #Results.OrganizationName = x.OrganizationName
--------------------------------------------------------------------------------

----Calculate the number of Age Rule Out Referrals

UPDATE
	#Results
		SET
			TotalAgeRO = x.cnt
		FROM
			(
				SELECT
				
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
				FROM
					#Staging r
				WHERE (Minutes between @StartRange19 and @EndRange19)
				
				and	
					currentreferraltypeid = 4
				
				AND	
				    ReferraldonorDeathdatetime <= calldatetime	
				    
				AND
					(
						EyesTrans NOT IN ('Med RO','High Risk')
					OR	EyesTrans IS NULL
					)
				AND
					(
						Bone NOT IN ('Med RO','High Risk')
					OR	Bone IS NULL
					)
				AND	
					(
						Tissue NOT IN ('Med RO','High Risk')
					OR	Tissue IS NULL
					)
				AND	
					(
						Skin NOT IN ('Med RO','High Risk')
					OR	Skin IS NULL
					)
				AND	
					(
						Valves NOT IN ('Med RO','High Risk')
					OR	Valves IS NULL
					)
				AND
					(
						EyesRsch <> 'Yes'
					OR	EyesRsch IS NULL
					)
				GROUP BY
					Organizationname
			) AS x
		WHERE  #Results.OrganizationName = x.OrganizationName
		
--------------------------------------------------------------------------------

----Calculate the number of Medical Rule Out Referrals

UPDATE
	#Results
		SET
			TotalMedRO = x.cnt
		FROM
			(
				SELECT
				
					
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
				FROM
					#Staging r
				WHERE (Minutes between @StartRange19 and @EndRange19)
				
				and
					currentreferraltypeid = 4
				
				AND	
				    ReferraldonorDeathdatetime <= calldatetime
				    
				AND
					(
						EyesTrans	IN ('Med RO','High Risk')
					OR	Bone		IN ('Med RO','High Risk')
					OR	Tissue		IN ('Med RO','High Risk')
					OR	Skin		IN ('Med RO','High Risk')
					OR	Valves		IN ('Med RO','High Risk')
					)
				AND
					(
						EyesRsch <> 'Yes'
					OR	EyesRsch IS NULL
					)
				GROUP BY
					Organizationname
			) AS x
		WHERE  #Results.OrganizationName = x.OrganizationName
		

-----------------------------------------------------------------------------------------------------------------------------------
------------- Range 20 ------------
----Begin populating the table with the  major categories of the report's purpose.
	
--------------------------------------------------------------------------------

------------Insert Rows for Total Referrals-----------------------

UPDATE
	#Results
		SET
			TotalReferrals = x.cnt
		FROM
			(
			
				SELECT
				
					COUNT(distinct R.callid) AS Cnt,
					OrganizationName
					
				FROM
					#Staging r
					
				where (Minutes between @StartRange20 and @EndRange20)
			
							Group by Organizationname
				) AS x
				
				Where   #Results.OrganizationName = x.OrganizationName
-------------------------------------------------------------------------------

----Calculate the number of Referrals Without Initial CTOD-------TotalReferrals	

UPDATE
	#Results
		SET
			TotalNoCTOD = x.cnt
		FROM
			(
				SELECT
				
					
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
				
				FROM
					#Staging r
				WHERE(Minutes between @StartRange20 and @EndRange20)
				 
					  and  (ReferraldonorDeathdatetime IS NULL 
					 OR ReferraldonorDeathdatetime >calldatetime)
					 
				Group by Organizationname
				) AS x
				
				Where  #Results.OrganizationName = x.OrganizationName
--------------------------------------------------------------------------------

----Calculate the number of Referrals With Initial CTOD	

UPDATE
	#Results
		SET
			TotalCTOD = x.cnt
		FROM
			(
				SELECT
					
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
				
				FROM
					#Staging r
				WHERE(Minutes between @StartRange20 and @EndRange20)
				
				and	 ReferraldonorDeathdatetime <= calldatetime
					 
				Group by Organizationname
				) AS x
				
				Where  #Results.OrganizationName = x.OrganizationName
				
--------------------------------------------------------------------------------

----Calculate the number of Referrals where the Donor was a Registered Donor

UPDATE
	#Results
		SET
			TotalRegistered = x.cnt
		FROM
			(
				SELECT
				
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
				FROM
					#Staging r
				WHERE (Minutes between @StartRange20 and @EndRange20)
					
					and r.registrytypeid IN (1,2,4)
					and ReferraldonorDeathdatetime <= calldatetime
					
				Group by Organizationname
				) AS x
				
				Where  #Results.OrganizationName = x.OrganizationName

--------------------------------------------------------------------------------
----Calculate the number of Tissue Referrals 

UPDATE
	#Results
		SET
			TotalTissue = x.cnt
		FROM
			(
				SELECT
					
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
				FROM
					#Staging r
				WHERE (Minutes between @StartRange20 and @EndRange20)
				
				and	R.ReferraldonorDeathdatetime <= calldatetime
					
				AND
					r.currentReferralTypeID = 2
				AND	
					(
						Organ <> 'Yes'
						or Organ is null
					
					)
				AND	
					(
						EyesTrans <> 'Yes'
						or EyesTrans is null
					
					)
				AND
					(
						Bone	= 'Yes'
					OR	Tissue	= 'Yes'
					OR	Skin	= 'Yes'
					OR	Valves	= 'Yes'
					)
				Group by Organizationname
			) AS x
		WHERE  #Results.OrganizationName = x.OrganizationName
			
--------------------------------------------------------------------------------

----Calculate the number of Tissue/Eye Referrals

UPDATE
	#Results
		SET
			Total_TE = x.cnt
		FROM
			(
				SELECT
				
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
				FROM
					#Staging r
				WHERE (Minutes between @StartRange20 and @EndRange20)
			
				and	ReferraldonorDeathdatetime <= calldatetime
					
				AND
					R.currentreferraltypeid = 2
				AND	
					(
						Organ <> 'Yes'
					
					)
				AND	EyesTrans = 'Yes'
				AND
					(
						Bone	= 'Yes'
					OR	Tissue	= 'Yes'
					OR	Skin	= 'Yes'
					OR	Valves	= 'Yes'
					)
				GROUP BY
					Organizationname
			) AS x
		WHERE  #Results.OrganizationName = x.OrganizationName
			
------------------------------------------------------------------------------

----Calculate the number of Eye Referrals

UPDATE
	#Results
		SET
			TotalEyesOnly = x.cnt
		FROM
			(
				SELECT
				
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
				FROM
					#Staging r
				WHERE (Minutes between @StartRange20 and @EndRange20)
				
				and	r.currentreferraltypeid = 3
				
				AND	
				    ReferraldonorDeathdatetime <= calldatetime	
				    
				AND
					(
						Organ <> 'Yes'
						or Organ is null
					
					)
				AND		EyesTrans = 'Yes'
						or EyesTrans is null
				AND	
					(
						Bone <> 'Yes'
						or Bone is null
					)
				AND	
					(
						Tissue	<> 'Yes'
						or Tissue is null
					)
				AND	
					(
						Skin <> 'Yes'
						or Skin is null
					)
				AND	
					(
						Valves	<> 'Yes'
						or Valves is null
					)
				AND
					(
						EyesRsch	<> 'Yes'
						or EyesRsch is null
					
					)
				GROUP BY
					Organizationname
			) AS x
		WHERE   #Results.OrganizationName = x.OrganizationName
				

--------------------------------------------------------------------------------

----Calculate the number of Other/Eye Referrals

UPDATE
	#Results
		SET
			TotalOtherEye = x.cnt
		FROM
			(
				SELECT
				
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
				FROM
					#Staging r
				WHERE (Minutes between @StartRange20 and @EndRange20)
				
				and	currentreferraltypeid IN (3,4)
				AND	
				    ReferraldonorDeathdatetime <= calldatetime	
				    
				AND
					(
						Organ <> 'Yes'
					OR	Organ IS NULL
					)
				AND		EyesTrans = 'Yes'
				AND	
					(
						Bone <> 'Yes'
					OR	Bone IS NULL
					)
				AND	
					(
						Tissue	<> 'Yes'
					OR	Tissue IS NULL
					)
				AND	
					(
						Skin <> 'Yes'
					OR	Skin IS NULL
					)
				AND	
					(
						Valves	<> 'Yes'
					OR	Valves IS NULL
					)
				AND		EyesRsch = 'Yes'
				GROUP BY
					Organizationname
			) AS x
		WHERE  #Results.OrganizationName = x.OrganizationName
--------------------------------------------------------------------------------

----Calculate the number of Other Referrals

UPDATE
	#Results
		SET
			TotalOther = x.cnt
		FROM
			(
				SELECT
				
					
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
				FROM
					#Staging r
				WHERE (Minutes between @StartRange20 and @EndRange20)
				
				and	
					currentreferraltypeid = 4
				
				AND	
				    ReferraldonorDeathdatetime <= calldatetime	
				    
				AND
					(
						Organ <> 'Yes'
					OR	Organ IS NULL
					)
				AND
					(
						EyesTrans <> 'Yes'
					OR	EyesTrans IS NULL
					)
				AND
					(
						Bone <> 'Yes'
					OR	Bone IS NULL
					)
				AND	
					(
						Tissue	<> 'Yes'
					OR	Tissue IS NULL
					)
				AND	
					(
						Skin <> 'Yes'
					OR	Skin IS NULL
					)
				AND	
					(
						Valves	<> 'Yes'
					OR	Valves IS NULL
					)
				AND		EyesRsch = 'Yes'
				GROUP BY
					Organizationname
			) AS x
		WHERE #Results.OrganizationName = x.OrganizationName
--------------------------------------------------------------------------------

----Calculate the number of Age Rule Out Referrals

UPDATE
	#Results
		SET
			TotalAgeRO = x.cnt
		FROM
			(
				SELECT
				
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
					
				FROM
					#Staging r
				WHERE (Minutes between @StartRange20 and @EndRange20)
				
				and	
					currentreferraltypeid = 4
				
				AND	
				    ReferraldonorDeathdatetime <= calldatetime	
				    
				AND
					(
						EyesTrans NOT IN ('Med RO','High Risk')
					OR	EyesTrans IS NULL
					)
				AND
					(
						Bone NOT IN ('Med RO','High Risk')
					OR	Bone IS NULL
					)
				AND	
					(
						Tissue NOT IN ('Med RO','High Risk')
					OR	Tissue IS NULL
					)
				AND	
					(
						Skin NOT IN ('Med RO','High Risk')
					OR	Skin IS NULL
					)
				AND	
					(
						Valves NOT IN ('Med RO','High Risk')
					OR	Valves IS NULL
					)
				AND
					(
						EyesRsch <> 'Yes'
					OR	EyesRsch IS NULL
					)
				GROUP BY
					Organizationname
			) AS x
		WHERE   #Results.OrganizationName = x.OrganizationName
		
--------------------------------------------------------------------------------

----Calculate the number of Medical Rule Out Referrals

UPDATE
	#Results
		SET
			TotalMedRO = x.cnt
		FROM
			(
				SELECT
				
					
					COUNT(DISTINCT r.CallID) AS Cnt,
					Organizationname
			
				FROM
					#Staging r
				WHERE (Minutes between @StartRange20 and @EndRange20)
				
				and
					currentreferraltypeid = 4
				
				AND	
				    ReferraldonorDeathdatetime <= calldatetime
				    
				AND
					(
						EyesTrans	IN ('Med RO','High Risk')
					OR	Bone		IN ('Med RO','High Risk')
					OR	Tissue		IN ('Med RO','High Risk')
					OR	Skin		IN ('Med RO','High Risk')
					OR	Valves		IN ('Med RO','High Risk')
					)
				AND
					(
						EyesRsch <> 'Yes'
					OR	EyesRsch IS NULL
					)
				GROUP BY
					Organizationname
			) AS x
		WHERE  #Results.OrganizationName = x.OrganizationName
		

SELECT	*
FROM	#Results

Select *
from #Staging
order by callid












drop table #staging
drop table #results
GO

