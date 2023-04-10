 /***************************************************************************************************
**	Name: OrganizationCaseReview
**	Desc: Add Primary keys, Unique keys, and Default Keys to OrganizationCaseReview
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	6/19/2009	Bret Knoll	Initial Key Creation
**	07/09/2010	ccarroll		added this note for development build (GenerateSQL)
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_OrganizationCaseReview')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_OrganizationCaseReview'
	ALTER TABLE dbo.OrganizationCaseReview ADD CONSTRAINT PK_OrganizationCaseReview PRIMARY KEY Clustered (OrganizationCaseReviewId)
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_OrganizationCaseReview_LastModified')
BEGIN
	PRINT 'Creating Default Constraint DF_OrganizationCaseReview_LastModified'
	ALTER TABLE dbo.OrganizationCaseReview ADD CONSTRAINT DF_OrganizationCaseReview_LastModified DEFAULT(GetDate()) FOR LastModified
END
GO
