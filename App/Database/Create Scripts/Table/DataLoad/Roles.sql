 /******************************************************************************
**		File: Roles.sql
**		Name: Roles
**		Desc: Load data to table Roles
**		Auth: Bret Knoll
**		Date: 10/21/2010
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		----------	----------------	-------------------------------------------
**		10/21/2010	Bret Knoll			Initial data load
**      1/26/2011   jth                 added new stattrac roles
*******************************************************************************/

DECLARE
	@role as nvarchar(100),
	@roleDescription  as nvarchar(100)

DECLARE @roleList Table 
	(
	role nvarchar(100),
	roleDescription nvarchar(100)
	)
			
	INSERT @roleList
	VALUES
	('SL:Administration-Statline', 'Statline administration role'),
	('SL:OASIS_Coordinator', 'Statline administration role'),	
	('SL:Supervisior', 'Statline supervisor role'),	
	('SL:Team_Lead-Triage', 'Statline team lead role'),		
	('SL:Triage_Coordinator', 'Statline triage coordinator role'),	
	('SL:Triage_Advanced', 'Statline advanced triage coordinator role'),	
	('SL:Triage_Super_User', 'Triage Super User'),
	('SL:Team_Lead-OASIS', 'Team Lead Oasis'),
	('SL:Supervisor', 'Supervisor'),
	('SL:QA', 'QA'),
	('SL:Operations_Manager', 'Operations Manager'),
	('SL:Help_Desk', 'Help Desk'),
	('SL:Admin_Support', 'Admin'),
	('LOOP:Referral_Center_Manager', 'Referral Center Manager'),
	('LOOP:Referral_Center_Coordinator', 'Referral Center Coordinator'),
	('LifeBanc:Supervisor', 'Supervisor'),			
	('LifeBanc:DRC', 'DRC'),	
	('LifeGift:Supervisor', 'Supervisor'),			
	('LifeGift:Donation_Resource_Specialist', 'Donation Resource Specialist'),					
	('LifeGift:Quality', 'Quality'),	
	('Gift_of_Life_MI:Supervisor', 'Supervisor'),			
	('Gift_of_Life_MI:Coordinator', 'Coordinator'),				
	('Gift_of_Life_MI:Schedules', 'Schedules'),
	('MTF:Supervisor', 'Supervisor'),			
	('MTF:Donor_Coordinator', 'Coordinator')


WHILE EXISTS(SELECT * FROM @roleList)
BEGIN
	SELECT TOP 1 
		@role = role, 
		@roleDescription = roleDescription
	FROM 
		@roleList
	PRINT @role
	PRINT @roleDescription
	
	IF NOT EXISTS(SELECT TOP 1 * FROM Roles WHERE Roles.RoleName = @role)
	BEGIN
		EXEC InsertRoles @RoleName=@role, @RoleDescription=@roleDescription, @Inactive=0 ,  @LastStatEmployeeID=45, @AuditLogTypeID=1
		
	END	
	 
	DELETE @roleList
	WHERE role = @role
END	