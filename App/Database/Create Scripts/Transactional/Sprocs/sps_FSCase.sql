SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_FSCase]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_FSCase]
GO

CREATE PROCEDURE sps_FSCase
		@CallId INT = 0

AS

SELECT FSCaseId, CallId, FSCaseCreateUserId, FSCaseCreateDateTime, FSCaseOpenUserId, FSCaseOpenDateTime,
FSCaseSysEventsUserId, FSCaseSysEventsDateTime, FSCaseSecCompUserId, FSCaseSecCompDateTime, 
FSCaseApproachUserId, FSCaseApproachDateTime, FSCaseFinalUserId, FSCaseFinalDateTime, FSCaseUpdate, FSCaseUserId, 

seo.StatEmployeeFirstName + ' ' + SUBSTRING(seo.StatEmployeeLastName,1,1) AS FSCaseOpenPerson,
see.StatEmployeeFirstName + ' ' + SUBSTRING(see.StatEmployeeLastName,1,1) AS FSCaseSysEventsPerson,
sec.StatEmployeeFirstName + ' ' + SUBSTRING(sec.StatEmployeeLastName,1,1) AS FSCaseSecCompPerson,
sea.StatEmployeeFirstName + ' ' + SUBSTRING(sea.StatEmployeeLastName,1,1) AS FSCaseApproachedPerson,
sef.StatEmployeeFirstName + ' ' + SUBSTRING(sef.StatEmployeeLastName,1,1) AS FSCaseFinalPerson

FROM FSCase
LEFT JOIN statemployee seo ON seo.statemployeeid = fscase.FSCaseOpenUserId
LEFT JOIN statemployee see ON see.statemployeeid = fscase.FSCaseSysEventsUserId
LEFT JOIN statemployee sec ON sec.statemployeeid = fscase.FSCaseSecCompUserId
LEFT JOIN statemployee sea ON sea.statemployeeid = fscase.FSCaseApproachUserId
LEFT JOIN statemployee sef ON sef.statemployeeid = fscase.FSCaseFinalUserId

WHERE callid = @CallId
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

