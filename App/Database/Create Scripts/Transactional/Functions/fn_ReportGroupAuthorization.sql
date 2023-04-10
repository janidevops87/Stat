  IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[fn_ReportGroupAuthorization]') AND xtype in (N'FN', N'IF', N'TF'))
	BEGIN
		PRINT 'Dropping Function fn_ReportGroupAuthorization'
		DROP Function fn_ReportGroupAuthorization
	END
GO

PRINT 'Creating Function fn_ReportGroupAuthorization' 
GO

CREATE FUNCTION dbo.fn_ReportGroupAuthorization
	(
	@vWebReportGroupID		int,
	@vOrgHierarchParentID 	int
	)
RETURNS int
AS
	BEGIN
		DECLARE @ReturnValue int
		
		SELECT   
			@ReturnValue  =  WebReportGroupID
		FROM     	
			WebReportGroup 
		WHERE    	
			WebReportGroupID = @vWebReportGroupID
		AND      	
			OrgHierarchyParentID = @vOrgHierarchParentID	
		RETURN ISNULL(@ReturnValue, 0)
	END
	



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

