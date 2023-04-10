/***************************************************************************************************
**	Name: Document RequestQueue
**	Desc: 
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	09/30/2019	Pls				Initial Key Creation 
***************************************************************************************************/
IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_DocumentRequestQueue')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_DocumentRequestQueue'
	ALTER TABLE dbo.DocumentRequestQueue ADD CONSTRAINT PK_DocumentRequestQueue PRIMARY KEY Clustered (DocumentRequestQueueId) 
END
GO

IF  NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[DocumentRequestQueue]') AND name = N'IX_DocumentRequestQueue_CallId')
BEGIN
CREATE NONCLUSTERED INDEX [IX_DocumentRequestQueue_CallId]
    ON [dbo].[DocumentRequestQueue]([CallId] ASC) WITH (FILLFACTOR = 90)
    ON [IDX];
END
GO

