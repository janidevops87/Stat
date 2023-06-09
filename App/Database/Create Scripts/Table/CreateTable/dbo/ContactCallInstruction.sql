SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContactCallInstruction]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ContactCallInstruction](
	[ContactCallInstructionID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[SortOrder] [tinyint] NULL,
	[CallInstruction] [varchar](100) NULL,
	[PersonPhoneID] [int] NULL,
	[LastModified] [datetime] NULL,
	[LastStatEmployeeID] [int] NULL,
	[AuditLogTypeID] [int] NULL,
	[TempCallInstructions] [bit] NULL,
 CONSTRAINT [PK_ContactCallInstruction] PRIMARY KEY CLUSTERED 
(
	[ContactCallInstructionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_ContactCallInstruction_LastModified]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ContactCallInstruction] ADD  CONSTRAINT [DF_ContactCallInstruction_LastModified]  DEFAULT (getdate()) FOR [LastModified]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__ContactCa__TempC__11D96759]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ContactCallInstruction] ADD  DEFAULT ((0)) FOR [TempCallInstructions]
END
GO
