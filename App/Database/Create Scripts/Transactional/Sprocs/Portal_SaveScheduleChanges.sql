IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'Portal_SaveScheduleChanges')
	BEGIN
		PRINT 'Dropping Procedure Portal_SaveScheduleChanges'
		DROP  Procedure  Portal_SaveScheduleChanges;
	END

GO

PRINT 'Creating Procedure Portal_SaveScheduleChanges'
GO

CREATE PROCEDURE Portal_SaveScheduleChanges 
@updates varchar(max),
@deletes varchar(max),
@WebPersonId INT
AS

/******************************************************************************
**	File: Portal_SaveScheduleChanges.sql
**	Name: Portal_SaveScheduleChanges
**	Desc: Deletes multiple shifts of schedule at one time, accepts
			comma delimited list of id's AND updates multiple schedules (requires string parsing)
**	Auth: Aykut Ucar
**	Date: 03/09/2021
**	Called By: used in reporting portal
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	03/09/2021		Aykut Ucar				Initial Sproc Creation
*******************************************************************************/
if (Len(@deletes)>0)
begin
--update auditlogtype with a 4 for audittrail purposes prior to delete
UPDATE ScheduleItemPerson
SET LastModified = GETDATE(),
	LastWebPersonID = @WebPersonID,
	AuditLogTypeID = 4
WHERE ScheduleItemID IN (SELECT value FROM STRING_SPLIT(@deletes, ','));

UPDATE ScheduleItem
SET LastModified = GETDATE(),
	LastWebPersonID = @WebPersonID,
	AuditLogTypeID = 4
WHERE ScheduleItemID IN (SELECT value FROM STRING_SPLIT(@deletes, ','));


DELETE FROM ScheduleItemPerson WHERE ScheduleItemID IN (SELECT value FROM STRING_SPLIT(@deletes, ','));
DELETE FROM ScheduleItem WHERE ScheduleItemID IN (SELECT value FROM STRING_SPLIT(@deletes, ','));
end

if (Len(@updates)>0)
begin
	DECLARE @pos INT;
	DECLARE @len INT;
	DECLARE @row varchar(max);

	declare @ScheduleItemID varchar(20);
	declare @people varchar(2000);
	declare @person varchar(50);
	declare @personId varchar(50);
	declare @priority varchar(2);
	DECLARE @pos1 INT;
	DECLARE @len1 INT;

	set @pos = 0;
	set @len = 0;
	--sample multi row update string
	--'2654086=p3:1076073,p1:1939541,&2653831=p4:1297532,p1:10768,&2654087=p3:-1,&';
	
	--One sample row
	--scheduleitemid = 2654086
	--p3:1076073
	--p1:1939541

	WHILE CHARINDEX('&', @updates, @pos+1)>0
	BEGIN
		set @len = CHARINDEX('&', @updates, @pos+1) - @pos
		set @row = SUBSTRING(@updates, @pos, @len)
            
		--PRINT @row;
    
		set @ScheduleItemID = SUBSTRING(@row, 0, CHARINDEX('=', @row, 0));
		print @ScheduleItemID;

		set @people = SUBSTRING(@row, CHARINDEX('=', @row, 0)+1,2000);
		--print @people;
	
		set @pos1 = 0;
		set @len1 = 0;
		WHILE CHARINDEX(',', @people, @pos1+1)>0
		BEGIN
			set @len1 = CHARINDEX(',', @people, @pos1+1) - @pos1;
			set @person = SUBSTRING(@people, @pos1, @len1);
			--print 'person='+ @person;
			set @pos1 = CHARINDEX(',', @people, @pos1+@len1) +1;
			set @personId = SUBSTRING(@person, 4, 20);
			--print 'personId='+ @personId;
		
			set @priority = SUBSTRING(@person, 2, 1);
			--print '@priority='+ @priority;
			if (@personId='-1')
				set @personId=null;
			EXEC Portal_ScheduleItemPersonInsertUpdate @ScheduleItemID, @personId, @priority, @WebPersonId;
		END
		set @pos = CHARINDEX('&', @updates, @pos+@len) +1;
	END
end
GO

