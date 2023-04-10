IF EXISTS (SELECT *
           FROM   DBO.SYSOBJECTS
           WHERE  ID = OBJECT_ID(N'[dbo].[sps_rpt_ImportOfferActivity_Select]')
                  AND OBJECTPROPERTY(ID,N'IsProcedure') = 1)
  BEGIN
	  PRINT 'Dropping Procedure sps_rpt_ImportOfferActivity_Select'
	  DROP PROCEDURE [DBO].[sps_rpt_ImportOfferActivity_Select]
  END
  
GO
PRINT 'Creating Procedure sps_rpt_ImportOfferActivity_Select'
SET QUOTED_IDENTIFIER ON  

GO

SET ANSI_NULLS ON  

GO

CREATE PROCEDURE sps_rpt_ImportOfferActivity_Select
                @UserOrgID      INT  = NULL,
                @ReportGroupID  INT  = NULL,
                @CallID         INT  = NULL,
                @ImportOfferStartDateTime  DATETIME  = NULL,
                @ImportOfferEndDateTime    DATETIME  = NULL,
                @SourceCodeName VARCHAR(50),
                @MessageCallerOrganization VARCHAR(50),
                @MessageFor VARCHAR(50),
                @MessageForOrganizationID INT = Null,
                @DisplayMT      INT  = NULL
AS

  /******************************************************************************
**		File: 
**		Name: sps_rpt_ImportOfferActivity_Select
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
  
  IF @MessageCallerOrganization IS NOT Null
	BEGIN
		SET @MessageCallerOrganization = REPLACE(@MessageCallerOrganization,'*','%')
	END
  /*Null out dates if call id is populated */
  IF ISNULL(@CallID,0) <> 0
    BEGIN
      SET @ImportOfferStartDateTime = NULL
      SET @ImportOfferEndDateTime = NULL
      SET @MessageCallerOrganization = NULL
      SET @MessageFor = NULL
    END
    
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
		LT.CallDateTime AS BasedOnDT1,
		PERSON.PERSONLAST                            AS MessageForLastName,
		PERSONTYPE.PERSONTYPENAME,
		PERSON.PERSONFIRST + ' ' + PERSON.PERSONLAST AS PersonName,
		@CustomCode                                  AS 'ReportCustomCode',
		Message.MessageImportUNOSID, 
		Message.MessageImportCenter, 
		Message.MessageImportPatient,
		Alerts.AlertGroupName,
		Alerts.alertid
  FROM      CALL
  Join (SELECT 		
			CallID, 
			CallDateTime
		FROM dbo.fn_rpt_MessageDateTimeConversion 
		(
		@CallID						 ,
		@ImportOfferStartDateTime		 ,
		@ImportOfferEndDateTime		 ,
		@DisplayMT		 ) )LT ON 
		LT.CallID = Call.CallID 
INNER JOIN Message ON Message.CallID = Call.CallID 
LEFT JOIN Organization ON Organization.OrganizationID = Message.OrganizationID 
JOIN MessageType ON MessageType.MessageTypeID = Message.MessageTypeID 
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
				WHERE AlertTypeID = 4	
		 ) ALERTS ON ALERTS.OrganizationID = Message.OrganizationID 
AND ALERTS.SourcecodeID = Call.SourceCodeID	                      
INNER JOIN SourceCode ON Call.SourceCodeID = SourceCode.SourceCodeID

  WHERE  ISNULL(@CallID,CALL.CALLID) = CALL.CALLID
		/* Search - Organization message for*/
		AND IsNull(Message.OrganizationID, 0) = IsNull(ISNull(@MessageForOrganizationID, Message.OrganizationID), 0)

		AND ISNULL(PATINDEX(@MessageCallerOrganization, ISNULL(MessageCallerOrganization, 0)), -1) <> 0
        AND ISNULL(@MessageFor, ISNUll(Person.PersonID, 0)) = ISNUll(Person.PersonID, 0)                      
		AND CALL.SOURCECODEID IN (SELECT SOURCECODEID
                                   FROM   DBO.FN_SOURCECODELIST (@ReportGroupID,@SourceCodeName ))
         
         --LIMIT MESSAGE.OrganizationID
		 AND MESSAGE.OrganizationID = ISNULL(@MessageOrganizationID, MESSAGE.OrganizationID)                         
         AND (MESSAGE.MESSAGETYPEID = 2)
GO