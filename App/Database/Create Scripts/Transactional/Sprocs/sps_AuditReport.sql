SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_AuditReport]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_AuditReport]
GO


CREATE PROCEDURE sps_AuditReport
	@CallId int

AS

SET NOCOUNT ON

/**********************REPORTING QUERIES**********************/

/*
--REFERRAL HEADER
select al.AuditLogId as 'Audit Id', 
	substring(at.AuditLogTypeName,1,10) + ' ' + substring(art.auditlogrecordtypename,1,15) as 'Audit Type', 
	--substring(art.auditlogrecordtypename,1,15) as 'Record Type', 
	al.AuditLogSourceRecordId as 'Referral #', 
	--al.AuditLogSourceParentId as SourceParentId, 
	--al.AuditLogPersonId, 
	substring(al.AuditLogPersonName,1,18) as 'Name', 
	substring(al.AuditLogOrganizationName,1,20) as 'Organization', 
	al.AuditLogServerDateTime as 'Server Date/Time',
	al.AuditLogLocalDateTime as 'User Date/Time'
	--al.AuditLogProcessed,
	--substring(ald1.AuditLogDetailNewValue, 1, 6) as 'SourceCode',
	--substring(ald2.AuditLogDetailNewValue, 1, 50) as 'Organization'
FROM auditlog al
JOIN auditlogtype at on al.auditlogtypeid = at.auditlogtypeid
JOIN auditlogrecordtype art on al.auditlogrecordtypeid = art.auditlogrecordtypeid
JOIN auditlogdetail ald1 ON al.AuditLogId = ald1.AuditLogId
JOIN auditlogdetail ald2 ON al.AuditLogId = ald2.AuditLogId
WHERE al.AuditLogRecordTypeId = 1
AND al.AuditLogTypeId = 1
AND al.AuditLogSourceRecordId = @CallId
AND ald1.AuditLogDetailFieldName = 'SourceCodeId'
AND ald2.AuditLogDetailFieldName = 'ReferralCallerOrganizationId'
ORDER BY al.AuditLogId
*/

--REFERRAL AUDIT LOGS
select al.AuditLogId as 'Audit Id',
	substring(at.AuditLogTypeName,1,10) + ' ' + substring(art.auditlogrecordtypename,1,15) as 'Audit Type', 
	--substring(art.auditlogrecordtypename,1,15) as AuditLogRecordType, 
	al.AuditLogSourceRecordId as 'Referral #', 
	--al.AuditLogSourceParentId as SourceParentId, 
	--al.AuditLogPersonId, 
	substring(al.AuditLogPersonName,1,18) as 'Name', 
	substring(al.AuditLogOrganizationName,1,20) as 'Organization', 
	al.AuditLogServerDateTime as 'Server Date/Time',
	al.AuditLogLocalDateTime as 'User Date/Time'
	--al.AuditLogProcessed
FROM auditlog al
JOIN auditlogtype at on al.auditlogtypeid = at.auditlogtypeid
JOIN auditlogrecordtype art on al.auditlogrecordtypeid = art.auditlogrecordtypeid
WHERE al.AuditLogRecordTypeId = 1
AND al.AuditLogSourceRecordId = @CallId
ORDER BY al.AuditLogId


--REFERRAL AUDIT LOG DETAIL
select al.AuditLogId as 'Audit Id', 
	ald.AuditLogDetailFieldName as 'Field Name', 
	ald.AuditLogDetailPreviousValue as 'Previous Value',
	ald.AuditLogDetailNewValue as 'Current Value'
from auditlog al
join auditlogdetail ald on al.auditlogid = ald.auditlogid
where al.AuditLogSourceRecordId = @CallId
and al.AuditLogRecordTypeId = 1
order by al.auditlogid

/*
--SECONDARY HEADER
select al.AuditLogId as 'Audit Id', 
	substring(at.AuditLogTypeName,1,10)  + ' ' + substring(art.auditlogrecordtypename,1,15) as 'Audit Type', 
	--substring(art.auditlogrecordtypename,1,15) as AuditLogRecordType, 
	--al.AuditLogSourceRecordId as SourceRecordId, 
	al.AuditLogSourceParentId as 'Referral #', 
	--al.AuditLogPersonId, 
	substring(al.AuditLogPersonName,1,18) as 'Name', 
	substring(al.AuditLogOrganizationName,1,20) as 'Organization', 
	al.AuditLogServerDateTime as 'Server Date/Time',
	al.AuditLogLocalDateTime as 'User Date/Time'
	--al.AuditLogProcessed
FROM auditlog al
JOIN auditlogtype at on al.auditlogtypeid = at.auditlogtypeid
JOIN auditlogrecordtype art on al.auditlogrecordtypeid = art.auditlogrecordtypeid
WHERE al.AuditLogRecordTypeId = 3
AND al.AuditLogTypeId = 1
AND al.AuditLogSourceRecordId = @CallId
ORDER BY al.AuditLogId
*/


--SECONDARY AUDIT LOGS
select al.AuditLogId as 'Audit Id', 
	substring(at.AuditLogTypeName,1,10) + ' ' + substring(art.auditlogrecordtypename,1,15) as 'Audit Type', 
	--substring(art.auditlogrecordtypename,1,15) as AuditLogRecordType, 
	--al.AuditLogSourceRecordId as 'Secondary #', 
	al.AuditLogSourceParentId as 'Referral #', 
	--al.AuditLogPersonId, 
	substring(al.AuditLogPersonName,1,18) as 'Name', 
	substring(al.AuditLogOrganizationName,1,20) as 'Organization', 
	al.AuditLogServerDateTime as 'Server Date/Time',
	al.AuditLogLocalDateTime as 'User Date/Time'
	--al.AuditLogProcessed
FROM auditlog al
JOIN auditlogtype at on al.auditlogtypeid = at.auditlogtypeid
JOIN auditlogrecordtype art on al.auditlogrecordtypeid = art.auditlogrecordtypeid
WHERE al.AuditLogRecordTypeId = 3
AND al.AuditLogSourceRecordId = @CallId
ORDER BY al.AuditLogId


--SECONDARY AUDIT LOG DETAIL
select al.AuditLogId as 'Audit Id', 
	ISNULL(ald.AuditLogDetailFieldName, '') as 'Field Name', 
	ISNULL(ald.AuditLogDetailPreviousValue, '')  as 'Previous Value',
	ISNULL(ald.AuditLogDetailNewValue, '')  as 'Current Value'
from auditlog al
join auditlogdetail ald on al.auditlogid = ald.auditlogid
where al.AuditLogSourceRecordId = @CallId
and al.AuditLogRecordTypeId = 3
order by al.auditlogid

/*
--LOG EVENT HEADERS
select al.AuditLogId as 'Audit Id', 
	substring(at.AuditLogTypeName,1,10) + ' ' + substring(art.auditlogrecordtypename,1,15) as 'Audit Type', 
	--substring(art.auditlogrecordtypename,1,15) as AuditLogRecordType, 
	--al.AuditLogSourceRecordId as SourceRecordId, 
	al.AuditLogSourceParentId as 'Referral #', 
	--al.AuditLogPersonId, 
	substring(al.AuditLogPersonName,1,18) as 'Name', 
	substring(al.AuditLogOrganizationName,1,20) as 'Organization', 
	al.AuditLogServerDateTime as 'Server Date/Time',
	al.AuditLogLocalDateTime as 'User Date/Time'
	--al.AuditLogProcessed,
	--substring(ald1.AuditLogDetailNewValue, 1, 20) as 'Log Event Date/Time'
	--LogEventTypeId
FROM auditlog al
JOIN auditlogtype at on al.auditlogtypeid = at.auditlogtypeid
JOIN auditlogrecordtype art on al.auditlogrecordtypeid = art.auditlogrecordtypeid
LEFT JOIN auditlogdetail ald1 on al.AuditLogId = ald1.AuditLogId
WHERE al.AuditLogRecordTypeId = 2
AND al.AuditLogTypeId = 1
AND al.AuditLogSourceParentId = @CallId
AND ald1.AuditLogDetailFieldName = 'LogEventDateTime'
ORDER BY al.AuditLogID
*/


--LOG EVENT AUDIT LOGS
select al.AuditLogId as 'Audit Id', 
	substring(at.AuditLogTypeName,1,10) + ' ' + substring(art.auditlogrecordtypename,1,15) as 'Audit Type', 
	--substring(art.auditlogrecordtypename,1,15) as AuditLogRecordType, 
	al.AuditLogSourceRecordId as 'Log Event #',
	--al.AuditLogSourceParentId as 'Referral #',
	--al.AuditLogPersonId, 
	substring(al.AuditLogPersonName,1,18) as 'Name', 
	substring(al.AuditLogOrganizationName,1,20) as 'Organization',
	al.AuditLogServerDateTime as 'Server Date/Time',
	al.AuditLogLocalDateTime as 'User Date/Time'
	--al.AuditLogProcessed
FROM auditlog al
JOIN auditlogtype at on al.auditlogtypeid = at.auditlogtypeid
JOIN auditlogrecordtype art on al.auditlogrecordtypeid = art.auditlogrecordtypeid
WHERE al.AuditLogRecordTypeId = 2
AND al.AuditLogSourceParentId = @CallId
ORDER BY al.AuditLogSourceRecordId, AuditLogId


--LOG EVENT AUDIT LOG DETAIL
select al.AuditLogId as 'Audit Id', 
	ald.AuditLogDetailFieldName as 'Field Name', 
	ald.AuditLogDetailPreviousValue as 'Previous Value',
	ald.AuditLogDetailNewValue as 'Current Value'
from auditlog al
join auditlogdetail ald on al.auditlogid = ald.auditlogid
where al.AuditLogSourceParentId = @CallId
and al.AuditLogRecordTypeId = 2
order by al.auditlogid




















GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

