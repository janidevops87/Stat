if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_DMVIMPORT_A_DataCleanupReplaceNonAlphaName]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
Begin
	PRINT 'Dropping sps_DMVIMPORT_A_DataCleanupReplaceNonAlphaName'
	drop procedure [dbo].[sps_DMVIMPORT_A_DataCleanupReplaceNonAlphaName]
End
GO

	PRINT 'Creating sps_DMVIMPORT_A_DataCleanupReplaceNonAlphaName'
GO


CREATE  PROCEDURE sps_DMVIMPORT_A_DataCleanupReplaceNonAlphaName AS
/******************************************************************************
**		File: sps_DMVIMPORT_A_DataCleanupReplaceNonAlphaName.sql
**		Name: sps_DMVIMPORT_A_DataCleanupReplaceNonAlphaName
**		Desc: This procedure requires function Remove_BAD255 to be in place and removes illegal characters
**             
**		Return values:
**
**		Called by:  
**             
**		Parameters:
**		Input							Output
**     ----------							-----------
**		None
**
**		Auth: christopher carroll
**		Date: 10/10/2007
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			--------------------------------------
**		10/10/2007  ccarroll			initial
*******************************************************************************/

UPDATE IMPORT_A SET FIRST = dbo.REMOVE_BAD255(FIRST)
WHERE PATINDEX ('%[^A-Z]%',FIRST) > 0

UPDATE IMPORT_A SET MIDDLE = dbo.REMOVE_BAD255(MIDDLE)
WHERE PATINDEX ('%[^A-Z]%',MIDDLE) > 0

UPDATE IMPORT_A SET LAST = dbo.REMOVE_BAD255(LAST)
WHERE PATINDEX ('%[^A-Z]%',LAST) > 0



GO



