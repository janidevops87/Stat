IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'PersonListSelect')
	BEGIN
		PRINT 'Dropping Procedure PersonListSelect'
		DROP Procedure PersonListSelect
	END
GO

PRINT 'Creating Procedure PersonListSelect'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[PersonListSelect]
(
		@PersonTypeID int = null,
		@OrganizationID int = null,
		@TrainedRequestorID int = null					
)
AS
/******************************************************************************
**	File: PersonListSelect.sql
**	Name: PersonListSelect
**	Desc: Selects multiple rows of Person Based on Id  fields 
**	Auth: Bret Knoll
**	Date: 9/15/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	9/15/2009		Bret Knoll			Initial Sproc Creation
**	12/9/2009		Jim Hawkins			Changed from create to alter and other alterations
**	07/12/2010		ccarroll			added this note for development build (GenerateSQL)
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	SELECT distinct
		Person.PersonID AS ListId,
		Person.PersonLast + ', ' + Person.PersonFirst + ' ' + isnull(Person.PersonMI,' ') AS FieldValue

	FROM 
		dbo.Person 
	WHERE 
		Person.PersonTypeID = ISNULL(@PersonTypeID, Person.PersonTypeID)
	AND
		Person.OrganizationID = ISNULL(@OrganizationID, Person.OrganizationID)
	AND
		Person.TrainedRequestorID = ISNULL(@TrainedRequestorID, Person.TrainedRequestorID)	
					
	ORDER BY 2
GO

GRANT EXEC ON PersonListSelect TO PUBLIC
GO

