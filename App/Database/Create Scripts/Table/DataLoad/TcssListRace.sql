/***************************************************************************************************
**	Name: TcssListRace
**	Desc: Data Load for table TcssListRace
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Data Load
***************************************************************************************************/

SET IDENTITY_INSERT TcssListRace ON

IF ((SELECT count(*) FROM TcssListRace) = 0)
BEGIN
	INSERT INTO TcssListRace (TcssListRaceId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('1', '679', '1', 'American Indian', 'American Indian')
	INSERT INTO TcssListRace (TcssListRaceId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('2', '679', '2', 'Eskimo', 'Eskimo')
	INSERT INTO TcssListRace (TcssListRaceId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('3', '679', '3', 'Aleutian', 'Aleutian')
	INSERT INTO TcssListRace (TcssListRaceId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('4', '679', '4', 'Alaska Indian', 'Alaska Indian')
	INSERT INTO TcssListRace (TcssListRaceId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('5', '679', '5', 'American Indian or Alaska Native: Other', 'American Indian or Alaska Native: Other')
	INSERT INTO TcssListRace (TcssListRaceId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('6', '679', '6', 'American Indian or Alaska Native: Not Specified/Unknown', 'American Indian or Alaska Native: Not Specified/Unknown')
	INSERT INTO TcssListRace (TcssListRaceId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('7', '679', '7', 'Asian Indian/Indian Sub-Continent', 'Asian Indian/Indian Sub-Continent')
	INSERT INTO TcssListRace (TcssListRaceId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('8', '679', '8', 'Chinese', 'Chinese')
	INSERT INTO TcssListRace (TcssListRaceId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('9', '679', '9', 'Filipino', 'Filipino')
	INSERT INTO TcssListRace (TcssListRaceId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('10', '679', '10', 'Japanese', 'Japanese')
	INSERT INTO TcssListRace (TcssListRaceId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('11', '679', '11', 'Korean', 'Korean')
	INSERT INTO TcssListRace (TcssListRaceId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('12', '679', '12', 'Vietnamese', 'Vietnamese')
	INSERT INTO TcssListRace (TcssListRaceId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('13', '679', '13', 'Asian: Other', 'Other')
	INSERT INTO TcssListRace (TcssListRaceId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('14', '679', '14', 'Asian: Not Specified/Unknown', 'Asian: Not Specified/Unknown')
	INSERT INTO TcssListRace (TcssListRaceId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('15', '679', '15', 'African American', 'African American')
	INSERT INTO TcssListRace (TcssListRaceId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('16', '679', '16', 'African (Continental)', 'African (Continental)')
	INSERT INTO TcssListRace (TcssListRaceId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('17', '679', '17', 'West Indian', 'West Indian')
	INSERT INTO TcssListRace (TcssListRaceId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('18', '679', '18', 'Haitian', 'Haitian')
	INSERT INTO TcssListRace (TcssListRaceId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('19', '679', '19', 'Black or African American: Other', 'Black or African American: Other')
	INSERT INTO TcssListRace (TcssListRaceId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('20', '679', '20', 'Black or African American: Not Specified/Unknown', 'Black or African American: Not Specified/Unknown')
	INSERT INTO TcssListRace (TcssListRaceId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('21', '679', '21', 'Mexican', 'Mexican')
	INSERT INTO TcssListRace (TcssListRaceId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('22', '679', '22', 'Puerto Rican (Mainland)', 'Puerto Rican (Mainland)')
	INSERT INTO TcssListRace (TcssListRaceId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('23', '679', '23', 'Puerto Rican (Island)', 'Puerto Rican (Island)')
	INSERT INTO TcssListRace (TcssListRaceId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('24', '679', '24', 'Cuban', 'Cuban')
	INSERT INTO TcssListRace (TcssListRaceId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('25', '679', '25', 'Hispanic/Latino: Other', 'Hispanic/Latino: Other')
	INSERT INTO TcssListRace (TcssListRaceId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('26', '679', '26', 'Hispanic/Latino: Not Specified/Unknown', 'Hispanic/Latino: Not Specified/Unknown')
	INSERT INTO TcssListRace (TcssListRaceId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('27', '679', '27', 'Native Hawaiian', 'Native Hawaiian')
	INSERT INTO TcssListRace (TcssListRaceId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('28', '679', '28', 'Guamanian or Chamorro', 'Guamanian or Chamorro')
	INSERT INTO TcssListRace (TcssListRaceId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('29', '679', '29', 'Samoan', 'Samoan')
	INSERT INTO TcssListRace (TcssListRaceId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('30', '679', '30', 'Native Hawaiian or Other Pacific Islander: Other', 'Native Hawaiian or Other Pacific Islander: Other')
	INSERT INTO TcssListRace (TcssListRaceId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('31', '679', '31', 'Native Hawaiian or Other Pacific Islander: Not Specified/Unknown', 'Native Hawaiian or Other Pacific Islander: Not Specified/Unknown')
	INSERT INTO TcssListRace (TcssListRaceId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('32', '679', '32', 'European Descent', 'European Descent')
	INSERT INTO TcssListRace (TcssListRaceId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('33', '679', '33', 'Arab or Middle Eastern', 'Arab or Middle Eastern')
	INSERT INTO TcssListRace (TcssListRaceId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('34', '679', '34', 'North African (non-Black)', 'North African (non-Black)')
	INSERT INTO TcssListRace (TcssListRaceId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('35', '679', '35', 'White: Other', 'hite: Other')
	INSERT INTO TcssListRace (TcssListRaceId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('36', '679', '36', 'White: Not Specified/Unknown', 'White: White: Not Specified/Unknown')
END

-- Update the speeling and UNOS maping
UPDATE TcssListRace SET UnosValue = 'White: Other' WHERE TcssListRaceId = 35
UPDATE TcssListRace SET UnosValue = 'White: Not Specified/Unknown' WHERE TcssListRaceId = 36
GO

SET IDENTITY_INSERT TcssListRace OFF
GO
