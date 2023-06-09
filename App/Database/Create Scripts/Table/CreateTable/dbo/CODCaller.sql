SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CODCaller]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CODCaller](
	[CODCallerID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[CallID] [int] NULL,
	[CODCallerFirst] [varchar](50) NULL,
	[CODCallerLast] [varchar](50) NULL,
	[CODCallerAddress1] [varchar](80) NULL,
	[CODCallerAddress2] [varchar](80) NULL,
	[CODCallerCity] [varchar](30) NULL,
	[StateID] [int] NULL,
	[CODCallerZip] [varchar](5) NULL,
	[OrganizationID] [int] NULL,
	[CODCallerPhone] [varchar](20) NULL,
	[CODCallerLabelStatus] [int] NOT NULL,
	[CODCallPassToCoalition] [int] NULL,
	[CODAdMethod] [int] NULL,
	[CODQuestions] [int] NULL,
	[CODCallerVM] [smallint] NULL,
	[LastModified] [datetime] NULL,
 CONSTRAINT [PK_CODCaller] PRIMARY KEY NONCLUSTERED 
(
	[CODCallerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__CODCaller__LastM__3A242279]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[CODCaller] ADD  DEFAULT (getdate()) FOR [LastModified]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_CODCaller_StateID_dbo_State_StateID]') AND parent_object_id = OBJECT_ID(N'[dbo].[CODCaller]'))
ALTER TABLE [dbo].[CODCaller]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_CODCaller_StateID_dbo_State_StateID] FOREIGN KEY([StateID])
REFERENCES [dbo].[State] ([StateID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_CODCaller_StateID_dbo_State_StateID]') AND parent_object_id = OBJECT_ID(N'[dbo].[CODCaller]'))
ALTER TABLE [dbo].[CODCaller] CHECK CONSTRAINT [FK_dbo_CODCaller_StateID_dbo_State_StateID]
GO
