SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SPS_SourceCodeCriteria]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SPS_SourceCodeCriteria]
GO

CREATE PROCEDURE SPS_SourceCodeCriteria
	@SourceCodeName varchar(100) = null
AS

select  
--CriteriaID	,
SourceCode.SourceCodeName,
CriteriaGroupName	,
DonorCategoryName,
--DonorCategoryID	,
CriteriaMaleUpperAge	,
CriteriaMaleLowerAge	,
CriteriaFemaleUpperAge	,
CriteriaFemaleLowerAge	,
CriteriaGeneralRuleout	,
--Unused1	,
CriteriaMaleNotAppropriate	,

CriteriaFemaleNotAppropriate	,
CriteriaReferNonPotential	,
Unused2	,
CriteriaLowerWeight	,
CriteriaUpperWeight	,
CriteriaLowerAgeUnit	,
CriteriaDisableAppropriate	,
Unused3	,
Unused4	,
Unused5	,
Unused6	,
CriteriaMaleUpperAgeUnit	,
CriteriaMaleLowerAgeUnit	,
CriteriaFemaleUpperAgeUnit	,
CriteriaFemaleLowerAgeUnit	,

DynamicDonorCategoryID	

from criteria
JOIN DonorCategory ON DonorCategory.DonorCategoryID  = Criteria.DonorCategoryID 
JOIN CriteriaSourceCode ON CriteriaSourceCode.CriteriaID = Criteria.CriteriaID
JOIN SourceCode ON SourceCode.SourceCodeID = CriteriaSourceCode.SourceCodeID 
WHERE SourceCode.SourceCodeName = ISNULL(@SourceCodeName,SourceCode.SourceCodeName)
ORDER BY CriteriaGroupName, DonorCategoryName
-- sp_help criteria
-- select * from DonorCategory
-- select * from sourceCode
-- 
-- select * from CriteriaSourceCode
-- sp_helptext sps_CriteriaGroupAssignments




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

