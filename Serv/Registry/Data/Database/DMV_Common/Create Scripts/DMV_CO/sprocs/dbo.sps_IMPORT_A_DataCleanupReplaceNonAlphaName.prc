SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.sps_IMPORT_A_DataCleanupReplaceNonAlphaName    Script Date: 5/14/2007 10:02:41 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_IMPORT_A_DataCleanupReplaceNonAlphaName]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_IMPORT_A_DataCleanupReplaceNonAlphaName]
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

