IF EXISTS (SELECT *
           FROM   DBO.SYSOBJECTS
           WHERE  ID = OBJECT_ID(N'[dbo].[sps_rpt_MessageActivity_count_select]')
                  AND OBJECTPROPERTY(ID,N'IsProcedure') = 1)
  BEGIN
	DROP PROCEDURE [DBO].[SPS_RPT_MessageActivity_count_select]
	PRINT 'Dropping procedure: sps_rpt_MessageActivity_count_select'
  END
	PRINT 'Creating procedure: sps_rpt_MessageActivity_count_select'
GO

SET QUOTED_IDENTIFIER ON  

GO

SET ANSI_NULLS ON  

GO


CREATE PROCEDURE sps_rpt_MessageActivity_count_select
                @UserOrgID      INT  = NULL,
                @ReportGroupID  INT  = NULL,
                @CallID         INT  = NULL,
                @StartDateTime  DATETIME  = NULL,
                @EndDateTime    DATETIME  = NULL,
                @SourceCodeName VARCHAR(50),
                @MessageCallerOrganization VARCHAR(50),
                @MessageFor VARCHAR(50),
                @MessageForOrganizationID INT = Null,
                @DisplayMT      INT  = NULL
AS

  /******************************************************************************
**		File: 
**		Name: sps_rpt_MessageActivity_count
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
**		09/29/2008	ccarroll			Placed into select sproc for Archive data  
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
  /*Null out dates if call id is populated */
  IF ISNULL(@CallID,0) <> 0
    BEGIN
      SET @StartDateTime = NULL
      
      SET @EndDateTime = NULL
    END
    
  /* Set CustomCode */
--  EXEC @CustomCode = SPS_RPT_CHECKCUSTOMREPORTUSERORG
--    @UserOrgID ,
--    @Results OUTPUT
  
  SELECT COUNT(DISTINCT Call.CallID) 'RecordCount'
  FROM      CALL
  Join (SELECT 		
			CallID, 
			CallDateTime
		FROM dbo.fn_rpt_MessageDateTimeConversion 
		(
		@CallID						 ,
		@StartDateTime		 ,
		@EndDateTime		 ,
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
       
GROUP BY
Call.CALLID,
Alerts.AlertID
GO
  