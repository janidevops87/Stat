SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_COD_GetAddresses]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_COD_GetAddresses]
GO


CREATE PROCEDURE sps_COD_GetAddresses
	@sourceCode varchar(7)
AS

SET NOCOUNT ON

DECLARE 	@currentMonth	varchar(2),
		@currentDay	varchar(2),
		@currentYear	varchar(4),
		@currentHour	varchar(2),
		@currentDate 	varchar(20)

SET @currentMonth =  DATEPART(mm,GetDate())
SET @currentDay = DATEPART(dd,GetDate())
SET @currentYear = DATEPART(yyyy,GetDate())
SET @currentHour = DATEPART(hh,GetDate()) - 1

SET @currentDate = @currentYear + '-' + @currentMonth + '-' + @currentDay + ' ' + @currentHour + ':00:00'

SELECT ISNULL(UPPER(c.OrganizationNotes),'') AS MailingLabelMessage,
	ISNULL(UPPER(a.CODCallerFirst),'') AS FirstName, 
	ISNULL(UPPER(a.CODCallerLast),'') AS LastName,
	ISNULL(UPPER(a.CODCallerAddress1),'') AS AddressLine1, 
	ISNULL(UPPER(a.CODCallerAddress2),'') AS AddressLine2,
	ISNULL(UPPER(a.CODCallerCity),'') AS City,
	ISNULL(b.StateAbbrv,'') AS State,
	ISNULL(a.CODCallerZip,'') AS Zip
FROM CODCaller a
JOIN State b ON b.StateID = a.StateID
JOIN Call d ON d.CallID = a.CallID
JOIN Organization c ON c.OrganizationID = a.OrganizationID
JOIN SourceCode e ON e.SourceCodeID = d.SourceCodeID
WHERE a.CODCallerLabelStatus = 1
AND e.SourceCodeName = @sourceCode
AND d.CallDateTime < CONVERT(varchar(20),@currentDate, 20)
ORDER BY b.StateAbbrv, a.CODCallerLast


SET NOCOUNT OFF
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

