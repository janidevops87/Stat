/******************************************************************************
**		File: CreateTable_AddrType.sql
**		Name: AddrType
**		Desc: Create table: AddrType
**
**		Auth: ccarroll
**		Date: 02/19/2009 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**      02/19/2009	ccarroll			initial
*******************************************************************************/
  IF EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'AddrType')
	BEGIN
		PRINT 'Table Exists: AddrType updating..'
		/*** Add Table script changes here ***/
		
	END
  ELSE 
	BEGIN
	PRINT 'Creating Table: AddrType'
		CREATE TABLE [dbo].[AddrType](
		[AddrTypeID] [int] IDENTITY(1,1) NOT NULL,
		[Description] [varchar](255) NULL
		)
	END

