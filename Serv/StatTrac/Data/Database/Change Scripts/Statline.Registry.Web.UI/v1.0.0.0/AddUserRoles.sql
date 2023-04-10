/* User Roles 
02/22/2010 ccarroll modified to add dynamic user roles for registry owners 
02/07/2011 ccarroll added role for registry Mailing Labels report
*/

/* NEOB 
if not exists (select * from roles where RoleName like 'NEOB: Read-Only Registry Site - Permission')
BEGIN
	PRINT 'Createing role: NEOB: Read-Only Registry Site - Permission'
	INSERT Roles (RoleName, RoleDescription, LastStatEmployeeID, AuditLogTypeID, LastModified)
	VALUES('NEOB: Read-Only Registry Site - Permission','Gives user permission to view registry site', 1100, 1, GetDate())
END
if not exists (select * from roles where RoleName like 'NEOB: Update/Delete Registry Site - Permission')
BEGIN
	PRINT 'Createing role: NEOB: Update/Delete Registry Site - Permission'
	INSERT Roles (RoleName, RoleDescription, LastStatEmployeeID, AuditLogTypeID, LastModified)
	VALUES('NEOB: Update/Delete Registry Site - Permission','Gives user permission to update/delete registry data', 1100, 1, GetDate())
END
*/

/* Dynamic User Roles 
if not exists (select * from roles where RoleName like 'Dynamic: Read-Only Registry Site - Permission')
BEGIN
	PRINT 'Createing role: Dynamic: Read-Only Registry Site - Permission'
	INSERT Roles (RoleName, RoleDescription, LastStatEmployeeID, AuditLogTypeID, LastModified)
	VALUES('Dynamic: Read-Only Registry Site - Permission','Gives user permission to view registry site', 1100, 1, GetDate())
END
if not exists (select * from roles where RoleName like 'Dynamic: Update/Delete Registry Site - Permission')
BEGIN

	PRINT 'Createing role: Dynamic: Update/Delete Registry Site - Permission'
	INSERT Roles (RoleName, RoleDescription, LastStatEmployeeID, AuditLogTypeID, LastModified)
	VALUES('Dynamic: Update/Delete Registry Site - Permission','Gives user permission to update/delete registry data', 1100, 1, GetDate())
END
*/

/* Add Role for Registry Mailing Label Reports*/
if not exists (select * from roles where RoleName like 'Registry: MailingLabelsReport - Permission')
BEGIN
	PRINT 'Createing role: Registry: MailingLabelsReport - Permission'
	INSERT Roles (RoleName, RoleDescription, LastStatEmployeeID, AuditLogTypeID, LastModified)
	VALUES('Registry: MailingLabelsReport - Permission','Gives user permission to run registry Mailing Labels report', 1100, 1, GetDate())
END
