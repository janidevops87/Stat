SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[CONTRACTS_HospitalPhone_TOC]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[CONTRACTS_HospitalPhone_TOC]
GO


CREATE PROCEDURE CONTRACTS_HospitalPhone_TOC AS
SELECT DISTINCT o.OrganizationID, o.OrganizationName
FROM Organization o,
     Referral r
WHERE o.OrganizationID = r.ReferralCallerOrganizationID
ORDER BY o.OrganizationName


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

