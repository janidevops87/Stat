 

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[fn_SourceCodeForAdmininistrationByOrganizationId]') AND xtype in (N'FN', N'IF', N'TF'))
BEGIN
	PRINT 'DROP FUNCTION [dbo].[fn_SourceCodeForAdmininistrationByOrganizationId]'
	DROP FUNCTION [dbo].[fn_SourceCodeForAdmininistrationByOrganizationId]
END 
GO
PRINT 'CREATE FUNCTION [dbo].[fn_SourceCodeForAdmininistrationByOrganizationId]'
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE FUNCTION [dbo].[fn_SourceCodeForAdmininistrationByOrganizationId] 
(
	@OrganizationId int
)  
RETURNS TABLE
AS

/******************************************************************************
**	File: fn_SourceCodeForAdmininistrationByOrganizationId.sql
**	Name: fn_SourceCodeForAdmininistrationByOrganizationId
**	Desc: Get all the source code that this organization has access to.
**			This is similar to GetSourceCodeByOrganizationId function only statline has access to
**			all SourceCodes.
**	Auth: Bret Knoll
**	Date: 07/22/2009
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:		Author:			Description:
**	--------	--------		----------------------------------
**	07/22/2009	Bret Knoll		Initial Function Creation
**	7/14/2010	Bret Knoll		Resave for Release
*******************************************************************************/

RETURN

Select distinct wrgsc.SourceCodeId
from Organization org
	inner join WebReportGroup wrg ON org.OrganizationID = wrg.OrgHierarchyParentId
	inner join WebReportGroupSourceCode wrgsc ON wrg.WebReportGroupId = wrgsc.WebReportGroupId
WHERE
	-- If this is a Statline than get all the source code that is not a lease organization
	(
		@OrganizationId = 194 
	)		 
	-- If the organizatin is not Statline than get only the source code for that organization
	OR  (@OrganizationId != 194 AND org.OrganizationId = @OrganizationId)

