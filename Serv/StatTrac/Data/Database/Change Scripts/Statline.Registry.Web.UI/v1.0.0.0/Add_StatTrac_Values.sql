/* ccarroll 02/05/2009 
*/


If (Select Count(*) FROM DRDSN WHERE DRDSNODBC = 'DMV_NH') < 1
PRINT 'Adding table values to: DRDSN DMV_NH'
BEGIN 
	INSERT DRDSN (	DRDSNName,
			DRDSNODBC,
			DRDSNStateID,
			LastModified,
			CreateDate,
			DRDSNServerName,
			DRDSNDBName,
			WebServiceEnable,
			WebServiceOrder
			)
		VALUES(	'New Hampshire',
			'DMV_NH',
			27,
			GetDate(),
			GetDate(),
			'ST-DRSQL',
			'DMV_NH',
			Null,
			Null
			)
END


If (Select Count(*) FROM DRDSN WHERE DRDSNODBC = 'DMV_VT') < 1
BEGIN
PRINT 'Adding table values to: DRDSN DMV_VT'

	INSERT DRDSN (	DRDSNName,
			DRDSNODBC,
			DRDSNStateID,
			LastModified,
			CreateDate,
			DRDSNServerName,
			DRDSNDBName,
			WebServiceEnable,
			WebServiceOrder
			)
		VALUES(	'Vermont',
			'DMV_VT',
			44,
			GetDate(),
			GetDate(),
			'ST-DRSQL',
			'DMV_VT',
			Null,
			Null
			)
END