SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_CONTRACTS_FSCriteriaGroups_TOC]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_CONTRACTS_FSCriteriaGroups_TOC]
GO


CREATE PROCEDURE sps_CONTRACTS_FSCriteriaGroups_TOC AS
	SET NOCOUNT ON
	
	--Criteria Group - Donor Cateogory List:
	select distinct s.CriteriaId as 'CriteriaGroupId', c.CriteriaGroupName as 'Criteria Group', d.donorcategoryname as 'Donor Category'
	from subcriteria s
	join subtype st on s.subtypeid = st.subtypeid
	join organization o on s.processorid = o.organizationid
	join criteria c on s.criteriaid = c.criteriaid
	join donorcategory d on c.donorcategoryid = d.donorcategoryid
	where c.criteriastatus = 1
	order by c.criteriagroupname, d.donorcategoryname





GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

