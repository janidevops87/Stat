  
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
    @ReportDateTypeID			int,
	--- used to set Report DateTime Configuration
	@ReportDateTimeID			int,
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
	@roleID						  int,
	@RoleName					  varchar(50),
	@ReportControlID			  int,
	@ReportControlName 			  varchar(50),
	@ReportParamSectionID 		  int		         
                  
SELECT
    @ReportDisplayName          = 'FS Hourly',
    @ReportLocalOnly            = 0,
    @ReportVirtualURL           = '/StatTrac/FS Hourly',
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
                    
exec SPI_Permission
                  @PERMISSIONID                 OUTPUT,
                  @PERMISSIONNAME               ,
                  @PERMISSIONTYPEID             ,
                  @FUNCTIONID                   ,
                  @PERMISSIONDESCRIPTION         ,
                  @ACTIVE                       
                  


SELECT @WEBPERSONID = 296

exec SPI_WebPersonPermission
                  @WEBPERSONPERMISSIONID        OUTPUT ,
                  @WEBPERSONID                  ,
                  @PERMISSIONID                 
                  
	/* ccarroll 01/07/2008 - remove pre-existing configuration */
	DELETE dbo.ReportDateTimeConfiguration  WHERE ReportID = @ReportID
	DELETE dbo.ReportDateTypeConfiguration WHERE ReportID = @ReportID
	DELETE dbo.ReportParamConfiguration WHERE ReportID = @ReportID
	DELETE dbo.ReportSortTypeConfiguration WHERE ReportID = @ReportID


/*
	1	ReportSpecificParams
	2	DateAndTime
	3	CoordinatorOrganization
	4	AgeGender
	5	SortOptions
	6	DisplayOptions

*/	
/*
controlID controlname control section
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

select @ReportControlID = 2
exec spi_ReportParamConfiguration
	@ReportID			,
	@ReportControlID	                  

select @ReportControlID = 3
exec spi_ReportParamConfiguration
	@ReportID			,
	@ReportControlID	                  

select @ReportControlID = 6
exec spi_ReportParamConfiguration
	@ReportID			,
	@ReportControlID	
	
select @ReportControlID = 7
exec spi_ReportParamConfiguration
	@ReportID			,
	@ReportControlID


select @RoleName = 'AdminUser'	    

EXEC GetRoleIdByName
	@Rolename,
	@roleID OUTPUT
	
exec spi_ReportRule @ReportID, @roleID	

-- this sets the DateTime
/*
1	Monthly
2	Yesterday
3	Today
4	Now
*/
select @ReportDateTimeID = 3
exec spi_ReportDateTimeConfiguration 
	@ReportID	,
	@ReportDateTypeID 
	