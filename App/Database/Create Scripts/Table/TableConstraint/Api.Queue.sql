/******************************************************************************
		**	File: Api.Queue.sql
		**	Name: Api.Queue
		**	Desc: Primary Key of table Api.Queue
		**	Auth: iosipov
		**	Date: 08/14/2017
		*******************************************************************************/
IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_Queue')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_Queue'
	ALTER TABLE Api.Queue ADD CONSTRAINT PK_Queue PRIMARY KEY Clustered (QueueId) --ON Primary
END
GO
IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_Queue_LastModified')
BEGIN
	PRINT 'Creating Default Constraint DF_Queue_LastModified'
	ALTER TABLE Api.Queue ADD CONSTRAINT DF_Queue_LastModified DEFAULT(GetDate()) FOR LastModified
END