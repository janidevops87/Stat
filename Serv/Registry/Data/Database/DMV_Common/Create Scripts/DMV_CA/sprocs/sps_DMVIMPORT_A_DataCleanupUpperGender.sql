if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_DMVIMPORT_A_DataCleanupUpperGender]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
Begin
	PRINT 'Dropping sps_DMVIMPORT_A_DataCleanupUpperGender'
	drop procedure [dbo].[sps_DMVIMPORT_A_DataCleanupUpperGender]
End
GO

	PRINT 'Creating sps_DMVIMPORT_A_DataCleanupUpperGender'
GO


CREATE PROCEDURE sps_DMVIMPORT_A_DataCleanupUpperGender AS
/******************************************************************************
**		File: sps_DMVIMPORT_A_DataCleanupUpperGender.sql
**		Name: ssps_DMVIMPORT_A_DataCleanupUpperGender
**		Desc: This sp converts gender to uppercase for consistency
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
  set Gender = upper(Gender)
commit transaction DMVIMPORT_A


GO



