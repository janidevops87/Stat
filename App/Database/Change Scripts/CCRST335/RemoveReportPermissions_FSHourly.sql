/******************************************************************************
**		File: RemoveReportPermissions_FSHourly.sql
**		Name: RemoveReportPermissions_FSHourly
**		Desc: Removes report permissions for the report FSHourly -
**				because we're not using it anymore
**
**		Auth: Mike Berenson
**		Date: 11/09/2020
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**      11/09/2020	Mike Berenson		initial
**		11/12/2020	Mike Berenson		Added removal of additional dependencies in 
**											ReportParamConfiguration and ReportDateTimeConfiguration
**		11/12/2020	Mike Berenson		Added @ReportID variable to make reuse easier
*******************************************************************************/

DECLARE @ReportID INT = 197;

/*
-- Find ReportRule records for FSHourly
select *
from ReportParamConfiguration
where ReportID = @ReportID;

select *
from ReportDateTimeConfiguration
where ReportID = @ReportID;

select *
from ReportRule
where ReportID = @ReportID;

-- Find Report records for FSHourly
select *
from Report
where ReportID = @ReportID;

*/

delete
from ReportParamConfiguration
where ReportID = @ReportID;


delete
from ReportDateTimeConfiguration
where ReportID = @ReportID;


delete  
from ReportRule
where ReportID = @ReportID;


delete
from Report
where ReportID = @ReportID;


/*
TEST (PRE-UPDATE)

ReportParamConfiguration
ReportParamConfiguration	ReportID	ReportControlID
691	197	2
692	197	3
693	197	6
694	197	7

ReportDateTimeConfiguration
ReportDateTimeConfigurationID	ReportID	ReportDateTimeID	IsArchived	IsDateOnly
60	197	NULL	0	0

ReportRule
ReportRuleID	ReportID	RoleID	LastStatEmployeeID	AuditLogTypeID	LastModified
4	197	3	NULL	NULL	NULL
46	197	3	NULL	NULL	NULL
59	197	3	NULL	NULL	NULL
94	197	3	NULL	NULL	NULL
100	197	3	NULL	NULL	NULL

Report
ReportID	ReportDisplayName	LastModified	ReportLocalOnly	ReportVirtualURL	ReportTypeID	Unused	ReportDescFileName	UpdatedFlag	ReportSortOrderID	ReportInDevelopment	ReportFromDate	ReportToDate	ReportGroup	ReportOrganization
197	FS Hourly (new)	2020-10-26 11:18:00.060	0	/StatTrac Test/FS Hourly	4	NULL	nodesc.shm	NULL	NULL	NULL	NULL	NULL	NULL	NULL


PROD (PRE-UPDATE)

ReportParamConfiguration


ReportDateTimeConfiguration


ReportRule




Report


*/