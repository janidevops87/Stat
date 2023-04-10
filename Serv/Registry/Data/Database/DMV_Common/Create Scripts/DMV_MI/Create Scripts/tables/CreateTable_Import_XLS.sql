/******************************************************************************
**		File: CreateTable_Import_XLS.sql
**		Name: Import_XLS
**		Desc: Create table: Import_XLS
**
**		Auth: ccarroll
**		Date: 12/10/2010 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**      12/10/2010	ccarroll			initial
*******************************************************************************/
	PRINT 'Drop All Foreign Keys to Import_XLS'
	WHILE EXISTS(SELECT * FROM sysobjects WHERE id = 
					(SELECT MAX(constid) FROM sysforeignkeys WHERE rkeyid = 
						(SELECT Id FROM sysobjects WHERE name = 'Import_XLS')))
	BEGIN
		DECLARE @sqlScript nvarchar(500), @TableNameId int, @FkId int, @KeyId int, 
			@FkTableName varchar(500), @KeyName varchar(500)

		SELECT @TableNameId = Id FROM sysobjects WHERE name = 'Import_XLS'
		SELECT @FkId = fkeyid, @KeyId = constid FROM sysforeignkeys WHERE rkeyid = @TableNameId
		SELECT @FkTableName = name FROM sysobjects WHERE id = @FkId
		SELECT @KeyName = name FROM sysobjects WHERE id = @KeyId
		
		SET @sqlScript = 'ALTER TABLE ' + @FkTableName + ' DROP CONSTRAINT ' + @KeyName
		EXEC(@sqlScript)
	END				


  IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[Import_XLS]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN
	PRINT 'Creating Table: Import_XLS'
	CREATE TABLE [dbo].[Import_XLS](
		[Import_XLSID] [int] IDENTITY(1,1) NOT NULL,
		[GUID][nvarchar](255) NULL,
		[FirstName] [nvarchar](255) NULL,
		[LastName] [nvarchar](255) NULL,
		[MiddleName] [nvarchar](255) NULL,
		[Address1] [nvarchar](255) NULL,
		[Address2] [nvarchar](255) NULL,
		[City] [nvarchar](255) NULL,
		[State] [nvarchar](255) NULL,
		[Zip] [nvarchar](255) NULL,
		[DateOfBirth] [nvarchar](255) NULL,
	 CONSTRAINT [PK_Import_XLS] PRIMARY KEY NONCLUSTERED 
	(
		[Import_XLSID] ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	) ON [PRIMARY]

END
GRANT SELECT ON Import_XLS TO PUBLIC
	
		-- Add Columns here

GO