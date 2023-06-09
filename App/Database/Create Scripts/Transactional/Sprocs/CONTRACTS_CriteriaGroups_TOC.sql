SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[CONTRACTS_CriteriaGroups_TOC]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[CONTRACTS_CriteriaGroups_TOC]
GO


CREATE PROCEDURE CONTRACTS_CriteriaGroups_TOC AS
DECLARE @CriteriaStatusID 	INT
SELECT 	@CriteriaStatusID = 0
SELECT DISTINCT c.CriteriaGroupName
FROM Criteria             c,
     CriteriaOrganization co
WHERE co.CriteriaID = c.CriteriaID
AND   c.CriteriaStatus = @CriteriaStatusID
ORDER BY c.CriteriaGroupName


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

