SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[CONTRACTS_TriageServiceFees_TOC]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[CONTRACTS_TriageServiceFees_TOC]
GO


CREATE PROCEDURE CONTRACTS_TriageServiceFees_TOC AS
SELECT o.OrganizationID, o.OrganizationName
FROM Organization o
WHERE o.OrganizationID IN (SELECT o.OrganizationID
                           FROM Organization o,
                                Invoice i 
                           WHERE o.OrganizationID = i.OrganizationID)
ORDER BY o.OrganizationName


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

