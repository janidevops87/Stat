SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_CriteriaIndication]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_CriteriaIndication]
GO

CREATE PROCEDURE sps_CriteriaIndication 
	@CriteriaGroupName varchar(100) = null,
	@DonorCategoryName varchar(100) = null
as
select CriteriaGroupName, DonorCategoryName, indicationName, IndicationNote 
from criteriaindication
join indication on indication.indicationid = criteriaindication.indicationid
join criteria on criteria.criteriaid = criteriaindication.criteriaid
JOIN DonorCategory ON DonorCategory.DonorCategoryID  = Criteria.DonorCategoryID 
WHERE CriteriaGroupName = ISNULL(@CriteriaGroupName,CriteriaGroupName)
AND   DonorCategoryName = ISNULL(@DonorCategoryName,DonorCategoryName)
ORDER BY CriteriaGroupName, DonorCategoryName


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

