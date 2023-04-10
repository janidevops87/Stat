/******************************************************************************
**		File: Script_Add_Column_SendInfoFlag.sql
**		Name: Script_Add_Column_SendInfoFlag
**		Desc: Add columns for SendInfoFlag. Updates DMV and Import tables. 
**
**		Auth: ccarroll
**		Date: 07/16/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		07/16/2009	ccarroll			initial
*******************************************************************************/
  IF NOT EXISTS (select * from syscolumns where id=object_id('DMV') and name like 'SendInfoFlag')
BEGIN
	PRINT 'Adding SendInfoFlag column to DMV' 
	BEGIN TRANSACTION
	SET QUOTED_IDENTIFIER ON
	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
	SET ARITHABORT ON
	SET NUMERIC_ROUNDABORT OFF
	SET CONCAT_NULL_YIELDS_NULL ON
	SET ANSI_NULLS ON
	SET ANSI_PADDING ON
	SET ANSI_WARNINGS ON
	COMMIT
	BEGIN TRANSACTION
	ALTER TABLE dbo.DMV ADD
		SendInfoFlag smallint NULL
	
	COMMIT
END

  IF NOT EXISTS (select * from syscolumns where id=object_id('DMV') and name like 'SendInfoDate')
BEGIN
	PRINT 'Adding SendInfoDate column to DMV' 
	BEGIN TRANSACTION
	SET QUOTED_IDENTIFIER ON
	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
	SET ARITHABORT ON
	SET NUMERIC_ROUNDABORT OFF
	SET CONCAT_NULL_YIELDS_NULL ON
	SET ANSI_NULLS ON
	SET ANSI_PADDING ON
	SET ANSI_WARNINGS ON
	COMMIT
	BEGIN TRANSACTION
	ALTER TABLE dbo.DMV ADD
		SendInfoDate datetime NULL
	
	COMMIT
END

  IF NOT EXISTS (select * from syscolumns where id=object_id('Import') and name like 'SendInfoFlag')
BEGIN
	PRINT 'Adding SendInfoFlag column to Import' 
	BEGIN TRANSACTION
	SET QUOTED_IDENTIFIER ON
	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
	SET ARITHABORT ON
	SET NUMERIC_ROUNDABORT OFF
	SET CONCAT_NULL_YIELDS_NULL ON
	SET ANSI_NULLS ON
	SET ANSI_PADDING ON
	SET ANSI_WARNINGS ON
	COMMIT
	BEGIN TRANSACTION
	ALTER TABLE dbo.Import ADD
		SendInfoFlag smallint NULL
	COMMIT
END


  IF NOT EXISTS (select * from syscolumns where id=object_id('Import_A') and name like 'SendInfoFlag')
BEGIN
	PRINT 'Adding SendInfoFlag column to Import_A' 
	BEGIN TRANSACTION
	SET QUOTED_IDENTIFIER ON
	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
	SET ARITHABORT ON
	SET NUMERIC_ROUNDABORT OFF
	SET CONCAT_NULL_YIELDS_NULL ON
	SET ANSI_NULLS ON
	SET ANSI_PADDING ON
	SET ANSI_WARNINGS ON
	COMMIT
	BEGIN TRANSACTION
	ALTER TABLE dbo.Import_A ADD
		SendInfoFlag varchar(2) NULL
	COMMIT
END
