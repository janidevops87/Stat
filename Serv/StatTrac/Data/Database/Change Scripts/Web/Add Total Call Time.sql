  
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
    @ReportDateTimeID int,
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
    @ReportDisplayName          = 'Total Call Time',
    @ReportLocalOnly            = 0,
    @ReportVirtualURL           = '/StatTrac/TotalCallTime',
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
	)	-- select * from reportControl
INSERT @controlList
VALUES('ddlReportDateType', 2)
INSERT @controlList
VALUES('webDateTimeEditStart', 2)
INSERT @controlList
VALUES('webDateTimeEditEnd', 2)
INSERT @controlList
VALUES('ddlReportGroup', 3)
INSERT @controlList
VALUES('ddlSourceCode', 3)
INSERT @controlList
VALUES('ddlOrganization', 3)

INSERT @controlList
VALUES('ddlOrganizationCoordinator', 3)

INSERT @controlList
VALUES('ddlGender', 4)
INSERT @controlList
VALUES('txtBoxLowerAge', 4)
INSERT @controlList
VALUES('txtBoxUpperAge', 4)
/*
INSERT @controlList
VALUES('chkBoxDisplayReferralName', 6)
INSERT @controlList
VALUES('chkBoxDisplayMedicalRecord', 6)
INSERT @controlList
VALUES('customParamsMedicalRecordNumber', 1)
INSERT @controlList
VALUES('customParamsReferralType', 1)
INSERT @controlList
VALUES('customParamsPatientName', 1)
*/
INSERT @controlList
VALUES('ddlSortOption1', 5)
INSERT @controlList
VALUES('ddlSortOption2', 5)
INSERT @controlList
VALUES('ddlSortOption3', 5)
INSERT @controlList
VALUES('callParams', 1)
-- INSERT @controlList
-- VALUES('referralDetailParams', 1)
--INSERT @controlList
--VALUES('customParamsMessageFor', 1)
--INSERT @controlList
--VALUES('customParamsDisplayEventLog', 1)
INSERT @controlList
VALUES('radionButtonTimeZoneReferral', 7)
INSERT @controlList
VALUES('radionButtonTimeZoneMountain', 7)

SELECT @loopCount = 1, @loopMax = Count(ID) FROM @controlList


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
select @ReportDateTypeID = 1
if not exists(select * from ReportDateTypeConfiguration where ReportID = @ReportID and ReportDateTypeID = @ReportDateTypeID )
begin
	exec spi_ReportDateTypeConfiguration
		@ReportID	,
		@ReportDateTypeID 
end	

--select * from report where ReportDisplayName like '%Total Call Time%'
SELECT @reportID = ReportID from report where ReportDisplayName like 'Total Call Time'
/*
SELECT '
	IF NOT EXISTS (
	SELECT * 
	FROM ReportSortTypeConfiguration rstc 
	JOIN ReportSortType rst ON rst.ReportSortTypeID = rstc.ReportSortTypeID 
	Where ReportID = @reportID
	AND
	 	ReportSortTypeName = ''' + ReportSortTypeName + ''' AND ReportSortTypeDisplayName = ''' + ReportSortTypeDisplayName + ''' ) 
	BEGIN
		SELECT @sortTypeID = ReportSortTypeID FROM ReportSortType WHERE ReportSortTypeName = ''' + ReportSortTypeName + ''' AND ReportSortTypeDisplayName = ''' + ReportSortTypeDisplayName + ''' 
		EXEC spi_ReportSortTypeConfiguration
		@reportid,
		@sortTypeID

	END'
	FROM ReportSortTypeConfiguration rstc 
	JOIN ReportSortType rst ON rst.ReportSortTypeID = rstc.ReportSortTypeID 
	Where ReportID = @reportID
*/

--- ******************* Sort Type Start

DECLARE 
	@sortTypeName varchar(100),
	@SorTypeDisplayName varchar(100)
	
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


select		
	@sortTypeName = 'SourceCodeName',
	@SorTypeDisplayName = 'Source Code'

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
	@sortTypeName = 'IncomingCall',
	@SorTypeDisplayName = 'Triage Incoming Call'

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
	@sortTypeName = 'Diff_IncomingToSecondary',
	@SorTypeDisplayName = 'Time Triage To Secondary'

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
	@sortTypeName = 'Diff_SecondaryPendingToScreening',
	@SorTypeDisplayName = 'Time Secondary To Screening'

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
	@sortTypeName = 'CallDateTime',
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
	@sortTypeName = 'Diff_IncomingToPaperwork',
	@SorTypeDisplayName = 'Total Time Elapsed'

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




--- ******************* Sort Type End

select 
	@ReportDateTimeID = ReportDateTimeID from reportdatetime where ReportDateTimeName = 'Today'
if not exists (select * from reportdatetimeconfiguration where ReportDateTimeID = @ReportDateTimeID and ReportID = @reportid)
begin
	EXEC spi_ReportDateTimeConfiguration
		@ReportID,
		@ReportDateTimeID	
end	
	