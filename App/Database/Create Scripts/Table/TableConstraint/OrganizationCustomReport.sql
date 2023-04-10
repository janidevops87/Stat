    /***************************************************************************************************
**	Name: OrganizationCustomReport
**	Desc: Add Primary keys, Unique keys, and Default Keys to OrganizationCustomReport
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	6/19/2009	Bret Knoll	Initial Key Creation 
**	07/09/2010	ccarroll		added this note for development build (GenerateSQL)
***************************************************************************************************/



IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_OrganizationCustomReport')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_OrganizationCustomReport'
	ALTER TABLE dbo.OrganizationCustomReport ADD CONSTRAINT PK_OrganizationCustomReport PRIMARY KEY Clustered (OrganizationCustomReportId) 
END
GO