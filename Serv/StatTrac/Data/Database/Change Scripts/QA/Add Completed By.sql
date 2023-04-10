        
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
    @ReportOrganization         smallint ,
    --- used to set Report Types
    @ReportDateTypeID int,
    @sortTypeID int,
	@ReportControlID	int,
	@ReportControlName 	[varchar](50),
	@ReportParamSectionID 	[int],	
	@roleID int,
	@RoleName varchar(50),

-- Permission Parameters
	@PERMISSIONID                 int ,
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
    @ACTIVE                       bit,       -- 0 false, 1 true         

-- Web Person Permissions
    @WEBPERSONPERMISSIONID        int,
    @WEBPERSONID                  int,
    @ReportDateTimeID			  int,
    @ControlName				  varchar(250)    ,
    @DateTypeID					  int        ,
    @ReportDateTypeDefault		  int 
SELECT
    @ReportDisplayName          = 'QA Forms Completed By',
    @ReportLocalOnly            = 0,
    @ReportVirtualURL           = '/StatTrac/QAFormsCompletedBy',
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
if (db_name() = '_ReferralDev1')
Begin
	Set @ReportVirtualURL = Replace(@ReportVirtualURL, 'StatTrac', 'StatTrac Test')
End

if exists(select * from report where ReportDisplayName = @ReportDisplayName and ReportVirtualURL = @ReportVirtualURL)
BEGIN
		SELECT 
			@ReportID = ReportID 
		from 
			report 
		where 
			ReportDisplayName = @ReportDisplayName 
		and 
			ReportVirtualURL = @ReportVirtualURL
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

--select * from report where reportid = @ReportID 


SELECT
                  @PERMISSIONNAME               = 'Report: ' + @ReportDisplayName,                  
                  @PERMISSIONTYPEID             = 2,
                  @FUNCTIONID                   = @ReportID,
                  @PERMISSIONDESCRIPTION        = 'Allows the webperson to see the Report: ' + @ReportDisplayName,
                  @ACTIVE                       = 1

IF NOT EXISTS (select * from permission where FunctionID = @ReportID) 
BEGIN                   
	exec SPI_Permission
                  @PERMISSIONID                 OUTPUT,
                  @PERMISSIONNAME               ,
                  @PERMISSIONTYPEID             ,
                  @FUNCTIONID                   ,
                  @PERMISSIONDESCRIPTION         ,
                  @ACTIVE                       
                  
END
ELSE
BEGIN
	SELECT @PERMISSIONID = PERMISSIONID FROM permission WHERE FunctionID = @ReportID
END
SELECT @WEBPERSONID = 296 -- bret

IF NOT EXISTS (SELECT * FROM WEBPersonPermission WHERE WebPersonID = @WebPersonID AND PermissionID = @PERMISSIONID)
BEGIN
	exec SPI_WebPersonPermission
                  @WEBPERSONPERMISSIONID        OUTPUT ,
                  @WEBPERSONID                  ,
                  @PERMISSIONID                 
END                  


SELECT @WEBPERSONID = 3195 -- scwells

IF NOT EXISTS (SELECT * FROM WEBPersonPermission WHERE WebPersonID = @WebPersonID AND PermissionID = @PERMISSIONID)
BEGIN
	exec SPI_WebPersonPermission
                  @WEBPERSONPERMISSIONID        OUTPUT ,
                  @WEBPERSONID                  ,
                  @PERMISSIONID                 
END

SELECT @WEBPERSONID = 7206 -- jhawkins

IF NOT EXISTS (SELECT * FROM WEBPersonPermission WHERE WebPersonID = @WebPersonID AND PermissionID = @PERMISSIONID)
BEGIN
	exec SPI_WebPersonPermission
                  @WEBPERSONPERMISSIONID        OUTPUT ,
                  @WEBPERSONID                  ,
                  @PERMISSIONID                 
END
SELECT @WEBPERSONID = 5383 -- ccarroll

IF NOT EXISTS (SELECT * FROM WEBPersonPermission WHERE WebPersonID = @WebPersonID AND PermissionID = @PERMISSIONID)
BEGIN
	exec SPI_WebPersonPermission
                  @WEBPERSONPERMISSIONID        OUTPUT ,
                  @WEBPERSONID                  ,
                  @PERMISSIONID                 
END
--- cleare all param settings
	DELETE dbo.ReportDateTimeConfiguration  WHERE ReportID = @ReportID
	DELETE dbo.ReportDateTypeConfiguration WHERE ReportID = @ReportID
	DELETE dbo.ReportParamConfiguration WHERE ReportID = @ReportID
	DELETE dbo.ReportSortTypeConfiguration WHERE ReportID = @ReportID

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
IF NOT EXISTS (SELECT * FROM ReportControl WHERE ReportControlName like 'customParamsCompletedByControl')
BEGIN
	insert ReportControl (ReportControlName, ReportParamSectionID) 
	values ('customParamsCompletedByControl', 1) 
END
IF NOT EXISTS (SELECT * FROM ReportControl WHERE ReportControlName like 'customParamsTrackingNumberControl')
BEGIN
	insert ReportControl (ReportControlName, ReportParamSectionID) 
	values ('customParamsTrackingNumberControl', 1) 
END	
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
VALUES('ddlReportGroup', 3)
INSERT @controlList
VALUES('ddlOrganization', 3)
INSERT @controlList
VALUES('ddlSourceCode', 3)

INSERT @controlList
VALUES('ddlSortOption1', 5)
INSERT @controlList
VALUES('ddlSortOption2', 5)
INSERT @controlList
VALUES('ddlSortOption3', 5)
INSERT @controlList
VALUES('radionButtonTimeZoneReferral', 7)
INSERT @controlList
VALUES('radionButtonTimeZoneMountain', 7)

INSERT @controlList
VALUES('customParamsCompletedByControl', 1)
INSERT @controlList
VALUES('customParamsTrackingNumberControl', 1)


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


select @RoleName = 'AdminUser'	    

EXEC GetRoleIdByName
	@Rolename,
	@roleID OUTPUT

IF NOT EXISTS (SELECT     *
			FROM	ReportRule 
			WHERE     (ReportRule.RoleID = @roleID) 
			AND (ReportRule.ReportID = @ReportID)	
			)
BEGIN
	exec spi_ReportRule @ReportID, @roleID	
END

-- What are the ReportDateTypes
-- 1	Referral	Referral
-- 2	CardiacDeath	Cardiac Death
IF NOT EXISTS (SELECT * FROM ReportDateType WHERE ReportDateTypeName like 'Call')
BEGIN
	insert ReportDateType (ReportDateTypeName, ReportDateTypeDisplayName) 
	values ('Call', 'Call D/T') 
END
IF NOT EXISTS (
		SELECT 	
			ReportDateTypeName,
			ReportDateTypeDisplayname 
		FROM 
			ReportDateTypeConfiguration  rstc 
		JOIN 
			ReportDateType rst ON rst.ReportDateTypeID = rstc.ReportDateTypeID
		WHERE 
			ReportID = @ReportID
		AND 
			ReportDateTypeName = 'Error'
		
	 	)
BEGIN

	SELECT 
		@DateTypeID  = ReportDateTypeID 
	FROM 
		ReportDateType 
	WHERE 
		ReportDateTypeName = 'Error'
	
set @ReportDateTypeDefault = 0
	exec spi_ReportDateTypeConfiguration
		@reportid,
		@DateTypeID,
		@ReportDateTypeDefault	
	
END
IF NOT EXISTS (
		SELECT 	
			ReportDateTypeName,
			ReportDateTypeDisplayname 
		FROM 
			ReportDateTypeConfiguration  rstc 
		JOIN 
			ReportDateType rst ON rst.ReportDateTypeID = rstc.ReportDateTypeID
		WHERE 
			ReportID = @ReportID
		AND 
			ReportDateTypeName = 'Call'
		
	 	)
BEGIN

	SELECT 
		@DateTypeID  = ReportDateTypeID 
	FROM 
		ReportDateType 
	WHERE 
		ReportDateTypeName = 'Call'
	
set @ReportDateTypeDefault = 1
	exec spi_ReportDateTypeConfiguration
		@reportid,
		@DateTypeID,
		@ReportDateTypeDefault	
	
END
DECLARE 
	@ReportSortTypeName varchar(250),
	@ReportSortTypeDisplayname varchar(250)
DECLARE @SORT TABLE
	(
		ID INT IDENTITY(1,1),
		ReportSortTypeName VARCHAR(250),
		ReportSortTypeDisplayname VARCHAR(250)
		
	
	)
	
INSERT @SORT
VALUES('CompletedBy', 'Completed By')	
INSERT @SORT
VALUES('SourceCode', 'Source Code')
INSERT @SORT
VALUES('CallTypeName', 'Referral Type')
INSERT @SORT
VALUES('Employee', 'Employee')	
INSERT @SORT
VALUES('QATrackingNumber', 'Tracking #')	
INSERT @SORT
VALUES('QATrackingFormPoints', 'Score')	


SELECT @loopCount = 1, @loopMax = Count(ID) FROM @SORT

WHILE (@loopCount <= @loopMax)
BEGIN

	SELECT 
		@ReportSortTypeName = ReportSortTypeName,
		@ReportSortTypeDisplayname = ReportSortTypeDisplayname
	FROM 
		@SORT
	WHERE
		ID = @loopCount

	-- ADD SORT TYPE		
		IF NOT EXISTS (
						SELECT     ReportSortTypeID, ReportSortTypeName, ReportSortTypeDisplayname
						FROM         ReportSortType
						WHERE     (ReportSortTypeName = @ReportSortTypeName) 
						AND		  (ReportSortTypeDisplayname = @ReportSortTypeDisplayname)
					  )	
		BEGIN
					INSERT ReportSortType
					VALUES (@ReportSortTypeName, @ReportSortTypeDisplayname)
		END
		IF NOT EXISTS (
				SELECT 	
					ReportSortTypeName,
					ReportSortTypeDisplayname 
				FROM 
					ReportSortTypeConfiguration  rstc 
				JOIN 
					ReportSortType rst ON rst.ReportSortTypeID = rstc.ReportSortTypeID
				WHERE 
					ReportID = @ReportID
				AND 
					ReportSortTypeName = @ReportSortTypeName
				AND
					ReportSortTypeDisplayname = @ReportSortTypeDisplayname
	 			)
		BEGIN

			SELECT 
				@sortTypeID  = ReportSortTypeID 
			FROM 
				ReportSortType 
			WHERE 
				ReportSortTypeName = @ReportSortTypeName
			AND 
				ReportSortTypeDisplayname = @ReportSortTypeDisplayname

			exec spi_ReportSortTypeConfiguration
				@reportid,
				@sortTypeID	
			
		END

	SET @loopCount = @loopCount + 1
END

IF NOT EXISTS (
		SELECT 	
			ReportDateTimeName,
			ReportDateTimename 
		FROM 
			ReportDateTimeConfiguration  rstc 
		JOIN 
			ReportDateTime rst ON rst.ReportDateTimeID = rstc.ReportDateTimeID
		WHERE 
			ReportID = @ReportID
		AND 
			ReportDateTimeName = 'Monthly'
		AND
			ReportDateTimename = 'Monthly'
	 	)
BEGIN
		declare 
		@IsArchived int,
		@IsDateOnly int
		
		set @IsArchived = 0
		set @IsDateOnly = 0


	SELECT 
		@DateTypeID  = ReportDateTimeID 
	FROM 
		ReportDateTime 
	WHERE 
		ReportDateTimeName = 'Monthly'
	AND 
		ReportDateTimename = 'Monthly'

	exec spi_ReportDateTimeConfiguration
		@reportid,
		@DateTypeID,
		@IsArchived,
		@IsDateOnly
	
END


 