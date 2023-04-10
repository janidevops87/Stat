
/****** Object:  UserDefinedFunction [dbo].[AuditTrailfn_SourceCodeList]    Script Date: 11/24/2008 09:19:44 ******/
IF  EXISTS (SELECT * FROM sysobjects WHERE name = 'AuditTrailfn_SourceCodeList' AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
	PRINT 'DROP FUNCTION [dbo].[AuditTrailfn_SourceCodeList]'
	DROP FUNCTION [dbo].[AuditTrailfn_SourceCodeList]
END
PRINT 'CREATE FUNCTION [dbo].[AuditTrailfn_SourceCodeList]'
GO
/****** Object:  UserDefinedFunction [dbo].[AuditTrailfn_SourceCodeList]    Script Date: 11/24/2008 09:19:14 ******/
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[AuditTrailfn_SourceCodeList]
	(
	@ReportGroupID int = 0,
	@SourceCodeName varchar(10)
	
	)
RETURNS 
	@SourceCodeList TABLE 
	(
		SourceCodeID int 
	)
AS
/******************************************************************************
**		File: AuditTrailfn_SourceCodeList
**		Name: AuditTrailfn_SourceCodeList
**		Desc: Calls fn_SourceCodeList in the production database 
**
**		
**		Return values:
**		Returns a table variable of sourcecodeid
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		ReportGroupID
**		SourceCodeName
**
**		Auth: Bret Knoll
**		Date: 11/24/08
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**      11/24/08	Bret Knoll			Create Function
**		08/24/2010	ccarroll			changed DB_NAME to @@SERVERNAME
*******************************************************************************/
	
	BEGIN
	IF(@@SERVERNAME like '%DEV%')
		BEGIN
			INSERT INTO @SourceCodeList 
				SELECT * FROM ReferralTest2.dbo.fn_SourceCodeList(@ReportGroupID, @SourceCodeName)
		END
		ELSE
		BEGIN
			INSERT INTO @SourceCodeList 
				SELECT * FROM _ReferralProdReport.dbo.fn_SourceCodeList(@ReportGroupID, @SourceCodeName)
		END
				
		/* alternative sql statement or statements */ 
	RETURN
	END

GO