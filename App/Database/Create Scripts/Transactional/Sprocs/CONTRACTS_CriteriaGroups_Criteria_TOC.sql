SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[CONTRACTS_CriteriaGroups_Criteria_TOC]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[CONTRACTS_CriteriaGroups_Criteria_TOC]
GO


CREATE PROCEDURE CONTRACTS_CriteriaGroups_Criteria_TOC AS
DECLARE @CriteriaStatusID 	INT
SELECT 	@CriteriaStatusID = 0
SELECT DISTINCT c.CriteriaID, c.CriteriaGroupName
FROM Criteria c,
     Organization o,
     CriteriaScheduleGroup csg,
     ScheduleGroup sg,
     Indication i, 
     CriteriaIndication ci,
     DonorCategory dc
WHERE sg.OrganizationID   = o.OrganizationID
AND   c.CriteriaID        = csg.CriteriaID
AND   csg.ScheduleGroupID = sg.ScheduleGroupID
AND   i.IndicationID      = ci.IndicationID
AND   ci.CriteriaID       = c.CriteriaID
AND   c.DonorCategoryID   = dc.DonorCategoryID
AND   c.CriteriaStatus = @CriteriaStatusID
ORDER BY c.CriteriaGroupName, c.CriteriaID


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

