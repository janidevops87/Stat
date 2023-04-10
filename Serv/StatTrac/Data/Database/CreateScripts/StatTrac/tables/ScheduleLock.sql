	BEGIN TRANSACTION
		SET QUOTED_IDENTIFIER ON
		SET ARITHABORT ON
		SET NUMERIC_ROUNDABORT OFF
		SET CONCAT_NULL_YIELDS_NULL ON
		SET ANSI_NULLS ON
		SET ANSI_PADDING OFF
		SET ANSI_WARNINGS ON

		/*	ccarroll 10/07/2008 - StatTrac 8.4.7 release
			ScheduleLock
			This script creates the table ScheduleLock. ScheduleLock is used to keep track of StatTrac users
			currently making schedule changes.
		*/
			

	COMMIT

	BEGIN TRANSACTION

	/* Create Table: ScheduleLock(if not existing) */
		IF EXISTS (SELECT * FROM dbo.sysobjects WHERE ID = OBJECT_ID(N'[dbo].[ScheduleLock]')
				AND OBJECTPROPERTY(ID,N'IsTable') = 1)
			BEGIN
				PRINT 'ScheduleLock Table exists..'
			END

		ELSE
			BEGIN
				PRINT 'Creating Table: ScheduleLock'
				
				CREATE TABLE [dbo].[ScheduleLock](
					[ScheduleGroupID] [int] NOT NULL,
					[StatEmployeeID] [int] NULL,
					[LastModified] [datetime] NULL CONSTRAINT [DF_ScheduleLock_LastModified] DEFAULT GetDate(),
					 CONSTRAINT [PK_ScheduleLock_1_1] PRIMARY KEY CLUSTERED 
					(
						[ScheduleGroupID] ASC
					)--WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
					) ON [PRIMARY]
			END
			
	COMMIT
