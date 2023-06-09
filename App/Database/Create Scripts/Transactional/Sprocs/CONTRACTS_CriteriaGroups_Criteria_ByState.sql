SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[CONTRACTS_CriteriaGroups_Criteria_ByState]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[CONTRACTS_CriteriaGroups_Criteria_ByState]
GO


CREATE PROCEDURE CONTRACTS_CriteriaGroups_Criteria_ByState @StateID INT AS

DECLARE @CriteriaStatusID 	INT
SELECT 	@CriteriaStatusID = 0

SELECT DISTINCT c.CriteriaID, c.CriteriaGroupName, dc.DonorCategoryName, o.OrganizationID, o.OrganizationName,
       CONVERT(varchar(255),c.CriteriaMaleLowerAge) + 
       CASE 
         WHEN c.CriteriaMaleLowerAgeUnit = CriteriaMaleUpperAgeUnit THEN '' + '-'
         WHEN c.CriteriaMaleLowerAgeUnit IS NULL                    THEN '' + '-'
         ELSE                                                          ' ' + c.CriteriaMaleLowerAgeUnit + ' to '
       END + CONVERT(varchar(255),c.CriteriaMaleUpperAge) + ' ' + CONVERT(varchar(255),c.CriteriaMaleUpperAgeUnit) AS CriteriaMaleAge,
       CONVERT(varchar(255),c.CriteriaFemaleLowerAge) + 
       CASE 
         WHEN c.CriteriaFemaleLowerAgeUnit = c.CriteriaFemaleUpperAgeUnit THEN '' + '-'
         WHEN c.CriteriaFemaleLowerAgeUnit IS NULL                        THEN '' + '-'
         ELSE                                                                  ' ' + c.CriteriaFemaleLowerAgeUnit + ' to '
       END + CONVERT(varchar(255),c.CriteriaFemaleUpperAge) + ' ' + CONVERT(varchar(255),c.CriteriaFemaleUpperAgeUnit) AS CriteriaFemaleAge,
      CASE
        WHEN  c.CriteriaLowerWeight IS NULL AND c.CriteriaLowerWeight IS NULL THEN ''
        ELSE CONVERT(varchar(255),c.CriteriaLowerWeight) + '-' + CONVERT(varchar(255),c.CriteriaUpperWeight) + ' kg'
      END AS CriteriaWeight,
      i.IndicationName, i.IndicationNote
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
AND   o.StateID           = @StateID
AND   c.CriteriaStatus = @CriteriaStatusID
--AND   c.CriteriaID        <= 10
ORDER BY c.CriteriaGroupName, c.CriteriaID, dc.DonorCategoryName, o.OrganizationName, o.OrganizationID, i.IndicationName


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

