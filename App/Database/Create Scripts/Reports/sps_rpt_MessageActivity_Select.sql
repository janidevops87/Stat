IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_rpt_MessageActivity_Select')
BEGIN
	DROP PROCEDURE sps_rpt_MessageActivity_Select;
	PRINT 'sps_rpt_MessageActivity_Select';
END
GO
PRINT 'Creating Procedure: sps_rpt_MessageActivity_Select';
GO

CREATE PROCEDURE [dbo].[sps_rpt_MessageActivity_Select]
                @UserOrgID      INT  = NULL,
                @ReportGroupID  INT  = NULL,
                @CallID         INT  = NULL,
                @MessageStartDateTime  DATETIME  = NULL,
                @MessageEndDateTime    DATETIME  = NULL,
                @SourceCodeName VARCHAR(50),
                @MessageCallerOrganization VARCHAR(50),
                @MessageFor VARCHAR(50),
                @MessageForOrganizationID INT = Null,
                @DisplayMT      INT  = NULL
AS

  /******************************************************************************
**		File: 
**		Name: sps_rpt_MessageActivity_Select
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
**		09/29/2008	ccarroll			Added Select sproc for Archive data
**		10/14/2008	Bret				removed distinct and change how alerts are queried
**      10/21/08    jth                 added  MessageForOrganizationID
**      02/09       JTH                 limit message org id to user org id 	
**      04/2009     jth                 changed BasedOnDT to BasedOnDT1 to handle sorting in report
**		02/19/2021	James Gerberich		Applied Report Group parameter to limit records. TFS 72897
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

  SELECT			
		CALL.CallID,
		MESSAGETYPE.MessageTypeName,
		CALL.CallNumber,
		ORGANIZATION.OrganizationName,
		MESSAGE.MessageCallerName,
		MessageCallerOrganization,
		MESSAGE.MessageCallerPhone,
		LT.CallDateTime AS 'BasedOnDT1',
		PERSON.PERSONLAST                            AS MessageForLastName,
		PERSONTYPE.PERSONTYPENAME,
		PERSON.PERSONFIRST + ' ' + PERSON.PERSONLAST AS PersonName,
		@CustomCode                                  AS 'ReportCustomCode',
		Alerts.AlertGroupName,
		Alerts.Alertid
  FROM      CALL
	  JOIN (SELECT 		
				CallID, 
				CallDateTime
			FROM dbo.fn_rpt_MessageDateTimeConversion 
			(
			@CallID						 ,
			@MessageStartDateTime		 ,
			@MessageEndDateTime		 ,
			@DisplayMT		 ) )LT ON 
						  LT.CallID = Call.CallID 
	INNER JOIN Message ON Message.CallID = Call.CallID 
	INNER JOIN WebReportGroupOrg wrgo ON wrgo.OrganizationID = Message.OrganizationID 
	LEFT JOIN Organization ON Organization.OrganizationID = Message.OrganizationID 
	INNER JOIN MessageType ON MessageType.MessageTypeID = Message.MessageTypeID 
	LEFT JOIN Person ON Person.PersonID = Message.PersonID 
	LEFT JOIN PersonType ON Person.PersonTypeID = PersonType.PersonTypeID 
	LEFT JOIN (
				SELECT     
					Alert.AlertID, 
					Alert.AlertGroupName, 
					AlertOrganization.OrganizationID, 
					AlertSourceCode.SourceCodeID
				FROM         
					Alert 
				INNER JOIN
					AlertSourceCode ON Alert.AlertID = AlertSourceCode.AlertID 
				INNER JOIN
					AlertOrganization ON Alert.AlertID = AlertOrganization.AlertID
				WHERE AlertTypeID = 2									  
			 ) ALERTS ON ALERTS.OrganizationID = Message.OrganizationID 
	AND ALERTS.SourcecodeID = Call.SourceCodeID	                      
	INNER JOIN SourceCode ON Call.SourceCodeID = SourceCode.SourceCodeID 
	JOIN
			(
				SELECT 
					SourceCodeID 
				FROM 
					dbo.fn_SourceCodeList
					(
						@ReportGroupID	, 
						@SourceCodeName
					)
			) SourceCodes ON SourceCodes.SourceCodeID = Call.SourceCodeID

	WHERE  
	wrgo.WebReportGroupID = @ReportGroupID
	AND
		(@CallID IS NULL OR CALL.CALLID = CALL.CALLID)
	AND 
		(@MessageCallerOrganization IS NULL OR PATINDEX(@MessageCallerOrganization, MessageCallerOrganization) <> 0)
	AND 
		(@MessageForOrganizationID IS NULL OR @MessageForOrganizationID = Message.OrganizationID)
	AND
		(@MessageFor IS NULL OR @MessageFor = Person.PersonID)
    --LIMIT MESSAGE.OrganizationID
	AND (@MessageOrganizationID IS NULL OR @MessageOrganizationID = MESSAGE.OrganizationID)
	AND (MESSAGE.MESSAGETYPEID <> 2)      
       

GO
