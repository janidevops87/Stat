SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_AuditEnumerateLogEventIds]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_AuditEnumerateLogEventIds]
GO


CREATE PROCEDURE sps_AuditEnumerateLogEventIds
	@CallId int

AS

CREATE TABLE #Audit(LogEventId int, AuditLogId int)

INSERT INTO #Audit
select al.auditlogsourcerecordid, max(al.AuditLogid) as 'AuditLogId' from auditlog al
join auditlogdetail ald on al.auditlogid = ald.auditlogid
where al.auditlogsourceparentid = @CallId
and al.auditlogsourcerecordid not in(
	select auditlogsourcerecordid from auditlog 
	where auditlogsourceparentid = @CallId 
	and auditlogtypeid = 4)
and ald.AuditLogDetailFieldName = 'LogEventDateTime'
group by al.auditlogsourcerecordid
order by AuditLogId

--select * from #audit

select ta.LogEventId, ta.AuditLogId, ald.auditlogdetailnewvalue from #Audit ta
join auditlogdetail ald on ta.auditlogid = ald.auditlogid
where ald.auditlogdetailfieldname = 'LogEventDateTime'
order by ald.auditlogdetailnewvalue asc






GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

