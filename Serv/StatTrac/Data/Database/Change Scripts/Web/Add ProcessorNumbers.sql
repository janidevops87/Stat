 
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
    @sortTypeID INT,
	@DateTypeID INT,
	@ReportDateTypeDefault INT

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
    @ReportDisplayName          = 'Processor Number',
    @ReportLocalOnly            = 0,
    @ReportVirtualURL           = '/StatTrac/Processor Number',
    @ReportTypeID               = 5,
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

IF NOT EXISTS (	SELECT * 
				from ReportControl rc join ReportParamConfiguration rpcf ON rpcf.ReportControlID = rc.ReportControlID 
				WHERE rpcf.ReportID = @ReportID AND ReportControlName = 'ddlReportDateType')
BEGIN
	select @ReportControlID = ReportControlID from ReportControl WHERE ReportControlName = 'ddlReportDateType'
	exec spi_ReportParamConfiguration
		@ReportID			,
		@ReportControlID	
END

IF NOT EXISTS (SELECT * 
				from ReportControl rc join ReportParamConfiguration rpcf ON rpcf.ReportControlID = rc.ReportControlID 
				WHERE rpcf.ReportID = @ReportID AND ReportControlName = 'webDateTimeEditStart')
BEGIN
	select @ReportControlID = ReportControlID from ReportControl WHERE ReportControlName = 'webDateTimeEditStart'
	exec spi_ReportParamConfiguration
		@ReportID			,
		@ReportControlID	
END

IF NOT EXISTS (SELECT * from ReportControl rc join ReportParamConfiguration rpcf ON rpcf.ReportControlID = rc.ReportControlID 
				WHERE rpcf.ReportID = @ReportID AND ReportControlName = 'webDateTimeEditEnd')
BEGIN
	select @ReportControlID = ReportControlID from ReportControl WHERE ReportControlName = 'webDateTimeEditEnd'
	exec spi_ReportParamConfiguration
		@ReportID			,
		@ReportControlID	
END

IF NOT EXISTS (SELECT * from ReportControl rc join ReportParamConfiguration rpcf ON rpcf.ReportControlID = rc.ReportControlID 
				WHERE rpcf.ReportID = @ReportID AND ReportControlName = 'ddlReportGroup')
BEGIN
	select @ReportControlID = ReportControlID from ReportControl WHERE ReportControlName = 'ddlReportGroup'
	exec spi_ReportParamConfiguration
		@ReportID			,
		@ReportControlID	
END

IF NOT EXISTS (SELECT * from ReportControl rc join ReportParamConfiguration rpcf ON rpcf.ReportControlID = rc.ReportControlID 
			WHERE rpcf.ReportID = @ReportID AND ReportControlName = 'ddlOrganization')
BEGIN
	select @ReportControlID = ReportControlID from ReportControl WHERE ReportControlName = 'ddlOrganization'
	exec spi_ReportParamConfiguration
		@ReportID			,
		@ReportControlID	
END

IF NOT EXISTS (SELECT * from ReportControl rc join ReportParamConfiguration rpcf ON rpcf.ReportControlID = rc.ReportControlID 
			WHERE rpcf.ReportID = @ReportID AND ReportControlName = 'ddlSourceCode')
BEGIN
	select 
		@ReportControlID = ReportControlID 
	FROM
		ReportControl 
	WHERE 
		ReportControlName = 'ddlSourceCode'
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
	
IF NOT EXISTS (SELECT * FROM ReportControl WHERE ReportControlName like 'chkBoxDisplayReferralName')
BEGIN
	insert ReportControl (ReportControlName, ReportParamSectionID) 
	values ('chkBoxDisplayReferralName', 6) 
END

select 
	@ReportControlID = 	ReportControlID from ReportControl WHERE ReportControlName = 'chkBoxDisplayReferralName'

if not exists( select * from reportparamconfiguration where reportID = @ReportID and reportcontrolID = @ReportControlID)
BEGIN
	exec spi_ReportParamConfiguration
		@ReportID			,
		@ReportControlID	
END	

IF NOT EXISTS (SELECT * FROM ReportControl WHERE ReportControlName like 'customParamsProcessor')
BEGIN
	insert ReportControl (ReportControlName, ReportParamSectionID) 
	values ('customParamsProcessor', 1) 
END

select 
	@ReportControlID = 	ReportControlID from ReportControl WHERE ReportControlName = 'customParamsProcessor'

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
			ReportDateTypeName = 'Referral'
		AND
			ReportDateTypeDisplayname = 'Referral'
	 	)
BEGIN

	SELECT 
		@DateTypeID  = ReportDateTypeID 
	FROM 
		ReportDateType 
	WHERE 
		ReportDateTypeName = 'Referral'
	AND 
		ReportDateTypeDisplayname = 'Referral'
set @ReportDateTypeDefault = 1
	exec spi_ReportDateTypeConfiguration
		@reportid,
		@DateTypeID,
		@ReportDateTypeDefault	
	
END


DECLARE 
	@sortTypeName varchar(100),
	@SorTypeDisplayName varchar(100)
	
select		
	@sortTypeName = 'ProcessorNumber',
	@SorTypeDisplayName = 'Processor #'

if not exists (select * from reportsorttype where ReportSortTypeName = @sortTypeName and ReportSortTypeDisplayName = @SorTypeDisplayName)
BEGIN
	INSERT 
		ReportSortType 
		(
		ReportSortTypeName, 
		ReportSortTypeDisplayName
		)
	VALUES
		(
			@sortTypeName, 
			@SorTypeDisplayName
		)
END
	select @sortTypeID = ReportSortTypeID 
	from reportsorttype 
	where ReportSortTypeName = @sortTypeName 
	and ReportSortTypeDisplayName = @SorTypeDisplayName
	

if not exists(select * from reportsorttypeconfiguration where ReportID = @reportid and ReportSortTypeID = @sortTypeID)
BEGIN
	exec spi_ReportSortTypeConfiguration
	@reportid,
	@sortTypeID	
END

select		
	@sortTypeName = 'AssignmentNotNeeded',
	@SorTypeDisplayName = 'Assignment Not Needed'

if not exists (select * from reportsorttype where ReportSortTypeName = @sortTypeName and ReportSortTypeDisplayName = @SorTypeDisplayName)
BEGIN
	INSERT 
		ReportSortType 
		(
		ReportSortTypeName, 
		ReportSortTypeDisplayName
		)
	VALUES
		(
			@sortTypeName, 
			@SorTypeDisplayName
		)
END
	select @sortTypeID = ReportSortTypeID 
	from reportsorttype 
	where ReportSortTypeName = @sortTypeName 
	and ReportSortTypeDisplayName = @SorTypeDisplayName
	

if not exists(select * from reportsorttypeconfiguration where ReportID = @reportid and ReportSortTypeID = @sortTypeID)
BEGIN
	exec spi_ReportSortTypeConfiguration
	@reportid,
	@sortTypeID	
END

select		
	@sortTypeName = 'CallID',
	@SorTypeDisplayName = 'Referral #'

if not exists (select * from reportsorttype where ReportSortTypeName = @sortTypeName and ReportSortTypeDisplayName = @SorTypeDisplayName)
BEGIN
	INSERT 
		ReportSortType 
		(
		ReportSortTypeName, 
		ReportSortTypeDisplayName
		)
	VALUES
		(
			@sortTypeName, 
			@SorTypeDisplayName
		)
END
	select @sortTypeID = ReportSortTypeID 
	from reportsorttype 
	where ReportSortTypeName = @sortTypeName 
	and ReportSortTypeDisplayName = @SorTypeDisplayName
	

if not exists(select * from reportsorttypeconfiguration where ReportID = @reportid and ReportSortTypeID = @sortTypeID)
BEGIN
	exec spi_ReportSortTypeConfiguration
	@reportid,
	@sortTypeID	
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

-- select * from reportdatetype

	 