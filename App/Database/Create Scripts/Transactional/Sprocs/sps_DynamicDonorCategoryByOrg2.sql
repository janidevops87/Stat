SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_DynamicDonorCategoryByOrg2]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	PRINT 'Dropping Procedure sps_DynamicDonorCategoryByOrg2'
	drop procedure [dbo].[sps_DynamicDonorCategoryByOrg2]
GO


PRINT 'Creating Procedure sps_DynamicDonorCategoryByOrg2'
GO

CREATE PROCEDURE sps_DynamicDonorCategoryByOrg2

     @vOrganizationID int =null,
     @vSourceCodeName varchar(20) = null

AS
/******************************************************************************
**		File: sps_DynamicDonorCategoryByOrg2.sql
**		Name: sps_DynamicDonorCategoryByOrg2
**		Desc: 
**
**              
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		See above
**
**		Auth: unknown
**		Date: 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**      06/05/2009	ccarroll			added Patindex and Uncommetted Read to increase performance
**      06/18/09    jth                 added order by...above changed caused sorting not to work
*******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

     SELECT    DISTINCT
               DonorCategoryID,
               DynamicDonorCategoryName

     FROM      Criteria 

     JOIN      CriteriaSourceCode ON CriteriaSourceCode.CriteriaID = Criteria.CriteriaID
     JOIN      SourceCode ON SourceCode.SourceCodeID = CriteriaSourceCode.SourceCodeID
     JOIN      CriteriaOrganization ON CriteriaOrganization.CriteriaID = Criteria.CriteriaID
     JOIN      DynamicDonorCategory ON DynamicDonorCategory.DynamicDonorCategoryID = Criteria.DynamicDonorCategoryID

     WHERE     OrganizationID= @vOrganizationID
    AND		PATINDEX(@vSourceCodeName, SourceCode.SourceCodeName) > 0
    --		Was: AND SourceCode.SourceCodeName = @vSourceCodeName
    AND		CriteriaStatus = 1
order by 1
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

