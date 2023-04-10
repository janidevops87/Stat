/****** Object:  Database DMV_Common    Script Date: 3/28/2008 2:26:41 PM ******/
IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'DMV_Common')
	DROP DATABASE [DMV_Common]
GO
-- f:\RegGroupA
-- d:\RegDevA

CREATE DATABASE [DMV_Common]  ON (NAME = N'DMV_Common_Data', FILENAME = N'n:\Data\DMV_Common_Data.MDF' , SIZE = 50, FILEGROWTH = 10%) LOG ON (NAME = N'DMV_Common_Log', FILENAME = N'p:\Log\DMV_Common_log.ldf' , SIZE = 50, FILEGROWTH = 10%)
 COLLATE SQL_Latin1_General_CP1_CI_AS
GO
ALTER DATABASE [DMV_Common] ADD FILEGROUP [IDX] 
GO
ALTER DATABASE [DMV_Common] ADD FILE(NAME = N'DMV_Common_IDX', FILENAME = N'q:\Index\DMV_Common_Index.ndf' , SIZE = 50, FILEGROWTH = 10%) TO FILEGROUP [IDX]
GO

exec sp_dboption N'DMV_Common', N'autoclose', N'false'
GO

exec sp_dboption N'DMV_Common', N'bulkcopy', N'false'
GO

exec sp_dboption N'DMV_Common', N'trunc. log', N'false'
GO

exec sp_dboption N'DMV_Common', N'torn page detection', N'false'
GO

exec sp_dboption N'DMV_Common', N'read only', N'false'
GO

exec sp_dboption N'DMV_Common', N'dbo use', N'false'
GO

exec sp_dboption N'DMV_Common', N'single', N'false'
GO

exec sp_dboption N'DMV_Common', N'autoshrink', N'false'
GO

exec sp_dboption N'DMV_Common', N'ANSI null default', N'false'
GO

exec sp_dboption N'DMV_Common', N'recursive triggers', N'false'
GO

exec sp_dboption N'DMV_Common', N'ANSI nulls', N'false'
GO

exec sp_dboption N'DMV_Common', N'concat null yields null', N'false'
GO

exec sp_dboption N'DMV_Common', N'cursor close on commit', N'false'
GO

exec sp_dboption N'DMV_Common', N'default to local cursor', N'false'
GO

exec sp_dboption N'DMV_Common', N'quoted identifier', N'false'
GO

exec sp_dboption N'DMV_Common', N'ANSI warnings', N'false'
GO

exec sp_dboption N'DMV_Common', N'auto create statistics', N'true'
GO

exec sp_dboption N'DMV_Common', N'auto update statistics', N'true'
GO

if( (@@microsoftversion / power(2, 24) = 8) and (@@microsoftversion & 0xffff >= 724) )
	exec sp_dboption N'DMV_Common', N'db chaining', N'false'
GO

use [DMV_Common]
GO

/****** Object:  Login citrixadmin    Script Date: 3/28/2008 2:26:42 PM ******/
if not exists (select * from master.dbo.syslogins where loginname = N'citrixadmin')
BEGIN
	declare @logindb nvarchar(132), @loginlang nvarchar(132) select @logindb = N'DMV_CO', @loginlang = N'us_english'
	if @logindb is null or not exists (select * from master.dbo.sysdatabases where name = @logindb)
		select @logindb = N'master'
	if @loginlang is null or (not exists (select * from master.dbo.syslanguages where name = @loginlang) and @loginlang <> N'us_english')
		select @loginlang = @@language
	exec sp_addlogin N'citrixadmin', null, @logindb, @loginlang
END
GO

/****** Object:  Login distributor_admin    Script Date: 3/28/2008 2:26:42 PM ******/
if not exists (select * from master.dbo.syslogins where loginname = N'distributor_admin')
BEGIN
	declare @logindb nvarchar(132), @loginlang nvarchar(132) select @logindb = N'master', @loginlang = N'us_english'
	if @logindb is null or not exists (select * from master.dbo.sysdatabases where name = @logindb)
		select @logindb = N'master'
	if @loginlang is null or (not exists (select * from master.dbo.syslanguages where name = @loginlang) and @loginlang <> N'us_english')
		select @loginlang = @@language
	exec sp_addlogin N'distributor_admin', null, @logindb, @loginlang
END
GO

/****** Object:  Login dmv_co    Script Date: 3/28/2008 2:26:42 PM ******/
if not exists (select * from master.dbo.syslogins where loginname = N'dmv_co')
BEGIN
	declare @logindb nvarchar(132), @loginlang nvarchar(132) select @logindb = N'master', @loginlang = N'us_english'
	if @logindb is null or not exists (select * from master.dbo.sysdatabases where name = @logindb)
		select @logindb = N'master'
	if @loginlang is null or (not exists (select * from master.dbo.syslanguages where name = @loginlang) and @loginlang <> N'us_english')
		select @loginlang = @@language
	exec sp_addlogin N'dmv_co', null, @logindb, @loginlang
END
GO

/****** Object:  Login DOGGY\Administrator    Script Date: 3/28/2008 2:26:42 PM ******/
if not exists (select * from master.dbo.syslogins where loginname = N'DOGGY\Administrator')
	exec sp_grantlogin N'DOGGY\Administrator'
	exec sp_defaultdb N'DOGGY\Administrator', N'master'
	exec sp_defaultlanguage N'DOGGY\Administrator', N'us_english'
GO

/****** Object:  Login DOGGY\clifford_sql    Script Date: 3/28/2008 2:26:42 PM ******/
if not exists (select * from master.dbo.syslogins where loginname = N'DOGGY\clifford_sql')
	exec sp_grantlogin N'DOGGY\clifford_sql'
	exec sp_defaultdb N'DOGGY\clifford_sql', N'master'
	exec sp_defaultlanguage N'DOGGY\clifford_sql', N'us_english'
GO

/****** Object:  Login dt    Script Date: 3/28/2008 2:26:42 PM ******/
if not exists (select * from master.dbo.syslogins where loginname = N'dt')
BEGIN
	declare @logindb nvarchar(132), @loginlang nvarchar(132) select @logindb = N'DMV_Common', @loginlang = N'us_english'
	if @logindb is null or not exists (select * from master.dbo.sysdatabases where name = @logindb)
		select @logindb = N'master'
	if @loginlang is null or (not exists (select * from master.dbo.syslanguages where name = @loginlang) and @loginlang <> N'us_english')
		select @loginlang = @@language
	exec sp_addlogin N'dt', null, @logindb, @loginlang
END
GO

/****** Object:  Login dtcaoladmin    Script Date: 3/28/2008 2:26:42 PM ******/
if not exists (select * from master.dbo.syslogins where loginname = N'dtcaoladmin')
BEGIN
	declare @logindb nvarchar(132), @loginlang nvarchar(132) select @logindb = N'_ReferralDev1', @loginlang = N'us_english'
	if @logindb is null or not exists (select * from master.dbo.sysdatabases where name = @logindb)
		select @logindb = N'master'
	if @loginlang is null or (not exists (select * from master.dbo.syslanguages where name = @loginlang) and @loginlang <> N'us_english')
		select @loginlang = @@language
	exec sp_addlogin N'dtcaoladmin', null, @logindb, @loginlang
END
GO

/****** Object:  Login dttxlgadmin    Script Date: 3/28/2008 2:26:42 PM ******/
if not exists (select * from master.dbo.syslogins where loginname = N'dttxlgadmin')
BEGIN
	declare @logindb nvarchar(132), @loginlang nvarchar(132) select @logindb = N'master', @loginlang = N'us_english'
	if @logindb is null or not exists (select * from master.dbo.sysdatabases where name = @logindb)
		select @logindb = N'master'
	if @loginlang is null or (not exists (select * from master.dbo.syslanguages where name = @loginlang) and @loginlang <> N'us_english')
		select @loginlang = @@language
	exec sp_addlogin N'dttxlgadmin', null, @logindb, @loginlang
END
GO

/****** Object:  Login saUtil    Script Date: 3/28/2008 2:26:42 PM ******/
if not exists (select * from master.dbo.syslogins where loginname = N'saUtil')
BEGIN
	declare @logindb nvarchar(132), @loginlang nvarchar(132) select @logindb = N'master', @loginlang = N'us_english'
	if @logindb is null or not exists (select * from master.dbo.sysdatabases where name = @logindb)
		select @logindb = N'master'
	if @loginlang is null or (not exists (select * from master.dbo.syslanguages where name = @loginlang) and @loginlang <> N'us_english')
		select @loginlang = @@language
	exec sp_addlogin N'saUtil', null, @logindb, @loginlang
END
GO

/****** Object:  Login statfileadmin    Script Date: 3/28/2008 2:26:42 PM ******/
if not exists (select * from master.dbo.syslogins where loginname = N'statfileadmin')
BEGIN
	declare @logindb nvarchar(132), @loginlang nvarchar(132) select @logindb = N'_ReferralDev2', @loginlang = N'us_english'
	if @logindb is null or not exists (select * from master.dbo.sysdatabases where name = @logindb)
		select @logindb = N'master'
	if @loginlang is null or (not exists (select * from master.dbo.syslanguages where name = @loginlang) and @loginlang <> N'us_english')
		select @loginlang = @@language
	exec sp_addlogin N'statfileadmin', null, @logindb, @loginlang
END
GO

/****** Object:  Login stattracadmin    Script Date: 3/28/2008 2:26:42 PM ******/
if not exists (select * from master.dbo.syslogins where loginname = N'stattracadmin')
BEGIN
	declare @logindb nvarchar(132), @loginlang nvarchar(132) select @logindb = N'_ReferralProdReport', @loginlang = N'us_english'
	if @logindb is null or not exists (select * from master.dbo.sysdatabases where name = @logindb)
		select @logindb = N'master'
	if @loginlang is null or (not exists (select * from master.dbo.syslanguages where name = @loginlang) and @loginlang <> N'us_english')
		select @loginlang = @@language
	exec sp_addlogin N'stattracadmin', null, @logindb, @loginlang
END
GO

/****** Object:  Login streportadmin    Script Date: 3/28/2008 2:26:42 PM ******/
if not exists (select * from master.dbo.syslogins where loginname = N'streportadmin')
BEGIN
	declare @logindb nvarchar(132), @loginlang nvarchar(132) select @logindb = N'master', @loginlang = N'us_english'
	if @logindb is null or not exists (select * from master.dbo.sysdatabases where name = @logindb)
		select @logindb = N'master'
	if @loginlang is null or (not exists (select * from master.dbo.syslanguages where name = @loginlang) and @loginlang <> N'us_english')
		select @loginlang = @@language
	exec sp_addlogin N'streportadmin', null, @logindb, @loginlang
END
GO

/****** Object:  Login Doggy\it dev    Script Date: 3/28/2008 2:26:42 PM ******/
if not exists (select * from master.dbo.syslogins where loginname = N'Doggy\it dev')
	exec sp_grantlogin N'Doggy\it dev'
	exec sp_defaultdb N'Doggy\it dev', N'Northwind'
	exec sp_defaultlanguage N'Doggy\it dev', N'us_english'
GO

/****** Object:  Login distributor_admin    Script Date: 3/28/2008 2:26:42 PM ******/
exec sp_addsrvrolemember N'distributor_admin', sysadmin
GO

/****** Object:  Login DOGGY\Administrator    Script Date: 3/28/2008 2:26:42 PM ******/
exec sp_addsrvrolemember N'DOGGY\Administrator', sysadmin
GO

/****** Object:  Login DOGGY\clifford_sql    Script Date: 3/28/2008 2:26:42 PM ******/
exec sp_addsrvrolemember N'DOGGY\clifford_sql', sysadmin
GO

/****** Object:  Login dt    Script Date: 3/28/2008 2:26:42 PM ******/
exec sp_addsrvrolemember N'dt', sysadmin
GO

/****** Object:  Login dttxlgadmin    Script Date: 3/28/2008 2:26:42 PM ******/
exec sp_addsrvrolemember N'dttxlgadmin', sysadmin
GO

/****** Object:  Login saUtil    Script Date: 3/28/2008 2:26:42 PM ******/
exec sp_addsrvrolemember N'saUtil', sysadmin
GO

/****** Object:  Login stattracadmin    Script Date: 3/28/2008 2:26:42 PM ******/
exec sp_addsrvrolemember N'stattracadmin', sysadmin
GO

/****** Object:  User Administrator    Script Date: 3/28/2008 2:26:42 PM ******/
if not exists (select * from dbo.sysusers where name = N'Administrator')
	EXEC sp_grantdbaccess N'DOGGY\Administrator', N'Administrator'
GO

/****** Object:  User dbo    Script Date: 3/28/2008 2:26:42 PM ******/
/****** Object:  User dmv_co    Script Date: 3/28/2008 2:26:42 PM ******/
if not exists (select * from dbo.sysusers where name = N'dmv_co')
	EXEC sp_grantdbaccess N'dmv_co'
GO

/****** Object:  User guest    Script Date: 3/28/2008 2:26:42 PM ******/
if not exists (select * from dbo.sysusers where name = N'guest' and hasdbaccess = 1)
	EXEC sp_grantdbaccess N'guest'
GO

/****** Object:  User stattracadmin    Script Date: 3/28/2008 2:26:42 PM ******/
if not exists (select * from dbo.sysusers where name = N'stattracadmin')
	EXEC sp_grantdbaccess N'stattracadmin'
GO

/****** Object:  User streportadmin    Script Date: 3/28/2008 2:26:42 PM ******/
if not exists (select * from dbo.sysusers where name = N'streportadmin')
	EXEC sp_grantdbaccess N'streportadmin', N'streportadmin'
GO

/****** Object:  DatabaseRole statline_users    Script Date: 3/28/2008 2:26:42 PM ******/
if not exists (select * from dbo.sysusers where name = N'statline_users')
	EXEC sp_addrole N'statline_users'
GO

/****** Object:  User stattracadmin    Script Date: 3/28/2008 2:26:42 PM ******/
exec sp_addrolemember N'db_owner', N'stattracadmin'
GO

/****** Object:  User streportadmin    Script Date: 3/28/2008 2:26:42 PM ******/
exec sp_addrolemember N'db_owner', N'streportadmin'
GO

