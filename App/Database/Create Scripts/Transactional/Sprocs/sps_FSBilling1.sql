SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_FSBilling1]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_FSBilling1]
GO


CREATE PROCEDURE sps_FSBilling1
		@CallId INT = 0,
		@vTZ	VARCHAR(2)

AS

DECLARE @TZ int      

EXEC spf_TZDif @vTZ, @TZ OUTPUT

SELECT	FSCaseId, 
	CallId, 
	FSCaseBillSecondaryUserId, 
	DATEADD(hh,@TZ,FSCaseBillDateTime) as 'FSCaseBillDateTime', 
	FSCaseBillFamUnavailUserId, 								--1/15/03 drh
	DATEADD(hh,@TZ,FSCaseBillFamUnavailDateTime) as 'FSCaseBillFamUnavailDateTime',	--1/15/03 drh
	FSCaseBillApproachUserId, 
	DATEADD(hh,@TZ,FSCaseBillApproachDateTime) as 'FSCaseBillApproachDateTime',
	FSCaseBillApproachCount,								--1/15/03 drh
	FSCaseBillMedSocUserId, 
	DATEADD(hh,@TZ,FSCaseBillMedSocDateTime) as 'FSCaseBillMedSocDateTime',
	FSCaseBillMedSocCount,								--1/15/03 drh
	FSCaseBillCryoFormUserId, 								--1/15/03 drh
	DATEADD(hh,@TZ,FSCaseBillCryoFormDateTime) as 'FSCaseBillCryoFormDateTime',	--1/15/03 drh
	FSCaseBillCryoFormCount,								--1/15/03 drh
	FSCaseUpdate, 
	FSCaseUserId, 
	
	

	seo.StatEmployeeFirstName + ' ' + SUBSTRING(seo.StatEmployeeLastName,1,1) AS FSCaseBillSecondaryPerson,
	sef.StatEmployeeFirstName + ' ' + SUBSTRING(sef.StatEmployeeLastName,1,1) AS FSCaseBillFamUnavailPerson,
	see.StatEmployeeFirstName + ' ' + SUBSTRING(see.StatEmployeeLastName,1,1) AS FSCaseBillApproachPerson,
	sec.StatEmployeeFirstName + ' ' + SUBSTRING(sec.StatEmployeeLastName,1,1) AS FSCaseBillMedSocPerson,
	sel.StatEmployeeFirstName + ' ' + SUBSTRING(sel.StatEmployeeLastName,1,1) AS FSCaseBillCryoFormPerson,
	sete.StatEmployeeFirstName + ' ' +SUBSTRING(sete.StatEmployeeLastName,1,1)AS FSCaseBillOTEPerson, 
	FSCaseBillOTEUserID,
	DATEADD(hh,@TZ,FSCaseBillOTEDateTime) as 'FSCaseBillOTEDateTime',		--T.T 11/01/2006
	FSCaseBillOTECount

FROM 	FSCase
LEFT 
JOIN 	statemployee seo ON seo.statemployeeid = fscase.FSCaseBillSecondaryUserId
LEFT 
JOIN 	statemployee sef ON sef.statemployeeid = fscase.FSCaseBillFamUnavailUserId
LEFT 
JOIN 	statemployee see ON see.statemployeeid = fscase.FSCaseBillApproachUserId
LEFT 
JOIN 	statemployee sec ON sec.statemployeeid = fscase.FSCaseBillMedSocUserId
LEFT 
JOIN 	statemployee sel ON sel.statemployeeid = fscase.FSCaseBillCryoFormUserId
LEFT 
JOIN 	statemployee sete ON sete.statemployeeid = fscase.FSCaseBillOTEUserId


WHERE 	callid = @CallId

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

