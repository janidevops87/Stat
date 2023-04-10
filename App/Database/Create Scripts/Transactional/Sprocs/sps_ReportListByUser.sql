

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sps_ReportListByUser')
	BEGIN
		PRINT 'Dropping Procedure sps_ReportListByUser';
		DROP Procedure sps_ReportListByUser;
	END
GO

PRINT 'Creating Procedure sps_ReportListByUser';
GO


CREATE PROCEDURE sps_ReportListByUser
	@UserName nvarchar(25)
AS

/******************************************************************************
**	File: sps_ReportListByUser.sql
**	Name: sps_ReportListByUser
**	Desc: Pulls list of reports user is authorized to use.
**	Auth: Pam Scheichenost
**	Date: 10/30/2020
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:						Description:
**	--------		--------					------------------------------
**	10/30/2020		Pam Scheichenost			Initial Sproc Creation
*******************************************************************************/

 
DECLARE
	@Reports Table (
		ReportType nvarchar(500),
		ReportName nvarchar(50),
		[Url] nvarchar(100),
		ReportId int,
		CustomReportControlName nvarchar(50)
	);

INSERT INTO @Reports
(
	ReportType,
	ReportName,
	[Url],
	ReportId 
)
Select Distinct
        rptTyp.ReportTypeName AS ReportType, 
        rpt.ReportDisplayName AS ReportName,
	    rpt.ReportVirtualURL as [Url],
        rpt.ReportID AS ReportID
    From
        WebPerson webPrsn 
		INNER JOIN UserRoles ur on webPrsn.WebPersonID = ur.WebPersonID
		INNER JOIN ReportRule rr on ur.RoleID = rr.RoleID
		INNER JOIN Report rpt on rr.ReportID = rpt.ReportID
        INNER JOIN ReportType rptTyp ON rpt.ReportTypeID = rptTyp.REPORTTYPEID
    Where
		--id's under 300 will be for the old site, above 300 is for new site
		rpt.ReportId >= 300 AND
        webPrsn.WebPersonUserName = @UserName AND
        PATINDEX('%sls%',rpt.ReportVirtualURL) = 0 AND 
        PATINDEX('%slf%',rpt.ReportVirtualURL) = 0;

UPDATE @Reports
SET CustomReportControlName = rc.ReportControlName
FROM @Reports r
inner join dbo.ReportParamConfiguration config on r.ReportId = config.ReportID
inner join dbo.ReportControl rc on config.ReportControlID = rc.ReportControlID AND rc.ReportParamSectionID = 1
where rc.ReportParamSectionID = 1;

SELECT *
FROM @Reports
order by ReportType, ReportName;



GO


GRANT EXEC ON sps_ReportListByUser TO PUBLIC
GO
