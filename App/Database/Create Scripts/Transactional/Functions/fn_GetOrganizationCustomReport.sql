 IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[fn_GetOrganizationCustomReport]') AND xtype in (N'FN', N'IF', N'TF'))
 --IF EXISTS (SELECT * FROM sysobjects WHERE type = 'IF' AND name = 'fn_GetOrganizationCustomReport')
	BEGIN
		PRINT 'Dropping Function fn_GetOrganizationCustomReport'
		DROP Function fn_GetOrganizationCustomReport
	END
GO

PRINT 'Creating Function fn_GetOrganizationCustomReport' 
GO

CREATE FUNCTION [dbo].[fn_GetOrganizationCustomReport]
(
	@OrganizationId int
)  
RETURNS int
AS

/******************************************************************************
**	File: fn_GetOrganizationCustomReport.sql
**	Name: fn_GetOrganizationCustomReport
**	Desc: Determine whether an image should show on a report
**	Auth: jth
**	Date: 07/2010
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:		Author:			Description:
**	--------	--------		----------------------------------
**	7/10 		jth				Initial Function Creation
*******************************************************************************/
BEGIN
DECLARE @Output AS Int
SET @Output = 0
select @Output = OrganizationCustomReportID
from OrganizationCustomReport
where OrganizationCustomReport.OrganizationID = @OrganizationId
RETURN @Output
End  