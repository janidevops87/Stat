SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_ReportGroupAuthorization]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_ReportGroupAuthorization]
GO


CREATE PROCEDURE sps_ReportGroupAuthorization

	@vWebReportGroupID 	int,
	@vOrgHierarchParentID 	int

AS

Declare @ReturnValue int

SELECT   @ReturnValue  = Count(OrgHierarchyParentID) 
			FROM     	WebReportGroup 
			WHERE    	WebReportGroupID = @vWebReportGroupID
			AND      	OrgHierarchyParentID = @vOrgHierarchParentID

Return @ReturnValue 




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

