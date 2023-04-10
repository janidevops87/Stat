SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_VerifyWeightRuleout]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
Begin
	PRINT 'dropping procedure sps_VerifyWeightRuleout'
	drop procedure [dbo].[sps_VerifyWeightRuleout]
End
PRINT 'creating procedure sps_VerifyWeightRuleout'
GO


CREATE  PROCEDURE sps_VerifyWeightRuleout
	@OrganizationID Int,
	@SourceCodeID Int

AS

/******************************************************************************
**		File: sps_VerifyWeightRuleout.sql
**		Name: sps_VerifyWeightRuleout
**		Desc: 
**              
**		Return values: 
**		
**		Called by:
**              
**		Parameters:
**		Input							Outputs
**		----------						-----------
**		See Above
**
**		Auth: Christopher Carroll
**		Date: 06/19/2008
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------		-------------------------------------
**
*******************************************************************************/

--SET @OrganizationID = 33
--SET @SourceCodeID = 14

SELECT DISTINCT CriteriaOrganization.CriteriaID, Criteria.DonorCategoryID, Criteria.CriteriaLowerWeight, Criteria.CriteriaUpperWeight 
FROM Criteria
JOIN CriteriaOrganization ON Criteria.CriteriaID = CriteriaOrganization.CriteriaID
JOIN CriteriaSourceCode ON CriteriaSourceCode.CriteriaID = Criteria.CriteriaID
WHERE CriteriaOrganization.OrganizationID = @OrganizationID
	  AND Criteria.DonorCategoryID IN (1, 2, 3, 4, 5, 6, 7)
	  AND CriteriaSourceCode.SourceCodeID = @SourceCodeID
	  AND Criteria.CriteriaStatus = 1 
ORDER BY Criteria.DonorCategoryID ASC

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO