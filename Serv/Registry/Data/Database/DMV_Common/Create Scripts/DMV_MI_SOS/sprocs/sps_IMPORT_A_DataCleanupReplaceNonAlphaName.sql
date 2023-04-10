if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_IMPORT_A_DataCleanupReplaceNonAlphaName]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
Begin
	drop procedure [dbo].[sps_IMPORT_A_DataCleanupReplaceNonAlphaName]
End
GO


SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

-- sp_helptext IMPORT_DataCleanupReplaceNonAlphaName
CREATE  PROCEDURE sps_IMPORT_A_DataCleanupReplaceNonAlphaName AS
/* This procedure requires function Remove_BAD255 to be in place
*/

UPDATE IMPORT_A SET FIRST = dbo.REMOVE_BAD255(FIRST)
WHERE PATINDEX ('%[^A-Z]%',FIRST) > 0

UPDATE IMPORT_A SET MIDDLE = dbo.REMOVE_BAD255(MIDDLE)
WHERE PATINDEX ('%[^A-Z]%',MIDDLE) > 0

UPDATE IMPORT_A SET LAST = dbo.REMOVE_BAD255(LAST)
WHERE PATINDEX ('%[^A-Z]%',LAST) > 0



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


/******************************* BEGIN ERROR HANDLING *********************************************/
	IF @@ERROR <> 0 
	BEGIN
	   PRINT '*** ERROR - sps_IMPORT_A_DataCleanupReplaceNonAlphaName create script failed'
	   PRINT ''
	END
	ELSE
	BEGIN
	   PRINT 'SUCCESS - 3.0 Procedure sps_IMPORT_A_DataCleanupReplaceNonAlphaName created'
	   PRINT ''
	END
	GO
/********************************* END ERROR HANDLING *********************************************/

