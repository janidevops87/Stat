IF EXISTS (SELECT *
           FROM   DBO.SYSOBJECTS
           WHERE  ID = OBJECT_ID(N'[dbo].[sps_rpt_MessageActivity_Select]')
                  AND OBJECTPROPERTY(ID,N'IsProcedure') = 1)
BEGIN
  PRINT 'Dropping Procedure sps_rpt_MessageActivity_Select'
  DROP PROCEDURE [DBO].[sps_rpt_MessageActivity_Select]
END
GO
PRINT 'Creating Procedure sps_rpt_MessageActivity_Select'
SET QUOTED_IDENTIFIER ON  

GO

SET ANSI_NULLS ON  

GO


CREATE PROCEDURE sps_rpt_MessageActivity_Select
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

	WHERE  
		ISNULL(@CallID,CALL.CALLID) = CALL.CALLID
	AND 
		ISNULL(PATINDEX(@MessageCallerOrganization, ISNULL(MessageCallerOrganization, 0)), -1) <> 0
	AND 
		IsNull(Message.OrganizationID, 0) = IsNull(ISNull(@MessageForOrganizationID, Message.OrganizationID), 0)
	AND
		ISNULL(@MessageFor,ISNULL(Person.PersonID, 0)) = ISNULL(Person.PersonID, 0)
	AND 
		CALL.SOURCECODEID IN (SELECT SOURCECODEID
                                   FROM   DBO.FN_SOURCECODELIST (@ReportGroupID,@SourceCodeName ))
    
    --LIMIT MESSAGE.OrganizationID
	AND MESSAGE.OrganizationID = ISNULL(@MessageOrganizationID, MESSAGE.OrganizationID)
	AND (MESSAGE.MESSAGETYPEID <> 2)      
       
GO
 