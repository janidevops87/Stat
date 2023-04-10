IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sps_ReportGetParameterDefaults')
	BEGIN
		PRINT 'Dropping Procedure sps_ReportGetParameterDefaults';
		DROP Procedure sps_ReportGetParameterDefaults;
	END
GO

PRINT 'Creating Procedure sps_ReportGetParameterDefaults';
GO
CREATE Procedure sps_ReportGetParameterDefaults
	@ReportID INT,
	@UserOrganizationId INT,
	@WebPersonId INT

AS

/******************************************************************************
**	File: sps_ReportGetParameterDefaults.sql
**	Name: sps_ReportGetParameterDefaults
**	Desc: Pulls default values for a report.
**	Auth: Pam Scheichenost
**	Date: 11/25/2020
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:						Description:
**	--------		--------					------------------------------
**	11/25/2020		Pam Scheichenost			Initial Sproc Creation
*******************************************************************************/
DECLARE
	@currentDateTime DATETIME;
DECLARE 
	@Configs TABLE
	(
		StartDateTime DATETIME,
		EndDateTime DATETIME,
		IsDateOnly BIT DEFAULT(0) ,
		ReportDateTypeId INT,
		SourceCodeTypeId INT,
		ReportGroupId INT,
		BlockEventLog BIT DEFAULT(1)
	)

SELECT
	@currentDateTime  = GETDATE()

INSERT INTO @Configs 
(StartDateTime)
Values
(NULL)

UPDATE @Configs
SET
	StartDateTime = 
	CASE
		WHEN 
			rdtc.ReportDateTimeID = 1 
		THEN
			CONVERT(VARCHAR, DATEPART
								(
									M,
									@currentDateTime
								)
					) + '/1/' + CONVERT(VARCHAR, DATEPART(YYYY, @currentDateTime)) + ' 00:00'
		WHEN 
			rdtc.ReportDateTimeID = 2 
		THEN
			CONVERT(VARCHAR, DATEPART
								(
									M,
									DATEADD(D, -1, @currentDateTime)
								)
					) + '/' + CONVERT(VARCHAR, DATEPART(D, DATEADD(D, -1, @currentDateTime))) +'/' + CONVERT(VARCHAR, DATEPART(YYYY, DATEADD(D, -1, @currentDateTime))) + ' 00:00'
		WHEN 
			rdtc.ReportDateTimeID = 3 
		THEN
			CONVERT(VARCHAR, DATEPART
								(
									M,
									@currentDateTime
								)
					) + '/' + CONVERT(VARCHAR, DATEPART(D, @currentDateTime)) +'/' + CONVERT(VARCHAR, DATEPART(YYYY,@currentDateTime)) + ' 00:00'
		WHEN 
			rdtc.ReportDateTimeID = 4 
		THEN
			@currentDateTime
		ELSE
			@currentDateTime
	END ,
	EndDateTime = 
	CASE
		WHEN 
			rdtc.ReportDateTimeID = 1 
		THEN
			DATEADD
			(
				S, 
				-1, 
				DATEADD
				(	
					M, 
					1, 
					CONVERT(VARCHAR, DATEPART
									(
										M, 
										@currentDateTime
									)
							)  + '/1/' + CONVERT(VARCHAR, DATEPART(YYYY, @currentDateTime) )
				)
			)		
		WHEN 
			rdtc.ReportDateTimeID = 2 
		THEN
			CONVERT(VARCHAR, DATEPART
								(
									M,
									DATEADD(D, -1, @currentDateTime)
								)
					) + '/' + CONVERT(VARCHAR, DATEPART(D, DATEADD(D, -1, @currentDateTime))) +'/' + CONVERT(VARCHAR, DATEPART(YYYY, DATEADD(D, -1, @currentDateTime))) + ' 23:59:59'
		WHEN 
			rdtc.ReportDateTimeID = 3 
		THEN
			CONVERT(VARCHAR, DATEPART
								(
									M,
									@currentDateTime
								)
					) + '/' + CONVERT(VARCHAR, DATEPART(D, @currentDateTime)) +'/' + CONVERT(VARCHAR, DATEPART(YYYY,@currentDateTime)) + ' 23:59:59'

		WHEN 
			rdtc.ReportDateTimeID = 4 
		THEN
			@currentDateTime
		ELSE
			@currentDateTime
	END	
	
	, isDateOnly = rdtc.IsDateOnly
FROM
	ReportDateTimeConfiguration rdtc
JOIN
	ReportDateTime rdt on rdt.ReportDateTimeID = rdtc.ReportDateTimeID
WHERE
	ReportID = @ReportID;

UPDATE @Configs
SET ReportDateTypeId = config.ReportDateTypeID 
FROM ReportDateTypeConfiguration config
WHERE ReportID = @reportID
AND ReportDateTypeConfigurationIsDefault = 1;

UPDATE @Configs
SET SourceCodeTypeId = r.SourceCodeTypeId
FROM dbo.Report r
WHERE r.ReportId = @reportID;

UPDATE @Configs
SET BlockEventLog = IsNull(IsAuth.roleCount,1)
FROM dbo.WebPerson w
LEFT JOIN (select COUNT(1) as roleCount, w.WebPersonID as WebPersonID
			FROM dbo.WebPerson w
			INNER JOIN UserRoles ur on w.WebPersonID = ur.WebPersonID
			INNER JOIN Roles r on ur.RoleID = r.RoleID
			WHERE w.WebPersonId = @WebPersonId
			AND r.RoleName IN ('Administrator','SL: Client Administrator- Permission','ClientUser')
			GROUP BY w.WebPersonID) IsAuth on IsAuth.WebPersonID = w.WebPersonID
WHERE w.WebPersonId = @WebPersonId;

--Get default report group
IF	@UserOrganizationId = 194
BEGIN
	--if import or message reports, default is different.  TODO
	IF (@ReportID IN (309,311,313,315))
	BEGIN
		UPDATE @Configs
		SET ReportGroupId =	WebReportGroupID 
		FROM		WebReportGroup
		WHERE 	OrgHierarchyParentID = @UserOrganizationId
		AND WebReportGroupName = 'Statline- All Messages/Imports';
	END
	ELSE
	BEGIN
		UPDATE @Configs
		SET ReportGroupId =	WebReportGroupID 
		FROM		WebReportGroup
		WHERE 	OrgHierarchyParentID = @UserOrganizationId
		AND WebReportGroupName = 'Statline- All Referrals (Triage & FS)';
	END
END
	
ELSE
BEGIN
	UPDATE @Configs
	SET	ReportGroupId = WebReportGroupID
	FROM		WebReportGroup
	WHERE 	OrgHierarchyParentID = @UserOrganizationId
	AND WebReportGroupname = 'All Referrals';
	--there are a few clients where they are messages only
	IF ((SELECT ReportGroupId FROM @Configs) IS NULL)
	BEGIN
		UPDATE @Configs
		SET	ReportGroupId = WebReportGroupID
		FROM		WebReportGroup
		WHERE 	OrgHierarchyParentID = @UserOrganizationId
		AND WebReportGroupname = 'All Messages';
	END
END

SELECT 
	CONVERT(nvarchar(10), StartDateTime, 101) as StartDate,
	CONVERT(nvarchar(5), StartDateTime, 114) as StartTime,
	CONVERT(nvarchar(10), EndDateTime, 101) as EndDate,
	CONVERT(nvarchar(5), EndDateTime, 114) as EndTime,
	IsDateOnly,
	ReportDateTypeId,
	SourceCodeTypeId,
	ReportGroupId,
	BlockEventLog
from @Configs;
GO


GRANT EXEC ON sps_ReportGetParameterDefaults TO PUBLIC
GO