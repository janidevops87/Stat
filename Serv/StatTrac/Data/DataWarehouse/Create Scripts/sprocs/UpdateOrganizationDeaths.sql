 IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'UpdateSchedule')
	BEGIN
		PRINT 'Dropping Procedure UpdateOrganizationDeaths'
		DROP  Procedure  UpdateOrganizationDeaths
	END

GO

PRINT 'Creating Procedure UpdateOrganizationDeaths'
GO
 
 CREATE Procedure UpdateOrganizationDeaths
    @yearID int = null, 
    @monthID int = null, 
    @orgID int = NULL , 
    @sourceCodeList varchar(25) = NULL,
    @totalDeaths int = NULL
	
AS

/******************************************************************************
**		File: 
**		Name: UpdateOrganizationDeaths
**		Desc: Update a record into the OrganizationDeaths table
**
**              
**		
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     		----------						-----------
**		See List
**
**		Auth: jth
**		Date: 10/08
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**		--------		--------				-------------------------------------------
**    		10/08			jth
**	  
*******************************************************************************/
		

IF (@yearID <> 0)
    BEGIN
	DELETE FROM OrganizationDeaths WHERE YearID = @yearID AND MonthID = @monthID AND OrganizationID = @orgID AND SourceCodeList = @sourceCodeList
    END

INSERT INTO OrganizationDeaths (YearID, MonthID, OrganizationID, SourceCodeList, TotalDeaths ) VALUES (@yearID,@monthID,@orgID,@sourceCodeList,@totalDeaths)

GO
 