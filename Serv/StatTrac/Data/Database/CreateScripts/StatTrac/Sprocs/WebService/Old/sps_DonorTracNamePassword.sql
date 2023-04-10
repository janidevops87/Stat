SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_DonorTracNamePassword]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_DonorTracNamePassword]
GO





CREATE PROCEDURE sps_DonorTracNamePassword
	@OrgID as int,
	@SourceCode as int


 AS

Select o.Organizationname,o.OrganizationID,wrg.WebReportGroupID From 
WebReportGroup wrg join webreportgroupsourcecode wrgsc on wrg.webReportGroupID = wrgsc.webReportGroupID
left join organization o on o.organizationid = wrg.OrgHierarchyParentid
where WebReportGroupMaster = 1  
and WebReportGroupName = 'All Referrals' 
--and wrgsc.sourceCodeID  =  @SourceCode
and o.OrganizationID = @OrgID



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

