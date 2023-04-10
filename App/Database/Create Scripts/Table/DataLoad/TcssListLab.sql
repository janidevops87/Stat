/***************************************************************************************************
**	Name: TcssListLab
**	Desc: Data Load for table TcssListLab
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/16/2009	Tanvir Ather	Initial Data Load
***************************************************************************************************/

SET IDENTITY_INSERT TcssListLab ON

IF ((SELECT count(*) FROM TcssListLab) = 0)
BEGIN
	INSERT INTO TcssListLab (TcssListLabId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue, IsLiver, IsKidney) VALUES('1', '679', '1', 'Na+ (mEq/L)', 'Na+ (mEq/L)', '1', '1')
	INSERT INTO TcssListLab (TcssListLabId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('2', '679', '2', 'K+ (mEq/L)', 'K+ (mEq/L)')
	INSERT INTO TcssListLab (TcssListLabId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('3', '679', '3', 'Cl (mmol/L)', 'Cl (mmol/L)')
	INSERT INTO TcssListLab (TcssListLabId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('4', '679', '4', 'CO2 (mmol/L)', 'CO2 (mmol/L)')
	INSERT INTO TcssListLab (TcssListLabId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue, IsLiver, IsKidney) VALUES('5', '679', '5', 'BUN (mg/dL)', 'BUN (mg/dL)', '1', '1')
	INSERT INTO TcssListLab (TcssListLabId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue, IsLiver, IsKidney) VALUES('6', '679', '6', 'Creatinine', 'Creatinine', '1', '1')
	INSERT INTO TcssListLab (TcssListLabId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue, IsKidney) VALUES('7', '679', '7', 'Glucose (mg/dL)', 'Glucose (mg/dL)', '1')
	INSERT INTO TcssListLab (TcssListLabId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue, IsLiver) VALUES('8', '679', '8', 'Total Bilirubin (mg/dL)', 'Total Bilirubin (mg/dL)', '1')
	INSERT INTO TcssListLab (TcssListLabId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue, IsLiver) VALUES('9', '679', '9', 'Direct Bilirubin (mg/dL)', 'Direct Bilirubin (mg/dL)', '1')
	INSERT INTO TcssListLab (TcssListLabId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('10', '679', '10', 'Indirect Bilirubin (mg/dL)', 'Indirect Bilirubin (mg/dL)')
	INSERT INTO TcssListLab (TcssListLabId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue, IsLiver) VALUES('11', '679', '11', 'AST (U/L)', 'AST (U/L)', '1')
	INSERT INTO TcssListLab (TcssListLabId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue, IsLiver) VALUES('12', '679', '12', 'ALT (U/L)', 'ALT (U/L)', '1')
	INSERT INTO TcssListLab (TcssListLabId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue, IsLiver) VALUES('13', '679', '13', 'Alkaline Phosphatase (U/L)', 'Alkaline Phosphatase (U/L)', '1')
	INSERT INTO TcssListLab (TcssListLabId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('14', '679', '14', 'GGT (u/L)', 'GGT (u/L)')
	INSERT INTO TcssListLab (TcssListLabId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('15', '679', '15', 'LDH (u/L)', 'LDH (u/L)')
	INSERT INTO TcssListLab (TcssListLabId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('16', '679', '16', 'Albumin (g/dL)', 'Albumin (g/dL)')
	INSERT INTO TcssListLab (TcssListLabId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('17', '679', '17', 'Total protein (g/dL)', 'Total protein (g/dL)')
	INSERT INTO TcssListLab (TcssListLabId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue, IsLiver) VALUES('18', '679', '18', 'PT (seconds)', 'PT (seconds)', '1')
	INSERT INTO TcssListLab (TcssListLabId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('19', '679', '19', 'INR', 'INR')
	INSERT INTO TcssListLab (TcssListLabId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('20', '679', '20', 'PTT (seconds)', 'PTT (seconds)')
	INSERT INTO TcssListLab (TcssListLabId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue, IsKidney) VALUES('21', '679', '21', 'Serum Amylase (u/L)', 'Serum Amylase (u/L)', '1')
	INSERT INTO TcssListLab (TcssListLabId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue, IsKidney) VALUES('22', '679', '22', 'Serum Lipase (u/L)', 'Serum Lipase (u/L)', '1')
END

SET IDENTITY_INSERT TcssListLab OFF
GO

-- Set the Lung values that needs to be displayed in the summary
IF ((SELECT count(*) FROM TcssListLab WHERE IsLung = 1) = 0)
BEGIN
	UPDATE TcssListLab SET IsLung = 1 
	WHERE TcssListLabId 
	IN 
	(
		1, -- Na+ (140 - 150 mEq/L)
		5, -- BUN (<20 mg/dL)
		6, -- Creatinine (<1.5 mg/dL)
		2, -- K+ (3.5 - 5.0 mEq/L)
		18, -- PT (11 - 15 seconds)
		19, -- INR (2.0 - 3.5)
		20-- PTT (24 - 36 seconds)
	)
END
GO

-- Set the Heart values that needs to be displayed in the summary
IF ((SELECT count(*) FROM TcssListLab WHERE IsHeart = 1) = 0)
BEGIN
	UPDATE TcssListLab SET IsHeart = 1 
	WHERE TcssListLabId 
	IN 
	(
		1, -- Na+ (140 - 150 mEq/L)
		5, -- BUN (<20 mg/dL)
		6, -- Creatinine (<1.5 mg/dL)
		2, -- K+ (3.5 - 5.0 mEq/L)
		18, -- PT (11 - 15 seconds)
		19, -- INR (2.0 - 3.5)
		20-- PTT (24 - 36 seconds)
	)
END
GO

-- Set the Intestine values that needs to be displayed in the summary
IF ((SELECT count(*) FROM TcssListLab WHERE IsIntestine = 1) = 0)
BEGIN
	UPDATE TcssListLab SET IsIntestine = 1 
	WHERE TcssListLabId 
	IN 
	(
		1, -- Na+ (140 - 150 mEq/L)
		5, -- BUN (<20 mg/dL)
		6, -- Creatinine (<1.5 mg/dL)
		8, -- Total Bili (0.1 - 1 mg/dL)
		9, -- Direct Bili (0.1 - 0.3 - mg/dL)
		11, -- AST (<40 U/L)
		12, -- ALT (5 - 35 IU)
		18, -- PT (11 - 15 seconds)
		20,-- PTT (24 - 36 seconds)
		13 -- Alk. Phos. (45 - 110 ImU/mL)
	)
END
GO

-- Set the Pancreas values that needs to be displayed in the summary
IF ((SELECT count(*) FROM TcssListLab WHERE IsPancreas = 1) = 0)
BEGIN
	UPDATE TcssListLab SET IsPancreas = 1 
	WHERE TcssListLabId 
	IN 
	(
		1, -- Na+ (140 - 150 mEq/L)
		5, -- BUN (<20 mg/dL)
		6, -- Creatinine (<1.5 mg/dL)
		7, -- Glucose (65 - 150 mg/dL)
		21, -- Amylase (23 - 851 IU/L)
		22, -- Lipase (0 - 80 U/L)
		8, -- Total Bili (0.1 - 1 mg/dL)
		9, -- Direct Bili (0.1 - 0.3 - mg/dL)
		11, -- AST (<40 U/L)
		12, -- ALT (5 - 35 IU)
		18, -- PT (11 - 15 seconds)
		20,-- PTT (24 - 36 seconds)
		13, -- Alk. Phos. (45 - 110 ImU/mL)
		14 -- GGT (17 - 55 Iuaca)
	)
END
GO

-- Set the HeartLung values that needs to be displayed in the summary
IF ((SELECT count(*) FROM TcssListLab WHERE IsHeartLung = 1) = 0)
BEGIN
	UPDATE TcssListLab SET IsHeartLung = 1 
	WHERE TcssListLabId 
	IN 
	(
		1, -- Na+ (140 - 150 mEq/L)
		5, -- BUN (<20 mg/dL)
		6, -- Creatinine (<1.5 mg/dL)
		2, -- K+ (3.5 - 5.0 mEq/L)
		18, -- PT (11 - 15 seconds)
		19, -- INR (2.0 - 3.5)
		20-- PTT (24 - 36 seconds)
	)
END
GO

-- Set the KidneyPancreas values that needs to be displayed in the summary
IF ((SELECT count(*) FROM TcssListLab WHERE IsKidneyPancreas = 1) = 0)
BEGIN
	UPDATE TcssListLab SET IsKidneyPancreas = 1 
	WHERE TcssListLabId 
	IN 
	(
		1, -- Na+ (140 - 150 mEq/L)
		5, -- BUN (<20 mg/dL)
		6, -- Creatinine (<1.5 mg/dL)
		7, -- Glucose (65 - 150 mg/dL)
		21, -- Amylase (23 - 851 IU/L)
		22, -- Lipase (0 - 80 U/L)
		8, -- Total Bili (0.1 - 1 mg/dL)
		9, -- Direct Bili (0.1 - 0.3 - mg/dL)
		11, -- AST (<40 U/L)
		12, -- ALT (5 - 35 IU)
		18, -- PT (11 - 15 seconds)
		20,-- PTT (24 - 36 seconds)
		13, -- Alk. Phos. (45 - 110 ImU/mL)
		14 -- GGT (17 - 55 Iuaca)
	)
END
GO


-- Set the MultiOrgan values that needs to be displayed in the summary
IF ((SELECT count(*) FROM TcssListLab WHERE IsMultiOrgan = 1) > 0)
BEGIN
	UPDATE TcssListLab SET IsMultiOrgan = 1 
	WHERE TcssListLabId 
	IN 
	(--set all to true of multiorgan, per sara 5/20/11 jth
		1, -- Na+ (140 - 150 mEq/L)
		2, -- K+ (3.5 - 5.0 mEq/L)
		3, 
		4,
		5, -- BUN (<20 mg/dL)
		6, -- Creatinine (<1.5 mg/dL)
		7, -- Glucose (65 - 150 mg/dL)
		21, -- Amylase (23 - 851 IU/L)
		22, -- Lipase (0 - 80 U/L)
		8, -- Total Bili (0.1 - 1 mg/dL)
		9, -- Direct Bili (0.1 - 0.3 - mg/dL)
		10,
		11, -- AST (<40 U/L)
		12, -- ALT (5 - 35 IU)
		15,
		16,
		17,
		18, -- PT (11 - 15 seconds)
		19, -- INR (2.0 - 3.5)
		20,-- PTT (24 - 36 seconds)
		13, -- Alk. Phos. (45 - 110 ImU/mL)
		14 -- GGT (17 - 55 Iuaca)
	)
END
GO

-- Bug# 6054
UPDATE TcssListLab SET IsLiver = 1 
WHERE TcssListLabId 
IN 
(
	20-- PTT (24 - 36 seconds)
)
GO

UPDATE TcssListLab SET FieldValue = 'Na+ (140 - 150 mEq/L)' WHERE TcssListLabId = 1
UPDATE TcssListLab SET FieldValue = 'K+ (3.5 - 5.0 mEq/L)' WHERE TcssListLabId = 2
UPDATE TcssListLab SET FieldValue = 'BUN (<20 mg/dL)' WHERE TcssListLabId = 5
UPDATE TcssListLab SET FieldValue = 'Creatinine (<1.5 mg/dL)' WHERE TcssListLabId = 6
UPDATE TcssListLab SET FieldValue = 'Glucose (65 - 150 mg/dL)' WHERE TcssListLabId = 7
UPDATE TcssListLab SET FieldValue = 'Amylase (23 - 851 IU/L)' WHERE TcssListLabId = 21
UPDATE TcssListLab SET FieldValue = 'Lipase (0 - 80 U/L)' WHERE TcssListLabId = 22
UPDATE TcssListLab SET FieldValue = 'Total Bili (0.1 - 1 mg/dL)' WHERE TcssListLabId = 8
UPDATE TcssListLab SET FieldValue = 'Direct Bili (0.1 - 0.3 - mg/dL)' WHERE TcssListLabId = 9
UPDATE TcssListLab SET FieldValue = 'AST (<40 U/L)' WHERE TcssListLabId = 11
UPDATE TcssListLab SET FieldValue = 'ALT (5 - 35 IU)' WHERE TcssListLabId = 12
UPDATE TcssListLab SET FieldValue = 'PT (11 - 15 seconds)' WHERE TcssListLabId = 18
UPDATE TcssListLab SET FieldValue = 'INR (2.0 - 3.5)' WHERE TcssListLabId = 19
UPDATE TcssListLab SET FieldValue = 'PTT (24 - 36 seconds)' WHERE TcssListLabId = 20
UPDATE TcssListLab SET FieldValue = 'Alk. Phos. (45 - 110 ImU/mL)' WHERE TcssListLabId = 13
UPDATE TcssListLab SET FieldValue = 'GGT (17 - 55 Iuaca)' WHERE TcssListLabId = 14
GO

-- Update teh Unos Value
UPDATE TcssListLab SET UnosValue = 'Na (mEq/L)' WHERE TcssListLabId = 1
UPDATE TcssListLab SET UnosValue = 'K+ (mmol/L)' WHERE TcssListLabId = 2
UPDATE TcssListLab SET UnosValue = 'Creatinine (mg/dL))' WHERE TcssListLabId = 6
UPDATE TcssListLab SET UnosValue = 'SGOT (AST) (u/L)' WHERE TcssListLabId = 11
UPDATE TcssListLab SET UnosValue = 'SGPT (ALT) (u/L)' WHERE TcssListLabId = 12
UPDATE TcssListLab SET UnosValue = 'Alkaline phosphatase (u/L)' WHERE TcssListLabId = 13
UPDATE TcssListLab SET UnosValue = 'Prothrombin (PT) (seconds)' WHERE TcssListLabId = 18
GO

-- BUG # 6055
UPDATE TcssListLab SET SortOrder = 7 WHERE TcssListLabId = 2 -- K+ (3.5 - 5.0 mEq/L)
UPDATE TcssListLab SET SortOrder = 2 WHERE TcssListLabId = 3 -- Cl (mmol/L)
UPDATE TcssListLab SET SortOrder = 3 WHERE TcssListLabId = 4 -- CO2 (mmol/L)
UPDATE TcssListLab SET SortOrder = 4 WHERE TcssListLabId = 5 -- BUN (<20 mg/dL)
UPDATE TcssListLab SET SortOrder = 5 WHERE TcssListLabId = 6 -- Creatinine (<1.5 mg/dL)
UPDATE TcssListLab SET SortOrder = 6 WHERE TcssListLabId = 7 -- Glucose (65 - 150 mg/dL)
GO