SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_CONTRACTS_CriteriaGroups_ByClient]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_CONTRACTS_CriteriaGroups_ByClient]
GO

CREATE PROCEDURE sps_CONTRACTS_CriteriaGroups_ByClient 
	@CriteriaGroupName VARCHAR(255) 	
AS

SET NOCOUNT ON


CREATE TABLE #rollup(ID                    INT IDENTITY (1, 1) PRIMARY KEY,
                     CriteriaID            INT,
                     CriteriaGroupName     VARCHAR(2000),
                     DonorCategoryName     VARCHAR(200),
                     OrganizationID        INT,
                     OrganizationName      VARCHAR(2000),
                     CriteriaMaleAge       VARCHAR(200),
                     CriteriaFemaleAge     VARCHAR(200),
                     CriteriaWeight        VARCHAR(200),
                     IndicationID          INT,
                     IndicationName        VARCHAR(500),
                     IndicationNote        VARCHAR(2000))
INSERT #rollup(CriteriaID, CriteriaGroupName, DonorCategoryName, OrganizationID, OrganizationName, CriteriaMaleAge, CriteriaFemaleAge, CriteriaWeight, IndicationID, IndicationName, IndicationNote)
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
      i.IndicationID, i.IndicationName, i.IndicationNote
FROM DonorCategory dc 
INNER JOIN Criteria c 
INNER JOIN CriteriaScheduleGroup csg ON c.CriteriaID = csg.CriteriaID 
INNER JOIN ScheduleGroup sg 
INNER JOIN Organization o ON sg.OrganizationID = o.OrganizationID ON csg.ScheduleGroupID = sg.ScheduleGroupID ON dc.DonorCategoryID = c.DonorCategoryID 
LEFT OUTER JOIN CriteriaIndication ci 
INNER JOIN Indication i ON ci.IndicationID = i.IndicationID ON c.CriteriaID = ci.CriteriaID
WHERE c.CriteriaGroupName LIKE @CriteriaGroupName
AND c.CriteriaStatus = 1
ORDER BY c.CriteriaGroupName, c.CriteriaID, dc.DonorCategoryName, o.OrganizationName, o.OrganizationID, i.IndicationName
SELECT *
FROM #rollup
DROP TABLE #rollup


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

