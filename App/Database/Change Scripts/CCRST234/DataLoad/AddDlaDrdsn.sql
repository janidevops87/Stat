/******************************************************************************
**		File: AddDlaDrdsn.sql
**		Name: Add DLA DRDSN Record
**		Desc: Loads DRDSN table with record for DLA Registry, per CCRST234
**
**		Auth: Mike Berenson
**		Date: 11/03/2016
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**      11/03/2016	Mike Berenson		initial
*******************************************************************************/

IF NOT EXISTS(SELECT 1 FROM DRDSN WHERE DRDSNName = 'DLA Registry')
BEGIN
	PRINT 'UPDATING Table - DRDSN. Adding DLA Registry.';
	INSERT INTO DRDSN
	VALUES ('DLA Registry', 'DMV_Common', NULL, GETDATE(), GETDATE(), 'st-testregsql', 'DMV_Common', NULL, NULL);
END

GO