SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_NWLEB_ReferralTypeViewAccess]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_NWLEB_ReferralTypeViewAccess]
GO



/****** Object:  Stored Procedure dbo.sps_NWLEB_ReferralTypeViewAccess    Script Date: 10/5/2004 ******/
CREATE PROCEDURE sps_NWLEB_ReferralTypeViewAccess
@vUserOrgID int = null

-- Returns a string denoting whether user's org has permission for Organs, Tissues and/or Eyes by
-- the first letter of each type.  An org with all three returns 'OTE'.  10/5/2004 - SAP

AS

IF @vUserOrgID <> 194 
   SELECT  RefTypePermission = 
				CASE SC.AccessOrgans
						WHEN 1  THEN 'O'
						ELSE ''
						END
			+ 
				CASE SC.AccessTissue
						WHEN 1  THEN 'T'
						ELSE ''
						END
 			+ 
				CASE SC.AccessEyes
						WHEN 1  THEN 'E'
						ELSE ''
						END
   FROM   WebReportGroupSourceCode SC
   JOIN   WebReportGroup RG ON RG.WebReportGroupID = SC.WebReportGroupID
   WHERE  OrgHierarchyParentID = @vUserOrgID
   AND  WebReportGroupMaster = 1;
ELSE  -- Statline users automatically have OTE permission
	SELECT 'OTE' AS RefTypePermission;
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

