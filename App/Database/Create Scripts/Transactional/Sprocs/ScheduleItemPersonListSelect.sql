 IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'ScheduleItemPersonListSelect')
	BEGIN
		PRINT 'Dropping Procedure ScheduleItemPersonListSelect'
		DROP Procedure ScheduleItemPersonListSelect
	END
GO

PRINT 'Creating Procedure ScheduleItemPersonListSelect'
GO

CREATE PROCEDURE dbo.ScheduleItemPersonListSelect
(	
	@ScheduleGroupID INT
)
AS
/******************************************************************************
**	File: ScheduleItemPersonListSelect.sql
**	Name: ScheduleItemPersonListSelect
**	Desc: Select Data from ScheduleLog
**	Auth: Bret Knoll
**	Date: 05/11/2011
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:		Author:			Description:
**	--------	--------		----------------------------------
**	05/11/2011  Bret Knoll		Initial Sproc Creation
**	6/8/2011	Bret Knoll		Wi 12844 Converted Select to cte(common table expression) 
**								to allow selection of both people in ScheduleGroupPerson and ScheduleItemPerson
**	10/13/2011	ccarroll		Only show active persons, Add Order By HS 28855 wi: 13857
*******************************************************************************/
SET NOCOUNT ON;
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	WITH PersonList
	AS(
	
		SELECT 
			
			Person.PersonID ListID,
			CASE 
				WHEN Person.Inactive = 1 
				THEN '(Inactive) ' + Person.PersonFirst+' '+ Person.PersonLast 
				ELSE Person.PersonFirst+' '+ Person.PersonLast 
			END  FieldValue	
		FROM Person
		LEFT JOIN ScheduleItemPerson ON Person.PersonID = ScheduleItemPerson.PersonID
		JOIN ScheduleItem ON ScheduleItemPerson.ScheduleItemID = ScheduleItem.ScheduleItemID
		
		WHERE 
			ScheduleItem.ScheduleGroupID = @ScheduleGroupID
			AND IsNull(Person.Inactive, 0) = 0 
			
		UNION ALL
		SELECT 
			
			Person.PersonID ListID,
			CASE 
				WHEN Person.Inactive = 1 
				THEN '(Inactive) ' + Person.PersonFirst+' '+ Person.PersonLast 
				ELSE Person.PersonFirst+' '+ Person.PersonLast 
			END  FieldValue	
		FROM Person
		LEFT JOIN ScheduleGroupPerson ON Person.PersonID = ScheduleGroupPerson.PersonID
		WHERE 
			ScheduleGroupPerson.ScheduleGroupID = @ScheduleGroupID
			AND IsNull(Person.Inactive, 0) = 0 
			)
		
		SELECT DISTINCT ListID, FieldValue FROM PersonList ORDER BY 2