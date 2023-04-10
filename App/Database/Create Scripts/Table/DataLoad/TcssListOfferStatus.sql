/***************************************************************************************************
**	Name: TcssListOfferStatus
**	Desc: Data Load for table TcssListOfferStatus
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Data Load
***************************************************************************************************/

SET IDENTITY_INSERT TcssListOfferStatus ON

IF ((SELECT count(*) FROM TcssListOfferStatus) = 0)
BEGIN
	INSERT INTO TcssListOfferStatus (TcssListOfferStatusId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('1', '679', '1', 'Provisional Yes', 'Provisional Yes')
	INSERT INTO TcssListOfferStatus (TcssListOfferStatusId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('2', '679', '2', 'Accepted', 'Accepted')
	INSERT INTO TcssListOfferStatus (TcssListOfferStatusId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('3', '679', '3', 'Refused', 'Refused')
END

SET IDENTITY_INSERT TcssListOfferStatus OFF
GO
