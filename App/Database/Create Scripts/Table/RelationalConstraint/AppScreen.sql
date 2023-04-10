/******************************************************************************
**	File: AppScreen.sql
**	Name: AppScreen
**	Desc: Relational Constraints for AppScreen
**	Auth: Tanvir Ather
**	Date: 03/02/2009
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:		Author:				Description:
**	----------	---------------		-------------------------------------------
**	03/02/2009	Tanvir Ather		Initial Relational Constraints
**	07/12/2010	ccarroll		added this note for development build (GenerateSQL)
*******************************************************************************/

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_AppScreen_ParentId_AppScreen_AppScreenId')
	BEGIN
		PRINT 'Adding Foreign Key FK_AppScreen_ParentId_AppScreen_AppScreenId'
		ALTER TABLE dbo.AppScreen ADD CONSTRAINT FK_AppScreen_ParentId_AppScreen_AppScreenId
			FOREIGN KEY(ParentId) REFERENCES dbo.AppScreen(AppScreenId) 
	END
GO

