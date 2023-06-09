SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_StatFileMessageDetail]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_StatFileMessageDetail]
GO

CREATE Procedure sps_StatFileMessageDetail
	@vUserName as varchar(50),
	@vPassword as varchar(50),
	@vStartDateTime as datetime,
	@vEndDateTime as datetime,
	@vCreated bit,
	@vModified bit,
	@vLastRecord as int = 0
AS

/******************************************************************************
**		File: 
**		Name: sps_StatFileMessageDetail
**		Desc: 
**
**		This procedure selects all data required for the Message Detail file. 
**		
**		Called by:  
** 
**      StatFile.Net        
**
**		
**		Auth: Statline
**		Date: 10/10/2006
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**    
*******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 


DECLARE @vnumRec int,
		@vOrgID int
		
SET @vnumRec = 0
/* This table is declare and then loaded by a function. I tried to put the function 
	within in the join and then within the where clause. When the function was inline not all data
	was returned.	
 */
DECLARE @CallIDTable TABLE
		(
			CallID int
		)
INSERT @CallIDTable
	select CallID from dbo.fn_GetCallIDList(@vStartDateTime, @vEndDateTime, @vCreated, @vModified)		

SET @vOrgID	= dbo.fn_GetOrganizationID(@vUserName, @vPassword)

select @vnumRec = recordsreturned from StatFileOrgFrequency where OrgID = @vOrgID
set rowcount @vnumRec

	SELECT DISTINCT 
		MessageID,
		Convert(char(25), dbo.fn_StatFile_ConvertDateTime(@vOrgID, Message.LastModified),120) AS LastModified, 
		MessageID, 
		CallNumber,
		Convert(char(25), dbo.fn_StatFile_ConvertDateTime(@vOrgID, CallDateTime),120) AS CallDateTime, 
		StatEmployeeFirstName + ' ' + StatEmployeeLastName, 
		Message.MessageTypeID, 
		MessageTypeName, 
		PersonFirst +  ' ' + PersonLast, 
		OrganizationName, 
		REPLACE(REPLACE(MessageDescription, CHAR(10), CHAR(32)), CHAR(13), '') AS 'MessageDescription', 
		MessageCallerName, 
		MessageCallerPhone, 
		MessageCallerOrganization 
	FROM 
		Message 
	JOIN 
		Call ON Call.CallID = Message.CallID 
	JOIN 
		MessageType ON MessageType.MessageTypeID = Message.MessageTypeID 
	JOIN 
		StatEmployee ON StatEmployee.StatEmployeeID = Call.StatEmployeeID 
	JOIN 
		Organization ON Organization.OrganizationID = Message.OrganizationID 
	JOIN 
		Person ON Person.PersonID = Message.PersonID 
	WHERE 
		Message.CallID IN (select CallID from @CallIDTable )
	AND 
		Message.OrganizationID = @vOrgID 
	AND 
		MessageID > @vLastRecord  	
	ORDER BY 
		MessageID



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

