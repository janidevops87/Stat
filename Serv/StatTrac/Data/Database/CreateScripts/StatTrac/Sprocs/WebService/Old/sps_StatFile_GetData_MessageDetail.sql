SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_StatFile_GetData_MessageDetail]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_StatFile_GetData_MessageDetail]
GO


CREATE PROCEDURE sps_StatFile_GetData_MessageDetail
(
	@vOrgID as int,
	@vStartDate as datetime,
	@vEndDate as datetime,
	@vCreated bit,
	@vModified bit,
	@vLastRecord as int = 0
)

AS

DECLARE @vnumRec as int


SELECT top 1 @vnumRec = recordsreturned FROM StatFileOrgFrequency WHERE OrgID = @vOrgID
SET rowcount @vnumRec

IF (@vCreated = 1) AND (@vModified = 1)
	SELECT DISTINCT MessageID,Convert(char(25), dbo.fn_StatFile_ConvertDateTime(@vOrgID, Message.LastModified),120) AS LastModified, MessageID, CallNumber,Convert(char(25), dbo.fn_StatFile_ConvertDateTime(@vOrgID, CallDateTime),120) AS CallDateTime, StatEmployeeFirstName + ' ' + StatEmployeeLastName, Message.MessageTypeID, MessageTypeName, PersonFirst +  ' ' + PersonLast, OrganizationName, REPLACE(REPLACE(MessageDescription, CHAR(10), CHAR(32)), CHAR(13), '') AS 'MessageDescription', MessageCallerName, MessageCallerPhone, MessageCallerOrganization FROM Message JOIN Call ON Call.CallID = Message.CallID JOIN MessageType ON MessageType.MessageTypeID = Message.MessageTypeID JOIN StatEmployee ON StatEmployee.StatEmployeeID = Call.StatEmployeeID JOIN Organization ON Organization.OrganizationID = Message.OrganizationID JOIN Person ON Person.PersonID = Message.PersonID 
	WHERE Call.CallDateTime BETWEEN @vStartDate AND @vEndDate AND Message.OrganizationID = @vOrgID And MessageID > @vLastRecord  
	
	UNION

SELECT DISTINCT MessageID,Convert(char(25), dbo.fn_StatFile_ConvertDateTime(@vOrgID, Message.LastModified),120) AS LastModified, MessageID, CallNumber,Convert(char(25), dbo.fn_StatFile_ConvertDateTime(@vOrgID, CallDateTime),120) AS CallDateTime, StatEmployeeFirstName + ' ' + StatEmployeeLastName, Message.MessageTypeID, MessageTypeName, PersonFirst +  ' ' + PersonLast, OrganizationName, REPLACE(REPLACE(MessageDescription, CHAR(10), CHAR(32)), CHAR(13), '') AS 'MessageDescription', MessageCallerName, MessageCallerPhone, MessageCallerOrganization FROM Message JOIN Call ON Call.CallID = Message.CallID JOIN MessageType ON MessageType.MessageTypeID = Message.MessageTypeID JOIN StatEmployee ON StatEmployee.StatEmployeeID = Call.StatEmployeeID JOIN Organization ON Organization.OrganizationID = Message.OrganizationID JOIN Person ON Person.PersonID = Message.PersonID 
	 WHERE Message.LastModified BETWEEN @vStartDate AND @vEndDate AND Call.CallDateTime NOT BETWEEN @vStartDate  AND @vEndDate AND Message.OrganizationID = @vOrgID and MessageID > @vLastRecord  
	ORDER BY MessageID
ELSE IF (@vCreated = 1)
	SELECT DISTINCT MessageID,Convert(char(25), dbo.fn_StatFile_ConvertDateTime(@vOrgID, Message.LastModified),120) AS LastModified, MessageID, CallNumber,Convert(char(25), dbo.fn_StatFile_ConvertDateTime(@vOrgID, CallDateTime),120) AS CallDateTime, StatEmployeeFirstName + ' ' + StatEmployeeLastName, Message.MessageTypeID, MessageTypeName, PersonFirst +  ' ' + PersonLast, OrganizationName, REPLACE(REPLACE(MessageDescription, CHAR(10), CHAR(32)), CHAR(13), '') AS 'MessageDescription', MessageCallerName, MessageCallerPhone, MessageCallerOrganization FROM Message JOIN Call ON Call.CallID = Message.CallID JOIN MessageType ON MessageType.MessageTypeID = Message.MessageTypeID JOIN StatEmployee ON StatEmployee.StatEmployeeID = Call.StatEmployeeID JOIN Organization ON Organization.OrganizationID = Message.OrganizationID JOIN Person ON Person.PersonID = Message.PersonID 
	WHERE Call.CallDateTime BETWEEN @vStartDate AND @vEndDate AND Message.OrganizationID = @vOrgID And MessageID > @vLastRecord  
	ORDER BY MessageID
ELSE IF (@vModified = 1)
SELECT DISTINCT MessageID,Convert(char(25), dbo.fn_StatFile_ConvertDateTime(@vOrgID, Message.LastModified),120) AS LastModified, MessageID, CallNumber,Convert(char(25), dbo.fn_StatFile_ConvertDateTime(@vOrgID, CallDateTime),120) AS CallDateTime, StatEmployeeFirstName + ' ' + StatEmployeeLastName, Message.MessageTypeID, MessageTypeName, PersonFirst +  ' ' + PersonLast, OrganizationName, REPLACE(REPLACE(MessageDescription, CHAR(10), CHAR(32)), CHAR(13), '') AS 'MessageDescription', MessageCallerName, MessageCallerPhone, MessageCallerOrganization FROM Message JOIN Call ON Call.CallID = Message.CallID JOIN MessageType ON MessageType.MessageTypeID = Message.MessageTypeID JOIN StatEmployee ON StatEmployee.StatEmployeeID = Call.StatEmployeeID JOIN Organization ON Organization.OrganizationID = Message.OrganizationID JOIN Person ON Person.PersonID = Message.PersonID 
	 WHERE Message.LastModified BETWEEN @vStartDate AND @vEndDate AND Call.CallDateTime NOT BETWEEN @vStartDate  AND @vEndDate AND Message.OrganizationID = @vOrgID and MessageID > @vLastRecord  
	ORDER BY MessageID

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

