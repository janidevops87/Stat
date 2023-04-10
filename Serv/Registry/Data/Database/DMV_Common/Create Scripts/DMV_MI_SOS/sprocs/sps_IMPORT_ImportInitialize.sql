if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_IMPORT_ImportInitialize]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
Begin
	drop procedure [dbo].[sps_IMPORT_ImportInitialize]
End
go


SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


CREATE PROCEDURE sps_IMPORT_ImportInitialize AS
/*
	Procedure:	
	ISE:		christopher carroll
	Date:		1/22/2007

	Notes:		This procedure is used to insert an import log record and then
			return the identiry value.

*/
insert IMPORTLOG(RecordsTotal) values(0)
return @@IDENTITY


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/********************************* BEGIN ERROR HANDLING *********************************************/
	IF @@ERROR <> 0 
	BEGIN
	   PRINT '*** ERROR - sps_IMPORT_ImportInitialize create script failed'
	   PRINT ''
	END
	ELSE
	BEGIN
	   PRINT 'SUCCESS - 3.0 Procedure sps_IMPORT_ImportInitialize created'
	   PRINT ''
	END
	GO
/********************************* END ERROR HANDLING *********************************************/