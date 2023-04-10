--Procedure to insert values into table and return last value
IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'InsertTrackingForm')
	BEGIN
		PRINT 'Dropping Procedure InsertTrackingForm'
		DROP  Procedure  InsertTrackingForm
	END

GO

PRINT 'Creating Procedure InsertTrackingForm'
GO

CREATE PROCEDURE InsertTrackingForm
@EmpID int,
@PersonID int,
@returnVal int OUTPUT

AS
/******************************************************************************
**	File: InsertTrackingForm.sql
**	Name: InsertTrackingForm
**	Desc: Inserts a tracking form into the qa system
**	Auth: jim hawkins
**	Date: 2009
**	Called By: QA Module
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
** 04/27/2012		ccarroll				Added missing column values on insert.
*******************************************************************************/

BEGIN
--Insert the values
INSERT INTO QATrackingForm
(
	QAProcessStepID,
	PersonID,
	QATrackingEventDateTime,
	QATrackingCAPANumber,
	QATrackingApproved,
	QATrackingStatusID,
	QATrackingFormPoints,
	QATrackingFormComments,
	LastModified,
	LastStatEmployeeID,
	AuditLogTypeID
) VALUES 
(
	1,			-- QAProcessStepID
	@PersonID,	-- PersonID
	getdate(),	-- QATrackingEventDateTime
	null,		-- QATrackingCAPANumber
	0,			-- QATrackingApproved
	null,		-- QATrackingStatusID
	0,			-- QATrackingFormPoints
	null,		-- QATrackingFormComments
	getdate(),	-- LastModified
	@EmpID,		-- LastStatEmployeeID
	1			-- AuditLogTypeID
)


--Select the column to send back
SELECT @returnVal = MAX(QATrackingFormID) FROM QATrackingForm

--Return Value
RETURN @returnVal

END

GO

