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
    @sortTypeName varchar(100),
	@SorTypeDisplayName varchar(100),
	@ReportControlID	int,
	@ReportControlName 	[varchar](50),
	@ReportParamSectionID 	[int],	
	@roleID int,
	@RoleName varchar(50),
	@ReportDateTimeID int,
	
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
    @WEBPERSONID                  int
                  
SELECT
    @ReportDisplayName          = 'Message Audit Trail',
    @ReportLocalOnly            = 0,
    @ReportVirtualURL           = '/StatTrac/MessageAuditTrail',
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

IF NOT EXISTS (SELECT * FROM ReportControl WHERE ReportControlName like 'callParams')
BEGIN
	insert ReportControl (ReportControlName, ReportParamSectionID) 
	values ('callParams', 1) 
END

select 
	@ReportControlID = 	ReportControlID from ReportControl WHERE ReportControlName = 'callParams'

if not exists( select * from reportparamconfiguration where reportID = @ReportID and reportcontrolID = @ReportControlID)
BEGIN
	exec spi_ReportParamConfiguration
		@ReportID			,
		@ReportControlID	
END					

IF NOT EXISTS (SELECT * FROM ReportControl WHERE ReportControlName like 'customParamsStatTracUser')
BEGIN
	insert ReportControl (ReportControlName, ReportParamSectionID) 
	values ('customParamsStatTracUser', 1) 
END

select @ReportControlID = ReportControlID from ReportControl WHERE ReportControlName = 'customParamsStatTracUser'
if not exists( select * from reportparamconfiguration where reportID = @ReportID and reportcontrolID = @ReportControlID)
BEGIN
	exec spi_ReportParamConfiguration
		@ReportID			,
		@ReportControlID	
END					
IF NOT EXISTS (SELECT * FROM ReportControl WHERE ReportControlName like 'radionButtonTimeZoneMountain')
BEGIN
	insert ReportControl (ReportControlName, ReportParamSectionID) 
	values ('radionButtonTimeZoneMountain', 1) 
END

select @ReportControlID = ReportControlID from ReportControl WHERE ReportControlName = 'radionButtonTimeZoneMountain'
if not exists( select * from reportparamconfiguration where reportID = @ReportID and reportcontrolID = @ReportControlID)
BEGIN
	exec spi_ReportParamConfiguration
		@ReportID			,
		@ReportControlID	
END					

IF NOT EXISTS (SELECT * FROM ReportControl WHERE ReportControlName like 'radionButtonTimeZoneReferral')
BEGIN
	insert ReportControl (ReportControlName, ReportParamSectionID) 
	values ('radionButtonTimeZoneReferral', 1) 
END

select @ReportControlID = ReportControlID from ReportControl WHERE ReportControlName = 'radionButtonTimeZoneReferral'
if not exists( select * from reportparamconfiguration where reportID = @ReportID and reportcontrolID = @ReportControlID)
BEGIN
	exec spi_ReportParamConfiguration
		@ReportID			,
		@ReportControlID	
END					


/*
select @ReportControlID = ReportControlID from ReportControl WHERE ReportControlName = 'customParamsOrganization'
exec spi_ReportParamConfiguration
	@ReportID			,
	@ReportControlID	
*/


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

IF NOT EXISTS (SELECT * FROM ReportDateType where ReportDateTypeName = 'Change')
BEGIN
	INSERT 
		ReportDateType
	VALUES
		('Change',
		 'Change')
END

SELECT @ReportDateTypeID = ReportDateTypeID FROM ReportDateType WHERE ReportDateTypeName = 'Change'

if not exists(select * from ReportDateTypeConfiguration where ReportID = @ReportID and ReportDateTypeID = @ReportDateTypeID )
begin
	exec spi_ReportDateTypeConfiguration
		@ReportID	,
		@ReportDateTypeID 
end
	
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

select		
	@sortTypeName = 'ChangeDT',
	@SorTypeDisplayName = 'Based on D/T'

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
	@sortTypeName = 'ChangeUser',
	@SorTypeDisplayName = 'StatTrac User'

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
	@sortTypeName = 'ChangeType',
	@SorTypeDisplayName = 'Change Type'

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
	@ReportDateTimeID = ReportDateTimeID from reportdatetime where ReportDateTimeName = 'Now'
if not exists (select * from reportdatetimeconfiguration where ReportDateTimeID = @ReportDateTimeID and ReportID = @reportid)
begin
	EXEC spi_ReportDateTimeConfiguration
		@ReportID,
		@ReportDateTimeID	
end


