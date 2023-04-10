 /***************************************************************************************************
**	Name: CriteriaAgeUnit
**	Desc: Data Load for table CriteriaAgeUnit
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	12/16/2009	ccarroll		add values for for StatTrac 9.0 release
**	07/09/2010	ccarroll		added this note for development build (GenerateSQL)
***************************************************************************************************/

SET IDENTITY_INSERT CriteriaAgeUnit ON;

IF ((SELECT count(*) FROM CriteriaAgeUnit WHERE CriteriaAgeUnitID = 1 AND CriteriaAgeUnitName = 'Years') = 0)
BEGIN
	INSERT INTO CriteriaAgeUnit (CriteriaAgeUnitId, CriteriaAgeUnitName, DisplayOrder, LastModified, LastStatEmployeeID, AuditLogTypeID)
	VALUES
	(1, 'Years', 1, GetDate(), 1100, 1)
END

IF ((SELECT count(*) FROM CriteriaAgeUnit WHERE CriteriaAgeUnitID = 2 AND CriteriaAgeUnitName = 'Months') = 0)
BEGIN
	INSERT INTO CriteriaAgeUnit (CriteriaAgeUnitId, CriteriaAgeUnitName, DisplayOrder, LastModified, LastStatEmployeeID, AuditLogTypeID)
	VALUES
	(2, 'Months', 2, GetDate(), 1100, 1)
END

IF ((SELECT count(*) FROM CriteriaAgeUnit WHERE CriteriaAgeUnitID = 3 AND CriteriaAgeUnitName = 'Weeks') = 0)
BEGIN
	INSERT INTO CriteriaAgeUnit (CriteriaAgeUnitId, CriteriaAgeUnitName, DisplayOrder, LastModified, LastStatEmployeeID, AuditLogTypeID)
	VALUES
	(3, 'Weeks', 3, GetDate(), 1100, 1)
END

IF ((SELECT count(*) FROM CriteriaAgeUnit WHERE CriteriaAgeUnitID = 4 AND CriteriaAgeUnitName = 'Days') = 0)
BEGIN
	INSERT INTO CriteriaAgeUnit (CriteriaAgeUnitId, CriteriaAgeUnitName, DisplayOrder, LastModified, LastStatEmployeeID, AuditLogTypeID)
	VALUES
	(4, 'Days', 4, GetDate(), 1100, 1)
END

SET IDENTITY_INSERT CriteriaAgeUnit OFF;
GO
 