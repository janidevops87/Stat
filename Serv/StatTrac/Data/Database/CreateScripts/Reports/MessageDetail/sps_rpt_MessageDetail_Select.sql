IF EXISTS
	(
		SELECT	*
		FROM	DBO.SYSOBJECTS
		WHERE	ID = OBJECT_ID(N'[dbo].[sps_rpt_MessageDetail_Select]')
			AND OBJECTPROPERTY(ID,N'IsProcedure') = 1
	)
	BEGIN
		PRINT 'Dropping Procedure: sps_rpt_MessageDetail_Select'
		DROP PROCEDURE [dbo].[sps_rpt_MessageDetail_Select]
	END
		PRINT 'Creating Procedure: sps_rpt_MessageDetail_Select'

GO

SET QUOTED_IDENTIFIER ON  

GO

SET ANSI_NULLS ON  

GO

CREATE PROCEDURE sps_rpt_MessageDetail_Select
	@UserOrgID      INT  = NULL,
	@ReportGroupID  INT  = NULL,
	@CallID         INT  = NULL,
	@StartDateTime  DATETIME  = NULL,
	@EndDateTime    DATETIME  = NULL,
	@SourceCodeName VARCHAR(50),
	@DisplayMT      INT  = NULL
AS

 /******************************************************************************
**		File: sps_rpt_MessageDetail_Select.sql
**		Name: sps_rpt_MessageDetail_Select
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
**		Date: 2/08
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	-------				----------------------------------------
**		10/01/2008	ccarroll			Added for Archive and Production databases
**      02/09       JTH                 limit message org id to user org id
**		03/14/2010	James Gerberich		Added phone extension to MessageCallerPhone
**										column. HS #22712
**		06/16/2010	Bret				Modified to Include in Release
*******************************************************************************/
SET TRANSACTION ISOLATION  LEVEL  READ  UNCOMMITTED

DECLARE
	@CustomCode				Int,
	@Results				Int,
	@MessageOrganizationID	Int

-- CHECK FOR STATLINE AND SET PARAM
IF (@UserOrgID = 194)
	BEGIN
		SET @MessageOrganizationID = NULL
	END
ELSE
	BEGIN
		SET @MessageOrganizationID = @UserOrgID
	END
  
/* Set CustomCode */
EXEC
	@CustomCode = sps_rpt_CheckCustomReportUserOrg
	@UserOrgID,
	@Results OUTPUT

SELECT DISTINCT
	CALL.CallID,
	MESSAGETYPE.MessageTypeName,
	CALL.CallNumber,
	ORGANIZATION.OrganizationName,
	MESSAGE.MessageCallerName,
	MESSAGE.MessageCallerOrganization,
	MESSAGE.MessageCallerPhone + IsNull(' x' + CAST(MESSAGE.MessageExtension AS VarChar(5)), ' No Ext'),
	LT.CallDateTime AS CallDateTime,
	--CONVERT(varchar, LT.CallDateTime, 1) AS CallDate,
	--CONVERT(varchar, LT.CallDateTime, 8) AS CallTime,
	MESSAGE.MessageUrgent,
	MESSAGE.MessageDescription,
	PERSON.PersonLast								AS MessageForLastName,
	PERSONTYPE.PersonTypeName,
	PERSON.PersonFirst + ' ' + PERSON.PersonLast	AS PersonName,
	@CustomCode										AS 'ReportCustomCode',
	(
		SELECT TOP 1
			SC.SourceCodeName
		FROM
			SOURCECODE AS SC
		WHERE
			SC.SourceCodeID = CALL.SourceCodeID
	)												AS SourceCodeName,
	(
		SELECT TOP
			1 PERSON.PersonFirst + ' ' + PERSON.PersonLast
		FROM
			LOGEVENT
		LEFT OUTER JOIN STATEMPLOYEE ON STATEMPLOYEE.StatEmployeeID = LOGEVENT.StatEmployeeID
		LEFT OUTER JOIN PERSON ON PERSON.PersonID = STATEMPLOYEE.PersonID
		WHERE
			LOGEVENT.CallID = CALL.CallID
	)												AS TrigageCoord
FROM
	CALL
	JOIN
		(
			SELECT 		
				CallID, 
				CallDateTime
			FROM
				dbo.fn_rpt_MessageDateTimeConversion 
					(
						@CallID,
						@StartDateTime,
						@EndDateTime,
						@DisplayMT
					)
		) LT						ON LT.CallID = Call.CallID
	INNER JOIN MESSAGE				ON MESSAGE.CallID = CALL.CallID
	INNER JOIN ORGANIZATION			ON ORGANIZATION.OrganizationID = MESSAGE.OrganizationID
	INNER JOIN MESSAGETYPE			ON MESSAGETYPE.MessageTypeID = MESSAGE.MessageTypeID
	INNER JOIN PERSON				ON PERSON.PersonID = MESSAGE.PersonID
	INNER JOIN PERSONTYPE			ON PERSON.PersonTypeID = PERSONTYPE.PersonTypeID
	INNER JOIN WebReportGroupOrg	ON WebReportGroupOrg.OrganizationID = MESSAGE.OrganizationID 
WHERE
	ISNULL(@CallID,CALL.CallID) = CALL.CallID
	AND CALL.SourceCodeID IN
		(
			SELECT
				SourceCodeID
			FROM
				dbo.fn_SourceCodeList (@ReportGroupID,@SourceCodeName)
		)
--LIMIT MESSAGE.OrganizationID
	AND MESSAGE.OrganizationID = ISNULL(@MessageOrganizationID, MESSAGE.OrganizationID)
	AND MESSAGE.MessageTypeID <> 2

GO