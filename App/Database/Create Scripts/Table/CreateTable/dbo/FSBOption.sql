SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FSBOption]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[FSBOption](
	[OptionName] [nvarchar](50) NOT NULL,
	[OptionValue] [nvarchar](50) NOT NULL,
	[InsertedBy] [nvarchar](50) NOT NULL,
	[UpdatedBy] [nvarchar](50) NOT NULL,
	[DateInserted] [datetime] NOT NULL,
	[DateUpdated] [datetime] NOT NULL,
 CONSTRAINT [FSBOption_PK] PRIMARY KEY NONCLUSTERED 
(
	[OptionName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__FSBOption__DateI__3BC31D7F]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[FSBOption] ADD  DEFAULT (getdate()) FOR [DateInserted]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__FSBOption__DateU__3CB741B8]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[FSBOption] ADD  DEFAULT (getdate()) FOR [DateUpdated]
END
GO
