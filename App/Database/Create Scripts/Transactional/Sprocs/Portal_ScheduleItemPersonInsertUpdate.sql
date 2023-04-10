--Procedure to insert values into table and return last value
IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'Portal_ScheduleItemPersonInsertUpdate')
	BEGIN
		PRINT 'Dropping Procedure Portal_ScheduleItemPersonInsertUpdate'
		DROP  Procedure  Portal_ScheduleItemPersonInsertUpdate
	END

GO

PRINT 'Creating Procedure Portal_ScheduleItemPersonInsertUpdate'
GO

CREATE PROCEDURE Portal_ScheduleItemPersonInsertUpdate
@ScheduleItemID INT = NULL,  
@PersonId INT = NULL,
@Priority INT = NULL,
@WebPersonID INT

AS

/******************************************************************************
**	File: Portal_ScheduleItemPersonInsertUpdate.sql
**	Name: Portal_ScheduleItemPersonInsertUpdate
**	Desc: Inserts or updates a person in the schedule 
**	Auth: plscheichenost
**	Date: 02/25/2021
**	Called By: used in reporting portal
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	02/25/2021		plscheichenost			Initial Sproc Creation
*******************************************************************************/

--Insert persons
IF ((SELECT COUNT(1) FROM dbo.ScheduleItemPerson WHERE ScheduleItemID = @ScheduleItemID AND Priority = @Priority) = 0)
BEGIN
	IF (@PersonId IS NOT NULL)
	BEGIN
		INSERT INTO ScheduleItemPerson 
			(ScheduleItemID, PersonID, Priority, LastModified, LastWebPersonID, AuditLogTypeID) 
		VALUES 
			(@ScheduleItemID,@PersonId,@Priority, GETDATE(), @WebPersonID, 1);

	END
END
ELSE
BEGIN
	IF (@PersonId IS NOT NULL)
	BEGIN
		UPDATE ScheduleItemPerson
		SET PersonID = @PersonId,
			LastModified = GETDATE(),
			LastWebPersonID = @WebPersonID,
			AuditLogTypeID = 3
		WHERE ScheduleItemID = @ScheduleItemID
		AND Priority = @Priority;
	END
	ELSE
	BEGIN
		--update auditlogtype with a 4 for audittrail purposes prior to delete
		UPDATE ScheduleItemPerson
		SET LastModified = GETDATE(),
			LastWebPersonID = @WebPersonID,
			AuditLogTypeID = 4
		WHERE ScheduleItemID = @ScheduleItemID
		AND Priority = @Priority;

		EXEC dbo.DeleteSchedulePerson @ScheduleItemID = @ScheduleItemID, @Priority = @Priority
	END
END


GO

