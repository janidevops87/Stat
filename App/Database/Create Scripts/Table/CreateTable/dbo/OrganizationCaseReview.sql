SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OrganizationCaseReview]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[OrganizationCaseReview](
	[OrganizationCaseReviewId] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[OrganizationId] [int] NULL,
	[CaseTypeId] [int] NULL,
	[CaseReviewPercentage] [int] NULL,
	[LastModified] [datetime] NULL,
	[LastStatEmployeeId] [int] NULL,
	[AuditLogTypeId] [int] NULL,
 CONSTRAINT [PK_OrganizationCaseReview] PRIMARY KEY CLUSTERED 
(
	[OrganizationCaseReviewId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_OrganizationCaseReview_LastModified]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[OrganizationCaseReview] ADD  CONSTRAINT [DF_OrganizationCaseReview_LastModified]  DEFAULT (getdate()) FOR [LastModified]
END
GO
