if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_DMVIMPORT_A_DataCleanupUpperDonor]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
Begin
	PRINT 'Dropping sps_DMVIMPORT_A_DataCleanupUpperDonor'
	drop procedure [dbo].[sps_DMVIMPORT_A_DataCleanupUpperDonor]
End
GO

	PRINT 'Creating sps_DMVIMPORT_A_DataCleanupUpperDonor'
GO


CREATE PROCEDURE sps_DMVIMPORT_A_DataCleanupUpperDonor AS
/******************************************************************************
**		File: sps_DMVIMPORT_A_DataCleanupUpperDonor.sql
**		Name: sps_DMVIMPORT_A_DataCleanupUpperDonor
**		Desc: This sp converts donor status to uppercase for consistency
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

begin transaction DMVIMPORT_A
  update DMVIMPORT_A
  set Donor = SUBSTRING(Donor,1,1)
commit transaction DMVIMPORT_A


GO


