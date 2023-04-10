/****** Object:  Table [dbo].[QAErrorLogHowIdentified]    Script Date: 04/20/2009 12:46:05 ******/
DELETE FROM [dbo].[QAErrorLogHowIdentified]
GO
/****** Object:  Table [dbo].[QALogos]    Script Date: 04/20/2009 12:46:05 ******/
DELETE FROM [dbo].[QALogos]
GO
/****** Object:  Table [dbo].[QAErrorStatus]    Script Date: 04/20/2009 12:46:05 ******/
DELETE FROM [dbo].[QAErrorStatus]
GO
/****** Object:  Table [dbo].[QATrackingType]    Script Date: 04/20/2009 12:46:05 ******/
DELETE FROM [dbo].[QATrackingType]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 04/20/2009 12:46:05 ******/
--DELETE FROM [dbo].[Roles]
--GO
/****** Object:  Table [dbo].[Roles]    Script Date: 04/20/2009 12:46:05 ******/
SET IDENTITY_INSERT [dbo].[Roles] ON
If not exists (SELECT * FROM Roles WHERE RoleName like 'SL: QA%')
begin
INSERT [dbo].[Roles] ([RoleID], [RoleName], [RoleDescription], [LastStatEmployeeID], [AuditLogTypeID], [LastModified], [Inactive]) VALUES (22, N'SL: QA QM Form - Permission', N'permission to allow users to access the Quality Monitoring Forms tab', 1499, 1, CAST(0x00009BDF00000000 AS DateTime), 0)
INSERT [dbo].[Roles] ([RoleID], [RoleName], [RoleDescription], [LastStatEmployeeID], [AuditLogTypeID], [LastModified], [Inactive]) VALUES (23, N'SL: QA Review - Permission', N'permission to allow users to access the QA Review tab', 1499, 1, CAST(0x00009BDF00000000 AS DateTime), 0)
INSERT [dbo].[Roles] ([RoleID], [RoleName], [RoleDescription], [LastStatEmployeeID], [AuditLogTypeID], [LastModified], [Inactive]) VALUES (24, N'SL: QA Update/Delete - Permission', N'permission to allow users to update and delete records in the QA tab with the exception of the configuration screen.
', 1499, 1, CAST(0x00009BDF00000000 AS DateTime), 0)
INSERT [dbo].[Roles] ([RoleID], [RoleName], [RoleDescription], [LastStatEmployeeID], [AuditLogTypeID], [LastModified], [Inactive]) VALUES (25, N'SL: QA Configuration - Permission', N'permission to allow users to have access to the Configuration screens', 1499, 1, CAST(0x00009BDF00000000 AS DateTime), 0)
INSERT [dbo].[Roles] ([RoleID], [RoleName], [RoleDescription], [LastStatEmployeeID], [AuditLogTypeID], [LastModified], [Inactive]) VALUES (26, N'SL: QA View Other Orgs - Permission', N'permission to view clients besides Statline.  This can only be assigned to Statline employees', 1499, 1, CAST(0x00009BDF00000000 AS DateTime), 0)
INSERT [dbo].[Roles] ([RoleID], [RoleName], [RoleDescription], [LastStatEmployeeID], [AuditLogTypeID], [LastModified], [Inactive]) VALUES (27, N'SL: QA Pending Review - Permission', N'permission shall give the user access to the Pending Review screen', 1499, 1, CAST(0x00009BDF00000000 AS DateTime), 0)
end
SET IDENTITY_INSERT [dbo].[Roles] OFF
/****** Object:  Table [dbo].[QATrackingType]    Script Date: 04/20/2009 12:46:05 ******/
SET IDENTITY_INSERT [dbo].[QATrackingType] ON
INSERT [dbo].[QATrackingType] ([QATrackingTypeID], [OrganizationID], [QATrackingTypeDescription], [LastModified], [LastStatEmployeeID], [AuditLogTypeID]) VALUES (1, 194, convert(text, N'StatTrac' collate SQL_Latin1_General_CP1_CI_AS), NULL, NULL, NULL)
INSERT [dbo].[QATrackingType] ([QATrackingTypeID], [OrganizationID], [QATrackingTypeDescription], [LastModified], [LastStatEmployeeID], [AuditLogTypeID]) VALUES (2, 194, convert(text, N'DonorTrac' collate SQL_Latin1_General_CP1_CI_AS), NULL, NULL, NULL)
INSERT [dbo].[QATrackingType] ([QATrackingTypeID], [OrganizationID], [QATrackingTypeDescription], [LastModified], [LastStatEmployeeID], [AuditLogTypeID]) VALUES (3, 194, convert(text, N'Oasis' collate SQL_Latin1_General_CP1_CI_AS), NULL, NULL, NULL)

SET IDENTITY_INSERT [dbo].[QATrackingType] OFF
/****** Object:  Table [dbo].[QAErrorStatus]    Script Date: 04/20/2009 12:46:05 ******/
SET IDENTITY_INSERT [dbo].[QAErrorStatus] ON
INSERT [dbo].[QAErrorStatus] ([QAErrorStatusID], [QAErrorStatusDescription], [LastModified], [LastStatEmployeeID], [AuditLogTypeID]) VALUES (1, convert(text, N'Pending Review' collate SQL_Latin1_General_CP1_CI_AS), NULL, NULL, NULL)
INSERT [dbo].[QAErrorStatus] ([QAErrorStatusID], [QAErrorStatusDescription], [LastModified], [LastStatEmployeeID], [AuditLogTypeID]) VALUES (2, convert(text, N'Review' collate SQL_Latin1_General_CP1_CI_AS), NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[QAErrorStatus] OFF
/****** Object:  Table [dbo].[QALogos]    Script Date: 04/20/2009 12:46:05 ******/
SET IDENTITY_INSERT [dbo].[QALogos] ON
INSERT [dbo].[QALogos] ([LogoId], [LogoName], [OrganizationID], [TrackingTypeID], [ImageName]) VALUES (1, convert(text, N'StatTrac' collate SQL_Latin1_General_CP1_CI_AS), 194, 1, convert(text, N'statline.jpg' collate SQL_Latin1_General_CP1_CI_AS))
INSERT [dbo].[QALogos] ([LogoId], [LogoName], [OrganizationID], [TrackingTypeID], [ImageName]) VALUES (2, convert(text, N'DonorTrac' collate SQL_Latin1_General_CP1_CI_AS), 194, 2, convert(text, N'donortrac.gif' collate SQL_Latin1_General_CP1_CI_AS))
INSERT [dbo].[QALogos] ([LogoId], [LogoName], [OrganizationID], [TrackingTypeID], [ImageName]) VALUES (3, convert(text, N'Oasis' collate SQL_Latin1_General_CP1_CI_AS), 194, 3, convert(text, N'oasis.jpg' collate SQL_Latin1_General_CP1_CI_AS))
SET IDENTITY_INSERT [dbo].[QALogos] OFF
/****** Object:  Table [dbo].[QAErrorLogHowIdentified]    Script Date: 04/20/2009 12:46:05 ******/
SET IDENTITY_INSERT [dbo].[QAErrorLogHowIdentified] ON
INSERT [dbo].[QAErrorLogHowIdentified] ([QAErrorLogHowIdentifiedID], [QAErrorLogHowIdentifiedDescription], [LastModified], [LastStatEmployeeID], [AuditLogTypeID]) VALUES (1, convert(text, N'Internal' collate SQL_Latin1_General_CP1_CI_AS), NULL, NULL, NULL)
INSERT [dbo].[QAErrorLogHowIdentified] ([QAErrorLogHowIdentifiedID], [QAErrorLogHowIdentifiedDescription], [LastModified], [LastStatEmployeeID], [AuditLogTypeID]) VALUES (2, convert(text, N'External' collate SQL_Latin1_General_CP1_CI_AS), NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[QAErrorLogHowIdentified] OFF
/****** Object:  Table [dbo].[QAMonitoringForm]    Script Date: 07/06/2009 12:46:05 ******/
SET IDENTITY_INSERT [dbo].[QAMonitoringForm] ON
INSERT [dbo].[QAMonitoringForm] ([QAMonitoringFormID], [OrganizationID], [QATrackingTypeID],[QAMonitoringFormName],[QAMonitoringFormCalculateScore],[QAMonitoringFormRequireReview],[QAMonitoringFormActive],[QAMonitoringFormInactiveComments],[QAMonitoringFormScore],[LastModified], [LastStatEmployeeID], [AuditLogTypeID]) VALUES (1, 194,1,convert(text, N'Default Form' collate SQL_Latin1_General_CP1_CI_AS),1,1,1,convert(text, N'Default Form' collate SQL_Latin1_General_CP1_CI_AS),0, getdate(), NULL,1)
SET IDENTITY_INSERT [dbo].[QAMonitoringForm] OFF
/****** Object:  Table [dbo].[QATrackingStatus]    Script Date: 07/06/2009 12:46:05 ******/
SET IDENTITY_INSERT [dbo].[QATrackingStatus] ON
INSERT [dbo].[QATrackingStatus] ([QATrackingStatusID], [QATrackingStatusDescription],[LastModified], [LastStatEmployeeID], [AuditLogTypeID]) VALUES (1,convert(text, N'Default Status' collate SQL_Latin1_General_CP1_CI_AS), getdate(), NULL,1)
SET IDENTITY_INSERT [dbo].[QATrackingStatus] OFF    