SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[CONTRACTS_ReportsIncluded_TOC]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[CONTRACTS_ReportsIncluded_TOC]
GO


CREATE PROCEDURE CONTRACTS_ReportsIncluded_TOC AS
SELECT DISTINCT o.OrganizationID, o.OrganizationName
FROM WebReportGroup wrg, Organization o
WHERE wrg.OrgHierarchyParentID = o.OrganizationID
ORDER BY o.OrganizationName


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

