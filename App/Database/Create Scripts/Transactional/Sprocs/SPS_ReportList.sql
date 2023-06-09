
PRINT 'Dropping Procedure SPS_ReportList';
DROP PROCEDURE IF EXISTS SPS_ReportList;
GO

PRINT 'Creating Procedure SPS_ReportList';
GO

CREATE PROCEDURE SPS_ReportList
	@ReportTypeID	INT = NULL,
    @UserOrgID		INT = NULL,
	@UserID			INT = NULL
AS

/******************************************************************************
**		File: SPS_ReportList.sql
**		Name: SPS_ReportList
**		Desc: returns a list of Reports
**              
**		Return values:
** 
**		Called by:   Old Reporting Site (Weblogin)
**              
**		Parameters:
**		Input							Output
**     ----------						-----------
**		See above
**
**		Auth: ? 
**		Date: ?
**
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			---------------------------------------
**		?			?					Initial Creation
**		12/15/2020	Mike Berenson		Refactored to improve readability & conform with coding standards
**		12/15/2020	Mike Berenson		Added where clause statements to make sure we only show old reports 
**                                          (ReportID < 300) in our old website
**		12/16/2020	Mike Berenson		Removed QUOTED_IDENTIFIER and ANSI_NULLS statements
**
*******************************************************************************/

BEGIN

	DECLARE  
		@intRetCode		INT = 0,
		@intRowcount	INT,
		@intError		INT,
		@ctr			INT;

	IF @ReportTypeID IS NOT NULL AND @UserOrgID IS NOT NULL AND @UserID IS NOT NULL
	BEGIN
		-- *************************
		IF @ReportTypeID = 1 OR @ReportTypeID = 2 OR @ReportTypeID = 3  --REFERRAL ACTIVITY OR MESSAGES OR IMPORTS
		BEGIN
			IF @UserOrgID <> 194
			BEGIN
				SELECT ReportID, ReportDisplayName, ReportVirtualUrl, ReportDescFileName 
				FROM Report 
				WHERE ReportTypeID = @ReportTypeID
				AND ReportLocalOnly = 0 
				AND ReportID IN (
						SELECT functionID
						FROM permission, webpersonpermission
						WHERE webpersonid = @UserID
						AND webpersonpermission.permissionid = permission.permissionid
						AND permission.permissiontypeid = 2
						AND permission.functionID < 300
						)
				ORDER BY ReportDisplayName;
			END
			ELSE
			BEGIN
				SELECT ReportID, ReportDisplayName, ReportVirtualUrl, ReportDescFileName 
				FROM Report 
				WHERE ReportTypeID = @ReportTypeID
				AND ReportID IN (
						SELECT functionID
						FROM permission, webpersonpermission
						WHERE webpersonid = @UserID
						AND webpersonpermission.permissionid = permission.permissionid
						AND permission.permissiontypeid = 2
						AND permission.functionID < 300
						)
				ORDER BY ReportDisplayName;
			END
		END
		-- *************************
		IF @ReportTypeID = 4 --REFERRAL STATS
		BEGIN
			IF @UserOrgID = 194	
			BEGIN
				SELECT DISTINCT
				 		ReportID, 
						ReportDisplayName, 
						ReportVirtualUrl, 
						ReportDescFileName 
				FROM 		Report 
				WHERE 	ReportTypeID = @ReportTypeID
				AND ReportID IN (
						SELECT functionID
						FROM permission, webpersonpermission
						WHERE webpersonid = @UserID
						AND webpersonpermission.permissionid = permission.permissionid
						AND permission.permissiontypeid = 2
						AND permission.functionID < 300
						)
				ORDER BY	ReportDisplayName;
			END
			ELSE
			BEGIN
				SELECT @ctr = Count(*) 
				FROM 		Report 
				JOIN		ReportCustom ON Report.ReportID = ReportCustom.ReportCustomReportID
				WHERE 	ReportTypeID = @ReportTypeID
				AND 		ReportLocalOnly = 0
				AND		ReportCustomOrganizationID = @UserOrgID
				AND ReportID IN (
						SELECT functionID
						FROM permission, webpersonpermission
						WHERE webpersonid = @UserID
						AND webpersonpermission.permissionid = permission.permissionid
						AND permission.permissiontypeid = 2
						AND permission.functionID < 300
						);

				IF @ctr	<> 0 
				BEGIN
					SELECT DISTINCT	
						ReportID, 
						ReportDisplayName, 
						ReportVirtualUrl, 
						ReportDescFileName 
					FROM 		Report 
					JOIN		ReportCustom ON Report.ReportID = ReportCustom.ReportCustomReportID
					WHERE 	ReportTypeID = @ReportTypeID
					AND		ReportCustomOrganizationID = @UserOrgID
					AND ReportID IN (
							SELECT functionID
							FROM permission, webpersonpermission
							WHERE webpersonid = @UserID
							AND webpersonpermission.permissionid = permission.permissionid
							AND permission.permissiontypeid = 2
							AND permission.functionID < 300
							)
					ORDER BY	ReportDisplayName;
				END
				ELSE
				BEGIN
					SELECT DISTINCT
				 		ReportID, 
						ReportDisplayName, 
						ReportVirtualUrl, 
						ReportDescFileName 
					FROM 		Report 
					WHERE 	ReportTypeID = @ReportTypeID
					AND 		ReportLocalOnly = 0
					AND ReportID IN (
							SELECT functionID
							FROM permission, webpersonpermission
							WHERE webpersonid = @UserID
							AND webpersonpermission.permissionid = permission.permissionid
							AND permission.permissiontypeid = 2
							AND permission.functionID < 300
							)
					ORDER BY	ReportDisplayName;
				END
			END
		END
		-- *************************
		IF @ReportTypeID = 5 --GENERAL
		BEGIN
			SELECT	ReportID,
					ReportDisplayName,					
					ReportVirtualUrl, 
					ReportDescFileName,
      				ReportFromDate,
       				ReportToDate,
       				ReportGroup,
       				ReportOrganization
			FROM   	Report
			WHERE  	ReportTypeID = @ReportTypeID
			AND ReportID IN (
					SELECT functionID
					FROM permission, webpersonpermission
					WHERE webpersonid = @UserID
					AND webpersonpermission.permissionid = permission.permissionid
					AND permission.permissiontypeid = 2
					AND permission.functionID < 300
					)
			ORDER BY 	ReportDisplayName;
		END
		-- *************************
		IF @ReportTypeID = 6 --CUSTOM REPORTS
		BEGIN
			IF @UserOrgID = 194	
			BEGIN
				SELECT DISTINCT
				 		ReportID, 
						ReportDisplayName, 
						ReportVirtualUrl, 
						ReportDescFileName 
				FROM 		Report 
				WHERE 	ReportTypeID = @ReportTypeID
				AND ReportID IN (
						SELECT functionID
						FROM permission, webpersonpermission
						WHERE webpersonid = @UserID
						AND webpersonpermission.permissionid = permission.permissionid
						AND permission.permissiontypeid = 2
						AND permission.functionID < 300
						)
				ORDER BY	ReportDisplayName;
			END
			ELSE
			BEGIN
				SELECT DISTINCT	
						ReportID, 
						ReportDisplayName, 
						ReportVirtualUrl, 
						ReportDescFileName 
				FROM 		Report 
				JOIN		ReportCustom ON Report.ReportID = ReportCustom.ReportCustomReportID
				WHERE 	ReportTypeID = @ReportTypeID
				AND		ReportCustomOrganizationID = @UserOrgID
				AND ReportID IN (
						SELECT functionID
						FROM permission, webpersonpermission
						WHERE webpersonid = @UserID
						AND webpersonpermission.permissionid = permission.permissionid
						AND permission.permissiontypeid = 2
						AND permission.functionID < 300
						)
				ORDER BY	ReportDisplayName;
			END
		END
		-- *************************
		IF @ReportTypeID = 7 --SCHEDULE
		BEGIN
			SELECT ReportID, ReportDisplayName, ReportVirtualUrl, ReportDescFileName 
			FROM Report 
			WHERE ReportTypeID = @ReportTypeID 
			AND ReportID IN (
					SELECT functionID
					FROM permission, webpersonpermission
					WHERE webpersonid = @UserID
					AND webpersonpermission.permissionid = permission.permissionid
					AND permission.permissiontypeid = 2
					AND permission.functionID < 300
					)
			ORDER BY ReportDisplayName;
		END
	END

	SELECT 
		@intRowCount = @@rowcount, 
		@intError = @@error;

	IF @intRowCount = 0 OR @intError <> 0
	BEGIN
		SELECT @intRetcode = 6;
		RETURN -(@intRetcode);
	END

	RETURN @intRetCode;

END
GO

