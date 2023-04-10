IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_ReportStateLookup')
	BEGIN
		PRINT 'Dropping Procedure sps_ReportStateLookup'
		DROP  Procedure  sps_ReportStateLookup
	END

GO

PRINT 'Creating Procedure sps_ReportStateLookup'
GO
CREATE Procedure sps_ReportStateLookup
		@StateArray varchar(100)
AS
/******************************************************************************
**		File: sps_ReportStateLookup.sql
**		Name: sps_ReportStateLookup
**		Desc: 
**
**		This template can be customized:
**              
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**
**		Auth: 
**		Date: 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**    
*******************************************************************************/
DECLARE @SQLString varchar(500)

SET @StateArray = Replace(@StateArray, ',', ''',''') 

SET @SQLString = 'SELECT State, DSN, StateDisplayName FROM StateDSNLookup WHERE State IN (''' + @StateArray + ''');'

EXEC @SQLString;

GO

