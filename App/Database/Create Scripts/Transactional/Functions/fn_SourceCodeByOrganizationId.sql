
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[fn_SourceCodeByOrganizationId]') AND xtype in (N'FN', N'IF', N'TF'))
BEGIN
	PRINT 'DROP FUNCTION [dbo].[fn_SourceCodeByOrganizationId]'
	DROP FUNCTION [dbo].[fn_SourceCodeByOrganizationId]
END 
GO
PRINT 'CREATE FUNCTION [dbo].[fn_SourceCodeByOrganizationId]'
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE FUNCTION [dbo].[fn_SourceCodeByOrganizationId] 
(
	@OrganizationId int
)  
RETURNS TABLE
AS

/******************************************************************************
**	File: fn_SourceCodeByOrganizationId.sql
**	Name: fn_SourceCodeByOrganizationId
**	Desc: Get all the source code that this organization has access to.
**			This is similar to GetSourceCodeByOrganizationId function only statline has access to
**			all SourceCodes even when not in a report group.
**	Auth: ccarroll
**	Date: 05/17/2011
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:		Author:			Description:
**	--------	--------		----------------------------------
**	05/17/2011	ccarroll		Initial Function Creation
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

