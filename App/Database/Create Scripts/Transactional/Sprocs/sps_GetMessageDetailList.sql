SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_GetMessageDetailList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_GetMessageDetailList]
GO



CREATE PROCEDURE sps_GetMessageDetailList

	@pvUserOrgID 	int 		=  0,
	@pvStartDate	datetime	=  null,
	@pvEndDate	datetime	=  null,
	@pvParent	int		=  0,
	@pvCallID	int		=  0,
	@pvSort   	varchar(30)	=  null 


 AS

SET CONCAT_NULL_YIELDS_NULL  OFF

	
	Declare @TZ varchar(2) ,
		@TZD int
	
	--GET TimeZone and Time Zone Difference
	SELECT @TZ = TimeZone.TimeZoneAbbreviation
	FROM Organization 
	LEFT JOIN TimeZone ON Organization.TimeZoneId = TimeZone.TimeZoneID
	where  OrganizationID = @pvParent

	Exec spf_TZDif @TZ, @TZD OUTPUT, @pvStartDate

IF @pvCallID = 0 

   If @pvSort = 'PersonLast'
      SELECT	MessageID, 
		Message.CallID, 
		Person.PersonFirst + RTRIM(' '+(Person.PersonMI)) + ' ' + Person.PersonLast AS PersonName,
		CallNumber, 	
		MessageCallerName, 
		TimeZone.TimeZoneAbbreviation 'OrganizationTimeZone', 
		MessageCallerOrganization, 
		StatPerson.PersonFirst + ' ' + StatPerson.PersonLast AS StatPerson, 
    		MessageCallerPhone, 
		MessageDescription, 
		MessageTypeName, 
		SourceCodeName 
       FROM 	Message 
       JOIN 	MessageType ON Message.MessageTypeID = MessageType.MessageTypeID 
       JOIN 	Call ON Call.CallID = Message.CallID 
       JOIN 	Person ON Person.PersonID = Message.PersonID 
       JOIN 	StatEmployee ON StatEmployee.StatEmployeeID = Call.StatEmployeeID 
       JOIN 	Person AS StatPerson ON StatPerson.PersonID = StatEmployee.PersonID 
       JOIN 	SourceCode ON SourceCode.SourceCodeID = Call.SourceCodeID 
       JOIN 	Organization ON Message.OrganizationID = Organization.OrganizationID
       LEFT JOIN TimeZone ON Organization.TimeZoneId = TimeZone.TimeZoneID
       WHERE	DATEADD(hour, @TZD, CallDateTime) BETWEEN @pvStartDate AND @pvEndDate
       AND 	Message.OrganizationID = @pvParent 
       AND 	Message.MessageTypeID <> 2
       ORDER BY  Person.PersonLast, Call.CallDateTime
   Else
      SELECT	MessageID, 
		Message.CallID, 
		Person.PersonFirst + RTRIM(' '+(Person.PersonMI)) + ' ' + Person.PersonLast AS PersonName,
		CallNumber, 	
		MessageCallerName, 
		TimeZone.TimeZoneAbbreviation 'OrganizationTimeZone', 
		MessageCallerOrganization, 
		StatPerson.PersonFirst + ' ' + StatPerson.PersonLast AS StatPerson, 
    		MessageCallerPhone, 
		MessageDescription, 
		MessageTypeName, 
		SourceCodeName 
       FROM 	Message 
       JOIN 	MessageType ON Message.MessageTypeID = MessageType.MessageTypeID 
       JOIN 	Call ON Call.CallID = Message.CallID 
       JOIN 	Person ON Person.PersonID = Message.PersonID 
       JOIN 	StatEmployee ON StatEmployee.StatEmployeeID = Call.StatEmployeeID 
       JOIN 	Person AS StatPerson ON StatPerson.PersonID = StatEmployee.PersonID 
       JOIN 	SourceCode ON SourceCode.SourceCodeID = Call.SourceCodeID 
       JOIN 	Organization ON Message.OrganizationID = Organization.OrganizationID
       LEFT JOIN TimeZone ON Organization.TimeZoneId = TimeZone.TimeZoneID
       WHERE	DATEADD(hour, @TZD, CallDateTime) BETWEEN @pvStartDate AND @pvEndDate
       AND 	Message.OrganizationID = @pvParent 
       AND 	Message.MessageTypeID <> 2
       ORDER BY  Call.CallDateTime, Person.PersonLast
      
ELSE

    SELECT	MessageID, 
		Message.CallID, 
		Person.PersonFirst + RTRIM(' '+(Person.PersonMI)) + ' ' + Person.PersonLast AS PersonName,
		CallNumber, 	
		MessageCallerName, 
		TimeZone.TimeZoneAbbreviation 'OrganizationTimeZone', 
		MessageCallerOrganization, 
		StatPerson.PersonFirst + ' ' + StatPerson.PersonLast AS StatPerson, 
    		MessageCallerPhone, 
		MessageDescription, 
		MessageTypeName, 
		SourceCodeName 
    FROM 	Message 
    JOIN 	MessageType ON Message.MessageTypeID = MessageType.MessageTypeID 
    JOIN 	Call ON Call.CallID = Message.CallID 
    JOIN 	Person ON Person.PersonID = Message.PersonID 
    JOIN 	StatEmployee ON StatEmployee.StatEmployeeID = Call.StatEmployeeID 
    JOIN 	Person AS StatPerson ON StatPerson.PersonID = StatEmployee.PersonID 
    JOIN 	SourceCode ON SourceCode.SourceCodeID = Call.SourceCodeID 
    JOIN 	Organization ON Message.OrganizationID = Organization.OrganizationID
    LEFT JOIN TimeZone ON Organization.TimeZoneId = TimeZone.TimeZoneID
    WHERE	Call.CallID = @pvCallID
   -- AND 	Message.OrganizationID = @pvParent 
    AND 	Message.MessageTypeID <> 2 
    ORDER BY 	Person.PersonLast, Message.MessageTypeID

SET CONCAT_NULL_YIELDS_NULL  ON






GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

