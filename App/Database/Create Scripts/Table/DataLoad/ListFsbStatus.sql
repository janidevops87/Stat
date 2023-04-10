/***************************************************************************************************
**	Name: ListFsbStatus
**	Desc: Data Load for table ListFsbStatus
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	04/01/2009	Tanvir Ather	Initial Data Load
**  7/6/11      jth				added inactive updates
***************************************************************************************************/

SET IDENTITY_INSERT ListFsbStatus ON

IF ((SELECT count(*) FROM ListFsbStatus) = 0)
BEGIN
	INSERT INTO ListFsbStatus (ListFsbStatusId, LastStatEmployeeId, FieldValue, ListFsbStatusColorId, ThresholdMinutes) VALUES('1', '679', 'Secondary Pending', '2', '20')
	INSERT INTO ListFsbStatus (ListFsbStatusId, LastStatEmployeeId, FieldValue) VALUES('2', '679', 'Additional Information Needed')
	INSERT INTO ListFsbStatus (ListFsbStatusId, LastStatEmployeeId, FieldValue) VALUES('3', '679', 'Approach with an ME Disclaimer')
	INSERT INTO ListFsbStatus (ListFsbStatusId, LastStatEmployeeId, FieldValue) VALUES('4', '679', 'Approach')
	INSERT INTO ListFsbStatus (ListFsbStatusId, LastStatEmployeeId, FieldValue) VALUES('5', '679', 'Registered Donor Approach')
	INSERT INTO ListFsbStatus (ListFsbStatusId, LastStatEmployeeId, FieldValue) VALUES('6', '679', 'Closed')
	INSERT INTO ListFsbStatus (ListFsbStatusId, LastStatEmployeeId, FieldValue) VALUES('7', '679', 'Consented')
	INSERT INTO ListFsbStatus (ListFsbStatusId, LastStatEmployeeId, FieldValue) VALUES('8', '679', 'Coord to c/b')
	INSERT INTO ListFsbStatus (ListFsbStatusId, LastStatEmployeeId, FieldValue) VALUES('9', '679', 'Call-out Pending')
	INSERT INTO ListFsbStatus (ListFsbStatusId, LastStatEmployeeId, FieldValue) VALUES('10', '679', 'Decision')
	INSERT INTO ListFsbStatus (ListFsbStatusId, LastStatEmployeeId, FieldValue) VALUES('11', '679', 'Direct Approach')
	INSERT INTO ListFsbStatus (ListFsbStatusId, LastStatEmployeeId, FieldValue) VALUES('12', '679', 'Inform of Rule-out')
	INSERT INTO ListFsbStatus (ListFsbStatusId, LastStatEmployeeId, FieldValue) VALUES('13', '679', 'Language Line Approach')
	INSERT INTO ListFsbStatus (ListFsbStatusId, LastStatEmployeeId, FieldValue) VALUES('14', '679', 'Language Line Paperwork')
	INSERT INTO ListFsbStatus (ListFsbStatusId, LastStatEmployeeId, FieldValue) VALUES('15', '679', 'No Next-of-Kin Information')
	INSERT INTO ListFsbStatus (ListFsbStatusId, LastStatEmployeeId, FieldValue) VALUES('16', '679', 'Next-of-Kin to Call Back')
	INSERT INTO ListFsbStatus (ListFsbStatusId, LastStatEmployeeId, FieldValue) VALUES('17', '679', 'Paperwork')
	INSERT INTO ListFsbStatus (ListFsbStatusId, LastStatEmployeeId, FieldValue) VALUES('18', '679', 'Recovery Outcome')
	INSERT INTO ListFsbStatus (ListFsbStatusId, LastStatEmployeeId, FieldValue) VALUES('19', '679', 'Secondary')
	INSERT INTO ListFsbStatus (ListFsbStatusId, LastStatEmployeeId, FieldValue) VALUES('20', '679', 'Awaiting Coroner Callback')
	INSERT INTO ListFsbStatus (ListFsbStatusId, LastStatEmployeeId, FieldValue) VALUES('21', '679', 'Screening with Processor')
END

UPDATE ListFsbStatus SET IsActive = 0 WHERE ListFsbStatusId = 20 -- Awaiting Coroner Callback
UPDATE ListFsbStatus SET IsActive = 0 WHERE ListFsbStatusId = 9 -- Call-out Pending
UPDATE ListFsbStatus SET IsActive = 0 WHERE ListFsbStatusId = 7 -- Consented
UPDATE ListFsbStatus SET IsActive = 0 WHERE ListFsbStatusId = 8 -- Coord to c/b
UPDATE ListFsbStatus SET IsActive = 0 WHERE ListFsbStatusId = 11 --  Direct Approach
UPDATE ListFsbStatus SET IsActive = 0 WHERE ListFsbStatusId = 13 -- Language Line Approach
UPDATE ListFsbStatus SET IsActive = 0 WHERE ListFsbStatusId = 14 -- Language Line Paperwork
UPDATE ListFsbStatus SET IsActive = 0 WHERE ListFsbStatusId = 5 -- Registered Donor Approach
UPDATE ListFsbStatus SET IsActive = 0 WHERE ListFsbStatusId = 21 -- Screening with Processor

SET IDENTITY_INSERT ListFsbStatus OFF
GO
