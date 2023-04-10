/***************************************************************************************************
**	Name: TcssListVitalSign
**	Desc: Data Load for table TcssListVitalSign
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Data Load
***************************************************************************************************/

SET IDENTITY_INSERT TcssListVitalSign ON

IF ((SELECT count(*) FROM TcssListVitalSign) = 0)
BEGIN
	INSERT INTO TcssListVitalSign (TcssListVitalSignId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue, IsLiver, IsKidney) VALUES('1', '679', '1', 'Average BP (systolic)', 'Average BP (systolic)', '1', '1')
	INSERT INTO TcssListVitalSign (TcssListVitalSignId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue, IsLiver, IsKidney) VALUES('2', '679', '2', 'Average BP (diastolic)', 'Average BP (diastolic)', '1', '1')
	INSERT INTO TcssListVitalSign (TcssListVitalSignId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue, IsLiver, IsKidney) VALUES('3', '679', '3', 'Heart rate', 'Average heart rate (bpm)', '1', '1')
	INSERT INTO TcssListVitalSign (TcssListVitalSignId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('4', '679', '4', 'High BP (systolic)', 'High BP (systolic)')
	INSERT INTO TcssListVitalSign (TcssListVitalSignId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('5', '679', '5', 'High BP (diastolic)', 'High BP (diastolic)')
	INSERT INTO TcssListVitalSign (TcssListVitalSignId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('6', '679', '6', 'High BP duration (min)', 'Duration at high (minutes)')
	INSERT INTO TcssListVitalSign (TcssListVitalSignId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('7', '679', '7', 'Low BP (systolic)', 'Low BP (systolic)')
	INSERT INTO TcssListVitalSign (TcssListVitalSignId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('8', '679', '8', 'Low BP (diastolic)', 'Low BP (diastolic)')
	INSERT INTO TcssListVitalSign (TcssListVitalSignId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('9', '679', '9', 'Low BP duration (min)', 'Duration at low (minutes)')
	INSERT INTO TcssListVitalSign (TcssListVitalSignId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue, IsLiver, IsKidney) VALUES('10', '679', '10', 'Temp (C)', 'Core Body Temp.', '1', '1')
	INSERT INTO TcssListVitalSign (TcssListVitalSignId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue, IsKidney) VALUES('11', '679', '11', 'Total Urine Output', 'Urine output (cc/hour)', '1')
	INSERT INTO TcssListVitalSign (TcssListVitalSignId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('12', '679', '12', 'CVP', 'CVP (mm/Hg)')
	INSERT INTO TcssListVitalSign (TcssListVitalSignId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue, IsLiver, IsKidney) VALUES('13', '679', '13', 'PA (systolic)', 'PA (systolic)', '1', '1')
	INSERT INTO TcssListVitalSign (TcssListVitalSignId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue, IsLiver, IsKidney) VALUES('14', '679', '14', 'PA (diastolic)', 'PA (diastolic)', '1', '1')
	INSERT INTO TcssListVitalSign (TcssListVitalSignId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue, IsLiver, IsKidney) VALUES('15', '679', '15', 'PAWP (PCWP)', 'PCWP (mm/Hg)', '1', '1')
	INSERT INTO TcssListVitalSign (TcssListVitalSignId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('16', '679', '16', 'PAMP', 'PAMP (mm/Hg)')
	INSERT INTO TcssListVitalSign (TcssListVitalSignId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue, IsLiver, IsKidney) VALUES('17', '679', '17', 'CO', 'CO', '1', '1')
	INSERT INTO TcssListVitalSign (TcssListVitalSignId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue, IsLiver, IsKidney) VALUES('18', '679', '18', 'CI', 'CI', '1', '1')
	INSERT INTO TcssListVitalSign (TcssListVitalSignId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('19', '679', '19', 'Comments', 'Comments')
END

SET IDENTITY_INSERT TcssListVitalSign OFF
GO

-- Set the Lung values that needs to be displayed in the summary
IF ((SELECT count(*) FROM TcssListVitalSign WHERE IsLung = 1) = 0)
BEGIN
	UPDATE TcssListVitalSign SET IsLung = 1 
	WHERE TcssListVitalSignId 
	IN 
	(
		1, -- Average BP (systolic)
		2, -- Average BP (diastolic)
		3, -- Heart rate
		10, -- Temp (C)
		12, -- CVP
		15, -- PAWP (PCWP)
		17, -- CO
		18, -- CI
		11 -- Urine Output (cc/hour)
	)
END
GO

-- Set the Heart values that needs to be displayed in the summary
IF ((SELECT count(*) FROM TcssListVitalSign WHERE IsHeart = 1) = 0)
BEGIN
	UPDATE TcssListVitalSign SET IsHeart = 1 
	WHERE TcssListVitalSignId 
	IN 
	(
		1, -- Average BP (systolic)
		2, -- Average BP (diastolic)
		3, -- Heart rate
		10, -- Temp (C)
		12, -- CVP
		13, -- PA (systolic)
		14, -- PA (diastolic)
		15, -- PAWP (PCWP)
		17, -- CO
		18, -- CI
		11 -- Urine Output (cc/hour)
	)
END
GO

-- Set the Intestine values that needs to be displayed in the summary
IF ((SELECT count(*) FROM TcssListVitalSign WHERE IsIntestine = 1) = 0)
BEGIN
	UPDATE TcssListVitalSign SET IsIntestine = 1 
	WHERE TcssListVitalSignId 
	IN 
	(
		1, -- Average BP (systolic)
		2, -- Average BP (diastolic)
		3, -- Heart rate
		10, -- Temp (C)
		13, -- PA (systolic)
		14, -- PA (diastolic)
		15, -- PAWP (PCWP)
		17, -- CO
		18, -- CI
		11 -- Urine Output (cc/hour)
	)
END
GO

-- Set the Pancreas values that needs to be displayed in the summary
IF ((SELECT count(*) FROM TcssListVitalSign WHERE IsPancreas = 1) = 0)
BEGIN
	UPDATE TcssListVitalSign SET IsPancreas = 1 
	WHERE TcssListVitalSignId 
	IN 
	(
		1, -- Average BP (systolic)
		2, -- Average BP (diastolic)
		3, -- Heart rate
		10, -- Temp (C)
		13, -- PA (systolic)
		14, -- PA (diastolic)
		15, -- PAWP (PCWP)
		17, -- CO
		18, -- CI
		11 -- Urine Output (cc/hour)
	)
END
GO

-- Set the HeartLung values that needs to be displayed in the summary
IF ((SELECT count(*) FROM TcssListVitalSign WHERE IsHeartLung = 1) = 0)
BEGIN
	UPDATE TcssListVitalSign SET IsHeartLung = 1 
	WHERE TcssListVitalSignId 
	IN 
	(
		1, -- Average BP (systolic)
		2, -- Average BP (diastolic)
		3, -- Heart rate
		10, -- Temp (C)
		12, -- CVP
		13, -- PA (systolic)
		14, -- PA (diastolic)
		15, -- PAWP (PCWP)
		17, -- CO
		18, -- CI
		11 -- Urine Output (cc/hour)
	)
END
GO

-- Set the KidneyPancreas values that needs to be displayed in the summary
IF ((SELECT count(*) FROM TcssListVitalSign WHERE IsKidneyPancreas = 1) = 0)
BEGIN
	UPDATE TcssListVitalSign SET IsKidneyPancreas = 1 
	WHERE TcssListVitalSignId 
	IN 
	(
		1, -- Average BP (systolic)
		2, -- Average BP (diastolic)
		3, -- Heart rate
		10, -- Temp (C)
		13, -- PA (systolic)
		14, -- PA (diastolic)
		15, -- PAWP (PCWP)
		17, -- CO
		18, -- CI
		11 -- Urine Output (cc/hour)
	)
END
GO

-- Set the MultiOrgan values that needs to be displayed in the summary
IF ((SELECT count(*) FROM TcssListVitalSign WHERE IsMultiOrgan = 1) = 0)
BEGIN
	UPDATE TcssListVitalSign SET IsMultiOrgan = 1 
	WHERE TcssListVitalSignId 
	IN 
	(
		1, -- Average BP (systolic)
		2, -- Average BP (diastolic)
		3, -- Heart rate
		10, -- Temp (C)
		12, -- CVP
		13, -- PA (systolic)
		14, -- PA (diastolic)
		15, -- PAWP (PCWP)
		17, -- CO
		18, -- CI
		11 -- Urine Output (cc/hour)
	)
END
GO

-- Update the order per Bug# 6051
UPDATE TcssListVitalSign SET SortOrder = 19, FieldValue = 'Urine Output (cc/hour)' WHERE TcssListVitalSignId = 11 -- Total Urine Output
UPDATE TcssListVitalSign SET SortOrder = 20 WHERE TcssListVitalSignId = 19 -- Comments
UPDATE TcssListVitalSign SET UnosValue = 'Vital Signs comments:' WHERE TcssListVitalSignId = 19
GO