--Procedure to insert values into table and return last value
IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'InsertTrackingNumber')
	BEGIN
		PRINT 'Dropping Procedure InsertTrackingNumber'
		DROP  Procedure  InsertTrackingNumber
	END

GO

PRINT 'Creating Procedure InsertTrackingNumber'
GO
/******************************************************************************
**	File: InsertTrackingNumber.sql
**	Name: InsertTrackingNumber
**	Desc: Inserts a tracking number into the qa system, along with the tracking type and some other data
**	Auth: jim hawkins
**	Date: 2009
**	Called By: When user adds a qa tracking number to a form or error
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
*** 9/10            jth                     added parm and code to use various tracking types other than StatTrac
** 04/27/2012		ccarroll				Added missing column values on insert.
 *******************************************************************************/
CREATE PROCEDURE InsertTrackingNumber
@QAOrgID int,
@QATrackingNumber varchar(20),
@EmpID int,
@SourceCode varchar(20),
@RefDateTime datetime,
@RefTypeID int,
@FromQAForm int,
@QAFormID int,
@returnVal int OUTPUT

AS


BEGIN
--Insert the values
DECLARE @TrackingTypeID int

if @FromQAForm = 1
Begin
	select @TrackingTypeID=QATrackingTypeID FROM QAMonitoringForm where qamonitoringformid = @QAFormID 
End
Else
Begin
	set @TrackingTypeID=@QAFormID
end
INSERT INTO QATracking
(
	OrganizationID,
	QATrackingTypeID,
	QATrackingNumber,
	QATrackingNotes,
	QATrackingSourceCode,
	QATrackingReferralDateTime,
	QATrackingReferralTypeID,
	QATrackingStatusID,
	LastModified,
	LastStatEmployeeID,
	AuditLogTypeID
)  VALUES (
	@QAOrgID, 
	@TrackingTypeID, 
	@QATrackingNumber,
	null,
	@SourceCode,
	@RefDateTime,
	@RefTypeID,
	1,
	getdate(),
	@EmpID,
	1
)



--Select the column to send back


SELECT @returnVal = MAX(QATrackingID) FROM QATracking



--Return Value


RETURN @returnVal


END

GO

