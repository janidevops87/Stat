SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_GetStatTracDataSet]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_GetStatTracDataSet]
GO


CREATE PROCEDURE sps_GetStatTracDataSet 


 		 
	 
		
		@vstrUserName as varchar(50),
		@vstrPassword as varchar(50),
		@vintFileType as int,
		@vintReportGroup as int,
		@vintIncludeNew as bit,
		@vintIncludeModified as bit,
		@vDateStartDateTime as datetime,
		@vDateEndDateTime as datetime,
		@vLastRecord as int
as
	
		declare
			@vOrgID as int
			 


		--set @vstrUserName = 'testco'
		--set @vstrPassword = 'testco'
		--set @vintFileType = 1
		--set @vintReportGroup = 57
		--set @vintIncludeNew =1
		--set @vintIncludeModified = 0
		--set @vDateStartDateTime = '01/20/2005'
		--set @vDateEndDateTime= '02/20/2005'
		--set @vLastRecord  = 0




		
		--@intlastReferral as int


SELECT 	@vOrgID = OrganizationID  
	
    		FROM 	WebPerson
    		JOIN 	Person ON Person.PersonID = WebPerson.PersonID

	    	WHERE 	WebPersonUserName = @vstrUserName
    		AND 	WebPersonPassword = @vstrPassword

	 
--File Type Referral Detail
if @vintFileType = 1 
	Begin
		if @vintIncludeNew = 1
			exec sps_StatFileReferralDetailCreated @vstrUserName,@vstrPassword,@vintReportGroup,@vDateStartDateTime,@vDateEndDateTime,@vLastRecord
        			
		if @vintIncludeModified = 1
			exec sps_StatFileReferralDetailLastMod @vstrUserName,@vstrPassword,@vintReportGroup,@vDateStartDateTime,@vDateEndDateTime,@vLastRecord
	End
--File Type Message Detail
print @vOrgID
if  @vintFileType = 2 
	Begin
		if @vintIncludeNew = 1
			exec sps_StatFileMessageDetailCreated  @vOrgID,@vDateStartDateTime,@vDateEndDateTime,@vLastRecord
		if @vintIncludeModified = 1 	
			exec sps_StatFileMessageDetailLastMod  @vOrgID,@vDateStartDateTime,@vDateEndDateTime,@vLastRecord	
	End

--File type ReferralEvents
if  @vintFileType = 3 
	Begin
		if @vintIncludeNew = 1
			exec  sps_StatFileReferralEventsCreated @vstrUserName,@vstrPassword,@vintReportGroup,@vDateStartDateTime,@vDateEndDateTime,@vLastRecord
		if @vintIncludeModified = 1 	
			exec  sps_StatFileReferralEventsLastMod @vstrUserName,@vstrPassword,@vintReportGroup,@vDateStartDateTime,@vDateEndDateTime,@vLastRecord	
	End

--File type MessageEvents
if  @vintFileType = 4 
	Begin
		if @vintIncludeNew = 1
			exec  sps_StatFileMessageEventsCreated @vstrUserName,@vstrPassword,@vintReportGroup,@vDateStartDateTime,@vDateEndDateTime,@vLastRecord
		if @vintIncludeModified = 1 	
			exec  sps_StatFileMessageEventsLastMod @vstrUserName,@vstrPassword,@vintReportGroup,@vDateStartDateTime,@vDateEndDateTime,@vLastRecord	
	End

--File type ReferralDetailExt
if  @vintFileType = 5
	Begin
		if @vintIncludeNew = 1
			exec  sps_StatFileReferralDetailExtCreated @vstrUserName,@vstrPassword,@vintReportGroup,@vDateStartDateTime,@vDateEndDateTime,@vLastRecord
		if @vintIncludeModified = 1 	
			exec sps_StatFileReferralDetailExtLastMod @vstrUserName,@vstrPassword,@vintReportGroup,@vDateStartDateTime,@vDateEndDateTime,@vLastRecord	
	End

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

