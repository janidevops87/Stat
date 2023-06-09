SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_FSBilling]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_FSBilling]
GO


CREATE PROCEDURE sps_FSBilling
		@CallId INT = 0,
		@vTZ	VARCHAR(2)

AS

DECLARE @TZ int      

EXEC spf_TZDif @vTZ, @TZ OUTPUT

SELECT	FSCaseId, 
	CallId, 
	FSCaseBillSecondaryUserId, 
	DATEADD(hh,@TZ,FSCaseBillDateTime) as 'FSCaseBillDateTime', 
	FSCaseBillApproachUserId, 
	DATEADD(hh,@TZ,FSCaseBillApproachDateTime) as 'FSCaseBillApproachDateTime',
	FSCaseBillMedSocUserId, 
	DATEADD(hh,@TZ,FSCaseBillMedSocDateTime) as 'FSCaseBillMedSocDateTime',
	FSCaseUpdate, 
	FSCaseUserId, 

	seo.StatEmployeeFirstName + ' ' + SUBSTRING(seo.StatEmployeeLastName,1,1) AS FSCaseBillSecondaryPerson,
	see.StatEmployeeFirstName + ' ' + SUBSTRING(see.StatEmployeeLastName,1,1) AS FSCaseBillApproachPerson,
	sec.StatEmployeeFirstName + ' ' + SUBSTRING(sec.StatEmployeeLastName,1,1) AS FSCaseBillMedSocPerson

FROM 	FSCase
LEFT 
JOIN 	statemployee seo ON seo.statemployeeid = fscase.FSCaseBillSecondaryUserId
LEFT 
JOIN 	statemployee see ON see.statemployeeid = fscase.FSCaseBillApproachUserId
LEFT 
JOIN 	statemployee sec ON sec.statemployeeid = fscase.FSCaseBillMedSocUserId


WHERE 	callid = @CallId


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

