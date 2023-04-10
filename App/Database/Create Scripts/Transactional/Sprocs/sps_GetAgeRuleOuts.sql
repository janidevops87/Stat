SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_GetAgeRuleOuts]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_GetAgeRuleOuts]
GO





CREATE PROCEDURE sps_GetAgeRuleOuts


		@UserOrgID	int		= null

AS

declare 
	@male as int,
	@Female as int


select @male = Max(CriteriaMaleUpperAge)  from Criteria  INNER JOIN CriteriaOrganization 
ON Criteria.CriteriaID = CriteriaOrganization.CriteriaID where CriteriaOrganization.OrganizationID =@UserOrgID
and Criteria.CriteriaStatus = 0 and DonorCategoryID <> 1 and criteriaMaleUpperAge <120

select @Female = Max(CriteriaFemaleUpperAge) from  Criteria  INNER JOIN CriteriaOrganization 
ON Criteria.CriteriaID = CriteriaOrganization.CriteriaID where CriteriaOrganization.OrganizationID = @UserOrgID
and Criteria.CriteriaStatus = 0 and DonorCategoryID <> 1  and criteriaFemaleUpperAge < 120 

if @male > @Female 
	select @male

if @Female > @male
	select @Female

if @Female = @male
	select @male



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

