SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_CoronerCaseActivity]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_CoronerCaseActivity]
GO



CREATE PROCEDURE sps_CoronerCaseActivity

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



*/   
    EXEC spf_TZDif     @vTZ, @TZ OUTPUT, @pvStartDate

/*     SELECT @TZ = 
                    CASE @vTZ
                    When 'MT' Then 0
                    When 'ET' Then 2
                    When 'CT' Then 1
                    When 'PT' Then -1    
                    END 
*/     
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
          SELECT @QueryString = @QueryString + "SourceCode.SourceCodeName, Referral.ReferralTypeID, ReferralTypeName, ReferralDonorLastName, "
          SELECT @QueryString = @QueryString + "ReferralDonorFirstName, OrganizationName, ReferralCoronerName, ReferralCoronerPhone, ReferralCoronerOrganization "
          SELECT @QueryString = @QueryString + "FROM Call JOIN Referral ON Referral.CallID = Call.CallID "
          SELECT @QueryString = @QueryString + "JOIN Organization ON Organization.OrganizationID = Referral.ReferralCallerOrganizationID "
          SELECT @QueryString = @QueryString + "JOIN WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = ReferralCallerOrganizationID "
          SELECT @QueryString = @QueryString + "JOIN StatEmployee ON StatEmployee.StatEmployeeID = Call.StatEmployeeID "
          SELECT @QueryString = @QueryString + "JOIN Person ON Person.PersonID = StatEmployee.PersonID "
          SELECT @QueryString = @QueryString + "JOIN SourceCode ON SourceCode.SourceCodeID = Call.SourceCodeID "
          SELECT @QueryString = @QueryString + "JOIN ReferralType ON ReferralType.ReferralTypeID = Referral.ReferralTypeID "
          SELECT @QueryString = @QueryString + "WHERE CallDateTime BETWEEN '"
          SELECT @QueryString = @QueryString + convert(varchar(20),@pvStartDate) --00/00/00 00:00:00
          SELECT @QueryString = @QueryString + "' AND '"
          SELECT @QueryString = @QueryString + convert(varchar(20), @pvEndDate )
          SELECT @QueryString = @QueryString + "' AND WebReportGroupOrg.WebReportGroupID = "
          SELECT @QueryString = @QueryString + convert(char(25),@pvReportGroupID)
          SELECT @QueryString = @QueryString + " AND ReferralCoronersCase = -1"
     IF @pvUserOrgID <> 194
     BEGIN
          SELECT @QueryString = @QueryString + " AND CALL.SourceCodeID IN ( "
          SELECT @QueryString = @QueryString + @SCIList
--          SELECT @QueryString = @QueryString + convert(char(25), @pvReportGroupID)
          SELECT @QueryString = @QueryString + ") "
     END

     IF @pvReferralTypeID > 0      
     BEGIN          
          SELECT @QueryString = @QueryString + "AND Referral.ReferralTypeID = "
          SELECT @QueryString = @QueryString + convert(char(1), @pvReferralTypeID )
     END
           
     IF @PvOrgID <> 0
          BEGIN
               SELECT @QueryString = @QueryString + " AND Referral.ReferralCallerOrganizationID = " 
               SELECT @QueryString = @QueryString + @PvOrgID
          END

          SELECT @QueryString = @QueryString + " ORDER BY ReferralCoronerPhone, ReferralCoronerOrganization, "
          SELECT @QueryString = @QueryString + @pvOrderBy     
   
     --select @QueryString
     EXEC(@QueryString )




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

