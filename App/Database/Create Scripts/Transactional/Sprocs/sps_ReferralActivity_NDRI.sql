SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_ReferralActivity_NDRI]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_ReferralActivity_NDRI]
GO


CREATE PROCEDURE sps_ReferralActivity_NDRI

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
		
	DECLARE SourceCodeCursor CURSOR FOR
		SELECT DISTINCT SourceCodeID FROM WebReportGroupSourceCode WHERE WebReportGroupID = @pvReportGroupID
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
          SELECT @QueryString = @QueryString + "ReferralDonorFirstName, OrganizationName "
          SELECT @QueryString = @QueryString + "FROM Call JOIN Referral ON Referral.CallID = Call.CallID "
          SELECT @QueryString = @QueryString + "LEFT JOIN Organization ON Organization.OrganizationID = Referral.ReferralCallerOrganizationID "
          SELECT @QueryString = @QueryString + "LEFT JOIN WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = ReferralCallerOrganizationID "
          SELECT @QueryString = @QueryString + "LEFT JOIN StatEmployee ON StatEmployee.StatEmployeeID = Call.StatEmployeeID "
          SELECT @QueryString = @QueryString + "LEFT JOIN Person ON Person.PersonID = StatEmployee.PersonID "
          SELECT @QueryString = @QueryString + "LEFT JOIN SourceCode ON SourceCode.SourceCodeID = Call.SourceCodeID "
          SELECT @QueryString = @QueryString + "LEFT JOIN ReferralType ON ReferralType.ReferralTypeID = Referral.ReferralTypeID "
          SELECT @QueryString = @QueryString + "JOIN NDRICallSheet ON Call.CallID = NDRICallSheet.CallID "
          SELECT @QueryString = @QueryString + "WHERE CallDateTime BETWEEN '"
          SELECT @QueryString = @QueryString + convert(varchar(20),@pvStartDate) --00/00/00 00:00:00
          SELECT @QueryString = @QueryString + "' AND '"
          SELECT @QueryString = @QueryString + convert(varchar(20), @pvEndDate )
          SELECT @QueryString = @QueryString + "' AND WebReportGroupOrg.WebReportGroupID = "
          SELECT @QueryString = @QueryString + convert(char(25),@pvReportGroupID)
          SELECT @QueryString = @QueryString + " AND CALL.SourceCodeID IN ( " + @SCIList + " ) "


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

