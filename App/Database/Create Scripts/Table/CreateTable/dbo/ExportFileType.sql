SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ExportFileType]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ExportFileType](
	[ExportFileTypeID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[ExportFileTypeName] [varchar](30) NULL,
	[LastModified] [smalldatetime] NULL,
	[UpdatedFlag] [smallint] NULL,
	[ExportFileXsltID] [int] NULL,
	[Enabled] [bit] NULL,
	[ExportFileDataTypeID] [int] NULL,
 CONSTRAINT [PK___2__16] PRIMARY KEY CLUSTERED 
(
	[ExportFileTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_ExportFileType_Enabled]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ExportFileType] ADD  CONSTRAINT [DF_ExportFileType_Enabled]  DEFAULT (1) FOR [Enabled]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_ExportFileType_ExportFileDataTypeID_dbo_ExportFileDataType_ExportFileDataTypeID]') AND parent_object_id = OBJECT_ID(N'[dbo].[ExportFileType]'))
ALTER TABLE [dbo].[ExportFileType]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_ExportFileType_ExportFileDataTypeID_dbo_ExportFileDataType_ExportFileDataTypeID] FOREIGN KEY([ExportFileDataTypeID])
REFERENCES [dbo].[ExportFileDataType] ([ExportFileDataTypeID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_ExportFileType_ExportFileDataTypeID_dbo_ExportFileDataType_ExportFileDataTypeID]') AND parent_object_id = OBJECT_ID(N'[dbo].[ExportFileType]'))
ALTER TABLE [dbo].[ExportFileType] CHECK CONSTRAINT [FK_dbo_ExportFileType_ExportFileDataTypeID_dbo_ExportFileDataType_ExportFileDataTypeID]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_ExportFileType_ExportFileXsltID_dbo_ExportFileXslt_ExportFileXsltID]') AND parent_object_id = OBJECT_ID(N'[dbo].[ExportFileType]'))
ALTER TABLE [dbo].[ExportFileType]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_ExportFileType_ExportFileXsltID_dbo_ExportFileXslt_ExportFileXsltID] FOREIGN KEY([ExportFileXsltID])
REFERENCES [dbo].[ExportFileXslt] ([ExportFileXsltID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_ExportFileType_ExportFileXsltID_dbo_ExportFileXslt_ExportFileXsltID]') AND parent_object_id = OBJECT_ID(N'[dbo].[ExportFileType]'))
ALTER TABLE [dbo].[ExportFileType] CHECK CONSTRAINT [FK_dbo_ExportFileType_ExportFileXsltID_dbo_ExportFileXslt_ExportFileXsltID]
GO
