if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_IMPORT_A_DataCleanupUpperDonor]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
Begin
	drop procedure [dbo].[sps_IMPORT_A_DataCleanupUpperDonor]
End
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


CREATE PROCEDURE sps_IMPORT_A_DataCleanupUpperDonor AS
/*
	Procedure:	
	ISE:		christopher carroll
	Date:		1/23/2007

	Notes:		This procedure is used to make sure that registered (Y) donors
			have an upper case Y as an identifier.

*/
begin transaction IMPORT_A
  update IMPORT_A
  set Donor = upper(Donor)
commit transaction IMPORT_A


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/********************************* BEGIN ERROR HANDLING *********************************************/
	IF @@ERROR <> 0 
	BEGIN
	   PRINT '*** ERROR - sps_IMPORT_A_DataCleanupUpperDonor create script failed'
	   PRINT ''
	END
	ELSE
	BEGIN
	   PRINT 'SUCCESS - 3.0 Procedure sps_IMPORT_A_DataCleanupUpperDonor created'
	   PRINT ''
	END
	GO
/********************************* END ERROR HANDLING *********************************************/