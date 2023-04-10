 if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_rpt_ReferralFacilityReportTime_Select]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	BEGIN
		PRINT 'Dropping Procedure: sps_rpt_ReferralFacilityReportTime_Select'
		DROP  Procedure  sps_rpt_ReferralFacilityReportTime_Select
	END

GO

PRINT 'Creating Procedure: sps_rpt_ReferralFacilityReportTime_Select'
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


CREATE Procedure [dbo].[sps_rpt_ReferralFacilityReportTime_Select_Select]
	(
		@ReferralStartDateTime	DateTime,
		@ReferralEndDateTime	DateTime,
		@CardiacStartDateTime	DateTime,
		@CardiacEndDateTime		DateTime,
		@ReportGroupID			Int,
		@OrganizationTypeId		Int,
		@OrganizationID			Int,
		@SourceCodeName			VarChar(10),
		@DisplayMT				Bit,
		@LowerAgeLimit			Int,
		@UpperAgeLimit			Int,
		@ReferralDonorGender	VarChar(10),
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
	
		
	)	

AS

/******************************************************************************
**		File: 
**		Name: sps_rpt_ReferralFacilityReportTime_Select_Select
**		Desc: 
**
**		Called by:   Referral Facility Report Time Report
**              
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			------------------------------------------
**		4/13/10		Sue Dabiri		Initial design
**		
**		
**		
**		
*******************************************************************************/
----------------------------------------------------------------------------
/*
Referral Type
	1	Organ/Tissue/Eye
	2	Tissue/Eye
	3	Eyes Only
	4	Ruleout

----------------------------------------------------------------------------

Registry Status Type
	1	StateRegistry
	2	WebRegistry
	3	Not on Registry
	4	Manually Found
	5	Not Checked
*/
----------------------------------------------------------------------------

--DECLARE
--	@ReferralStartDateTime	DateTime,
--	@ReferralEndDateTime	DateTime,
--	@CardiacStartDateTime	DateTime,
--	@CardiacEndDateTime		DateTime,
--	@ReportGroupID			Int,
--	@OrganizationTypeId		Int,
--	@OrganizationID			Int,
--	@SourceCodeName			VarChar(15),
--	@DisplayMT				Bit,
--	@LowerAgeLimit			Int,
--	@UpperAgeLimit			Int,
--	@ReferralDonorGender	varchar(15),
--	@StartRange1			INT,
--	@uom1					bit,
--	@EndRange1				INT,
--	@StartRange2			INT, 
--	@uom2					bit,
--	@EndRange2				INT,
--	@StartRange3			INT,
--	@uom3					bit,
--	@EndRange3				INT,
--	@StartRange4			INT, 
--	@uom4					bit,
--	@EndRange4				INT,
--	@StartRange5			INT,
--	@uom5					bit,
--	@EndRange5				INT,
--	@StartRange6			INT,
--	@uom6					bit,
--	@EndRange6				INT,
--	@StartRange7			INT, 
--	@uom7					bit,
--	@EndRange7				INT,
--	@StartRange8			INT,
--	@uom8					bit,
--	@EndRange8				INT,
--	@StartRange9			INT,
--	@uom9					bit,
--	@EndRange9				INT,
--	@StartRange10			INT, 
--	@uom10					bit,
--	@EndRange10				INT,
--	@StartRange11			INT,
--	@uom11					bit,
--	@EndRange11				INT,
--	@StartRange12			INT,
--	@uom12					bit,
--	@EndRange12				INT,
--	@StartRange13			INT, 
--	@uom13					bit,
--	@EndRange13				INT,
--	@StartRange14			INT, 
--	@uom14					bit,
--	@EndRange14				INT,
--	@StartRange15			INT,
--	@uom15					bit,
--	@EndRange15				INT,
--	@StartRange16			INT,
--	@uom16					bit,
--	@EndRange16				INT,
--	@StartRange17			INT,
--	@uom17					bit,
--	@EndRange17				INT,
--	@StartRange18			INT,
--	@uom18					bit,
--	@EndRange18				INT,
--	@StartRange19			INT,
--	@uom19					bit,
--	@EndRange19				INT,
--	@StartRange20			INT,
--	@uom20					bit,
--	@EndRange20				INT
	
	
--SELECT
--	@ReferralStartDateTime	=	'2010-01-01 12:00:00', --CAST (DATEPART(yyyy,GETDATE())AS VarChar) + '-' + RIGHT('0' + CONVERT(VarChar,DATEPART(mm,GETDATE())),2) + '-' + '01',
--	@ReferralEndDateTime	=	'2010-01-03 12:00:00', --CAST (DATEPART(yyyy,GETDATE())AS VarChar) + '-' + RIGHT('0' + CONVERT(VarChar,DATEPART(mm,GETDATE())),2)  + '-' + RIGHT('0' + CONVERT(VarChar,DATEPART(dd,GETDATE())),2)
--	@CardiacStartDateTime	=	NULL,
--	@CardiacEndDateTime		=	NULL,
--	@ReportGroupID			=	1937,
--	@OrganizationTypeId		=	Null,
--	@OrganizationID			=	NULL,
--	@SourceCodeName			=	'CASD',
--	@DisplayMT				=	0, --1,
--	@LowerAgeLimit			=	NULL,
--	@UpperAgeLimit			=	NULL,
--	@ReferralDonorGender	=	NULL, -- M or F
--	@StartRange1			=   60,--0,
--	@UOM1					=	1,
--	@EndRange1				=	75,-- 60,
--	@StartRange2			=	100, --180,
--	@UOM2					=	1,
--	@EndRange2				=   120,	 --360
--	@StartRange3			= NULL,
--	@UOM3					=	0, 
--	@EndRange3				= NULL, 
--	@StartRange4			= NULL, 
--		@UOM4					=	0,
--	@EndRange4				= NULL, 
--	@StartRange5			= NULL, 
--		@UOM5					=	0, 
--	@EndRange5				= NULL, 
--	@StartRange6			= NULL, 
--		@UOM6					=	0, 
--	@EndRange6				= NULL, 
--	@StartRange7			= NULL, 
--		@UOM7					=	0,
--	@EndRange7				= NULL, 
--	@StartRange8			= NULL,  
--		@UOM8					=	0,
--	@EndRange8				= NULL, 
--	@StartRange9			= NULL,
--		@UOM9					=	0,  
--	@EndRange9				= NULL, 
--	@StartRange10			= NULL,  
--		@UOM10					=	0,
--	@EndRange10				= NULL, 
--	@StartRange11			= NULL, 
--		@UOM11					=	0,
--	@EndRange11				= NULL, 
--	@StartRange12			= NULL,  
--		@UOM12					=	0,
--	@EndRange12				= NULL, 
--	@StartRange13			= NULL, 
--		@UOM13					=	0,
--	@EndRange13				= NULL, 
--	@StartRange14			= NULL, 
--		@UOM14					=	0, 
--	@EndRange14				= NULL, 
--	@StartRange15			= NULL, 
--		@UOM15					=	0, 
--	@EndRange15				= NULL, 
--	@StartRange16			= NULL, 
--		@UOM16					=	0,
--	@EndRange16				= NULL, 
--	@StartRange17			= NULL, 
--		@UOM17					=	0, 
--	@EndRange17				= NULL, 
--	@StartRange18			= NULL, 
--		@UOM18					=	0, 
--	@EndRange18				= NULL, 
--	@StartRange19			= NULL,  
--		@UOM19					=	0,
--	@EndRange19				= NULL, 
--	@StartRange20			= NULL, 
--		@UOM20					=	0,
--	@EndRange20				= NULL
	
	
----------------------------------------------------------------------------

-------------------------------Temp Table to Get Ranges---------------------


	If @uom1 = 0
	
	
	
	select 
	 @StartRange1 = (CAST (@StartRange1 AS INT) * 60),
	 @EndRange1 =   (CAST (@EndRange1 AS INT) * 60) 
	
		else
		
	select 
	@StartRange1 = @StartRange1,
	@EndRange1 = @EndRange1
	
	
	If @UOM2 = 0
		select 
	@StartRange2 =(CAST (@StartRange2 AS INT) * 60),
	@EndRange2 = (CAST (@EndRange2 AS INT) * 60)
	
		else
		
	select 
	@StartRange2 = @StartRange2,
	@EndRange2 = @EndRange2
	
	
	If @uom3 = 0
	
	select 
	@StartRange3 =(CAST (@StartRange3 AS INT) * 60),
	@EndRange3 = (CAST (@EndRange3 AS INT) * 60)
	
		else
		
	select 
	@StartRange3 = @StartRange3,
	@EndRange3 = @EndRange3
	
	
	
	If @uom4 = 0
	
	select 
	@StartRange4 =(CAST (@StartRange4 AS INT) * 60),
	@EndRange4 = (CAST (@EndRange4 AS INT) * 60)
	
		else
		
	select 
	@StartRange4 = @StartRange4,
	@EndRange4 = @EndRange4
	
	
	
	If @uom5 = 0
	
	select 
	@StartRange5 =(CAST (@StartRange5 AS INT) * 60),
	@EndRange5 = (CAST (@EndRange5 AS INT) * 60)
	
		else
		
	select 
	@StartRange5 = @StartRange5,
	@EndRange5 = @EndRange5
	
	
	
	If @uom6 = 0
	
	select 
	@StartRange6 =(CAST (@StartRange6 AS INT) * 60),
	@EndRange6 = (CAST (@EndRange6 AS INT) * 60)
	
		else
		
	select 
	@StartRange6 = @StartRange6,
	@EndRange6 = @EndRange6



	If @uom7 = 0
	
	select 
	@StartRange7 =(CAST (@StartRange7 AS INT) * 60),
	@EndRange7 = (CAST (@EndRange7 AS INT) * 60)
	
		else
		
	select 
	@StartRange7 = @StartRange7,
	@EndRange7 = @EndRange7
	
	
	If @uom8 = 0
	
	select 
	@StartRange8 =(CAST (@StartRange8 AS INT) * 60),
	@EndRange8 = (CAST (@EndRange8 AS INT) * 60)
	
		else
		
	select 
	@StartRange8 = @StartRange8,
	@EndRange8 = @EndRange8
	
	
	
	If @uom9 = 0
	
	select 
	@StartRange9 =(CAST (@StartRange9 AS INT) * 60),
	@EndRange9 = (CAST (@EndRange9 AS INT) * 60)
	
		else
		
	select 
	@StartRange9 = @StartRange9,
	@EndRange9 = @EndRange9
	
	
	If @uom10 = 0
	
	select 
	@StartRange10 =(CAST (@StartRange10 AS INT) * 60),
	@EndRange10 = (CAST (@EndRange10 AS INT) * 60)
	
		else
		
	select 
	@StartRange10 = @StartRange10,
	@EndRange10 = @EndRange10



If @uom11 = 0
	
	select 
	@StartRange11 =(CAST (@StartRange11 AS INT) * 60),
	@EndRange11 = (CAST (@EndRange11 AS INT) * 60)
	
		else
		
	select 
	@StartRange11 = @StartRange11,
	@EndRange11 = @EndRange11
	
	
	If @uom12 = 0
	
	select 
	@StartRange12 =(CAST (@StartRange12 AS INT) * 60),
	@EndRange12 = (CAST (@EndRange12 AS INT) * 60)
	
		else
		
	select 
	@StartRange12 = @StartRange12,
	@EndRange12 = @EndRange12
	
	
	If @uom13 = 0
	
	select 
	@StartRange13 =(CAST (@StartRange13 AS INT) * 60),
	@EndRange13 = (CAST (@EndRange13 AS INT) * 60)
	
		else
		
	select 
	@StartRange13 = @StartRange13,
	@EndRange13 = @EndRange13
	
	
	
	If @uom14 = 0
	
	select 
	@StartRange14 =(CAST (@StartRange14 AS INT) * 60),
	@EndRange14 = (CAST (@EndRange14 AS INT) * 60)
	
		else
		
	select 
	@StartRange14 = @StartRange14,
	@EndRange14 = @EndRange14
	
	
	If @uom15 = 0
	
	select 
	@StartRange15 =(CAST (@StartRange15 AS INT) * 60),
	@EndRange15 = (CAST (@EndRange15 AS INT) * 60)
	
		else
		
	select 
	@StartRange15 = @StartRange15,
	@EndRange15 = @EndRange15
	
	
	If @uom16 = 0
	
	select 
	@StartRange16 =(CAST (@StartRange16 AS INT) * 60),
	@EndRange16 = (CAST (@EndRange16 AS INT) * 60)
	
		else
		
	select 
	@StartRange16 = @StartRange16,
	@EndRange16 = @EndRange16
	
	
	If @uom17 = 0
	
	select 
	@StartRange17 =(CAST (@StartRange17 AS INT) * 60),
	@EndRange17 = (CAST (@EndRange17 AS INT) * 60)
	
		else
		
	select 
	@StartRange17 = @StartRange17,
	@EndRange17 = @EndRange17
	
	
	If @uom18 = 0
	
	select 
	@StartRange18 =(CAST (@StartRange18 AS INT) * 60),
	@EndRange18 = (CAST (@EndRange18 AS INT) * 60)
	
		else
		
	select 
	@StartRange18 = @StartRange18,
	@EndRange18 = @EndRange18
	
	
	If @uom19 = 0
	
	select 
	@StartRange19 =(CAST (@StartRange19 AS INT) * 60),
	@EndRange19 = (CAST (@EndRange19 AS INT) * 60)
	
		else
		
	select 
	@StartRange19 = @StartRange19,
	@EndRange19 = @EndRange19
	
	
	If @uom20 = 0
	
	select 
	@StartRange20 =(CAST (@StartRange20 AS INT) * 60),
	@EndRange20 = (CAST (@EndRange20 AS INT) * 60)
	
		else
		
	select 
	@StartRange20 = @StartRange20,
	@EndRange20 = @EndRange20










declare @Range table 

(

OrganizationTypeId		Int,
OrganizationType		Varchar(50),
ReferralCallerOrganizationID int,
OrganizationName varchar(80),
RCallID int,
Calldatetime datetime,
Sourcecodeid int,
ReferraldonorDeathdatetime datetime



)
 
 Insert into @Range
( 

 OrganizationTypeId,
 OrganizationType,
 ReferralCallerOrganizationID,
 OrganizationName,
 RCallId,
 CallDateTime,
  SourceCodeID,
 ReferraldonorDeathdatetime
 

 
 
 
   )
   
   Select 

O.OrganizationTypeID as OrganizationTypeId,
OT.OrganizationTypeName As OrganizationType,
ReferralCallerOrganizationID As ReferralCallerOrganizationId,
OrganizationName As OrganizationName,
 R.CallId As RCallid,
 c.CallDateTime,
 c.SourceCodeID As SourceCodeId,
 
 CONVERT
      (
            DATETIME,
                  ISNULL
                        (
                              CONVERT
                                    (
                                          VarChar, R.ReferralDonorDeathDate, 101
                                    ), '01/01/00'
                        )
                  + ' '
                  + CASE
                        WHEN
                              ISNULL(ReferralDonorDeathTime, '') NOT LIKE '[0-9][0-9]:[0-9][0-9] [A-Z][A-Z]'
                        THEN
                              '00:00'
                        ELSE
                              ISNULL(substring( ReferralDonorDeathTime,1, 5 ), '00:00')
                        END )as ReferraldonorDeathdatetime
                        
                        

                        
                        
      
      
                  
From
      [Call] c
      INNER JOIN Referral R ON c.CallID = R.CallID
      INNER JOIN Organization O ON r.ReferralCallerOrganizationID = O.OrganizationID 
      Left Join OrganizationType  OT on O.OrganizationTypeID = OT.OrganizationTypeID
Where
      c.CallDateTime >= @ReferralStartDateTime and c.CallDateTime <= @ReferralEndDateTime
      
     
      
      
      
     
--Order By
--      o.OrganizationName



---------------------------------------------------------------------------------------

--It is possible for a Donor's Registry Status to change over time, so get the latest.

DECLARE
	@RegStatus	Table
		(
			
			
			CallID			Int,
			RegistryStatus	Int,
			ModDate			DateTime
		)

INSERT INTO
		@RegStatus
	SELECT
		
		
		CallID,
		RegistryStatus,
		Max(LastModified)
		
	FROM
			RegistryStatus
			 
	GROUP BY
			CallID,
			RegistryStatus
			
			
			
----------------------------------------------------------------------------------------------------------------------------------------------

--if @StartRange1 is not null 
Select  distinct       
 
 
    --CASE WHEN CAST(DATEDIFF(minute, ReferraldonorDeathdatetime,ran.Calldatetime) AS int) / 60.0 < @EndRange1 THEN 1  -- 0 to 1 hour
    
    --     WHEN CAST(DATEDIFF(minute, ReferraldonorDeathdatetime,ran.Calldatetime) AS int) / 60.0 >=  @EndRange1
    --          And CAST(DATEDIFF(minute, ReferraldonorDeathdatetime,ran.Calldatetime) AS int) / 60.0 < @startRange2 THEN 2 -- 1 to 3 hours
         
    --     WHEN CAST(DATEDIFF(minute, ReferraldonorDeathdatetime,ran.Calldatetime) AS int) / 60.0 >= @startRange2
    --          AND CAST(DATEDIFF(minute, ReferraldonorDeathdatetime,ran.Calldatetime) AS int) / 60.0 < @EndRange2 THEN 3-- 3 to 6 hours
             
    --     WHEN CAST(DATEDIFF(minute, ReferraldonorDeathdatetime,ran.Calldatetime) AS int) / 60.0 > @EndRange2 THEN 4  -- Greater then 6 hours
        
    --    END AS Ranges,
   @StartRange1 as StartRange1,
   @EndRange1 as endrange1,
   @StartRange2 as StartRange2,
   @EndRange2 as endrange2,
   @StartRange3 as StartRange3,
   @EndRange3 as endrange3,
   @StartRange4 as StartRange4,
   @EndRange4 as endrange4,
   @StartRange5 as StartRange5,
   @EndRange5 as endrange5,
   @StartRange6 as StartRange6,
   @EndRange6 as endrange6,
   @StartRange7 as StartRange7,
   @EndRange7 as endrange7,
   @StartRange8 as StartRange8,
   @EndRange8 as endrange8,
   @StartRange9 as StartRange9,
   @EndRange9 as endrange9,
   @StartRange10 as StartRange10,
   @EndRange10 as endrange10,
   @StartRange11 as StartRange11,
   @EndRange11 as endrange11,
   @StartRange12 as StartRange12,
   @EndRange12 as endrange12,
   @StartRange13 as StartRange13,
   @EndRange13 as endrange13,
   @StartRange14 as StartRange14,
   @EndRange14 as endrange14,
   @StartRange15 as StartRange15,
   @EndRange15 as endrange15,
   @StartRange16 as StartRange16,
   @EndRange16 as endrange16,
   @StartRange17 as StartRange17,
   @EndRange17 as endrange17,
   @StartRange18 as StartRange18,
   @EndRange18 as endrange18,
   @StartRange19 as StartRange19,
   @EndRange19 as endrange19,
   @StartRange20 as StartRange20,
   @EndRange20 as Endrange20,
   
 DATEDIFF(minute, ReferraldonorDeathdatetime,ran.Calldatetime) AS MINUTES, 
        
        
-- CAST(DATEDIFF(minute, ReferraldonorDeathdatetime,ran.Calldatetime) AS int) / 60.0 AS hours, 
  
r.callid,
C.CallDateTime,
ran.ReferraldonorDeathdatetime, 

	 
	CASE
		WHEN r.ReferralDonorGender = 'F'
			THEN 'Female'
		WHEN r.ReferralDonorGender = 'M'
			THEN 'Male'
		ELSE 'Unknown'
	END AS ReferralDonorGender,
	
ReferralDOB,
ReferralDonorAge,
ReferralDonorAgeUnit,
Ran.OrganizationType,
ran.OrganizationName,
ReferralDonorCauseOfDeathID,
rs.ID as RegistryTypeId,
RegistryType,
currentreferraltypeid,
referraltypename,
Organ.AppropriateName As Organ,
Bone.AppropriateName As Bone,
Tissue.AppropriateName AS Tissue,
Skin.AppropriateName As Skin,
EyesTrans.AppropriateName As EyesTrans,
EyesRsch.AppropriateName As EyesRsch,
Valves.AppropriateName AS Valves



FROM Referral r

	INNER JOIN		[Call] c				ON r.CallID = c.CallID
	left Join Organization  org              on R.ReferralCallerOrganizationid = org.organizationid
	Left Join OrganizationType OrgType		on Org.OrganizationTypeID = OrgType.OrganizationTypeID
	
	INNER JOIN
		(
			SELECT
				
				CallID,
				CallDateTime
			FROM
				dbo.fn_rpt_ReferralDateTimeConversion 
					(
						Null					,
						@ReferralStartDateTime	,
						@ReferralEndDateTime	,
						@CardiacStartDateTime	,
						@CardiacEndDateTime		,
						@DisplayMT
					)
		) LT ON LT.CallID = c.CallID
	LEFT OUTER JOIN ReferralType rt			ON r.ReferralTypeID = rt.ReferralTypeID
	LEFT OUTER JOIN @RegStatus rg			ON r.CallID = rg.CallID
	LEFT OUTER JOIN RegistryStatusType rs	ON rg.RegistryStatus = rs.ID
	LEFT OUTER JOIN WebReportGroupOrg wr	ON wr.OrganizationID = r.ReferralCallerOrganizationID
	left join Appropriate  Organ			ON r.ReferralOrganAppropriateID =Organ.AppropriateID
	left join Appropriate  Bone				ON r.ReferralBoneAppropriateID = Bone.AppropriateID
	left join Appropriate Tissue			ON r.ReferralTissueAppropriateID = Tissue.AppropriateID
	left join Appropriate Skin				ON r.ReferralSkinAppropriateID = Skin.AppropriateID
	Left join Appropriate EyesTrans			ON r.ReferralEyesTransAppropriateID = EyesTrans.AppropriateID
	Left Join Appropriate EyesRsch			ON r.ReferralEyesRschAppropriateID = EyesRsch.AppropriateID
	Left Join Appropriate Valves			ON r.ReferralValvesAppropriateID = Valves.AppropriateID
	Left Join @Range	ran					on R.CallID = ran.RCallID

WHERE  



	 c.SourceCodeID IN
		(
			SELECT DISTINCT * 
			FROM
			dbo.fn_SourceCodeList(@ReportGroupID,@SourceCodeName)
		)
		

AND r.ReferralCallerOrganizationID = ISNULL(@OrganizationID, r.ReferralCallerOrganizationID)
AND Org.OrganizationTypeID = ISNULL(@OrganizationTypeID, Org.OrganizationTypeID)
AND wr.WebReportGroupID = ISNULL(@ReportGroupID, 0)
AND --- either use the fn_rpt_DonorAgeYear or ignore
	(
		(dbo.fn_rpt_DonorAgeYear(ReferralDOB,r.ReferralDonorDeathDate,ReferralDonorAge,ReferralDonorAgeUnit)
			BETWEEN ISNULL(@LowerAgeLimit, 0) AND ISNULL(@UpperAgeLimit, 0)
	OR
		(ISNULL(@LowerAgeLimit, 0) = 0 AND ISNULL(@UpperAgeLimit, 0) = 0)
	)
AND ISNULL(r.ReferralDonorGender, 0) = ISNULL(@ReferralDonorGender, ISNULL(r.ReferralDonorGender,0))

and
    
  ((
  DATEDIFF(minute, ReferraldonorDeathdatetime,ran.Calldatetime) BETWEEN @StartRange1 and @EndRange1 
or
  DATEDIFF(minute, ReferraldonorDeathdatetime,ran.Calldatetime) between @StartRange2 and @EndRange2
or
  DATEDIFF(minute, ReferraldonorDeathdatetime,ran.Calldatetime) between @StartRange3 and @EndRange3
or
  DATEDIFF(minute, ReferraldonorDeathdatetime,ran.Calldatetime) between @StartRange4 and @EndRange4
or
  DATEDIFF(minute, ReferraldonorDeathdatetime,ran.Calldatetime) between @StartRange5 and @EndRange5
or
  DATEDIFF(minute, ReferraldonorDeathdatetime,ran.Calldatetime) between @StartRange6 and @EndRange6
or
  DATEDIFF(minute, ReferraldonorDeathdatetime,ran.Calldatetime) between @StartRange7 and @EndRange7
or
  DATEDIFF(minute, ReferraldonorDeathdatetime,ran.Calldatetime) between @StartRange8 and @EndRange8
or
  DATEDIFF(minute, ReferraldonorDeathdatetime,ran.Calldatetime) between @StartRange9 and @EndRange9
or
  DATEDIFF(minute, ReferraldonorDeathdatetime,ran.Calldatetime) between @StartRange10 and @EndRange10
or
  DATEDIFF(minute, ReferraldonorDeathdatetime,ran.Calldatetime) between @StartRange11 and @EndRange11
or
  DATEDIFF(minute, ReferraldonorDeathdatetime,ran.Calldatetime) between @StartRange12 and @EndRange12
or
  DATEDIFF(minute, ReferraldonorDeathdatetime,ran.Calldatetime) between @StartRange13 and @EndRange13
or
  DATEDIFF(minute, ReferraldonorDeathdatetime,ran.Calldatetime) between @StartRange14 and @EndRange14
or
  DATEDIFF(minute, ReferraldonorDeathdatetime,ran.Calldatetime) between @StartRange15 and @EndRange15
or
  DATEDIFF(minute, ReferraldonorDeathdatetime,ran.Calldatetime) between @StartRange16 and @EndRange16
or
  DATEDIFF(minute, ReferraldonorDeathdatetime,ran.Calldatetime) between @StartRange17 and @EndRange17
or
  DATEDIFF(minute, ReferraldonorDeathdatetime,ran.Calldatetime) between @StartRange18 and @EndRange18
or
  DATEDIFF(minute, ReferraldonorDeathdatetime,ran.Calldatetime) between @StartRange19 and @EndRange19
or
  DATEDIFF(minute, ReferraldonorDeathdatetime,ran.Calldatetime) between @StartRange20 and @EndRange20)))


 



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

 