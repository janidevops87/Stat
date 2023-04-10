if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_rpt_ImportOfferDetail_count_select]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_rpt_ImportOfferDetail_count_select]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE PROCEDURE sps_rpt_ImportOfferDetail_count_select
	@UserOrgID		int = Null,
	@ReportGroupID	int = Null,
	@CallID			int = Null,
	@StartDateTime	DATETIME = NULL ,
	@EndDateTime	DATETIME = NULL,
	@SourceCodeName varchar(50) ,
	@OrganizationID int = Null,
	@DisplayMT		int = Null
	
AS

/******************************************************************************
**		File: sps_rpt_ImportOfferDetail_count_select.sql
**		Name: sps_rpt_ImportOfferDetail_count_select
**		Desc: 
**
**              
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------						-----------
**
**		Auth: jth
**		Date: 5/08
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	-------				-------------------------------------------
**		09/29/2008	ccarroll			Added selection for Archive data   
**      02/09       JTH                 limit message org id to user org id 
*******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
Declare @MessageOrganizationID int

-- CHECK FOR STATLINE AND SET PARAM
if (@UserOrgID = 194)
begin
	set @MessageOrganizationID = null
end
else
begin
	set @MessageOrganizationID = @UserOrgID
end
SELECT  COUNT(DISTINCT Call.CallID) 'RecordCount'
 FROM   CALL
  Join (SELECT 		
			CallID, 
			CallDateTime
		FROM dbo.fn_rpt_MessageDateTimeConversion 
		(
		@CallID						 ,
		@StartDateTime		 ,
		@EndDateTime		 ,
		@DisplayMT		 ) ) LT ON LT.CallID = Call.CallID
         INNER JOIN MESSAGE
           ON MESSAGE.CALLID = CALL.CALLID
         INNER JOIN ORGANIZATION
           ON ORGANIZATION.ORGANIZATIONID = MESSAGE.ORGANIZATIONID
         INNER JOIN MESSAGETYPE
           ON MESSAGETYPE.MESSAGETYPEID = MESSAGE.MESSAGETYPEID
         INNER JOIN PERSON
           ON PERSON.PERSONID = MESSAGE.PERSONID
         INNER JOIN PERSONTYPE
           ON PERSON.PERSONTYPEID = PERSONTYPE.PERSONTYPEID
         INNER JOIN WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = Message.OrganizationID   
  WHERE  ISNULL(@CallID,CALL.CALLID) = CALL.CALLID
         AND CALL.SOURCECODEID IN (SELECT SOURCECODEID
                                   FROM   DBO.FN_SOURCECODELIST (@ReportGroupID,@SourceCodeName ))
          --LIMIT MESSAGE.OrganizationID
         AND MESSAGE.OrganizationID = ISNULL(@MessageOrganizationID, MESSAGE.OrganizationID)                                      
         AND (MESSAGE.MESSAGETYPEID = 2)


  GO