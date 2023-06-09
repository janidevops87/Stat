SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_CONTRACTS_FSCriteriaGroups_ByClient]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_CONTRACTS_FSCriteriaGroups_ByClient]
GO


CREATE PROCEDURE sps_CONTRACTS_FSCriteriaGroups_ByClient 
	@CriteriaGroupId int
AS

SET NOCOUNT ON

select c.CriteriaId, 
	c.CriteriaGroupName as 'Criteria Group', 
	d.donorcategoryname as 'Donor Category', 
	s.SubTypeId as 'SubCategoryId', 
	st.subtypename as 'SubCategory', 
	s.processorid as 'ProcessorId',
	o.organizationname as 'Processor', 
	s.ProcessorPrecedence as 'Processor Order', 

	CASE s.SubCriteriaMaleNotAppropriate
		WHEN -1 THEN 'N/A'
		ELSE CASE s.SubCriteriaMaleLowerAgeUnit
		          	WHEN s.SubCriteriaMaleUpperAgeUnit THEN CAST(s.SubCriteriaMaleLowerAge as varchar)
		          	ELSE CAST(s.SubCriteriaMaleLowerAge as varchar) + ' ' + s.SubCriteriaMaleLowerAgeUnit
		          END + '-' + CAST(s.SubCriteriaMaleUpperAge as varchar) + ' ' + s.SubCriteriaMaleUpperAgeUnit 
	END as 'Male Age',

	CASE s.SubCriteriaFemaleNotAppropriate
		WHEN -1 THEN 'N/A'
		ELSE CASE s.SubCriteriaFemaleLowerAgeUnit
		          	WHEN s.SubCriteriaFemaleUpperAgeUnit THEN CAST(s.SubCriteriaFemaleLowerAge as varchar)
		          	ELSE CAST(s.SubCriteriaFemaleLowerAge as varchar) + ' ' + s.SubCriteriaFemaleLowerAgeUnit
		END + '-' + CAST(s.SubCriteriaFemaleUpperAge as varchar) + ' ' + s.SubCriteriaFemaleUpperAgeUnit 
	END as 'Female Age',

	CASE s.SubCriteriaMaleNotAppropriate
		WHEN -1 THEN 'N/A'
		ELSE CAST(s.SubCriteriaLowerWeight as varchar) + '-' + CAST(s.SubCriteriaUpperWeight as varchar) + ' kg'
	END as 'Male Weight',

	CASE s.SubCriteriaFemaleNotAppropriate
		WHEN -1 THEN 'N/A'
		ELSE CAST(s.SubCriteriaFemaleLowerWeight as varchar) + '-' + CAST(s.SubCriteriaFemaleUpperWeight as varchar) + ' kg' 
	END as 'Female Weight',

	s.SubCriteriaGeneralRuleout as 'General Alert',
	pc.fsindicationid as 'IndicationId', 
	fsi.fsindicationname as 'Indicator', 
	fsa.fsappropriatename as 'R/O Reason',
	isnull(fsc.fsconditionname, 'AUTOMATIC R/O') as 'Indicator Note'
from processorcriteria_conditionalro pc
	join subcriteria s on pc.subcriteriaid = s.subcriteriaid
	join subtype st on s.subtypeid = st.subtypeid
	join organization o on s.processorid = o.organizationid
	join criteria c on s.criteriaid = c.criteriaid
	join donorcategory d on c.donorcategoryid = d.donorcategoryid
	left join fsindication fsi on pc.fsindicationid = fsi.fsindicationid
	left join fscondition fsc on pc.fsconditionid = fsc.fsconditionid
	join fsappropriate fsa on pc.fsappropriateid = fsa.fsappropriateid
where c.criteriastatus = 1
	and s.criteriaid = @CriteriaGroupId
order by st.subtypename, o.organizationname, fsi.fsindicationname







GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

