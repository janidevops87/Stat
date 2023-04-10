 IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TransplantSurgeonContactByOrganizationSelect')
	BEGIN
		PRINT 'Dropping Procedure TransplantSurgeonContactByOrganizationSelect'
		DROP Procedure TransplantSurgeonContactByOrganizationSelect
	END
GO

PRINT 'Creating Procedure TransplantSurgeonContactByOrganizationSelect'
GO

CREATE PROCEDURE dbo.TransplantSurgeonContactByOrganizationSelect
(
	@SourceCodeId int,
	@OrganizationId int
)
AS

/***************************************************************************************************
**	Name: TransplantSurgeonContactByOrganizationSelect
**	Desc: Update Data in table TcssListOrganType
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	DISTINCT Person.PersonID AS ListId, 
	CASE
		WHEN Person.Inactive = 1 THEN '(Inactive) ' + Person.PersonFirst + ' ' + PersonLast 
		ELSE Person.PersonFirst + ' ' + PersonLast 
	END AS FieldValue
FROM ScheduleItemPerson 
	JOIN Person ON Person.PersonID = ScheduleItemPerson.PersonID 
	JOIN PersonType ON PersonType.PersonTypeID = Person.PersonTypeID 
	JOIN ScheduleItem ON ScheduleItemPerson.ScheduleItemID = ScheduleItem.ScheduleItemID 
	JOIN ScheduleGroup ON ScheduleGroup.ScheduleGroupID = ScheduleItem.ScheduleGroupID 
	JOIN ScheduleGroupOrganization ON ScheduleGroupOrganization.ScheduleGroupID = ScheduleGroup.ScheduleGroupID 
	JOIN ScheduleGroupSourceCode ON ScheduleGroupSourceCode.ScheduleGroupID = ScheduleGroupOrganization.ScheduleGroupID 
WHERE ScheduleGroupOrganization.OrganizationID = @OrganizationId -- referring facility or TransplantCenter 
	AND ScheduleGroupSourceCode.SourceCodeID = @SourceCodeId 
	--- USE THE DATE IF "Show All" is not clicked
	AND (ScheduleItemStartDate + ' ' + ScheduleItemStartTime <= GetDate() 
	AND ScheduleItemEndDate + ' ' + ScheduleItemEndTime > GetDate()) -- ScheduleItemID = 1327963  
ORDER BY FieldValue ASC


GO

GRANT EXEC ON TransplantSurgeonContactByOrganizationSelect TO PUBLIC
GO
 
 