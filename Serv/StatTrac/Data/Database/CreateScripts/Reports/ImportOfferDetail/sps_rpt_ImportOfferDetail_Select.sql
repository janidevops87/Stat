IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_rpt_ImportOfferDetail_Select')
	BEGIN
		PRINT 'Dropping Procedure sps_rpt_ImportOfferDetail_Select'
		DROP  Procedure  sps_rpt_ImportOfferDetail_Select
	END

GO

PRINT 'Creating Procedure sps_rpt_ImportOfferDetail_Select'
GO


CREATE PROCEDURE [dbo].[sps_rpt_ImportOfferDetail_Select]
                @UserOrgID      INT  = NULL,
                @ReportGroupID  INT  = NULL,
                @CallID         INT  = NULL,
                @StartDateTime  DATETIME  = NULL,
                @EndDateTime    DATETIME  = NULL,
                @SourceCodeName VARCHAR(50),
                @DisplayMT      INT  = NULL
AS

  /******************************************************************************
**		File: sps_rpt_ImportOfferDetail_Select.sql
**		Name: sps_rpt_ImportOfferDetail_Select
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
**     ----------						-----------
**
**		Auth: jth
**		Date: 5/08
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	-------				-------------------------------------------
**		10/01/2008	ccarroll			Created for Archive and Production databases
**      02/09       JTH                 limit message org id to user org id 	
**		03/14/2010	James Gerberich		Added phone extension to MessageCallerPhone
**										column. HS #22712
*******************************************************************************/
  SET TRANSACTION ISOLATION  LEVEL  READ  UNCOMMITTED
  
  DECLARE  @CustomCode  AS INT,
           @Results     AS INT
  
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

  /* Set CustomCode */
  EXEC @CustomCode = SPS_RPT_CHECKCUSTOMREPORTUSERORG
    @UserOrgID ,
    @Results OUTPUT
    
  SELECT DISTINCT CALL.CallID,
                  MESSAGETYPE.MessageTypeName,
                  CALL.CallNumber,
                  ORGANIZATION.OrganizationName,
                  MESSAGE.MessageCallerName,
                  MessageCallerOrganization,
                  MESSAGE.MessageCallerPhone + ISNULL(' x' + Cast(MESSAGE.MessageExtension AS VarChar(20)), ' No Ext') AS MessageCallerPhone,
                  LT.CallDateTime AS CallDateTime,
				  --CONVERT(varchar, LT.CallDateTime, 1) AS CallDate,
				  --CONVERT(varchar, LT.CallDateTime, 8) AS CallTime,
                  MESSAGE.MessageUrgent,
                  MESSAGE.MessageDescription,
                  PERSON.PERSONLAST                            AS MessageForLastName,
                  PERSONTYPE.PERSONTYPENAME,
                  PERSON.PERSONFIRST + ' ' + PERSON.PERSONLAST AS PersonName,
                  @CustomCode                                  AS 'ReportCustomCode',
                  (SELECT TOP 1 SC.SourceCodeName
                   FROM   SOURCECODE AS SC
                   WHERE  SC.SOURCECODEID = CALL.SOURCECODEID) AS SOURCECODENAME,
                  (SELECT TOP 1 PERSON.PERSONFIRST + ' ' + PERSON.PERSONLAST
                   FROM   LOGEVENT
                          LEFT OUTER JOIN STATEMPLOYEE
                            ON STATEMPLOYEE.STATEMPLOYEEID = LOGEVENT.STATEMPLOYEEID
                          LEFT OUTER JOIN PERSON
                            ON PERSON.PERSONID = STATEMPLOYEE.PERSONID
                   WHERE  (LOGEVENT.CALLID = CALL.CALLID)) AS TrigageCoord,Message.MessageImportUNOSID, Message.MessageImportCenter, 
                      Message.MessageImportPatient
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
         --JOIN WEBREPORTGROUP ON WEBREPORTGROUP.ORGHIERARCHYPARENTID = MESSAGE.ORGANIZATIONID
  WHERE  ISNULL(@CallID,CALL.CALLID) = CALL.CALLID
         AND CALL.SOURCECODEID IN (SELECT SOURCECODEID
                                   FROM   DBO.FN_SOURCECODELIST (@ReportGroupID,@SourceCodeName ))
         --AND WEBREPORTGROUP.WEBREPORTGROUPID = ISNULL(@ReportGroupID,0)
         
         --LIMIT MESSAGE.OrganizationID
		 AND MESSAGE.OrganizationID = ISNULL(@MessageOrganizationID, MESSAGE.OrganizationID)
         AND (MESSAGE.MESSAGETYPEID = 2)



GO


