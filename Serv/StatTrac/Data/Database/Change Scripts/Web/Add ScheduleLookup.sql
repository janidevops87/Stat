    
-- Report Table Paramters
Declare 
	@ReportID int,
    @ReportDisplayName          varchar(50) ,
    @LastModified               datetime ,
    @ReportLocalOnly            int, -- 0 false, -1 true
    @ReportVirtualURL           varchar(100),
    /*
		/reports/referral/ftpdetail_extended_2006_1.slf?
		/StatTrac/AgeSkinBoneSummary
    */
    @ReportTypeID               smallint,
    /*
		1	Referrals
		2	Messages
		3	Imports
		4	Referral Stats
		5	General
		6	Custom Reports
		7	Schedules
    */
    @Unused                     varbinary(50),
    @ReportDescFileName         varchar(50), -- used by the original reports website
    -- nodesc.shm
    @UpdatedFlag                smallint,
    @ReportSortOrderID          smallint,
    @ReportInDevelopment        smallint,
    @ReportFromDate             smallint,
    @ReportToDate               smallint,
    @ReportGroup                smallint,
    @ReportOrganization         smallint, 
    @sortTypeID int

-- Permission Parameters
DECLARE           @PERMISSIONID                 int ,
                  @PERMISSIONNAME               varchar(500) ,
                  @PERMISSIONTYPEID             int ,
                  /*
					1	Navigation
					2	Reports
					3	Buttons
					4	Functions
					5	Online Referral
                  
                  */
                  @FUNCTIONID                   int , -- ReportID
                  @PERMISSIONDESCRIPTION        varchar(1000) ,
                  @ACTIVE                       bit       -- 0 false, 1 true         

-- Web Person Permissions
DECLARE
                  @WEBPERSONPERMISSIONID        int,
                  @WEBPERSONID                  int 
                  
SELECT
    @ReportDisplayName          = 'Schedule Lookup',
    @ReportLocalOnly            = 0,
    @ReportVirtualURL           = '/StatTrac/ScheduleLookup',
    @ReportTypeID               = 4,
    @Unused                     = null,
    @ReportDescFileName         = 'nodesc.shm',
    @UpdatedFlag                = null,
    @ReportSortOrderID          = null,
    @ReportInDevelopment        = null,
    @ReportFromDate             = null,
    @ReportToDate               = null,
    @ReportGroup                = null,
    @ReportOrganization         = null


if exists(select * from report where replace(ReportDisplayName, ' (new)', '') = @ReportDisplayName and replace(ReportVirtualURL,  'StatTrac Test', 'StatTrac') = @ReportVirtualURL)
BEGIN
		SELECT 
			@ReportID = ReportID 
		from 
			report 
		where 
			replace(ReportDisplayName, ' (new)', '') = @ReportDisplayName 
		and 
			replace(ReportVirtualURL,  'StatTrac Test', 'StatTrac') = @ReportVirtualURL
END
ELSE
BEGIN
	
exec SPI_Report 
                  @ReportID OUTPUT            ,
                  @ReportDisplayName          ,
                  @LastModified               ,
                  @ReportLocalOnly            ,
                  @ReportVirtualURL           ,
                  @ReportTypeID               ,
                  @Unused					  ,
                  @ReportDescFileName         ,
                  @UpdatedFlag                ,
                  @ReportSortOrderID          ,
                  @ReportInDevelopment        ,
                  @ReportFromDate             ,
                  @ReportToDate               ,
                  @ReportGroup                ,
                  @ReportOrganization          

END 


SELECT
                  @PERMISSIONNAME               = 'Report: ' + @ReportDisplayName,                  
                  @PERMISSIONTYPEID             = 2,
                  @FUNCTIONID                   = @ReportID,
                  @PERMISSIONDESCRIPTION        = 'Allows the webperson to see the Report: ' + @ReportDisplayName,
                  @ACTIVE                       = 1

if exists(select * from Permission where PermissionName = @PERMISSIONNAME and FunctionID = @FUNCTIONID)
begin
		SELECT 
			@PERMISSIONID = PermissionID
		FROM
			Permission
		WHERE
			PermissionName = @PERMISSIONNAME 
		AND 
			FunctionID = @FUNCTIONID			           

end
else
begin                    
exec SPI_Permission
                  @PERMISSIONID                 OUTPUT,
                  @PERMISSIONNAME               ,
                  @PERMISSIONTYPEID             ,
                  @FUNCTIONID                   ,
                  @PERMISSIONDESCRIPTION         ,
                  @ACTIVE                       
                  
end

SELECT @WEBPERSONID = 296 -- bret

IF EXISTS ( select * from webpersonpermission where webpersonID = @WEBPERSONID and PermissionID = @PERMISSIONID)
begin
	SELECT 
		@WEBPERSONPERMISSIONID = WebPersonPermissionID
	FROM 
		webpersonpermission 
	WHERE 
		webpersonID = @WEBPERSONID 
	AND
		PermissionID = @PERMISSIONID

end
else
begin

exec SPI_WebPersonPermission
                  @WEBPERSONPERMISSIONID        OUTPUT ,
                  @WEBPERSONID                  ,
                  @PERMISSIONID                 
end

SELECT @WEBPERSONID = 3195 -- bret

IF EXISTS ( select * from webpersonpermission where webpersonID = @WEBPERSONID and PermissionID = @PERMISSIONID)
begin
	SELECT 
		@WEBPERSONPERMISSIONID = WebPersonPermissionID
	FROM 
		webpersonpermission 
	WHERE 
		webpersonID = @WEBPERSONID 
	AND
		PermissionID = @PERMISSIONID

end
else
begin

exec SPI_WebPersonPermission
                  @WEBPERSONPERMISSIONID        OUTPUT ,
                  @WEBPERSONID                  ,
                  @PERMISSIONID                 
end

SELECT @WEBPERSONID = 5383 -- bret

IF EXISTS ( select * from webpersonpermission where webpersonID = @WEBPERSONID and PermissionID = @PERMISSIONID)
begin
	SELECT 
		@WEBPERSONPERMISSIONID = WebPersonPermissionID
	FROM 
		webpersonpermission 
	WHERE 
		webpersonID = @WEBPERSONID 
	AND
		PermissionID = @PERMISSIONID

end
else
begin

exec SPI_WebPersonPermission
                  @WEBPERSONPERMISSIONID        OUTPUT ,
                  @WEBPERSONID                  ,
                  @PERMISSIONID                 
end
                  
Declare
	@ReportControlID	int,

/*
1	ddlReportDateType	2
2	webDateTimeEditStart	2
3	webDateTimeEditEnd	2
4	ddlReportGroup	3
5	ddlOrganization	3
6	ddlSourceCode	3
7	ddlOrganizationCoordinator	3
8	txtBoxLowerAge	4
9	ddlGender	4
10	txtBoxUpperAge	4
11	ddlSortOption1	5
12	ddlSortOption2	5
13	ddlSortOption3	5
14	chkBoxDisplayReferralName	6
15	chkBoxDisplaySSN	6
16	chkBoxDisplayMedicalRecord	6
17	avayaCustomParams	1
18	fSConversionParams	1
19	callParams	1
20	approchPersonParams	1
21	referralDetailParams	1



*/
	@ReportControlName 	[varchar](50),
	@ReportParamSectionID 	[int]	
/*
	1	ReportSpecificParams
	2	DateAndTime
	3	CoordinatorOrganization
	4	AgeGender
	5	SortOptions
	6	DisplayOptions

*/	
DECLARE 
	@loopCount int, 
	@loopMax int
	--- declared @ReportControlName varchar(250),
	--- declared @ReportParamSectionID int
	
DECLARE @controlList TABLE
	(
		ID INT IDENTITY(1,1),
		ReportControlName varchar(250),		
		ReportParamSectionID int
	)
	-- select * from reportControl
INSERT @controlList
VALUES('ddlReportDateType', 2)
INSERT @controlList
VALUES('webDateTimeEditStart', 2)
INSERT @controlList
VALUES('webDateTimeEditEnd', 2)
INSERT @controlList
VALUES('ddlSortOption1', 5)
INSERT @controlList
VALUES('ddlSortOption2', 5)
INSERT @controlList
VALUES('ddlSortOption3', 5)
INSERT @controlList
VALUES('customParamsScheduleLookup', 1)
INSERT @controlList
VALUES('radionButtonTimeZoneReferral', 7)
INSERT @controlList
VALUES('radionButtonTimeZoneMountain', 7)


SELECT @loopCount = 1, @loopMax = Count(ID) FROM @controlList

WHILE (@loopCount <= @loopMax)
BEGIN

	SELECT 
		@ReportControlName = ReportControlName,
		@ReportParamSectionID = ReportParamSectionID 
	FROM 
		@controlList
	WHERE
		ID = @loopCount

	-- ADD controlList TYPE		
		IF NOT EXISTS (
						SELECT     *
						FROM       ReportControl
						WHERE     (ReportControlName = @ReportControlName) 
					  )	
		BEGIN
					INSERT ReportControl
					VALUES (@ReportControlName, @ReportParamSectionID )
		END
		IF NOT EXISTS (
				SELECT 	
					ReportControlName
				FROM 
					ReportParamConfiguration  rstc 
				JOIN 
					ReportControl rst ON rst.ReportControlID = rstc.ReportControlID
				WHERE 
					ReportID = @ReportID
				AND 
					ReportControlName = @ReportControlName
	 			)
		BEGIN

			SELECT 
				@ReportControlID  = ReportControlID 
			FROM 
				ReportControl 
			WHERE 
				ReportControlName = @ReportControlName
			

			exec spi_ReportParamConfiguration
				@reportid,
				@ReportControlID	
			
		END

	SET @loopCount = @loopCount + 1
END

Declare @roleID int,
	    @RoleName varchar(50)
select @RoleName = 'AdminUser'	    

EXEC GetRoleIdByName
	@Rolename,
	@roleID OUTPUT

if not exists(select * from reportrule where ReportID = @ReportID and RoleID = @roleID )
BEGIN	
	exec spi_ReportRule @ReportID, @roleID	
END
-- What are the ReportDateTypes
-- 1	Referral	Referral
-- 2	CardiacDeath	Cardiac Death
DECLARE 
	@ReportDateTypeName nvarchar(25),
	@ReportDateTypeDisplayName nvarchar(25),
	@ReportDateTypeDefault bit
DECLARE @ReportDateTypeNameList TABLE
	(
		ID INT IDENTITY(1,1),
		ReportDateTypeName nvarchar(25),
		ReportDateTypeDisplayName nvarchar(25),
		ReportDateTypeDefault bit	
	
	)
	
INSERT @ReportDateTypeNameList
VALUES('ScheduleDT', 'Schedule D/T', 1)


SELECT @loopCount = MIN(ID), @loopMax = MAX(ID) FROM @ReportDateTypeNameList

WHILE (@loopCount <= @loopMax)
BEGIN

	SELECT 
		@ReportDateTypeName = ReportDateTypeName,
		@ReportDateTypeDisplayName = ReportDateTypeDisplayName,
		@ReportDateTypeDefault = ReportDateTypeDefault
	FROM 
		@ReportDateTypeNameList
	WHERE
		ID = @loopCount

	-- ADD ReportDateTypeNameList TYPE		
		IF NOT EXISTS (
						SELECT     *
						FROM         ReportDateType
						WHERE     (ReportDateTypeName = @ReportDateTypeName) 
						AND		  (ReportDateTypeDisplayName = @ReportDateTypeDisplayName)
					  )	
		BEGIN
					INSERT ReportDateType
					VALUES (@ReportDateTypeName, @ReportDateTypeDisplayName)
		END
		IF NOT EXISTS (
				SELECT 	
					ReportDateTypeName,
					ReportDateTypeDisplayName 
				FROM 
					ReportDateTypeConfiguration  rstc 
				JOIN 
					ReportDateType rst ON rst.ReportDateTypeID = rstc.ReportDateTypeID
				WHERE 
					ReportID = @ReportID
				AND 
					ReportDateTypeName = @ReportDateTypeName
				AND
					ReportDateTypeDisplayName = @ReportDateTypeDisplayName
	 			)
		BEGIN

			SELECT 
				@sortTypeID  = ReportDateTypeID 
			FROM 
				ReportDateType 
			WHERE 
				ReportDateTypeName = @ReportDateTypeName
			AND 
				ReportDateTypeDisplayName = @ReportDateTypeDisplayName

			exec spi_ReportDateTypeConfiguration
				@reportid,
				@sortTypeID,
				@ReportDateTypeDefault
			
		END

	SET @loopCount = @loopCount + 1
END

/*

1	CallID	Call ID
2	SourceCode	Source Code
3	IncomingCall	Triage Incoming Call
4	Diff_IncomingToSecondary	Time Triage To Secondary
5	Diff_SecondaryPendingToScreening	Time Secondary To Screening
6	Diff_IncomingToPaperwork	Total Time Elapsed
7	ReferralApproachedByPersonLastName	Last Name (of employee)
8	ReferralApproachedByPersonFirstName	First Name (of employee)
9	ReferralType	Referral Type
10	BasedOnDT	Base on D/T
11	PatientLastName	Patient Last Name
12	ReferralFacility	Referral Facility
13	InitialApproachType	Initial Approach Type
14	FinalApproachType	Final Approach Type

*/
DECLARE 
	@ReportSortTypeName nvarchar(25),
	@ReportSortTypeDisplayName nvarchar(25)
DECLARE @ReportSortTypeNameList TABLE
	(
		ID INT IDENTITY(1,1),
		ReportSortTypeName nvarchar(25),
		ReportSortTypeDisplayName nvarchar(25)
		
	
	)
	
INSERT @ReportSortTypeNameList
VALUES('StartDT', 'Start D/T')
INSERT @ReportSortTypeNameList
VALUES('EndDT', 'End D/T')
INSERT @ReportSortTypeNameList
VALUES('ShiftName', 'Shift Name')

SELECT @loopCount = MIN(ID), @loopMax = MAX(ID) FROM @ReportSortTypeNameList

WHILE (@loopCount <= @loopMax)
BEGIN

	SELECT 
		@ReportSortTypeName = ReportSortTypeName,
		@ReportSortTypeDisplayName = ReportSortTypeDisplayName
	FROM 
		@ReportSortTypeNameList
	WHERE
		ID = @loopCount

	-- ADD ReportSortTypeNameList TYPE		
		IF NOT EXISTS (
						SELECT     *
						FROM         ReportSortType
						WHERE     (ReportSortTypeName = @ReportSortTypeName) 
						AND		  (ReportSortTypeDisplayName = @ReportSortTypeDisplayName)
					  )	
		BEGIN
					INSERT ReportSortType
					VALUES (@ReportSortTypeName, @ReportSortTypeDisplayName)
		END
		IF NOT EXISTS (
				SELECT 	
					ReportSortTypeName,
					ReportSortTypeDisplayName 
				FROM 
					ReportSortTypeConfiguration  rstc 
				JOIN 
					ReportSortType rst ON rst.ReportSortTypeID = rstc.ReportSortTypeID
				WHERE 
					ReportID = @ReportID
				AND 
					ReportSortTypeName = @ReportSortTypeName
				AND
					ReportSortTypeDisplayName = @ReportSortTypeDisplayName
	 			)
		BEGIN

			SELECT 
				@sortTypeID  = ReportSortTypeID 
			FROM 
				ReportSortType 
			WHERE 
				ReportSortTypeName = @ReportSortTypeName
			AND 
				ReportSortTypeDisplayName = @ReportSortTypeDisplayName

			exec spi_ReportSortTypeConfiguration
				@reportid,
				@sortTypeID	
			
		END

	SET @loopCount = @loopCount + 1
END

declare 
	@ReportDateTimeID int 
	
select 
	@ReportDateTimeID = ReportDateTimeID from reportdatetime where ReportDateTimeName = 'Monthly'
if not exists (select * from reportdatetimeconfiguration where ReportDateTimeID = @ReportDateTimeID and ReportID = @reportid)
begin
	EXEC spi_ReportDateTimeConfiguration
		@ReportID,
		@ReportDateTimeID	
end

