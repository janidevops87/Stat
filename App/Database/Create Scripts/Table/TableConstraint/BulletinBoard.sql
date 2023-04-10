
		/******************************************************************************
		**	File: BulletinBoard(Constraint).sql 
		**	Name: BulletinBoard
		**	Desc: Creates the table BulletinBoard
		**	Auth: ccarroll
		**	Date: 9/13/2010
		*******************************************************************************
		**	Change History
		*******************************************************************************
		**	Date:			Author:			Description:
		**	--------		--------		-------------------------------------------
		**	9/13/2010		ccarroll		Initial Table Creation
		*******************************************************************************/
		-- Alter the table to  Defaults, Primary Keys and Indexes 
		PRINT 'Add Primary Keys, Indexes and Defaults for Table BulletinBoard'
		GO

		IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_BulletinBoard')
		BEGIN
			PRINT 'Creating Primary Key Constraint PK_BulletinBoard'
			ALTER TABLE dbo.BulletinBoard ADD CONSTRAINT PK_BulletinBoard PRIMARY KEY Clustered (BulletinBoardID) 
		END
		GO

		IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_BulletinBoard_LastModified')
		BEGIN
			PRINT 'Creating Default Constraint DF_BulletinBoard_LastModified'
			ALTER TABLE dbo.BulletinBoard ADD CONSTRAINT DF_BulletinBoard_LastModified DEFAULT(GetDate()) FOR LastModified
		END
		GO
	
		IF (SERVERPROPERTY ( 'ProductVersion' ) = '10.0.2531.0')
		BEGIN
			ALTER TABLE BulletinBoard SET (LOCK_ESCALATION = TABLE)
		END

