SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[CONTRACTS_AffiliatedHospitals_TOC]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[CONTRACTS_AffiliatedHospitals_TOC]
GO


CREATE PROCEDURE CONTRACTS_AffiliatedHospitals_TOC AS
SELECT DISTINCT o.OrganizationID, o.OrganizationName
FROM WebReportGroup  wrg,
     Organization    o
WHERE wrg.OrgHierarchyParentID = o.OrganizationID
AND wrg.WebReportGroupName like '%All Referrals%'
ORDER BY o.OrganizationName


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

