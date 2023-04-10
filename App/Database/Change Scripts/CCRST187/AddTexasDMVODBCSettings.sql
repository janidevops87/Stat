/******************************************************************************
**		File: AddTexasDMVODBCSettings.sql
**		Name: AddTexasDMVODBCSettings
**		Desc: Updates DRDSN table for Texas DMV ODBC Settings, per CCRST187
**
**		Auth: Moonray Schepart
**		Date: 01/06/2014
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**      01/06/2014	Moonray Schepart	initial
*******************************************************************************/

IF NOT EXISTS(SELECT * FROM DRDSN WHERE DRDSNStateID = 41)
  BEGIN
  PRINT 'UPDATING Table - DRDSN. Adding Texas DMV.';
  INSERT INTO DRDSN
  VALUES ('Texas Registry', 'DMV_TX', 41, GETDATE(), GETDATE(), 'st-testregsql', 'DMV_TX', NULL, NULL);
  END

GO
	