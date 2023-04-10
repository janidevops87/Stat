  
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
    @ReportDisplayName          = 'Approach Outcome',
    @ReportLocalOnly            = 0,
    @ReportVirtualURL           = '/StatTrac/ApproachPersonOutcome',
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
SELECT @WEBPERSONID = 296

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
               
SELECT @WEBPERSONID = 3195 -- scwells

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
	9	ddGender	4
	10	txtBoxUpperAge	4
	11	ddSortOption1	5
	12	ddSortOption2	5
	13	ddSortOption3	5
	14	chkBoxDisplayReferralName	6
	15	chkBoxDisplaySSN	6
	16	chkBoxDisplayMedicalRecord	6


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

IF NOT EXISTS (SELECT * FROM ReportControl WHERE ReportControlName like 'ddlReportDateType')
BEGIN
	insert ReportControl (ReportControlName, ReportParamSectionID) 
	values ('ddlReportDateType', 2) 
END

select 
	@ReportControlID = 
	ReportControlID from ReportControl WHERE ReportControlName = 'ddlReportDateType'

if not exists( select * from reportparamconfiguration where reportID = @ReportID and reportcontrolID = @ReportControlID)
BEGIN
	exec spi_ReportParamConfiguration
		@ReportID			,
		@ReportControlID	
END	
IF NOT EXISTS (SELECT * FROM ReportControl WHERE ReportControlName like 'webDateTimeEditStart')
BEGIN
	insert ReportControl (ReportControlName, ReportParamSectionID) 
	values ('webDateTimeEditStart', 2) 
END

select 
	@ReportControlID = ReportControlID from ReportControl WHERE ReportControlName = 'webDateTimeEditStart'

if not exists( select * from reportparamconfiguration where reportID = @ReportID and reportcontrolID = @ReportControlID)
BEGIN
	exec spi_ReportParamConfiguration
		@ReportID			,
		@ReportControlID	
END	

IF NOT EXISTS (SELECT * FROM ReportControl WHERE ReportControlName like 'webDateTimeEditEnd')
BEGIN
	insert ReportControl (ReportControlName, ReportParamSectionID) 
	values ('webDateTimeEditEnd', 2) 
END

select 
	@ReportControlID = ReportControlID from ReportControl WHERE ReportControlName = 'webDateTimeEditEnd'

if not exists( select * from reportparamconfiguration where reportID = @ReportID and reportcontrolID = @ReportControlID)
BEGIN
	exec spi_ReportParamConfiguration
		@ReportID			,
		@ReportControlID	
END	

IF NOT EXISTS (SELECT * FROM ReportControl WHERE ReportControlName like 'ddlReportGroup')
BEGIN
	insert ReportControl (ReportControlName, ReportParamSectionID) 
	values ('ddlReportGroup', 3) 
END

select 
	@ReportControlID = ReportControlID from ReportControl WHERE ReportControlName = 'ddlReportGroup'

if not exists( select * from reportparamconfiguration where reportID = @ReportID and reportcontrolID = @ReportControlID)
BEGIN
	exec spi_ReportParamConfiguration
		@ReportID			,
		@ReportControlID	
END	

IF NOT EXISTS (SELECT * FROM ReportControl WHERE ReportControlName like 'ddlOrganization')
BEGIN
	insert ReportControl (ReportControlName, ReportParamSectionID) 
	values ('ddlOrganization', 3) 
END

select 
	@ReportControlID = ReportControlID from ReportControl WHERE ReportControlName = 'ddlOrganization'

if not exists( select * from reportparamconfiguration where reportID = @ReportID and reportcontrolID = @ReportControlID)
BEGIN
	exec spi_ReportParamConfiguration
		@ReportID			,
		@ReportControlID	
END	

IF NOT EXISTS (SELECT * FROM ReportControl WHERE ReportControlName like 'ddlSourceCode')
BEGIN
	insert ReportControl (ReportControlName, ReportParamSectionID) 
	values ('ddlSourceCode', 3) 
END

select 
	@ReportControlID = ReportControlID from ReportControl WHERE ReportControlName = 'ddlSourceCode'

if not exists( select * from reportparamconfiguration where reportID = @ReportID and reportcontrolID = @ReportControlID)
BEGIN
	exec spi_ReportParamConfiguration
		@ReportID			,
		@ReportControlID	
END		
					
IF NOT EXISTS (SELECT * FROM ReportControl WHERE ReportControlName like 'ddlOrganizationCoordinator')
BEGIN
	insert ReportControl (ReportControlName, ReportParamSectionID) 
	values ('ddlOrganizationCoordinator', 3) 
END

select 
	@ReportControlID = ReportControlID from ReportControl WHERE ReportControlName = 'ddlOrganizationCoordinator'

if not exists( select * from reportparamconfiguration where reportID = @ReportID and reportcontrolID = @ReportControlID)
BEGIN
	exec spi_ReportParamConfiguration
		@ReportID			,
		@ReportControlID	
END	

IF NOT EXISTS (SELECT * FROM ReportControl WHERE ReportControlName like 'txtBoxLowerAge')
BEGIN
	insert ReportControl (ReportControlName, ReportParamSectionID) 
	values ('txtBoxLowerAge', 4) 
END

select 
	@ReportControlID = ReportControlID from ReportControl WHERE ReportControlName = 'txtBoxLowerAge'

if not exists( select * from reportparamconfiguration where reportID = @ReportID and reportcontrolID = @ReportControlID)
BEGIN
	exec spi_ReportParamConfiguration
		@ReportID			,
		@ReportControlID	
END	

IF NOT EXISTS (SELECT * FROM ReportControl WHERE ReportControlName like 'ddlGender')
BEGIN
	insert ReportControl (ReportControlName, ReportParamSectionID) 
	values ('ddlGender', 4) 
END

select 
	@ReportControlID = ReportControlID from ReportControl WHERE ReportControlName = 'ddlGender'

if not exists( select * from reportparamconfiguration where reportID = @ReportID and reportcontrolID = @ReportControlID)
BEGIN
	exec spi_ReportParamConfiguration
		@ReportID			,
		@ReportControlID	
END	

IF NOT EXISTS (SELECT * FROM ReportControl WHERE ReportControlName like 'txtBoxUpperAge')
BEGIN
	insert ReportControl (ReportControlName, ReportParamSectionID) 
	values ('txtBoxUpperAge', 4) 
END

select 
	@ReportControlID = ReportControlID from ReportControl WHERE ReportControlName = 'txtBoxUpperAge'

if not exists( select * from reportparamconfiguration where reportID = @ReportID and reportcontrolID = @ReportControlID)
BEGIN
	exec spi_ReportParamConfiguration
		@ReportID			,
		@ReportControlID	
END	
						
IF NOT EXISTS (SELECT * FROM ReportControl WHERE ReportControlName like 'ddlSortOption1')
BEGIN
	insert ReportControl (ReportControlName, ReportParamSectionID) 
	values ('ddlSortOption1', 5) 
END

select 
	@ReportControlID = ReportControlID from ReportControl WHERE ReportControlName = 'ddlSortOption1'

if not exists( select * from reportparamconfiguration where reportID = @ReportID and reportcontrolID = @ReportControlID)
BEGIN
	exec spi_ReportParamConfiguration
		@ReportID			,
		@ReportControlID	
END	

IF NOT EXISTS (SELECT * FROM ReportControl WHERE ReportControlName like 'ddlSortOption2')
BEGIN
	insert ReportControl (ReportControlName, ReportParamSectionID) 
	values ('ddlSortOption2', 5) 
END

select 
	@ReportControlID = ReportControlID from ReportControl WHERE ReportControlName = 'ddlSortOption2'

if not exists( select * from reportparamconfiguration where reportID = @ReportID and reportcontrolID = @ReportControlID)
BEGIN
	exec spi_ReportParamConfiguration
		@ReportID			,
		@ReportControlID	
END	

IF NOT EXISTS (SELECT * FROM ReportControl WHERE ReportControlName like 'ddlSortOption3')
BEGIN
	insert ReportControl (ReportControlName, ReportParamSectionID) 
	values ('ddlSortOption3', 5) 
END

select 
	@ReportControlID = 	ReportControlID from ReportControl WHERE ReportControlName = 'ddlSortOption3'

if not exists( select * from reportparamconfiguration where reportID = @ReportID and reportcontrolID = @ReportControlID)
BEGIN
	exec spi_ReportParamConfiguration
		@ReportID			,
		@ReportControlID	
END	
if not exists(Select * from reportparamsection where ReportParamSectionName = 'TimeZone')
begin
	INSERT reportparamsection (ReportParamSectionID, ReportParamSectionName)
	VALUES(7, 'TimeZone')
end


IF NOT EXISTS (SELECT * FROM ReportControl WHERE ReportControlName like 'radionButtonTimeZoneReferral')
BEGIN
	insert ReportControl (ReportControlName, ReportParamSectionID) 
	values ('radionButtonTimeZoneReferral', 7) 
END

select 
	@ReportControlID = ReportControlID from ReportControl WHERE ReportControlName = 'radionButtonTimeZoneReferral'

if not exists( select * from reportparamconfiguration where reportID = @ReportID and reportcontrolID = @ReportControlID)
BEGIN
	exec spi_ReportParamConfiguration
		@ReportID			,
		@ReportControlID	
END					

IF NOT EXISTS (SELECT * FROM ReportControl WHERE ReportControlName like 'radionButtonTimeZoneMountain')
BEGIN
	insert ReportControl (ReportControlName, ReportParamSectionID) 
	values ('radionButtonTimeZoneMountain', 7) 
END

select 
	@ReportControlID = ReportControlID from ReportControl WHERE ReportControlName = 'radionButtonTimeZoneMountain'

if not exists( select * from reportparamconfiguration where reportID = @ReportID and reportcontrolID = @ReportControlID)
BEGIN
	exec spi_ReportParamConfiguration
		@ReportID			,
		@ReportControlID	
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


select @ReportDateTypeID = 1
if not exists(select * from ReportDateTypeConfiguration where ReportID = @ReportID and ReportDateTypeID = @ReportDateTypeID )
begin
	exec spi_ReportDateTypeConfiguration
		@ReportID	,
		@ReportDateTypeID 
end	


DECLARE 
	@loopCount int, 
	@loopMax int,
	@ReportSortTypeName varchar(100),
	@ReportSortTypeDisplayName varchar(100)
DECLARE @sortTypeList TABLE
	(
		ID INT IDENTITY(1,1),
		ReportSortTypeName varchar(100),
		ReportSortTypeDisplayName varchar(100)
		
	
	)
	
INSERT @sortTypeList VALUES('ApproacherLastName', 'Last Name (of employee)')
INSERT @sortTypeList VALUES('ApproacherFirstName', 'First Name (of employee)')
INSERT @sortTypeList VALUES('Approach', 'Approaches	')
INSERT @sortTypeList VALUES('VerbalConsent', 'Verbal Consents')
INSERT @sortTypeList VALUES('WrittenConsent', 'Written Consents')
INSERT @sortTypeList VALUES('RegistryConsent', 'Registry Consents')
INSERT @sortTypeList VALUES('TotalConsent', 'Total Consents')



SELECT @loopCount = 1, @loopMax = Count(ID) FROM @sortTypeList

WHILE (@loopCount <= @loopMax)
BEGIN

	SELECT 
		@ReportSortTypeName = ReportSortTypeName,
		@ReportSortTypeDisplayName = ReportSortTypeDisplayName
	FROM 
		@sortTypeList
	WHERE
		ID = @loopCount

	-- ADD sortTypeList TYPE		
		IF NOT EXISTS (
						SELECT     *
						FROM         reportsorttype
						WHERE     (ReportSortTypeName = @ReportSortTypeName) 
						AND		  (ReportSortTypeDisplayName = @ReportSortTypeDisplayName)
					  )	
		BEGIN
					INSERT reportsorttype
					VALUES (@ReportSortTypeName, @ReportSortTypeDisplayName)
		END
		IF NOT EXISTS (
				SELECT 	
					ReportSortTypeName,
					ReportSortTypeDisplayName 
				FROM 
					reportsorttypeConfiguration  rstc 
				JOIN 
					reportsorttype rst ON rst.reportsorttypeID = rstc.reportsorttypeID
				WHERE 
					ReportID = @ReportID
				AND 
					ReportSortTypeName = @ReportSortTypeName
				AND
					ReportSortTypeDisplayName = @ReportSortTypeDisplayName
	 			)
		BEGIN

			SELECT 
				@sortTypeID  = reportsorttypeID 
			FROM 
				reportsorttype 
			WHERE 
				ReportSortTypeName = @ReportSortTypeName
			AND 
				ReportSortTypeDisplayName = @ReportSortTypeDisplayName

			exec spi_reportsorttypeConfiguration
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

	 