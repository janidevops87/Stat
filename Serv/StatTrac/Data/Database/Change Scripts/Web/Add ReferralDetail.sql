  
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
    @ReportDateTypeDefault bit,
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
    @ReportDisplayName          = 'Referral Detail',
    @ReportLocalOnly            = 0,
    @ReportVirtualURL           = '/StatTrac/ReferralDetail',
    @ReportTypeID               = 1,
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
----- Age and Gender Section
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
---- End Age and Gender Section
						
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

IF NOT EXISTS (SELECT * FROM ReportControl WHERE ReportControlName like 'chkBoxDisplaySSN')
BEGIN
	insert ReportControl (ReportControlName, ReportParamSectionID) 
	values ('chkBoxDisplaySSN', 6) 
END

select 
	@ReportControlID = ReportControlID from ReportControl WHERE ReportControlName = 'chkBoxDisplaySSN'

if not exists( select * from reportparamconfiguration where reportID = @ReportID and reportcontrolID = @ReportControlID)
BEGIN
	exec spi_ReportParamConfiguration
		@ReportID			,
		@ReportControlID	
END	

IF NOT EXISTS (SELECT * FROM ReportControl WHERE ReportControlName like 'chkBoxDisplayMedicalRecord')
BEGIN
	insert ReportControl (ReportControlName, ReportParamSectionID) 
	values ('chkBoxDisplayMedicalRecord', 6) 
END

select 
	@ReportControlID = ReportControlID from ReportControl WHERE ReportControlName = 'chkBoxDisplayMedicalRecord'

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

IF NOT EXISTS (SELECT * FROM ReportControl WHERE ReportControlName like 'customParamsDisplayEventLog')
BEGIN
	insert ReportControl (ReportControlName, ReportParamSectionID) 
	values ('customParamsDisplayEventLog', 1) 
END

select 
	@ReportControlID = ReportControlID from ReportControl WHERE ReportControlName = 'customParamsDisplayEventLog'

if not exists( select * from reportparamconfiguration where reportID = @ReportID and reportcontrolID = @ReportControlID)
BEGIN
	exec spi_ReportParamConfiguration
		@ReportID			,
		@ReportControlID	
END					


IF NOT EXISTS (SELECT * FROM ReportControl WHERE ReportControlName like 'referralDetailParams')
BEGIN
	insert ReportControl (ReportControlName, ReportParamSectionID) 
	values ('referralDetailParams', 1) 
END

select 
	@ReportControlID = ReportControlID from ReportControl WHERE ReportControlName = 'referralDetailParams'

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
set @ReportDateTypeDefault = 1
if not exists(select * from ReportDateTypeConfiguration where ReportID = @ReportID and ReportDateTypeID = @ReportDateTypeID )
begin
	exec spi_ReportDateTypeConfiguration
		@ReportID	,
		@ReportDateTypeID ,
		@ReportDateTypeDefault
end	

select @ReportDateTypeID = 2
set @ReportDateTypeDefault = 0
if not exists(select * from ReportDateTypeConfiguration where ReportID = @ReportID and ReportDateTypeID = @ReportDateTypeID )
begin
	exec spi_ReportDateTypeConfiguration
		@ReportID	,
		@ReportDateTypeID ,
		@ReportDateTypeDefault

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
DECLARE 
	@sortTypeName varchar(100),
	@SorTypeDisplayName varchar(100)
	
select		
	@sortTypeName = 'PreliminaryRefType',
	@SorTypeDisplayName = 'Referral Type'

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
	@sortTypeName = 'CallDateTime',
	@SorTypeDisplayName = 'Base on D/T'

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
	@sortTypeName = 'ReferralDonorLastName',
	@SorTypeDisplayName = 'Patient Last Name'

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
ELSE
BEGIN
	select @sortTypeID = ReportSortTypeID 
	from reportsorttype 
	where ReportSortTypeName = @sortTypeName 
	and ReportSortTypeDisplayName = @SorTypeDisplayName
	
END	
if not exists(select * from reportsorttypeconfiguration where ReportID = @reportid and ReportSortTypeID = @sortTypeID)
BEGIN
	exec spi_ReportSortTypeConfiguration
	@reportid,
	@sortTypeID	
END

select		
	@sortTypeName = 'ReferralFacility',
	@SorTypeDisplayName = 'Referral Facility'

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
ELSE
BEGIN
	select @sortTypeID = ReportSortTypeID 
	from reportsorttype 
	where ReportSortTypeName = @sortTypeName 
	and ReportSortTypeDisplayName = @SorTypeDisplayName
	
END	
if not exists(select * from reportsorttypeconfiguration where ReportID = @reportid and ReportSortTypeID = @sortTypeID)
BEGIN
	exec spi_ReportSortTypeConfiguration
	@reportid,
	@sortTypeID	
END

select		
	@sortTypeName = 'InitialApproachType',
	@SorTypeDisplayName = 'Initial Approach Type'

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
ELSE
BEGIN
	select @sortTypeID = ReportSortTypeID 
	from reportsorttype 
	where ReportSortTypeName = @sortTypeName 
	and ReportSortTypeDisplayName = @SorTypeDisplayName
	
END	
if not exists(select * from reportsorttypeconfiguration where ReportID = @reportid and ReportSortTypeID = @sortTypeID)
BEGIN
	exec spi_ReportSortTypeConfiguration
	@reportid,
	@sortTypeID	
END
		
select		
	@sortTypeName = 'FinalApproachType',
	@SorTypeDisplayName = 'Final Approach Type'

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
ELSE
BEGIN
	select @sortTypeID = ReportSortTypeID 
	from reportsorttype 
	where ReportSortTypeName = @sortTypeName 
	and ReportSortTypeDisplayName = @SorTypeDisplayName
	
END	
if not exists(select * from reportsorttypeconfiguration where ReportID = @reportid and ReportSortTypeID = @sortTypeID)
BEGIN
	exec spi_ReportSortTypeConfiguration
	@reportid,
	@sortTypeID	
END

declare 
	@ReportDateTimeID int 
	
select 
	@ReportDateTimeID = ReportDateTimeID from reportdatetime where ReportDateTimeName = 'Now'
if not exists (select * from reportdatetimeconfiguration where ReportDateTimeID = @ReportDateTimeID and ReportID = @reportid)
begin
	EXEC spi_ReportDateTimeConfiguration
		@ReportID,
		@ReportDateTimeID	
end

