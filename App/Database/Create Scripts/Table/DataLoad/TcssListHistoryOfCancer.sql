/***************************************************************************************************
**	Name: TcssListHistoryOfCancer
**	Desc: Data Load for table TcssListHistoryOfCancer
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Data Load
***************************************************************************************************/

SET IDENTITY_INSERT TcssListHistoryOfCancer ON

IF ((SELECT count(*) FROM TcssListHistoryOfCancer) = 0)
BEGIN
	INSERT INTO TcssListHistoryOfCancer (TcssListHistoryOfCancerId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('1', '679', '1', 'NO', 'NO')
	INSERT INTO TcssListHistoryOfCancer (TcssListHistoryOfCancerId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('2', '679', '2', 'SKIN - SQUAMOUS, BASAL CELL', 'SKIN - SQUAMOUS, BASAL CELL')
	INSERT INTO TcssListHistoryOfCancer (TcssListHistoryOfCancerId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('3', '679', '3', 'SKIN - MELANOMA', 'SKIN - MELANOMA')
	INSERT INTO TcssListHistoryOfCancer (TcssListHistoryOfCancerId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('4', '679', '4', 'CNS TUMOR - ASTROCYTOMA', 'CNS TUMOR - ASTROCYTOMA')
	INSERT INTO TcssListHistoryOfCancer (TcssListHistoryOfCancerId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('5', '679', '5', 'CNS TUMOR - GLIOBLASTOMA MULTIFORME', 'NS TUMOR - GLIOBLASTOMA MULTIFORME')
	INSERT INTO TcssListHistoryOfCancer (TcssListHistoryOfCancerId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('6', '679', '6', 'CNS TUMOR - MEDULLOBLASTOMA', 'CNS TUMOR - MEDULLOBLASTOMA')
	INSERT INTO TcssListHistoryOfCancer (TcssListHistoryOfCancerId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('7', '679', '7', 'CNS TUMOR - NEUROBLASTOMA', 'CNS TUMOR - NEUROBLASTOMA')
	INSERT INTO TcssListHistoryOfCancer (TcssListHistoryOfCancerId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('8', '679', '8', 'CNS TUMOR - ANGIOBLASTOMA', 'CNS TUMOR - ANGIOBLASTOMA')
	INSERT INTO TcssListHistoryOfCancer (TcssListHistoryOfCancerId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('9', '679', '9', 'CNS TUMOR - MENINGIOMA', 'CNS TUMOR - MENINGIOMA')
	INSERT INTO TcssListHistoryOfCancer (TcssListHistoryOfCancerId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('10', '679', '10', 'CNS TUMOR - OTHER', 'CNS TUMOR - OTHER')
	INSERT INTO TcssListHistoryOfCancer (TcssListHistoryOfCancerId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('11', '679', '11', 'GENITOURINARY - BLADDER', 'GENITOURINARY - BLADDER')
	INSERT INTO TcssListHistoryOfCancer (TcssListHistoryOfCancerId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('12', '679', '12', 'GENITOURINARY - UTERINE CERVIX', 'GENITOURINARY - UTERINE CERVIX')
	INSERT INTO TcssListHistoryOfCancer (TcssListHistoryOfCancerId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('13', '679', '13', 'GENITOURINARY - UTERINE BODY ENDOMETRIAL', 'GENITOURINARY - UTERINE BODY ENDOMETRIAL')
	INSERT INTO TcssListHistoryOfCancer (TcssListHistoryOfCancerId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('14', '679', '14', 'GENITOURINARY - UTERINE BODY CHORIOCARCINOMA', 'GENITOURINARY - UTERINE BODY CHORIOCARCINOMA')
	INSERT INTO TcssListHistoryOfCancer (TcssListHistoryOfCancerId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('15', '679', '15', 'GENITOURINARY - VULVA', 'GENITOURINARY - VULVA')
	INSERT INTO TcssListHistoryOfCancer (TcssListHistoryOfCancerId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('16', '679', '16', 'GENITOURINARY - OVARIAN', 'GENITOURINARY - OVARIAN')
	INSERT INTO TcssListHistoryOfCancer (TcssListHistoryOfCancerId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('17', '679', '17', 'GENITOURINARY - PENIS, TESTICULAR', 'GENITOURINARY - PENIS, TESTICULAR')
	INSERT INTO TcssListHistoryOfCancer (TcssListHistoryOfCancerId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('18', '679', '18', 'GENITOURINARY - PROSTATE', 'GENITOURINARY - PROSTATE')
	INSERT INTO TcssListHistoryOfCancer (TcssListHistoryOfCancerId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('19', '679', '19', 'GENITOURINARY - KIDNEY', 'GENITOURINARY - KIDNEY')
	INSERT INTO TcssListHistoryOfCancer (TcssListHistoryOfCancerId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('20', '679', '20', 'GENITOURINARY - UNKNOWN', 'GENITOURINARY - UNKNOWN')
	INSERT INTO TcssListHistoryOfCancer (TcssListHistoryOfCancerId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('21', '679', '21', 'GASTROINTESTINAL - ESOPHAGEAL', 'GASTROINTESTINAL - ESOPHAGEAL')
	INSERT INTO TcssListHistoryOfCancer (TcssListHistoryOfCancerId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('22', '679', '22', 'GASTROINTESTINAL - STOMACH', 'GASTROINTESTINAL - STOMACH')
	INSERT INTO TcssListHistoryOfCancer (TcssListHistoryOfCancerId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('23', '679', '23', 'GASTROINTESTINAL - SMALL INTESTINE', 'ASTROINTESTINAL - SMALL INTESTINE')
	INSERT INTO TcssListHistoryOfCancer (TcssListHistoryOfCancerId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('24', '679', '24', 'GASTROINTESTINAL - COLO-RECTAL', 'GASTROINTESTINAL - COLO-RECTAL')
	INSERT INTO TcssListHistoryOfCancer (TcssListHistoryOfCancerId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('25', '679', '25', 'GASTROINTESTINAL - LIVER & BILIARY TRACT', 'GASTROINTESTINAL - LIVER & BILIARY TRACT')
	INSERT INTO TcssListHistoryOfCancer (TcssListHistoryOfCancerId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('26', '679', '26', 'GASTROINTESTINAL - PANCREAS', 'GASTROINTESTINAL - PANCREAS')
	INSERT INTO TcssListHistoryOfCancer (TcssListHistoryOfCancerId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('27', '679', '27', 'BREAST', 'BREAST')
	INSERT INTO TcssListHistoryOfCancer (TcssListHistoryOfCancerId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('28', '679', '28', 'THYROID', 'THYROID')
	INSERT INTO TcssListHistoryOfCancer (TcssListHistoryOfCancerId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('29', '679', '29', 'TONGUE/THROAT', 'TONGUE/THROAT')
	INSERT INTO TcssListHistoryOfCancer (TcssListHistoryOfCancerId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('30', '679', '30', 'LARYNX', 'LARYNX')
	INSERT INTO TcssListHistoryOfCancer (TcssListHistoryOfCancerId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('31', '679', '31', 'LUNG (include bronchial)', 'LUNG (include bronchial)')
	INSERT INTO TcssListHistoryOfCancer (TcssListHistoryOfCancerId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('32', '679', '32', 'LEUKEMIA/LYMPHOMA', 'LEUKEMIA/LYMPHOMA')
	INSERT INTO TcssListHistoryOfCancer (TcssListHistoryOfCancerId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('33', '679', '33', 'UNKNOWN', 'UNKNOWN')
	INSERT INTO TcssListHistoryOfCancer (TcssListHistoryOfCancerId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('34', '679', '34', 'OTHER, SPECIFY', 'OTHER, SPECIFY')
END

SET IDENTITY_INSERT TcssListHistoryOfCancer OFF
GO
