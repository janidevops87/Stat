
 /******************************************************************************
**		File: SecurityRule.sql
**		Name: SecurityRule
**		Desc: Load data to table SecurityRule
**		Auth: Bret Knoll
**		Date: 10/21/2010 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		----------	----------------	-------------------------------------------
**		10/21/2010	Bret Knoll			Initial data load
**      1/26/2011   jth                 re-working for new statline
*******************************************************************************/
/* disabling all older permission
 SELECT * FROM SecurityRule
IF((SELECT COUNT(*) FROM SecurityRule) <1 )
BEGIN
	INSERT SecurityRule VALUES
	('Administrator', 'R:Admininistrator', GetDate(), 45, 1), 
	('GeneralAdministration', 'R:Administrator OR R:&quot;R:SL: Client Administrator- Permission&quot; ', GetDate(), 45, 1), 
	('ReportAccessGroup', 'R:Administrator OR R:ClientAdmin ', GetDate(), 45, 1), 
	('ReportAccessGroupConfigure', 'R:Administrator ', GetDate(), 45, 1), 
	('Role', 'R:Administrator OR R:ClientAdmin ', GetDate(), 45, 1), 
	('RoleConfigure', 'R:Administrator OR R:&quot;R:SL: Client Administrator- Permission&quot;', GetDate(), 45, 1), 
	('UserConfigure', 'R:Administrator OR R:&quot;R:SL: Client Administrator- Permission&quot; ', GetDate(), 45, 1), 
	('User', 'R:*', GetDate(), 45, 1),
	('BlockEventLog', 'R:BlockEventLog AND (NOT R:ClientUser) AND (NOT R:Administrator) AND (NOT R:&quot;R:SL: Client Administrator- Permission&quot;)', GetDate(), 45, 1), 
	('Update', 'R:Administrator OR R:&quot;R:SL: Update Referral- Permission&quot; OR R:&quot;R:SL: Update Event Log- Permission&quot; OR R:&quot;R:SL: Edit Schedule Shift- Permission&quot; OR R:&quot;R:SL: Create Schedule Shift- Permission&quot; OR R:&quot;R:SL: Delete Schedule Shift- Permission&quot; OR R:&quot;R:SL: Update Ref Facility Compliance- Permission&quot;', GetDate(), 45, 1), 
	('ReferralUpdate', 'R:Administrator OR R:&quot;R:SL: Update Referral- Permission&quot;', GetDate(), 45, 1), 
	('EventLogUpdate', 'R:Administrator OR R:&quot;R:SL: Update Event Log- Permission&quot;', GetDate(), 45, 1), 
	('ScheduleSearch', 'R:Administrator OR R:&quot;R:SL: Create Schedule Shift- Permission&quot; OR R:&quot;R:SL: Edit Schedule Shift- Permission&quot; OR R:&quot;R:SL: Delete Schedule Shift- Permission&quot;', GetDate(), 45, 1), 
	('ScheduleShiftUpdate', 'R:Administrator OR R:&quot;R:SL: Edit Schedule Shift- Permission&quot; OR R:&quot;R:SL: Delete Schedule Shift- Permission&quot;', GetDate(), 45, 1), 
	('ScheduleShiftDelete', 'R:Administrator OR R:&quot;R:SL: Delete Schedule Shift- Permission&quot;', GetDate(), 45, 1), 
	('ScheduleShiftCreate', 'R:Administrator OR R:&quot;R:SL: Create Schedule Shift- Permission&quot;', GetDate(), 45, 1), 
	('ReferralFacilityCompliance', 'R:Administrator OR R:&quot;R:SL: Update Ref Facility Compliance- Permission&quot;', GetDate(), 45, 1), 
	('QA', 'R:Administrator OR R:&quot;R:SL:QA QM Form - Permission&quot; OR R:&quot;R:SL:QA Review - Permission&quot; OR R:&quot;R:SL:QA Configuration - Permission&quot; OR R:&quot;R:SL:QA Pending Review - Permission&quot;', GetDate(), 45, 1), 
	('QAQMForm', 'R:Administrator OR R:&quot;R:SL:QA QM Form - Permission&quot;', GetDate(), 45, 1), 
	('QAReview', 'R:Administrator OR R:&quot;R:SL:QA Review - Permission&quot;', GetDate(), 45, 1), 
	('QAPendingReview', 'R:Administrator OR R:&quot;R:SL:QA Pending Review - Permission&quot;', GetDate(), 45, 1), 
	('QAConfig', 'R:Administrator OR R:&quot;R:SL:QA Configuration - Permission&quot;', GetDate(), 45, 1), 
	('QACreate', 'R:Administrator', GetDate(), 45, 1),
	('QAUpdate', 'R:Administrator OR R:&quot;R:SL:QA Update/Delete - Permission&quot;', GetDate(), 45, 1), 
	('QAViewOtherOrgs', 'R:Administrator OR R:&quot;R:SL:QA View Other Orgs - Permission&quot;', GetDate(), 45, 1), 
	('QAAddEdit', 'R:Administrator OR R:&quot;R:SL:QA Add/Edit Quality Monitoring Form - Permission&quot;', GetDate(), 45, 1) 
END

*/
/*
*	1. Add role at this time we can include spaces.
*	2. Add permission to SecurityRule enum. Satline.StatTrac.Security.SecurityHelper.
*	3. Add permission and expression to SecurityRule Table
*	4. 
*	5. Assign role to User. Note if creating a new Role the Role is automatically assigned. 
*   6. Test exec StatEmployeeSelectDataSet @StatEmployeeUserId=N'bret'
*/
PRINT 'Set SecurityRule(s)'
DECLARE
	@securityRule as nvarchar(100),
	@securityExpression as nvarchar(300),
	@lastModified as datetime = GetDate()

DECLARE @newRules Table
(
	securityRule nvarchar(100),
	securityExpression nvarchar(300)
)
INSERT @newRules
VALUES
 ( 'Contact_Permissions', 'R:SL:Administration-Statline OR R:SL:Triage_Super_User OR R:SL:Admin_Support OR R:SL:Operations_Manager OR R:SL:Supervisior')
,( 'Delete_Call', 'R:SL:Administration-Statline OR R:SL:Admin_Support OR R:SL:Operations_Manager OR R:SL:QA OR R:SL:Supervisior OR R:SL:Team_Lead-OASIS OR R:SL:Team_Lead-Triage OR R:SL:Triage_Super_User')
,( 'Unlock_Case', 'R:SL:Administration-Statline OR R:SL:Admin_Support OR R:SL:Operations_Manager OR R:SL:Supervisior OR R:SL:Team_Lead-OASIS OR R:SL:Team_Lead-Triage OR R:SL:Triage_Super_User')
,( 'Delete_Events', 'R:SL:Administration-Statline OR R:SL:Admin_Support OR R:SL:Operations_Manager OR R:SL:QA OR R:SL:Supervisior OR R:SL:Team_Lead-OASIS OR R:SL:Team_Lead-Triage OR R:SL:Triage_Super_User')
,(	'Schedule_Changes', 'R:SL:Administration-Statline OR R:SL:Admin_Support OR R:SL:Operations_Manager OR R:SL:QA OR R:SL:Supervisior OR R:SL:Team_Lead-OASIS OR R:SL:Team_Lead-Triage OR R:SL:Triage_Super_User' )
,(	'Add_Organizations', 'R:SL:Administration-Statline OR R:SL:Admin_Support OR R:SL:Operations_Manager OR R:SL:QA OR R:SL:Supervisior OR R:SL:Team_Lead-OASIS OR R:SL:Team_Lead-Triage OR R:SL:Triage_Super_User' )
,(	'Edit_Organizations', 'R:SL:Administration-Statline OR R:SL:Operations_Manager OR R:SL:QA OR R:SL:Supervisior OR R:SL:Triage_Super_User')
,(	'Edit_Exclusive_Calls', 'R:SL:Administration-Statline OR R:SL:Admin_Support OR R:SL:Operations_Manager OR R:SL:QA OR R:SL:Supervisior OR R:SL:Team_Lead-OASIS OR R:SL:Team_Lead-Triage OR R:SL:Triage_Super_User')
,(	'Recycled_Cases', 'R:SL:Administration-Statline OR R:SL:Admin_Support OR R:SL:Operations_Manager OR R:SL:QA OR R:SL:Supervisior OR R:SL:Team_Lead-OASIS OR R:SL:Team_Lead-Triage OR R:SL:Triage_Super_User')
,(	'ST_Update', 'R:SL:Administration-Statline OR R:SL:Admin_Support OR R:SL:Operations_Manager OR R:SL:QA OR R:SL:Supervisior OR R:SL:Team_Lead-OASIS OR R:SL:Team_Lead-Triage OR R:SL:Triage_Super_User' )
,(	'Delete_Bulletin_Board', 'R:SL:Administration-Statline OR R:SL:Admin_Support OR R:SL:Operations_Manager OR R:SL:Supervisior OR R:SL:Team_Lead-OASIS OR R:SL:Team_Lead-Triage OR R:SL:Triage_Super_User')
,(	'Verify_Organizations', 'R:SL:Administration-Statline OR R:SL:Operations_Manager OR R:SL:Supervisior OR R:SL:Triage_Super_User')
,(	'Family_Services', 'R:SL:Administration-Statline OR R:SL:Admin_Support OR R:SL:Operations_Manager OR R:SL:QA OR R:SL:Supervisior OR R:SL:Triage_Super_User')
,(	'FS_Active_Cases', 'R:SL:Administration-Statline OR R:SL:Admin_Support OR R:SL:Operations_Manager OR R:SL:QA OR R:SL:Supervisior OR R:SL:Triage_Super_User')
,(	'OASIS', 'R:SL:Administration-Statline OR R:SL:Admin_Support OR R:SL:OASIS_Coordinator OR R:SL:Operations_Manager OR R:SL:QA OR R:SL:Supervisior OR R:SL:Team_Lead-OASIS OR R:SL:Triage_Super_User')
,(	'Reopen_OASIS_Case', 'R:SL:Administration-Statline OR R:SL:Operations_Manager OR R:SL:QA OR R:SL:Supervisior OR R:SL:Team_Lead-OASIS OR R:SL:Triage_Super_User' )
,(	'Administration_Access', 'R:SL:Administration-Statline OR R:SL:Operations_Manager OR R:SL:QA OR R:SL:Supervisior OR R:SL:Triage_Super_User')
,(	'Add_Source_Code', 'R:SL:Administration-Statline OR R:SL:Operations_Manager OR R:SL:Triage_Super_User' )
,(	'Modify_Source_Code_Name', 'R:SL:Administration-Statline OR R:SL:Operations_Manager OR R:SL:Triage_Super_User' )
,(	'Set_Source_Code_Inactive', 'R:SL:Administration-Statline OR R:SL:Operations_Manager')
,(	'Rule_Out_Indications', 'R:SL:Administration-Statline OR R:SL:Operations_Manager')
,(	'View_ASP_Calls', 'R:SL:Administration-Statline OR R:SL:Admin_Support OR R:SL:Operations_Manager OR R:SL:Supervisior')
,(	'Base_Configuration', 'R:SL:Administration-Statline OR R:SL:Operations_Manager')
,(	'Reassign_Numbers','R:SL:Administration-Statline' )
,(	'Response_Interval', 'R:SL:Administration-Statline OR R:SL:Operations_Manager')
,(	'View_ASP_Organizations', 'R:SL:Admin_Support OR R:SL:Administration-Statline OR R:SL:Donor_Trac_Administrator OR R:SL:Admin_Support OR R:SL:OASIS_Coordinator OR R:SL:Operations_Manager OR R:SL:QA OR R:SL:Supervisior OR R:SL:Team_Lead-OASIS OR R:SL:Team_Lead-Triage OR R:SL:Triage_Coordinator' )
,(	'Login_Override', 'I:bret')
,(	'All_Roles', 'I:bret')


WHILE EXISTS (SELECT * FROM @newRules)
BEGIN	
	SELECT TOP 1 @securityRule = SecurityRule, @securityExpression = securityExpression FROM @newRules
	IF NOT EXISTS(SELECT TOP 1 * FROM SecurityRule WHERE SecurityRule = @securityRule)
	BEGIN
		EXEC SecurityRuleInsert @SecurityRuleID=null, @SecurityRule=@securityRule, @Expression=@securityExpression, @LastModified= @lastModified, @LastStatEmployeeID=45, @AuditLogTypeID=1
		
	END
	DELETE @newRules 
	WHERE SecurityRule = @securityRule 
	AND SecurityExpression = @securityExpression	
END

DECLARE
	@ID INT ,
	@Permission nvarchar(100),
	@Role nvarchar(100)

DECLARE @RuleConfigure TABLE
(
	ID INT IDENTITY(1,1),
	Permission nvarchar(100),
	Role nvarchar(100)
)
INSERT @RuleConfigure (Permission, Role)
VALUES
('Add_Organizations', 'R:Gift_of_Life_MI:Coordinator'),
('Delete_Bulletin_Board', 'R:Gift_of_Life_MI:Coordinator'),
('Schedule_Changes', 'R:Gift_of_Life_MI:Coordinator'),
('Edit_Exclusive_Calls', 'R:Gift_of_Life_MI:Coordinator'),
('Unlock_Case', 'R:Gift_of_Life_MI:Coordinator'),

('Schedule_Changes', 'R:Gift_of_Life_MI:Schedules'),
('Add_Organizations', 'R:Gift_of_Life_MI:Schedules'),
('Edit_Organizations', 'R:Gift_of_Life_MI:Schedules'),

('Add_Organizations', 'R:Gift_of_Life_MI:Supervisor'),
('Delete_Bulletin_Board', 'R:Gift_of_Life_MI:Supervisor'),
('Delete_Call', 'R:Gift_of_Life_MI:Supervisor'),
('Delete_Events', 'R:Gift_of_Life_MI:Supervisor'),
('Edit_Exclusive_Calls', 'R:Gift_of_Life_MI:Supervisor'),
('Edit_Organizations', 'R:Gift_of_Life_MI:Supervisor'),
('Reassign_Numbers', 'R:Gift_of_Life_MI:Supervisor'),
('Recycled_Cases', 'R:Gift_of_Life_MI:Supervisor'),
('Response_Interval', 'R:Gift_of_Life_MI:Supervisor'),
('Schedule_Changes', 'R:Gift_of_Life_MI:Supervisor'),
('Unlock_Case', 'R:Gift_of_Life_MI:Supervisor'),

('Delete_Bulletin_Board', 'R:LifeBanc:DRC'),
('Edit_Exclusive_Calls', 'R:LifeBanc:DRC'),
('Schedule_Changes', 'R:LifeBanc:DRC'),
('Unlock_Case', 'R:LifeBanc:DRC'),
('Recycled_Cases', 'R:LifeBanc:DRC'),

('Add_Organizations', 'R:LifeBanc:Supervisor'),
('Delete_Bulletin_Board', 'R:LifeBanc:Supervisor'),
('Delete_Call', 'R:LifeBanc:Supervisor'),
('Delete_Events', 'R:LifeBanc:Supervisor'),
('Edit_Exclusive_Calls', 'R:LifeBanc:Supervisor'),
('Edit_Organizations', 'R:LifeBanc:Supervisor'),
('Recycled_Cases', 'R:LifeBanc:Supervisor'),
('Response_Interval', 'R:LifeBanc:Supervisor'),
('Schedule_Changes', 'R:LifeBanc:Supervisor'),
('Unlock_Case', 'R:LifeBanc:Supervisor'),

('Family_Services', 'R:LifeGift:Donation_Resource_Specialist'),
('Schedule_Changes', 'R:LifeGift:Donation_Resource_Specialist'),

('Add_Organizations', 'R:LifeGift:Supervisor'),
('Delete_Call', 'R:LifeGift:Supervisor'),
('Delete_Events', 'R:LifeGift:Supervisor'),
('Edit_Exclusive_Calls', 'R:LifeGift:Supervisor'),
('Edit_Organizations', 'R:LifeGift:Supervisor'),
('Family_Services', 'R:LifeGift:Supervisor'),
('Reassign_Numbers', 'R:LifeGift:Supervisor'),
('Recycled_Cases', 'R:LifeGift:Supervisor'),
('Response_Interval', 'R:LifeGift:Supervisor'),
('Schedule_Changes', 'R:LifeGift:Supervisor'),
('Unlock_Case', 'R:LifeGift:Supervisor'),

('Delete_Bulletin_Board', 'R:LifeGift:Supervisor'),


 
('Delete_Bulletin_Board', 'R:LOOP:Referral_Center_Manager'),
('Edit_Exclusive_Calls', 'R:LOOP:Referral_Center_Manager'),
('Response_Interval', 'R:LOOP:Referral_Center_Manager'),
('Add_Organizations', 'R:LOOP:Referral_Center_Manager'),
('Delete_Bulletin_Board', 'R:LOOP:Referral_Center_Manager'),
('Delete_Call', 'R:LOOP:Referral_Center_Manager'),
('Delete_Events', 'R:LOOP:Referral_Center_Manager'),
('Edit_Exclusive_Calls', 'R:LOOP:Referral_Center_Manager'),
('Edit_Organizations', 'R:LOOP:Referral_Center_Manager'),
('Recycled_Cases', 'R:LOOP:Referral_Center_Manager'),
('Response_Interval', 'R:LOOP:Referral_Center_Manager'),
('Schedule_Changes', 'R:LOOP:Referral_Center_Manager'),
('Unlock_Case', 'R:LOOP:Referral_Center_Manager'),


('Delete_Bulletin_Board', 'R:LOOP:Referral_Center_Coordinator'),
('Edit_Exclusive_Calls', 'R:LOOP:Referral_Center_Coordinator'),
('Response_Interval', 'R:LOOP:Referral_Center_Coordinator'), -- really
-- ('Add_Organizations', 'R:LOOP:Referral_Center_Coordinator'), -- really
('Schedule_Changes', 'R:LOOP:Referral_Center_Coordinator'),
('Recycled_Cases', 'R:LOOP:Referral_Center_Coordinator'),
('Unlock_Case', 'R:LOOP:Referral_Center_Coordinator'),

('Add_Organizations', 'R:MTF:Donor_Coordinator'),
('Delete_Bulletin_Board', 'R:MTF:Donor_Coordinator'),
('Edit_Exclusive_Calls', 'R:MTF:Donor_Coordinator'),
('Family_Services', 'R:MTF:Donor_Coordinator'),
('FS_Active_Cases', 'R:MTF:Donor_Coordinator'),
('Recycled_Cases', 'R:MTF:Donor_Coordinator'),
('Schedule_Changes', 'R:MTF:Donor_Coordinator'),
('Unlock_Case', 'R:MTF:Donor_Coordinator'),
('Add_Organizations', 'R:MTF:Supervisor'),
('Delete_Bulletin_Board', 'R:MTF:Supervisor'),
('Delete_Call', 'R:MTF:Supervisor'),
('Delete_Events', 'R:MTF:Supervisor'),
('Edit_Exclusive_Calls', 'R:MTF:Supervisor'),
('Edit_Organizations', 'R:MTF:Supervisor'),
('Family_Services', 'R:MTF:Supervisor'),
('FS_Active_Cases', 'R:MTF:Supervisor'),
('Recycled_Cases', 'R:MTF:Supervisor'),
('Response_Interval', 'R:MTF:Supervisor'),
('Schedule_Changes', 'R:MTF:Supervisor'),
('Unlock_Case', 'R:MTF:Supervisor'),

('View_ASP_Organizations', 'R:SL:Admin_Support'),
('Add_Organizations', 'R:SL:Help_Desk'),
('Contact_Permissions', 'R:SL:Help_Desk'),
('Delete_Bulletin_Board', 'R:SL:Help_Desk'),
('Delete_Call', 'R:SL:Help_Desk'),
('Delete_Events', 'R:SL:Help_Desk'),
('Edit_Exclusive_Calls', 'R:SL:Help_Desk'),
('Family_Services', 'R:SL:Help_Desk'),
('FS_Active_Cases', 'R:SL:Help_Desk'),
('OASIS', 'R:SL:Help_Desk'),
('Recycled_Cases', 'R:SL:Help_Desk'),
('Schedule_Changes', 'R:SL:Help_Desk'),
('Unlock_Case', 'R:SL:Help_Desk'),
('Update', 'R:SL:Help_Desk'),
('View_ASP_Calls', 'R:SL:Help_Desk'),
('View_ASP_Organizations', 'R:SL:Help_Desk'),

('Add_Organizations', 'R:SL:Operations_Manager'),
('Add_Source_Code', 'R:SL:Operations_Manager'),
('Administration_Access', 'R:SL:Operations_Manager'),
('Base_Configuration', 'R:SL:Operations_Manager'),
('Contact_Permissions', 'R:SL:Operations_Manager'),
('Delete_Bulletin_Board', 'R:SL:Operations_Manager'),
('Delete_Call', 'R:SL:Operations_Manager'),
('Delete_Events', 'R:SL:Operations_Manager'),
('Edit_Exclusive_Calls', 'R:SL:Operations_Manager'),
('Edit_Organizations', 'R:SL:Operations_Manager'),
('Family_Services', 'R:SL:Operations_Manager'),
('FS_Active_Cases', 'R:SL:Operations_Manager'),
('Modify_Source_Code_Name', 'R:SL:Operations_Manager'),
('OASIS', 'R:SL:Operations_Manager'),
('Recycled_Cases', 'R:SL:Operations_Manager'),
('Reopen_OASIS_Case', 'R:SL:Operations_Manager'),
('Response_Interval', 'R:SL:Operations_Manager'),
('Rule_Out_Indications', 'R:SL:Operations_Manager'),
('Schedule_Changes', 'R:SL:Operations_Manager'),
('Set_Source_Code_Inactive', 'R:SL:Operations_Manager'),
('Unlock_Case', 'R:SL:Operations_Manager'),
('Update', 'R:SL:Operations_Manager'),
('Verify_Organizations', 'R:SL:Operations_Manager'),
('View_ASP_Calls', 'R:SL:Operations_Manager'),
('View_ASP_Organizations', 'R:SL:Operations_Manager'),
('Add_Organizations', 'R:SL:QA'),
('Administration_Access', 'R:SL:QA'),
('Delete_Call', 'R:SL:QA'),
('Delete_Events', 'R:SL:QA'),
('Edit_Exclusive_Calls', 'R:SL:QA'),
('Edit_Organizations', 'R:SL:QA'),
('Family_Services', 'R:SL:QA'),
('FS_Active_Cases', 'R:SL:QA'),
('OASIS', 'R:SL:QA'),
('Recycled_Cases', 'R:SL:QA'),
('Reopen_OASIS_Case', 'R:SL:QA'),
('Schedule_Changes', 'R:SL:QA'),
('Update', 'R:SL:QA'),
('View_ASP_Organizations', 'R:SL:QA'),
('Add_Organizations', 'R:SL:Supervisor'),
('Administration_Access', 'R:SL:Supervisor'),
('Contact_Permissions', 'R:SL:Supervisor'),
('Delete_Bulletin_Board', 'R:SL:Supervisor'),
('Delete_Call', 'R:SL:Supervisor'),
('Delete_Events', 'R:SL:Supervisor'),
('Edit_Exclusive_Calls', 'R:SL:Supervisor'),
('Edit_Organizations', 'R:SL:Supervisor'),
('Family_Services', 'R:SL:Supervisor'),
('FS_Active_Cases', 'R:SL:Supervisor'),
('OASIS', 'R:SL:Supervisor'),
('Recycled_Cases', 'R:SL:Supervisor'),
('Reopen_OASIS_Case', 'R:SL:Supervisor'),
('Schedule_Changes', 'R:SL:Supervisor'),
('Unlock_Case', 'R:SL:Supervisor'),
('Update', 'R:SL:Supervisor'),
('Verify_Organizations', 'R:SL:Supervisor'),
('View_ASP_Calls', 'R:SL:Supervisor'),
('View_ASP_Organizations', 'R:SL:Supervisor'),
('Add_Organizations', 'R:SL:Team_Lead-OASIS'),
('Delete_Bulletin_Board', 'R:SL:Team_Lead-OASIS'),
('Delete_Call', 'R:SL:Team_Lead-OASIS'),
('Delete_Events', 'R:SL:Team_Lead-OASIS'),
('Edit_Exclusive_Calls', 'R:SL:Team_Lead-OASIS'),
('OASIS', 'R:SL:Team_Lead-OASIS'),
('Recycled_Cases', 'R:SL:Team_Lead-OASIS'),
('Reopen_OASIS_Case', 'R:SL:Team_Lead-OASIS'),
('Schedule_Changes', 'R:SL:Team_Lead-OASIS'),
('Unlock_Case', 'R:SL:Team_Lead-OASIS'),
('Update', 'R:SL:Team_Lead-OASIS'),
('View_ASP_Organizations', 'R:SL:Team_Lead-OASIS'),
('Add_Organizations', 'R:SL:Team_Lead-Triage'),
('Delete_Bulletin_Board', 'R:SL:Team_Lead-Triage'),
('Delete_Call', 'R:SL:Team_Lead-Triage'),
('Delete_Events', 'R:SL:Team_Lead-Triage'),
('Edit_Exclusive_Calls', 'R:SL:Team_Lead-Triage'),
('Recycled_Cases', 'R:SL:Team_Lead-Triage'),
('Schedule_Changes', 'R:SL:Team_Lead-Triage'),
('Unlock_Case', 'R:SL:Team_Lead-Triage'),
('Update', 'R:SL:Team_Lead-Triage'),
('View_ASP_Organizations', 'R:SL:Team_Lead-Triage'),
('View_ASP_Organizations', 'R:SL:Triage_Coordinator'),
('OASIS', 'R:SL:OASIS_Coordinator'),
('View_ASP_Organizations', 'R:SL:OASIS_Coordinator'),
('Add_Organizations', 'R:SL:Triage_Super_User'),
('Add_Source_Code', 'R:SL:Triage_Super_User'),
('Administration_Access', 'R:SL:Triage_Super_User'),
('Base_Configuration', 'R:SL:Triage_Super_User'),
('Contact_Permissions', 'R:SL:Triage_Super_User'),
('Delete_Bulletin_Board', 'R:SL:Triage_Super_User'),
('Delete_Call', 'R:SL:Triage_Super_User'),
('Delete_Events', 'R:SL:Triage_Super_User'),
('Edit_Exclusive_Calls', 'R:SL:Triage_Super_User'),
('Edit_Organizations', 'R:SL:Triage_Super_User'),
('Family_Services', 'R:SL:Triage_Super_User'),
('FS_Active_Cases', 'R:SL:Triage_Super_User'),
('Modify_Source_Code_Name', 'R:SL:Triage_Super_User'),
('OASIS', 'R:SL:Triage_Super_User'),
('Recycled_Cases', 'R:SL:Triage_Super_User'),
('Reopen_OASIS_Case', 'R:SL:Triage_Super_User'),
('Response_Interval', 'R:SL:Triage_Super_User'),
('Rule_Out_Indications', 'R:SL:Triage_Super_User'),
('Schedule_Changes', 'R:SL:Triage_Super_User'),
('Set_Source_Code_Inactive', 'R:SL:Triage_Super_User'),
('Unlock_Case', 'R:SL:Triage_Super_User'),
('Update', 'R:SL:Triage_Super_User'),
('Verify_Organizations', 'R:SL:Triage_Super_User'),
('View_ASP_Calls', 'R:SL:Triage_Super_User'),
('View_ASP_Organizations', 'R:SL:Triage_Super_User'),

('Add_Organizations', 'R:SL:Administration-Statline'),
('Add_Source_Code', 'R:SL:Administration-Statline'),
('Administration_Access', 'R:SL:Administration-Statline'),
('Base_Configuration', 'R:SL:Administration-Statline'),
('Contact_Permissions', 'R:SL:Administration-Statline'),
('Delete_Bulletin_Board', 'R:SL:Administration-Statline'),
('Delete_Call', 'R:SL:Administration-Statline'),
('Delete_Events', 'R:SL:Administration-Statline'),
('Edit_Exclusive_Calls', 'R:SL:Administration-Statline'),
('Edit_Organizations', 'R:SL:Administration-Statline'),
('Family_Services', 'R:SL:Administration-Statline'),
('FS_Active_Cases', 'R:SL:Administration-Statline'),
('Modify_Source_Code_Name', 'R:SL:Administration-Statline'),
('OASIS', 'R:SL:Administration-Statline'),
('Reassign_Numbers', 'R:SL:Administration-Statline'),
('Recycled_Cases', 'R:SL:Administration-Statline'),
('Reopen_OASIS_Case', 'R:SL:Administration-Statline'),
('Response_Interval', 'R:SL:Administration-Statline'),
('Rule_Out_Indications', 'R:SL:Administration-Statline'),
('Schedule_Changes', 'R:SL:Administration-Statline'),
('Set_Source_Code_Inactive', 'R:SL:Administration-Statline'),
('Unlock_Case', 'R:SL:Administration-Statline'),
('Update', 'R:SL:Administration-Statline'),
('Verify_Organizations', 'R:SL:Administration-Statline'),
('View_ASP_Calls', 'R:SL:Administration-Statline'),
('View_ASP_Organizations', 'R:SL:Administration-Statline')

,('Login_Override', 'I:jlbush')
,('All_Roles', 'I:jlbush')
,('Login_Override', 'I:jscheier')
,('All_Roles', 'I:jscheier')

select Role, RoleName 
from @RuleConfigure r 
left outer join  Roles ON replace(r.role, 'R:', '') = Roles.RoleName

order by 1

WHILE EXISTS (SELECT * FROM @RuleConfigure)
BEGIN

	SELECT TOP 1 
	@ID = ID,
	@Permission = Permission,
	@Role = Role
	FROM @RuleConfigure
	
	UPDATE SecurityRule 
	SET Expression = REPLACE(Expression, '  ', ' ') + ' OR ' + @Role
	WHERE SecurityRule = @Permission 
	AND Expression NOT LIKE '%'+@Role+'%'

	DELETE @RuleConfigure
	WHERE ID = @ID
	
END

-- truncate table securityrule