if exists (select 1 from dbo.sysobjects where id = object_id(N'[dbo].[sps_FSCaseWithSecondaryBilling]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
begin
	print 'drop procedure [dbo].[sps_FSCaseWithSecondaryBilling]';
	drop procedure [dbo].[sps_FSCaseWithSecondaryBilling];
end
GO
	print 'create procedure [dbo].[sps_FSCaseWithSecondaryBilling]';
GO




-- exec sps_FSCaseWithSecondaryBilling 1953974 , MT
CREATE PROCEDURE sps_FSCaseWithSecondaryBilling
		@CallId INT = 0,
		@vTZ	VARCHAR(2)

AS

/******************************************************************************
**		File: sps_FSCaseWithSecondaryBilling.sql
**		Name: sps_FSCaseWithSecondaryBilling
**		Desc: Loads FSCase and SecondaryBilling data
**
**              
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		See List
**
**		Auth: Mike Berenson
**		Date: 11/27/2018
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**    
*******************************************************************************/

DECLARE @TZ int;      

EXEC spf_TZDif @vTZ, @TZ OUTPUT;

SELECT	FSCaseId, 
	CallId, 
	FSCaseCreateUserId, 
	DATEADD(hh,@TZ,FSCaseCreateDateTime) as 'FSCaseCreateDateTime', 
	FSCaseOpenUserId, 
	DATEADD(hh,@TZ,FSCaseOpenDateTime) as 'FSCaseOpenDateTime',
	FSCaseSysEventsUserId, 
	DATEADD(hh,@TZ,FSCaseSysEventsDateTime) as 'FSCaseSysEventsDateTime', 
	FSCaseSecCompUserId, 
	DATEADD(hh,@TZ,FSCaseSecCompDateTime) as 'FSCaseSecCompDateTime', 
	FSCaseApproachUserId, 
	DATEADD(hh,@TZ,FSCaseApproachDateTime) as 'FSCaseApproachDateTime', 
	FSCaseFinalUserId, 
	DATEADD(hh,@TZ,FSCaseFinalDateTime) as 'FSCaseFinalDateTime', 
	FSCaseUpdate, 
	FSCaseUserId, 
	seo.StatEmployeeFirstName + ' ' + SUBSTRING(seo.StatEmployeeLastName,1,1) AS FSCaseOpenPerson,
	see.StatEmployeeFirstName + ' ' + SUBSTRING(see.StatEmployeeLastName,1,1) AS FSCaseSysEventsPerson,
	sec.StatEmployeeFirstName + ' ' + SUBSTRING(sec.StatEmployeeLastName,1,1) AS FSCaseSecCompPerson,
	sea.StatEmployeeFirstName + ' ' + SUBSTRING(sea.StatEmployeeLastName,1,1) AS FSCaseApproachedPerson,
	sef.StatEmployeeFirstName + ' ' + SUBSTRING(sef.StatEmployeeLastName,1,1) AS FSCaseFinalPerson,
	
	--Billing Fields
	FSCaseBillSecondaryUserId,	
	DATEADD(hh,@TZ,FSCaseBillDateTime) as 'FSCaseBillDateTime', 	
	FSCaseBillFamUnavailUserId, 								
	DATEADD(hh,@TZ,FSCaseBillFamUnavailDateTime) as 'FSCaseBillFamUnavailDateTime',
	FSCaseBillApproachUserId, 
	DATEADD(hh,@TZ,FSCaseBillApproachDateTime) as 'FSCaseBillApproachDateTime',
	FSCaseBillApproachCount,								
	FSCaseBillMedSocUserId, 
	DATEADD(hh,@TZ,FSCaseBillMedSocDateTime) as 'FSCaseBillMedSocDateTime',
	FSCaseBillMedSocCount,								
	FSCaseBillCryoFormUserId, 							
	DATEADD(hh,@TZ,FSCaseBillCryoFormDateTime) as 'FSCaseBillCryoFormDateTime',	
	FSCaseBillCryoFormCount,	
	sebs.StatEmployeeFirstName + ' ' + SUBSTRING(sebs.StatEmployeeLastName,1,1) AS FSCaseBillSecondaryPerson,
	sebf.StatEmployeeFirstName + ' ' + SUBSTRING(sebf.StatEmployeeLastName,1,1) AS FSCaseBillFamUnavailPerson,
	seba.StatEmployeeFirstName + ' ' + SUBSTRING(seba.StatEmployeeLastName,1,1) AS FSCaseBillApproachPerson,
	sebm.StatEmployeeFirstName + ' ' + SUBSTRING(sebm.StatEmployeeLastName,1,1) AS FSCaseBillMedSocPerson,
	sebc.StatEmployeeFirstName + ' ' + SUBSTRING(sebc.StatEmployeeLastName,1,1) AS FSCaseBillCryoFormPerson,
	sebo.StatEmployeeFirstName + ' ' + SUBSTRING(sebo.StatEmployeeLastName,1,1) AS FSCaseBillOTEPerson, 
	FSCaseBillOTEUserID,
	DATEADD(hh,@TZ,FSCaseBillOTEDateTime) as 'FSCaseBillOTEDateTime',
	FSCaseBillOTECount		

FROM 	FSCase
	LEFT JOIN statemployee seo ON seo.statemployeeid = fscase.FSCaseOpenUserId
	LEFT JOIN statemployee see ON see.statemployeeid = fscase.FSCaseSysEventsUserId
	LEFT JOIN statemployee sec ON sec.statemployeeid = fscase.FSCaseSecCompUserId
	LEFT JOIN statemployee sea ON sea.statemployeeid = fscase.FSCaseApproachUserId
	LEFT JOIN statemployee sef ON sef.statemployeeid = fscase.FSCaseFinalUserId
	LEFT JOIN statemployee sebs ON sebs.statemployeeid = fscase.FSCaseBillSecondaryUserId
	LEFT JOIN statemployee sebf ON sebf.statemployeeid = fscase.FSCaseBillFamUnavailUserId
	LEFT JOIN statemployee seba ON seba.statemployeeid = fscase.FSCaseBillApproachUserId
	LEFT JOIN statemployee sebm ON sebm.statemployeeid = fscase.FSCaseBillMedSocUserId
	LEFT JOIN statemployee sebc ON sebc.statemployeeid = fscase.FSCaseBillCryoFormUserId
	LEFT JOIN statemployee sebo ON sebo.statemployeeid = fscase.FSCaseBillOTEUserId
WHERE 	callid = @CallId;




GO
