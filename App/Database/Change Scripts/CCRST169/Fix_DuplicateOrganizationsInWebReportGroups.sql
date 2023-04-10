/* CCRST169 Release - Fix Duplicate Organizations in Report Groups 
	05/03/2012 ccarroll
	
	
	INSTRUCTIONS: 
	1. Run this script to remove duplicates in WebReportGroupOrg.
	2. After running, check if duplicates still exist. 
	3. If records remain then re-run this script.
	
*/

DECLARE @ProcessStep varchar(255)


/* Step 1.	Check for temp tables and DROP if exist */
SET @ProcessStep = 'Step 1.	Check for temp tables and DROP if exist'
IF OBJECT_ID(N'tempdb..#DuplicateWebReportGroupOrgs', N'U') IS NOT NULL 
BEGIN
	DROP TABLE #DuplicateWebReportGroupOrgs;
END
IF OBJECT_ID(N'tempdb..#WebReportGroupOrg_SelectionTable', N'U') IS NOT NULL 
BEGIN
	DROP TABLE #WebReportGroupOrg_SelectionTable;
END
PRINT @ProcessStep + '-Completed';

/* Step 2.	Find duplicate OrganizationID/WebReportGroupID combination and
			place one instance of each in temp table */
SET @ProcessStep = 'Step 2.	Find duplicate OrganizationID/WebReportGroupID'

SELECT	
		ParentOrg.OrganizationName,
		WebReportGroup.WebReportGroupName,
		WebReportGroup.WebReportGroupID,
		DuplicateOrg.OrganizationName AS DuplicateOrganizationName,
		DuplicateOrg.OrganizationID,
		DuplicateOrg.OrganizationCity,
		DuplicateOrgState.StateName,
		DuplicateOrgType.OrganizationTypeName,
		COUNT(*) AS Duplicates

INTO #DuplicateWebReportGroupOrgs
FROM WebReportGroupOrg
JOIN WebReportGroup ON  WebReportGroupOrg.WebReportGroupID = WebReportGroup.WebReportGroupID
JOIN Organization DuplicateOrg ON DuplicateOrg.OrganizationID = WebReportGroupOrg.OrganizationID
JOIN [State] DuplicateOrgState ON DuplicateOrgState.StateID = DuplicateOrg.StateID
JOIN OrganizationType DuplicateOrgType ON DuplicateOrgType.OrganizationTypeID = DuplicateOrg.OrganizationTypeID
JOIN Organization ParentOrg ON ParentOrg.OrganizationID = WebReportGroup.OrgHierarchyParentID
/* Add WHERE to limit to specific WebReporGroup */
--WHERE WebReportGroupOrg.WebReportGroupID = 277
GROUP BY 
			
			ParentOrg.OrganizationName,
			WebReportGroup.WebReportGroupName,
			WebReportGroup.WebReportGroupID,
			DuplicateOrg.OrganizationName,
			DuplicateOrg.OrganizationID,
			DuplicateOrg.OrganizationCity,
			DuplicateOrgState.StateName,
			DuplicateOrgType.OrganizationTypeName
HAVING COUNT(*) > 1
PRINT @ProcessStep + '-Completed';


/* Step 3.	Create selection table which identifies WebReportGroupOrgIDs and associates them
			with the Organization and WebReportGroup IDs */
SET @ProcessStep = 'Step 3.	Create selection table for WebReportGroupOrgIDs'
SELECT WebReportGroupOrgID, Dups.WebReportGroupID, Dups.OrganizationID, LastModified
INTO #WebReportGroupOrg_SelectionTable
FROM WebReportGroupOrg
JOIN #DuplicateWebReportGroupOrgs Dups ON (Dups.WebReportGroupID = WebReportGroupOrg.WebReportGroupID) AND (Dups.OrganizationID = WebReportGroupOrg.OrganizationID) 
PRINT @ProcessStep + '-Completed';

/* Step 4.	Remove duplicates from the seletion table. The items in this list will be 
			removed from WebReportGroupOrg in the next step*/
SET @ProcessStep = 'Step 4.	Remove duplicates from the seletion table'
DELETE #WebReportGroupOrg_SelectionTable
FROM
		(SELECT
			lt.WebReportGroupID AS d_WebReportGroupID, 
			lt.OrganizationID AS d_OrganizationID,
			MAX(lt.LastModified) AS d_LastModified
		 FROM #WebReportGroupOrg_SelectionTable AS lt
		 WHERE EXISTS
		(SELECT WebReportGroupID, OrganizationID
		 FROM #WebReportGroupOrg_SelectionTable AS rt
		 WHERE rt.WebReportGroupID = lt.WebReportGroupID
			AND rt.OrganizationID = lt.OrganizationID
			GROUP BY rt.WebReportGroupID, rt.OrganizationID
			HAVING Count(*) > 1
			)
		GROUP BY lt.WebReportGroupID, lt.OrganizationID
		)dt
		
		WHERE WebReportGroupID = dt.d_WebReportGroupID
			AND OrganizationID = dt.d_OrganizationID
			AND LastModified  <> dt.d_LastModified

PRINT @ProcessStep + '-Completed';

/* Step 5.	Remove Records from WebReportGroupOrg */
SET @ProcessStep = 'Step 5.	Remove records from WebReportGroupOrg'
DELETE WebReportGroupOrg WHERE WebReportGroupOrgID IN (
SELECT WebReportGroupOrgID FROM #WebReportGroupOrg_SelectionTable)

PRINT @ProcessStep + '-Completed';


/* Step 6. CCRST169 Release - Return duplicate Organizations still in Report Groups */
SELECT	
		ParentOrg.OrganizationName AS Group_Owner,
		WebReportGroup.WebReportGroupName,
		WebReportGroup.WebReportGroupID,
		DuplicateOrg.OrganizationName AS DuplicateOrganizationName,
		DuplicateOrg.OrganizationID,
		DuplicateOrg.OrganizationCity,
		DuplicateOrgState.StateName,
		DuplicateOrgType.OrganizationTypeName,
		COUNT(*) AS Duplicates
FROM WebReportGroupOrg
JOIN WebReportGroup ON  WebReportGroupOrg.WebReportGroupID = WebReportGroup.WebReportGroupID
JOIN Organization DuplicateOrg ON DuplicateOrg.OrganizationID = WebReportGroupOrg.OrganizationID
JOIN [State] DuplicateOrgState ON DuplicateOrgState.StateID = DuplicateOrg.StateID
JOIN OrganizationType DuplicateOrgType ON DuplicateOrgType.OrganizationTypeID = DuplicateOrg.OrganizationTypeID
JOIN Organization ParentOrg ON ParentOrg.OrganizationID = WebReportGroup.OrgHierarchyParentID
GROUP BY 
		ParentOrg.OrganizationName,
		WebReportGroup.WebReportGroupName,
		WebReportGroup.WebReportGroupID,
		DuplicateOrg.OrganizationName,
		DuplicateOrg.OrganizationID,
		DuplicateOrg.OrganizationCity,
		DuplicateOrgState.StateName,
		DuplicateOrgType.OrganizationTypeName
HAVING COUNT(*) > 1
PRINT 'Step 6. Review duplicate Organizations still in Report Groups';