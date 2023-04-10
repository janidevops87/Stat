/******************************************************************************
**		File: Alter_dbo.Message_AddConstraint_UniqueCallId.sql
**		Name: Alter dbo.Message_AddConstraint_UniqueCallId
**		Desc: Add Unique Constraint to Message.CallID - after running datafix script
**		Datafix Script Location: https://statlinemtf.sharepoint.com/:u:/r/sites/StatlineDevelopment/Shared%20Documents/Scripts/HS/69798_StatTrac_RemoveMessagesWithSameCallID.sql?csf=1&web=1&e=IB8gMC
**
**		Auth: Mike Berenson
**		Date: 5/18/2020
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**      05/18/2020	Mike Berenson		initial
*******************************************************************************/

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Dbo_Message_Unique_CallId]') AND type = 'UQ')
BEGIN
	ALTER TABLE dbo.[Message] ADD CONSTRAINT [Dbo_Message_Unique_CallId] UNIQUE NONCLUSTERED 
(
	[CallID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
END
GO