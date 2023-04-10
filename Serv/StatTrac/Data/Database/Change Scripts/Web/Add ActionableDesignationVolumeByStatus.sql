    
-- Report Table Paramters
Declare 
	@ReportID int,
    @ReportDisplayName          varchar(50) ,
    @LastModified               datetime ,
    @ReportLocalOnly            int, -- 0 false, -1 true
    @ReportVirtualURL           varchar(100),
    @ReportDateTypeName			varchar(500),
    @ReportDateTypeDisplayName  varchar(500),
    @ReportDateTimeID			int,
    @ReportDateTypeDefault		int,
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

/* Note: If run in TEST change @ReportVirtualURL to the following:
    @ReportVirtualURL           = '/StatTrac Test/ActionableDesignationVolumeByStatus',
*/                   
SELECT
    @ReportDisplayName          = 'Actionable Designation Volume by Status',
    @ReportLocalOnly            = 0,
    @ReportVirtualURL           = '/StatTrac/ActionableDesignationVolumeByStatus',
    @ReportTypeID               = 6,
    @Unused                     = null,
    @ReportDescFileName         = 'nodesc.shm',
    @UpdatedFlag                = null,
    @ReportSortOrderID          = null,
    @ReportInDevelopment        = null,
    @ReportFromDate             = null,
    @ReportToDate               = null,
    @ReportGroup                = null,
    @ReportOrganization         = null


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
SET @ReportControlName ='ddlReportDateType'

IF NOT EXISTS (SELECT * FROM ReportControl WHERE ReportControlName like @ReportControlName)
BEGIN
	insert ReportControl (ReportControlName, ReportParamSectionID) 
	values (@ReportControlName, 2) 
END

select 
	@ReportControlID = 
	ReportControlID from ReportControl WHERE ReportControlName = @ReportControlName

if not exists( select * from reportparamconfiguration where reportID = @ReportID and reportcontrolID = @ReportControlID)
BEGIN
	exec spi_ReportParamConfiguration
		@ReportID			,
		@ReportControlID	
END	

SET @ReportControlName = 'webDateTimeEditStart'

IF NOT EXISTS (SELECT * FROM ReportControl WHERE ReportControlName like @ReportControlName)
BEGIN
	insert ReportControl (ReportControlName, ReportParamSectionID) 
	values (@ReportControlName, 2) 
END

select 
	@ReportControlID = ReportControlID from ReportControl WHERE ReportControlName = @ReportControlName

if not exists( select * from reportparamconfiguration where reportID = @ReportID and reportcontrolID = @ReportControlID)
BEGIN
	exec spi_ReportParamConfiguration
		@ReportID			,
		@ReportControlID	
END	

SET @ReportControlName = 'webDateTimeEditEnd'

IF NOT EXISTS (SELECT * FROM ReportControl WHERE ReportControlName like @ReportControlName)
BEGIN
	insert ReportControl (ReportControlName, ReportParamSectionID) 
	values (@ReportControlName, 2) 
END

select 
	@ReportControlID = ReportControlID from ReportControl WHERE ReportControlName = @ReportControlName

if not exists( select * from reportparamconfiguration where reportID = @ReportID and reportcontrolID = @ReportControlID)
BEGIN
	exec spi_ReportParamConfiguration
		@ReportID			,
		@ReportControlID	
END	

/*
------customParamsRegistryState-----------------------------------------------
IF NOT EXISTS (SELECT * FROM ReportControl WHERE ReportControlName like 'customParamsRegistryState')
BEGIN
	insert ReportControl (ReportControlName, ReportParamSectionID) 
	values ('customParamsRegistryState', 1) 
END

select 
	@ReportControlID = ReportControlID from ReportControl WHERE ReportControlName = 'customParamsRegistryState'

if not exists( select * from reportparamconfiguration where reportID = @ReportID and reportcontrolID = @ReportControlID)
BEGIN
	exec spi_ReportParamConfiguration
		@ReportID			,
		@ReportControlID	
END
*/
		
------customParamsRegistryGroupBy--------------------------------------		
SET @ReportControlName = 'customParamsRegistryGroupBy'	
IF NOT EXISTS (SELECT * FROM ReportControl WHERE ReportControlName like @ReportControlName)
BEGIN
	insert ReportControl (ReportControlName, ReportParamSectionID) 
	values (@ReportControlName, 1) 
END

select 
	@ReportControlID = ReportControlID from ReportControl WHERE ReportControlName = @ReportControlName

if not exists( select * from reportparamconfiguration where reportID = @ReportID and reportcontrolID = @ReportControlID)
BEGIN
	exec spi_ReportParamConfiguration
		@ReportID			,
		@ReportControlID	
END	

------customParamsRegistryDonorDesignationStatus------------------------------------------
SET @ReportControlName  = 'customParamsRegistryDonorDesignationStatus'
IF NOT EXISTS (SELECT * FROM ReportControl WHERE ReportControlName like @ReportControlName)
BEGIN
	insert ReportControl (ReportControlName, ReportParamSectionID) 
	values (@ReportControlName, 1) 
END

select 
	@ReportControlID = ReportControlID from ReportControl WHERE ReportControlName = @ReportControlName

if not exists( select * from reportparamconfiguration where reportID = @ReportID and reportcontrolID = @ReportControlID)
BEGIN
	exec spi_ReportParamConfiguration
		@ReportID			,
		@ReportControlID	
END	

--- customParamsRegistryState 
SET @ReportControlName  = 'customParamsRegistryState'
IF NOT EXISTS (SELECT * FROM ReportControl WHERE ReportControlName like @ReportControlName)
BEGIN
	insert ReportControl (ReportControlName, ReportParamSectionID) 
	values (@ReportControlName, 1) 
END

select 
	@ReportControlID = ReportControlID from ReportControl WHERE ReportControlName = @ReportControlName

if not exists( select * from reportparamconfiguration where reportID = @ReportID and reportcontrolID = @ReportControlID)
BEGIN
	exec spi_ReportParamConfiguration
		@ReportID			,
		@ReportControlID	
END	

--- customParamsRegistryDMVWebControl 
SET @ReportControlName  = 'customParamsRegistryDMVWebControl'
IF NOT EXISTS (SELECT * FROM ReportControl WHERE ReportControlName like @ReportControlName)
BEGIN
	insert ReportControl (ReportControlName, ReportParamSectionID) 
	values (@ReportControlName, 1) 
END

select 
	@ReportControlID = ReportControlID from ReportControl WHERE ReportControlName = @ReportControlName

if not exists( select * from reportparamconfiguration where reportID = @ReportID and reportcontrolID = @ReportControlID)
BEGIN
	exec spi_ReportParamConfiguration
		@ReportID			,
		@ReportControlID	
END	



select 
	@ReportDateTimeID = ReportDateTimeID from reportdatetime where ReportDateTimeName = 'Monthly'
if not exists (select * from reportdatetimeconfiguration where ReportDateTimeID = @ReportDateTimeID and ReportID = @reportid)
begin
	EXEC spi_ReportDateTimeConfiguration
		@ReportID,
		@ReportDateTimeID	
end
SET @ReportDateTypeName = 'LastModified'
SET @ReportDateTypeDisplayName  = 'Last Modified'

if not exists (SELECT * From reportdatetype WHERE reportDateTypeName = @ReportDateTypeName)
BEGIN 
INSERT reportdatetype 
VALUES (@ReportDateTypeName, @ReportDateTypeDisplayName)
END
select @ReportDateTypeID = ReportDateTypeID From reportdatetype WHERE reportDateTypeName = @ReportDateTypeName
set @ReportDateTypeDefault = 1
if not exists(select * from ReportDateTypeConfiguration where ReportID = @ReportID and ReportDateTypeID = @ReportDateTypeID )
begin
	exec spi_ReportDateTypeConfiguration
		@ReportID	,
		@ReportDateTypeID ,
		@ReportDateTypeDefault
end	

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