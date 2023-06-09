SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_OnlineHospitalGroupOwner]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_OnlineHospitalGroupOwner]
GO

CREATE PROCEDURE sps_OnlineHospitalGroupOwner 
			@SourceCodeID as int

 AS

select distinct OrganizationName,OrganizationID
from Organization 
inner join webreportgroup
	on webreportgroup.orghierarchyparentid = organization.organizationid
inner join webreportgroupsourcecode
	on webreportgroupsourcecode.webreportgroupid = webreportgroup.webreportgroupid
where webreportgroupsourcecode.sourcecodeid = @SourceCodeID and Organization.organizationID <> 194
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

