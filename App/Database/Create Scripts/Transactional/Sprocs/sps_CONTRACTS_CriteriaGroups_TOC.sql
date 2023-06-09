SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_CONTRACTS_CriteriaGroups_TOC]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_CONTRACTS_CriteriaGroups_TOC]
GO

CREATE PROCEDURE sps_CONTRACTS_CriteriaGroups_TOC AS
	SET NOCOUNT ON
	CREATE TABLE #criteriaGroup(
		CriteriaGroupName VARCHAR(255),
		CriteriaGroupID int
	)

	INSERT #criteriaGroup
		SELECT DISTINCT RTRIM(c.CriteriaGroupName), 0 
	FROM Criteria c ,     CriteriaOrganization co
	WHERE  co.CriteriaID = c.CriteriaID 
	AND    c.CriteriaStatus = 1
	ORDER BY RTRIM(C.CriteriaGroupName)

	UPDATE #criteriaGroup
	SET CriteriaGroupID = (SELECT TOP 1 CriteriaID FROM Criteria where CriteriaGroupName = #criteriaGroup.CriteriaGroupName)


	SELECT * FROM #criteriaGroup
	DROP TABLE #criteriaGroup

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

