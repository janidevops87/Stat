SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_StatFileMessageDetailLastMod]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_StatFileMessageDetailLastMod]
GO





CREATE PROCEDURE sps_StatFileMessageDetailLastMod
			@vOrgID as int,
			@vStartDate as datetime,
			@vEndDate as datetime,
			@vLastRecord as int = 0

AS

/**	12/08/2009	ccarroll	Removed table alias in ORDER BY for SQL Server 2008 update **/
declare
		@vOrgTZ as varchar(20),
		@vOrgTZdiff as int,
		@vnumRec as int

 

--Get OrganizationTimeZone
SELECT @vOrgTZ = TimeZone.TimeZoneAbbreviation 
		from Organization 
		join TimeZone ON Organization.TimeZoneID = TimeZone.TimeZoneID
		where OrganizationID = @vOrgID
 --select @vOrgTZdiff = exec spf_TimeZone @vOrgTZ

SELECT @vOrgTZdiff = 
                    CASE @vOrgTZ
                    When 'AT' Then 3                    
                    When 'AS' Then 3                    
                    When 'ET' Then 2
                    When 'ES' Then 2
                    When 'CT' Then 1
                    When 'CS' Then 1
                    When 'MT' Then 0
                    When 'MS' Then 0
                    When 'PT' Then -1
                    When 'PS' Then -1
                    When 'KT' Then -2
                    When 'KS' Then -2
                    When 'HT' Then -3
                    When 'HS' Then -3
                    When 'ST' Then -4                                                              
                    When 'SS' Then -4                                                              
                    END


select @vnumRec = recordsreturned from StatFileOrgFrequency where OrgID = @vOrgID
set rowcount @vnumRec
/* FileMessageDetail */ SELECT DISTINCT MessageID, DATEADD(hour, @vOrgTZdiff, Message.LastModified) AS LastModified, MessageID, CallNumber, DATEADD(hour, @vOrgTZdiff, CallDateTime) AS CallDateTime, StatEmployeeFirstName + ' ' + StatEmployeeLastName, Message.MessageTypeID, MessageTypeName, PersonFirst +  ' ' + PersonLast, OrganizationName, REPLACE(REPLACE(MessageDescription, CHAR(10), CHAR(32)), CHAR(13), '') AS 'MessageDescription', MessageCallerName, MessageCallerPhone, MessageCallerOrganization FROM Message JOIN Call ON Call.CallID = Message.CallID JOIN MessageType ON MessageType.MessageTypeID = Message.MessageTypeID JOIN StatEmployee ON StatEmployee.StatEmployeeID = Call.StatEmployeeID JOIN Organization ON Organization.OrganizationID = Message.OrganizationID JOIN Person ON Person.PersonID = Message.PersonID
 WHERE Message.LastModified BETWEEN @vStartDate AND @vEndDate AND Call.CallDateTime NOT BETWEEN @vStartDate  AND @vEndDate AND Message.OrganizationID = @vOrgID and MessageID > @vLastRecord  
 ORDER BY LastModified



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

