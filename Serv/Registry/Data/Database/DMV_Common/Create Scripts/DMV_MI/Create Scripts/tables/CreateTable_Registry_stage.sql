 /******************************************************************************
**		File: CreateTable_Registry_stage.sql
**		Name: Registry_stage
**		Desc: Create table: Registry_stage
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
	PRINT 'Drop All Foreign Keys to Registry_stage'
	WHILE EXISTS(SELECT * FROM sysobjects WHERE id = 
					(SELECT MAX(constid) FROM sysforeignkeys WHERE rkeyid = 
						(SELECT Id FROM sysobjects WHERE name = 'Registry_stage')))
	BEGIN
		DECLARE @sqlScript nvarchar(500), @TableNameId int, @FkId int, @KeyId int, 
			@FkTableName varchar(500), @KeyName varchar(500)

		SELECT @TableNameId = Id FROM sysobjects WHERE name = 'Registry_stage'
		SELECT @FkId = fkeyid, @KeyId = constid FROM sysforeignkeys WHERE rkeyid = @TableNameId
		SELECT @FkTableName = name FROM sysobjects WHERE id = @FkId
		SELECT @KeyName = name FROM sysobjects WHERE id = @KeyId
		
		SET @sqlScript = 'ALTER TABLE ' + @FkTableName + ' DROP CONSTRAINT ' + @KeyName
		EXEC(@sqlScript)
	END				


  IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[Registry_stage]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
	BEGIN
	PRINT 'Creating Table: Registry_stage'
		CREATE TABLE [dbo].[Registry_stage](
			[ID] [int] NOT NULL,
			[SSN] [varchar](11) NULL,
			[DOB] [datetime] NULL,
			[FirstName] [varchar](20) NULL,
			[MiddleName] [varchar](20) NULL,
			[LastName] [varchar](20) NULL,
			[Suffix] [varchar](4) NULL,
			[Gender] [varchar](1) NULL,
			[Race] [int] NULL,
			[EyeColor] [varchar](5) NULL,
			[Phone] [varchar](10) NULL,
			[Comment] [varchar](200) NULL,
			[DMVID] [int] NULL,
			[License] [varchar](9) NULL,
			[DMVDonor] [bit] NOT NULL,
			[Donor] [bit] NOT NULL,
			[DonorConfirmed] [bit] NOT NULL,
			[SourceCode] [varchar](10) NULL,
			[OnlineRegDate] [datetime] NULL,
			[SignatureDate] [datetime] NULL,
			[MailerDate] [datetime] NULL,
			[DeleteFlag] [bit] NOT NULL,
			[DeleteDate] [datetime] NULL,
			[DeletedByID] [int] NULL,
			[UserID] [int] NULL,
			[LastModified] [datetime] NULL,
			[CreateDate] [datetime] NULL,
			[DeceasedDate] [datetime] NULL,
			[InfoSource] [int] NULL,
			[InfoSourceDesc] [varchar](25) NULL,
			[WitnessType1] [int] NULL,
			[WitnessType2] [int] NULL,
			[Religion] [int] NULL,
			[Newsletter] [bit] NULL,
			[Active] [bit] NULL,
			[Addr1] [varchar](40) NULL,
			[Addr2] [varchar](20) NULL,
			[City] [varchar](25) NULL,
			[Zip] [varchar](10) NULL
		) ON [PRIMARY]
	END
	
	GRANT SELECT ON Registry_stage TO PUBLIC
	
		-- check if GUID exists
		IF NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[Registry_stage]')
			AND syscolumns.name = 'GUID'
			)
		BEGIN
			PRINT 'ALTERING TABLE Registry_stage Adding Column GUID'
			ALTER TABLE Registry_stage
				ADD [GUID] uniqueidentifier NULL
		END



GO