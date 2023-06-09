SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_QueryOpenMessageLO]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_QueryOpenMessageLO]
GO





CREATE PROCEDURE sps_QueryOpenMessageLO
		@vStartPeriod	datetime = null,
		@vEndPeriod		datetime = null,
		@vTimeZoneDif	int 	 = null,
		@vTCMessageID	int	 = null,
		@vLeaseOrg		int	 = null

AS
/******************************************************************************
**		File: sps_QueryOpenMessageLO.sql
**		Name: sps_QueryOpenMessageLO
**		Desc: Obtains list of LogEvents with a status of pending
**
**              
**		Return values: returns partial logevent records
**		
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		@vStartPeriod	datetime = null,
**		@vEndPeriod		datetime = null,
**		@vTimeZoneDif	int 	 = null,
**		@vTCMessageID	int	 = null,
**		@vLeaseOrg		int	 = null
**		
**		Auth: Christopher Carroll
**		Date: 12/18/2006
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		12/18/2006	Christopher Carroll	Notes: If vTCMessageID has a value the WHERE statment 
**										returns message ID of Value provided.
**										If not, ALL message IDs are included.
**		5/25/2007	Bret Knoll			StatTrac v. 8.4 requirement 8.4.3.3.2
**										Added comment block
**										Added set transaction level
**		12/08/2009	ccarroll			Removed table alias in ORDER BY for SQL Server 2008 update.
**		03/16/2010	ccarroll			Added this note for inclusion in release
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

SELECT DISTINCT 
	Call.CallID, 
	Call.CallNumber, 
	DATEADD(hh, @vTimeZoneDif ,Call.CallDateTime) AS 'CallDateTime', 
	Person.PersonFirst+RTRIM(' '+(ISNULL(Person.PersonMI,'')))+' '+Person.PersonLast, 
	Organization.OrganizationName, 
	MessageType.MessageTypeName, 
	SourceCodeName, 
	CASE
		WHEN
			Message.MessageTypeID = 2
		THEN
			ISNULL(MessageImportCenter,'') + ' - ' + ISNULL(MessageImportPatient,'') + ' - ' + ISNULL(MessageImportUNOSID,'')
		ELSE 
			ISNULL(MessageCallerOrganization, '') + ' - ' + MessageCallerName
	END	, 
	'' AS Spacer, 
	PO.OrganizationID 
FROM 
	Call 
JOIN 
	Message ON Call.CallID = Message.CallID 
LEFT JOIN 
	Person ON Person.PersonID = Message.PersonID 
LEFT JOIN 
	Organization ON Organization.OrganizationID = Message.OrganizationID 
LEFT JOIN 
	State ON State.StateID = Organization.StateID 
LEFT JOIN 
	MessageType ON MessageType.MessageTypeID = Message.MessageTypeID 
LEFT JOIN 
	SourceCode ON SourceCode.SourceCodeID = Call.SourceCodeID 
LEFT JOIN 
	StatEmployee ON StatEmployee.StatEmployeeID = Call.StatEmployeeID 
LEFT JOIN 
	Person PO ON PO.PersonID = StatEmployee.PersonID 
LEFT JOIN 
	SourceCodeOrganization ON SourceCodeOrganization.SourceCodeID = SourceCode.SourceCodeID 
WHERE 
	CallDateTime <= @vEndPeriod
AND 
	CallDateTime >= @vStartPeriod
AND 
	CallActive <> 0 
AND 
	Message.MessageTypeID = ISNULL(@vTCMessageID,Message.MessageTypeID) 
AND 
	SourceCodeOrganization.OrganizationID = @vLeaseOrg  
ORDER BY 
	CallDateTime DESC;







GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

