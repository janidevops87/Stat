/******************************************************************************
**		File: Script_AddValues_Race.sql
**		Name: Script_AddValues_Race
**		Desc: Add values to Race lookup for DMV and Import tables. 
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
    IF NOT EXISTS (select * from syscolumns where id=object_id('DMV') and name like 'RaceID')
BEGIN
	PRINT 'Adding RaceID column to DMV' 
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
		RaceID int NULL
	
	COMMIT
END


    IF NOT EXISTS (select * from syscolumns where id=object_id('IMPORT') and name like 'RaceDMVCode')
BEGIN
	PRINT 'Adding RaceDMVCode column to Import' 
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
		RaceDMVCode varchar(15) NULL
	
	COMMIT
END

    IF NOT EXISTS (select * from syscolumns where id=object_id('IMPORT_A') and name like 'RaceDMVCode')
BEGIN
	PRINT 'Adding RaceDMVCode column to Import_A' 
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
		RaceDMVCode varchar(15) NULL
	
	COMMIT
END