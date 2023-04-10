/******************************************************************************
**		File: AddHawaiiDMVODBCSettings.sql
**		Name: AddHawaiiDMVODBCSettings
**		Desc: Updates DRDSN table for Texas DMV ODBC Settings, per CCRST186
**
**		Auth: Chris Carroll
**		Date: 02/21/2014
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**      02/21/2014	Chris Carroll	initial
*******************************************************************************/

IF NOT EXISTS(SELECT * FROM DRDSN WHERE DRDSNStateID = 11)
  BEGIN
  PRINT 'UPDATING Table - DRDSN. Adding Texas DMV.';
  INSERT INTO DRDSN
  VALUES ('Hawaii Registry', 'DMV_HI', 11, GETDATE(), GETDATE(), 'st-testregsql', 'DMV_HI', NULL, NULL);
  END

GO
	