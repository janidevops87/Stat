SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[fn_OrgAddressHtml]') and xtype in (N'FN', N'IF', N'TF'))
drop function [dbo].[fn_OrgAddressHtml]
GO


CREATE FUNCTION fn_OrgAddressHtml (@orgId Integer)

RETURNS varchar(300)  

-- Takes an Organization ID and returns an HTML-formatted string (with line breaks) 
-- displaying the address of the organization.
-- 10/26/04 - SAP

AS  
BEGIN 

DECLARE @rtnString varchar(300)

SET @rtnString = (SELECT IsNull(OrganizationAddress1, '') + '<br>' + 
		IsNull(OrganizationAddress2, '') + '<br>' + 
		IsNull(OrganizationCity, '') + ', ' + 
		IsNull(ST.StateAbbrv, '') + ' ' + 
		IsNull(OrganizationZipCode, '')

		FROM Organization OG
		LEFT JOIN State ST ON OG.StateId = ST.StateId
		WHERE OrganizationId = @orgId);

-- Remove double page breaks
SET @rtnString = Replace(@rtnString, '<br><br>', '<br>')
	
RETURN @rtnString;


END




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

