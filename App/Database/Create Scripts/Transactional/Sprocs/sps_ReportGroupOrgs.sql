SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_ReportGroupOrgs]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_ReportGroupOrgs]
GO






/****** Object:  Stored Procedure dbo.sps_ReportGroupOrgs    Script Date: 2/24/99 1:12:46 AM ******/
CREATE PROCEDURE sps_ReportGroupOrgs	

	@vReportGroupID	int		= null

AS

    SELECT Organization.OrganizationID, OrganizationName
    FROM WebReportGroupOrg
    JOIN Organization ON Organization.OrganizationID = WebReportGroupOrg.OrganizationID
    WHERE WebReportGroupID = @vReportGroupID
    ORDER BY OrganizationName




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

