/******************************************************************************
**		File: Script_AddColumn_PreviousDonorState.sql
**		Name: Script_AddColumn_PreviousDonorState
**		Desc: Add Previous Donor State for consistancy with common registry. 
**
**		Auth: ccarroll
**		Date: 07/20/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		07/20/2009	ccarroll			initial
*******************************************************************************/
     IF NOT EXISTS (select * from syscolumns where id=object_id('DMV') and name like 'PreviousDonorState%')
BEGIN
	--Add column to DMV table 
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
		PreviousDonorState varchar(50) NULL
	
	COMMIT
END

   IF NOT EXISTS (select * from syscolumns where id=object_id('Import') and name like 'PreviousDonorState%')
BEGIN
	--Add column to Import table 
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
		PreviousDonorState varchar(50) NULL
	
	COMMIT
END