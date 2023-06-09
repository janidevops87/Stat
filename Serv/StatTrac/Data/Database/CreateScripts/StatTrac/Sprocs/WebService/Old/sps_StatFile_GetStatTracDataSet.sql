SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_StatFile_GetStatTracDataSet]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_StatFile_GetStatTracDataSet]
GO




CREATE PROCEDURE sps_StatFile_GetStatTracDataSet 
(
		@vstrUserName as varchar(50),
		@vstrPassword as varchar(50),
		@vintFileType as int,
		@vintReportGroup as int,
		@vintIncludeNew as bit,
		@vintIncludeModified as bit,
		@vDateStartDateTime as datetime,
		@vDateEndDateTime as datetime,
		@vLastRecord as int
)
AS

DECLARE @vOrgID as int

SELECT 	@vOrgID = OrganizationID  
	
    		FROM 	WebPerson
    		JOIN 	Person ON Person.PersonID = WebPerson.PersonID

	    	WHERE 	WebPersonUserName = @vstrUserName
    		AND 	WebPersonPassword = @vstrPassword

	 
--File Type Referral Detail
if @vintFileType = 1 
	EXEC sps_StatFile_GetData_ReferralDetail @vOrgID, @vintReportGroup, @vDateStartDateTime, @vDateEndDateTime, @vintIncludeNew, @vintIncludeModified, @vLastRecord

--File Type Message Detail
if  @vintFileType = 2 
	EXEC sps_StatFile_GetData_MessageDetail  @vOrgID, @vDateStartDateTime, @vDateEndDateTime, @vintIncludeNew, @vintIncludeModified, @vLastRecord

--File type ReferralEvents
if  @vintFileType = 3 
	EXEC sps_StatFile_GetData_ReferralEvents @vOrgID, @vintReportGroup, @vDateStartDateTime, @vDateEndDateTime, @vintIncludeNew, @vintIncludeModified, @vLastRecord

--File type MessageEvents
if  @vintFileType = 4 
	EXEC sps_StatFile_GetData_ReferralEvents @vOrgID, @vintReportGroup, @vDateStartDateTime, @vDateEndDateTime, @vintIncludeNew, @vintIncludeModified, @vLastRecord

--File type ReferralDetailExt
if  @vintFileType = 5
	EXEC sps_StatFile_GetData_ReferralDetailExt @vOrgID, @vintReportGroup, @vDateStartDateTime, @vDateEndDateTime, @vintIncludeNew, @vintIncludeModified, @vLastRecord

--File type ReferralDetailFS
if  @vintFileType = 6
	EXEC sps_StatFile_GetData_ReferralDetailFS @vOrgID, @vintReportGroup, @vDateStartDateTime, @vDateEndDateTime, @vintIncludeNew, @vintIncludeModified, @vLastRecord

--File type ReferralDetail2004Created
if  @vintFileType = 7
	EXEC sps_StatFile_GetData_ReferralDetail2004 @vOrgID, @vintReportGroup, @vDateStartDateTime, @vDateEndDateTime, @vintIncludeNew, @vintIncludeModified, @vLastRecord

--File type ReferralEvents2004
if  @vintFileType = 8
	EXEC sps_StatFile_GetData_ReferralEvents2004 @vOrgID, @vintReportGroup, @vDateStartDateTime, @vDateEndDateTime, @vintIncludeNew, @vintIncludeModified, @vLastRecord

--File type sps_StatFileReferralExtFS
if  @vintFileType = 9
	EXEC sps_StatFile_GetData_ReferralDetailExtFS @vOrgID, @vintReportGroup, @vDateStartDateTime, @vDateEndDateTime, @vintIncludeNew, @vintIncludeModified, @vLastRecord

--File type sps_StatFileReferralDetail2006
if  @vintFileType = 10
	EXEC sps_StatFile_GetData_ReferralDetail2006 @vOrgID, @vintReportGroup, @vDateStartDateTime, @vDateEndDateTime, @vintIncludeNew, @vintIncludeModified, @vLastRecord

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

