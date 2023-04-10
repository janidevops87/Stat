 
 DECLARE @DBLOGINNAME AS VARCHAR(100),
	@DBNAME AS VARCHAR(100),
	@DBPASSWORD AS VARCHAR(100),
	@USESTATMENT AS VARCHAR(100),
	@sql as NVARCHAR(4000)


SELECT @DBLOGINNAME = 'streportadmin'
SELECT @DBNAME = db_name()
SELECT @DBPASSWORD = 'stattrac'

/*
SELECT @DBLOGINNAME
SELECT @DBNAME 
SELECT @DBPASSWORD 
*/

SET @sql = 'USE ' + @DBNAME + ' '
 
----- add the login name to the database
SET @sql = @sql + 'if not exists (select * from master.dbo.syslogins where name = N''' + @DBLOGINNAME + ''') BEGIN '
SET @sql = @sql + 'Print ''login does not exist'' '
SET @sql = @sql + 'EXEC sp_addlogin @loginame = ''' + @DBLOGINNAME + ''', @passwd = ''' + @DBPASSWORD + ''', @defdb = ''' + @DBNAME + ''' END '
SET @sql = @sql + 'if not exists (select * from dbo.sysusers where name = N''' + @DBLOGINNAME + ''' and uid < 16382) BEGIN '
SET @sql = @sql + 'EXEC sp_grantdbaccess @loginame = ''' + @DBLOGINNAME + ''', @name_in_db = ''' + @DBLOGINNAME + ''' END '

SET @sql = @sql + 'EXEC sp_addrolemember ''db_owner'',''' +  @DBLOGINNAME + ''' '

SET @sql = @sql + 'EXEC sp_change_users_login ''Auto_Fix'', ''' +  @DBLOGINNAME + ''', NULL, ''' +  @DBLOGINNAME + ''' '

EXEC sp_executesql @sql


