 /******************************************************************************
**		File: AppScreen.sql
**		Name: AppScreen
**		Desc: Load data to table AppScreen
**		Auth: Tanvir Ather
**		Date: 03/02/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		----------	----------------	-------------------------------------------
**		03/02/2009	Tanvir Ather		Initial data load
**		07/12/2010	ccarroll			added this note for development build (GenerateSQL)
**      1/13/2011   jth					changes to go along with the latest version of the navigation nodes...
**      7/14/2011   jth					comment out Help and Color and Icon under main Help
*******************************************************************************/

DELETE FROM AppScreen

SET NOCOUNT ON

IF ((SELECT count(*) FROM AppScreen) = 0)
BEGIN

	-- The main node is there as a placeholder to be the root item
	INSERT INTO AppScreen VALUES (1, null, 'Main', 1, '')
	
	-- The main items
	INSERT INTO AppScreen VALUES (2, 1, 'Dashboard', 1, '')
	INSERT INTO AppScreen VALUES (3, 1, 'New Call', 2, '')
	INSERT INTO AppScreen VALUES (4, 1, 'Schedules', 4, '')
	--INSERT INTO AppScreen VALUES (5, 1, 'General Alerts', 4, '')
	--INSERT INTO AppScreen VALUES (6, 1, 'Lease Org Calls', 5, '')
	INSERT INTO AppScreen VALUES (7, 1, 'Organizations', 3, '')
	INSERT INTO AppScreen VALUES (8, 1, 'Administration', 6, '')
	INSERT INTO AppScreen VALUES (9, 1, 'Help', 7, '')
	INSERT INTO AppScreen VALUES (229, 1, 'Key Codes', 5, '')
	
	-- Dashboard items
	INSERT INTO AppScreen VALUES (10, 2, 'Referrals (F1)', 1, 'F1')
	INSERT INTO AppScreen VALUES (11, 2, 'Msgs & Imports (F2)', 2, 'F2')
	INSERT INTO AppScreen VALUES (12, 2, 'No Calls (F9)', 8, 'F9')
	INSERT INTO AppScreen VALUES (13, 2, 'Family Services (F4)', 3, 'F4')
	INSERT INTO AppScreen VALUES (14, 2, 'FS Active Cases (F5)', 4, 'F5')
	--INSERT INTO AppScreen VALUES (15, 2, 'QA', 6, 'F7')
	INSERT INTO AppScreen VALUES (16, 2, 'OASIS Active Cases (F6)', 5, 'F6')
	INSERT INTO AppScreen VALUES (17, 2, 'Recycled Cases (F8)', 7, 'F8')
	INSERT INTO AppScreen VALUES (225, 2, 'Updates (F7)', 6, 'F7')

	-- New Call
	INSERT INTO AppScreen VALUES (18, 3, 'Referrals', 1, '')
	INSERT INTO AppScreen VALUES (19, 3, 'Family Services', 6, '')
	INSERT INTO AppScreen VALUES (20, 3, 'Messages', 2, '')
	INSERT INTO AppScreen VALUES (21, 3, 'Import Offers', 3, '')
	INSERT INTO AppScreen VALUES (22, 3, 'OASIS', 5, '')
	INSERT INTO AppScreen VALUES (23, 3, 'No Calls', 4, '')

	-- Schedules
	INSERT INTO AppScreen VALUES (24, 4, 'Schedules', 1, '')
	INSERT INTO AppScreen VALUES (25, 4, 'On Call', 2, '')
	
	-- General Alerts
	--INSERT INTO AppScreen VALUES (26, 5, 'Add', 1, '')
	--INSERT INTO AppScreen VALUES (27, 5, 'Edit', 2, '')
	--INSERT INTO AppScreen VALUES (28, 5, 'Delete', 3, '')
	
	-- Lease Org Calls
	--INSERT INTO AppScreen VALUES (29, 6, 'Lease Org Calls', 1, '')
	
	-- Organizations
	INSERT INTO AppScreen VALUES (30, 7, 'Organizations', 1, '')
	INSERT INTO AppScreen VALUES (231, 7, 'Quick Lookup', 3, '')
	
	-- Administration
	INSERT INTO AppScreen VALUES (31, 8, 'Source Codes', 8, '')
	--INSERT INTO AppScreen VALUES (32, 8, 'Billing Groups', 2, '')
	--INSERT INTO AppScreen VALUES (33, 8, 'Templates', 3, '')
	INSERT INTO AppScreen VALUES (34, 8, 'Report Groups', 5, '')
	INSERT INTO AppScreen VALUES (35, 8, 'Facility Rotation', 4, '')
	--INSERT INTO AppScreen VALUES (36, 8, 'Key Codes', 6, '')
	INSERT INTO AppScreen VALUES (37, 8, 'Rule Out Indications', 6, '')
	--INSERT INTO AppScreen VALUES (38, 8, 'QA Configuration', 8, '')
	--INSERT INTO AppScreen VALUES (39, 8, 'Blocked Numbers', 9, '')
	INSERT INTO AppScreen VALUES (226, 8, 'Alerts', 1, '')
	INSERT INTO AppScreen VALUES (227, 8, 'Commit Client Changes', 2, '')
	INSERT INTO AppScreen VALUES (228, 8, 'View ASP Calls', 9, '')
	INSERT INTO AppScreen VALUES (175, 8, 'Screen Configuration', 7, '')
	-- Help
	--INSERT INTO AppScreen VALUES (40, 9, 'Help', 1, '')
	--INSERT INTO AppScreen VALUES (41, 9, 'Color and Icon Key', 2, '')
	INSERT INTO AppScreen VALUES (42, 9, 'About', 3, '')
	
	-- FS Active Cases
	INSERT INTO AppScreen VALUES (43, 14, 'Family Services Summary', 1, '')
	INSERT INTO AppScreen VALUES (44, 14, 'Family Services Detail', 2, '')

	-- OASIS
	INSERT INTO AppScreen VALUES (45, 22, 'OASIS Offer Information', 1, '')
	INSERT INTO AppScreen VALUES (46, 22, 'Common Donor Card', 2, '')
	INSERT INTO AppScreen VALUES (47, 22, 'Liver Donor Card', 2, '')
	INSERT INTO AppScreen VALUES (48, 22, 'Kidney Donor Card', 3, '')
	
	-- OASIS Offer Information
	INSERT INTO AppScreen VALUES (49, 45, 'Offer Information', 1, '')
	INSERT INTO AppScreen VALUES (50, 45, 'Import Donor Card', 2, '')
	
	-- OASIS Common pages
	INSERT INTO AppScreen VALUES (51, 46, 'Donor Card Status/Assoc', 1, '')
	INSERT INTO AppScreen VALUES (52, 46, 'Contact Information', 2, '')
	INSERT INTO AppScreen VALUES (53, 46, 'Medical & Social History', 4, '')
	INSERT INTO AppScreen VALUES (54, 46, 'Fluids/Blood Details', 6, '')
	INSERT INTO AppScreen VALUES (55, 46, 'Test & Diagnoses Details', 8, '')
	INSERT INTO AppScreen VALUES (56, 46, 'Serologies', 9, '')
	INSERT INTO AppScreen VALUES (58, 46, 'Urinalysis/Cultures Details', 11, '')
	INSERT INTO AppScreen VALUES (59, 46, 'ABG''s/Vent Settings Details', 12, '')
	INSERT INTO AppScreen VALUES (60, 46, 'Donor/Recipient/HLA Information Details', 13, '')
	INSERT INTO AppScreen VALUES (61, 46, 'Vital Signs Details', 14, '')
	INSERT INTO AppScreen VALUES (62, 46, 'Lab Profile Details', 15, '')
	
	
	-- OASIS Liver
	INSERT INTO AppScreen VALUES (63, 47, 'Donor/Recipient/HLA Information', 1, '')
	INSERT INTO AppScreen VALUES (64, 47, 'Liver Donor/Recipient Information Summary', 2, '')
	INSERT INTO AppScreen VALUES (65, 47, 'Vital Signs', 3, '')
	INSERT INTO AppScreen VALUES (66, 47, 'Lab Profile', 4, '')
	INSERT INTO AppScreen VALUES (67, 47, 'Liver Vital Signs Summary', 5, '')
	INSERT INTO AppScreen VALUES (68, 47, 'Liver Lab Profile Summary', 6, '')
	INSERT INTO AppScreen VALUES (69, 47, 'Diagnostics', 7, '')
	INSERT INTO AppScreen VALUES (70, 47, 'Liver Diagnostics Summary', 8, '')

	-- OASIS Kidney
	INSERT INTO AppScreen VALUES (71, 48, 'Donor/Recipient/HLA Information', 1, '')
	INSERT INTO AppScreen VALUES (72, 47, 'Kidney Donor/Recipient Information Summary', 2, '')
	INSERT INTO AppScreen VALUES (73, 48, 'Vital Signs', 2, '')
	INSERT INTO AppScreen VALUES (74, 48, 'Lab Profile', 3, '')
	INSERT INTO AppScreen VALUES (75, 48, 'Kidney Vital Signs Summary', 4, '')
	INSERT INTO AppScreen VALUES (76, 48, 'Kidney Lab Profile Summary', 5, '')
	INSERT INTO AppScreen VALUES (77, 47, 'Diagnostics', 7, '')
	INSERT INTO AppScreen VALUES (78, 47, 'Kidney Diagnostics Summary', 8, '')


	--Organizations
	INSERT INTO AppScreen VALUES (86, 30, 'Organization Edit', 2, '')
	INSERT INTO AppScreen VALUES (87, 86, 'Organization Properites', 1, '')
	INSERT INTO AppScreen VALUES (88, 86, 'Organization Base Configuration', 2, '')
	INSERT INTO AppScreen VALUES (89, 86, 'Organization Numbers', 3, '')
	INSERT INTO AppScreen VALUES (90, 86, 'Organization Aliases', 4, '')
	INSERT INTO AppScreen VALUES (91, 86, 'Organization Contacts', 5, '')


	INSERT INTO AppScreen VALUES (101, 22, 'Lung Donor Card', 5, '')
	INSERT INTO AppScreen VALUES (102, 22, 'Heart Donor Card', 5, '')
	INSERT INTO AppScreen VALUES (103, 22, 'Intestine Donor Card', 5, '')
	INSERT INTO AppScreen VALUES (104, 22, 'Pancreas Donor Card', 5, '')
	INSERT INTO AppScreen VALUES (105, 22, 'Heart/Lung Donor Card', 5, '')
	INSERT INTO AppScreen VALUES (106, 22, 'Kidney/Pancreas Donor Card', 5, '')
	INSERT INTO AppScreen VALUES (107, 22, 'Multi Organ Donor Card', 5, '')


	-- OASIS Lung
	INSERT INTO AppScreen VALUES (108, 101, 'Donor/Recipient/HLA Information', 1, '')
	INSERT INTO AppScreen VALUES (109, 101, 'Lung Donor/Recipient Information Summary', 2, '')
	INSERT INTO AppScreen VALUES (100, 101, 'Vital Signs', 3, '')
	INSERT INTO AppScreen VALUES (111, 101, 'Lab Profile', 4, '')
	INSERT INTO AppScreen VALUES (112, 101, 'Lung Vital Signs Summary', 5, '')
	INSERT INTO AppScreen VALUES (113, 101, 'Lung Lab Profile Summary', 6, '')
	INSERT INTO AppScreen VALUES (114, 101, 'Diagnostics', 7, '')
	INSERT INTO AppScreen VALUES (115, 101, 'Lung Diagnostics Summary', 8, '')

	-- OASIS Heart
	INSERT INTO AppScreen VALUES (116, 102, 'Donor/Recipient/HLA Information', 1, '')
	INSERT INTO AppScreen VALUES (117, 102, 'Heart Donor/Recipient Information Summary', 2, '')
	INSERT INTO AppScreen VALUES (118, 102, 'Vital Signs', 3, '')
	INSERT INTO AppScreen VALUES (119, 102, 'Lab Profile', 4, '')
	INSERT INTO AppScreen VALUES (120, 102, 'Heart Vital Signs Summary', 5, '')
	INSERT INTO AppScreen VALUES (121, 102, 'HeartLab Profile Summary', 6, '')
	INSERT INTO AppScreen VALUES (122, 102, 'Diagnostics', 7, '')
	INSERT INTO AppScreen VALUES (123, 102, 'Heart Diagnostics Summary', 8, '')

	-- OASIS Intestine
	INSERT INTO AppScreen VALUES (124, 102, 'Donor/Recipient/HLA Information', 1, '')
	INSERT INTO AppScreen VALUES (125, 102, 'Intestine Donor/Recipient Information Summary', 2, '')
	INSERT INTO AppScreen VALUES (126, 103, 'Vital Signs', 3, '')
	INSERT INTO AppScreen VALUES (127, 103, 'Lab Profile', 4, '')
	INSERT INTO AppScreen VALUES (128, 103, 'Intestine Vital Signs Summary', 5, '')
	INSERT INTO AppScreen VALUES (129, 103, 'IntestineLab Profile Summary', 6, '')
	INSERT INTO AppScreen VALUES (130, 103, 'Diagnostics', 7, '')
	INSERT INTO AppScreen VALUES (131, 103, 'Intestine Diagnostics Summary', 8, '')
	
	-- OASIS Pancreas
	INSERT INTO AppScreen VALUES (132, 104, 'Donor/Recipient/HLA Information', 1, '')
	INSERT INTO AppScreen VALUES (133, 104, 'Pancreas Donor/Recipient Information Summary', 2, '')
	INSERT INTO AppScreen VALUES (134, 104, 'Vital Signs', 3, '')
	INSERT INTO AppScreen VALUES (135, 104, 'Lab Profile', 4, '')
	INSERT INTO AppScreen VALUES (136, 104, 'Pancreas Vital Signs Summary', 5, '')
	INSERT INTO AppScreen VALUES (137, 104, 'PancreasLab Profile Summary', 6, '')
	INSERT INTO AppScreen VALUES (138, 104, 'Diagnostics', 7, '')
	INSERT INTO AppScreen VALUES (139, 104, 'Pancreas Diagnostics Summary', 8, '')
	
	-- OASIS HeartLung
	INSERT INTO AppScreen VALUES (140, 105, 'Donor/Recipient/HLA Information', 1, '')
	INSERT INTO AppScreen VALUES (141, 105, 'HeartLung Donor/Recipient Information Summary', 2, '')
	INSERT INTO AppScreen VALUES (142, 105, 'Vital Signs', 3, '')
	INSERT INTO AppScreen VALUES (143, 105, 'Lab Profile', 4, '')
	INSERT INTO AppScreen VALUES (144, 105, 'HeartLung Vital Signs Summary', 5, '')
	INSERT INTO AppScreen VALUES (145, 105, 'HeartLungLab Profile Summary', 6, '')
	INSERT INTO AppScreen VALUES (146, 105, 'Diagnostics', 7, '')
	INSERT INTO AppScreen VALUES (147, 105, 'HeartLung Diagnostics Summary', 8, '')
	
	-- OASIS KidneyPancreas
	INSERT INTO AppScreen VALUES (148, 106, 'Donor/Recipient/HLA Information', 1, '')
	INSERT INTO AppScreen VALUES (149, 106, 'KidneyPancreas Donor/Recipient Information Summary', 2, '')
	INSERT INTO AppScreen VALUES (150, 106, 'Vital Signs', 3, '')
	INSERT INTO AppScreen VALUES (151, 106, 'Lab Profile', 4, '')
	INSERT INTO AppScreen VALUES (152, 106, 'KidneyPancreas Vital Signs Summary', 5, '')
	INSERT INTO AppScreen VALUES (153, 106, 'KidneyPancreasLab Profile Summary', 6, '')
	INSERT INTO AppScreen VALUES (154, 106, 'Diagnostics', 7, '')
	INSERT INTO AppScreen VALUES (155, 106, 'KidneyPancreas Diagnostics Summary', 8, '')
	
	-- OASIS MultiOrgan
	INSERT INTO AppScreen VALUES (156, 107, 'Donor/Recipient/HLA Information', 1, '')
	INSERT INTO AppScreen VALUES (157, 107, 'MultiOrgan Donor/Recipient Information Summary', 2, '')
	INSERT INTO AppScreen VALUES (158, 107, 'Vital Signs', 3, '')
	INSERT INTO AppScreen VALUES (159, 107, 'Lab Profile', 4, '')
	INSERT INTO AppScreen VALUES (160, 107, 'MultiOrgan Vital Signs Summary', 5, '')
	INSERT INTO AppScreen VALUES (161, 107, 'MultiOrganLab Profile Summary', 6, '')
	INSERT INTO AppScreen VALUES (162, 107, 'Diagnostics', 7, '')
	INSERT INTO AppScreen VALUES (163, 107, 'MultiOrgan Diagnostics Summary', 8, '')
	

--Question
	--INSERT INTO AppScreen VALUES (170, 8, 'Question', 1, '')
	--INSERT INTO AppScreen VALUES (171, 170, 'Question Details', 4, '')
	--INSERT INTO AppScreen VALUES (172, 170, 'Question Add/Edit', 1, '')
	--INSERT INTO AppScreen VALUES (173, 170, 'Question Groups', 3, '')
	--INSERT INTO AppScreen VALUES (174, 170, 'Question Multiple Groups', 2, '')
	
--Screen Config
	
	INSERT INTO AppScreen VALUES (176, 175, 'Contact Information', 1, '')
	INSERT INTO AppScreen VALUES (177, 175, 'Patient Information', 2, '')
	INSERT INTO AppScreen VALUES (178, 175, 'Medical History', 3, '')
	INSERT INTO AppScreen VALUES (179, 175, 'Registry', 4, '')	
	INSERT INTO AppScreen VALUES (180, 175, 'Next of Kin', 5, '')
	INSERT INTO AppScreen VALUES (181, 175, 'Authorization', 6, '')
	INSERT INTO AppScreen VALUES (182, 175, 'CoronerME', 7, '')
	INSERT INTO AppScreen VALUES (183, 175, 'Funeral Home', 8, '')	
	INSERT INTO AppScreen VALUES (184, 175, 'More Data', 9, '')
	INSERT INTO AppScreen VALUES (185, 175, 'Update', 10, '')
	INSERT INTO AppScreen VALUES (186, 175, 'Overall Disposition', 11, '')
	INSERT INTO AppScreen VALUES (187, 175, 'Family Services', 12, '')	
	INSERT INTO AppScreen VALUES (188, 175, 'Event Log', 13, '')
	INSERT INTO AppScreen VALUES (189, 175, 'Associated Organizations', 14, '')
	INSERT INTO AppScreen VALUES (190, 175, 'Associated Source Codes', 15, '')
	INSERT INTO AppScreen VALUES (191, 176, 'Apply Screen Config', 2, '')
	INSERT INTO AppScreen VALUES (192, 175, 'Message', 1, '')
	INSERT INTO AppScreen VALUES (193, 175, 'Import Offer', 1, '')
	INSERT INTO AppScreen VALUES (194, 175, 'TCSS', 1, '')
	INSERT INTO AppScreen VALUES (195, 192, 'Other Event Log', 2, '')
	
	--Source Code
	--INSERT INTO AppScreen VALUES (98, 8, 'Source Code', 1, '')
	INSERT INTO AppScreen VALUES (201, 31, 'Source Code', 1, '')
	INSERT INTO AppScreen VALUES (202, 31, 'Associated Organizations', 2, '')

	--Criteria Main
	INSERT INTO AppScreen VALUES (203, 8, 'Criteria', 3, '')
	--Criteria Sub Level (1)Menu Tabs
	INSERT INTO AppScreen VALUES (204, 203, 'Triage Criteria', 1, '')
	INSERT INTO AppScreen VALUES (205, 203, 'Triage Questions', 2, '')
	INSERT INTO AppScreen VALUES (206, 203,	'Family Services Criteria', 3, '')
	INSERT INTO AppScreen VALUES (207, 203, 'Associated Organizations', 4, '')
	INSERT INTO AppScreen VALUES (208, 203, 'Associated Source Codes', 5, '')
	
	--Criteria Sub Level (2)Menu Tabs
	INSERT INTO AppScreen VALUES (209, 205, 'Associated Questions', 1, '')
	INSERT INTO AppScreen VALUES (210, 205, 'Question Configuration', 2, '')
	
	INSERT INTO AppScreen VALUES (211, 206, 'Processors', 1, '')
	INSERT INTO AppScreen VALUES (212, 206, 'Update Criteria and Questions', 2, '') 
	
	--Criteria Sub Level (3)Menu Tabs
	INSERT INTO AppScreen VALUES (213, 212, 'Modify FS Criteria', 1, '')
	INSERT INTO AppScreen VALUES (214, 212, 'Family Services Questions', 2, '')

	
	
	--Criteria Sub Level (4)Menu Tabs
	INSERT INTO AppScreen VALUES (215, 214, 'Associated Questions', 1, '')
	INSERT INTO AppScreen VALUES (216, 214, 'Question Configuration', 2, '')
	
	--RuleOutIndications
	
	INSERT INTO AppScreen VALUES (218, 37, 'Rule Out Indications', 1, '')
	INSERT INTO AppScreen VALUES (219, 37, 'Rule Out Indications Detail', 2, '')
	
--FSQuestions
	INSERT INTO AppScreen VALUES (220, 214, 'FS Next of Kin', 1, '')
	INSERT INTO AppScreen VALUES (221, 214, 'FS Coroner ME Autopsy', 2, '')
	INSERT INTO AppScreen VALUES (222, 214, 'FS H&P', 3, '')
	INSERT INTO AppScreen VALUES (223, 214, 'FS Body Care', 4, '')
	INSERT INTO AppScreen VALUES (224, 214, 'FS Case Management', 5, '')
	
--Key Codes
	INSERT INTO AppScreen VALUES (230, 229, 'Key Code Screen', 1, '')
End
GO