SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_ReferralActivity_MS]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_ReferralActivity_MS]
GO


CREATE PROCEDURE sps_ReferralActivity_MS

     @pvReportGroupID     int          = null,
     @pvStartDate         datetime     = null,  
     @pvEndDate           datetime     = null,
     @pvOrgID             int          = null,
     @vTZ                 varchar(2)   = null,
     @pvReferralTypeID    int          = null, 
     @pvOrderBy           varchar(60)  = null,
     @pvUserOrgID	  int	       = null	 

--with recompile
AS

     DECLARE @QueryString varchar(8000)
     DECLARE @ReferralTypeStart int
     DECLARE @ReferralTypeEnd int
     DECLARE @TZ int          
     DECLARE @SourceCodeID int
     DECLARE @SCIList varchar(2000)	
/*
     Create Table #ReferralActivity
          (
          ReferralID int, 
          CallID int, 
          CallNumber char(10),
          CallDateTime smalldatetime, 
          CallDate char(8), 
          CallTime char(5), 
          PersonFirst varchar(50), 
          PersonLast varchar(50), 
          GenderAge varchar(15), 
          SourceCodeID int, 
          SourceCodeName varchar(10), 
          ReferralTypeID int, 
          ReferralTypeName varchar(50),
          ReferralDonorLastName varchar(40),
          ReferralDonorFirstName varchar(40),
          OrganizationName varchar(80)
          )


     Create Table #SourceCodeLookUP
          (
          SourceCodeID int
          )
*/       
     EXEC spf_TZDif @vTZ, @TZ OUTPUT, @pvStartDate

  /*   
     IF @pvReferralTypeID = 0 
          BEGIN
               Select @ReferralTypeStart = 1
               Select @ReferralTypeEnd = 4
          END
     Else
          BEGIN
               Select @ReferralTypeStart = @pvReferralTypeID
               Select @ReferralTypeEnd = @pvReferralTypeID 
          END
     */
     --SELECT @ReferralTypeStart, @ReferralTypeEnd

     --IF @pvOrderBy = ''
          --SET @pvOrderBy = 'ReferralTypeID, OrganizationName, CallDateTime'
     
     SELECT @pvStartDate = DateAdd(hour,-@TZ,@pvStartDate)
     SELECT @pvEndDate = DateAdd(hour,-@TZ,@pvEndDate)     

     --SELECT @pvStartDate
     --SELECT @pvEndDate

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


     --SELECT * FROM #SourceCodeLookUP
          SELECT @QueryString = ""
          SELECT @QueryString = "SELECT DISTINCT ReferralID, Call.CallID, CallNumber, DATEADD(hour, "
          SELECT @QueryString = @QueryString + Convert(char(2),@TZ)
          SELECT @QueryString = @QueryString + " , CallDateTime) AS CallDateTime, CONVERT(char(8), DATEADD(hour, "
          SELECT @QueryString = @QueryString + Convert(char(2),@TZ)
          SELECT @QueryString = @QueryString + " , CallDateTime), 1) AS CallDate, CONVERT(char(5), DATEADD(hour, "
          SELECT @QueryString = @QueryString + Convert(char(2),@TZ)     
          SELECT @QueryString = @QueryString + " , CallDateTime), 8) AS CallTime, PersonFirst, PersonLast, ReferralDonorGender "
          SELECT @QueryString = @QueryString + " + '  ' +   "
          SELECT @QueryString = @QueryString + " ReferralDonorAge "
SELECT @QueryString = @QueryString + " + ' ' + "
          SELECT @QueryString = @QueryString + " ReferralDonorAgeUnit as GenderAge, Call.SourceCodeID, "
          SELECT @QueryString = @QueryString + " SourceCode.SourceCodeName, "
          SELECT @QueryString = @QueryString + " CASE "
          SELECT @QueryString = @QueryString + " WHEN Referral.ReferralTypeID = 1 THEN Referral.ReferralTypeID "
          SELECT @QueryString = @QueryString + " WHEN Referral.ReferralTypeID = 2 THEN Referral.ReferralTypeID "
          SELECT @QueryString = @QueryString + " WHEN Referral.ReferralTypeID = 3 THEN Referral.ReferralTypeID "
          SELECT @QueryString = @QueryString + " WHEN Referral.ReferralTypeID = 4 THEN "
          SELECT @QueryString = @QueryString + " CASE "
          SELECT @QueryString = @QueryString + " WHEN   Referral.ReferralTypeID = 4 " 		 
	  SELECT @QueryString = @QueryString + " AND	(ReferralGeneralConsent = -1 OR ReferralGeneralConsent = Null) "
	  SELECT @QueryString = @QueryString + " AND	(ReferralApproachTypeID = -1 OR ReferralApproachTypeID = 7) "
	  SELECT @QueryString = @QueryString + " AND 	ReferralOrganAppropriateID <>1  "
	  SELECT @QueryString = @QueryString + " AND 	ReferralEyesTransAppropriateID <>1 "
	  SELECT @QueryString = @QueryString + " AND	ReferralBoneAppropriateID > 1 "
	  SELECT @QueryString = @QueryString + " AND	ReferralTissueAppropriateID > 1 "
	  SELECT @QueryString = @QueryString + " AND	ReferralSkinAppropriateID > 1 "
	  SELECT @QueryString = @QueryString + " AND	ReferralValvesAppropriateID > 1 "
	  SELECT @QueryString = @QueryString + " AND	ReferralEyesRschAppropriateID = 1 "	
	  SELECT @QueryString = @QueryString + " THEN 2 "
	  SELECT @QueryString = @QueryString + " ELSE Referral.ReferralTypeID END "
	  SELECT @QueryString = @QueryString + " END AS 'ReferralTypeID',"

          SELECT @QueryString = @QueryString + " CASE "
          SELECT @QueryString = @QueryString + " WHEN Referral.ReferralTypeID = 1 THEN ReferralTypeName "
          SELECT @QueryString = @QueryString + " WHEN Referral.ReferralTypeID = 2 THEN ReferralTypeName "
          SELECT @QueryString = @QueryString + " WHEN Referral.ReferralTypeID = 3 THEN ReferralTypeName "
          SELECT @QueryString = @QueryString + " WHEN Referral.ReferralTypeID = 4 THEN "
          SELECT @QueryString = @QueryString + " CASE "
          SELECT @QueryString = @QueryString + " WHEN   Referral.ReferralTypeID = 4 " 		 
	  SELECT @QueryString = @QueryString + " AND	(ReferralGeneralConsent = -1 OR ReferralGeneralConsent = Null) "
	  SELECT @QueryString = @QueryString + " AND	(ReferralApproachTypeID = -1 OR ReferralApproachTypeID = 7) "
	  SELECT @QueryString = @QueryString + " AND 	ReferralOrganAppropriateID <>1  "
	  SELECT @QueryString = @QueryString + " AND 	ReferralEyesTransAppropriateID <>1 "
	  SELECT @QueryString = @QueryString + " AND	ReferralBoneAppropriateID > 1 "
	  SELECT @QueryString = @QueryString + " AND	ReferralTissueAppropriateID > 1 "
	  SELECT @QueryString = @QueryString + " AND	ReferralSkinAppropriateID > 1 "
	  SELECT @QueryString = @QueryString + " AND	ReferralValvesAppropriateID > 1 "
	  SELECT @QueryString = @QueryString + " AND	ReferralEyesRschAppropriateID = 1 "	
	  SELECT @QueryString = @QueryString + " THEN 'Tissue/Eye' "
	  SELECT @QueryString = @QueryString + " ELSE ReferralTypeName END "
	  SELECT @QueryString = @QueryString + " END AS 'ReferralTypeName',"
                    
          

          
          SELECT @QueryString = @QueryString + " ReferralDonorLastName, "
          SELECT @QueryString = @QueryString + "ReferralDonorFirstName, OrganizationName "
          SELECT @QueryString = @QueryString + "FROM Call JOIN Referral ON Referral.CallID = Call.CallID "
          SELECT @QueryString = @QueryString + "LEFT JOIN Organization ON Organization.OrganizationID = Referral.ReferralCallerOrganizationID "
          SELECT @QueryString = @QueryString + "LEFT JOIN WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = ReferralCallerOrganizationID "
          SELECT @QueryString = @QueryString + "LEFT JOIN StatEmployee ON StatEmployee.StatEmployeeID = Call.StatEmployeeID "
          SELECT @QueryString = @QueryString + "LEFT JOIN Person ON Person.PersonID = StatEmployee.PersonID "
          SELECT @QueryString = @QueryString + "LEFT JOIN SourceCode ON SourceCode.SourceCodeID = Call.SourceCodeID "
          SELECT @QueryString = @QueryString + "LEFT JOIN ReferralType ON ReferralType.ReferralTypeID = Referral.ReferralTypeID "
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
   
     --select @QueryString
     EXEC(@QueryString )














GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

