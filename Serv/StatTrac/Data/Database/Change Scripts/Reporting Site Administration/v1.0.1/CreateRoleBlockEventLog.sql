 Declare @roleID int,
	    @RoleName varchar(50),
		@RoleNameDescription varchar(50)
set @RoleName = 'BlockEventLog'	    
set @RoleNameDescription = 'Prevents a user from viewing an Eventlog in a report'	    

if not exists(select * from roles where RoleName = @RoleName )
BEGIN	
	INSERT Roles
	values(
		@RoleName,
		@RoleNameDescription,
		45,
		1,
		GetDate(),
		0
		)
			
END

