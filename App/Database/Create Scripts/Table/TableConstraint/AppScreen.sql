/******************************************************************************
**		File: AppScreen.sql
**		Name: AppScreen
**		Desc: Table Constraint for AppScreen
**		Auth: Tanvir Ather
**		Date: 12/23/2008
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		----------	----------------	-------------------------------------------
**		12/23/2008	Tanvir Ather		Initial Table Constraint
**		07/09/2010	ccarroll		added this note for development build (GenerateSQL)
*******************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K'
	AND parent_obj = (SELECT Id FROM sysobjects WHERE name = 'AppScreen'))
BEGIN
	PRINT 'Adding Primary Key PK_AppScreen'
	ALTER TABLE dbo.AppScreen ADD 
		CONSTRAINT PK_AppScreen PRIMARY KEY CLUSTERED (AppScreenId) --ON PRIMARY
END
GO
