/******************************************************************************
**		File: CreateNewReportRowsAndPermissions.sql
**		Name: Create new report rows for new portal site and 
				permissions based off of the permissions for the old reporting site
**		Desc: Create new report rows for new portal site and 
				permissions based off of the permissions for the old reporting site
**
**		Auth: Pam Scheichenost	
**		Date: 12/30/2020
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**      12/30/2020	Pam Scheichenost	initial
*******************************************************************************/

DECLARE
@ModifiedDate datetime = GetDate(),
@ReportFolder nvarchar(50) = '/CCRST307ReportingSiteRedesign'; --TODO: Will need to find out report folder for training/production

IF ((SELECT COUNT(*) FROM dbo.Report WHERE ReportId >= 300) = 0)
BEGIN
SET IDENTITY_INSERT dbo.Report ON;

INSERT INTO dbo.Report 
(ReportId, ReportDisplayName, LastModified, ReportVirtualURL, ReportTypeID, SourceCodeTypeId) 
VALUES 
(300,'Actionable Designation Volume by Event',@ModifiedDate, @ReportFolder + '/ActionableDesignationVolumeByEvent',11,NULL),
(301,'Actionable Designation Volume by Status',@ModifiedDate, @ReportFolder + '/ActionableDesignationVolumeByStatus',11,NULL),
(302,'Actionable Designation Volume by Zip Code',@ModifiedDate, @ReportFolder + '/ActionableDesignationVolumeByZipCode',11,NULL),
(303,'Age Demographics',@ModifiedDate, @ReportFolder + '/AgeDemographics',8,NULL),
(304,'Alerts',@ModifiedDate, @ReportFolder + '/Alerts',9,NULL),
(305,'Approach Outcome',@ModifiedDate, @ReportFolder + '/ApproachPersonOutcome',8,1),
(306,'Billable Count Summary',@ModifiedDate, @ReportFolder + '/Billable Count Summary',8,NULL),
(308,'Hospital Affiliations',@ModifiedDate, @ReportFolder + '/HospitalAffiliations',9,NULL),
(309,'Import Offer Activity',@ModifiedDate, @ReportFolder + '/ImportOfferActivity',3,4),
(310,'Import Offer Audit Trail',@ModifiedDate, @ReportFolder + '/AuditTrailImportOffer',3,NULL),
(311,'Import Offer Detail',@ModifiedDate, @ReportFolder + '/ImportOfferDetail',3,4),
(312,'Initial Approacher Summary',@ModifiedDate, @ReportFolder + '/InitialApproacherSummary',8,1),
(313,'Message Activity',@ModifiedDate, @ReportFolder + '/MessageActivity',2,2),
(314,'Message Audit Trail',@ModifiedDate, @ReportFolder + '/AuditTrailMessage',2,NULL),
(315,'Message Detail',@ModifiedDate, @ReportFolder + '/MessageDetail',2,2),
(316,'Organization People',@ModifiedDate, @ReportFolder + '/OrganizationPeople',9,NULL),
(317,'Outbound Electronic Communication',@ModifiedDate, @ReportFolder + '/AlphaPageMonitor',9,NULL),
(318,'Outcome by Category',@ModifiedDate, @ReportFolder + '/OutcomeByCategory',8,1),
(319,'Pending Referrals',@ModifiedDate, @ReportFolder + '/PendingReferrals',1,1),
(320,'Personnel Listing',@ModifiedDate, @ReportFolder + '/OrganizationPersonnelListing',9,NULL),
(328,'Referral Activity',@ModifiedDate, @ReportFolder + '/ReferralActivity',1,1),
(329,'Referral Audit Trail',@ModifiedDate, @ReportFolder + '/AuditTrailReferral',1,NULL),
(330,'Referral Detail',@ModifiedDate, @ReportFolder + '/ReferralDetail',1,1),
(331,'Referral Detail Extended 2004 FTP',@ModifiedDate, @ReportFolder + '/ReferralDetail_Ftp',10,NULL),
(332,'Referral Detail Extended 2006 FTP',@ModifiedDate, @ReportFolder + '/ReferralDetail_Ftp',10,NULL),
(333,'Referral Detail FTP',@ModifiedDate, @ReportFolder + '/ReferralDetail_Ftp',10,NULL),
(334,'Referral Outcome',@ModifiedDate, @ReportFolder + '/ReferralOutcome',1,1),
(335,'Report Group Organizations',@ModifiedDate, @ReportFolder + '/Organizations',9,NULL),
(336,'Schedule Lookup',@ModifiedDate, @ReportFolder + '/ScheduleLookup',7,NULL),
(339,'Timely Referral',@ModifiedDate, @ReportFolder + '/HospitalReportTime',8,NULL),
(340,'Processor Number',@ModifiedDate, @ReportFolder + '/ProcessorNumber',1,1),
(342,'Appropriate Referrals by Facility',@ModifiedDate, @ReportFolder + '/AppropriateReferrals',8,NULL),
(343,'Screening Criteria - Triage',@ModifiedDate, @ReportFolder + '/ScreeningCriteria_Triage',9,NULL),
(344,'Screening Criteria - Secondary',@ModifiedDate, @ReportFolder + '/ScreeningCriteria_Secondary',9,NULL);

SET IDENTITY_INSERT dbo.Report OFF;
END

IF ((SELECT COUNT(*) FROM dbo.ReportControl WHERE ReportControlId >= 100) = 0)
BEGIN
	SET IDENTITY_INSERT dbo.ReportControl ON;

	INSERT INTO dbo.ReportControl
	(ReportControlID, ReportControlName, ReportParamSectionID)
	VALUES
	(100, 'customParamsActionableDesignationByEvent', 1),
	(101, 'customParamsActionableDesignationByStatus', 1),
	(102, 'customParamsActionableDesignationByZipCode', 1),
	(103, 'customParamsAlert', 1),
	(104, 'customParamsImportOfferActivity', 1),
	(105, 'customParamsImportStattracUser', 1),
	(106, 'customParamsImportEventLog', 1),
	(107, 'customParamsMessageActivity', 1),
	(108, 'customParamsMessageStattracUser', 1),
	(109, 'customParamsMessageEvent', 1),
	(110, 'customParamsQA', 1),
	(111, 'customParamsQAApproved', 1),
	(112, 'customParamsQAByCapa', 1),
	(113, 'customParamsQAByError', 1),
	(114, 'customParamsTrackingNumberAndTypeControl', 1),
	(115, 'customParamsQAFormsCompletedBy', 1),
	(116, 'customParamsQAScoreByEmployee', 1),
	(117, 'customParamsReferralActivity', 1),
	(118, 'customParamsReferralStatTracUser', 1),
	(119, 'customParamsReferralDetail', 1),
	(120, 'customParamsReferralOutcome', 1),
	(121, 'cbxHideIdentifyingInfo', 5),
	(122, 'rbtTimeZone', 2),
	(123, 'customParamsStartEndMonthYear', 1),
	(124, 'customParamsHoursBack', 1),
	(125, 'customParamsOrganizationType', 1),
	(126, 'customParams2004ExtendedFTPReports', 1),
	(127, 'customParamsPersonnelListing', 1)

	SET IDENTITY_INSERT dbo.ReportControl OFF;
END


IF ((SELECT COUNT(*) FROM dbo.ReportDateTimeConfiguration WHERE ReportId >= 300) = 0)
BEGIN
	SET IDENTITY_INSERT dbo.ReportDateTimeConfiguration ON;

	INSERT INTO dbo.ReportDateTimeConfiguration
	(ReportDateTimeConfigurationID, ReportID, ReportDateTimeID, IsArchived, IsDateOnly)
	VALUES
	(100, 300, 1, 0, 0),
	(101, 301, 1, 0, 0),
	(102, 302, 1, 0, 0),
	(103, 305, 1, 1, 0),
	(104, 306, 1, 0, 1),
	(105, 309, 2, 0, 0),
	(106, 310, 4, 0, 0),
	(107, 311, 2, 1, 0),
	(108, 312, 1, 1, 0),
	(109, 313, 2, 0, 0),
	(110, 314, 4, 0, 0),
	(111, 315, 2, 1, 0),
	(112, 318, 1, 1, 0),
	(113, 319, 2, 1, 0),
	(121, 328, 2, 1, 0),
	(122, 329, 4, 0, 0),
	(123, 330, 4, 1, 0),
	(124, 334, 2, 1, 0),
	(125, 336, 1, 0, 0),
	(126, 340, 1, 1, 0),
	(127, 331, 2, 1, 0),
	(128, 332, 2, 1, 0),
	(129, 333, 2, 1, 0)

	SET IDENTITY_INSERT dbo.ReportDateTimeConfiguration OFF;
END

IF ((SELECT COUNT(*) FROM dbo.ReportDateTypeConfiguration WHERE ReportId >= 300) = 0)
BEGIN
	SET IDENTITY_INSERT dbo.ReportDateTypeConfiguration ON;

	INSERT INTO dbo.ReportDateTypeConfiguration
	(ReportDateTypeConfigurationID, ReportID, ReportDateTypeID, ReportDateTypeConfigurationIsDefault)
	VALUES
	(100, 300, 4, 100),
	(101, 301, 4, 101),
	(102, 302, 4, 102),
	(103, 305, 1, 103),
	(104, 306, 1, 104),
	(105, 309, 5, 105),
	(106, 310, 3, 106),
	(107, 311, 5, 107),
	(108, 312, 1, 108),
	(109, 313, 6, 109),
	(110, 314, 3, 110),
	(111, 315, 6, 111),
	(112, 318, 1, 112),
	(113, 319, 1, 113),
	(128, 328, 1, 128),
	(129, 328, 2, 129),
	(130, 329, 3, 130),
	(131, 330, 1, 131),
	(132, 330, 2, 132),
	(133, 334, 1, 133),
	(134, 334, 2, 134),
	(135, 336, 8, 135),
	(136, 340, 1, 136),
	(137, 331, 1, 137),
	(138, 332, 1, 138),
	(139, 333, 1, 139)

	SET IDENTITY_INSERT dbo.ReportDateTypeConfiguration OFF;
END

IF ((SELECT COUNT(*) FROM dbo.ReportParamConfiguration WHERE ReportId >= 300) = 0)
BEGIN
	SET IDENTITY_INSERT dbo.ReportParamConfiguration ON;

	INSERT INTO dbo.ReportParamConfiguration
	(ReportParamConfiguration, ReportId, ReportControlId)
	VALUES
	(900, 300, 1),
	(901, 300, 2),
	(902, 300, 3),
	(903, 300, 100),
	(904, 301, 101),
	(905, 301, 1),
	(906, 301, 2),
	(907, 301, 3),
	(908, 302, 102),
	(909, 302, 1),
	(910, 302, 2),
	(911, 302, 3),
	(912, 304, 103),
	(913, 304, 6),
	(914, 305, 1),
	(915, 305, 2),
	(916, 305, 3),
	(917, 305, 4),
	(918, 305, 5),
	(919, 305, 6),
	(920, 305, 7),
	(921, 305, 8),
	(922, 305, 9),
	(923, 305, 10),
	(924, 305, 11),
	(925, 305, 122),
	(929, 306, 1),
	(930, 306, 2),
	(931, 306, 3),
	(932, 306, 4),
	(933, 306, 6),
	(934, 306, 5),
	(935, 306, 39),
	(936, 309, 104),
	(937, 309, 1),
	(938, 309, 2),
	(939, 309, 3),
	(940, 309, 4),
	(941, 309, 6),
	(942, 309, 11),
	(943, 309, 122),
	(947, 310, 105),
	(948, 310, 1),
	(949, 310, 2),
	(950, 310, 3),
	(951, 310, 11),
	(956, 311, 106),
	(957, 311, 1),
	(958, 311, 2),
	(959, 311, 3),
	(960, 311, 4),
	(961, 311, 6),
	(962, 311, 11),
	(963, 311, 122),
	(967, 312, 46),
	(968, 312, 1),
	(969, 312, 2),
	(970, 312, 3),
	(971, 312, 4),
	(973, 312, 6),
	(974, 312, 11),
	(975, 312, 122),
	(979, 313, 107),
	(980, 313, 1),
	(981, 313, 2),
	(982, 313, 3),
	(983, 313, 4),
	(984, 313, 6),
	(985, 313, 11),
	(986, 313, 122),
	(990, 314, 108),
	(991, 314, 1),
	(992, 314, 2),
	(993, 314, 3),
	(994, 314, 11),
	(995, 314, 122),
	(999, 315, 109),
	(1000, 315, 1),
	(1001, 315, 2),
	(1002, 315, 3),
	(1003, 315, 4),
	(1004, 315, 6),
	(1005, 315, 11),
	(1006, 315, 122),
	(1012, 318, 1),
	(1013, 318, 2),
	(1014, 318, 3),
	(1015, 318, 4),
	(1016, 318, 5),
	(1017, 318, 6),
	(1018, 318, 122),
	(1020, 319, 34),
	(1021, 319, 1),
	(1022, 319, 2),
	(1023, 319, 3),
	(1024, 319, 4),
	(1025, 319, 5),
	(1026, 319, 6),
	(1027, 319, 7),
	(1028, 319, 8),
	(1029, 319, 9),
	(1030, 319, 10),
	(1031, 319, 11),
	(1032, 319, 121),
	(1033, 319, 122),
	(1107, 328, 117),
	(1108, 328, 1),
	(1109, 328, 2),
	(1110, 328, 3),
	(1111, 328, 4),
	(1112, 328, 5),
	(1113, 328, 6),
	(1114, 328, 7),
	(1115, 328, 8),
	(1116, 328, 9),
	(1117, 328, 10),
	(1118, 328, 11),
	(1119, 328, 121),
	(1120, 328, 122),
	(1125, 329, 118),
	(1126, 329, 1),
	(1127, 329, 2),
	(1128, 329, 3),
	(1129, 329, 4),
	(1130, 329, 11),
	(1131, 329, 121),
	(1132, 329, 122),
	(1140, 330, 119),
	(1141, 330, 1),
	(1142, 330, 2),
	(1143, 330, 3),
	(1144, 330, 4),
	(1145, 330, 5),
	(1146, 330, 6),
	(1147, 330, 7),
	(1148, 330, 8),
	(1149, 330, 9),
	(1150, 330, 10),
	(1151, 330, 11),
	(1152, 330, 121),
	(1153, 330, 122),
	(1161, 334, 120),
	(1162, 334, 1),
	(1163, 334, 2),
	(1164, 334, 3),
	(1165, 334, 4),
	(1166, 334, 5),
	(1167, 334, 6),
	(1168, 334, 7),
	(1169, 334, 8),
	(1170, 334, 9),
	(1171, 334, 10),
	(1172, 334, 11),
	(1173, 334, 121),
	(1174, 334, 122),
	(1181, 336, 48),
	(1182, 336, 1),
	(1183, 336, 2),
	(1184, 336, 3),
	(1185, 336, 11),
	(1186, 336, 122),
	(1190, 340, 28),
	(1191, 340, 1),
	(1192, 340, 2),
	(1193, 340, 3),
	(1194, 340, 4),
	(1195, 340, 5),
	(1196, 340, 6),
	(1197, 340, 11),
	(1198, 340, 121),
	(1199, 340, 122),
	(1200, 303, 123),
	(1201, 303, 4),
	(1202, 303, 5),
	(1203, 308, 5),
	(1204, 316, 4),
	(1205, 316, 5),
	(1206, 317, 124),
	(1208, 320, 127),
	(1209, 320, 11),
	(1210, 335, 4),
	(1211, 335, 125),
	(1212, 339, 123),
	(1213, 339, 4),
	(1214, 339, 5),
	(1215, 331, 126),
	(1216, 331, 1),
	(1217, 331, 40),
	(1218, 331, 41),
	(1219, 331, 4),
	(1220, 331, 5),
	(1221, 331, 11),
	(1222, 332, 126),
	(1223, 332, 1),
	(1224, 332, 40),
	(1225, 332, 41),
	(1226, 332, 4),
	(1227, 332, 5),
	(1228, 332, 11),
	(1229, 333, 126),
	(1230, 333, 1),
	(1231, 333, 40),
	(1232, 333, 41),
	(1233, 333, 4),
	(1234, 333, 5),
	(1235, 333, 11),
	(2237, 343, 5),
	(2238, 344, 5),
	(2258, 342, 4),
	(2259, 342, 5),
	(2260, 342, 123)

	SET IDENTITY_INSERT dbo.ReportParamConfiguration OFF;
END

IF ((SELECT COUNT(*) FROM dbo.ReportSortType WHERE ReportSortTypeId >= 77) = 0)
BEGIN
	SET IDENTITY_INSERT dbo.ReportSortType ON;

	INSERT INTO dbo.ReportSortType
	(ReportSortTypeID, ReportSortTypeName, ReportSortTypeDisplayname)
	VALUES
	(77, 'ReferralApproachTypeId', 'Approach Type')
SET IDENTITY_INSERT dbo.ReportSortType OFF;
END

--Fix 2 existing sort types that are broken in old and new
UPDATE ReportSortType
SET ReportSortTypeName = 'InitialPreReferral'
WHERE ReportSortTypeID = 43;

UPDATE ReportSortType
SET ReportSortTypeName = 'RegistryApproach',
	ReportSortTypeDisplayname = '# Registry Approach'
WHERE ReportSortTypeID = 55

update ReportSortType
Set ReportSortTypeDisplayname = 'Based on D/T'
WHERE ReportSortTypeID = 11;



IF ((SELECT COUNT(*) FROM dbo.ReportSortTypeConfiguration WHERE ReportId >= 300) = 0)
BEGIN
	SET IDENTITY_INSERT dbo.ReportSortTypeConfiguration ON;

	INSERT INTO dbo.ReportSortTypeConfiguration
	(ReportSortTypeConfigurationID, ReportID, ReportSortTypeID)
	VALUES
	(300, 305, 29),
	(301, 305, 30),
	(302, 305, 31),
	(303, 305, 32),
	--(304, 305, 33),  --removing security for alerts for now, we will not be displaying in new site for now
	(305, 305, 34),
	(306, 305, 35),
	(307, 309, 56),
	(308, 309, 37),
	(309, 309, 39),
	(310, 309, 40),
	(311, 310, 16),
	(312, 310, 17),
	(313, 310, 18),
	(314, 311, 36),
	(315, 311, 37),
	(316, 311, 38),
	(317, 311, 2),
	(318, 312, 41),
	(319, 312, 42),
	(320, 312, 43),
	(321, 312, 55),
	(322, 313, 56),
	(323, 313, 37),
	(324, 313, 39),
	(325, 313, 40),
	(326, 314, 16),
	(327, 314, 17),
	(328, 314, 18),
	(329, 315, 36),
	(330, 315, 37),
	(331, 315, 39),
	(332, 315, 2),
	(333, 319, 44),
	(334, 319, 26),
	(335, 319, 27),
	(336, 319, 13),
	(337, 319, 1),
	(338, 319, 56),
	(380, 328, 36),
	(381, 328, 27),
	(382, 328, 1),
	(383, 328, 44),
	(384, 328, 51),
	(385, 328, 13),
	(386, 329, 16),
	(387, 329, 17),
	(388, 329, 18),
	(389, 330, 10),
	(390, 330, 11),
	(391, 330, 12),
	(392, 330, 13),
	(393, 330, 14),
	(394, 330, 15),
	(395, 334, 10),
	(396, 334, 15),
	(397, 334, 14),
	(398, 334, 26),
	(399, 334, 27),
	(400, 334, 28),
	(401, 334, 13),
	(402, 334, 1),
	(403, 336, 52),
	(404, 336, 53),
	(405, 336, 54),
	(406, 340, 24),
	(407, 340, 25),
	(408, 340, 1),
	(409, 320, 20),
	(410, 320, 19),
	(411, 331, 11),
	(412, 331, 12),
	(413, 331, 22),
	(414, 331, 44),
	(415, 331, 77),
	(416, 332, 11),
	(417, 332, 12),
	(418, 332, 22),
	(419, 332, 44),
	(420, 332, 77),
	(421, 333, 11),
	(422, 333, 12),
	(423, 333, 22),
	(424, 333, 44),
	(425, 333, 77)

SET IDENTITY_INSERT dbo.ReportSortTypeConfiguration OFF;
END

--removed sort type configuration that isn't configured for report on old site.
delete from ReportSortTypeConfiguration
where ReportSortTypeConfigurationID = 67;


--start of report permissions
DECLARE @Reports TABLE(
NewReportId int,
OldReportId int,
RoleId int
)

INSERT INTO @Reports VALUES
(300,205, 69),
(301,207, 70),
(302,208, 71),
(303,55, 72),
--(304,215, 73),  --removing security for alerts for now, we will not be displaying in new site for now
(305,212, 74),
(306,211, 75),
(308,116, 76),
(309,224, 77),
(310,200, 78),
(311,213, 79),
(312,218, 80),
(313,225, 81),
(314,201, 82),
(315,214, 83),
(316,132, 84),
(317,187, 85),
(318,219, 86),
(319,220, 87),
(320,82, 88),
(328,222, 89),
(329,204, 90),
(330,209, 91),
(331,184, 92),
(332,194, 93),
(333,131, 94),
(334,210, 95),
(335,76, 96),
(336,223, 97),
(339,68, 98),
(340,206, 99),
(342,50, 101),
(343,117, 102),
(344,148, 103)






SET IDENTITY_INSERT dbo.Roles ON;

insert into dbo.Roles
(RoleID, RoleName, RoleDescription, LastStatEmployeeID, AuditLogTypeID,LastModified, Inactive)
SELECT 
r.RoleId, 'Report Portal: ' + rep.ReportDisplayName, 'Access to ' + rep.ReportDisplayName + ' report.', 1564, 1 , GetDate(), 0
FROM @Reports r
INNER JOIN Report rep on r.NewReportId = rep.ReportID
WHERE NOT EXISTS (SELECT * FROM Roles ex WHERE r.RoleId = ex.RoleId)


SET IDENTITY_INSERT dbo.Roles OFF;



--create new records for new reports that match old reports
INSERT INTO dbo.ReportRule
	(ReportID, RoleID, LastStatEmployeeID, LastModified)
select r.NewReportId, rr.RoleID, 1564, GETDATE()
FROM @Reports r
INNER JOIN ReportRule rr on r.OldReportId = rr.ReportID 
WHERE NOT EXISTS (SELECT * FROM ReportRule ext where ext.RoleID = rr.RoleID and ext.ReportID = r.NewReportId);



--insert reports to new roles
INSERT INTO dbo.ReportRule
	(ReportID, RoleID, LastStatEmployeeID, LastModified)
select r.NewReportId, r.RoleId, 1564, GetDate()
from @Reports r
WHERE NOT EXISTS (SELECT * FROM ReportRule ex WHERE r.NewReportId = ex.ReportID AND r.RoleId = ex.RoleID)


----add certain reports to AdminUser role
IF ((SELECT COUNT(*) FROM ReportRule Where RoleId = 3 AND ReportId in (308,317,320,335,343,344)) = 0)
BEGIN
	INSERT INTO dbo.ReportRule
		(ReportID, RoleID, LastStatEmployeeID, LastModified)
	values
	(308, 3, 1564, GetDate()),
	(317, 3, 1564, GetDate()),
	(320, 3, 1564, GetDate()),
	(335, 3, 1564, GetDate()),
	(343, 3, 1564, GetDate()),
	(344, 3, 1564, GetDate())
END



--Actionable Designation Volume by Event
DECLARE
@OldReportId int = 205

IF ((SELECT COUNT(*) FROM UserRoles ur INNER JOIN @Reports r on ur.RoleId = r.RoleId AND r.OldReportId = @OldReportId) = 0)
BEGIN
INSERT INTO UserRoles
(WebPersonID, RoleId, LastStatEmployeeID, AuditLogTypeID, LastModified)
select 
	wpp.WEBPERSONID,
	r.RoleId,
	1564,
	1,
	GETDATE()
from WebPersonPermission wpp
inner join WebPerson wp on wpp.WEBPERSONID = wp.WebPersonID
inner join Permission p on wpp.PERMISSIONID = p.permissionId
INNER JOIN @Reports r ON p.FUNCTIONID = r.OldReportId
WHERE FUNCTIONID = @OldReportId
AND NOT EXISTS (SELECT * FROM UserRoles ur WHERE ur.RoleID in (3,9) AND ur.WebPersonID = wpp.WEBPERSONID)  -- don't insert rows for those that exists in these roles
AND NOT EXISTS (SELECT * FROM UserRoles ext WHERE r.RoleId = ext.RoleID AND wpp.WEBPERSONID = ext.WebPersonID);  -- this is to make sure it doesn't get inserted again if scripts are ran
END


--Actionable Designation Volume by Status
SELECT
@OldReportId = 207

IF ((SELECT COUNT(*) FROM UserRoles ur INNER JOIN @Reports r on ur.RoleId = r.RoleId AND r.OldReportId = @OldReportId) = 0)
BEGIN
INSERT INTO UserRoles
(WebPersonID, RoleId, LastStatEmployeeID, AuditLogTypeID, LastModified)
select 
	wpp.WEBPERSONID,
	r.RoleId,
	1564,
	1,
	GETDATE()
from WebPersonPermission wpp
inner join WebPerson wp on wpp.WEBPERSONID = wp.WebPersonID
inner join Permission p on wpp.PERMISSIONID = p.permissionId
INNER JOIN @Reports r ON p.FUNCTIONID = r.OldReportId
WHERE FUNCTIONID = @OldReportId
AND NOT EXISTS (SELECT * FROM UserRoles ur WHERE ur.RoleID in (3,9) AND ur.WebPersonID = wpp.WEBPERSONID);
END



--Actionable Designation Volume by Zip Code
SELECT
@OldReportId = 208

IF ((SELECT COUNT(*) FROM UserRoles ur INNER JOIN @Reports r on ur.RoleId = r.RoleId AND r.OldReportId = @OldReportId) = 0)
BEGIN
INSERT INTO UserRoles
(WebPersonID, RoleId, LastStatEmployeeID, AuditLogTypeID, LastModified)
select 
	wpp.WEBPERSONID,
	r.RoleId,
	1564,
	1,
	GETDATE()
from WebPersonPermission wpp
inner join WebPerson wp on wpp.WEBPERSONID = wp.WebPersonID
inner join Permission p on wpp.PERMISSIONID = p.permissionId
INNER JOIN @Reports r ON p.FUNCTIONID = r.OldReportId
WHERE FUNCTIONID = @OldReportId
AND NOT EXISTS (SELECT * FROM UserRoles ur WHERE ur.RoleID in (3,9) AND ur.WebPersonID = wpp.WEBPERSONID);
END



--Age Demographics
SELECT
@OldReportId = 55

IF ((SELECT COUNT(*) FROM UserRoles ur INNER JOIN @Reports r on ur.RoleId = r.RoleId AND r.OldReportId = @OldReportId) = 0)
BEGIN
INSERT INTO UserRoles
(WebPersonID, RoleId, LastStatEmployeeID, AuditLogTypeID, LastModified)
select 
	wpp.WEBPERSONID,
	r.RoleId,
	1564,
	1,
	GETDATE()
from WebPersonPermission wpp
inner join WebPerson wp on wpp.WEBPERSONID = wp.WebPersonID
inner join Permission p on wpp.PERMISSIONID = p.permissionId
INNER JOIN @Reports r ON p.FUNCTIONID = r.OldReportId
WHERE FUNCTIONID = @OldReportId;
END


--Approach Outcome
SELECT
@OldReportId = 212

IF ((SELECT COUNT(*) FROM UserRoles ur INNER JOIN @Reports r on ur.RoleId = r.RoleId AND r.OldReportId = @OldReportId) = 0)
BEGIN
INSERT INTO UserRoles
(WebPersonID, RoleId, LastStatEmployeeID, AuditLogTypeID, LastModified)
select 
	wpp.WEBPERSONID,
	r.RoleId,
	1564,
	1,
	GETDATE()
from WebPersonPermission wpp
inner join WebPerson wp on wpp.WEBPERSONID = wp.WebPersonID
inner join Permission p on wpp.PERMISSIONID = p.permissionId
INNER JOIN @Reports r ON p.FUNCTIONID = r.OldReportId
WHERE FUNCTIONID = @OldReportId
AND NOT EXISTS (SELECT * FROM UserRoles ur WHERE ur.RoleID in (3,12) AND ur.WebPersonID = wpp.WEBPERSONID);
END



--Billable Count Summary
SELECT
@OldReportId = 211


IF ((SELECT COUNT(*) FROM UserRoles ur INNER JOIN @Reports r on ur.RoleId = r.RoleId AND r.OldReportId = @OldReportId) = 0)
BEGIN
INSERT INTO UserRoles
(WebPersonID, RoleId, LastStatEmployeeID, AuditLogTypeID, LastModified)
select 
	wpp.WEBPERSONID,
	r.RoleId,
	1564,
	1,
	GETDATE()
from WebPersonPermission wpp
inner join WebPerson wp on wpp.WEBPERSONID = wp.WebPersonID
inner join Permission p on wpp.PERMISSIONID = p.permissionId
INNER JOIN @Reports r ON p.FUNCTIONID = r.OldReportId
WHERE FUNCTIONID = @OldReportId
AND NOT EXISTS (SELECT * FROM UserRoles ur WHERE ur.RoleID in (3,13) AND ur.WebPersonID = wpp.WEBPERSONID);
END


--Hospital Affiliations
SELECT
@OldReportId = 116

IF ((SELECT COUNT(*) FROM UserRoles ur INNER JOIN @Reports r on ur.RoleId = r.RoleId AND r.OldReportId = @OldReportId) = 0)
BEGIN
INSERT INTO UserRoles
(WebPersonID, RoleId, LastStatEmployeeID, AuditLogTypeID, LastModified)
select 
	wpp.WEBPERSONID,
	r.RoleId,
	1564,
	1,
	GETDATE()
from WebPersonPermission wpp
inner join WebPerson wp on wpp.WEBPERSONID = wp.WebPersonID
inner join Permission p on wpp.PERMISSIONID = p.permissionId
INNER JOIN @Reports r ON p.FUNCTIONID = r.OldReportId
WHERE FUNCTIONID = @OldReportId
AND NOT EXISTS (SELECT * FROM UserRoles ur WHERE ur.RoleID in (3) AND ur.WebPersonID = wpp.WEBPERSONID);
END


--Import Offer Activity
SELECT
@OldReportId = 224


IF ((SELECT COUNT(*) FROM UserRoles ur INNER JOIN @Reports r on ur.RoleId = r.RoleId AND r.OldReportId = @OldReportId) = 0)
BEGIN
INSERT INTO UserRoles
(WebPersonID, RoleId, LastStatEmployeeID, AuditLogTypeID, LastModified)
select 
	wpp.WEBPERSONID,
	r.RoleId,
	1564,
	1,
	GETDATE()
from WebPersonPermission wpp
inner join WebPerson wp on wpp.WEBPERSONID = wp.WebPersonID
inner join Permission p on wpp.PERMISSIONID = p.permissionId
INNER JOIN @Reports r ON p.FUNCTIONID = r.OldReportId
WHERE FUNCTIONID = @OldReportId
AND NOT EXISTS (SELECT * FROM UserRoles ur WHERE ur.RoleID in (3,13,67) AND ur.WebPersonID = wpp.WEBPERSONID);
END


--Import Offer AuditTrail
SELECT
@OldReportId = 200


IF ((SELECT COUNT(*) FROM UserRoles ur INNER JOIN @Reports r on ur.RoleId = r.RoleId AND r.OldReportId = @OldReportId) = 0)
BEGIN
INSERT INTO UserRoles
(WebPersonID, RoleId, LastStatEmployeeID, AuditLogTypeID, LastModified)
select 
	wpp.WEBPERSONID,
	r.RoleId,
	1564,
	1,
	GETDATE()
from WebPersonPermission wpp
inner join WebPerson wp on wpp.WEBPERSONID = wp.WebPersonID
inner join Permission p on wpp.PERMISSIONID = p.permissionId
INNER JOIN @Reports r ON p.FUNCTIONID = r.OldReportId
WHERE FUNCTIONID = @OldReportId
AND NOT EXISTS (SELECT * FROM UserRoles ur WHERE ur.RoleID in (3,42) AND ur.WebPersonID = wpp.WEBPERSONID);
END

--Import Offer Detail
SELECT
@OldReportId = 213


IF ((SELECT COUNT(*) FROM UserRoles ur INNER JOIN @Reports r on ur.RoleId = r.RoleId AND r.OldReportId = @OldReportId) = 0)
BEGIN
INSERT INTO UserRoles
(WebPersonID, RoleId, LastStatEmployeeID, AuditLogTypeID, LastModified)
select 
	wpp.WEBPERSONID,
	r.RoleId,
	1564,
	1,
	GETDATE()
from WebPersonPermission wpp
inner join WebPerson wp on wpp.WEBPERSONID = wp.WebPersonID
inner join Permission p on wpp.PERMISSIONID = p.permissionId
INNER JOIN @Reports r ON p.FUNCTIONID = r.OldReportId
WHERE FUNCTIONID = @OldReportId
AND NOT EXISTS (SELECT * FROM UserRoles ur WHERE ur.RoleID in (3,13, 67) AND ur.WebPersonID = wpp.WEBPERSONID);
END


--Initial Approacher Summary
SELECT
@OldReportId = 218


IF ((SELECT COUNT(*) FROM UserRoles ur INNER JOIN @Reports r on ur.RoleId = r.RoleId AND r.OldReportId = @OldReportId) = 0)
BEGIN
INSERT INTO UserRoles
(WebPersonID, RoleId, LastStatEmployeeID, AuditLogTypeID, LastModified)
select 
	wpp.WEBPERSONID,
	r.RoleId,
	1564,
	1,
	GETDATE()
from WebPersonPermission wpp
inner join WebPerson wp on wpp.WEBPERSONID = wp.WebPersonID
inner join Permission p on wpp.PERMISSIONID = p.permissionId
INNER JOIN @Reports r ON p.FUNCTIONID = r.OldReportId
WHERE FUNCTIONID = @OldReportId
AND NOT EXISTS (SELECT * FROM UserRoles ur WHERE ur.RoleID in (3) AND ur.WebPersonID = wpp.WEBPERSONID);
END


--Message Activity
SELECT
@OldReportId = 225

IF ((SELECT COUNT(*) FROM UserRoles ur INNER JOIN @Reports r on ur.RoleId = r.RoleId AND r.OldReportId = @OldReportId) = 0)
BEGIN
INSERT INTO UserRoles
(WebPersonID, RoleId, LastStatEmployeeID, AuditLogTypeID, LastModified)
select 
	wpp.WEBPERSONID,
	r.RoleId,
	1564,
	1,
	GETDATE()
from WebPersonPermission wpp
inner join WebPerson wp on wpp.WEBPERSONID = wp.WebPersonID
inner join Permission p on wpp.PERMISSIONID = p.permissionId
INNER JOIN @Reports r ON p.FUNCTIONID = r.OldReportId
WHERE FUNCTIONID = @OldReportId
AND NOT EXISTS (SELECT * FROM UserRoles ur WHERE ur.RoleID in (3,13, 65) AND ur.WebPersonID = wpp.WEBPERSONID);
END


--Message AuditTrail
SELECT
@OldReportId = 201


IF ((SELECT COUNT(*) FROM UserRoles ur INNER JOIN @Reports r on ur.RoleId = r.RoleId AND r.OldReportId = @OldReportId) = 0)
BEGIN
INSERT INTO UserRoles
(WebPersonID, RoleId, LastStatEmployeeID, AuditLogTypeID, LastModified)
select 
	wpp.WEBPERSONID,
	r.RoleId,
	1564,
	1,
	GETDATE()
from WebPersonPermission wpp
inner join WebPerson wp on wpp.WEBPERSONID = wp.WebPersonID
inner join Permission p on wpp.PERMISSIONID = p.permissionId
INNER JOIN @Reports r ON p.FUNCTIONID = r.OldReportId
WHERE FUNCTIONID = @OldReportId
AND NOT EXISTS (SELECT * FROM UserRoles ur WHERE ur.RoleID in (3,42) AND ur.WebPersonID = wpp.WEBPERSONID);
END


--Message Detail
SELECT
@OldReportId = 214


IF ((SELECT COUNT(*) FROM UserRoles ur INNER JOIN @Reports r on ur.RoleId = r.RoleId AND r.OldReportId = @OldReportId) = 0)
BEGIN
INSERT INTO UserRoles
(WebPersonID, RoleId, LastStatEmployeeID, AuditLogTypeID, LastModified)
select 
	wpp.WEBPERSONID,
	r.RoleId,
	1564,
	1,
	GETDATE()
from WebPersonPermission wpp
inner join WebPerson wp on wpp.WEBPERSONID = wp.WebPersonID
inner join Permission p on wpp.PERMISSIONID = p.permissionId
INNER JOIN @Reports r ON p.FUNCTIONID = r.OldReportId
WHERE FUNCTIONID = @OldReportId
AND NOT EXISTS (SELECT * FROM UserRoles ur WHERE ur.RoleID in (3,13, 65) AND ur.WebPersonID = wpp.WEBPERSONID);
END


--Organization People
SELECT
@OldReportId = 132


IF ((SELECT COUNT(*) FROM UserRoles ur INNER JOIN @Reports r on ur.RoleId = r.RoleId AND r.OldReportId = @OldReportId) = 0)
BEGIN
INSERT INTO UserRoles
(WebPersonID, RoleId, LastStatEmployeeID, AuditLogTypeID, LastModified)
select 
	wpp.WEBPERSONID,
	r.RoleId,
	1564,
	1,
	GETDATE()
from WebPersonPermission wpp
inner join WebPerson wp on wpp.WEBPERSONID = wp.WebPersonID
inner join Permission p on wpp.PERMISSIONID = p.permissionId
INNER JOIN @Reports r ON p.FUNCTIONID = r.OldReportId
WHERE FUNCTIONID = @OldReportId;
END



--Outbound Electronic Communication
SELECT
@OldReportId = 187


IF ((SELECT COUNT(*) FROM UserRoles ur INNER JOIN @Reports r on ur.RoleId = r.RoleId AND r.OldReportId = @OldReportId) = 0)
BEGIN
INSERT INTO UserRoles
(WebPersonID, RoleId, LastStatEmployeeID, AuditLogTypeID, LastModified)
select 
	wpp.WEBPERSONID,
	r.RoleId,
	1564,
	1,
	GETDATE()
from WebPersonPermission wpp
inner join WebPerson wp on wpp.WEBPERSONID = wp.WebPersonID
inner join Permission p on wpp.PERMISSIONID = p.permissionId
INNER JOIN @Reports r ON p.FUNCTIONID = r.OldReportId
WHERE FUNCTIONID = @OldReportId
AND NOT EXISTS (SELECT * FROM UserRoles ur WHERE ur.RoleID in (3) AND ur.WebPersonID = wpp.WEBPERSONID);
END


--Outcome by Category
SELECT
@OldReportId = 219

IF ((SELECT COUNT(*) FROM UserRoles ur INNER JOIN @Reports r on ur.RoleId = r.RoleId AND r.OldReportId = @OldReportId) = 0)
BEGIN
INSERT INTO UserRoles
(WebPersonID, RoleId, LastStatEmployeeID, AuditLogTypeID, LastModified)
select 
	wpp.WEBPERSONID,
	r.RoleId,
	1564,
	1,
	GETDATE()
from WebPersonPermission wpp
inner join WebPerson wp on wpp.WEBPERSONID = wp.WebPersonID
inner join Permission p on wpp.PERMISSIONID = p.permissionId
INNER JOIN @Reports r ON p.FUNCTIONID = r.OldReportId
WHERE FUNCTIONID = @OldReportId
AND NOT EXISTS (SELECT * FROM UserRoles ur WHERE ur.RoleID in (3,13, 23) AND ur.WebPersonID = wpp.WEBPERSONID);
END


--Pending Referrals
SELECT
@OldReportId = 220


IF ((SELECT COUNT(*) FROM UserRoles ur INNER JOIN @Reports r on ur.RoleId = r.RoleId AND r.OldReportId = @OldReportId) = 0)
BEGIN
INSERT INTO UserRoles
(WebPersonID, RoleId, LastStatEmployeeID, AuditLogTypeID, LastModified)
select 
	wpp.WEBPERSONID,
	r.RoleId,
	1564,
	1,
	GETDATE()
from WebPersonPermission wpp
inner join WebPerson wp on wpp.WEBPERSONID = wp.WebPersonID
inner join Permission p on wpp.PERMISSIONID = p.permissionId
INNER JOIN @Reports r ON p.FUNCTIONID = r.OldReportId
WHERE FUNCTIONID = @OldReportId
AND NOT EXISTS (SELECT * FROM UserRoles ur WHERE ur.RoleID in (3,13) AND ur.WebPersonID = wpp.WEBPERSONID);
END



--Personnel Listing
SELECT
@OldReportId = 82


IF ((SELECT COUNT(*) FROM UserRoles ur INNER JOIN @Reports r on ur.RoleId = r.RoleId AND r.OldReportId = @OldReportId) = 0)
BEGIN
INSERT INTO UserRoles
(WebPersonID, RoleId, LastStatEmployeeID, AuditLogTypeID, LastModified)
select 
	wpp.WEBPERSONID,
	r.RoleId,
	1564,
	1,
	GETDATE()
from WebPersonPermission wpp
inner join WebPerson wp on wpp.WEBPERSONID = wp.WebPersonID
inner join Permission p on wpp.PERMISSIONID = p.permissionId
INNER JOIN @Reports r ON p.FUNCTIONID = r.OldReportId
WHERE FUNCTIONID = @OldReportId
AND NOT EXISTS (SELECT * FROM UserRoles ur WHERE ur.RoleID in (3) AND ur.WebPersonID = wpp.WEBPERSONID);
END



--Referral Activity
SELECT
@OldReportId = 222


IF ((SELECT COUNT(*) FROM UserRoles ur INNER JOIN @Reports r on ur.RoleId = r.RoleId AND r.OldReportId = @OldReportId) = 0)
BEGIN
INSERT INTO UserRoles
(WebPersonID, RoleId, LastStatEmployeeID, AuditLogTypeID, LastModified)
select 
	wpp.WEBPERSONID,
	r.RoleId,
	1564,
	1,
	GETDATE()
from WebPersonPermission wpp
inner join WebPerson wp on wpp.WEBPERSONID = wp.WebPersonID
inner join Permission p on wpp.PERMISSIONID = p.permissionId
INNER JOIN @Reports r ON p.FUNCTIONID = r.OldReportId
WHERE FUNCTIONID = @OldReportId
AND NOT EXISTS (SELECT * FROM UserRoles ur WHERE ur.RoleID in (3,13,24,15,66) AND ur.WebPersonID = wpp.WEBPERSONID);
END


--Referral AuditTrail
SELECT
@OldReportId = 204


IF ((SELECT COUNT(*) FROM UserRoles ur INNER JOIN @Reports r on ur.RoleId = r.RoleId AND r.OldReportId = @OldReportId) = 0)
BEGIN
INSERT INTO UserRoles
(WebPersonID, RoleId, LastStatEmployeeID, AuditLogTypeID, LastModified)
select 
	wpp.WEBPERSONID,
	r.RoleId,
	1564,
	1,
	GETDATE()
from WebPersonPermission wpp
inner join WebPerson wp on wpp.WEBPERSONID = wp.WebPersonID
inner join Permission p on wpp.PERMISSIONID = p.permissionId
INNER JOIN @Reports r ON p.FUNCTIONID = r.OldReportId
WHERE FUNCTIONID = @OldReportId
AND NOT EXISTS (SELECT * FROM UserRoles ur WHERE ur.RoleID in (3,14) AND ur.WebPersonID = wpp.WEBPERSONID);
END



--Referral Detail
SELECT
@OldReportId = 209


IF ((SELECT COUNT(*) FROM UserRoles ur INNER JOIN @Reports r on ur.RoleId = r.RoleId AND r.OldReportId = @OldReportId) = 0)
BEGIN
INSERT INTO UserRoles
(WebPersonID, RoleId, LastStatEmployeeID, AuditLogTypeID, LastModified)
select 
	wpp.WEBPERSONID,
	r.RoleId,
	1564,
	1,
	GETDATE()
from WebPersonPermission wpp
inner join WebPerson wp on wpp.WEBPERSONID = wp.WebPersonID
inner join Permission p on wpp.PERMISSIONID = p.permissionId
INNER JOIN @Reports r ON p.FUNCTIONID = r.OldReportId
WHERE FUNCTIONID = @OldReportId
AND NOT EXISTS (SELECT * FROM UserRoles ur WHERE ur.RoleID in (3,13,24,66,21) AND ur.WebPersonID = wpp.WEBPERSONID);
END


--Referral Detail Extended 2004 FTP
SELECT
@OldReportId = 184


IF ((SELECT COUNT(*) FROM UserRoles ur INNER JOIN @Reports r on ur.RoleId = r.RoleId AND r.OldReportId = @OldReportId) = 0)
BEGIN
INSERT INTO UserRoles
(WebPersonID, RoleId, LastStatEmployeeID, AuditLogTypeID, LastModified)
select 
	wpp.WEBPERSONID,
	r.RoleId,
	1564,
	1,
	GETDATE()
from WebPersonPermission wpp
inner join WebPerson wp on wpp.WEBPERSONID = wp.WebPersonID
inner join Permission p on wpp.PERMISSIONID = p.permissionId
INNER JOIN @Reports r ON p.FUNCTIONID = r.OldReportId
WHERE FUNCTIONID = @OldReportId;
END



--Referral Detail Extended 2006 FTP
SELECT
@OldReportId = 194


IF ((SELECT COUNT(*) FROM UserRoles ur INNER JOIN @Reports r on ur.RoleId = r.RoleId AND r.OldReportId = @OldReportId) = 0)
BEGIN
INSERT INTO UserRoles
(WebPersonID, RoleId, LastStatEmployeeID, AuditLogTypeID, LastModified)
select 
	wpp.WEBPERSONID,
	r.RoleId,
	1564,
	1,
	GETDATE()
from WebPersonPermission wpp
inner join WebPerson wp on wpp.WEBPERSONID = wp.WebPersonID
inner join Permission p on wpp.PERMISSIONID = p.permissionId
INNER JOIN @Reports r ON p.FUNCTIONID = r.OldReportId
WHERE FUNCTIONID = @OldReportId;
END


--Referral Detail FTP
SELECT
@OldReportId = 131


IF ((SELECT COUNT(*) FROM UserRoles ur INNER JOIN @Reports r on ur.RoleId = r.RoleId AND r.OldReportId = @OldReportId) = 0)
BEGIN
INSERT INTO UserRoles
(WebPersonID, RoleId, LastStatEmployeeID, AuditLogTypeID, LastModified)
select 
	wpp.WEBPERSONID,
	r.RoleId,
	1564,
	1,
	GETDATE()
from WebPersonPermission wpp
inner join WebPerson wp on wpp.WEBPERSONID = wp.WebPersonID
inner join Permission p on wpp.PERMISSIONID = p.permissionId
INNER JOIN @Reports r ON p.FUNCTIONID = r.OldReportId
WHERE FUNCTIONID = @OldReportId;
END



--Referral Outcome
SELECT
@OldReportId = 210


IF ((SELECT COUNT(*) FROM UserRoles ur INNER JOIN @Reports r on ur.RoleId = r.RoleId AND r.OldReportId = @OldReportId) = 0)
BEGIN
INSERT INTO UserRoles
(WebPersonID, RoleId, LastStatEmployeeID, AuditLogTypeID, LastModified)
select 
	wpp.WEBPERSONID,
	r.RoleId,
	1564,
	1,
	GETDATE()
from WebPersonPermission wpp
inner join WebPerson wp on wpp.WEBPERSONID = wp.WebPersonID
inner join Permission p on wpp.PERMISSIONID = p.permissionId
INNER JOIN @Reports r ON p.FUNCTIONID = r.OldReportId
WHERE FUNCTIONID = @OldReportId
AND NOT EXISTS (SELECT * FROM UserRoles ur WHERE ur.RoleID in (3,13,66,24) AND ur.WebPersonID = wpp.WEBPERSONID);
END


--Report Group Organizations
SELECT
@OldReportId = 76


IF ((SELECT COUNT(*) FROM UserRoles ur INNER JOIN @Reports r on ur.RoleId = r.RoleId AND r.OldReportId = @OldReportId) = 0)
BEGIN
INSERT INTO UserRoles
(WebPersonID, RoleId, LastStatEmployeeID, AuditLogTypeID, LastModified)
select 
	wpp.WEBPERSONID,
	r.RoleId,
	1564,
	1,
	GETDATE()
from WebPersonPermission wpp
inner join WebPerson wp on wpp.WEBPERSONID = wp.WebPersonID
inner join Permission p on wpp.PERMISSIONID = p.permissionId
INNER JOIN @Reports r ON p.FUNCTIONID = r.OldReportId
WHERE FUNCTIONID = @OldReportId
AND NOT EXISTS (SELECT * FROM UserRoles ur WHERE ur.RoleID in (3) AND ur.WebPersonID = wpp.WEBPERSONID);
END



--Schedule Lookup
SELECT
@OldReportId = 223


IF ((SELECT COUNT(*) FROM UserRoles ur INNER JOIN @Reports r on ur.RoleId = r.RoleId AND r.OldReportId = @OldReportId) = 0)
BEGIN
INSERT INTO UserRoles
(WebPersonID, RoleId, LastStatEmployeeID, AuditLogTypeID, LastModified)
select 
	wpp.WEBPERSONID,
	r.RoleId,
	1564,
	1,
	GETDATE()
from WebPersonPermission wpp
inner join WebPerson wp on wpp.WEBPERSONID = wp.WebPersonID
inner join Permission p on wpp.PERMISSIONID = p.permissionId
INNER JOIN @Reports r ON p.FUNCTIONID = r.OldReportId
WHERE FUNCTIONID = @OldReportId
AND NOT EXISTS (SELECT * FROM UserRoles ur WHERE ur.RoleID in (3,13,65,18) AND ur.WebPersonID = wpp.WEBPERSONID);
END


--Timely Referral
SELECT
@OldReportId = 68


IF ((SELECT COUNT(*) FROM UserRoles ur INNER JOIN @Reports r on ur.RoleId = r.RoleId AND r.OldReportId = @OldReportId) = 0)
BEGIN
INSERT INTO UserRoles
(WebPersonID, RoleId, LastStatEmployeeID, AuditLogTypeID, LastModified)
select 
	wpp.WEBPERSONID,
	r.RoleId,
	1564,
	1,
	GETDATE()
from WebPersonPermission wpp
inner join WebPerson wp on wpp.WEBPERSONID = wp.WebPersonID
inner join Permission p on wpp.PERMISSIONID = p.permissionId
INNER JOIN @Reports r ON p.FUNCTIONID = r.OldReportId
WHERE FUNCTIONID = @OldReportId;
END


--Processor Number
SELECT
@OldReportId = 206


IF ((SELECT COUNT(*) FROM UserRoles ur INNER JOIN @Reports r on ur.RoleId = r.RoleId AND r.OldReportId = @OldReportId) = 0)
BEGIN
INSERT INTO UserRoles
(WebPersonID, RoleId, LastStatEmployeeID, AuditLogTypeID, LastModified)
select 
	wpp.WEBPERSONID,
	r.RoleId,
	1564,
	1,
	GETDATE()
from WebPersonPermission wpp
inner join WebPerson wp on wpp.WEBPERSONID = wp.WebPersonID
inner join Permission p on wpp.PERMISSIONID = p.permissionId
INNER JOIN @Reports r ON p.FUNCTIONID = r.OldReportId
WHERE FUNCTIONID = @OldReportId
AND NOT EXISTS (SELECT * FROM UserRoles ur WHERE ur.RoleID in (3,21,10) AND ur.WebPersonID = wpp.WEBPERSONID);
END




--Appropriate Referrals by Facility
SELECT
@OldReportId = 50

IF ((SELECT COUNT(*) FROM UserRoles ur INNER JOIN @Reports r on ur.RoleId = r.RoleId AND r.OldReportId = @OldReportId) = 0)
BEGIN
INSERT INTO UserRoles
(WebPersonID, RoleId, LastStatEmployeeID, AuditLogTypeID, LastModified)
select 
	wpp.WEBPERSONID,
	r.RoleId,
	1564,
	1,
	GETDATE()
from WebPersonPermission wpp
inner join WebPerson wp on wpp.WEBPERSONID = wp.WebPersonID
inner join Permission p on wpp.PERMISSIONID = p.permissionId
INNER JOIN @Reports r ON p.FUNCTIONID = r.OldReportId
WHERE FUNCTIONID = @OldReportId;
END



--Screening Criteria - Triage
SELECT
@OldReportId = 117


IF ((SELECT COUNT(*) FROM UserRoles ur INNER JOIN @Reports r on ur.RoleId = r.RoleId AND r.OldReportId = @OldReportId) = 0)
BEGIN
INSERT INTO UserRoles
(WebPersonID, RoleId, LastStatEmployeeID, AuditLogTypeID, LastModified)
select 
	wpp.WEBPERSONID,
	r.RoleId,
	1564,
	1,
	GETDATE()
from WebPersonPermission wpp
inner join WebPerson wp on wpp.WEBPERSONID = wp.WebPersonID
inner join Permission p on wpp.PERMISSIONID = p.permissionId
INNER JOIN @Reports r ON p.FUNCTIONID = r.OldReportId
WHERE FUNCTIONID = @OldReportId
AND NOT EXISTS (SELECT * FROM UserRoles ur WHERE ur.RoleID in (3) AND ur.WebPersonID = wpp.WEBPERSONID);
END


--Screening Criteria - Secondary
SELECT
@OldReportId = 148


IF ((SELECT COUNT(*) FROM UserRoles ur INNER JOIN @Reports r on ur.RoleId = r.RoleId AND r.OldReportId = @OldReportId) = 0)
BEGIN
INSERT INTO UserRoles
(WebPersonID, RoleId, LastStatEmployeeID, AuditLogTypeID, LastModified)
select 
	wpp.WEBPERSONID,
	r.RoleId,
	1564,
	1,
	GETDATE()
from WebPersonPermission wpp
inner join WebPerson wp on wpp.WEBPERSONID = wp.WebPersonID
inner join Permission p on wpp.PERMISSIONID = p.permissionId
INNER JOIN @Reports r ON p.FUNCTIONID = r.OldReportId
WHERE FUNCTIONID = @OldReportId
AND NOT EXISTS (SELECT * FROM UserRoles ur WHERE ur.RoleID in (3) AND ur.WebPersonID = wpp.WEBPERSONID);
END

GO