  /***************************************************************************************************
**	Name: CriteriaWeightUnit
**	Desc: Data Load for table CriteriaWeightUnit
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	12/16/2009	ccarroll		add values for for StatTrac 9.0 release
**	07/09/2010	ccarroll		added this note for development build (GenerateSQL)
***************************************************************************************************/

SET IDENTITY_INSERT CriteriaWeightUnit ON;

IF ((SELECT count(*) FROM CriteriaWeightUnit WHERE CriteriaWeightUnitID = 1 AND CriteriaWeightUnitName = 'Kilograms') = 0)
BEGIN
	INSERT INTO CriteriaWeightUnit (CriteriaWeightUnitId, CriteriaWeightUnitName, DisplayOrder, LastModified, LastStatEmployeeID, AuditLogTypeID)
	VALUES
	(1, 'Kilograms', 1, GetDate(), 1100, 1)
END

IF ((SELECT count(*) FROM CriteriaWeightUnit WHERE CriteriaWeightUnitID = 2 AND CriteriaWeightUnitName = 'Grams') = 0)
BEGIN
	INSERT INTO CriteriaWeightUnit (CriteriaWeightUnitId, CriteriaWeightUnitName, DisplayOrder, LastModified, LastStatEmployeeID, AuditLogTypeID)
	VALUES
	(2, 'Grams', 2, GetDate(), 1100, 1)
END

IF ((SELECT count(*) FROM CriteriaWeightUnit WHERE CriteriaWeightUnitID = 3 AND CriteriaWeightUnitName = 'Pounds') = 0)
BEGIN
	INSERT INTO CriteriaWeightUnit (CriteriaWeightUnitId, CriteriaWeightUnitName, DisplayOrder, LastModified, LastStatEmployeeID, AuditLogTypeID)
	VALUES
	(3, 'Pounds', 3, GetDate(), 1100, 1)
END

IF ((SELECT count(*) FROM CriteriaWeightUnit WHERE CriteriaWeightUnitID = 4 AND CriteriaWeightUnitName = 'Ounces') = 0)
BEGIN
	INSERT INTO CriteriaWeightUnit (CriteriaWeightUnitId, CriteriaWeightUnitName, DisplayOrder, LastModified, LastStatEmployeeID, AuditLogTypeID)
	VALUES
	(4, 'Ounces', 4, GetDate(), 1100, 1)
END

SET IDENTITY_INSERT CriteriaWeightUnit OFF;
GO
 