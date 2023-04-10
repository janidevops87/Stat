 SELECT r.ReportID, ReportDisplayName, ReportVirtualURL, rt.REPORTTYPENAME FROM REPORT r
JOIN ReportType rt ON rt.ReportTypeID = r.ReportTypeID
WHERE ReportID > 194
order by ReportDisplayName

SELECT ReportDisplayName, rc.ReportControlName  FROM REPORT r
JOIN ReportParamConfiguration rpc ON rpc.ReportID = r.ReportID
JOIN ReportControl rc ON rc.ReportControlID = rpc.ReportControlID
WHERE r.ReportID > 194
order by ReportDisplayName, ReportParamSectionID, rc.ReportControlID

SELECT distinct ReportDisplayName, rst.ReportSortTypeDisplayname, rst.ReportSortTypeName  FROM REPORT r
JOIN ReportSortTypeConfiguration rsc ON rsc.ReportID = r.ReportID
JOIN ReportSortType rst ON rst.ReportSortTypeID = rsc.ReportSortTypeID
WHERE r.ReportID > 194
order by ReportDisplayName, ReportSortTypeDisplayname

SELECT distinct ReportDisplayName, ISNULL(ReportDateTimeName, '')ReportDateTimeName  FROM REPORT r
LEFT JOIN ReportDateTimeConfiguration config ON config.ReportID = r.ReportID
LEFT JOIN ReportDateTime configD ON configD.ReportDateTimeID = config.ReportDateTimeID
WHERE r.ReportID > 194
order by ReportDisplayName, ReportDateTimeName

SELECT  ReportDisplayName, ISNULL(ReportDateTypeDisplayname, '')ReportDateTypeDisplayname, ISNULL(ReportDateTypeName, '')ReportDateTypeName, CASE WHEN ReportDateTypeConfigurationIsDefault = 1 THEN 'Default' ELSE '' END DefaultDateType  FROM REPORT r
LEFT JOIN  ReportDateTypeConfiguration config ON config.ReportID = r.ReportID
LEFT JOIN ReportDateType configD ON configD.ReportDateTypeID = config.ReportDateTypeID
WHERE r.ReportID > 194
order by ReportDisplayName, ReportDateTypeDisplayname


