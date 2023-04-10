  Declare @roleID int,
	    @RoleName varchar(50),
		@RoleNameDescription varchar(50)
set @RoleName = 'RegistryUserCO'	    
set @RoleNameDescription = 'Used to give access to Registry Reports'	    

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

