 /****** Object:  Database DMV_NH    Script Date: 1/11/2008 10:58:50 AM ******/
IF NOT EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'DMV_VT')
BEGIN
CREATE DATABASE [DMV_VT]  ON (NAME = N'DMV_VT_Data', FILENAME = N'r:\Data\DMV_VT_Data.MDF' , SIZE = 1630, FILEGROWTH = 10%) LOG ON (NAME = N'DMV_VT_Log', FILENAME = N's:\Log\DMV_VT_log.ldf' , SIZE = 200, FILEGROWTH = 10%)
 COLLATE SQL_Latin1_General_CP1_CI_AS
ALTER DATABASE [DMV_VT] ADD FILEGROUP [IDX] 
ALTER DATABASE [DMV_VT] ADD FILE(NAME = N'DMV_VT_Index', FILENAME = N't:\Index\DMV_VT_IDX.ndf' , SIZE = 570, FILEGROWTH = 10%) TO FILEGROUP [IDX]
exec sp_dboption N'DMV_VT', N'autoclose', N'false'
exec sp_dboption N'DMV_VT', N'bulkcopy', N'false'
exec sp_dboption N'DMV_VT', N'trunc. log', N'false'
exec sp_dboption N'DMV_VT', N'torn page detection', N'false'
exec sp_dboption N'DMV_VT', N'read only', N'false'
exec sp_dboption N'DMV_VT', N'dbo use', N'false'
exec sp_dboption N'DMV_VT', N'single', N'false'
exec sp_dboption N'DMV_VT', N'autoshrink', N'false'
exec sp_dboption N'DMV_VT', N'ANSI null default', N'false'
exec sp_dboption N'DMV_VT', N'recursive triggers', N'false'
exec sp_dboption N'DMV_VT', N'ANSI nulls', N'false'
exec sp_dboption N'DMV_VT', N'concat null yields null', N'false'
exec sp_dboption N'DMV_VT', N'cursor close on commit', N'false'
exec sp_dboption N'DMV_VT', N'default to local cursor', N'false'
exec sp_dboption N'DMV_VT', N'quoted identifier', N'false'
exec sp_dboption N'DMV_VT', N'ANSI warnings', N'false'
exec sp_dboption N'DMV_VT', N'auto create statistics', N'true'
exec sp_dboption N'DMV_VT', N'auto update statistics', N'true'
END

if( ( (@@microsoftversion / power(2, 24) = 8) and (@@microsoftversion & 0xffff >= 724) ) or ( (@@microsoftversion / power(2, 24) = 7) and (@@microsoftversion & 0xffff >= 1082) ) )
BEGIN
	exec sp_dboption N'DMV_VT', N'db chaining', N'false'


use [DMV_VT]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_DMVADDR_ADDRTYPE]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[DMVADDR] DROP CONSTRAINT FK_DMVADDR_ADDRTYPE
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_DMVORGAN_ORGANTYPE]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[DMVORGAN] DROP CONSTRAINT FK_DMVORGAN_ORGANTYPE
GO

/****** Object:  Trigger dbo.sp_MSsync_upd_trig_ADDRTYPE_8    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_MSsync_upd_trig_ADDRTYPE_8]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[sp_MSsync_upd_trig_ADDRTYPE_8]
GO

/****** Object:  Trigger dbo.sp_MSsync_upd_trig_ADDRTYPE_5    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_MSsync_upd_trig_ADDRTYPE_5]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[sp_MSsync_upd_trig_ADDRTYPE_5]
GO

/****** Object:  Trigger dbo.i_DMVARCHIVE    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[i_DMVARCHIVE]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[i_DMVARCHIVE]
GO

/****** Object:  Trigger dbo.u_DMVARCHIVE    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[u_DMVARCHIVE]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[u_DMVARCHIVE]
GO

/****** Object:  Trigger dbo.i_DMVARCHIVEADDR    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[i_DMVARCHIVEADDR]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[i_DMVARCHIVEADDR]
GO

/****** Object:  Trigger dbo.u_DMVARCHIVEADDR    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[u_DMVARCHIVEADDR]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[u_DMVARCHIVEADDR]
GO

/****** Object:  Trigger dbo.i_DMVARCHIVEORGAN    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[i_DMVARCHIVEORGAN]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[i_DMVARCHIVEORGAN]
GO

/****** Object:  Trigger dbo.u_DMVARCHIVEORGAN    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[u_DMVARCHIVEORGAN]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[u_DMVARCHIVEORGAN]
GO

/****** Object:  Trigger dbo.i_IMPORTARCHIVE    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[i_IMPORTARCHIVE]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[i_IMPORTARCHIVE]
GO

/****** Object:  Trigger dbo.u_IMPORTARCHIVE    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[u_IMPORTARCHIVE]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[u_IMPORTARCHIVE]
GO

/****** Object:  Trigger dbo.i_IMPORTARCHIVE_A    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[i_IMPORTARCHIVE_A]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[i_IMPORTARCHIVE_A]
GO

/****** Object:  Trigger dbo.u_IMPORTARCHIVE_A    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[u_IMPORTARCHIVE_A]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[u_IMPORTARCHIVE_A]
GO

/****** Object:  Trigger dbo.i_IMPORTARCHIVE_B    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[i_IMPORTARCHIVE_B]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[i_IMPORTARCHIVE_B]
GO

/****** Object:  Trigger dbo.u_IMPORTARCHIVE_B    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[u_IMPORTARCHIVE_B]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[u_IMPORTARCHIVE_B]
GO

/****** Object:  Trigger dbo.i_IMPORTARCHIVE_C    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[i_IMPORTARCHIVE_C]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[i_IMPORTARCHIVE_C]
GO

/****** Object:  Trigger dbo.u_IMPORTARCHIVE_C    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[u_IMPORTARCHIVE_C]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[u_IMPORTARCHIVE_C]
GO

/****** Object:  Trigger dbo.i_IMPORTLOG    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[i_IMPORTLOG]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[i_IMPORTLOG]
GO

/****** Object:  Trigger dbo.u_IMPORTLOG    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[u_IMPORTLOG]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[u_IMPORTLOG]
GO

/****** Object:  Trigger dbo.i_IMPORTLOGSTATS    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[i_IMPORTLOGSTATS]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[i_IMPORTLOGSTATS]
GO

/****** Object:  Trigger dbo.u_IMPORTLOGSTATS    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[u_IMPORTLOGSTATS]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[u_IMPORTLOGSTATS]
GO

/****** Object:  Trigger dbo.sp_MSsync_upd_trig_ORGANTYPE_8    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_MSsync_upd_trig_ORGANTYPE_8]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[sp_MSsync_upd_trig_ORGANTYPE_8]
GO

/****** Object:  Trigger dbo.sp_MSsync_upd_trig_ORGANTYPE_5    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_MSsync_upd_trig_ORGANTYPE_5]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[sp_MSsync_upd_trig_ORGANTYPE_5]
GO

/****** Object:  Trigger dbo.Insert_Registry    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Insert_Registry]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[Insert_Registry]
GO

/****** Object:  Trigger dbo.Update_REGISTRY    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Update_REGISTRY]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[Update_REGISTRY]
GO

/****** Object:  Trigger dbo.Insert_REGISTRYADDR    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Insert_REGISTRYADDR]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[Insert_REGISTRYADDR]
GO

/****** Object:  Trigger dbo.Update_REGISTRYADDR    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Update_REGISTRYADDR]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[Update_REGISTRYADDR]
GO

/****** Object:  Trigger dbo.Insert_REGISTRYORGAN    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Insert_REGISTRYORGAN]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[Insert_REGISTRYORGAN]
GO

/****** Object:  Trigger dbo.Update_REGISTRYORGAN    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Update_REGISTRYORGAN]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[Update_REGISTRYORGAN]
GO

/****** Object:  Trigger dbo.sp_MSsync_upd_trig_RegistryEventSourceCodes_7    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_MSsync_upd_trig_RegistryEventSourceCodes_7]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[sp_MSsync_upd_trig_RegistryEventSourceCodes_7]
GO

/****** Object:  Trigger dbo.sp_MSsync_upd_trig_RegistryEventSourceCodes_11    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_MSsync_upd_trig_RegistryEventSourceCodes_11]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[sp_MSsync_upd_trig_RegistryEventSourceCodes_11]
GO

/****** Object:  Trigger dbo.i_DMVORGAN    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[i_DMVORGAN]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[i_DMVORGAN]
GO

/****** Object:  Trigger dbo.u_DMVORGAN    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[u_DMVORGAN]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[u_DMVORGAN]
GO

/****** Object:  User Defined Function dbo.REMOVE_BAD255    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[REMOVE_BAD255]') and xtype in (N'FN', N'IF', N'TF'))
drop function [dbo].[REMOVE_BAD255]
GO

/****** Object:  Stored Procedure dbo.spi_Archive_Deceased    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Archive_Deceased]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spi_Archive_Deceased]
GO

/****** Object:  Stored Procedure dbo.spi_Archive_OutOfState    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Archive_OutOfState]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spi_Archive_OutOfState]
GO

/****** Object:  Stored Procedure dbo.sps_CheckRegistry_NEOB    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_CheckRegistry_NEOB]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_CheckRegistry_NEOB]
GO

/****** Object:  Stored Procedure dbo.sps_IMPORT_All_ImportArchive    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_IMPORT_All_ImportArchive]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_IMPORT_All_ImportArchive]
GO

/****** Object:  Stored Procedure dbo.sps_IMPORT_All_ImportDonor    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_IMPORT_All_ImportDonor]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_IMPORT_All_ImportDonor]
GO

/****** Object:  Stored Procedure dbo.sps_IMPORT_All_ImportDonorFull    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_IMPORT_All_ImportDonorFull]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_IMPORT_All_ImportDonorFull]
GO

/****** Object:  Stored Procedure dbo.sps_WebUserUpSert    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_WebUserUpSert]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_WebUserUpSert]
GO

/****** Object:  Stored Procedure dbo.spu_IMPORT_All_ImportOverwriteGuard    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_IMPORT_All_ImportOverwriteGuard]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spu_IMPORT_All_ImportOverwriteGuard]
GO

/****** Object:  Stored Procedure dbo.spu_Import_Deletes    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_Import_Deletes]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spu_Import_Deletes]
GO

/****** Object:  Stored Procedure dbo.spui_Registry    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spui_Registry]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spui_Registry]
GO

/****** Object:  Stored Procedure dbo.SPS_CheckRegistry_REG    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SPS_CheckRegistry_REG]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SPS_CheckRegistry_REG]
GO

/****** Object:  Stored Procedure dbo.SPS_CheckRegistry_REGv2    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SPS_CheckRegistry_REGv2]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SPS_CheckRegistry_REGv2]
GO

/****** Object:  Stored Procedure dbo.SPUI_REGISTRYADDR    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SPUI_REGISTRYADDR]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SPUI_REGISTRYADDR]
GO

/****** Object:  Stored Procedure dbo.spf_IMPORT_ALL_CheckRecordCounts    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spf_IMPORT_ALL_CheckRecordCounts]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spf_IMPORT_ALL_CheckRecordCounts]
GO

/****** Object:  Stored Procedure dbo.spi_IMPORT_ImportApply_A    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_IMPORT_ImportApply_A]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spi_IMPORT_ImportApply_A]
GO

/****** Object:  Stored Procedure dbo.spi_IMPORT_ImportApply_B    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_IMPORT_ImportApply_B]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spi_IMPORT_ImportApply_B]
GO

/****** Object:  Stored Procedure dbo.spi_IMPORT_ImportApply_C    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_IMPORT_ImportApply_C]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spi_IMPORT_ImportApply_C]
GO

/****** Object:  Stored Procedure dbo.spi_IMPORT_ImportInitialize    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_IMPORT_ImportInitialize]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spi_IMPORT_ImportInitialize]
GO

/****** Object:  Stored Procedure dbo.spi_Import_Adds    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Import_Adds]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spi_Import_Adds]
GO

/****** Object:  Stored Procedure dbo.spi_QueryLog    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_QueryLog]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spi_QueryLog]
GO

/****** Object:  Stored Procedure dbo.spi_Registry_Archive_Removed    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Registry_Archive_Removed]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spi_Registry_Archive_Removed]
GO

/****** Object:  Stored Procedure dbo.spi_WebUser    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_WebUser]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spi_WebUser]
GO

/****** Object:  Stored Procedure dbo.sps_AccessType    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_AccessType]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_AccessType]
GO

/****** Object:  Stored Procedure dbo.sps_Access_BW    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_Access_BW]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_Access_BW]
GO

/****** Object:  Stored Procedure dbo.sps_CheckRegistry    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_CheckRegistry]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_CheckRegistry]
GO

/****** Object:  Stored Procedure dbo.sps_DonorRegistryByGenderAgeAndDonorStatus    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_DonorRegistryByGenderAgeAndDonorStatus]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_DonorRegistryByGenderAgeAndDonorStatus]
GO

/****** Object:  Stored Procedure dbo.sps_DonorRegistryByGenderAgeAndDonorStatus2    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_DonorRegistryByGenderAgeAndDonorStatus2]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_DonorRegistryByGenderAgeAndDonorStatus2]
GO

/****** Object:  Stored Procedure dbo.sps_DonorRegistryByGenderAgeAndSource    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_DonorRegistryByGenderAgeAndSource]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_DonorRegistryByGenderAgeAndSource]
GO

/****** Object:  Stored Procedure dbo.sps_DonorRegistryByGenderAgeAndSource2    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_DonorRegistryByGenderAgeAndSource2]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_DonorRegistryByGenderAgeAndSource2]
GO

/****** Object:  Stored Procedure dbo.sps_DonorRegistryByGenderAndAge    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_DonorRegistryByGenderAndAge]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_DonorRegistryByGenderAndAge]
GO

/****** Object:  Stored Procedure dbo.sps_DonorRegistryByGenderAndAge2    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_DonorRegistryByGenderAndAge2]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_DonorRegistryByGenderAndAge2]
GO

/****** Object:  Stored Procedure dbo.sps_DonorRegistryGetCounts    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_DonorRegistryGetCounts]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_DonorRegistryGetCounts]
GO

/****** Object:  Stored Procedure dbo.sps_DonorRegistrySource    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_DonorRegistrySource]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_DonorRegistrySource]
GO

/****** Object:  Stored Procedure dbo.sps_GetRegistryData    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_GetRegistryData]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_GetRegistryData]
GO

/****** Object:  Stored Procedure dbo.sps_IMPORT_ALL_ImportSuspense    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_IMPORT_ALL_ImportSuspense]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_IMPORT_ALL_ImportSuspense]
GO

/****** Object:  Stored Procedure dbo.sps_IMPORT_A_DataCleanupInvalidAddress    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_IMPORT_A_DataCleanupInvalidAddress]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_IMPORT_A_DataCleanupInvalidAddress]
GO

/****** Object:  Stored Procedure dbo.sps_IMPORT_A_DataCleanupInvalidGender    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_IMPORT_A_DataCleanupInvalidGender]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_IMPORT_A_DataCleanupInvalidGender]
GO

/****** Object:  Stored Procedure dbo.sps_IMPORT_A_DataCleanupUpperDonor    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_IMPORT_A_DataCleanupUpperDonor]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_IMPORT_A_DataCleanupUpperDonor]
GO

/****** Object:  Stored Procedure dbo.sps_IMPORT_A_DataCleanupUpperGender    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_IMPORT_A_DataCleanupUpperGender]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_IMPORT_A_DataCleanupUpperGender]
GO

/****** Object:  Stored Procedure dbo.sps_IMPORT_A_ImportSuspense    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_IMPORT_A_ImportSuspense]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_IMPORT_A_ImportSuspense]
GO

/****** Object:  Stored Procedure dbo.sps_IMPORT_All_ImportArchiveBULK    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_IMPORT_All_ImportArchiveBULK]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_IMPORT_All_ImportArchiveBULK]
GO

/****** Object:  Stored Procedure dbo.sps_IMPORT_B_ImportSuspense    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_IMPORT_B_ImportSuspense]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_IMPORT_B_ImportSuspense]
GO

/****** Object:  Stored Procedure dbo.sps_IMPORT_C_DataCleanupInvalidAddress    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_IMPORT_C_DataCleanupInvalidAddress]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_IMPORT_C_DataCleanupInvalidAddress]
GO

/****** Object:  Stored Procedure dbo.sps_IMPORT_C_ImportSuspense    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_IMPORT_C_ImportSuspense]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_IMPORT_C_ImportSuspense]
GO

/****** Object:  Stored Procedure dbo.sps_IMPORT_ImportInitialize    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_IMPORT_ImportInitialize]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_IMPORT_ImportInitialize]
GO

/****** Object:  Stored Procedure dbo.sps_SourceEvent    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_SourceEvent]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_SourceEvent]
GO

/****** Object:  Stored Procedure dbo.sps_WebUser    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_WebUser]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_WebUser]
GO

/****** Object:  Stored Procedure dbo.sps_WebUserEmail    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_WebUserEmail]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_WebUserEmail]
GO

/****** Object:  Stored Procedure dbo.sps_WebUserLogin    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_WebUserLogin]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_WebUserLogin]
GO

/****** Object:  Stored Procedure dbo.sps_WebUserbyID    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_WebUserbyID]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_WebUserbyID]
GO

/****** Object:  Stored Procedure dbo.spu_ConfirmOnlineRegistrant    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_ConfirmOnlineRegistrant]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spu_ConfirmOnlineRegistrant]
GO

/****** Object:  Stored Procedure dbo.spu_IMPORT_A_DataCleanupDeceasedDate    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_IMPORT_A_DataCleanupDeceasedDate]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spu_IMPORT_A_DataCleanupDeceasedDate]
GO

/****** Object:  Stored Procedure dbo.spu_IMPORT_A_DataCleanupDuplicateLicense    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_IMPORT_A_DataCleanupDuplicateLicense]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spu_IMPORT_A_DataCleanupDuplicateLicense]
GO

/****** Object:  Stored Procedure dbo.spu_IMPORT_A_DataCleanupInvalidDOB    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_IMPORT_A_DataCleanupInvalidDOB]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spu_IMPORT_A_DataCleanupInvalidDOB]
GO

/****** Object:  Stored Procedure dbo.spu_IMPORT_A_DataCleanupInvalidFirstLast    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_IMPORT_A_DataCleanupInvalidFirstLast]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spu_IMPORT_A_DataCleanupInvalidFirstLast]
GO

/****** Object:  Stored Procedure dbo.spu_IMPORT_A_DataCleanupInvalidLicense    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_IMPORT_A_DataCleanupInvalidLicense]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spu_IMPORT_A_DataCleanupInvalidLicense]
GO

/****** Object:  Stored Procedure dbo.spu_IMPORT_All_ImportLog2    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_IMPORT_All_ImportLog2]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spu_IMPORT_All_ImportLog2]
GO

/****** Object:  Stored Procedure dbo.spu_IMPORT_All_ImportLogStats    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_IMPORT_All_ImportLogStats]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spu_IMPORT_All_ImportLogStats]
GO

/****** Object:  Stored Procedure dbo.spu_IMPORT_B_DataCleanupDuplicateLicense    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_IMPORT_B_DataCleanupDuplicateLicense]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spu_IMPORT_B_DataCleanupDuplicateLicense]
GO

/****** Object:  Stored Procedure dbo.spu_IMPORT_B_DataCleanupInvalidDOB    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_IMPORT_B_DataCleanupInvalidDOB]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spu_IMPORT_B_DataCleanupInvalidDOB]
GO

/****** Object:  Stored Procedure dbo.spu_IMPORT_B_DataCleanupInvalidFirstLast    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_IMPORT_B_DataCleanupInvalidFirstLast]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spu_IMPORT_B_DataCleanupInvalidFirstLast]
GO

/****** Object:  Stored Procedure dbo.spu_IMPORT_B_DataCleanupInvalidLicense    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_IMPORT_B_DataCleanupInvalidLicense]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spu_IMPORT_B_DataCleanupInvalidLicense]
GO

/****** Object:  Stored Procedure dbo.spu_IMPORT_C_DataCleanupDuplicateLicense    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_IMPORT_C_DataCleanupDuplicateLicense]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spu_IMPORT_C_DataCleanupDuplicateLicense]
GO

/****** Object:  Stored Procedure dbo.spu_IMPORT_C_DataCleanupInvalidLicense    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_IMPORT_C_DataCleanupInvalidLicense]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spu_IMPORT_C_DataCleanupInvalidLicense]
GO

/****** Object:  Stored Procedure dbo.spu_IMPORT_DataCleanupReplaceEmptyString    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_IMPORT_DataCleanupReplaceEmptyString]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spu_IMPORT_DataCleanupReplaceEmptyString]
GO

/****** Object:  Stored Procedure dbo.spu_IMPORT_DataCleanupTrimBlanks    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_IMPORT_DataCleanupTrimBlanks]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spu_IMPORT_DataCleanupTrimBlanks]
GO

/****** Object:  Stored Procedure dbo.spu_IMPORT_ImportLog1    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_IMPORT_ImportLog1]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spu_IMPORT_ImportLog1]
GO

/****** Object:  Stored Procedure dbo.spu_SetOnlineMailerDate    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_SetOnlineMailerDate]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spu_SetOnlineMailerDate]
GO

/****** Object:  Stored Procedure dbo.spu_Suspense_B_CleanUpLicenseDups    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_Suspense_B_CleanUpLicenseDups]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spu_Suspense_B_CleanUpLicenseDups]
GO

/****** Object:  Stored Procedure dbo.spui_RegistryTest    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spui_RegistryTest]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spui_RegistryTest]
GO

/****** Object:  Stored Procedure dbo.SPS_CheckRegistry_DMV    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SPS_CheckRegistry_DMV]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SPS_CheckRegistry_DMV]
GO

/****** Object:  Stored Procedure dbo.SPS_CheckRegistry_DMVNEOB    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SPS_CheckRegistry_DMVNEOB]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SPS_CheckRegistry_DMVNEOB]
GO

/****** Object:  Stored Procedure dbo.SPS_CheckRegistry_DMVv2    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SPS_CheckRegistry_DMVv2]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SPS_CheckRegistry_DMVv2]
GO

/****** Object:  Stored Procedure dbo.SPS_CheckRegistry_REGLoad    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SPS_CheckRegistry_REGLoad]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SPS_CheckRegistry_REGLoad]
GO

/****** Object:  Stored Procedure dbo.sp_RebuildIndex    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_RebuildIndex]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_RebuildIndex]
GO

/****** Object:  Stored Procedure dbo.spf_CreateDMVADDRTempTable    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spf_CreateDMVADDRTempTable]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spf_CreateDMVADDRTempTable]
GO

/****** Object:  Stored Procedure dbo.spf_CreateDMVTempTable    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spf_CreateDMVTempTable]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spf_CreateDMVTempTable]
GO

/****** Object:  Stored Procedure dbo.spf_DropDMVADDRTable    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spf_DropDMVADDRTable]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spf_DropDMVADDRTable]
GO

/****** Object:  Stored Procedure dbo.spf_DropDMVTable    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spf_DropDMVTable]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spf_DropDMVTable]
GO

/****** Object:  Stored Procedure dbo.spi_IMPORT_ImportInitializeTest    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_IMPORT_ImportInitializeTest]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spi_IMPORT_ImportInitializeTest]
GO

/****** Object:  Stored Procedure dbo.spi_SourceEvent    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_SourceEvent]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spi_SourceEvent]
GO

/****** Object:  Stored Procedure dbo.sps_CheckRegistryv2    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_CheckRegistryv2]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_CheckRegistryv2]
GO

/****** Object:  Stored Procedure dbo.sps_CheckRegistryv2Test    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_CheckRegistryv2Test]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_CheckRegistryv2Test]
GO

/****** Object:  Stored Procedure dbo.sps_DMVwildcard    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_DMVwildcard]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_DMVwildcard]
GO

/****** Object:  Stored Procedure dbo.sps_GetServerDB    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_GetServerDB]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_GetServerDB]
GO

/****** Object:  Stored Procedure dbo.sps_IMPORT_A_DataCleanupReplaceNonAlphaName    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_IMPORT_A_DataCleanupReplaceNonAlphaName]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_IMPORT_A_DataCleanupReplaceNonAlphaName]
GO

/****** Object:  Stored Procedure dbo.sps_checkregistry_DMVLoad    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_checkregistry_DMVLoad]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_checkregistry_DMVLoad]
GO

/****** Object:  Stored Procedure dbo.spu_SourceEvent    Script Date: 1/11/2008 10:58:58 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_SourceEvent]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spu_SourceEvent]
GO


/****** Object:  Login citrixadmin    Script Date: 1/11/2008 10:58:50 AM ******/
if not exists (select * from master.dbo.syslogins where loginname = N'citrixadmin')
BEGIN
	declare @logindb nvarchar(132), @loginlang nvarchar(132) select @logindb = N'DMV_CO', @loginlang = N'us_english'
	if @logindb is null or not exists (select * from master.dbo.sysdatabases where name = @logindb)
		select @logindb = N'master'
	if @loginlang is null or (not exists (select * from master.dbo.syslanguages where name = @loginlang) and @loginlang <> N'us_english')
		select @loginlang = @@language
	exec sp_addlogin N'citrixadmin', null, @logindb, @loginlang
END

/****** Object:  Login distributor_admin    Script Date: 1/11/2008 10:58:50 AM ******/
if not exists (select * from master.dbo.syslogins where loginname = N'distributor_admin')
BEGIN
	declare @logindb nvarchar(132), @loginlang nvarchar(132) select @logindb = N'master', @loginlang = N'us_english'
	if @logindb is null or not exists (select * from master.dbo.sysdatabases where name = @logindb)
		select @logindb = N'master'
	if @loginlang is null or (not exists (select * from master.dbo.syslanguages where name = @loginlang) and @loginlang <> N'us_english')
		select @loginlang = @@language
	exec sp_addlogin N'distributor_admin', null, @logindb, @loginlang
END

/****** Object:  Login dmv_co    Script Date: 1/11/2008 10:58:50 AM ******/
if not exists (select * from master.dbo.syslogins where loginname = N'dmv_co')
BEGIN
	declare @logindb nvarchar(132), @loginlang nvarchar(132) select @logindb = N'master', @loginlang = N'us_english'
	if @logindb is null or not exists (select * from master.dbo.sysdatabases where name = @logindb)
		select @logindb = N'master'
	if @loginlang is null or (not exists (select * from master.dbo.syslanguages where name = @loginlang) and @loginlang <> N'us_english')
		select @loginlang = @@language
	exec sp_addlogin N'dmv_co', null, @logindb, @loginlang
END

/****** Object:  Login DOGGY\Administrator    Script Date: 1/11/2008 10:58:50 AM ******/
if not exists (select * from master.dbo.syslogins where loginname = N'DOGGY\Administrator')
BEGIN
	exec sp_grantlogin N'DOGGY\Administrator'
	exec sp_defaultdb N'DOGGY\Administrator', N'master'
	exec sp_defaultlanguage N'DOGGY\Administrator', N'us_english'
END

/****** Object:  Login DOGGY\clifford_sql    Script Date: 1/11/2008 10:58:50 AM ******/
if not exists (select * from master.dbo.syslogins where loginname = N'DOGGY\clifford_sql')
BEGIN
	exec sp_grantlogin N'DOGGY\clifford_sql'
	exec sp_defaultdb N'DOGGY\clifford_sql', N'master'
	exec sp_defaultlanguage N'DOGGY\clifford_sql', N'us_english'
END

/****** Object:  Login dt    Script Date: 1/11/2008 10:58:50 AM ******/
if not exists (select * from master.dbo.syslogins where loginname = N'dt')
BEGIN
	declare @logindb nvarchar(132), @loginlang nvarchar(132) select @logindb = N'DMV_WY', @loginlang = N'us_english'
	if @logindb is null or not exists (select * from master.dbo.sysdatabases where name = @logindb)
		select @logindb = N'master'
	if @loginlang is null or (not exists (select * from master.dbo.syslanguages where name = @loginlang) and @loginlang <> N'us_english')
		select @loginlang = @@language
	exec sp_addlogin N'dt', null, @logindb, @loginlang
END

/****** Object:  Login dtcaoladmin    Script Date: 1/11/2008 10:58:50 AM ******/
if not exists (select * from master.dbo.syslogins where loginname = N'dtcaoladmin')
BEGIN
	declare @logindb nvarchar(132), @loginlang nvarchar(132) select @logindb = N'DMV_VT', @loginlang = N'us_english'
	if @logindb is null or not exists (select * from master.dbo.sysdatabases where name = @logindb)
		select @logindb = N'master'
	if @loginlang is null or (not exists (select * from master.dbo.syslanguages where name = @loginlang) and @loginlang <> N'us_english')
		select @loginlang = @@language
	exec sp_addlogin N'dtcaoladmin', null, @logindb, @loginlang
END

/****** Object:  Login dttxlgadmin    Script Date: 1/11/2008 10:58:50 AM ******/
if not exists (select * from master.dbo.syslogins where loginname = N'dttxlgadmin')
BEGIN
	declare @logindb nvarchar(132), @loginlang nvarchar(132) select @logindb = N'master', @loginlang = N'us_english'
	if @logindb is null or not exists (select * from master.dbo.sysdatabases where name = @logindb)
		select @logindb = N'master'
	if @loginlang is null or (not exists (select * from master.dbo.syslanguages where name = @loginlang) and @loginlang <> N'us_english')
		select @loginlang = @@language
	exec sp_addlogin N'dttxlgadmin', null, @logindb, @loginlang
END

/****** Object:  Login saUtil    Script Date: 1/11/2008 10:58:50 AM ******/
if not exists (select * from master.dbo.syslogins where loginname = N'saUtil')
BEGIN
	declare @logindb nvarchar(132), @loginlang nvarchar(132) select @logindb = N'master', @loginlang = N'us_english'
	if @logindb is null or not exists (select * from master.dbo.sysdatabases where name = @logindb)
		select @logindb = N'master'
	if @loginlang is null or (not exists (select * from master.dbo.syslanguages where name = @loginlang) and @loginlang <> N'us_english')
		select @loginlang = @@language
	exec sp_addlogin N'saUtil', null, @logindb, @loginlang
END

/****** Object:  Login statfileadmin    Script Date: 1/11/2008 10:58:50 AM ******/
if not exists (select * from master.dbo.syslogins where loginname = N'statfileadmin')
BEGIN
	declare @logindb nvarchar(132), @loginlang nvarchar(132) select @logindb = N'_ReferralDev1', @loginlang = N'us_english'
	if @logindb is null or not exists (select * from master.dbo.sysdatabases where name = @logindb)
		select @logindb = N'master'
	if @loginlang is null or (not exists (select * from master.dbo.syslanguages where name = @loginlang) and @loginlang <> N'us_english')
		select @loginlang = @@language
	exec sp_addlogin N'statfileadmin', null, @logindb, @loginlang
END

/****** Object:  Login stattracadmin    Script Date: 1/11/2008 10:58:50 AM ******/
if not exists (select * from master.dbo.syslogins where loginname = N'stattracadmin')
BEGIN
	declare @logindb nvarchar(132), @loginlang nvarchar(132) select @logindb = N'_ReferralProdReport', @loginlang = N'us_english'
	if @logindb is null or not exists (select * from master.dbo.sysdatabases where name = @logindb)
		select @logindb = N'master'
	if @loginlang is null or (not exists (select * from master.dbo.syslanguages where name = @loginlang) and @loginlang <> N'us_english')
		select @loginlang = @@language
	exec sp_addlogin N'stattracadmin', null, @logindb, @loginlang
END

/****** Object:  Login streportadmin    Script Date: 1/11/2008 10:58:50 AM ******/
if not exists (select * from master.dbo.syslogins where loginname = N'streportadmin')
BEGIN
	declare @logindb nvarchar(132), @loginlang nvarchar(132) select @logindb = N'master', @loginlang = N'us_english'
	if @logindb is null or not exists (select * from master.dbo.sysdatabases where name = @logindb)
		select @logindb = N'master'
	if @loginlang is null or (not exists (select * from master.dbo.syslanguages where name = @loginlang) and @loginlang <> N'us_english')
		select @loginlang = @@language
	exec sp_addlogin N'streportadmin', null, @logindb, @loginlang
END

/****** Object:  Login Doggy\it dev    Script Date: 1/11/2008 10:58:50 AM ******/
if not exists (select * from master.dbo.syslogins where loginname = N'Doggy\it dev')
BEGIN
	exec sp_grantlogin N'Doggy\it dev'
	exec sp_defaultdb N'Doggy\it dev', N'Northwind'
	exec sp_defaultlanguage N'Doggy\it dev', N'us_english'
END

/****** Object:  Login distributor_admin    Script Date: 1/11/2008 10:58:50 AM ******/
exec sp_addsrvrolemember N'distributor_admin', sysadmin

/****** Object:  Login DOGGY\Administrator    Script Date: 1/11/2008 10:58:50 AM ******/
exec sp_addsrvrolemember N'DOGGY\Administrator', sysadmin

/****** Object:  Login DOGGY\clifford_sql    Script Date: 1/11/2008 10:58:50 AM ******/
exec sp_addsrvrolemember N'DOGGY\clifford_sql', sysadmin

/****** Object:  Login dt    Script Date: 1/11/2008 10:58:50 AM ******/
exec sp_addsrvrolemember N'dt', sysadmin

/****** Object:  Login dttxlgadmin    Script Date: 1/11/2008 10:58:50 AM ******/
exec sp_addsrvrolemember N'dttxlgadmin', sysadmin

/****** Object:  Login saUtil    Script Date: 1/11/2008 10:58:50 AM ******/
exec sp_addsrvrolemember N'saUtil', sysadmin

/****** Object:  Login stattracadmin    Script Date: 1/11/2008 10:58:50 AM ******/
exec sp_addsrvrolemember N'stattracadmin', sysadmin

/****** Object:  User dbo    Script Date: 1/11/2008 10:58:50 AM ******/
/****** Object:  User stattracadmin    Script Date: 1/11/2008 10:58:50 AM ******/
if not exists (select * from dbo.sysusers where name = N'stattracadmin' and uid < 16382)
BEGIN
	EXEC sp_grantdbaccess N'stattracadmin'
END

/****** Object:  User streportadmin    Script Date: 1/11/2008 10:58:50 AM ******/
if not exists (select * from dbo.sysusers where name = N'streportadmin' and uid < 16382)
BEGIN
	EXEC sp_grantdbaccess N'streportadmin'
END

/****** Object:  User stattracadmin    Script Date: 1/11/2008 10:58:50 AM ******/
exec sp_addrolemember N'db_owner', N'stattracadmin'

/****** Object:  User streportadmin    Script Date: 1/11/2008 10:58:50 AM ******/
exec sp_addrolemember N'db_owner', N'streportadmin'


SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  User Defined Function dbo.REMOVE_BAD255    Script Date: 1/11/2008 10:59:14 AM ******/


CREATE  FUNCTION dbo.REMOVE_BAD255 (@strName varchar (255))
RETURNS varchar (255)
AS
BEGIN

	--Loops through passed code to remove special characters
	WHILE PATINDEX('%[^a-z^A-Z]%',@strName) > 0 
	  AND PATINDEX('%[^a-z^A-Z]%',@strName) <= LEN(@strName)	
	BEGIN 
		SET @strName = REPLACE(@strName, SUBSTRING(@strName, (PATINDEX ('%[^a-z^A-Z]%',@strName)), 1),'')
	END

	RETURN(@strName)

END



GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Create tables if not existing ******/
IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'ACCESSTYPE')
BEGIN
	PRINT 'Creating Table ACCESSTYPE'
	CREATE TABLE [dbo].[ACCESSTYPE] (
		[AccessID] [int] NOT NULL ,
		[Access] [int] NOT NULL ,
		[AccessName] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
		[AccessDescription] [varchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
	) ON [PRIMARY]
END

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'ADDRTYPE')
BEGIN
	PRINT 'Creating Table ADDRTYPE'
	CREATE TABLE [dbo].[ADDRTYPE] (
		[ID] [int] NOT NULL ,
		[Description] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
		[msrepl_tran_version] [uniqueidentifier] NOT NULL 
	) ON [PRIMARY]
END

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'DMV')
BEGIN
	PRINT 'Creating Table DMV'
	CREATE TABLE [dbo].[DMV] (
	[ID] [int] IDENTITY (1, 1) NOT NULL ,
	[ImportLogID] [int] NULL ,
	[SSN] [varchar] (11) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[License] [varchar] (9) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[DOB] [datetime] NULL ,
	[FirstName] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[MiddleName] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[LastName] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Suffix] [varchar] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Gender] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Donor] [bit] NOT NULL ,
	[RenewalDate] [datetime] NULL ,
	[DeceasedDate] [datetime] NULL ,
	[CSORState] [varchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CSORLicense] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[UserID] [int] NULL ,
	[LastModified] [datetime] NULL ,
	[CreateDate] [datetime] NULL ,
	[SignupDate] [datetime] NULL,
 	[PreviousDonorState] varchar(50) NULL
) ON [PRIMARY]
END

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'DMVARCHIVE')
BEGIN
	PRINT 'Creating Table DMVARCHIVE'
	CREATE TABLE [dbo].[DMVARCHIVE] (
		[ID] [int] NOT NULL ,
		[ImportLogID] [int] NULL ,
		[SSN] [varchar] (11) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
		[License] [varchar] (9) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
		[DOB] [datetime] NULL ,
		[FirstName] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
		[MiddleName] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
		[LastName] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
		[Suffix] [varchar] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
		[Gender] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
		[Donor] [bit] NOT NULL ,
		[RenewalDate] [datetime] NULL ,
		[DeceasedDate] [datetime] NULL ,
		[CSORState] [varchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
		[CSORLicense] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
		[UserID] [int] NULL ,
		[LastModified] [datetime] NULL ,
		[CreateDate] [datetime] NULL ,
		[DisplacedBy] [int] NULL ,
		[RecordType] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
	) ON [PRIMARY]
END

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'DMVARCHIVEADDR')
BEGIN
	PRINT 'Creating Table DMVARCHIVEADDR'
		CREATE TABLE [dbo].[DMVARCHIVEADDR] (
		[ID] [int] NOT NULL ,
		[DMVArchiveID] [int] NULL ,
		[AddrTypeID] [int] NULL ,
		[Addr1] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
		[Addr2] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
		[City] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
		[State] [varchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
		[Zip] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
		[UserID] [int] NULL ,
		[LastModified] [datetime] NULL ,
		[CreateDate] [datetime] NULL 
	) ON [PRIMARY]
END

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'DMVARCHIVEORGAN')
BEGIN
	PRINT 'Creating Table DMVARCHIVEORGAN'
	CREATE TABLE [dbo].[DMVARCHIVEORGAN] (
	[ID] [int] NOT NULL ,
	[DMVArchiveID] [int] NULL ,
	[OrganTypeID] [int] NULL ,
	[LastModified] [datetime] NULL ,
	[CreateDate] [datetime] NULL 
	) ON [PRIMARY]
END

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'DMVARCHIVETYPE')
BEGIN
	PRINT 'Creating Table DMVARCHIVETYPE'
	CREATE TABLE [dbo].[DMVARCHIVETYPE] (
		[ID] [int] IDENTITY (1, 1) NOT NULL ,
		[description] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
	) ON [PRIMARY]
END

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'EventSourceCodes')
BEGIN
	PRINT 'Creating Table EventSourceCodes'
	CREATE TABLE [dbo].[EventSourceCodes] (
		[SourceCodeID] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
		[SourceCodeName] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
		[SourceCodeNote] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
	) ON [PRIMARY]
END

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'IMPORT')
BEGIN
	PRINT 'Creating Table IMPORT'
	CREATE TABLE [dbo].[IMPORT] (
	[ID] [int] IDENTITY (1, 1) NOT NULL ,
	[IMPORTLOGID] [int] NULL ,
	[LAST] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[FIRST] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[MIDDLE] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SUFFIX] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[AADDR1] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ACITY] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ASTATE] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[AZIP] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[BADDR1] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[BCITY] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[BSTATE] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[BZIP] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[DOB] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[GENDER] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[LICENSE] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[DONOR] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[RENEWALDATE] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[DECEASEDDATE] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CSORSTATE] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CSORLICENSE] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CREATEDATE] [smalldatetime] NULL 
) ON [PRIMARY]
END

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'IMPORTARCHIVE')
BEGIN
	PRINT 'Creating Table IMPORTARCHIVE'
	CREATE TABLE [dbo].[IMPORTARCHIVE] (
	[ID] [int] NOT NULL ,
	[IMPORTLOGID] [int] NULL ,
	[LAST] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[FIRST] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[MIDDLE] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SUFFIX] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[AADDR1] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ACITY] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ASTATE] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[AZIP] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[BADDR1] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[BCITY] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[BSTATE] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[BZIP] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[DOB] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[GENDER] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[LICENSE] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[DONOR] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[RENEWALDATE] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[DECEASEDDATE] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CSORSTATE] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CSORLICENSE] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[LastModified] [datetime] NULL ,
	[CreateDate] [datetime] NULL 
) ON [PRIMARY]
END

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'IMPORTARCHIVE_A')
BEGIN
	PRINT 'Creating Table IMPORTARCHIVE_A'
	CREATE TABLE [dbo].[IMPORTARCHIVE_A] (
	[ID] [int] NOT NULL ,
	[IMPORTLOGID] [int] NULL ,
	[LAST] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[FIRST] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[MIDDLE] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SUFFIX] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[AADDR1] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ACITY] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ASTATE] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[AZIP] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[BADDR1] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[BCITY] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[BSTATE] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[BZIP] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[DOB] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[GENDER] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[LICENSE] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[DONOR] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[RENEWALDATE] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[DECEASEDDATE] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CSORSTATE] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CSORLICENSE] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[LastModified] [datetime] NULL ,
	[CreateDate] [datetime] NULL 
) ON [PRIMARY]
END

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'IMPORTARCHIVE_B')
BEGIN
	PRINT 'Creating Table IMPORTARCHIVE_B'
	CREATE TABLE [dbo].[IMPORTARCHIVE_B] (
	[ID] [int] NOT NULL ,
	[IMPORTLOGID] [int] NULL ,
	[LICENSE] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[LAST] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[FIRST] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[MIDDLE] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SUFFIX] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[DATEOFCHANGE] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[TIMEOFCHANGE] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[DOB] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[FILMNUM] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[USERID] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[DATEOFMOD] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[TIMEOFMOD] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[LastModified] [datetime] NULL ,
	[CreateDate] [datetime] NULL 
) ON [PRIMARY]
END

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'IMPORTARCHIVE_C')
BEGIN
	PRINT 'Creating Table IMPORTARCHIVE_C'
	CREATE TABLE [dbo].[IMPORTARCHIVE_C] (
	[ID] [int] NOT NULL ,
	[IMPORTLOGID] [int] NULL ,
	[LICENSE] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[AADDR1] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ACITY] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ASTATE] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[AZIP] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[BADDR1] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[BCITY] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[BSTATE] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[BZIP] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[LastModified] [datetime] NULL ,
	[CreateDate] [datetime] NULL 
) ON [PRIMARY]
END

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'IMPORTFILES')
BEGIN
	PRINT 'Creating Table IMPORTFILES'
	CREATE TABLE [dbo].[IMPORTFILES] (
	[TableName] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[FileName] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[WorkOrder] [int] NULL 
) ON [PRIMARY]
END

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'IMPORTLOG')
BEGIN
	PRINT 'Creating Table IMPORTLOG'
	CREATE TABLE [dbo].[IMPORTLOG] (
	[ID] [int] IDENTITY (1, 1) NOT NULL ,
	[RunStart] [datetime] NULL ,
	[RunEnd] [datetime] NULL ,
	[RunStatus] [varchar] (12) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[RecordsTotal] [int] NULL ,
	[RecordsSuspended] [int] NULL ,
	[RecordsAdded] [int] NULL ,
	[RecordsUpdated] [int] NULL ,
	[LastModified] [datetime] NULL ,
	[CreateDate] [datetime] NULL 
) ON [PRIMARY]
END

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'IMPORTLOGSTATS')
BEGIN
	PRINT 'Creating Table IMPORTLOGSTATS'
	CREATE TABLE [dbo].[IMPORTLOGSTATS] (
	[ID] [int] NOT NULL ,
	[RunStart] [datetime] NULL ,
	[RunEnd] [datetime] NULL ,
	[RunStatus] [varchar] (12) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[RTotal] [int] NULL ,
	[RSuspended] [int] NULL ,
	[RAdded] [int] NULL ,
	[RUpdated] [int] NULL ,
	[RDonorY] [int] NULL ,
	[RDonorChange] [int] NULL ,
	[RM] [int] NULL ,
	[RF] [int] NULL ,
	[RMDonorY] [int] NULL ,
	[RFDonorY] [int] NULL ,
	[RM18Total] [int] NULL ,
	[RM18DonorY] [int] NULL ,
	[RF18Total] [int] NULL ,
	[RF18DonorY] [int] NULL ,
	[RM17Total] [int] NULL ,
	[RM17DonorY] [int] NULL ,
	[RF17Total] [int] NULL ,
	[RF17DonorY] [int] NULL ,
	[LastModified] [datetime] NULL ,
	[CreateDate] [datetime] NULL 
) ON [PRIMARY]
END

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'IMPORT_A')
BEGIN
	PRINT 'Creating Table IMPORT_A'
	CREATE TABLE [dbo].[IMPORT_A] (
	[ID] [int] IDENTITY (1, 1) NOT NULL ,
	[IMPORTLOGID] [int] NULL ,
	[LAST] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[FIRST] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[MIDDLE] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SUFFIX] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[AADDR1] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ACITY] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ASTATE] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[AZIP] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[BADDR1] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[BCITY] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[BSTATE] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[BZIP] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[DOB] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[GENDER] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[LICENSE] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[DONOR] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[RENEWALDATE] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[DECEASEDDATE] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CSORSTATE] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CSORLICENSE] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
END

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'IMPORT_B')
BEGIN
	PRINT 'Creating Table IMPORT_B'
	CREATE TABLE [dbo].[IMPORT_B] (
	[ID] [int] IDENTITY (1, 1) NOT NULL ,
	[IMPORTLOGID] [int] NULL ,
	[LICENSE] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[LAST] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[FIRST] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[MIDDLE] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SUFFIX] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[DATEOFCHANGE] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[TIMEOFCHANGE] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[DOB] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[FILMNUM] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[USERID] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[DATEOFMOD] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[TIMEOFMOD] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
END

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'IMPORT_C')
BEGIN
	PRINT 'Creating Table IMPORT_C'
	CREATE TABLE [dbo].[IMPORT_C] (
	[ID] [int] IDENTITY (1, 1) NOT NULL ,
	[IMPORTLOGID] [int] NULL ,
	[LICENSE] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[AADDR1] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ACITY] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ASTATE] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[AZIP] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[BADDR1] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[BCITY] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[BSTATE] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[BZIP] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
END

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'IMPORT_D')
BEGIN
	PRINT 'Creating Table IMPORT_D'
	CREATE TABLE [dbo].[IMPORT_D] (
	[ImportFile] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ImportFileSize] [int] NOT NULL ,
	[TableCount] [int] NULL 
) ON [PRIMARY]
END

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'Import_Adds')
BEGIN
	PRINT 'Creating Table Import_Adds'
	CREATE TABLE [dbo].[Import_Adds] (
	[ID] [int] IDENTITY (1, 1) NOT NULL ,
	[ImportLogId] [int] NULL ,
	[Last] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[First] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Middle] [varchar] (12) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Suffix] [varchar] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[AAddr1] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ACity] [varchar] (24) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[AState] [varchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[AZip] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[AZipExt] [varchar] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[BAddr1] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[BCity] [varchar] (24) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[BState] [varchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[BZip] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[DOB] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Gender] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[LicenseType] [varchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[License] [varchar] (9) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[IssueDate] [varchar] (8) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ExpirationDate] [varbinary] (8) NULL ,
	[Donor] [varchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[RenewalDate] [varchar] (8) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[DeceasedDate] [varchar] (8) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CSORState] [varchar] (8) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CSORLicense] [varchar] (8) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CreateDate] [smalldatetime] NULL 
) ON [PRIMARY]
END

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'Import_Deletes')
BEGIN
	PRINT 'Creating Table Import_Deletes'
	CREATE TABLE [dbo].[Import_Deletes] (
	[ID] [int] IDENTITY (1, 1) NOT NULL ,
	[ImportLogId] [int] NULL ,
	[Last] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[First] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Middle] [varchar] (12) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Suffix] [varchar] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[AAddr1] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ACity] [varchar] (24) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[AState] [varchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[AZip] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[AZipExt] [varchar] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[BAddr1] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[BCity] [varchar] (24) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[BState] [varchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[BZip] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[DOB] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Gender] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[LicenseType] [varchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[License] [varchar] (9) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[IssueDate] [varchar] (8) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ExpirationDate] [varbinary] (8) NULL ,
	[Donor] [varchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[RenewalDate] [varchar] (8) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[DeceasedDate] [varchar] (8) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CSORState] [varchar] (8) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CSORLicense] [varchar] (8) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CreateDate] [smalldatetime] NULL 
) ON [PRIMARY]
END

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'VT_Donor_Registry')
BEGIN
	PRINT 'Creating Table VT_Donor_Registry'
	CREATE TABLE [dbo].[VT_Donor_Registry] (
	[NH_Donor_RegistryID] [int] NOT NULL ,
	[NH_DMV_RegistryID] [int] NULL ,
	[FIRST] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[MIDDLE] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[LAST] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SUFFIX] [varchar] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ADDR1] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ADDR2] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CITY] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[STATE] [varchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ZIP1] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ZIP2] [varchar] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[DOB] [datetime] NULL ,
	[RACE] [int] NULL ,
	[SEX] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SSN] [varchar] (11) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[LICENSE] [varchar] (9) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[PHONE] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[EYECOLOR] [varchar] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[AADDR1] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[AADDR2] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ACITY] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ASTATE] [varchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[AZIP1] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[AZIP2] [varchar] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[DONOR] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Comment] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[OnlineRegDate] [datetime] NULL ,
	[SignatureDate] [datetime] NULL ,
	[DeleteFlag] [bit] NULL ,
	[DeleteDate] [datetime] NULL ,
	[DeletedByID] [int] NULL ,
	[DonorStatus] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SourceCode] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[UserID] [int] NULL ,
	[LastModified] [datetime] NULL 
) ON [PRIMARY]
END

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'VT_OnLine_Registry')
BEGIN
	PRINT 'Creating Table VT_OnLine_Registry'
	CREATE TABLE [dbo].[VT_OnLine_Registry] (
	[NH_OnLine_RegistryID] [int] NOT NULL ,
	[FIRST] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[MIDDLE] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[LAST] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SUFFIX] [varchar] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ADDR1] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ADDR2] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CITY] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[STATE] [varchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ZIP1] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ZIP2] [varchar] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[DOB] [datetime] NULL ,
	[RACE] [int] NULL ,
	[SEX] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SSN] [varchar] (11) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[LICENSE] [varchar] (9) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[PHONE] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[AADDR1] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[AADDR2] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ACITY] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ASTATE] [varchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[AZIP1] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[AZIP2] [varchar] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[DONOR] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Comment] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SignatureDate] [datetime] NULL ,
	[MailerDate] [datetime] NULL ,
	[DeleteFlag] [bit] NULL ,
	[DeleteDate] [datetime] NULL ,
	[DeletedByID] [int] NULL ,
	[DonorStatus] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[UserID] [int] NULL ,
	[LastModified] [datetime] NULL 
) ON [PRIMARY]
END

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'ORGANTYPE')
BEGIN
	PRINT 'Creating Table ORGANTYPE'
	CREATE TABLE [dbo].[ORGANTYPE] (
	[ID] [int] NOT NULL ,
	[Code] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Description] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[msrepl_tran_version] [uniqueidentifier] NOT NULL 
) ON [PRIMARY]
END

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'QueryLog')
BEGIN
	PRINT 'Creating Table QueryLog'
	CREATE TABLE [dbo].[QueryLog] (
	[QueryLogID] [int] IDENTITY (1, 1) NOT NULL ,
	[QueryLogDateTime] [datetime] NULL ,
	[QueryLogNumber] [int] NULL ,
	[QueryLogComputer] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[QueryLogSource] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[QueryLogLocation] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[QueryLogDescription] [varchar] (8000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
END

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'REGISTRY')
BEGIN
	PRINT 'Creating Table REGISTRY'
	CREATE TABLE [dbo].[REGISTRY] (
	[ID] [int] IDENTITY (1, 1) NOT NULL ,
	[SSN] [varchar] (11) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[DOB] [datetime] NULL ,
	[FirstName] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[MiddleName] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[LastName] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Suffix] [varchar] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Gender] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Race] [int] NULL ,
	[EyeColor] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Phone] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Comment] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[DMVID] [int] NULL ,
	[License] [varchar] (9) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[DMVDonor] [bit] NOT NULL ,
	[Donor] [bit] NOT NULL ,
	[DonorConfirmed] [bit] NOT NULL ,
	[SourceCode] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[OnlineRegDate] [datetime] NULL ,
	[SignatureDate] [datetime] NULL ,
	[MailerDate] [datetime] NULL ,
	[DeleteFlag] [bit] NOT NULL ,
	[DeleteDate] [datetime] NULL ,
	[DeletedByID] [int] NULL ,
	[UserID] [int] NULL ,
	[LastModified] [datetime] NULL ,
	[CreateDate] [datetime] NULL ,
	[DeceasedDate] [datetime] NULL ,
	[msrepl_tran_version] [uniqueidentifier] NOT NULL 
) ON [PRIMARY]
END

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'REGISTRYADDR')
BEGIN
	PRINT 'Creating Table REGISTRYADDR'
	CREATE TABLE [dbo].[REGISTRYADDR] (
	[ID] [int] IDENTITY (1, 1) NOT NULL ,
	[RegistryID] [int] NULL ,
	[AddrTypeID] [int] NULL ,
	[Addr1] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Addr2] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[City] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[State] [varchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Zip] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[UserID] [int] NULL ,
	[LastModified] [datetime] NULL ,
	[CreateDate] [datetime] NULL ,
	[msrepl_tran_version] [uniqueidentifier] NOT NULL 
) ON [PRIMARY]
END

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'REGISTRYARCHIVE')
BEGIN
	PRINT 'Creating Table REGISTRYARCHIVE'
	CREATE TABLE [dbo].[REGISTRYARCHIVE] (
	[ID] [int] NOT NULL ,
	[SSN] [varchar] (11) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[DOB] [datetime] NULL ,
	[FirstName] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[MiddleName] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[LastName] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Suffix] [varchar] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Gender] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Race] [int] NULL ,
	[EyeColor] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Phone] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Comment] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[DMVID] [int] NULL ,
	[License] [varchar] (9) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[DMVDonor] [bit] NOT NULL ,
	[Donor] [bit] NOT NULL ,
	[DonorConfirmed] [bit] NOT NULL ,
	[SourceCode] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[OnlineRegDate] [datetime] NULL ,
	[SignatureDate] [datetime] NULL ,
	[MailerDate] [datetime] NULL ,
	[DeleteFlag] [bit] NOT NULL ,
	[DeleteDate] [datetime] NULL ,
	[DeletedByID] [int] NULL ,
	[UserID] [int] NULL ,
	[LastModified] [datetime] NULL ,
	[CreateDate] [datetime] NULL ,
	[DeceasedDate] [datetime] NULL ,
	[ArchiveType] [int] NULL 
) ON [PRIMARY]
END

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'REGISTRYARCHIVEADDR')
BEGIN
	PRINT 'Creating Table REGISTRYARCHIVEADDR'
	CREATE TABLE [dbo].[REGISTRYARCHIVEADDR] (
	[ID] [int] NOT NULL ,
	[REGISTRYARCHIVEID] [int] NULL ,
	[AddrTypeID] [int] NULL ,
	[Addr1] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Addr2] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[City] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[State] [varchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Zip] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[UserID] [int] NULL ,
	[LastModified] [datetime] NULL ,
	[CreateDate] [datetime] NULL 
) ON [PRIMARY]
END

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'REGISTRYARCHIVETYPE')
BEGIN
	PRINT 'Creating Table REGISTRYARCHIVETYPE'
	CREATE TABLE [dbo].[REGISTRYARCHIVETYPE] (
	[ID] [int] IDENTITY (1, 1) NOT NULL ,
	[description] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
) ON [PRIMARY]
END

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'REGISTRYORGAN')
BEGIN
	PRINT 'Creating Table REGISTRYORGAN'
	CREATE TABLE [dbo].[REGISTRYORGAN] (
	[ID] [int] IDENTITY (1, 1) NOT NULL ,
	[RegistryID] [int] NOT NULL ,
	[OrganTypeID] [int] NOT NULL ,
	[LastModified] [datetime] NULL ,
	[CreateDate] [datetime] NULL ,
	[msrepl_tran_version] [uniqueidentifier] NOT NULL 
) ON [PRIMARY]
END

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'RegistryEventSourceCodes')
BEGIN
	PRINT 'Creating Table RegistryEventSourceCodes'
	CREATE TABLE [dbo].[RegistryEventSourceCodes] (
	[SourceCodeID] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[SourceCodeName] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[SourceCodeNote] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[msrepl_tran_version] [uniqueidentifier] NOT NULL 
) ON [PRIMARY]
END

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'SUSPENSE')
BEGIN
	PRINT 'Creating Table SUSPENSE'
	CREATE TABLE [dbo].[SUSPENSE] (
	[ID] [int] NULL ,
	[IMPORTLOGID] [int] NULL ,
	[LAST] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[FIRST] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[MIDDLE] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SUFFIX] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[AADDR1] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ACITY] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ASTATE] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[AZIP] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[BADDR1] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[BCITY] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[BSTATE] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[BZIP] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[DOB] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[GENDER] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[LICENSE] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[DONOR] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[RENEWALDATE] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[DECEASEDDATE] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CSORSTATE] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CSORLICENSE] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[OK] [bit] NOT NULL ,
	[REASON] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
END

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'SUSPENSE_A')
BEGIN
	PRINT 'Creating Table SUSPENSE_A'
	CREATE TABLE [dbo].[SUSPENSE_A] (
	[ID] [int] NOT NULL ,
	[IMPORTLOGID] [int] NULL ,
	[LAST] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[FIRST] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[MIDDLE] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SUFFIX] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[AADDR1] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ACITY] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ASTATE] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[AZIP] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[BADDR1] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[BCITY] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[BSTATE] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[BZIP] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[DOB] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[GENDER] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[LICENSE] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[DONOR] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[RENEWALDATE] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[DECEASEDDATE] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CSORSTATE] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CSORLICENSE] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[OK] [bit] NOT NULL ,
	[REASON] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
END

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'SUSPENSE_B')
BEGIN
	PRINT 'Creating Table SUSPENSE_B'
	CREATE TABLE [dbo].[SUSPENSE_B] (
	[ID] [int] NOT NULL ,
	[IMPORTLOGID] [int] NULL ,
	[LICENSE] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[LAST] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[FIRST] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[MIDDLE] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SUFFIX] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[DATEOFCHANGE] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[TIMEOFCHANGE] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[DOB] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[FILMNUM] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[USERID] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[DATEOFMOD] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[TIMEOFMOD] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[OK] [bit] NOT NULL ,
	[REASON] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
END

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'SUSPENSE_C')
BEGIN
	PRINT 'Creating Table SUSPENSE_C'
	CREATE TABLE [dbo].[SUSPENSE_C] (
	[ID] [int] NOT NULL ,
	[IMPORTLOGID] [int] NULL ,
	[LICENSE] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[AADDR1] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ACITY] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ASTATE] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[AZIP] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[BADDR1] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[BCITY] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[BSTATE] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[BZIP] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[OK] [bit] NOT NULL ,
	[REASON] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
END

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'WEBUSER')
BEGIN
	PRINT 'Creating Table WEBUSER'
	CREATE TABLE [dbo].[WEBUSER] (
	[WebUserID] [int] IDENTITY (1, 1) NOT NULL ,
	[Email] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[Pwd] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[RegistryID] [int] NULL ,
	[Access] [int] NULL 
) ON [PRIMARY]
END

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'legacy')
BEGIN
	PRINT 'Creating Table legacy'
	CREATE TABLE [dbo].[legacy] (
	[ID] [int] IDENTITY (1, 1) NOT NULL ,
	[VT_DMV_RegistryID] [int] NOT NULL ,
	[FIRST] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[MIDDLE] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[LAST] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SUFFIX] [varchar] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ADDR1] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ADDR2] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CITY] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[STATE] [varchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ZIP1] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ZIP2] [varchar] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[DOB] [datetime] NULL ,
	[SEX] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[LICENSE] [varchar] (9) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[AADDR1] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[AADDR2] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ACITY] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ASTATE] [varchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[AZIP1] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[AZIP2] [varchar] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[DONOR] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[OriginalDate] [datetime] NULL ,
	[DonorStatusChanged] [bit] NOT NULL ,
	[RenewalDate] [datetime] NULL ,
	[DeathDate] [datetime] NULL ,
	[CsorJur] [varchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CsorLicNo] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SystemID] [int] NULL ,
	[SysLastModified] [datetime] NULL ,
	[UserID] [int] NULL ,
	[LastModified] [datetime] NULL ,
	[temp1] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[temp2] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
END

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'DMVADDR')
BEGIN
	PRINT 'Creating Table DMVADDR'
	CREATE TABLE [dbo].[DMVADDR] (
	[ID] [int] IDENTITY (1, 1) NOT NULL ,
	[DMVID] [int] NULL ,
	[AddrTypeID] [int] NULL ,
	[Addr1] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Addr2] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[City] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[State] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Zip] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[UserID] [int] NULL ,
	[LastModified] [datetime] NULL ,
	[CreateDate] [datetime] NULL 
) ON [PRIMARY]

END

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'DMVORGAN')
BEGIN
	PRINT 'Creating Table DMVORGAN'
	CREATE TABLE [dbo].[DMVORGAN] (
	[ID] [int] IDENTITY (1, 1) NOT NULL ,
	[DMVID] [int] NULL ,
	[OrganTypeID] [int] NULL ,
	[LastModified] [datetime] NULL ,
	[CreateDate] [datetime] NULL ,
	[msrepl_tran_version] [uniqueidentifier] NOT NULL 
) ON [PRIMARY]
END


ALTER TABLE [dbo].[ADDRTYPE] ADD 
	CONSTRAINT [DF__ADDRTYPE__msrepl__7EACC042] DEFAULT (newid()) FOR [msrepl_tran_version],
	CONSTRAINT [PK_ADDRTYPE] PRIMARY KEY  NONCLUSTERED 
	(
		[ID]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[DMV] ADD 
	CONSTRAINT [PK_DMV] PRIMARY KEY  NONCLUSTERED 
	(
		[ID]
	)  ON [IDX] 
GO

 CREATE  INDEX [DMV_CSORSTATE_CSORLICENSE_id] ON [dbo].[DMV]([CSORState], [CSORLicense], [ID]) ON [IDX]
GO

 CREATE  INDEX [DMV_DeceasedDate] ON [dbo].[DMV]([DeceasedDate]) ON [IDX]
GO

 CREATE  INDEX [DMV_first_last_dob] ON [dbo].[DMV]([FirstName], [LastName], [DOB]) ON [IDX]
GO

 CREATE  INDEX [DMV_MiddleName] ON [dbo].[DMV]([MiddleName]) ON [IDX]
GO

 CREATE  INDEX [DMV_License_ID] ON [dbo].[DMV]([License], [ID]) ON [IDX]
GO

 CREATE  INDEX [DMV_SSN] ON [dbo].[DMV]([SSN]) ON [IDX]
GO

ALTER TABLE [dbo].[DMVARCHIVE] ADD 
	CONSTRAINT [DF_DMVARCHIVE_Donor] DEFAULT (0) FOR [Donor],
	CONSTRAINT [PK_DMVARCHIVE] PRIMARY KEY  NONCLUSTERED 
	(
		[ID]
	) WITH  FILLFACTOR = 60  ON [IDX] 
GO

ALTER TABLE [dbo].[DMVARCHIVEADDR] ADD 
	CONSTRAINT [PK_DMVARCHIVEADDR] PRIMARY KEY  NONCLUSTERED 
	(
		[ID]
	) WITH  FILLFACTOR = 60  ON [IDX] 
GO

 CREATE  INDEX [DMVARCHIVEADDR_DMVID] ON [dbo].[DMVARCHIVEADDR]([DMVArchiveID]) WITH  FILLFACTOR = 60 ON [IDX]
GO

ALTER TABLE [dbo].[DMVARCHIVEORGAN] ADD 
	CONSTRAINT [PK_DMVARCHIVEORGAN] PRIMARY KEY  NONCLUSTERED 
	(
		[ID]
	) WITH  FILLFACTOR = 60  ON [IDX] 
GO

 CREATE  INDEX [DMVARCHIVEORGAN_DMVID] ON [dbo].[DMVARCHIVEORGAN]([DMVArchiveID]) WITH  FILLFACTOR = 60 ON [IDX]
GO

ALTER TABLE [dbo].[IMPORT] ADD 
	CONSTRAINT [PK_IMPORT] PRIMARY KEY  NONCLUSTERED 
	(
		[ID]
	)  ON [PRIMARY] 
GO

 CREATE  INDEX [IMPORT_DOB] ON [dbo].[IMPORT]([DOB]) WITH  FILLFACTOR = 80,  PAD_INDEX  ON [IDX]
GO

 CREATE  INDEX [IMPORT_License] ON [dbo].[IMPORT]([LICENSE]) WITH  FILLFACTOR = 80,  PAD_INDEX  ON [IDX]
GO

 CREATE  INDEX [import0] ON [dbo].[IMPORT]([DONOR]) WITH  FILLFACTOR = 80,  PAD_INDEX  ON [IDX]
GO

 CREATE  INDEX [IMPORTARCHIVE_ID] ON [dbo].[IMPORTARCHIVE]([ID]) WITH  FILLFACTOR = 80,  PAD_INDEX  ON [IDX]
GO

 CREATE  INDEX [IMPORTARCHIVE_IMPORTLOGID] ON [dbo].[IMPORTARCHIVE]([IMPORTLOGID]) WITH  FILLFACTOR = 80,  PAD_INDEX  ON [IDX]
GO

ALTER TABLE [dbo].[IMPORTFILES] ADD 
	CONSTRAINT [PK_IMPORTFILES] PRIMARY KEY  NONCLUSTERED 
	(
		[TableName]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[IMPORTLOG] ADD 
	CONSTRAINT [DF_IMPORTLOG_RunStart] DEFAULT (getdate()) FOR [RunStart],
	CONSTRAINT [DF_IMPORTLOG_RunStatus] DEFAULT ('LOADING') FOR [RunStatus],
	CONSTRAINT [DF_IMPORTLOG_RecordsTotal] DEFAULT (0) FOR [RecordsTotal],
	CONSTRAINT [DF_IMPORTLOG_RecordsSuspended] DEFAULT (0) FOR [RecordsSuspended],
	CONSTRAINT [DF_IMPORTLOG_RecordsAdded] DEFAULT (0) FOR [RecordsAdded],
	CONSTRAINT [DF_IMPORTLOG_RecordsUpdated] DEFAULT (0) FOR [RecordsUpdated],
	CONSTRAINT [PK_IMPORTLOG] PRIMARY KEY  NONCLUSTERED 
	(
		[ID]
	)  ON [PRIMARY] 
GO

 CREATE  INDEX [IMPORTLOG_RunStatus] ON [dbo].[IMPORTLOG]([RunStatus]) WITH  FILLFACTOR = 80,  PAD_INDEX  ON [IDX]
GO

ALTER TABLE [dbo].[IMPORTLOGSTATS] ADD 
	CONSTRAINT [DF_IMPORTLOGSTATS_RunStart] DEFAULT (getdate()) FOR [RunStart],
	CONSTRAINT [DF_IMPORTLOGSTATS_RunStatus] DEFAULT ('LOADING') FOR [RunStatus],
	CONSTRAINT [DF_IMPORTLOGSTATS_RecordsTotal] DEFAULT (0) FOR [RTotal],
	CONSTRAINT [DF_IMPORTLOGSTATS_RecordsSuspended] DEFAULT (0) FOR [RSuspended],
	CONSTRAINT [DF_IMPORTLOGSTATS_RecordsAdded] DEFAULT (0) FOR [RAdded],
	CONSTRAINT [DF_IMPORTLOGSTATS_RecordsUpdated] DEFAULT (0) FOR [RUpdated],
	CONSTRAINT [DF_IMPORTLOGSTATS_RDonorY] DEFAULT (0) FOR [RDonorY],
	CONSTRAINT [DF_IMPORTLOGSTATS_RecordsUpdatedDonorChange] DEFAULT (0) FOR [RDonorChange],
	CONSTRAINT [DF_IMPORTLOGSTATS_RM] DEFAULT (0) FOR [RM],
	CONSTRAINT [DF_IMPORTLOGSTATS_RF] DEFAULT (0) FOR [RF],
	CONSTRAINT [DF_IMPORTLOGSTATS_RMDonorY] DEFAULT (0) FOR [RMDonorY],
	CONSTRAINT [DF_IMPORTLOGSTATS_RFDonorY] DEFAULT (0) FOR [RFDonorY],
	CONSTRAINT [DF_IMPORTLOGSTATS_RM18Total] DEFAULT (0) FOR [RM18Total],
	CONSTRAINT [DF_IMPORTLOGSTATS_RM18DonorY] DEFAULT (0) FOR [RM18DonorY],
	CONSTRAINT [DF_IMPORTLOGSTATS_RF18Total] DEFAULT (0) FOR [RF18Total],
	CONSTRAINT [DF_IMPORTLOGSTATS_RF18DonorY] DEFAULT (0) FOR [RF18DonorY],
	CONSTRAINT [DF_IMPORTLOGSTATS_RM17Total] DEFAULT (0) FOR [RM17Total],
	CONSTRAINT [DF_IMPORTLOGSTATS_RM17DonorY] DEFAULT (0) FOR [RM17DonorY],
	CONSTRAINT [DF_IMPORTLOGSTATS_RF17Total] DEFAULT (0) FOR [RF17Total],
	CONSTRAINT [DF_IMPORTLOGSTATS_RF17DonorY] DEFAULT (0) FOR [RF17DonorY],
	CONSTRAINT [PK_IMPORTLOGSTATS] PRIMARY KEY  NONCLUSTERED 
	(
		[ID]
	)  ON [PRIMARY] 
GO

 CREATE  INDEX [IMPORTLOGSTATS_RunStatus] ON [dbo].[IMPORTLOGSTATS]([RunStatus]) WITH  FILLFACTOR = 80,  PAD_INDEX  ON [IDX]
GO

ALTER TABLE [dbo].[IMPORT_A] ADD 
	CONSTRAINT [PK_IMPORT_A] PRIMARY KEY  NONCLUSTERED 
	(
		[ID]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[IMPORT_B] ADD 
	CONSTRAINT [PK_IMPORT_B] PRIMARY KEY  NONCLUSTERED 
	(
		[ID]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[IMPORT_C] ADD 
	CONSTRAINT [PK_IMPORT_C] PRIMARY KEY  NONCLUSTERED 
	(
		[ID]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[Import_Adds] ADD 
	CONSTRAINT [DF_Import_Adds_CREATEDATE] DEFAULT (getdate()) FOR [CreateDate],
	CONSTRAINT [PK_Import_Adds] PRIMARY KEY  NONCLUSTERED 
	(
		[ID]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[Import_Deletes] ADD 
	CONSTRAINT [DF_Import_Deletes_CREATEDATE] DEFAULT (getdate()) FOR [CreateDate],
	CONSTRAINT [PK_Import_Deletes] PRIMARY KEY  NONCLUSTERED 
	(
		[ID]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[ORGANTYPE] ADD 
	CONSTRAINT [DF__ORGANTYPE__msrep__69B1A35C] DEFAULT (newid()) FOR [msrepl_tran_version],
	CONSTRAINT [PK_ORGAN] PRIMARY KEY  NONCLUSTERED 
	(
		[ID]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[REGISTRY] ADD 
	CONSTRAINT [DF__REGISTRY__msrepl__64B7E415] DEFAULT (newid()) FOR [msrepl_tran_version],
	CONSTRAINT [PK_REGISTRY] PRIMARY KEY  NONCLUSTERED 
	(
		[ID]
	)  ON [IDX] 
GO

 CREATE  INDEX [registry_last_first_dob] ON [dbo].[REGISTRY]([LastName], [FirstName], [DOB]) WITH  FILLFACTOR = 90 ON [IDX]
GO

 CREATE  INDEX [DOB_FIRST_LAST] ON [dbo].[REGISTRY]([DOB], [FirstName], [LastName]) WITH  FILLFACTOR = 90 ON [IDX]
GO

 CREATE  INDEX [DOB_FIRST_MID_LAST] ON [dbo].[REGISTRY]([DOB], [FirstName], [MiddleName], [LastName]) WITH  FILLFACTOR = 90 ON [IDX]
GO

 CREATE  INDEX [DOB_FIRST_LAST_LICENSE] ON [dbo].[REGISTRY]([DOB], [FirstName], [LastName], [License]) WITH  FILLFACTOR = 90 ON [IDX]
GO

 CREATE  INDEX [SSN] ON [dbo].[REGISTRY]([SSN]) WITH  FILLFACTOR = 90 ON [IDX]
GO

ALTER TABLE [dbo].[REGISTRYADDR] ADD 
	CONSTRAINT [DF__REGISTRYA__msrep__5A3A55A2] DEFAULT (newid()) FOR [msrepl_tran_version],
	CONSTRAINT [PK_REGISTRYADDR] PRIMARY KEY  NONCLUSTERED 
	(
		[ID]
	)  ON [PRIMARY] 
GO

 CREATE  INDEX [registryaddr_RegID_TypeID_AddressFields] ON [dbo].[REGISTRYADDR]([RegistryID], [AddrTypeID], [Addr1], [Addr2], [City], [State], [Zip]) WITH  FILLFACTOR = 90 ON [IDX]
GO

 CREATE  INDEX [RegistryID_Addr1_State_Zip] ON [dbo].[REGISTRYADDR]([RegistryID], [Addr1], [State], [Zip]) WITH  FILLFACTOR = 90 ON [IDX]
GO

ALTER TABLE [dbo].[REGISTRYORGAN] ADD 
	CONSTRAINT [DF__REGISTRYO__msrep__453F38BC] DEFAULT (newid()) FOR [msrepl_tran_version],
	CONSTRAINT [PK_REGISTRYORGAN] PRIMARY KEY  NONCLUSTERED 
	(
		[ID]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[RegistryEventSourceCodes] ADD 
	CONSTRAINT [DF__RegistryE__msrep__4FBCC72F] DEFAULT (newid()) FOR [msrepl_tran_version],
	CONSTRAINT [PK_RegistryEventSourceCodes] PRIMARY KEY  NONCLUSTERED 
	(
		[SourceCodeID]
	)  ON [PRIMARY] 
GO

 CREATE  INDEX [SUSPECT_ID] ON [dbo].[SUSPENSE]([ID]) WITH  FILLFACTOR = 80,  PAD_INDEX  ON [IDX]
GO

 CREATE  INDEX [SUSPECT_LastFirst] ON [dbo].[SUSPENSE]([LAST], [FIRST]) WITH  FILLFACTOR = 80,  PAD_INDEX  ON [IDX]
GO

 CREATE  INDEX [SUSPECT_License] ON [dbo].[SUSPENSE]([LICENSE]) WITH  FILLFACTOR = 80,  PAD_INDEX  ON [IDX]
GO

 CREATE  INDEX [SUSPECT_Reason] ON [dbo].[SUSPENSE]([REASON]) WITH  FILLFACTOR = 80,  PAD_INDEX  ON [IDX]
GO

 CREATE  INDEX [SUSPENSE_ImportLogID] ON [dbo].[SUSPENSE]([IMPORTLOGID]) WITH  FILLFACTOR = 80,  PAD_INDEX  ON [IDX]
GO

 CREATE  INDEX [suspense_a0] ON [dbo].[SUSPENSE_A]([LICENSE]) WITH  FILLFACTOR = 80,  PAD_INDEX  ON [IDX]
GO

ALTER TABLE [dbo].[legacy] ADD 
	CONSTRAINT [PK_legacy] PRIMARY KEY  NONCLUSTERED 
	(
		[ID]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[DMVADDR] ADD 
	CONSTRAINT [PK_DMVADDR] PRIMARY KEY  NONCLUSTERED 
	(
		[ID]
	)  ON [IDX] 
GO

ALTER TABLE [dbo].[DMVORGAN] ADD 
	CONSTRAINT [DF__DMVORGAN__msrepl__742F31CF] DEFAULT (newid()) FOR [msrepl_tran_version],
	CONSTRAINT [PK_DMVORGAN] PRIMARY KEY  NONCLUSTERED 
	(
		[ID]
	) WITH  FILLFACTOR = 60  ON [IDX] 
GO

 CREATE  INDEX [DMVORGAN_DMVID] ON [dbo].[DMVORGAN]([DMVID]) WITH  FILLFACTOR = 60 ON [IDX]
GO

ALTER TABLE [dbo].[DMVADDR] ADD 
	CONSTRAINT [FK_DMVADDR_ADDRTYPE] FOREIGN KEY 
	(
		[AddrTypeID]
	) REFERENCES [dbo].[ADDRTYPE] (
		[ID]
	)
GO

ALTER TABLE [dbo].[DMVORGAN] ADD 
	CONSTRAINT [FK_DMVORGAN_ORGANTYPE] FOREIGN KEY 
	(
		[OrganTypeID]
	) REFERENCES [dbo].[ORGANTYPE] (
		[ID]
	)
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.SPS_CheckRegistry_DMV    Script Date: 1/11/2008 10:59:12 AM ******/

/****** Object:  Stored Procedure dbo.SPS_CheckRegistry_DMV    Script Date: 8/11/2006 10:57:44 AM ******/







CREATE Procedure SPS_CheckRegistry_DMV
	@DOB   DATETIME    = NULL,
	@LastName  VARCHAR(25) = NULL,
	@FirstName VARCHAR(25) = NULL,
	@MiddleName VARCHAR(25) = NULL,
	@SSN   VARCHAR(11) = NULL,
	@LICENSE VARCHAR(15) = NULL,
	@StreetAddress VARCHAR(45) = NULL,
	@City VARCHAR(25) = NULL,
	@State VARCHAR(2) = NULL,
	@Zip VARCHAR(10) = NULL,
	@DMVID INT OUTPUT,
	@DMVDonor BIT OUTPUT,
	@DMVDate SMALLDATETIME OUTPUT,
	@RecordsReturned INT OUTPUT 

AS
SET NOCOUNT ON
/*
This stored procedure is called by sps_CheckRegistry to query the DMV table

Desigened AND Developed 03/2003

Legal Information...
 ©1996-2003 Statline, LLC. All rights reserved. 

 Statline is a registered trademark of Statline, LLC in the U.S.A. 


 7555 East Hampden Avenue, Ste. 104, 
 Denver, CO 80231. 
 1-888-881-7828. 


*/

	-- get values for dmv
	IF	ISNULL(@MiddleName, '') +  
		ISNULL(@SSN, '') +
		ISNULL(@LICENSE, '') +
		ISNULL(@StreetAddress, '') +
		ISNULL(@City, '') +		
		ISNULL(@Zip, '') = '' 
	BEGIN	
-- PRINT 'DMV: QUERY WITH DOB, LAST AND FIRST'
		SELECT  --TOP 1
			@DMVID = D.ID ,
			@DMVDonor = D.Donor ,
			@DMVDate = CASE WHEN D.RENEWALDATE IS NULL THEN 
						CASE WHEN D.CREATEDATE IS NULL THEN '07/01/01' ELSE D.CREATEDATE END
					ELSE D.RENEWALDATE END
		FROM DMV D
		WHERE	FirstName         = @FirstName
		AND	LastName          = @LastName		 
		AND	DOB		  = @DOB					
		
		ORDER BY LASTMODIFIED DESC

		-- get the number of records returned
		SELECT @RecordsReturned = @@RowCount

		-- if records returned is greater than 0 then clear the variables
		-- Note: record count is only done in DMV query. DMV Should never have a duplicate
		-- 	 Duplicates are check for by Colorado DMV, Statline and again in this sp
		IF @RecordsReturned > 1 
		BEGIN
			SELECT  
				@DMVID = 0 ,
				@DMVDonor = 0,
				@DMVDate = '1/1/1900'
		END

	END
	ELSE
	BEGIN
		-- license
		IF ISNULL(@LICENSE, '') <> ''
		BEGIN
-- PRINT 'DMV: QUERY WITH LICENSE: ' + @LICENSE
			SELECT  --TOP 1
				@DMVID = D.ID ,
				@DMVDonor = D.Donor ,
				@DMVDate = CASE WHEN D.RENEWALDATE IS NULL THEN 
							CASE WHEN D.CREATEDATE IS NULL THEN '07/01/01' ELSE D.CREATEDATE END
						ELSE D.RENEWALDATE END
			FROM DMV D
			WHERE	FirstName       = @FirstName
			AND	LastName        = @LastName		 
			AND	DOB		= @DOB			
			AND	License		= @LICENSE
			
				
			ORDER BY LASTMODIFIED DESC

			-- get the number of records returned
			SELECT @RecordsReturned = @@RowCount
			
			-- if records returned is greater than 0 then clear the variables
			-- Note: record count is only done in DMV query. DMV Should never have a duplicate
			-- 	 Duplicates are check for by Colorado DMV, Statline and again in this sp
			
			IF @RecordsReturned > 1 
			BEGIN
			SELECT  
				@DMVID = 0 ,
				@DMVDonor = 0,
				@DMVDate = '1/1/1900'
			END
		
		END
		
		-- PRINT 'record count before middlename if: ' + ISNULL(cast(@RecordsReturned as varchar(3)), '')
		-- middlename
		IF ISNULL(@MiddleName, '') <> '' AND (@RecordsReturned > 1 OR ISNULL(@RecordsReturned,0) = 0)
		BEGIN
-- PRINT 'DMV: QUERY WITH MIDDLENAME: ' + @MiddleName
			SELECT  --TOP 1
				@DMVID = D.ID ,
				@DMVDonor = D.Donor ,
				@DMVDate = CASE WHEN D.RENEWALDATE IS NULL THEN 
							CASE WHEN D.CREATEDATE IS NULL THEN '07/01/01' ELSE D.CREATEDATE END
						ELSE D.RENEWALDATE END
			FROM DMV D
			WHERE	FirstName       = @FirstName
			AND	LastName        = @LastName		 
			AND	DOB		= @DOB			
			AND	MiddleName	= @MiddleName
			ORDER BY LASTMODIFIED DESC

			-- get the number of records returned
			SELECT @RecordsReturned = @@RowCount

			-- if records returned is greater than 0 then clear the variables
			-- Note: record count is only done in DMV query. DMV Should never have a duplicate
			-- 	 Duplicates are check for by Colorado DMV, Statline and again in this sp
			IF @RecordsReturned > 1 
			BEGIN
			SELECT  
				@DMVID = 0 ,
				@DMVDonor = 0,
				@DMVDate = '1/1/1900'
			END


		END
		-- ADDRESS + NAME AND BIRTHDATE
		IF ISNULL(@StreetAddress, '') + ISNULL(@State, '') + ISNULL(@Zip, '') <> '' AND (@RecordsReturned > 1 OR ISNULL(@RecordsReturned,0) = 0)
		BEGIN
-- PRINT 'DMV: QUERY WITH Address: ' + @StreetAddress + " " + @State + " " + @Zip
			SELECT  --TOP 1
				@DMVID = D.ID ,
				@DMVDonor = D.Donor ,
				@DMVDate = CASE WHEN D.RENEWALDATE IS NULL THEN 
							CASE WHEN D.CREATEDATE IS NULL THEN '07/01/01' ELSE D.CREATEDATE END
						ELSE D.RENEWALDATE END
			FROM DMV D
			JOIN DMVAddr DA ON DA.DMVID = D.ID
			WHERE	FirstName       = @FirstName
			AND	LastName        = @LastName		 
			AND	DOB		= @DOB			
			AND   	(LEFT(DA.ADDR1, 5)	  = LEFT(@StreetAddress, 5) 
								OR ISNULL(@StreetAddress, '')='')
			AND   	(DA.State		  = @State	OR ISNULL(@State, 	'')='')
			AND   	(LEFT(DA.Zip, 5)	  = LEFT(@Zip, 5)
								OR ISNULL(@Zip	, 	'')='')
			
			ORDER BY D.LASTMODIFIED DESC

			-- get the number of records returned
			SELECT @RecordsReturned = @@RowCount		

			-- if records returned is greater than 0 then clear the variables
			-- Note: record count is only done in DMV query. DMV Should never have a duplicate
			-- 	 Duplicates are check for by Colorado DMV, Statline and again in this sp
			IF @RecordsReturned > 1 
			BEGIN
			SELECT  
				@DMVID = 0 ,
				@DMVDonor = 0,
				@DMVDate = '1/1/1900'
			END

	
		END
		
		-- SSN
		IF ISNULL(@SSN, '') <> '' AND (@RecordsReturned > 1 OR ISNULL(@RecordsReturned,0) = 0)
		BEGIN
-- PRINT 'DMV: QUERY WITH SSN: ' + @SSN
			SELECT  --TOP 1
				@DMVID = D.ID ,
				@DMVDonor = D.Donor ,
				@DMVDate = CASE WHEN D.RENEWALDATE IS NULL THEN 
							CASE WHEN D.CREATEDATE IS NULL THEN '07/01/01' ELSE D.CREATEDATE END
						ELSE D.RENEWALDATE END
			FROM DMV D
			WHERE	FirstName       = @FirstName
			AND	LastName        = @LastName		 
			AND	DOB		= @DOB			
			AND	SSN	= @SSN
			ORDER BY LASTMODIFIED DESC

			-- get the number of records returned
			SELECT @RecordsReturned = @@RowCount		

			-- if records returned is greater than 0 then clear the variables
			-- Note: record count is only done in DMV query. DMV Should never have a duplicate
			-- 	 Duplicates are check for by Colorado DMV, Statline and again in this sp
			IF @RecordsReturned > 1 
			BEGIN
			SELECT  
				@DMVID = 0 ,
				@DMVDonor = 0,
				@DMVDate = '1/1/1900'
			END

	
		END
		
		
	
	
	END

-- PRINT 'DMV: what is the DMV record count: ' + ISNULL(cast(@RecordsReturned as varchar(3)), '')
	-- IF MORE THAN 1 RECORD WAS RETURNED ASK FOR ADDITIONAL INFORMATION
	IF (@RecordsReturned > 1 OR ISNULL(@RecordsReturned,0) = 0)
	BEGIN
		SELECT
		@DMVID	  = 0,
		@DMVDonor = 0,
		@DMVDate  = '1/1/1900'
		
		RETURN
	END
	ELSE
	BEGIN
		RETURN
	END	













GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

/****** Object:  Stored Procedure dbo.SPS_CheckRegistry_DMVNEOB    Script Date: 1/11/2008 10:59:12 AM ******/

CREATE       Procedure SPS_CheckRegistry_DMVNEOB
	@DOB   DATETIME    = NULL,
	@LastName  VARCHAR(25) = NULL,
	@FirstName VARCHAR(25) = NULL,
	@MiddleName VARCHAR(25) = NULL,
	@SSN   VARCHAR(11) = NULL,
	@LICENSE VARCHAR(15) = NULL,
	@StreetAddress VARCHAR(45) = NULL,
	@City VARCHAR(25) = NULL,
	@State VARCHAR(2) = NULL,
	@Zip VARCHAR(10) = NULL,
	@DMVID INT OUTPUT,
	@DMVDonor BIT OUTPUT,
	@DMVDate SMALLDATETIME OUTPUT,
	@RecordsReturned INT OUTPUT,
	@DMVSource VARCHAR(10) OUTPUT

AS
SET NOCOUNT ON
/*
ccarroll 8/25/2006
 This stored procedure is called by sps_CheckRegistry_NEOB to query 
 DMV tables in the NEOB domain and return the resulting DMVSource. For 
 example, 'DMV_CT'. The DMVsource is then used to dispay the correct Verification
 sheet.

 The donor verification Sheets are prefixed with the DMVSource and are stored in a
 virtual directory on the web server ('NEOB_Verification') For Example:
 /NEOB_Verification/DMV_CT_qryVerificationSheet.sls


 
Legal Information...
 ©1996-2003 Statline, LLC. All rights reserved. 
 Statline is a registered trademark of Statline, LLC in the U.S.A. 
*/

	-- get values for dmv
	IF	ISNULL(@MiddleName, '') +  
		ISNULL(@SSN, '') +
		ISNULL(@LICENSE, '') +
		ISNULL(@StreetAddress, '') +
		ISNULL(@City, '') +		
		ISNULL(@Zip, '') = '' 
	BEGIN
	
-- PRINT 'DMV: QUERY WITH DOB, LAST AND FIRST'

SELECT 	@DMVID = ID,
	@DMVDonor = Donor,
	@DMVDate = DMVDate,
	@DMVSource = DMVSource 

FROM
		--Build dirived table to get Union select statments assigned to vars  
		(SELECT  TOP 2
			ID ,
			Donor ,
			 CASE WHEN RENEWALDATE IS NULL THEN 
				   CASE WHEN CREATEDATE IS NULL THEN '07/01/01' ELSE CREATEDATE END
					ELSE RENEWALDATE END AS DMVDate,
			'DMV_RI' AS DMVSource,
			DOB,
			FirstName,
			LastName
		FROM DMV_RI.dbo.DMV		
		WHERE	DOB		  = @DOB
		AND	FirstName         = @FirstName
		AND	LastName          = @LastName

	UNION
		SELECT  TOP 2
			ID ,
			Donor ,
			CASE WHEN RENEWALDATE IS NULL THEN 
				   CASE WHEN CREATEDATE IS NULL THEN '07/01/01' ELSE CREATEDATE END
					ELSE RENEWALDATE END AS DMVDate,
			'DMV_CT' AS DMVSource,
			DOB,
			FirstName,
			LastName

		FROM DMV_CT.dbo.DMV		
		WHERE	DOB		  = @DOB
		AND	FirstName         = @FirstName
		AND	LastName          = @LastName

	UNION
		SELECT  TOP 2
			ID ,
			Donor ,
			CASE WHEN RENEWALDATE IS NULL THEN 
				   CASE WHEN CREATEDATE IS NULL THEN '07/01/01' ELSE CREATEDATE END
					ELSE RENEWALDATE END  AS DMVDate,
			'DMV_MA' AS DMVSource,
			DOB,
			FirstName,
			LastName
		FROM DMV_MA.dbo.DMV
		WHERE	DOB		  = @DOB
		AND	FirstName         = @FirstName
		AND	LastName          = @LastName


	UNION
		SELECT  TOP 2
			ID ,
			Donor ,
			CASE WHEN RENEWALDATE IS NULL THEN 
				   CASE WHEN CREATEDATE IS NULL THEN '07/01/01' ELSE CREATEDATE END
					ELSE RENEWALDATE END  AS DMVDate,
			'DMV_ME' AS DMVSource,
			DOB,
			FirstName,
			LastName
		FROM DMV_ME.dbo.DMV
		WHERE	DOB		  = @DOB
		AND	FirstName         = @FirstName
		AND	LastName          = @LastName

	UNION
		SELECT  TOP 2
			ID ,
			Donor ,
			CASE WHEN RENEWALDATE IS NULL THEN 
				   CASE WHEN CREATEDATE IS NULL THEN '07/01/01' ELSE CREATEDATE END
					ELSE RENEWALDATE END  AS DMVDate,
			'DMV_VT' AS DMVSource,
			DOB,
			FirstName,
			LastName
		FROM DMV_VT.dbo.DMV
		WHERE	DOB		  = @DOB
		AND	FirstName         = @FirstName
		AND	LastName          = @LastName

	)d

		-- get the number of records returned
		SET @RecordsReturned = @@RowCount

		-- PRINT @RecordsReturned

		-- if records returned is greater than 0 then clear the variables
		-- Note: record count is only done in DMV query. DMV Should never have a duplicate
		-- 	 Duplicates are check for by Colorado DMV, Statline and again in this sp
		IF @RecordsReturned > 1 
		BEGIN
			SELECT  
				@DMVID = 0 ,
				@DMVDonor = 0,
				@DMVDate = '1/1/1900',
				@DMVSource = ''
		END

	END

	ELSE
	BEGIN

		-- license
		IF ISNULL(@LICENSE, '') <> ''
		BEGIN


-- PRINT 'DMV: QUERY WITH LICENSE: ' + @LICENSE
	SELECT 	@DMVID = ID,
		@DMVDonor = Donor,
		@DMVDate = DMVDate,
		@DMVSource = DMVSource 
	FROM

		--Build dirived table to get Union select statments assigned to vars  
		(SELECT  TOP 2
			ID ,
			Donor ,
			 CASE WHEN RENEWALDATE IS NULL THEN 
				   CASE WHEN CREATEDATE IS NULL THEN '07/01/01' ELSE CREATEDATE END
					ELSE RENEWALDATE END AS DMVDate,
			'DMV_RI' AS DMVSource,
			DOB,
			FirstName,
			LastName,
			License
		FROM DMV_RI.dbo.DMV		
		WHERE	License		  = @License
		AND 	DOB		  = @DOB
		AND	FirstName         = @FirstName
		AND	LastName          = @LastName

	UNION
		SELECT  TOP 2
			ID ,
			Donor ,
			CASE WHEN RENEWALDATE IS NULL THEN 
				   CASE WHEN CREATEDATE IS NULL THEN '07/01/01' ELSE CREATEDATE END
					ELSE RENEWALDATE END AS DMVDate,
			'DMV_CT' AS DMVSource,
			DOB,
			FirstName,
			LastName,
			License

		FROM DMV_CT.dbo.DMV		
		WHERE	License		  = @License
		AND 	DOB		  = @DOB
		AND	FirstName         = @FirstName
		AND	LastName          = @LastName

	UNION
		SELECT  TOP 2
			ID ,
			Donor ,
			CASE WHEN RENEWALDATE IS NULL THEN 
				   CASE WHEN CREATEDATE IS NULL THEN '07/01/01' ELSE CREATEDATE END
					ELSE RENEWALDATE END  AS DMVDate,
			'DMV_MA' AS DMVSource,
			DOB,
			FirstName,
			LastName,
			License

		FROM DMV_MA.dbo.DMV
		WHERE	License		  = @License
		AND 	DOB		  = @DOB
		AND	FirstName         = @FirstName
		AND	LastName          = @LastName

	UNION
		SELECT  TOP 2
			ID ,
			Donor ,
			CASE WHEN RENEWALDATE IS NULL THEN 
				   CASE WHEN CREATEDATE IS NULL THEN '07/01/01' ELSE CREATEDATE END
					ELSE RENEWALDATE END  AS DMVDate,
			'DMV_ME' AS DMVSource,
			DOB,
			FirstName,
			LastName,
			License

		FROM DMV_ME.dbo.DMV
		WHERE	License		  = @License
		AND 	DOB		  = @DOB
		AND	FirstName         = @FirstName
		AND	LastName          = @LastName

	UNION
		SELECT  TOP 2
			ID ,
			Donor ,
			CASE WHEN RENEWALDATE IS NULL THEN 
				   CASE WHEN CREATEDATE IS NULL THEN '07/01/01' ELSE CREATEDATE END
					ELSE RENEWALDATE END  AS DMVDate,
			'DMV_VT' AS DMVSource,
			DOB,
			FirstName,
			LastName,
			License
		FROM DMV_VT.dbo.DMV
		WHERE	License		  = @License
		AND 	DOB		  = @DOB
		AND	FirstName         = @FirstName
		AND	LastName          = @LastName
	)d


			-- get the number of records returned
			SELECT @RecordsReturned = @@RowCount
			
			-- if records returned is greater than 0 then clear the variables
			-- Note: record count is only done in DMV query. DMV Should never have a duplicate
			-- 	 Duplicates are check for by Colorado DMV, Statline and again in this sp
			
			IF @RecordsReturned > 1 
			BEGIN
			SELECT  
				@DMVID = 0 ,
				@DMVDonor = 0,
				@DMVDate = '1/1/1900',
				@DMVSource = ''
			END
		
		END
		
-- PRINT 'record count before middlename if: ' + ISNULL(cast(@RecordsReturned as varchar(3)), '')
		-- middlename
		IF ISNULL(@MiddleName, '') <> '' AND (@RecordsReturned > 1 OR ISNULL(@RecordsReturned,0) = 0)
		BEGIN
-- PRINT 'DMV: QUERY WITH MIDDLENAME: ' + @MiddleName
	SELECT 	@DMVID = ID,
		@DMVDonor = Donor,
		@DMVDate = DMVDate,
		@DMVSource = DMVSource 
	FROM

		--Build dirived table to get Union select statments assigned to vars  
		(SELECT  TOP 2
			ID ,
			Donor ,
			 CASE WHEN RENEWALDATE IS NULL THEN 
				   CASE WHEN CREATEDATE IS NULL THEN '07/01/01' ELSE CREATEDATE END
					ELSE RENEWALDATE END AS DMVDate,
			'DMV_RI' AS DMVSource,
			DOB,
			FirstName,
			LastName,
			MiddleName

		FROM DMV_RI.dbo.DMV		
		WHERE	DOB		  = @DOB
		AND	FirstName         = @FirstName
		AND	MiddleName	  = @MiddleName
		AND	LastName          = @LastName

	UNION
		SELECT  TOP 2
			ID ,
			Donor ,
			CASE WHEN RENEWALDATE IS NULL THEN 
				   CASE WHEN CREATEDATE IS NULL THEN '07/01/01' ELSE CREATEDATE END
					ELSE RENEWALDATE END AS DMVDate,
			'DMV_CT' AS DMVSource,
			DOB,
			FirstName,
			LastName,
			MiddleName

		FROM DMV_CT.dbo.DMV		
		WHERE	DOB		  = @DOB
		AND	FirstName         = @FirstName
		AND	MiddleName	  = @MiddleName
		AND	LastName          = @LastName

	UNION
		SELECT  TOP 2
			ID ,
			Donor ,
			CASE WHEN RENEWALDATE IS NULL THEN 
				   CASE WHEN CREATEDATE IS NULL THEN '07/01/01' ELSE CREATEDATE END
					ELSE RENEWALDATE END  AS DMVDate,
			'DMV_MA' AS DMVSource,
			DOB,
			FirstName,
			LastName,
			MiddleName

		FROM DMV_MA.dbo.DMV
		WHERE	DOB		  = @DOB
		AND	FirstName         = @FirstName
		AND	MiddleName	  = @MiddleName
		AND	LastName          = @LastName

	UNION
		SELECT  TOP 2
			ID ,
			Donor ,
			CASE WHEN RENEWALDATE IS NULL THEN 
				   CASE WHEN CREATEDATE IS NULL THEN '07/01/01' ELSE CREATEDATE END
					ELSE RENEWALDATE END  AS DMVDate,
			'DMV_ME' AS DMVSource,
			DOB,
			FirstName,
			LastName,
			MiddleName

		FROM DMV_ME.dbo.DMV
		WHERE	DOB		  = @DOB
		AND	FirstName         = @FirstName
		AND	MiddleName	  = @MiddleName
		AND	LastName          = @LastName

	UNION
		SELECT  TOP 2
			ID ,
			Donor ,
			CASE WHEN RENEWALDATE IS NULL THEN 
				   CASE WHEN CREATEDATE IS NULL THEN '07/01/01' ELSE CREATEDATE END
					ELSE RENEWALDATE END  AS DMVDate,
			'DMV_VT' AS DMVSource,
			DOB,
			FirstName,
			LastName,
			MiddleName

		FROM DMV_VT.dbo.DMV
		WHERE	DOB		  = @DOB
		AND	FirstName         = @FirstName
		AND	MiddleName	  = @MiddleName
		AND	LastName          = @LastName
	)d

			-- get the number of records returned
			SELECT @RecordsReturned = @@RowCount

			-- if records returned is greater than 0 then clear the variables
			-- Note: record count is only done in DMV query. DMV Should never have a duplicate
			-- 	 Duplicates are check for by Colorado DMV, Statline and again in this sp
			IF @RecordsReturned > 1 
			BEGIN
			SELECT  
				@DMVID = 0 ,
				@DMVDonor = 0,
				@DMVDate = '1/1/1900',
				@DMVSource = ''
			END


		END
		-- ADDRESS + NAME AND BIRTHDATE
		IF ISNULL(@StreetAddress, '') + ISNULL(@State, '') + ISNULL(@Zip, '') <> '' AND (@RecordsReturned > 1 OR ISNULL(@RecordsReturned,0) = 0)
		BEGIN
		-- PRINT 'DMV: QUERY WITH Address: ' + @StreetAddress + " " + @State + " " + @Zip
			SELECT  --TOP 1
				@DMVID = D.ID ,
				@DMVDonor = D.Donor ,
				@DMVDate = CASE WHEN D.RENEWALDATE IS NULL THEN 
							CASE WHEN D.CREATEDATE IS NULL THEN '07/01/01' ELSE D.CREATEDATE END
						ELSE D.RENEWALDATE END
			FROM DMV D
			JOIN DMVAddr DA ON DA.DMVID = D.ID
			WHERE	DOB		  = @DOB
			AND	FirstName         = @FirstName
			AND	LastName          = @LastName
			AND   (LEFT(DA.ADDR1, 5)	  = LEFT(@StreetAddress, 5) 
								OR ISNULL(@StreetAddress, '')='')
			AND   (DA.State		  = @State	OR ISNULL(@State, 	'')='')
			AND   (LEFT(DA.Zip, 5)	  = LEFT(@Zip, 5)
								OR ISNULL(@Zip	, 	'')='')
			
			ORDER BY D.LASTMODIFIED DESC

			-- get the number of records returned
			SELECT @RecordsReturned = @@RowCount		

			-- if records returned is greater than 0 then clear the variables
			-- Note: record count is only done in DMV query. DMV Should never have a duplicate
			-- 	 Duplicates are check for by Colorado DMV, Statline and again in this sp
			IF @RecordsReturned > 1 
			BEGIN
			SELECT  
				@DMVID = 0 ,
				@DMVDonor = 0,
				@DMVDate = '1/1/1900',
				@DMVSource = ''
			END

	
		END
		
		-- SSN
		IF ISNULL(@SSN, '') <> '' AND (@RecordsReturned > 1 OR ISNULL(@RecordsReturned,0) = 0)
		BEGIN
         -- PRINT 'DMV: QUERY WITH SSN: ' + @SSN
			SELECT  --TOP 1
				@DMVID = D.ID ,
				@DMVDonor = D.Donor ,
				@DMVDate = CASE WHEN D.RENEWALDATE IS NULL THEN 
							CASE WHEN D.CREATEDATE IS NULL THEN '07/01/01' ELSE D.CREATEDATE END
						ELSE D.RENEWALDATE END
			FROM DMV D
			WHERE	SSN	= @SSN
			ORDER BY LASTMODIFIED DESC

			-- get the number of records returned
			SELECT @RecordsReturned = @@RowCount		

			-- if records returned is greater than 0 then clear the variables
			-- Note: record count is only done in DMV query. DMV Should never have a duplicate
			-- 	 Duplicates are check for by Colorado DMV, Statline and again in this sp
			IF @RecordsReturned > 1 
			BEGIN
			SELECT  
				@DMVID = 0 ,
				@DMVDonor = 0,
				@DMVDate = '1/1/1900',
				@DMVSource = ''
			END
		END	
	END

        -- PRINT 'DMV: what is the DMV record count: ' + ISNULL(cast(@RecordsReturned as varchar(3)), '')
	-- IF MORE THAN 1 RECORD WAS RETURNED ASK FOR ADDITIONAL INFORMATION
	IF (@RecordsReturned > 1 OR ISNULL(@RecordsReturned,0) = 0)
	BEGIN
		SELECT
		@DMVID	  = 0,
		@DMVDonor = 0,
		@DMVDate  = '1/1/1900',
		@DMVSource = ''
		
		RETURN
	END
	ELSE
	BEGIN
		RETURN
	END




GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

/****** Object:  Stored Procedure dbo.SPS_CheckRegistry_DMVv2    Script Date: 1/11/2008 10:59:12 AM ******/

/****** Object:  Stored Procedure dbo.SPS_CheckRegistry_DMVv2    Script Date: 8/11/2006 10:57:44 AM ******/





CREATE Procedure SPS_CheckRegistry_DMVv2
	@DOB   DATETIME    = NULL,
	@LastName  VARCHAR(25) = NULL,
	@FirstName VARCHAR(25) = NULL,
	@MiddleName VARCHAR(25) = NULL,
	@SSN   VARCHAR(11) = NULL,
	@LICENSE VARCHAR(15) = NULL,
	@StreetAddress VARCHAR(45) = NULL,
	@City VARCHAR(25) = NULL,
	@State VARCHAR(2) = NULL,
	@Zip VARCHAR(10) = NULL,
	@loc int = NULL,
	@DMVID INT OUTPUT,
	@DMVDonor BIT OUTPUT,
	@DMVDate SMALLDATETIME OUTPUT,
	@RecordsReturned INT OUTPUT 

AS
SET NOCOUNT ON
/*
This stored procedure is called by sps_CheckRegistry to query the DMV table

Desigened AND Developed 03/2003

Legal Information...
 ©1996-2003 Statline, LLC. All rights reserved. 

 Statline is a registered trademark of Statline, LLC in the U.S.A. 


 7555 East Hampden Avenue, Ste. 104, 
 Denver, CO 80231. 
 1-888-881-7828. 


*/
print 'loc'
print @loc

if  isnull(@loc,'') <>  ''
		begin
		print 'enter'
		--print @loc
			SELECT  --TOP 1
			@DMVID = D.ID ,
			@DMVDonor = D.Donor ,
			@DMVDate = CASE WHEN D.RENEWALDATE IS NULL THEN 
						CASE WHEN D.CREATEDATE IS NULL THEN '07/01/01' ELSE D.CREATEDATE END
					ELSE D.RENEWALDATE END

				FROM DMV D
				WHERE	d.id = @loc --DOB		  = @DOB			
				AND	FirstName           = @FirstName
				AND	LastName             = @LastName		 
				ORDER BY LASTMODIFIED DESC

				-- get the number of records returned
				SELECT @RecordsReturned = @@RowCount
			Return
		end
	-- get values for dmv
	IF	ISNULL(@MiddleName, '') +  
		ISNULL(@SSN, '') +
		ISNULL(@LICENSE, '') +
		ISNULL(@StreetAddress, '') +
		ISNULL(@City, '') +		
		ISNULL(@Zip, '') = '' 
	BEGIN	
-- PRINT 'DMV: QUERY WITH DOB, LAST AND FIRST'
		SELECT  --TOP 1
			@DMVID = D.ID ,
			@DMVDonor = D.Donor ,
			@DMVDate = CASE WHEN D.RENEWALDATE IS NULL THEN 
						CASE WHEN D.CREATEDATE IS NULL THEN '07/01/01' ELSE D.CREATEDATE END
					ELSE D.RENEWALDATE END
		FROM DMV D
		WHERE	FirstName         = @FirstName
		AND	LastName          = @LastName		 
		AND	DOB		  = @DOB					
		
		ORDER BY LASTMODIFIED DESC

		-- get the number of records returned
		SELECT @RecordsReturned = @@RowCount

		-- if records returned is greater than 0 then clear the variables
		-- Note: record count is only done in DMV query. DMV Should never have a duplicate
		-- 	 Duplicates are check for by Colorado DMV, Statline and again in this sp
		IF @RecordsReturned > 1 
		BEGIN
			SELECT  
				@DMVID = 0 ,
				@DMVDonor = 0,
				@DMVDate = '1/1/1900'
		END

	END
	ELSE
	BEGIN
		-- license
		IF ISNULL(@LICENSE, '') <> ''
		BEGIN
-- PRINT 'DMV: QUERY WITH LICENSE: ' + @LICENSE
			SELECT  --TOP 1
				@DMVID = D.ID ,
				@DMVDonor = D.Donor ,
				@DMVDate = CASE WHEN D.RENEWALDATE IS NULL THEN 
							CASE WHEN D.CREATEDATE IS NULL THEN '07/01/01' ELSE D.CREATEDATE END
						ELSE D.RENEWALDATE END
			FROM DMV D
			WHERE	FirstName       = @FirstName
			AND	LastName        = @LastName		 
			AND	DOB		= @DOB			
			AND	License		= @LICENSE
			
				
			ORDER BY LASTMODIFIED DESC

			-- get the number of records returned
			SELECT @RecordsReturned = @@RowCount
			
			-- if records returned is greater than 0 then clear the variables
			-- Note: record count is only done in DMV query. DMV Should never have a duplicate
			-- 	 Duplicates are check for by Colorado DMV, Statline and again in this sp
			
			IF @RecordsReturned > 1 
			BEGIN
			SELECT  
				@DMVID = 0 ,
				@DMVDonor = 0,
				@DMVDate = '1/1/1900'
			END
		
		END
		
		-- PRINT 'record count before middlename if: ' + ISNULL(cast(@RecordsReturned as varchar(3)), '')
		-- middlename
		IF ISNULL(@MiddleName, '') <> '' AND (@RecordsReturned > 1 OR ISNULL(@RecordsReturned,0) = 0)
		BEGIN
-- PRINT 'DMV: QUERY WITH MIDDLENAME: ' + @MiddleName
			SELECT  --TOP 1
				@DMVID = D.ID ,
				@DMVDonor = D.Donor ,
				@DMVDate = CASE WHEN D.RENEWALDATE IS NULL THEN 
							CASE WHEN D.CREATEDATE IS NULL THEN '07/01/01' ELSE D.CREATEDATE END

						ELSE D.RENEWALDATE END
			FROM DMV D
			WHERE	FirstName       = @FirstName
			AND	LastName        = @LastName		 
			AND	DOB		= @DOB			
			AND	MiddleName	= @MiddleName
			ORDER BY LASTMODIFIED DESC

			-- get the number of records returned
			SELECT @RecordsReturned = @@RowCount

			-- if records returned is greater than 0 then clear the variables
			-- Note: record count is only done in DMV query. DMV Should never have a duplicate
			-- 	 Duplicates are check for by Colorado DMV, Statline and again in this sp
			IF @RecordsReturned > 1 
			BEGIN
			SELECT  
				@DMVID = 0 ,
				@DMVDonor = 0,
				@DMVDate = '1/1/1900'
			END


		END
		-- ADDRESS + NAME AND BIRTHDATE
		IF ISNULL(@StreetAddress, '') + ISNULL(@State, '') + ISNULL(@Zip, '') <> '' AND (@RecordsReturned > 1 OR ISNULL(@RecordsReturned,0) = 0)
		BEGIN
-- PRINT 'DMV: QUERY WITH Address: ' + @StreetAddress + " " + @State + " " + @Zip
			SELECT  --TOP 1
				@DMVID = D.ID ,
				@DMVDonor = D.Donor ,
				@DMVDate = CASE WHEN D.RENEWALDATE IS NULL THEN 
							CASE WHEN D.CREATEDATE IS NULL THEN '07/01/01' ELSE D.CREATEDATE END
						ELSE D.RENEWALDATE END
			FROM DMV D
			JOIN DMVAddr DA ON DA.DMVID = D.ID
			WHERE	FirstName       = @FirstName
			AND	LastName        = @LastName		 
			AND	DOB		= @DOB			
			AND   	(LEFT(DA.ADDR1, 5)	  = LEFT(@StreetAddress, 5) 
								OR ISNULL(@StreetAddress, '')='')
			AND   	(DA.State		  = @State	OR ISNULL(@State, 	'')='')
			AND   	(LEFT(DA.Zip, 5)	  = LEFT(@Zip, 5)
								OR ISNULL(@Zip	, 	'')='')
			
			ORDER BY D.LASTMODIFIED DESC

			-- get the number of records returned
			SELECT @RecordsReturned = @@RowCount		

			-- if records returned is greater than 0 then clear the variables
			-- Note: record count is only done in DMV query. DMV Should never have a duplicate
			-- 	 Duplicates are check for by Colorado DMV, Statline and again in this sp
			IF @RecordsReturned > 1 
			BEGIN
			SELECT  
				@DMVID = 0 ,
				@DMVDonor = 0,
				@DMVDate = '1/1/1900'
			END

	
		END
		
		-- SSN
		IF ISNULL(@SSN, '') <> '' AND (@RecordsReturned > 1 OR ISNULL(@RecordsReturned,0) = 0)
		BEGIN
-- PRINT 'DMV: QUERY WITH SSN: ' + @SSN
			SELECT  --TOP 1
				@DMVID = D.ID ,
				@DMVDonor = D.Donor ,
				@DMVDate = CASE WHEN D.RENEWALDATE IS NULL THEN 
							CASE WHEN D.CREATEDATE IS NULL THEN '07/01/01' ELSE D.CREATEDATE END
						ELSE D.RENEWALDATE END
			FROM DMV D
			WHERE	FirstName       = @FirstName
			AND	LastName        = @LastName		 
			AND	DOB		= @DOB			
			AND	SSN	= @SSN
			ORDER BY LASTMODIFIED DESC

			-- get the number of records returned
			SELECT @RecordsReturned = @@RowCount		

			-- if records returned is greater than 0 then clear the variables
			-- Note: record count is only done in DMV query. DMV Should never have a duplicate
			-- 	 Duplicates are check for by Colorado DMV, Statline and again in this sp
			IF @RecordsReturned > 1 
			BEGIN
			SELECT  
				@DMVID = 0 ,
				@DMVDonor = 0,
				@DMVDate = '1/1/1900'
			END

	
		END
		
		
	
	
	END

-- PRINT 'DMV: what is the DMV record count: ' + ISNULL(cast(@RecordsReturned as varchar(3)), '')
	-- IF MORE THAN 1 RECORD WAS RETURNED ASK FOR ADDITIONAL INFORMATION
	IF (@RecordsReturned > 1 OR ISNULL(@RecordsReturned,0) = 0)
	BEGIN
		SELECT
		@DMVID	  = 0,
		@DMVDonor = 0,
		@DMVDate  = '1/1/1900'
		
		RETURN
	END
	ELSE
	BEGIN
		RETURN
	END
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

/****** Object:  Stored Procedure dbo.SPS_CheckRegistry_REGLoad    Script Date: 1/11/2008 10:59:12 AM ******/

CREATE Procedure SPS_CheckRegistry_REGLoad
	@DOB   varchar(255)    = NULL,
	@LastName  VARCHAR(25) = NULL,
	@FirstName VARCHAR(25) = NULL,
	@MiddleName VARCHAR(25) = NULL,
	@SSN   VARCHAR(11) = NULL,
	@LICENSE VARCHAR(15) = NULL,
	@StreetAddress VARCHAR(45) = NULL,
	@City VARCHAR(25) = NULL,
	@State VARCHAR(2) = NULL,
	@Zip VARCHAR(10) = NULL,
	@Loc int = null
AS
/******************************************************************************
**		File: 
**		Name: sps_CheckRegistry_REGLoad
**		Desc: 
**
**		This template can be customized:
**              
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**
**		Auth: Unknown
**		Date: Unknown
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**    10/15/2007	ccarroll			added FirstName, LastName to select
*******************************************************************************/
SET NOCOUNT ON
Declare
@strproc varchar(8000)
set @strproc =  'Select Registry.FirstName, Registry.MIDDLENAME, Registry.LastName, registry.License as  License, '	
				set @strproc = @strproc + 'registryAddr.Addr1 as  Addr1, '
				set @strproc = @strproc   + 'registryAddr.city as   City, '
				set @strproc = @strproc   + 'registryAddr.State as  State, '
				set @strproc = @strproc   + 'registryAddr.zip as  Zip, '
				set @strproc = @strproc   + 'Registry.LastModified as  SearchDate, '
				set @strproc = @strproc   + 'registry.ID as loc'
				
				set @strproc = @strproc   +  ' FROM registry  join registryAddr On registry.ID = registryAddr.registryid '
				set @strproc = @strproc   +   ' WHERE	registry.DOB = ' +"'" + @DOB  ++"'" + ' And'	
				--set @strproc = @strproc   +  'AND	'
				If  @MiddleName is not null
					Begin
						Set @strproc = @strproc + ' registry.middleName = ' + "'" + @MiddleName + "'" +  ' And '
					End
				If  @License is not null
					Begin
						Set @strproc = @strproc + ' registry.License = ' + "'" + @License + "'" +  ' And '
					End
				If  @StreetAddress is not null
					Begin
							if Left(@StreetAddress,1) = '*' or Right(@StreetAddress,1)  = '*'
							Begin
								set @StreetAddress = REPLACE(@StreetAddress,'*','%');
								Set @strproc = @strproc + '  registryAddr.Addr1  like ' + "'" + @StreetAddress + "'" +  ' And '
							end
						else
							Begin
								Set @strproc = @strproc + ' registryAddr.Addr1 = ' + "'" + @StreetAddress + "'" +  ' And '
							end
						 
					End
				If  @City is not null
					Begin						 
						if Left(@City,1) = '*' or Right(@City,1)  = '*'
							Begin
								set @City = REPLACE(@City,'*','%');
								Set @strproc = @strproc + '  registryAddr.City like ' + "'" + @City + "'" +  ' And '
							end
						else
							Begin
								Set @strproc = @strproc + ' registryAddr.City = ' + "'" + @City + "'" +  ' And '
							end
					End
				If  @State is not null
					Begin
						Set @strproc = @strproc + ' registryAddr.State = ' + "'" + @State+ "'" +  ' And '
					End
				If  @Zip is not null
					Begin
						Set @strproc = @strproc + ' registryAddr.Zip = ' + "'" + @Zip + "'" +  ' And '
					End
				set @strproc = @strproc   +   ' registry.FirstName           = '  +  "'" + @FirstName + "'"
				set @strproc = @strproc    + ' AND	registry.LastName             = ' + "'" + @LastName	+"'" 
				set @strproc = @strproc   +  ' ORDER BY registry.middleName,registryAddr.Zip,registryAddr.City,registryAddr.Addr1  DESC'


print @strproc
exec(@strproc)

GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

GRANT  EXECUTE  ON [dbo].[SPS_CheckRegistry_REGLoad]  TO [public]
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.sp_RebuildIndex    Script Date: 1/11/2008 10:59:12 AM ******/

/****** Object:  Stored Procedure dbo.sp_RebuildIndex    Script Date: 8/11/2006 10:57:44 AM ******/




Create Procedure sp_RebuildIndex 
 @RebuildAll int =0
AS
/*

	Desigened AND Developed 01/2003

	Legal Information...
	 ©1996-2003 Statline, LLC. All rights reserved. 

	 Statline is a registered trademark of Statline, LLC in the U.S.A. 


	 7555 East Hampden Avenue, Ste. 104, 
	 Denver, CO 80231. 
	 1-888-881-7828. 
*/
        -- 1. Replace MSDB.DBO.DMV_VTIndexStatus with current databases name.
        -- declare variables
        
        -- check for table in MSDB with name of databaseindexstatus ie DMV_VTIndexStatus
        -- TableName, LastRun  
 
        --     CREATE TABLE [MSDB].[dbo].[DMV_VTIndexStatus] (
 --    [TableName] [varchar] (50) NULL ,
 --    [IndexName] [varchar] (100) null, 
 --    [LastRun] [smalldatetime] NULL 
        --     ) ON [PRIMARY]
        --     GO
  
 DECLARE @tableName varchar(50)
 DECLARE @indexName varchar(100)
        DECLARE @LastRun        smalldatetime
        SELECT @LastRun = null
        -- declare cursor of tablenames in database
 DECLARE idx_cursor CURSOR
 FOR
  SELECT distinct a.name, b.name
  FROM sysobjects a,sysindexes b
  WHERE a.type = 'U'
  AND a.id = b.id
  AND b.indid > 0
 OPEN idx_cursor
 fetch next from idx_cursor into @tableName, @indexName
 while @@fetch_status = 0
   BEGIN
            
            -- check for table name in databaseindexstatus table
            -- if last index rebuild is greater than 1 week rebuild index
            SELECT @LastRun = LastRun 
     FROM  MSDB.DBO.DMV_VTIndexStatus 
     WHERE  TableName = @tableName
     AND  IndexName = @indexName
 
            If @LastRun is null 
                 BEGIN
                   INSERT MSDB.DBO.DMV_VTIndexStatus Values(@tableName, @indexName,GetDate())
                  EXEC ("DBCC DBREINDEX (" + @tableName + ", " + @indexName +")")
                   -- Exit while Loop
     IF @RebuildAll = 0 BREAK
                 END   
            If DATEDIFF(WW,@LastRun,GetDate()) > 1
                 BEGIN
                   UPDATE MSDB.DBO.DMV_VTIndexStatus SET LastRun = GetDate() WHERE TableName = @tableName
                  EXEC ("DBCC DBREINDEX (" + @tableName + ", " + @indexName +")")
     -- Exit while Loop
                   IF @RebuildAll = 0 BREAK
                 END   
     
            FETCH NEXT FROM idx_cursor INTO @tableName, @indexName
            SELECT @LastRun = null
   END
 DEALLOCATE idx_cursor
             






GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO

/****** Object:  Stored Procedure dbo.spf_CreateDMVADDRTempTable    Script Date: 1/11/2008 10:59:12 AM ******/

/****** Object:  Stored Procedure dbo.spf_CreateDMVADDRTempTable    Script Date: 8/11/2006 10:57:44 AM ******/


CREATE  PROCEDURE spf_CreateDMVADDRTempTable AS

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[DMVADDRTempTable]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[DMVADDRTempTable]

CREATE TABLE [dbo].[DMVADDRTempTable] (
	[ID] [int] IDENTITY (1, 1) NOT NULL ,
	[DMVID] [int] NULL ,
	[AddrTypeID] [int] NULL ,
	[Addr1] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Addr2] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[City] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[State] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Zip] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[UserID] [int] NULL ,
	[LastModified] [datetime] NULL ,
	[CreateDate] [datetime] NULL 
) ON [PRIMARY]



GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.spf_CreateDMVTempTable    Script Date: 1/11/2008 10:59:12 AM ******/

/****** Object:  Stored Procedure dbo.spf_CreateDMVTempTable    Script Date: 8/11/2006 10:57:44 AM ******/


CREATE  PROCEDURE spf_CreateDMVTempTable AS

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[DMVTempTable]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[DMVTempTable]

CREATE TABLE [dbo].[DMVTempTable] (
	[ID] [int] IDENTITY (1, 1) NOT NULL ,
	[ImportLogID] [int] NULL ,
	[SSN] [varchar] (11) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[License] [varchar] (9) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[DOB] [datetime] NULL ,
	[FirstName] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[MiddleName] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[LastName] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Suffix] [varchar] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Gender] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Donor] [bit] NOT NULL ,
	[RenewalDate] [datetime] NULL ,
	[DeceasedDate] [datetime] NULL ,
	[CSORState] [varchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CSORLicense] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[UserID] [int] NULL ,
	[LastModified] [datetime] NULL ,
	[CreateDate] [datetime] NULL,
 	[SignupDate] [datetime] NULL,
 	[PreviousDonorState] varchar(50) NULL
 	
) ON [PRIMARY]




GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

/****** Object:  Stored Procedure dbo.spf_DropDMVADDRTable    Script Date: 1/11/2008 10:59:12 AM ******/

/****** Object:  Stored Procedure dbo.spf_DropDMVADDRTable    Script Date: 8/11/2006 10:57:44 AM ******/

CREATE PROCEDURE spf_DropDMVADDRTable AS

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[DMVADDR]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[DMVADDR]


GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

/****** Object:  Stored Procedure dbo.spf_DropDMVTable    Script Date: 1/11/2008 10:59:12 AM ******/

/****** Object:  Stored Procedure dbo.spf_DropDMVTable    Script Date: 8/11/2006 10:57:44 AM ******/

CREATE PROCEDURE spf_DropDMVTable AS

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[DMV]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[DMV]


GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

















/****** Object:  Stored Procedure dbo.spi_IMPORT_ImportInitializeTest    Script Date: 1/11/2008 10:59:12 AM ******/

/****** Object:  Stored Procedure dbo.spi_IMPORT_ImportInitializeTest    Script Date: 8/11/2006 10:57:44 AM ******/



CREATE PROCEDURE spi_IMPORT_ImportInitializeTest AS
/*

	Desigened AND Developed 01/2003

	Legal Information...
	 ©1996-2003 Statline, LLC. All rights reserved. 

	 Statline is a registered trademark of Statline, LLC in the U.S.A. 


	 7555 East Hampden Avenue, Ste. 104, 
	 Denver, CO 80231. 
	 1-888-881-7828. 
*/
insert IMPORTLOGTest(RecordsTotal) values(0)
return @@IDENTITY







GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.spi_SourceEvent    Script Date: 1/11/2008 10:59:12 AM ******/

/****** Object:  Stored Procedure dbo.spi_SourceEvent    Script Date: 8/11/2006 10:57:44 AM ******/




CREATE PROCEDURE spi_SourceEvent AS

DECLARE @ErrorMessage VARCHAR(500)

INSERT RegistryEventSourceCodes
(
SourceCodeID,
SourceCodeName,
SourceCodeNote
)
SELECT DISTINCT SourceCodeID,
		SourceCodeName,
		SourceCodeNote
FROM _EventSource_Temp
WHERE SourceCodeID NOT IN (SELECT  SourceCodeID FROM RegistryEventSourceCodes)


SET @ErrorMessage = 'Information Message:> Event Source insert count: ' + CAST(@@ROWCOUNT AS VARCHAR)

RAISERROR (@ErrorMessage,10,1)with LOG












GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.sps_CheckRegistryv2    Script Date: 1/11/2008 10:59:12 AM ******/

/****** Object:  Stored Procedure dbo.sps_CheckRegistryv2    Script Date: 8/11/2006 10:57:46 AM ******/


/****** Object:  Stored Procedure dbo.sps_CheckRegistryv2    Script Date: 11/4/2005 12:25:13 PM ******/




CREATE Procedure sps_CheckRegistryv2
	@DOB   		DATETIME    	= NULL,
	@LastName	VARCHAR(25) 	= NULL,
	@FirstName 	VARCHAR(25) 	= NULL,
	@NADD 		INT	       	= NULL, -- NADD = No Additional Donor Data	
	@MiddleName 	VARCHAR(25) 	= NULL,
	@SSN   		VARCHAR(11) 	= NULL,
	@LICENSE 	VARCHAR(15) 	= NULL,
	@StreetAddress 	VARCHAR(45) 	= NULL,
	@City 		VARCHAR(25) 	= NULL,
	@State 		VARCHAR(2) 	= NULL,
	@Zip 		VARCHAR(10) 	= NULL,
	@loc		int	= null,
	@Found Varchar(25) = NULL
AS

SET NOCOUNT ON
print @loc
/*

Desigened AND Developed 01/2003

Legal Information...
 ©1996-2003 Statline, LLC. All rights reserved. 

 Statline is a registered trademark of Statline, LLC in the U.S.A. 


 7555 East Hampden Avenue, Ste. 104, 
 Denver, CO 80231. 
 1-888-881-7828. 

Paramameters
	First - Donors First Name
	Last  - Donors Last Name
	DOB   - Donor Date of Birth
	SSN   - Social Security Number	

-- SP_HELP DMV
*/
	-- DECLARE VARIABLES
	DECLARE @RegistryID INT,
		@RegistryDonor BIT,
		@RegistryDate SMALLDATETIME,
		@DMVID INT,
		@DMVDonor BIT,
		@DMVDate SMALLDATETIME,
		@RestrictionID INT,		
		@REGRecordsReturned INT,		
		@DMVRecordsReturned INT
	-- initialize @RestrictionID
	SELECT @RestrictionID  = 0 

	-- get values for registry 
	if  @Found = 'Web'  or isnull(@Found,'') = '' 
	     Begin
		EXEC sps_CheckRegistry_REGv2
		@DOB, 
		@LastName, 
		@FirstName, 
		@MiddleName, 
		@SSN, 
		@LICENSE, 
		@StreetAddress,
		@City,
		@State,
		@Zip,
		@loc,
		1,			-- This is the suspense variable see Note:			
		@RegistryID OUTPUT,
		@RegistryDonor OUTPUT,
		@RegistryDate OUTPUT,
		@REGRecordsReturned OUTPUT
	       End
		--print @RegistryID
		--print @RegistryDonor
		--print @REGRecordsReturned
/*
   Suspense Variable Note:
   NULL returns both registry (non-suspense) and suspense records
   1	returns registry  (non-suspense) records
   0	returns suspense records

*/
	print @loc
-- check for multiple records from registry 
-- IF MORE THAN 1 RECORD WAS RETURNED ASK FOR ADDITIONAL INFORMATION
	IF 	@REGRecordsReturned > 1 
		AND
		(ISNULL(@MiddleName, '') +  
		 ISNULL(@SSN, '') +
		 ISNULL(@LICENSE, '') +
		 ISNULL(@StreetAddress, '') +
		 ISNULL(@City, '') +
		 ISNULL(@State, '') +
		 ISNULL(@Zip, '') = '' 
		)
		BEGIN
			SELECT
			'Registration Undetermined' AS 'Source',
			0 AS 'ID',
			'U' AS 'Donor' , -- U is undetermined
			'1/1/1900' AS 'Date',
			0 AS 'RestrictionID',
			'R' as 'Organization',
			@REGRecordsReturned as 'RecordsReturned'
		
			RETURN
		END
	ELSE IF @REGRecordsReturned > 1 
		AND
		(
		 ISNULL(@NADD,1) = 1
		OR -- BJK 05/27/03 
		 ISNULL(@MiddleName, '') +  
		 ISNULL(@SSN, '') +
		 ISNULL(@LICENSE, '') +
		 ISNULL(@StreetAddress, '') +
		 ISNULL(@City, '') +
		 ISNULL(@State, '') +
		 ISNULL(@Zip, '') <> '' 
		)
		BEGIN
			
			SELECT
			'Registration Undetermined' AS 'Source',
			0 AS 'ID',
			'N' AS 'Donor' , -- U is undetermined
			'1/1/1900' AS 'Date',
			0 AS 'RestrictionID',
			'R' as 'Organization',
			@REGRecordsReturned as 'RecordsReturned'
		
			RETURN		
		END
	print @loc

	if  @Found = 'State'  or isnull(@Found,'') = '' 
	     Begin
		EXEC sps_CheckRegistry_DMVv2	
		@DOB, 
		@LastName, 
		@FirstName, 
		@MiddleName, 
		@SSN, 
		@LICENSE, 
		@StreetAddress,
		@City,
		@State,
		@Zip,
		@loc,
		@DMVID OUTPUT,
		@DMVDonor OUTPUT,
		@DMVDate OUTPUT,
		@DMVRecordsReturned OUTPUT
	       End
	
	-- check for multiple records from dmv 
	-- IF MORE THAN 1 RECORD WAS RETURNED ASK FOR ADDITIONAL INFORMATION
	IF 	@DMVRecordsReturned > 1 
		AND
		(
		 ISNULL(@MiddleName, '') +  
		 ISNULL(@SSN, '') +
		 ISNULL(@LICENSE, '') +
		 ISNULL(@StreetAddress, '') +
		 ISNULL(@City, '') +
		 ISNULL(@State, '') +
		 ISNULL(@Zip, '') = ''		 
		)
	BEGIN
		
		SELECT
		'Registration Undetermined' AS 'Source',
		0 AS 'ID',
		'U' AS 'Donor' , -- U is undetermined
		'1/1/1900' AS 'Date',
		0 AS 'RestrictionID',
		'R' as 'Organization',
		@DMVRecordsReturned as 'RecordsReturned'
		
		RETURN
	END
	ELSE IF @DMVRecordsReturned > 1 
		AND
		(
		 ISNULL(@NADD,1) = 1
		OR -- BJK 05/27/03 
		 ISNULL(@MiddleName, '') +  
		 ISNULL(@SSN, '') +
		 ISNULL(@LICENSE, '') +
		 ISNULL(@StreetAddress, '') +
		 ISNULL(@City, '') +
		 ISNULL(@State, '') +
		 ISNULL(@Zip, '') <> '' 
		)
		BEGIN
			

			SELECT
			'Registration Undetermined' AS 'Source',
			0 AS 'ID',
			'N' AS 'Donor' , -- U is undetermined
			'1/1/1900' AS 'Date',
			0 AS 'RestrictionID',
			'R' as 'Organization',
			@DMVRecordsReturned as 'RecordsReturned'
		
			RETURN		
		END
		

	/*

		SELECT  D.ID ,
			D.Donor ,
			CASE WHEN D.RENEWALDATE IS NULL THEN 
					CASE WHEN D.CREATEDATE IS NULL THEN '07/01/01' ELSE D.CREATEDATE END
			     ELSE D.RENEWALDATE END
		FROM DMV D
		WHERE LastName           = 'knoll'
		AND   FirstName          = 'bret'
		AND   DOB		  = '11/17/1970'

	*/

	--PRINT @DMVDonor
	--PRINT @RegistryDonor 
	--PRINT @OnlineDonor 

	-- if all the values are null return a blank record set
	IF (ISNULL(@DMVID, '') + ISNULL(@RegistryID, '') = '' )
	
		-- no values were found
		-- return empty record st
		BEGIN
			
			SELECT
				'No Registration' AS 'Source',
				0 AS 'ID',
				'N' AS 'Donor' ,
				'1/1/1900' AS 'Date',
				0 AS 'RestrictionID',
				'R' as 'Organization',
				@REGRecordsReturned as 'RecordsReturned'
				
				RETURN

		END

	
	-- check for the Oldest Date
	ELSE
		BEGIN
			IF	(ISNULL(@RegistryDate,'1/1/1900') > ISNULL(@DMVDate,'1/1/1900') )

				--Return Registry
				BEGIN
					SELECT
						'Registry' AS 'Source',
						@RegistryID AS 'ID',
						CASE @RegistryDonor WHEN 1 THEN 'Y' ELSE 'N' END AS 'Donor' ,
						@RegistryDate AS 'Date'	,
						@RestrictionID -- ADD CASE STATMENT FOR REGISTRY ID TO RETURN
						AS 'RestrictionID'
					RETURN				
				END		
			-- check if dmv is the latest date	
			ELSE IF (ISNULL(@DMVDate,'1/1/1900') > ISNULL(@RegistryDate,'1/1/1900'))
				-- Return DMV
				BEGIN
					SELECT
						'DMV' AS 'Source',
						@DMVID AS 'ID',
						CASE @DMVDonor WHEN 1 THEN 'Y' ELSE 'N' END AS 'Donor' ,
						@DMVDate AS 'Date',
						CASE @RegistryDonor When 1 Then @RegistryID Else 0 End AS 'RestrictionID' 
					RETURN
				END
			-- check if all the values are not = N for No
			-- Both registry and dmv dates are equal, check that both = Y
			ELSE IF ( ISNULL( @DMVDonor, 1 ) <> 0 AND ISNULL( @RegistryDonor, 1 ) <> 0 )
				BEGIN
					-- if registry is not null return registry
					IF (@RegistryID IS NOT NULL)
						BEGIN
						print ('Registry')
							SELECT
								
								'Registry' AS 'Source',
								@RegistryID AS 'ID',
								CASE @RegistryDonor WHEN 1 THEN 'Y' ELSE 'N' END AS 'Donor' ,
								@RegistryDate AS 'Date'	,
								@RestrictionID -- ADD CASE STATMENT FOR REGISTRY ID TO RETURN
								AS 'RestrictionID'
							RETURN								
						END
					ELSE 
						BEGIN 
						print('DMV')
							SELECT
								
								'DMV' AS 'Source',
								@DMVID AS 'ID',
								CASE @DMVDonor WHEN 1 THEN 'Y' ELSE 'N' END AS 'Donor' ,
								@DMVDate AS 'Date',
								CASE @RegistryDonor When 1 Then @RegistryID Else 0 End AS 'RestrictionID' 
							RETURN
						
						END
				
				END
			ELSE 	-- a result cannot be determined			
				-- return empty record st
				BEGIN
				
					SELECT
						'Undetermined Registration' AS 'Source',
						0 AS 'ID',
						'N' AS 'Donor' ,
						'1/1/1900' AS 'Date',
						@RestrictionID AS 'RestrictionID',
						'R' as 'Organization',
						@REGRecordsReturned as 'RecordsReturned'

						RETURN
				END			
		END




/* Query Sample
SELECT * 
FROM DMV
WHERE (LastName           LIKE 'Knoll'   or ISNULL('Knoll',   '')='')
AND   (FirstName          LIKE 'Bret'  or ISNULL('Bret',  '')='')
AND   (MiddleName         LIKE 'James' or ISNULL('JAMES', '')='')
AND   (License            LIKE '921243832'    or ISNULL('921243832',    '')='')
AND   (DOB		  LIKE '1970-11-17'	   OR ISNULL('1970-11-17', 	  '')='')
AND   (SSN	          LIKE '521471351' 	   OR ISNULL('521471351',	  '')='')

*/
-- SELECT COUNT(DONOR) FROM DMV WHERE DONOR = 1


GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.sps_CheckRegistryv2Test    Script Date: 1/11/2008 10:59:12 AM ******/

/****** Object:  Stored Procedure dbo.sps_CheckRegistryv2Test    Script Date: 8/11/2006 10:57:46 AM ******/





CREATE Procedure sps_CheckRegistryv2Test
	@DOB   		DATETIME    	= NULL,
	@LastName	VARCHAR(25) 	= NULL,
	@FirstName 	VARCHAR(25) 	= NULL,
	@NADD 		INT	       	= NULL, -- NADD = No Additional Donor Data	
	@MiddleName 	VARCHAR(25) 	= NULL,
	@SSN   		VARCHAR(11) 	= NULL,
	@LICENSE 	VARCHAR(15) 	= NULL,
	@StreetAddress 	VARCHAR(45) 	= NULL,
	@City 		VARCHAR(25) 	= NULL,
	@State 		VARCHAR(2) 	= NULL,
	@Zip 		VARCHAR(10) 	= NULL,
	@loc		int	= null,
	@Found Varchar(25) = NULL
AS

SET NOCOUNT ON
print @loc
/*

Desigened AND Developed 01/2003

Legal Information...
 ©1996-2003 Statline, LLC. All rights reserved. 

 Statline is a registered trademark of Statline, LLC in the U.S.A. 


 7555 East Hampden Avenue, Ste. 104, 
 Denver, CO 80231. 
 1-888-881-7828. 

Paramameters
	First - Donors First Name
	Last  - Donors Last Name
	DOB   - Donor Date of Birth
	SSN   - Social Security Number	

-- SP_HELP DMV
*/
	-- DECLARE VARIABLES
	DECLARE @RegistryID INT,
		@RegistryDonor BIT,
		@RegistryDate SMALLDATETIME,
		@DMVID INT,
		@DMVDonor BIT,
		@DMVDate SMALLDATETIME,
		@RestrictionID INT,		
		@REGRecordsReturned INT,		
		@DMVRecordsReturned INT
	-- initialize @RestrictionID
	SELECT @RestrictionID  = 0 

	-- get values for registry 
	if  @Found = 'Web'  or isnull(@Found,'') = '' 
	     Begin
		EXEC sps_CheckRegistry_REGv2
		@DOB, 
		@LastName, 
		@FirstName, 
		@MiddleName, 
		@SSN, 
		@LICENSE, 
		@StreetAddress,
		@City,
		@State,
		@Zip,
		@loc,
		1,			-- This is the suspense variable see Note:			
		@RegistryID OUTPUT,
		@RegistryDonor OUTPUT,
		@RegistryDate OUTPUT,
		@REGRecordsReturned OUTPUT
	       End
		--print @RegistryID
		--print @RegistryDonor
		--print @REGRecordsReturned
/*
   Suspense Variable Note:
   NULL returns both registry (non-suspense) and suspense records
   1	returns registry  (non-suspense) records
   0	returns suspense records

*/
	print @loc
-- check for multiple records from registry 
-- IF MORE THAN 1 RECORD WAS RETURNED ASK FOR ADDITIONAL INFORMATION
	IF 	@REGRecordsReturned > 1 
		AND
		(ISNULL(@MiddleName, '') +  
		 ISNULL(@SSN, '') +
		 ISNULL(@LICENSE, '') +
		 ISNULL(@StreetAddress, '') +
		 ISNULL(@City, '') +
		 ISNULL(@State, '') +
		 ISNULL(@Zip, '') = '' 
		)
		BEGIN
			SELECT
			'Registration Undetermined' AS 'Source',
			0 AS 'ID',
			'U' AS 'Donor' , -- U is undetermined
			'1/1/1900' AS 'Date',
			0 AS 'RestrictionID',
			'R' as 'Organization',
			@REGRecordsReturned as 'RecordsReturned'
		
			RETURN
		END
	ELSE IF @REGRecordsReturned > 1 
		AND
		(
		 ISNULL(@NADD,1) = 1
		OR -- BJK 05/27/03 
		 ISNULL(@MiddleName, '') +  
		 ISNULL(@SSN, '') +
		 ISNULL(@LICENSE, '') +
		 ISNULL(@StreetAddress, '') +
		 ISNULL(@City, '') +
		 ISNULL(@State, '') +
		 ISNULL(@Zip, '') <> '' 
		)
		BEGIN
			
			SELECT
			'Registration Undetermined' AS 'Source',
			0 AS 'ID',
			'N' AS 'Donor' , -- U is undetermined
			'1/1/1900' AS 'Date',
			0 AS 'RestrictionID',
			'R' as 'Organization',
			@REGRecordsReturned as 'RecordsReturned'
		
			RETURN		
		END
	print @loc

	if  @Found = 'State'  or isnull(@Found,'') = '' 
	     Begin
		EXEC sps_CheckRegistry_DMVv2	
		@DOB, 
		@LastName, 
		@FirstName, 
		@MiddleName, 
		@SSN, 
		@LICENSE, 
		@StreetAddress,
		@City,
		@State,
		@Zip,
		@loc,
		@DMVID OUTPUT,
		@DMVDonor OUTPUT,
		@DMVDate OUTPUT,
		@RegRecordsReturned OUTPUT
	       End
	
	-- check for multiple records from dmv 
	-- IF MORE THAN 1 RECORD WAS RETURNED ASK FOR ADDITIONAL INFORMATION
	IF 	@DMVRecordsReturned > 1 
		AND
		(
		 ISNULL(@MiddleName, '') +  
		 ISNULL(@SSN, '') +
		 ISNULL(@LICENSE, '') +
		 ISNULL(@StreetAddress, '') +
		 ISNULL(@City, '') +
		 ISNULL(@State, '') +
		 ISNULL(@Zip, '') = ''		 
		)
	BEGIN
		
		SELECT
		'Registration Undetermined' AS 'Source',
		0 AS 'ID',
		'U' AS 'Donor' , -- U is undetermined
		'1/1/1900' AS 'Date',
		0 AS 'RestrictionID',
		'R' as 'Organization',
		@REGRecordsReturned as 'RecordsReturned'
		
		RETURN
	END
	ELSE IF @DMVRecordsReturned > 1 
		AND
		(
		 ISNULL(@NADD,1) = 1
		OR -- BJK 05/27/03 
		 ISNULL(@MiddleName, '') +  
		 ISNULL(@SSN, '') +
		 ISNULL(@LICENSE, '') +
		 ISNULL(@StreetAddress, '') +
		 ISNULL(@City, '') +
		 ISNULL(@State, '') +
		 ISNULL(@Zip, '') <> '' 
		)
		BEGIN
			

			SELECT
			'Registration Undetermined' AS 'Source',
			0 AS 'ID',
			'N' AS 'Donor' , -- U is undetermined
			'1/1/1900' AS 'Date',
			0 AS 'RestrictionID',
			'R' as 'Organization',
			@REGRecordsReturned as 'RecordsReturned'
		
			RETURN		
		END
		

	/*

		SELECT  D.ID ,
			D.Donor ,
			CASE WHEN D.RENEWALDATE IS NULL THEN 
					CASE WHEN D.CREATEDATE IS NULL THEN '07/01/01' ELSE D.CREATEDATE END
			     ELSE D.RENEWALDATE END
		FROM DMV D
		WHERE LastName           = 'knoll'
		AND   FirstName          = 'bret'
		AND   DOB		  = '11/17/1970'

	*/

	--PRINT @DMVDonor
	--PRINT @RegistryDonor 
	--PRINT @OnlineDonor 

	-- if all the values are null return a blank record set
	IF (ISNULL(@DMVID, '') + ISNULL(@RegistryID, '') = '' )
	
		-- no values were found
		-- return empty record st
		BEGIN
			
			SELECT
				'No Registration' AS 'Source',
				0 AS 'ID',
				'N' AS 'Donor' ,
				'1/1/1900' AS 'Date',
				0 AS 'RestrictionID',
				'R' as 'Organization',
				@REGRecordsReturned as 'RecordsReturned'
				
				RETURN

		END

	
	-- check for the Oldest Date
	ELSE
		BEGIN
			IF	(ISNULL(@RegistryDate,'1/1/1900') > ISNULL(@DMVDate,'1/1/1900') )

				--Return Registry
				BEGIN
					SELECT
						'Registry' AS 'Source',
						@RegistryID AS 'ID',
						CASE @RegistryDonor WHEN 1 THEN 'Y' ELSE 'N' END AS 'Donor' ,
						@RegistryDate AS 'Date'	,
						@RestrictionID -- ADD CASE STATMENT FOR REGISTRY ID TO RETURN
						AS 'RestrictionID'
					RETURN				
				END		
			-- check if dmv is the latest date	
			ELSE IF (ISNULL(@DMVDate,'1/1/1900') > ISNULL(@RegistryDate,'1/1/1900'))
				-- Return DMV
				BEGIN
					SELECT
						'DMV' AS 'Source',
						@DMVID AS 'ID',
						CASE @DMVDonor WHEN 1 THEN 'Y' ELSE 'N' END AS 'Donor' ,
						@DMVDate AS 'Date',
						CASE @RegistryDonor When 1 Then @RegistryID Else 0 End AS 'RestrictionID' 
					RETURN
				END
			-- check if all the values are not = N for No
			-- Both registry and dmv dates are equal, check that both = Y
			ELSE IF ( ISNULL( @DMVDonor, 1 ) <> 0 AND ISNULL( @RegistryDonor, 1 ) <> 0 )
				BEGIN
					-- if registry is not null return registry
					IF (@RegistryID IS NOT NULL)
						BEGIN
						print ('Registry')
							SELECT
								
								'Registry' AS 'Source',
								@RegistryID AS 'ID',
								CASE @RegistryDonor WHEN 1 THEN 'Y' ELSE 'N' END AS 'Donor' ,
								@RegistryDate AS 'Date'	,
								@RestrictionID -- ADD CASE STATMENT FOR REGISTRY ID TO RETURN
								AS 'RestrictionID'
							RETURN								
						END
					ELSE 
						BEGIN 
						print('DMV')
							SELECT
								
								'DMV' AS 'Source',
								@DMVID AS 'ID',
								CASE @DMVDonor WHEN 1 THEN 'Y' ELSE 'N' END AS 'Donor' ,
								@DMVDate AS 'Date',
								CASE @RegistryDonor When 1 Then @RegistryID Else 0 End AS 'RestrictionID' 
							RETURN
						
						END
				
				END
			ELSE 	-- a result cannot be determined			
				-- return empty record st
				BEGIN
				
					SELECT
						'Undetermined Registration' AS 'Source',
						0 AS 'ID',
						'N' AS 'Donor' ,
						'1/1/1900' AS 'Date',
						@RestrictionID AS 'RestrictionID',
						'R' as 'Organization',
						@REGRecordsReturned as 'RecordsReturned'

						RETURN
				END			
		END




/* Query Sample
SELECT * 
FROM DMV
WHERE (LastName           LIKE 'Knoll'   or ISNULL('Knoll',   '')='')
AND   (FirstName          LIKE 'Bret'  or ISNULL('Bret',  '')='')
AND   (MiddleName         LIKE 'James' or ISNULL('JAMES', '')='')
AND   (License            LIKE '921243832'    or ISNULL('921243832',    '')='')
AND   (DOB		  LIKE '1970-11-17'	   OR ISNULL('1970-11-17', 	  '')='')
AND   (SSN	          LIKE '521471351' 	   OR ISNULL('521471351',	  '')='')

*/
-- SELECT COUNT(DONOR) FROM DMV WHERE DONOR = 1



GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.sps_DMVwildcard    Script Date: 1/11/2008 10:59:12 AM ******/

/****** Object:  Stored Procedure dbo.sps_DMVwildcard    Script Date: 8/11/2006 10:57:44 AM ******/





CREATE PROCEDURE sps_DMVwildcard @LastName   varchar(255),
                                 @FirstName  varchar(255),
                                 @MiddleName varchar(255),
                                 @License    varchar(255),
                                 @Day        varchar(255),
                                 @Month      varchar(255),
                                 @Year       varchar(255)  AS
/*

	Desigened AND Developed 01/2003

	Legal Information...
	©1996-2003 Statline, LLC. All rights reserved. 

	Statline is a registered trademark of Statline, LLC in the U.S.A. 


	7555 East Hampden Avenue, Ste. 104, 
	Denver, CO 80231. 
	1-888-881-7828. 
*/
IF substring(@Day,1,1)=0   select @Day=substring(@Day,2,255)
IF substring(@Month,1,1)=0 select @Month=substring(@Month,2,255)
select * 
from DMV
where	(License            like @License    or isnull(@License,    '')='')
and	(datepart(mm,DOB)   like @Month      or isnull(@Month,      '')='')
and	(datepart(dd,DOB)   like @Day        or isnull(@Day,        '')='')
and	(datepart(yyyy,DOB) like @Year       or isnull(@Year,       '')='')
and	(FirstName          like @FirstName  or isnull(@FirstName,  '')='')
and	(MiddleName         like @MiddleName or isnull(@MiddleName, '')='')
and	(LastName           like @LastName   or isnull(@LastName,   '')='')








GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.sps_GetServerDB    Script Date: 1/11/2008 10:59:12 AM ******/

/****** Object:  Stored Procedure dbo.sps_GetServerDB    Script Date: 8/11/2006 10:57:44 AM ******/





CREATE PROCEDURE sps_GetServerDB 
AS
/*

	Desigened AND Developed 01/2003

	Legal Information...
	 ©1996-2003 Statline, LLC. All rights reserved. 

	 Statline is a registered trademark of Statline, LLC in the U.S.A. 


	 7555 East Hampden Avenue, Ste. 104, 
	 Denver, CO 80231. 
	 1-888-881-7828. 
*/
SELECT @@ServerName as 'Server_Name', DB_NAME(db_id()) AS 'DB_Name'







GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.sps_IMPORT_A_DataCleanupReplaceNonAlphaName    Script Date: 1/11/2008 10:59:12 AM ******/

/****** Object:  Stored Procedure dbo.sps_IMPORT_A_DataCleanupReplaceNonAlphaName    Script Date: 8/11/2006 10:57:45 AM ******/


-- sp_helptext IMPORT_DataCleanupReplaceNonAlphaName
CREATE  PROCEDURE sps_IMPORT_A_DataCleanupReplaceNonAlphaName AS
/* This procedure requires function Remove_BAD255 to be in place
*/

UPDATE IMPORT_A SET FIRST = dbo.REMOVE_BAD255(FIRST)
WHERE PATINDEX ('%[^A-Z]%',FIRST) > 0

UPDATE IMPORT_A SET MIDDLE = dbo.REMOVE_BAD255(MIDDLE)
WHERE PATINDEX ('%[^A-Z]%',MIDDLE) > 0

UPDATE IMPORT_A SET LAST = dbo.REMOVE_BAD255(LAST)
WHERE PATINDEX ('%[^A-Z]%',LAST) > 0




GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

/****** Object:  Stored Procedure dbo.sps_checkregistry_DMVLoad    Script Date: 1/11/2008 10:59:12 AM ******/
CREATE PROCEDURE sps_checkregistry_DMVLoad
 
	@DOB   varchar(25)    = NULL,
	@LastName  VARCHAR(25) = NULL,
	@FirstName VARCHAR(25) = NULL, 
	@MiddleName VARCHAR(25) = NULL,
	@SSN   VARCHAR(11) = NULL,
	@LICENSE VARCHAR(15) = NULL,
	@StreetAddress VARCHAR(45) = NULL,
	@City VARCHAR(25) = NULL,
	@State VARCHAR(2) = NULL,
	@Zip VARCHAR(10) = NULL,
	@Loc  int = null
	
AS
/******************************************************************************
**		File: 
**		Name: sps_CheckRegistry_DMVLoad
**		Desc: 
**
**		This template can be customized:
**              
**		Return values:
** 
**		Called by:   FrmDonorData
**              
**		Parameters:
**
**		Auth: Unknown
**		Date: 3/2003
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**    10/15/2007	ccarroll			Added FirstName, and LastName to select
*******************************************************************************/
SET NOCOUNT ON
	declare
		@RecordsReturned int,
		@strproc	varchar(8000)
				set @strproc =  'Select DMV.FirstName, DMV.MiddleName, DMV.LastName, Dmv.License as  License, '	
				set @strproc = @strproc + 'DMVAddr.Addr1 as  Addr1, '
				set @strproc = @strproc   + 'DMVAddr.city as   City, '
				set @strproc = @strproc   + 'DMVAddr.State as  State, '
				set @strproc = @strproc   + 'DMVAddr.zip as  Zip, '
				
				set @strproc = @strproc   + 'DMV.LastModified as  SearchDate, '
				set @strproc = @strproc   + 'DMV.ID as Loc'
			
				
				set @strproc = @strproc   +  ' FROM DMV join DMVAddr On DMV.ID = DMVAddr.Dmvid '
				set @strproc = @strproc   +   ' WHERE	DMV.DOB = ' +"'" + @DOB  ++"'" + ' And'	
				--set @strproc = @strproc   +  'AND	'
				If  @MiddleName is not null
					Begin
						Set @strproc = @strproc + ' dmv.middleName = ' + "'" + @MiddleName + "'" +  ' And '
					End
				If  @License is not null
					Begin
						Set @strproc = @strproc + ' dmv.License = ' + "'" + @License + "'" +  ' And '
					End
				If  @StreetAddress is not null
					Begin
						if Left(@StreetAddress,1) = '*' or Right(@StreetAddress,1)  = '*'
							Begin
								set @StreetAddress = REPLACE(@StreetAddress,'*','%');
								Set @strproc = @strproc + '  DMVAddr.Addr1  like ' + "'" + @StreetAddress + "'" +  ' And '
							end
						else
							Begin
								Set @strproc = @strproc + ' DMVAddr.Addr1 = ' + "'" + @StreetAddress + "'" +  ' And '
							end
					End
				If  @City is not null
					Begin
						if Left(@City,1) = '*' or Right(@City,1)  = '*'
							Begin
								set @City = REPLACE(@City,'*','%');
								Set @strproc = @strproc + '  DMVAddr.City like ' + "'" + @City + "'" +  ' And '
							end
						else
							Begin
								Set @strproc = @strproc + ' DMVAddr.City = ' + "'" + @City + "'" +  ' And '
							end
					End
				If  @State is not null
					Begin
						Set @strproc = @strproc + ' DMVAddr.State = ' + "'" + @State+ "'" +  ' And '
					End
				If  @Zip is not null
					Begin
						Set @strproc = @strproc + ' DMVAddr.Zip = ' + "'" + @Zip + "'" +  ' And '
					End
				set @strproc = @strproc   +   ' dmv.FirstName           = '  +  "'" + @FirstName + "'"
				set @strproc = @strproc    + ' AND	dmv.LastName             = ' + "'" + @LastName	+"'" 
				set @strproc = @strproc   +  ' ORDER BY dmv.middleName,DMVAddr.Zip,DMVAddr.City,DMVAddr.Addr1 '


print @strproc
exec(@strproc)

GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

GRANT  EXECUTE  ON [dbo].[sps_checkregistry_DMVLoad]  TO [public]
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.spu_SourceEvent    Script Date: 1/11/2008 10:59:12 AM ******/

/****** Object:  Stored Procedure dbo.spu_SourceEvent    Script Date: 8/11/2006 10:57:44 AM ******/




CREATE PROCEDURE spu_SourceEvent AS

DECLARE @ErrorMessage VARCHAR(500)

	UPDATE EventSourceCodes
	SET
	EventSourceCodes.SourceCodeName  = EST.SourceCodeName,
	EventSourceCodes.SourceCodeNote  = EST.SourceCodeNote 
	
	FROM _EventSource_Temp EST
	WHERE EventSourceCodes.SourceCodeID  = EST.SourceCodeID
	
SET @ErrorMessage = 'Information Message:> Event Source update count: ' + CAST(@@ROWCOUNT AS VARCHAR)

RAISERROR (@ErrorMessage,10,1)with LOG







GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.SPS_CheckRegistry_REG    Script Date: 1/11/2008 10:59:12 AM ******/

/****** Object:  Stored Procedure dbo.SPS_CheckRegistry_REG    Script Date: 8/11/2006 10:57:45 AM ******/






CREATE Procedure SPS_CheckRegistry_REG
	@DOB   DATETIME    = NULL,
	@LastName  VARCHAR(25) = NULL,
	@FirstName VARCHAR(25) = NULL,
	@MiddleName VARCHAR(25) = NULL,
	@SSN   VARCHAR(11) = NULL,
	@LICENSE VARCHAR(15) = NULL,
	@StreetAddress VARCHAR(45) = NULL,
	@City VARCHAR(25) = NULL,
	@State VARCHAR(2) = NULL,
	@Zip VARCHAR(10) = NULL,
	@DonorConfirmed BIT = NULL,
	@REGID INT OUTPUT,
	@REGDonor BIT OUTPUT,
	@REGDate SMALLDATETIME OUTPUT,
	@RecordsReturned INT OUTPUT 

AS
SET NOCOUNT ON
/*
This stored procedure is called by sps_CheckRegistry to query the Registry table

Desigened AND Developed 03/2003

Legal Information...
 ©1996-2003 Statline, LLC. All rights reserved. 

 Statline is a registered trademark of Statline, LLC in the U.S.A. 


 7555 East Hampden Avenue, Ste. 104, 
 Denver, CO 80231. 
 1-888-881-7828. 


*/

	-- get values for REG
	IF	ISNULL(@MiddleName, '') +  
		ISNULL(@SSN, '') +
		ISNULL(@LICENSE, '') +
		ISNULL(@StreetAddress, '') +
		ISNULL(@City, '') +		
		ISNULL(@Zip, '') = '' 
	BEGIN	
-- PRINT 'REG: QUERY WITH DOB, LAST AND FIRST'
		SELECT  --TOP 1
			@REGID = D.ID ,
			@REGDonor = D.Donor ,
			@REGDate = CASE 
					WHEN SignatureDate IS NULL THEN 
					CASE WHEN OnlineRegDate IS NULL THEN CreateDate ELSE OnlineRegDate End
			      		ELSE SignatureDate END
		FROM Registry D
		WHERE	DOB		= @DOB			
		AND	FirstName       = @FirstName			
		AND	LastName	= @LastName		 			
		AND   (DonorConfirmed	  = @DonorConfirmed OR ISNULL(@DonorConfirmed, 	'')='')
		ORDER BY LASTMODIFIED DESC

		-- get the number of records returned
		SELECT @RecordsReturned = @@RowCount
		
		-- Note: No record count is used in the registry query. The registry tables could have a duplicate
		---      records of the same person. The registration form allows donors to register as often as they want.
		
	END
	ELSE
	BEGIN
		-- license
		IF ISNULL(@LICENSE, '') <> ''
		BEGIN
-- PRINT 'REG: QUERY WITH LICENSE: ' + @LICENSE
			SELECT  --TOP 1
				@REGID = D.ID ,
				@REGDonor = D.Donor ,
				@REGDate = CASE 
						WHEN SignatureDate IS NULL THEN 
						CASE WHEN OnlineRegDate IS NULL THEN CreateDate ELSE OnlineRegDate End
			     	 		ELSE SignatureDate END
			FROM 	Registry D
			WHERE	DOB		= @DOB			
			AND	FirstName       = @FirstName			
			AND	LastName	= @LastName								
			AND	License		= @LICENSE
			AND	(DonorConfirmed	  = @DonorConfirmed OR ISNULL(@DonorConfirmed, 	'')='')
			ORDER BY LASTMODIFIED DESC

			-- get the number of records returned
			SELECT @RecordsReturned = @@RowCount

			-- Note: No record count is used in the registry query. The registry tables could have a duplicate
			---      records of the same person. The registration form allows donors to register as often as they want.
		END
		
		-- PRINT 'record count before middlename if: ' + ISNULL(cast(@RecordsReturned as varchar(3)), '')
		-- middlename
		IF ISNULL(@MiddleName, '') <> '' AND (@RecordsReturned > 1 OR ISNULL(@RecordsReturned,0) = 0)
		BEGIN
-- PRINT 'REG: QUERY WITH MIDDLENAME: ' + @MiddleName
			SELECT  --TOP 1
				@REGID = D.ID ,
				@REGDonor = D.Donor ,
				@REGDate = CASE 
						WHEN SignatureDate IS NULL THEN 
						CASE WHEN OnlineRegDate IS NULL THEN CreateDate ELSE OnlineRegDate End
			      			ELSE SignatureDate END
			FROM 	Registry D
			WHERE	DOB		= @DOB			
			AND	FirstName       = @FirstName			
			AND	MiddleName	= @MiddleName	
			AND	LastName	= @LastName		
			AND	(DonorConfirmed	  = @DonorConfirmed OR ISNULL(@DonorConfirmed, 	'')='')
			ORDER BY LASTMODIFIED DESC

			-- get the number of records returned
			SELECT @RecordsReturned = @@RowCount

			-- Note: No record count is used in the registry query. The registry tables could have a duplicate
			---      records of the same person. The registration form allows donors to register as often as they want.
		
		END
		-- ADDRESS + NAME AND BIRTHDATE
		IF ISNULL(@StreetAddress, '') + ISNULL(@State, '') + ISNULL(@Zip, '') <> '' AND (@RecordsReturned > 1 OR ISNULL(@RecordsReturned,0) = 0)
		BEGIN
-- PRINT 'REG: QUERY WITH Address: ' + @StreetAddress + " " + @State + " " + @Zip
			SELECT  --TOP 1
				@REGID = D.ID ,
				@REGDonor = D.Donor ,
				@REGDate = CASE 
						WHEN D.SignatureDate IS NULL THEN 
						CASE WHEN D.OnlineRegDate IS NULL THEN D.CreateDate ELSE D.OnlineRegDate End
			      			ELSE D.SignatureDate END
			FROM Registry D
			JOIN RegistryAddr DA ON DA.RegistryID = D.ID
			WHERE	DOB		= @DOB			
			AND	FirstName       = @FirstName			
			AND	LastName	= @LastName		
			AND   	(DonorConfirmed	  = @DonorConfirmed OR ISNULL(@DonorConfirmed, 	'')='')			
			AND   	(LEFT(DA.ADDR1, 5)	  = LEFT(@StreetAddress, 5) 
								OR ISNULL(@StreetAddress, '')='')
			AND   	(DA.State		  = @State	OR ISNULL(@State, 	'')='')
			AND   	(LEFT(DA.Zip, 5)	  = LEFT(@Zip, 5)
								OR ISNULL(@Zip	, 	'')='')
			ORDER BY D.LASTMODIFIED DESC

			-- get the number of records returned
			SELECT @RecordsReturned = @@RowCount		
			
			-- Note: No record count is used in the registry query. The registry tables could have a duplicate
			---      records of the same person. The registration form allows donors to register as often as they want.
	
		END
		
		-- SSN
		IF ISNULL(@SSN, '') <> '' AND (@RecordsReturned > 1 OR ISNULL(@RecordsReturned,0) = 0)
		BEGIN
-- PRINT 'REG: QUERY WITH SSN: ' + @SSN
			SELECT  --TOP 1
				@REGID = D.ID ,
				@REGDonor = D.Donor ,
				@REGDate = CASE 
						WHEN SignatureDate IS NULL THEN 
						CASE WHEN OnlineRegDate IS NULL THEN CreateDate ELSE OnlineRegDate End
			      			ELSE SignatureDate END
			FROM Registry D
			WHERE	SSN	= @SSN
			AND   	(DonorConfirmed	  = @DonorConfirmed OR ISNULL(@DonorConfirmed, 	'')='')	
			ORDER BY LASTMODIFIED DESC

			-- get the number of records returned
			SELECT @RecordsReturned = @@RowCount		

			-- Note: No record count is used in the registry query. The registry tables could have a duplicate
			---      records of the same person. The registration form allows donors to register as often as they want.
		END
	END

-- PRINT 'REG: what is the REG record count: ' + ISNULL(cast(@RecordsReturned as varchar(3)), '')
	-- IF MORE THAN 1 RECORD WAS RETURNED ASK FOR ADDITIONAL INFORMATION
	IF ISNULL(@RecordsReturned,0) = 0
	BEGIN
		SELECT
		@REGID	  = 0,
		@REGDonor = 0,
		@REGDate  = '1/1/1900'
		
		RETURN
	END
	ELSE
	BEGIN
		RETURN
	END


GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

/****** Object:  Stored Procedure dbo.SPS_CheckRegistry_REGv2    Script Date: 1/11/2008 10:59:12 AM ******/

/****** Object:  Stored Procedure dbo.SPS_CheckRegistry_REGv2    Script Date: 8/11/2006 10:57:45 AM ******/




CREATE Procedure SPS_CheckRegistry_REGv2
	@DOB   DATETIME    = NULL,
	@LastName  VARCHAR(25) = NULL,
	@FirstName VARCHAR(25) = NULL,
	@MiddleName VARCHAR(25) = NULL,
	@SSN   VARCHAR(11) = NULL,
	@LICENSE VARCHAR(15) = NULL,
	@StreetAddress VARCHAR(45) = NULL,
	@City VARCHAR(25) = NULL,
	@State VARCHAR(2) = NULL,
	@Zip VARCHAR(10) = NULL,
	@loc int = NULL,
	@DonorConfirmed BIT = NULL,
	@REGID INT OUTPUT,
	@REGDonor BIT OUTPUT,
	@REGDate SMALLDATETIME OUTPUT,
	@RecordsReturned INT OUTPUT 

AS
SET NOCOUNT ON
/*
This stored procedure is called by sps_CheckRegistry to query the Registry table

Desigened AND Developed 03/2003

Legal Information...
 ©1996-2003 Statline, LLC. All rights reserved. 

 Statline is a registered trademark of Statline, LLC in the U.S.A. 


 7555 East Hampden Avenue, Ste. 104, 
 Denver, CO 80231. 
 1-888-881-7828. 


*/
print 'loc'
print @loc
	if  isnull(@loc,'') <>  ''
		Begin
		print 'enter'
		SELECT  --TOP 1
			@REGID = D.ID ,
			@REGDonor = D.Donor ,
			@REGDate =  D.LastModified

		FROM Registry D
		WHERE	d.id = @loc --DOB		= @DOB			
		AND	FirstName       = @FirstName			
		AND	LastName	= @LastName		 			
		--AND   (DonorConfirmed	  = @DonorConfirmed OR ISNULL(@DonorConfirmed, 	'')='')
		ORDER BY LASTMODIFIED DESC


		-- get the number of records returned
		SELECT @RecordsReturned = @@RowCount
	return
	end

	-- get values for REG
	IF	ISNULL(@MiddleName, '') +  
		ISNULL(@SSN, '') +
		ISNULL(@LICENSE, '') +
		ISNULL(@StreetAddress, '') +
		ISNULL(@City, '') +		
		ISNULL(@Zip, '') = '' 
	BEGIN	
-- PRINT 'REG: QUERY WITH DOB, LAST AND FIRST'
		SELECT  --TOP 1
			@REGID = D.ID ,
			@REGDonor = D.Donor ,
			@REGDate = CASE 
					WHEN SignatureDate IS NULL THEN 
					CASE WHEN OnlineRegDate IS NULL THEN CreateDate ELSE OnlineRegDate End
			      		ELSE SignatureDate END
		FROM Registry D
		WHERE	DOB		= @DOB			
		AND	FirstName       = @FirstName			
		AND	LastName	= @LastName		 			
		AND   (DonorConfirmed	  = @DonorConfirmed OR ISNULL(@DonorConfirmed, 	'')='')
		ORDER BY LASTMODIFIED DESC

		-- get the number of records returned
		SELECT @RecordsReturned = @@RowCount
		
		-- Note: No record count is used in the registry query. The registry tables could have a duplicate
		---      records of the same person. The registration form allows donors to register as often as they want.
		
	END
	ELSE
	BEGIN
		-- license
		IF ISNULL(@LICENSE, '') <> ''
		BEGIN
-- PRINT 'REG: QUERY WITH LICENSE: ' + @LICENSE
			SELECT  --TOP 1
				@REGID = D.ID ,
				@REGDonor = D.Donor ,
				@REGDate = CASE 
						WHEN SignatureDate IS NULL THEN 
						CASE WHEN OnlineRegDate IS NULL THEN CreateDate ELSE OnlineRegDate End
			     	 		ELSE SignatureDate END
			FROM 	Registry D
			WHERE	DOB		= @DOB			
			AND	FirstName       = @FirstName			
			AND	LastName	= @LastName								
			AND	License		= @LICENSE
			AND	(DonorConfirmed	  = @DonorConfirmed OR ISNULL(@DonorConfirmed, 	'')='')
			ORDER BY LASTMODIFIED DESC

			-- get the number of records returned
			SELECT @RecordsReturned = @@RowCount

			-- Note: No record count is used in the registry query. The registry tables could have a duplicate
			---      records of the same person. The registration form allows donors to register as often as they want.
		END
		
		-- PRINT 'record count before middlename if: ' + ISNULL(cast(@RecordsReturned as varchar(3)), '')
		-- middlename
		IF ISNULL(@MiddleName, '') <> '' AND (@RecordsReturned > 1 OR ISNULL(@RecordsReturned,0) = 0)
		BEGIN
-- PRINT 'REG: QUERY WITH MIDDLENAME: ' + @MiddleName
			SELECT  --TOP 1
				@REGID = D.ID ,
				@REGDonor = D.Donor ,
				@REGDate = CASE 
						WHEN SignatureDate IS NULL THEN 
						CASE WHEN OnlineRegDate IS NULL THEN CreateDate ELSE OnlineRegDate End
			      			ELSE SignatureDate END
			FROM 	Registry D
			WHERE	DOB		= @DOB			
			AND	FirstName       = @FirstName			
			AND	MiddleName	= @MiddleName	
			AND	LastName	= @LastName		
			AND	(DonorConfirmed	  = @DonorConfirmed OR ISNULL(@DonorConfirmed, 	'')='')
			ORDER BY LASTMODIFIED DESC

			-- get the number of records returned
			SELECT @RecordsReturned = @@RowCount

			-- Note: No record count is used in the registry query. The registry tables could have a duplicate
			---      records of the same person. The registration form allows donors to register as often as they want.
		
		END
		-- ADDRESS + NAME AND BIRTHDATE
		IF ISNULL(@StreetAddress, '') + ISNULL(@State, '') + ISNULL(@Zip, '') <> '' AND (@RecordsReturned > 1 OR ISNULL(@RecordsReturned,0) = 0)
		BEGIN
-- PRINT 'REG: QUERY WITH Address: ' + @StreetAddress + " " + @State + " " + @Zip
			SELECT  --TOP 1
				@REGID = D.ID ,
				@REGDonor = D.Donor ,
				@REGDate = CASE 
						WHEN D.SignatureDate IS NULL THEN 
						CASE WHEN D.OnlineRegDate IS NULL THEN D.CreateDate ELSE D.OnlineRegDate End
			      			ELSE D.SignatureDate END
			FROM Registry D
			JOIN RegistryAddr DA ON DA.RegistryID = D.ID
			WHERE	DOB		= @DOB			
			AND	FirstName       = @FirstName			
			AND	LastName	= @LastName		
			AND   	(DonorConfirmed	  = @DonorConfirmed OR ISNULL(@DonorConfirmed, 	'')='')			
			AND   	(LEFT(DA.ADDR1, 5)	  = LEFT(@StreetAddress, 5) 
								OR ISNULL(@StreetAddress, '')='')
			AND   	(DA.State		  = @State	OR ISNULL(@State, 	'')='')
			AND   	(LEFT(DA.Zip, 5)	  = LEFT(@Zip, 5)
								OR ISNULL(@Zip	, 	'')='')
			ORDER BY D.LASTMODIFIED DESC

			-- get the number of records returned
			SELECT @RecordsReturned = @@RowCount		
			
			-- Note: No record count is used in the registry query. The registry tables could have a duplicate
			---      records of the same person. The registration form allows donors to register as often as they want.
	
		END
		
		-- SSN
		IF ISNULL(@SSN, '') <> '' AND (@RecordsReturned > 1 OR ISNULL(@RecordsReturned,0) = 0)
		BEGIN
-- PRINT 'REG: QUERY WITH SSN: ' + @SSN
			SELECT  --TOP 1
				@REGID = D.ID ,
				@REGDonor = D.Donor ,
				@REGDate = CASE 
						WHEN SignatureDate IS NULL THEN 
						CASE WHEN OnlineRegDate IS NULL THEN CreateDate ELSE OnlineRegDate End
			      			ELSE SignatureDate END
			FROM Registry D
			WHERE	SSN	= @SSN
			AND   	(DonorConfirmed	  = @DonorConfirmed OR ISNULL(@DonorConfirmed, 	'')='')	
			ORDER BY LASTMODIFIED DESC

			-- get the number of records returned
			SELECT @RecordsReturned = @@RowCount		

			-- Note: No record count is used in the registry query. The registry tables could have a duplicate
			---      records of the same person. The registration form allows donors to register as often as they want.
		END
	END

-- PRINT 'REG: what is the REG record count: ' + ISNULL(cast(@RecordsReturned as varchar(3)), '')
	-- IF MORE THAN 1 RECORD WAS RETURNED ASK FOR ADDITIONAL INFORMATION
	IF ISNULL(@RecordsReturned,0) = 0
	BEGIN
		SELECT
		@REGID	  = 0,
		@REGDonor = 0,
		@REGDate  = '1/1/1900'
		
		RETURN
	END
	ELSE
	BEGIN
		RETURN
	END
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.SPUI_REGISTRYADDR    Script Date: 1/11/2008 10:59:12 AM ******/

/****** Object:  Stored Procedure dbo.SPUI_REGISTRYADDR    Script Date: 8/11/2006 10:57:45 AM ******/







CREATE PROCEDURE SPUI_REGISTRYADDR
	@pvRegistryID	AS INT		=NULL,
	@pvADDRTYPE	AS INT		=NULL,
	@pvADDR		AS VARCHAR(40)	=NULL,
	@pvCITY		AS VARCHAR(25)	=NULL,
	@pvSTATE	AS VARCHAR(2)	=NULL,
	@pvZIP		AS VARCHAR(10)	=NULL,
	@pvUserID	AS INT 		=NULL,
	@AddrResult 	AS VARCHAR(50)  =NULL OUTPUT


AS
/*

	Desigened AND Developed 01/2003

	Legal Information...
	 ©1996-2003 Statline, LLC. All rights reserved. 

	 Statline is a registered trademark of Statline, LLC in the U.S.A. 


	 7555 East Hampden Avenue, Ste. 104, 
	 Denver, CO 80231. 
	 1-888-881-7828. 

	@pvRegistryID
	@pvADDRTYPE
	@pvADDR
	@pvCITY
	@pvSTATE
	@pvZIP
	 
*/
-- turn record counts off
SET NOCOUNT ON

DECLARE @CURRENTADDRID	AS INT
	


-- check for values execute sp if they exist
IF ISNULL(@pvADDR, '') + ISNULL(@pvCITY,'') + ISNULL(@pvSTATE, '') + ISNULL(@pvZIP, '') <> ''
BEGIN -- execute sp

	SELECT 	@CURRENTADDRID = ID 
	FROM 	RegistryAddr 
	WHERE 	RegistryID = @pvRegistryID
	AND	AddrTypeID = @pvADDRTYPE
	
	IF @CURRENTADDRID > 0 
	BEGIN	-- update
	
		UPDATE [REGISTRYADDR] 
	
		SET  
			[Addr1]	 	= @pvADDR,
			[City]	 	= @pvCITY,
			[State]	 	= @pvSTATE,
			[Zip]	 	= @pvZIP,
			[UserID]	= @pvUserID
	
		WHERE	[ID] 		= @CURRENTADDRID

		-- create the return statment
		IF @@ERROR = 0
		BEGIN
			SELECT @AddrResult = CASE @pvADDRTYPE WHEN 1 THEN 'Residential' WHEN 2 THEN 'Mailing' END + ' address ' + CAST(@CURRENTADDRID AS VARCHAR(10)) + ' was updated'
		END
		ELSE
		BEGIN
			SELECT @AddrResult = 'An error occured while attempting to update ' + CASE @pvADDRTYPE WHEN 1 THEN 'Residential ' WHEN 2 THEN 'Mailing 'END + 'address ' + CAST(@CURRENTADDRID AS VARCHAR(10)) + ''

		END

	END -- update
	ELSE
	BEGIN 	-- insert
		INSERT INTO [REGISTRYADDR] 
			 ( 
			 [RegistryID],
			 [AddrTypeID],
			 [Addr1],			 
			 [City],
			 [State],
			 [Zip],
			 [UserID],
			 [CreateDate]
			 ) 

		VALUES 
			( 
			 @pvRegistryID,
			 @pvADDRTYPE,
			 @pvADDR,
			 @pvCITY,
			 @pvSTATE,
			 @pvZIP,
			 @pvUserID,
			 GETDATE()			 
			 )
		
		
		IF @@ERROR = 0
		BEGIN
			SELECT @CURRENTADDRID = @@IDENTITY
			SELECT @AddrResult = CASE @pvADDRTYPE WHEN 1 THEN 'Residential ' WHEN 2 THEN 'Mailing 'END + ' address ' + CAST(@CURRENTADDRID AS VARCHAR(10)) + ' was created'
		END
		ELSE
		BEGIN
			SELECT @CURRENTADDRID = @@IDENTITY
			SELECT @AddrResult = 'An error occured while attempting to update ' + CASE @pvADDRTYPE WHEN 1 THEN ' Residential ' WHEN 2 THEN ' Mailing 'END + 'address ' 

		END

	END -- insert
END -- execute sp


	 
	 
	 
	 







GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.spf_IMPORT_ALL_CheckRecordCounts    Script Date: 1/11/2008 10:59:12 AM ******/

/****** Object:  Stored Procedure dbo.spf_IMPORT_ALL_CheckRecordCounts    Script Date: 8/11/2006 10:57:45 AM ******/





CREATE PROCEDURE spf_IMPORT_ALL_CheckRecordCounts AS
/*

	Desigened AND Developed 01/2003

	Legal Information...
	 ©1996-2003 Statline, LLC. All rights reserved. 

	 Statline is a registered trademark of Statline, LLC in the U.S.A. 


	 7555 East Hampden Avenue, Ste. 104, 
	 Denver, CO 80231. 
	 1-888-881-7828. 
*/
-- check the record counts -- compare file counts to what was imported
 SET NOCOUNT ON
 DECLARE @ErrorMessage VARCHAR(250)
 UPDATE IMPORT_D 
 SET TableCount = (SELECT COUNT(*) FROM IMPORT_A)
 WHERE ImportFile = 'a'
 UPDATE IMPORT_D 
 SET TableCount = (SELECT COUNT(*) FROM IMPORT_B)
 WHERE ImportFile = 'b'
 UPDATE IMPORT_D 
 SET TableCount = (SELECT COUNT(*) FROM IMPORT_C)
 WHERE  ImportFile = 'c'
 SELECT @ErrorMessage = COUNT(*) FROM IMPORT_D WHERE (ImportFileSize -  TableCount) <> 0
 IF (@ErrorMessage > 0)
 BEGIN
  SET @ErrorMessage = @ErrorMessage + ' table counts and the values in donor-d.txt file are not equal.'
  RAISERROR (@ErrorMessage,11,1)with LOG
  RETURN 1
 END
 
 RETURN 0
-- end check the record counts -- compare file counts to what was imported







GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.spi_IMPORT_ImportApply_A    Script Date: 1/11/2008 10:59:12 AM ******/

/****** Object:  Stored Procedure dbo.spi_IMPORT_ImportApply_A    Script Date: 8/11/2006 10:57:45 AM ******/





--SP_HELPTEXT Import_ImportApply_A
--SP_HELPTEXT Import_ImportApply_B
--SP_HELPTEXT Import_ImportApply_C
CREATE PROCEDURE spi_IMPORT_ImportApply_A AS
/*

	Desigened AND Developed 01/2003

	Legal Information...
	 ©1996-2003 Statline, LLC. All rights reserved. 

	 Statline is a registered trademark of Statline, LLC in the U.S.A. 


	 7555 East Hampden Avenue, Ste. 104, 
	 Denver, CO 80231. 
	 1-888-881-7828. 
*/
update IMPORT
set DECEASEDDATE = a.DECEASEDDATE,
    CSORSTATE    = a.CSORSTATE,
    CSORLICENSE  = a.CSORLICENSE
from IMPORT i, IMPORT_A a
where i.LICENSE = a.LICENSE
insert IMPORT(IMPORTLOGID, LAST, FIRST, MIDDLE, SUFFIX, AADDR1, ACITY, ASTATE, AZIP, BADDR1, BCITY, BSTATE, BZIP, DOB, GENDER, LICENSE, DONOR, RENEWALDATE, DECEASEDDATE, CSORSTATE, CSORLICENSE)
select        IMPORTLOGID, LAST, FIRST, MIDDLE, SUFFIX, AADDR1, ACITY, ASTATE, AZIP, BADDR1, BCITY, BSTATE, BZIP, DOB, GENDER, LICENSE, DONOR, RENEWALDATE, DECEASEDDATE, CSORSTATE, CSORLICENSE
from IMPORT_A
where LICENSE NOT IN (select LICENSE
                      from IMPORT)







GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.spi_IMPORT_ImportApply_B    Script Date: 1/11/2008 10:59:12 AM ******/

/****** Object:  Stored Procedure dbo.spi_IMPORT_ImportApply_B    Script Date: 8/11/2006 10:57:45 AM ******/





CREATE PROCEDURE spi_IMPORT_ImportApply_B AS
/*

	Desigened AND Developed 01/2003

	Legal Information...
	 ©1996-2003 Statline, LLC. All rights reserved. 

	 Statline is a registered trademark of Statline, LLC in the U.S.A. 


	 7555 East Hampden Avenue, Ste. 104, 
	 Denver, CO 80231. 
	 1-888-881-7828. 
*/
update IMPORT
set LAST = b.LAST,
    FIRST  = b.FIRST,
    MIDDLE = b.MIDDLE,
    SUFFIX  = b.SUFFIX
from IMPORT i, IMPORT_B b
where i.LICENSE = b.LICENSE
insert IMPORT(IMPORTLOGID, LICENSE, LAST, FIRST, MIDDLE, SUFFIX, DOB)
select        IMPORTLOGID, LICENSE, LAST, FIRST, MIDDLE, SUFFIX, DOB
from IMPORT_B
where LICENSE NOT IN (select LICENSE
                      from IMPORT)







GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.spi_IMPORT_ImportApply_C    Script Date: 1/11/2008 10:59:12 AM ******/

/****** Object:  Stored Procedure dbo.spi_IMPORT_ImportApply_C    Script Date: 8/11/2006 10:57:45 AM ******/





CREATE PROCEDURE spi_IMPORT_ImportApply_C AS
/*

	Desigened AND Developed 01/2003

	Legal Information...
	 ©1996-2003 Statline, LLC. All rights reserved. 

	 Statline is a registered trademark of Statline, LLC in the U.S.A. 


	 7555 East Hampden Avenue, Ste. 104, 
	 Denver, CO 80231. 
	 1-888-881-7828. 
*/
update IMPORT
set AADDR1 = c.AADDR1,
    ACITY  = c.ACITY,
    ASTATE = c.ASTATE,
    AZIP   = c.AZIP,
    BADDR1 = c.BADDR1,
    BCITY  = c.BCITY,
    BSTATE = c.BSTATE,
    BZIP   = c.BZIP
from IMPORT i, IMPORT_C c
where i.LICENSE = c.LICENSE
insert IMPORT(IMPORTLOGID, LICENSE, AADDR1, ACITY, ASTATE, AZIP, BADDR1, BCITY, BSTATE, BZIP)
select        IMPORTLOGID, LICENSE, AADDR1, ACITY, ASTATE, AZIP, BADDR1, BCITY, BSTATE, BZIP
from IMPORT_C
where LICENSE NOT IN (select LICENSE
                      from IMPORT)







GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.spi_IMPORT_ImportInitialize    Script Date: 1/11/2008 10:59:12 AM ******/

/****** Object:  Stored Procedure dbo.spi_IMPORT_ImportInitialize    Script Date: 8/11/2006 10:57:45 AM ******/





CREATE PROCEDURE spi_IMPORT_ImportInitialize AS
/*

	Desigened AND Developed 01/2003

	Legal Information...
	 ©1996-2003 Statline, LLC. All rights reserved. 

	 Statline is a registered trademark of Statline, LLC in the U.S.A. 


	 7555 East Hampden Avenue, Ste. 104, 
	 Denver, CO 80231. 
	 1-888-881-7828. 
*/
insert IMPORTLOG(RecordsTotal) values(0)
return @@IDENTITY







GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

/****** Object:  Stored Procedure dbo.spi_Import_Adds    Script Date: 1/11/2008 10:59:13 AM ******/

/****** Object:  Stored Procedure dbo.spi_Import_Adds    Script Date: 8/11/2006 10:57:45 AM ******/

CREATE PROCEDURE spi_Import_Adds
AS

DECLARE @ID       int, 
        @IDENTITY int, 
        @v        varchar(255)

DECLARE @IMPORTLOGID int,
        @Addr1       varchar(255), 
        @Addr2       varchar(255),
        @City        varchar(255), 
        @State       varchar(255), 
        @Zip         varchar(255),
        @Donor       varchar(255),
        @DonorTF     bit,
        @matchCount Integer

SELECT @IMPORTLOGID = ID
	FROM ImportLog
	WHERE Upper(RunStatus) = 'LOADING';

DECLARE cIMPORT CURSOR FOR 
	SELECT Import_Adds.ID
		FROM Import_Adds
OPEN cIMPORT

FETCH NEXT FROM cIMPORT INTO @id 

WHILE @@fetch_status = 0
      BEGIN
	BEGIN TRANSACTION IMPORT

 	SELECT @v = Convert(varchar(255),@ID)
	PRINT  @v
	SELECT @DonorTF = CASE Upper(DONOR)
			WHEN 'Y' THEN 1
                      		ELSE 0
                      		END
    		FROM Import_Adds
		WHERE Import_Adds.ID = @ID; 

	-- Check for existing DMV records with a matching License number
	SET @matchCount = (SELECT Count(*) FROM DMV WHERE DMV.License = (SELECT License FROM Import_Deletes WHERE Import_Deletes.ID = @ID)); 

	IF @matchCount > 0 
	     BEGIN
		-- Matching existing records found, set the donor value to 1, and update any other information
		UPDATE DMV SET
			IMPORTLOGID = @IMPORTLOGID,
			DOB = CASE ISDATE(Import_Deletes.DOB) WHEN 0 THEN NULL ELSE CONVERT(datetime,Import_Deletes.DOB) END,                 
			FirstName = Import_Deletes.First,
			MiddleName = Import_Deletes.Middle,
			LastName = Import_Deletes.Last,
			Suffix = Import_Deletes.Suffix,
			Gender = Import_Deletes.Gender,
			Donor = 1, -- Force Donor status YES
			LastModified = GetDate()
			FROM DMV
			JOIN Import_Deletes
			ON DMV.License = Import_Deletes.License
			WHERE Import_Deletes.ID = @id

		-- Delete any existing address records for found deletes
		DELETE FROM DMVAddr 
			WHERE DmvId IN
			(SELECT DMV.[ID] 
				FROM DMV JOIN Import_Deletes 
				ON DMV.License = Import_Deletes.License 
				WHERE Import_Deletes.[ID] = @id)

		-- Set @Identity variable to allow for insertion of new addresses below
		SET @IDENTITY = (SELECT TOP 1DMV.[ID] 
				FROM DMV JOIN Import_Deletes 
				ON DMV.License = Import_Deletes.License 
				WHERE Import_Deletes.[ID] = @id)

	     END

	ELSE
	     BEGIN
		-- Insert basic info into DMV record from Import_Adds
		INSERT DMV ( IMPORTLOGID, SSN,  License, DOB, FirstName, MiddleName, LastName, Suffix, Gender, Donor, RenewalDate, DeceasedDate, CSORState, CSORLicense, CreateDate)
    			SELECT @IMPORTLOGID, NULL, LICENSE, 
				CASE ISDATE(DOB)
	                                       		WHEN 0 THEN NULL
             	                           		ELSE CONVERT(datetime,DOB)
             	                           		END,                 
				FIRST,  MIDDLE,  LAST, SUFFIX, GENDER, 1,   -- Force donor status YES
				CASE ISDATE(RENEWALDATE)
					WHEN 0 THEN NULL
					ELSE CONVERT(datetime,RENEWALDATE)
					END,                         
				CASE ISDATE(DECEASEDDATE)
					WHEN 0 THEN NULL
					ELSE CONVERT(datetime,DECEASEDDATE)
					END,                               
				CSORSTATE, CSORLICENSE, ISNULL(CREATEDATE,GETDATE())
				FROM Import_Adds
				WHERE Import_Adds.ID = @ID;

		-- Get Identity of record just inserted
    		SELECT @IDENTITY = @@IDENTITY;
	     END

	-- Get the main address variables
	SELECT @Addr1     = ltrim(rtrim(AADDR1)),
           		@Addr2     = NULL, 
          		@City      = ltrim(rtrim(ACITY)),  
           		@State     = ltrim(rtrim(ASTATE)),  
           		@Zip       = ltrim(rtrim(AZIP))
    		FROM Import_Adds
    		WHERE Import_Adds.ID = @ID;   

	-- Insert them as Type 1 address into DMVAddr table
    	IF Isnull(@Addr1,'') + isnull(@Addr2,'') + isnull(@City,'') + isnull(@State,'') + isnull(@Zip,'') <> ''
    	INSERT DMVADDR (DMVID,      ADDRTYPEID, Addr1,  Addr2, City,  State,  Zip)
    		SELECT @IDENTITY,  1, AADDR1, NULL,  ACITY, ASTATE, AZIP
    			FROM Import_Adds
    			WHERE Import_Adds.ID = @ID;   

	-- Get the mailing address variables
    	SELECT @Addr1     = ltrim(rtrim(BADDR1)),
           		@Addr2     = NULL, 
          		@City      = ltrim(rtrim(BCITY)),  
           		@State     = ltrim(rtrim(BSTATE)),  
           		@Zip       = ltrim(rtrim(BZIP))
    		FROM Import_Adds
    		WHERE Import_Adds.ID = @ID;   

	-- Insert them as Type 2 address into DMVAddr table
    	IF isnull(@Addr1,'') + isnull(@Addr2,'') + isnull(@City,'') + isnull(@State,'') + isnull(@Zip,'') <> ''
    	INSERT DMVADDR (DMVID,      ADDRTYPEID, Addr1,  Addr2, City,  State,  Zip)
    		SELECT  @IDENTITY,  2,  BADDR1, NULL,  BCITY, BSTATE, BZIP
			FROM Import_Adds
    			WHERE Import_Adds.ID = @ID;   


	-- Commented out DMVOrgan filling table.  Not currently needed 1/25/05 - SAP
/*    	SELECT @Donor = ltrim(rtrim(DONOR))
    		FROM Import_Adds
    		WHERE Import_Adds.ID = @ID;   
	IF isnull(@Donor,'') <> ''
    	INSERT DMVORGAN (DMVID, ORGANTYPEID)
    		SELECT  @IDENTITY, 
			CASE ltrim(rtrim(DONOR))
		                  	WHEN 'Y' THEN 1                   
				ELSE 0
                                		END
			FROM Import_Adds
    			WHERE Import_Adds.ID = @ID;   */

	COMMIT TRANSACTION IMPORT;

    	CHECKPOINT -- bjk 07/01/03 add checkpoint

	FETCH NEXT FROM cIMPORT INTO @id
     END

CLOSE cIMPORT
DEALLOCATE cIMPORT
;


GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.spi_QueryLog    Script Date: 1/11/2008 10:59:13 AM ******/

/****** Object:  Stored Procedure dbo.spi_QueryLog    Script Date: 8/11/2006 10:57:45 AM ******/


CREATE PROCEDURE spi_QueryLog

	@vDateTime	smalldatetime	= getDate,
	@vNumber	int		= 0,
	@vComputer	varchar(50) 	= null,
	@vSource	varchar(50) 	= null,
	@vLocation	varchar(100) 	= null,
	@vDescription	varchar(8000) 	= null

AS
	INSERT 	QueryLog (
		QueryLogDateTime,
		QueryLogNumber,
		QueryLogComputer,
		QueryLogSource,
		QueryLogLocation,
		QueryLogDescription)
	
	VALUES 	(
		@vDateTime,
		@vNumber,
		@vComputer,
		@vSource,
		@vLocation,
		@vDescription)



GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.spi_Registry_Archive_Removed    Script Date: 1/11/2008 10:59:13 AM ******/

/****** Object:  Stored Procedure dbo.spi_Registry_Archive_Removed    Script Date: 8/11/2006 10:57:45 AM ******/




CREATE PROCEDURE spi_Registry_Archive_Removed
	@RegistryID	INT = NULL,
	@ArchiveReason 	INT = 5
AS
/*

	Desigened AND Developed 01/2003

	Legal Information...
	 ©1996-2003 Statline, LLC. All rights reserved. 

	 Statline is a registered trademark of Statline, LLC in the U.S.A. 


	 7555 East Hampden Avenue, Ste. 104, 
	 Denver, CO 80231. 
	 1-888-881-7828. 
*/ 
 
 begin transaction ARCHIVE
 	-- REGISTRYARCHIVE


	insert REGISTRYARCHIVE
	select [ID], [SSN], [DOB], [FirstName], [MiddleName], [LastName], [Suffix], [Gender], [Race], [EyeColor], [Phone], [Comment], [DMVID], [License], [DMVDonor], [Donor], [DonorConfirmed], [SourceCode], [OnlineRegDate], [SignatureDate], [MailerDate], [DeleteFlag], [DeleteDate], [DeletedByID], [UserID], [LastModified], [CreateDate], [DeceasedDate], @ArchiveReason 
	from REGISTRY
	where REGISTRY.ID = @RegistryID

	-- REGISTRYARCHIVEADDR
	insert REGISTRYARCHIVEADDR
	select REGISTRY.[ID], [RegistryID], [AddrTypeID], [Addr1], [Addr2], [City], [State], [Zip], REGISTRY.[UserID], REGISTRY.[LastModified], REGISTRY.[CreateDate]
	from REGISTRY, REGISTRYADDR
	where REGISTRY.ID = REGISTRYADDR.REGISTRYID
	and   REGISTRY.ID = @RegistryID

	/*
	-- REGISTRYARCHIVEORGAN
	insert REGISTRYARCHIVEORGAN
	select REGISTRYORGAN.* from REGISTRY, REGISTRYORGAN
	where REGISTRY.ID = REGISTRYORGAN.REGISTRYID
	and   REGISTRY.ID = @RegistryID

	-- REGISTRYARCHIVEGIFT
	insert REGISTRYARCHIVEGIFT
	select REGISTRYGIFT.* from REGISTRY, REGISTRYGIFT
	where REGISTRY.ID = REGISTRYGIFT.REGISTRYID
	and   REGISTRY.ID = @RegistryID

	-- REGISTRYGIFT
	delete from REGISTRYGIFT
	from REGISTRY, REGISTRYGIFT
	where REGISTRY.ID = REGISTRYGIFT.REGISTRYID
	and   REGISTRY.ID = @RegistryID

	-- REGISTRYORGAN
	delete from REGISTRYORGAN
	from REGISTRY, REGISTRYORGAN
	where REGISTRY.ID = REGISTRYORGAN.REGISTRYID
	and   REGISTRY.ID = @RegistryID
	*/
	-- REGISTRYADDR
	delete from REGISTRYADDR
	from REGISTRY, REGISTRYADDR
	where REGISTRY.ID = REGISTRYADDR.REGISTRYID
	and   REGISTRY.ID = @RegistryID
	
	-- REGISTRY
	delete from REGISTRY
	from REGISTRY
	where REGISTRY.ID = @RegistryID
 commit transaction ARCHIVE
CHECKPOINT
-- SELECT * FROM REGISTRYARCHIVETYPE















GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.spi_WebUser    Script Date: 1/11/2008 10:59:13 AM ******/

/****** Object:  Stored Procedure dbo.spi_WebUser    Script Date: 8/11/2006 10:57:45 AM ******/




CREATE PROCEDURE spi_WebUser
		@vEmail 		varchar(500)	= null,
		@vPwd			varchar(50)	= null

AS

If @vEmail IS NOT NULL AND @vPwd IS NOT NULL
BEGIN
	IF NOT EXISTS(SELECT email FROM webuser WHERE email=@vEmail)
	BEGIN
		INSERT INTO WebUser
		Select @vEmail, @vPwd, 0, 0
	END
	ELSE
	PRINT 'EMAIL EXISTS'
	SELECT 0,0,0,0
END




















GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.sps_AccessType    Script Date: 1/11/2008 10:59:13 AM ******/

/****** Object:  Stored Procedure dbo.sps_AccessType    Script Date: 8/11/2006 10:57:45 AM ******/


CREATE PROCEDURE sps_AccessType
		@Access 		varchar(500)	= null

AS

If @Access IS NOT NULL
BEGIN
	SELECT * FROM accesstype 
	WHERE access=@Access
	AND AccessName IS NOT NULL
END
ELSE
BEGIN
	SELECT * FROM accesstype 
	WHERE AccessName IS NOT NULL
END





GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.sps_Access_BW    Script Date: 1/11/2008 10:59:13 AM ******/

/****** Object:  Stored Procedure dbo.sps_Access_BW    Script Date: 8/11/2006 10:57:45 AM ******/




CREATE PROCEDURE sps_Access_BW
		@WebUserID 		INT	= 0
AS

If @WebUserID <> 0
BEGIN
	SELECT Accesstype.Access, AccessName, AccessDescription
	FROM Accesstype, Webuser
	WHERE WebUserID= @WebUserID
	AND Accesstype.Access & WebUser.Access <> 0
END













GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.sps_CheckRegistry    Script Date: 1/11/2008 10:59:13 AM ******/

/****** Object:  Stored Procedure dbo.sps_CheckRegistry    Script Date: 8/11/2006 10:57:44 AM ******/









CREATE Procedure sps_CheckRegistry
	@DOB   		DATETIME    	= NULL,
	@LastName	VARCHAR(25) 	= NULL,
	@FirstName 	VARCHAR(25) 	= NULL,
	@NADD 		INT	       	= NULL, -- NADD = No Additional Donor Data	
	@MiddleName 	VARCHAR(25) 	= NULL,
	@SSN   		VARCHAR(11) 	= NULL,
	@LICENSE 	VARCHAR(15) 	= NULL,
	@StreetAddress 	VARCHAR(45) 	= NULL,
	@City 		VARCHAR(25) 	= NULL,
	@State 		VARCHAR(2) 	= NULL,
	@Zip 		VARCHAR(10) 	= NULL
AS

SET NOCOUNT ON
/*

Desigened AND Developed 01/2003

Legal Information...
 ©1996-2003 Statline, LLC. All rights reserved. 

 Statline is a registered trademark of Statline, LLC in the U.S.A. 


 7555 East Hampden Avenue, Ste. 104, 
 Denver, CO 80231. 
 1-888-881-7828. 

Paramameters
	First - Donors First Name
	Last  - Donors Last Name
	DOB   - Donor Date of Birth
	SSN   - Social Security Number	

-- SP_HELP DMV
*/
	-- DECLARE VARIABLES
	DECLARE @RegistryID INT,
		@RegistryDonor BIT,
		@RegistryDate SMALLDATETIME,
		@DMVID INT,
		@DMVDonor BIT,
		@DMVDate SMALLDATETIME,
		@RestrictionID INT,		
		@REGRecordsReturned INT,		
		@DMVRecordsReturned INT
	-- initialize @RestrictionID
	SELECT @RestrictionID  = 0 

	-- get values for registry 
	EXEC sps_CheckRegistry_REG
		@DOB, 
		@LastName, 
		@FirstName, 
		@MiddleName, 
		@SSN, 
		@LICENSE, 
		@StreetAddress,
		@City,
		@State,
		@Zip,
		NULL,			-- This is the suspense variable see Note:			
		@RegistryID OUTPUT,
		@RegistryDonor OUTPUT,
		@RegistryDate OUTPUT,
		@REGRecordsReturned OUTPUT
/*
   Suspense Variable Note:
   NULL returns both registry (non-suspense) and suspense records
   1	returns registry  (non-suspense) records
   0	returns suspense records

*/
	
-- check for multiple records from registry 
-- IF MORE THAN 1 RECORD WAS RETURNED ASK FOR ADDITIONAL INFORMATION
	IF 	@REGRecordsReturned > 1 
		AND
		(ISNULL(@MiddleName, '') +  
		 ISNULL(@SSN, '') +
		 ISNULL(@LICENSE, '') +
		 ISNULL(@StreetAddress, '') +
		 ISNULL(@City, '') +
		 ISNULL(@State, '') +
		 ISNULL(@Zip, '') = '' 
		)
		BEGIN
			SELECT
			'Registration Undetermined' AS 'Source',
			0 AS 'ID',
			'U' AS 'Donor' , -- U is undetermined
			'1/1/1900' AS 'Date',
			0 AS 'RestrictionID'
		
			RETURN
		END
	ELSE IF @REGRecordsReturned > 1 
		AND
		(
		 ISNULL(@NADD,1) = 1
		OR -- BJK 05/27/03 
		 ISNULL(@MiddleName, '') +  
		 ISNULL(@SSN, '') +
		 ISNULL(@LICENSE, '') +
		 ISNULL(@StreetAddress, '') +
		 ISNULL(@City, '') +
		 ISNULL(@State, '') +
		 ISNULL(@Zip, '') <> '' 
		)
		BEGIN
			SELECT
			'Registration Undetermined' AS 'Source',
			0 AS 'ID',
			'N' AS 'Donor' , -- U is undetermined
			'1/1/1900' AS 'Date',
			0 AS 'RestrictionID'
		
			RETURN		
		END
	
	EXEC sps_CheckRegistry_DMV	
		@DOB, 
		@LastName, 
		@FirstName, 
		@MiddleName, 
		@SSN, 
		@LICENSE, 
		@StreetAddress,
		@City,
		@State,
		@Zip,
		@DMVID OUTPUT,
		@DMVDonor OUTPUT,
		@DMVDate OUTPUT,
		@DMVRecordsReturned OUTPUT
	
	-- check for multiple records from dmv 
	-- IF MORE THAN 1 RECORD WAS RETURNED ASK FOR ADDITIONAL INFORMATION
	IF 	@DMVRecordsReturned > 1 
		AND
		(
		 ISNULL(@MiddleName, '') +  
		 ISNULL(@SSN, '') +
		 ISNULL(@LICENSE, '') +
		 ISNULL(@StreetAddress, '') +
		 ISNULL(@City, '') +
		 ISNULL(@State, '') +
		 ISNULL(@Zip, '') = ''		 
		)
	BEGIN
		SELECT
		'Registration Undetermined' AS 'Source',
		0 AS 'ID',
		'U' AS 'Donor' , -- U is undetermined
		'1/1/1900' AS 'Date',
		0 AS 'RestrictionID'
		
		RETURN
	END
	ELSE IF @DMVRecordsReturned > 1 
		AND
		(
		 ISNULL(@NADD,1) = 1
		OR -- BJK 05/23/03 
		 ISNULL(@MiddleName, '') +  
		 ISNULL(@SSN, '') +
		 ISNULL(@LICENSE, '') +
		 ISNULL(@StreetAddress, '') +
		 ISNULL(@City, '') +
		 ISNULL(@State, '') +
		 ISNULL(@Zip, '') <> '' 		
		)
		BEGIN
			SELECT
			'Registration Undetermined' AS 'Source',
			0 AS 'ID',
			'N' AS 'Donor' , -- U is undetermined
			'1/1/1900' AS 'Date',
			0 AS 'RestrictionID'
		
			RETURN		
		END
		

	/*

		SELECT  D.ID ,
			D.Donor ,
			CASE WHEN D.RENEWALDATE IS NULL THEN 
					CASE WHEN D.CREATEDATE IS NULL THEN '07/01/01' ELSE D.CREATEDATE END
			     ELSE D.RENEWALDATE END
		FROM DMV D
		WHERE LastName           = 'knoll'
		AND   FirstName          = 'bret'
		AND   DOB		  = '11/17/1970'

	*/

	--PRINT @DMVDonor
	--PRINT @RegistryDonor 
	--PRINT @OnlineDonor 

	-- if all the values are null return a blank record set
	IF (ISNULL(@DMVID, '') + ISNULL(@RegistryID, '') = '' )
	
		-- no values were found
		-- return empty record st
		BEGIN
			SELECT
				'No Registration' AS 'Source',
				0 AS 'ID',
				'N' AS 'Donor' ,
				'1/1/1900' AS 'Date',
				0 AS 'RestrictionID'
				
				RETURN

		END

	
	-- check for the Oldest Date
	ELSE
		BEGIN
			IF	(ISNULL(@RegistryDate,'1/1/1900') > ISNULL(@DMVDate,'1/1/1900') )

				--Return Registry
				BEGIN
					SELECT
						'Registry' AS 'Source',
						@RegistryID AS 'ID',
						CASE @RegistryDonor WHEN 1 THEN 'Y' ELSE 'N' END AS 'Donor' ,
						@RegistryDate AS 'Date'	,
						@RestrictionID -- ADD CASE STATMENT FOR REGISTRY ID TO RETURN
						AS 'RestrictionID'
					RETURN				
				END		
			-- check if dmv is the latest date	
			ELSE IF (ISNULL(@DMVDate,'1/1/1900') > ISNULL(@RegistryDate,'1/1/1900'))
				-- Return DMV
				BEGIN
					SELECT
						'DMV' AS 'Source',
						@DMVID AS 'ID',
						CASE @DMVDonor WHEN 1 THEN 'Y' ELSE 'N' END AS 'Donor' ,
						@DMVDate AS 'Date',
						CASE @RegistryDonor When 1 Then @RegistryID Else 0 End AS 'RestrictionID' 
					RETURN
				END
			-- check if all the values are not = N for No
			-- Both registry and dmv dates are equal, check that both = Y
			ELSE IF ( ISNULL( @DMVDonor, 1 ) <> 0 AND ISNULL( @RegistryDonor, 1 ) <> 0 )
				BEGIN
					-- if registry is not null return registry
					IF (@RegistryID IS NOT NULL)
						BEGIN
							SELECT
								'Registry' AS 'Source',
								@RegistryID AS 'ID',
								CASE @RegistryDonor WHEN 1 THEN 'Y' ELSE 'N' END AS 'Donor' ,
								@RegistryDate AS 'Date'	,
								@RestrictionID -- ADD CASE STATMENT FOR REGISTRY ID TO RETURN
								AS 'RestrictionID'
							RETURN								
						END
					ELSE 
						BEGIN 
							SELECT
								'DMV' AS 'Source',
								@DMVID AS 'ID',
								CASE @DMVDonor WHEN 1 THEN 'Y' ELSE 'N' END AS 'Donor' ,
								@DMVDate AS 'Date',
								CASE @RegistryDonor When 1 Then @RegistryID Else 0 End AS 'RestrictionID' 
							RETURN
						
						END
				
				END
			ELSE 	-- a result cannot be determined			
				-- return empty record st
				BEGIN
					SELECT
						'Undetermined Registration' AS 'Source',
						0 AS 'ID',
						'N' AS 'Donor' ,
						'1/1/1900' AS 'Date',
						@RestrictionID AS 'RestrictionID'

						RETURN
				END			
		END




/* Query Sample
SELECT * 
FROM DMV
WHERE (LastName           LIKE 'Knoll'   or ISNULL('Knoll',   '')='')
AND   (FirstName          LIKE 'Bret'  or ISNULL('Bret',  '')='')
AND   (MiddleName         LIKE 'James' or ISNULL('JAMES', '')='')
AND   (License            LIKE '921243832'    or ISNULL('921243832',    '')='')
AND   (DOB		  LIKE '1970-11-17'	   OR ISNULL('1970-11-17', 	  '')='')
AND   (SSN	          LIKE '521471351' 	   OR ISNULL('521471351',	  '')='')

*/
-- SELECT COUNT(DONOR) FROM DMV WHERE DONOR = 1















GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.sps_DonorRegistryByGenderAgeAndDonorStatus    Script Date: 1/11/2008 10:59:13 AM ******/

/****** Object:  Stored Procedure dbo.sps_DonorRegistryByGenderAgeAndDonorStatus    Script Date: 8/11/2006 10:57:45 AM ******/

/*

This report builds on the CO Registry Count (All) report and breaks down
the counts further by Ys and Ns.
2.	Number of Y's and N's entered. (group by Y and Ns)
a.	 Name: CO Registry Count (Y or N)
Report Date	Date Range	Number of Ys	Number of Ns	Gender	Age



1.	Number of enrollees by website and outreach (summary)
2.	Report Date at top
3.	Date Range
4.	Web Online counts
5.	Donor counts
6.	group by gender, age (0-17, 18-21, 22-29, 30-39,….60-69, 70+)
	
group by gender, age (0-17, 18-21, 22-29, 30-39,….60-69, 70+)
	
Report Date	Date Range	Website	Outreach	Gender	Age


get a count of online and donor registrants between signature date range

group by gender and age . Age should fit into a category of 0-17, 18-21, 22-29, 30-39,40-49, 50-59, 60-69 and 70 or greater.
The age is obtained by subtracting Todays date from birthdate in years.

SP_HELP Registry 
signaturedate
Registry

*/
-- sp_helptext sps_DonorRegistryByGenderAndAge
-- sps_DonorRegistryByGenderAgeAndDonorStatus '5/1/01', '9/20/02'
-- sps_DonorRegistryByGenderAgeAndDonorStatus '01/01/03 00:00', '02/24/03 00:00'

-- name stored procedure
-- drop PROCEDURE sps_DonorRegistryByGenderAgeAndDonorStatus GO
CREATE PROCEDURE sps_DonorRegistryByGenderAgeAndDonorStatus

	@StartDate	SMALLDATETIME,
	@EndDate	SMALLDATETIME


AS
/*
	Desigened AND Developed 01/2003

	Legal Information...
	 ©1996-2003 Statline, LLC. All rights reserved. 

	 Statline is a registered trademark of Statline, LLC in the U.S.A. 


	 7555 East Hampden Avenue, Ste. 104, 
	 Denver, CO 80231. 
	 1-888-881-7828. 
*/

-- TURN RECORD COUNTS OFF
SET NOCOUNT ON
-- Build temporary holding table
SELECT COUNT(*) AS 'Online', COUNT(*) AS 'Outreach', 'U' AS 'Gender', '          ' AS 'AgeRange', CAST(Donor AS CHAR(1)) AS 'Donor'
INTO #DRCountHoldingTable
FROM Registry
where 0<>0
GROUP BY Gender, CAST(Donor AS CHAR(1)) 

--Start with counts from Registry
INSERT #DRCountHoldingTable (Online, Outreach, Gender, AgeRange, Donor)

SELECT 0,
Count(*) as  'Outrech',
CASE Gender 
	WHEN 'M' THEN 'M'
	WHEN 'F' THEN 'F'
	ELSE 'U'
END AS 'Gender'
, 
CASE 
	WHEN DATEDIFF(YY, DOB, GETDATE()) < 18 THEN '0 - 17'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 18 AND 21 THEN '18 - 21'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 22 AND 29 THEN '22 - 29'	
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 30 AND 39 THEN '30 - 39'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 40 AND 49 THEN '40 - 49'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 50 AND 59 THEN '50 - 59'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 60 AND 69 THEN '60 - 69'
	WHEN DATEDIFF(YY, DOB, GETDATE()) > 69 THEN '70 + '
END AS 'Age Group',
CAST(Donor AS CHAR(1)) as 'Donor'
FROM Registry
WHERE ISNULL(SignatureDate,OnlineRegDate) BETWEEN @StartDate AND @EndDate
GROUP BY 
Gender,
CASE 
	WHEN DATEDIFF(YY, DOB, GETDATE()) < 18 THEN '0 - 17'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 18 AND 21 THEN '18 - 21'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 22 AND 29 THEN '22 - 29'	
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 30 AND 39 THEN '30 - 39'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 40 AND 49 THEN '40 - 49'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 50 AND 59 THEN '50 - 59'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 60 AND 69 THEN '60 - 69'
	WHEN DATEDIFF(YY, DOB, GETDATE()) > 69 THEN '70 + '
END,
CAST(Donor AS CHAR(1))

-- Next query Registry

INSERT #DRCountHoldingTable (Online, Outreach, Gender, AgeRange, Donor)

SELECT Count(*) as  'Online',
0,
CASE Gender 
	WHEN 'M' THEN 'M'
	WHEN 'F' THEN 'F'
	ELSE 'U'
END AS 'Gender'
, 
CASE 
	WHEN DATEDIFF(YY, DOB, GETDATE()) < 18 THEN '0 - 17'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 18 AND 21 THEN '18 - 21'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 22 AND 29 THEN '22 - 29'	
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 30 AND 39 THEN '30 - 39'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 40 AND 49 THEN '40 - 49'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 50 AND 59 THEN '50 - 59'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 60 AND 69 THEN '60 - 69'
	WHEN DATEDIFF(YY, DOB, GETDATE()) > 69 THEN '70 + '
END AS 'Age Group',
CAST(Donor AS CHAR(1)) as 'Donor'
FROM Registry
WHERE ISNULL(SignatureDate,OnlineRegDate)  BETWEEN @StartDate AND @EndDate
GROUP BY 
Gender,
CASE 
	WHEN DATEDIFF(YY, DOB, GETDATE()) < 18 THEN '0 - 17'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 18 AND 21 THEN '18 - 21'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 22 AND 29 THEN '22 - 29'	
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 30 AND 39 THEN '30 - 39'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 40 AND 49 THEN '40 - 49'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 50 AND 59 THEN '50 - 59'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 60 AND 69 THEN '60 - 69'
	WHEN DATEDIFF(YY, DOB, GETDATE()) > 69 THEN '70 + '
END,
CAST(Donor AS CHAR(1)) 

-- select from temporary table 
SELECT SUM(Online) AS 'OnLine', SUM(Outreach) AS 'Outreach', Gender, AgeRange, CASE Donor WHEN '1' THEN 'Y' WHEN '0' THEN 'N' ELSE 'U' END AS 'Donor'
FROM #DRCountHoldingTable

GROUP BY Donor , Gender, AgeRange 
ORDER BY AgeRange, Gender, Donor

DROP TABLE #DRCountHoldingTable


GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

/****** Object:  Stored Procedure dbo.sps_DonorRegistryByGenderAgeAndDonorStatus2    Script Date: 1/11/2008 10:59:13 AM ******/

/****** Object:  Stored Procedure dbo.sps_DonorRegistryByGenderAgeAndDonorStatus2    Script Date: 8/11/2006 10:57:45 AM ******/

CREATE PROCEDURE sps_DonorRegistryByGenderAgeAndDonorStatus2

	@StartDate	SMALLDATETIME,
	@EndDate	SMALLDATETIME


AS
/*
	Desigened AND Developed 01/2003

	Legal Information...
	 ©1996-2003 Statline, LLC. All rights reserved. 

	 Statline is a registered trademark of Statline, LLC in the U.S.A. 


	 7555 East Hampden Avenue, Ste. 104, 
	 Denver, CO 80231. 
	 1-888-881-7828. 
*/

-- TURN RECORD COUNTS OFF
SET NOCOUNT ON
-- Build temporary holding table
SELECT COUNT(*) AS 'Online', COUNT(*) AS 'Outreach', 'U' AS 'Gender', '          ' AS 'AgeRange', CAST(Donor AS CHAR(1)) AS 'Donor'
INTO #DRCountHoldingTable
FROM Registry
where 0<>0
GROUP BY Gender, CAST(Donor AS CHAR(1)) 

--Start with counts from Registry
INSERT #DRCountHoldingTable (Online, Outreach, Gender, AgeRange, Donor)

SELECT 0,
Count(*) as  'Outrech',
CASE Gender 
	WHEN 'M' THEN 'M'
	WHEN 'F' THEN 'F'
	ELSE 'U'
END AS 'Gender'
, 
CASE 
	WHEN DATEDIFF(YY, DOB, GETDATE()) < 18 THEN '0 - 17'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 18 AND 21 THEN '18 - 21'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 22 AND 29 THEN '22 - 29'	
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 30 AND 39 THEN '30 - 39'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 40 AND 49 THEN '40 - 49'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 50 AND 59 THEN '50 - 59'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 60 AND 69 THEN '60 - 69'
	WHEN DATEDIFF(YY, DOB, GETDATE()) > 69 THEN '70 + '
END AS 'Age Group',
CAST(Donor AS CHAR(1)) as 'Donor'
FROM Registry
WHERE ISNULL(SignatureDate,CreateDate)  BETWEEN @StartDate AND @EndDate AND ISNULL(SourceCode, '') <> ''
GROUP BY 
Gender,
CASE 
	WHEN DATEDIFF(YY, DOB, GETDATE()) < 18 THEN '0 - 17'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 18 AND 21 THEN '18 - 21'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 22 AND 29 THEN '22 - 29'	
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 30 AND 39 THEN '30 - 39'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 40 AND 49 THEN '40 - 49'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 50 AND 59 THEN '50 - 59'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 60 AND 69 THEN '60 - 69'
	WHEN DATEDIFF(YY, DOB, GETDATE()) > 69 THEN '70 + '
END,
CAST(Donor AS CHAR(1))

-- Next query Registry

INSERT #DRCountHoldingTable (Online, Outreach, Gender, AgeRange, Donor)

SELECT Count(*) as  'Online',
0,
CASE Gender 
	WHEN 'M' THEN 'M'
	WHEN 'F' THEN 'F'
	ELSE 'U'
END AS 'Gender'
, 
CASE 
	WHEN DATEDIFF(YY, DOB, GETDATE()) < 18 THEN '0 - 17'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 18 AND 21 THEN '18 - 21'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 22 AND 29 THEN '22 - 29'	
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 30 AND 39 THEN '30 - 39'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 40 AND 49 THEN '40 - 49'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 50 AND 59 THEN '50 - 59'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 60 AND 69 THEN '60 - 69'
	WHEN DATEDIFF(YY, DOB, GETDATE()) > 69 THEN '70 + '
END AS 'Age Group',
CAST(Donor AS CHAR(1)) as 'Donor'
FROM Registry
WHERE ISNULL(OnLineRegDate,CreateDate)  BETWEEN @StartDate AND @EndDate AND ISNULL(SourceCode, '') = ''
GROUP BY 
Gender,
CASE 
	WHEN DATEDIFF(YY, DOB, GETDATE()) < 18 THEN '0 - 17'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 18 AND 21 THEN '18 - 21'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 22 AND 29 THEN '22 - 29'	
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 30 AND 39 THEN '30 - 39'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 40 AND 49 THEN '40 - 49'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 50 AND 59 THEN '50 - 59'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 60 AND 69 THEN '60 - 69'
	WHEN DATEDIFF(YY, DOB, GETDATE()) > 69 THEN '70 + '
END,
CAST(Donor AS CHAR(1)) 

-- select from temporary table 
SELECT SUM(Online) AS 'OnLine', SUM(Outreach) AS 'Outreach', Gender, AgeRange, CASE Donor WHEN '1' THEN 'Y' WHEN '0' THEN 'N' ELSE 'U' END AS 'Donor'
FROM #DRCountHoldingTable

GROUP BY Donor , Gender, AgeRange 
ORDER BY AgeRange, Gender, Donor

DROP TABLE #DRCountHoldingTable


GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.sps_DonorRegistryByGenderAgeAndSource    Script Date: 1/11/2008 10:59:13 AM ******/

/****** Object:  Stored Procedure dbo.sps_DonorRegistryByGenderAgeAndSource    Script Date: 8/11/2006 10:57:45 AM ******/





/*

3.	Outreach enrollments by source code
a.	Name CO Registry Count (Source)
Kenn, I have the organization name in an Excel spreadsheet. Can they be imported into the database, or how do you want to handle this?

Report Date	Date Range	Event Source Code	Organization Name	Number 	Gender	Age

1.	Number of enrollees by website and outreach (summary)
2.	Report Date at top
3.	Date Range
4.	Web Online counts
5.	Donor counts
6.	group by gender, age (0-17, 18-21, 22-29, 30-39,….60-69, 70+)
	
group by gender, age (0-17, 18-21, 22-29, 30-39,….60-69, 70+)
	
Report Date	Date Range	Website	Outreach	Gender	Age


get a count of online and donor registrants between signature date range

group by gender and age . Age should fit into a category of 0-17, 18-21, 22-29, 30-39,40-49, 50-59, 60-69 and 70 or greater.
The age is obtained by subtracting Todays date from birthdate in years.

SP_HELP Registry 
signaturedate
Registry
SELECT * FROM Registry WHERE SourceCode IS NULL Order By SourceCode, LastModified
SELECT * FROM Registry WHERE FIRST = 'Bret' AND LAST = 'Knoll' Order By SourceCode, LastModified
delete Registry  where RegistryID = 6905
UPDATE Registry SET SourceCode = "" WHERE SourceCode is null
SELECT COUNT(*) FROM Registry Order By SourceCode
SELECT COUNT(*) FROM Registry

*/
-- sp_helptext sps_DonorRegistryByGenderAndAge
-- sps_DonorRegistryByGenderAgeAndSource '5/1/01', '9/20/02'
-- name stored procedure
-- drop PROCEDURE sps_DonorRegistryByGenderAgeAndSource
CREATE PROCEDURE sps_DonorRegistryByGenderAgeAndSource

	@StartDate	SMALLDATETIME = NULL,
	@EndDate	SMALLDATETIME = NULL,
	@SourceCodeID   VARCHAR(50) =NULL


AS
/*
	Desigened AND Developed 01/2003

	Legal Information...
	 ©1996-2003 Statline, LLC. All rights reserved. 

	 Statline is a registered trademark of Statline, LLC in the U.S.A. 


	 7555 East Hampden Avenue, Ste. 104, 
	 Denver, CO 80231. 
	 1-888-881-7828. 
*/
-- TURN RECORD COUNTS OFF
SET NOCOUNT ON

SELECT 

Count(*) as  'Outreach',
ISNULL(SC.SourceCodeName, 'No Source') AS 'EventName',
CASE Gender 
	WHEN 'M' THEN 'M'
	WHEN 'F' THEN 'F'
	ELSE 'U'
END AS 'Gender'
, 
CASE 
	WHEN DATEDIFF(YY, DOB, GETDATE()) < 18 THEN '0 - 17'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 18 AND 21 THEN '18 - 21'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 22 AND 29 THEN '22 - 29'	
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 30 AND 39 THEN '30 - 39'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 40 AND 49 THEN '40 - 49'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 50 AND 59 THEN '50 - 59'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 60 AND 69 THEN '60 - 69'
	WHEN DATEDIFF(YY, DOB, GETDATE()) > 69 THEN '70 + '
END AS 'AgeRange'

FROM Registry
LEFT JOIN RegistryEventSourceCodes SC ON  SC.SourceCodeID = Registry.SourceCode
WHERE	(SOURCECODE = @SourceCodeID   or isnull(@SourceCodeID,   '')='')
AND	(ISNULL(SignatureDate,OnlineRegDate)  >= @StartDate  OR ISNULL(@StartDate, '')='')
AND	(ISNULL(SignatureDate,OnlineRegDate)  <= @EndDate OR ISNULL(@EndDate, '')='')


GROUP BY 
SC.SourceCodeName ,
Gender,
CASE 
	WHEN DATEDIFF(YY, DOB, GETDATE()) < 18 THEN '0 - 17'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 18 AND 21 THEN '18 - 21'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 22 AND 29 THEN '22 - 29'	
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 30 AND 39 THEN '30 - 39'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 40 AND 49 THEN '40 - 49'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 50 AND 59 THEN '50 - 59'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 60 AND 69 THEN '60 - 69'
	WHEN DATEDIFF(YY, DOB, GETDATE()) > 69 THEN '70 + '
END 
ORDER BY 
SC.SourceCodeName ,

CASE 
	WHEN DATEDIFF(YY, DOB, GETDATE()) < 18 THEN '0 - 17'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 18 AND 21 THEN '18 - 21'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 22 AND 29 THEN '22 - 29'	
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 30 AND 39 THEN '30 - 39'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 40 AND 49 THEN '40 - 49'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 50 AND 59 THEN '50 - 59'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 60 AND 69 THEN '60 - 69'
	WHEN DATEDIFF(YY, DOB, GETDATE()) > 69 THEN '70 + '
END ,
Gender

/*
-- select from temporary table 
SELECT SUM(Online) AS 'OnLine', SUM(Outreach) AS 'Outreach', Gender, AgeRange, SourceCode AS 'EventName'
FROM #DRCountHoldingTable
--ORDER BY GENDER, AgeRange
GROUP BY Donor, Gender, AgeRange 
*/

--DROP TABLE #DRCountHoldingTable 















GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

/****** Object:  Stored Procedure dbo.sps_DonorRegistryByGenderAgeAndSource2    Script Date: 1/11/2008 10:59:13 AM ******/

/****** Object:  Stored Procedure dbo.sps_DonorRegistryByGenderAgeAndSource2    Script Date: 8/11/2006 10:57:45 AM ******/

/*

3.	Outreach enrollments by source code
a.	Name CO Registry Count (Source)
Kenn, I have the organization name in an Excel spreadsheet. Can they be imported into the database, or how do you want to handle this?

Report Date	Date Range	Event Source Code	Organization Name	Number 	Gender	Age

1.	Number of enrollees by website and outreach (summary)
2.	Report Date at top
3.	Date Range
4.	Web Online counts
5.	Donor counts
6.	group by gender, age (0-17, 18-21, 22-29, 30-39,….60-69, 70+)
	
group by gender, age (0-17, 18-21, 22-29, 30-39,….60-69, 70+)
	
Report Date	Date Range	Website	Outreach	Gender	Age


get a count of online and donor registrants between signature date range

group by gender and age . Age should fit into a category of 0-17, 18-21, 22-29, 30-39,40-49, 50-59, 60-69 and 70 or greater.
The age is obtained by subtracting Todays date from birthdate in years.

SP_HELP Registry 
signaturedate
Registry
SELECT * FROM Registry WHERE SourceCode IS NULL Order By SourceCode, LastModified
SELECT * FROM Registry WHERE FIRST = 'Bret' AND LAST = 'Knoll' Order By SourceCode, LastModified
delete Registry  where RegistryID = 6905
UPDATE Registry SET SourceCode = "" WHERE SourceCode is null
SELECT COUNT(*) FROM Registry Order By SourceCode
SELECT COUNT(*) FROM Registry

*/
-- sp_helptext sps_DonorRegistryByGenderAndAge
-- sps_DonorRegistryByGenderAgeAndSource '5/1/01', '9/20/02'
-- name stored procedure
-- drop PROCEDURE sps_DonorRegistryByGenderAgeAndSource
CREATE PROCEDURE sps_DonorRegistryByGenderAgeAndSource2

	@StartDate	SMALLDATETIME = NULL,
	@EndDate	SMALLDATETIME = NULL,
	@EventSource   VARCHAR(50) =NULL


AS
/*
	Desigened AND Developed 01/2003

	Legal Information...
	 ©1996-2003 Statline, LLC. All rights reserved. 

	 Statline is a registered trademark of Statline, LLC in the U.S.A. 


	 7555 East Hampden Avenue, Ste. 104, 
	 Denver, CO 80231. 
	 1-888-881-7828. 
*/
-- TURN RECORD COUNTS OFF
SET NOCOUNT ON

SELECT 

Count(*) as  'Outreach',
ISNULL(SC.SourceCodeName, 'No Source') AS 'EventName',
CASE Gender 
	WHEN 'M' THEN 'M'
	WHEN 'F' THEN 'F'
	ELSE 'U'
END AS 'Gender'
, 
CASE 
	WHEN DATEDIFF(YY, DOB, GETDATE()) < 18 THEN '0 - 17'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 18 AND 21 THEN '18 - 21'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 22 AND 29 THEN '22 - 29'	
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 30 AND 39 THEN '30 - 39'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 40 AND 49 THEN '40 - 49'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 50 AND 59 THEN '50 - 59'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 60 AND 69 THEN '60 - 69'
	WHEN DATEDIFF(YY, DOB, GETDATE()) > 69 THEN '70 + '
END AS 'AgeRange'

FROM Registry
LEFT JOIN RegistryEventSourceCodes SC ON  SC.SourceCodeID = Registry.SourceCode
WHERE	(SOURCECODE = @EventSource   or isnull(@EventSource,   '')='')
AND	(ISNULL(SignatureDate,OnlineRegDate)  >= @StartDate  OR ISNULL(@StartDate, '')='')
AND	(ISNULL(SignatureDate,OnlineRegDate)  <= @EndDate OR ISNULL(@EndDate, '')='')


GROUP BY 
SC.SourceCodeName ,
Gender,
CASE 
	WHEN DATEDIFF(YY, DOB, GETDATE()) < 18 THEN '0 - 17'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 18 AND 21 THEN '18 - 21'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 22 AND 29 THEN '22 - 29'	
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 30 AND 39 THEN '30 - 39'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 40 AND 49 THEN '40 - 49'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 50 AND 59 THEN '50 - 59'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 60 AND 69 THEN '60 - 69'
	WHEN DATEDIFF(YY, DOB, GETDATE()) > 69 THEN '70 + '
END 
ORDER BY 
SC.SourceCodeName ,

CASE 
	WHEN DATEDIFF(YY, DOB, GETDATE()) < 18 THEN '0 - 17'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 18 AND 21 THEN '18 - 21'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 22 AND 29 THEN '22 - 29'	
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 30 AND 39 THEN '30 - 39'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 40 AND 49 THEN '40 - 49'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 50 AND 59 THEN '50 - 59'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 60 AND 69 THEN '60 - 69'
	WHEN DATEDIFF(YY, DOB, GETDATE()) > 69 THEN '70 + '
END ,
Gender

/*
-- select from temporary table 
SELECT SUM(Online) AS 'OnLine', SUM(Outreach) AS 'Outreach', Gender, AgeRange, SourceCode AS 'EventName'
FROM #DRCountHoldingTable
--ORDER BY GENDER, AgeRange
GROUP BY Donor, Gender, AgeRange 
*/

--DROP TABLE #DRCountHoldingTable


GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.sps_DonorRegistryByGenderAndAge    Script Date: 1/11/2008 10:59:13 AM ******/

/****** Object:  Stored Procedure dbo.sps_DonorRegistryByGenderAndAge    Script Date: 8/11/2006 10:57:45 AM ******/

/*

Do you want any demographic info? We can get gender and age info if you'd like.

1.	Number of enrollees by website and outreach (summary)
2.	Report Date at top
3.	Date Range
4.	Web Online counts
5.	Donor counts
6.	group by gender, age (0-17, 18-21, 22-29, 30-39,….60-69, 70+)
	
Report Date	Date Range	Website	Outreach	Gender	Age


get a count of online and donor registrants between signature date range

group by gender and age . Age should fit into a category of 0-17, 18-21, 22-29, 30-39,40-49, 50-59, 60-69 and 70 or greater.
The age is obtained by subtracting Todays date from birthdate in years.

SP_HELP Registry 
signaturedate
Registry

*/
-- name stored procedure
-- drop PROCEDURE sps_DonorRegistryByGenderAndAge 
CREATE PROCEDURE sps_DonorRegistryByGenderAndAge

	@StartDate	SMALLDATETIME,
	@EndDate	SMALLDATETIME


AS
/*

	Desigened AND Developed 01/2003

	Legal Information...
	 ©1996-2003 Statline, LLC. All rights reserved. 

	 Statline is a registered trademark of Statline, LLC in the U.S.A. 


	 7555 East Hampden Avenue, Ste. 104, 
	 Denver, CO 80231. 
	 1-888-881-7828. 
*/

-- TURN RECORD COUNTS OFF
SET NOCOUNT ON
-- Build temporary holding table
SELECT COUNT(*) AS 'Online', COUNT(*) AS 'Outreach', 'U' AS 'Gender', '          ' AS 'AgeRange'
INTO #DRCountHoldingTable
FROM Registry
where 0<>0
GROUP BY Gender

--Start with counts from Registry
INSERT #DRCountHoldingTable (Online, Outreach, Gender, AgeRange)

SELECT 0,
Count(*) as  'Outrech',
CASE Gender 
	WHEN 'M' THEN 'M'
	WHEN 'F' THEN 'F'
	ELSE 'U'
END AS 'Gender'
, 
CASE 
	WHEN DATEDIFF(YY, DOB, GETDATE()) < 18 THEN '0 - 17'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 18 AND 21 THEN '18 - 21'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 22 AND 29 THEN '22 - 29'	
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 30 AND 39 THEN '30 - 39'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 40 AND 49 THEN '40 - 49'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 50 AND 59 THEN '50 - 59'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 60 AND 69 THEN '60 - 69'
	WHEN DATEDIFF(YY, DOB, GETDATE()) > 69 THEN '70 + '
END AS 'Age Group'
FROM Registry
WHERE ISNULL(SignatureDate,OnlineRegDate)  BETWEEN @StartDate AND @EndDate
GROUP BY 
Gender,
CASE 
	WHEN DATEDIFF(YY, DOB, GETDATE()) < 18 THEN '0 - 17'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 18 AND 21 THEN '18 - 21'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 22 AND 29 THEN '22 - 29'	
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 30 AND 39 THEN '30 - 39'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 40 AND 49 THEN '40 - 49'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 50 AND 59 THEN '50 - 59'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 60 AND 69 THEN '60 - 69'
	WHEN DATEDIFF(YY, DOB, GETDATE()) > 69 THEN '70 + '
END

-- Next query Registry

INSERT #DRCountHoldingTable (Online, Outreach, Gender, AgeRange)

SELECT Count(*) as  'Online',
0,
CASE Gender 
	WHEN 'M' THEN 'M'
	WHEN 'F' THEN 'F'
	ELSE 'U'
END AS 'Gender'
, 
CASE 
	WHEN DATEDIFF(YY, DOB, GETDATE()) < 18 THEN '0 - 17'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 18 AND 21 THEN '18 - 21'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 22 AND 29 THEN '22 - 29'	
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 30 AND 39 THEN '30 - 39'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 40 AND 49 THEN '40 - 49'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 50 AND 59 THEN '50 - 59'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 60 AND 69 THEN '60 - 69'
	WHEN DATEDIFF(YY, DOB, GETDATE()) > 69 THEN '70 + '
END AS 'Age Group'
FROM Registry
WHERE ISNULL(SignatureDate,OnlineRegDate)  BETWEEN @StartDate AND @EndDate
GROUP BY 
Gender,
CASE 
	WHEN DATEDIFF(YY, DOB, GETDATE()) < 18 THEN '0 - 17'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 18 AND 21 THEN '18 - 21'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 22 AND 29 THEN '22 - 29'	
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 30 AND 39 THEN '30 - 39'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 40 AND 49 THEN '40 - 49'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 50 AND 59 THEN '50 - 59'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 60 AND 69 THEN '60 - 69'
	WHEN DATEDIFF(YY, DOB, GETDATE()) > 69 THEN '70 + '
END

-- select from temporary table 
SELECT SUM(Online) AS 'OnLine', SUM(Outreach) AS 'Outreach', Gender, AgeRange
FROM #DRCountHoldingTable
--ORDER BY GENDER, AgeRange
GROUP BY Gender, AgeRange


DROP TABLE #DRCountHoldingTable


GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

/****** Object:  Stored Procedure dbo.sps_DonorRegistryByGenderAndAge2    Script Date: 1/11/2008 10:59:13 AM ******/

/****** Object:  Stored Procedure dbo.sps_DonorRegistryByGenderAndAge2    Script Date: 8/11/2006 10:57:45 AM ******/

/*

Do you want any demographic info? We can get gender and age info if you'd like.

1.	Number of enrollees by website and outreach (summary)
2.	Report Date at top
3.	Date Range
4.	Web Online counts
5.	Donor counts
6.	group by gender, age (0-17, 18-21, 22-29, 30-39,….60-69, 70+)
	
Report Date	Date Range	Website	Outreach	Gender	Age


get a count of online and donor registrants between signature date range

group by gender and age . Age should fit into a category of 0-17, 18-21, 22-29, 30-39,40-49, 50-59, 60-69 and 70 or greater.
The age is obtained by subtracting Todays date from birthdate in years.

SP_HELP Registry 
signaturedate
Registry

*/
-- name stored procedure
-- drop PROCEDURE sps_DonorRegistryByGenderAndAge 
CREATE PROCEDURE sps_DonorRegistryByGenderAndAge2

--CAB- This procedure was created 07/30/2004. Procedure was created to eliminate inaccurrate results / WHERE clause
--in "sps_DonorRegistryByGenderAndAge". This procedure should be renamed to "sps_DonorRegistryByGenderAndAge" when
--testing is complete.
	@StartDate	SMALLDATETIME,
	@EndDate	SMALLDATETIME


AS
/*

	Desigened AND Developed 01/2003

	Legal Information...
	 ©1996-2003 Statline, LLC. All rights reserved. 

	 Statline is a registered trademark of Statline, LLC in the U.S.A. 


	 7555 East Hampden Avenue, Ste. 104, 
	 Denver, CO 80231. 
	 1-888-881-7828. 
*/

-- TURN RECORD COUNTS OFF
SET NOCOUNT ON
-- Build temporary holding table
SELECT COUNT(*) AS 'Online', COUNT(*) AS 'Outreach', 'U' AS 'Gender', '          ' AS 'AgeRange'
INTO #DRCountHoldingTable
FROM Registry
where 0<>0
GROUP BY Gender

--Start with counts from Registry
INSERT #DRCountHoldingTable (Online, Outreach, Gender, AgeRange)

SELECT 0,
Count(*) as  'Outrech',
CASE Gender 
	WHEN 'M' THEN 'M'
	WHEN 'F' THEN 'F'
	ELSE 'U'
END AS 'Gender'
, 
CASE 
	WHEN DATEDIFF(YY, DOB, GETDATE()) < 18 THEN '0 - 17'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 18 AND 21 THEN '18 - 21'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 22 AND 29 THEN '22 - 29'	
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 30 AND 39 THEN '30 - 39'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 40 AND 49 THEN '40 - 49'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 50 AND 59 THEN '50 - 59'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 60 AND 69 THEN '60 - 69'
	WHEN DATEDIFF(YY, DOB, GETDATE()) > 69 THEN '70 + '
END AS 'Age Group'
FROM Registry
WHERE ISNULL(SignatureDate,CreateDate)  BETWEEN @StartDate AND @EndDate AND ISNULL(SourceCode, '') <> ''
GROUP BY 
Gender,
CASE 
	WHEN DATEDIFF(YY, DOB, GETDATE()) < 18 THEN '0 - 17'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 18 AND 21 THEN '18 - 21'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 22 AND 29 THEN '22 - 29'	
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 30 AND 39 THEN '30 - 39'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 40 AND 49 THEN '40 - 49'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 50 AND 59 THEN '50 - 59'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 60 AND 69 THEN '60 - 69'
	WHEN DATEDIFF(YY, DOB, GETDATE()) > 69 THEN '70 + '
END

-- Next query Registry

INSERT #DRCountHoldingTable (Online, Outreach, Gender, AgeRange)

SELECT Count(*) as  'Online',
0,
CASE Gender 
	WHEN 'M' THEN 'M'
	WHEN 'F' THEN 'F'
	ELSE 'U'
END AS 'Gender'
, 
CASE 
	WHEN DATEDIFF(YY, DOB, GETDATE()) < 18 THEN '0 - 17'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 18 AND 21 THEN '18 - 21'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 22 AND 29 THEN '22 - 29'	
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 30 AND 39 THEN '30 - 39'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 40 AND 49 THEN '40 - 49'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 50 AND 59 THEN '50 - 59'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 60 AND 69 THEN '60 - 69'
	WHEN DATEDIFF(YY, DOB, GETDATE()) > 69 THEN '70 + '
END AS 'Age Group'
FROM Registry
WHERE ISNULL(OnLineRegDate,CreateDate)  BETWEEN @StartDate AND @EndDate AND ISNULL(SourceCode, '') = ''
GROUP BY 
Gender,
CASE 
	WHEN DATEDIFF(YY, DOB, GETDATE()) < 18 THEN '0 - 17'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 18 AND 21 THEN '18 - 21'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 22 AND 29 THEN '22 - 29'	
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 30 AND 39 THEN '30 - 39'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 40 AND 49 THEN '40 - 49'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 50 AND 59 THEN '50 - 59'
	WHEN DATEDIFF(YY, DOB, GETDATE()) BETWEEN 60 AND 69 THEN '60 - 69'
	WHEN DATEDIFF(YY, DOB, GETDATE()) > 69 THEN '70 + '
END

-- select from temporary table 
SELECT SUM(Online) AS 'OnLine', SUM(Outreach) AS 'Outreach', Gender, AgeRange
FROM #DRCountHoldingTable
--ORDER BY GENDER, AgeRange
GROUP BY Gender, AgeRange


DROP TABLE #DRCountHoldingTable


GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO

/****** Object:  Stored Procedure dbo.sps_DonorRegistryGetCounts    Script Date: 1/11/2008 10:59:13 AM ******/

/****** Object:  Stored Procedure dbo.sps_DonorRegistryGetCounts    Script Date: 8/11/2006 10:57:45 AM ******/

CREATE PROCEDURE sps_DonorRegistryGetCounts
AS

declare @dmv			int,
	@DonorRegistry		int,
	@OnlineRegistry		int

SET @dmv = (SELECT Count(*) FROM dmv WHERE Donor = 1)
SET @DonorRegistry = (SELECT Count(*) FROM registry WHERE Donor = 1 AND DonorConfirmed = 1)
SET @OnlineRegistry = (SELECT Count(*) FROM registry WHERE Donor = 1 AND DonorConfirmed = 0)

SELECT @dmv as 'DMV', @DonorRegistry as 'DonorRegistry', @OnlineRegistry AS 'OnlineRegistry';


GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.sps_DonorRegistrySource    Script Date: 1/11/2008 10:59:13 AM ******/

/****** Object:  Stored Procedure dbo.sps_DonorRegistrySource    Script Date: 8/11/2006 10:57:45 AM ******/







/*

3.	Outreach enrollments by source code
a.	Name CO Registry Count (Source)
Kenn, I have the organization name in an Excel spreadsheet. Can they be imported into the database, or how do you want to handle this?

Report Date	Date Range	Event Source Code	Organization Name	Number 	Gender	Age

1.	Number of enrollees by website and outreach (summary)
2.	Report Date at top
3.	Date Range
4.	Web Online counts
5.	Donor counts
6.	group by gender, age (0-17, 18-21, 22-29, 30-39,….60-69, 70+)
	
group by gender, age (0-17, 18-21, 22-29, 30-39,….60-69, 70+)
	
Report Date	Date Range	Website	Outreach	Gender	Age


get a count of online and donor registrants between signature date range

group by gender and age . Age should fit into a category of 0-17, 18-21, 22-29, 30-39,40-49, 50-59, 60-69 and 70 or greater.
The age is obtained by subtracting Todays date from birthdate in years.

SP_HELP Registry 
signaturedate
Registry
SELECT * FROM Registry WHERE SourceCode IS NULL Order By SourceCode, LastModified
SELECT * FROM Registry WHERE FIRST = 'Bret' AND LAST = 'Knoll' Order By SourceCode, LastModified
delete Registry  where RegistryID = 6905
UPDATE Registry SET SourceCode = "" WHERE SourceCode is null
SELECT COUNT(*) FROM Registry Order By SourceCode
SELECT COUNT(*) FROM Registry

*/
-- sp_helptext sps_DonorRegistryByGenderAndAge
-- sps_DonorRegistrySource '5/1/01', '9/20/02'
-- name stored procedure
-- drop PROCEDURE sps_DonorRegistrySource
-- SELECT * FROM RegistryEventSourceCodes
CREATE PROCEDURE sps_DonorRegistrySource

	@StartDate	SMALLDATETIME,
	@EndDate	SMALLDATETIME
AS
/*

	Desigened AND Developed 01/2003

	Legal Information...
	 ©1996-2003 Statline, LLC. All rights reserved. 

	 Statline is a registered trademark of Statline, LLC in the U.S.A. 


	 7555 East Hampden Avenue, Ste. 104, 
	 Denver, CO 80231. 
	 1-888-881-7828. 
*/
-- TURN RECORD COUNTS OFF
SET NOCOUNT ON

SELECT 

Count(*) as  'Outreach',
SC.SourceCodeName AS 'EventName',
Registry.SourceCode AS 'SourceID'

FROM Registry
LEFT JOIN RegistryEventSourceCodes SC ON  SC.SourceCodeID = Registry.SourceCode
WHERE	SC.SourceCodeName IS NOT NULL 
AND	SignatureDate BETWEEN @StartDate AND @EndDate
 
GROUP BY 
SC.SourceCodeName,Registry.SourceCode 
ORDER BY 
SC.SourceCodeName 

/*
-- select from temporary table 
SELECT SUM(Online) AS 'OnLine', SUM(Outreach) AS 'Outreach', Gender, AgeRange, SourceCode AS 'EventName'
FROM #DRCountHoldingTable
--ORDER BY GENDER, AgeRange
GROUP BY Donor, Gender, AgeRange 
*/

--DROP TABLE #DRCountHoldingTable 










GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.sps_GetRegistryData    Script Date: 1/11/2008 10:59:13 AM ******/

/****** Object:  Stored Procedure dbo.sps_GetRegistryData    Script Date: 8/11/2006 10:57:45 AM ******/


CREATE PROCEDURE sps_GetRegistryData
	@DMVID	INTEGER =0,
	@RegID	INTEGER =0	

AS
/*

	Desigened AND Developed 01/2003

	Legal Information...
	 ©1996-2003 Statline, LLC. All rights reserved. 

	 Statline is a registered trademark of Statline, LLC in the U.S.A. 


	 7555 East Hampden Avenue, Ste. 104, 
	 Denver, CO 80231. 
	 1-888-881-7828. 
*/
	-- declare variables
	DECLARE
	@Restriction	VARCHAR(30), -- Used to hold the restrictions from the registry table
	@ADDR1		VARCHAR(40), -- Address Holders
	@ADDR2		VARCHAR(20),
	@CITY		VARCHAR(25),
	@STATE		VARCHAR(2),
	@ZIP		VARCHAR(10),
	@ADDRType	VARCHAR(30)
	
    -- if DMVID is > 0 select data from DMV tables
    IF @DMVID > 0 
    BEGIN
	-- check if the @RegID is > 0. Get Registry Comment if it is
	IF @RegID > 0
	BEGIN
		SELECT 	@Restriction 	= ISNULL(Comment, '')
		FROM 	Registry
		WHERE	ID		= @RegID
	END
	ELSE
	BEGIN
		SELECT @Restriction = ''
	END
	-- build the address field
	SELECT  TOP 1
		@ADDR1	= Addr1,
		@ADDR2	= ISNULL(Addr2,''),
		@CITY	= ISNULL(City,''),
		@STATE	= ISNULL(State,''),
		@ZIP	= ISNULL(Zip,''),
		@ADDRType = RTRIM(LTRIM(AD.Description))
	FROM	DMVADDR
	LEFT 
	JOIN	AddrType AD ON AD.ID = DMVADDR.AddrTypeID
	WHERE	DMVID	= @DMVID
	ORDER 
	BY	AddrTypeID

	SELECT 
		License AS 'RegistryID',
		ISNULL(FirstName, '') AS 'FirstName',
		ISNULL(MiddleName, '') AS 'MiddleName',
		ISNULL(LastName, '') AS 'LastName',
		ISNULL(DOB, '') AS 'DOB',
		ISNULL(Suffix, '') AS 'Suffix',
		ISNULL(Gender,'') AS 'Gender', 
		CASE Donor 
		    	WHEN 0 Then 'N'
		    	WHEN 1 THEN 'Y'
			Else ''
    		END AS 'Donor',
		CASE 
			WHEN RenewalDate IS NULL 
			THEN CASE 
				WHEN LastModified IS NULL 
				THEN CreateDate
				ELSE LastModified 
			     END
			ELSE RenewalDate
		END AS 'DonorFlagDate',		
		@Restriction 'Restriction',
		ID,
		@ADDR1 AS 'ADDR1',
		@ADDR2 AS 'ADDR2',	
		@CITY AS 'CITY',	
		@STATE AS 'STATE',	
		@ZIP AS 'ZIP',
		@ADDRType AS 'AddrType',
		'' AS 'DonorYear'		
	FROM	DMV	
	WHERE	ID	= 	@DMVID

		
	
    END
    ELSE 
    BEGIN
    -- if DMVID = 0 select data from Registry
    
	-- build the address field
	SELECT TOP 1
		@ADDR1		= Addr1,
		@ADDR2		= ISNULL(Addr2, ''),
		@CITY		= City,
		@STATE		= State,
		@ZIP		= Zip,
		@ADDRType 	= RTRIM(LTRIM(AD.Description))
	FROM	RegistryAddr	
	LEFT 
	JOIN	AddrType AD ON AD.ID = RegistryAddr.AddrTypeID
	WHERE	RegistryID	= @RegID
	ORDER 
	BY	AddrTypeID
        
    	SELECT 
    		CASE 	WHEN LEN(License)=9 THEN License
    			ELSE CAST(ID AS VARCHAR(20))
    		END AS 'RegistryID',
		ISNULL(FirstName, '') AS 'FirstName',
		ISNULL(MiddleName, '') AS 'MiddleName',
		ISNULL(LastName, '') AS 'LastName',
		ISNULL(DOB, '') AS 'DOB',
		ISNULL(Suffix, '') AS 'Suffix',
		ISNULL(Gender,'') AS 'Gender', 
    		CASE Donor 
    			WHEN 0 Then 'N'
    			WHEN 1 THEN 'Y'
			ELSE ''
    		END AS 'Donor',
		CASE 
			WHEN SignatureDate IS NULL 
			THEN CASE 
				WHEN OnlineRegDate IS NULL 
				THEN LastModified
				ELSE OnlineRegDate 
			     END
			ELSE SignatureDate
		END AS 'DonorFlagDate',
		ISNULL(RTRIM(LTRIM(Comment)), '') AS 'Restriction',
		ID,
		@ADDR1 AS 'ADDR1',
		@ADDR2 AS 'ADDR2',	
		@CITY AS 'CITY',	
		@STATE AS 'STATE',	
		@ZIP AS 'ZIP',
		@ADDRType AS 'AddrType',
		'' AS 'DonorYear'		
	FROM	Registry
	WHERE	ID	=	@RegID
    
    END












GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.sps_IMPORT_ALL_ImportSuspense    Script Date: 1/11/2008 10:59:13 AM ******/

/****** Object:  Stored Procedure dbo.sps_IMPORT_ALL_ImportSuspense    Script Date: 8/11/2006 10:57:45 AM ******/





-- sp_helpTEXT IMPORT_ImportSuspense
CREATE PROCEDURE sps_IMPORT_ALL_ImportSuspense AS
/*

	Desigened AND Developed 01/2003

	Legal Information...
	 ©1996-2003 Statline, LLC. All rights reserved. 

	 Statline is a registered trademark of Statline, LLC in the U.S.A. 


	 7555 East Hampden Avenue, Ste. 104, 
	 Denver, CO 80231. 
	 1-888-881-7828. 
*/

Begin Transaction IMPORT
  set identity_insert IMPORT on
  insert IMPORT(ID, LAST, FIRST, MIDDLE, SUFFIX, AADDR1, ACITY, ASTATE, AZIP, BADDR1, BCITY, BSTATE, BZIP, DOB, GENDER, LICENSE, DONOR, RENEWALDATE)
  select        ID, LAST, FIRST, MIDDLE, SUFFIX, AADDR1, ACITY, ASTATE, AZIP, BADDR1, BCITY, BSTATE, BZIP, DOB, GENDER, LICENSE, DONOR, RENEWALDATE
  from SUSPENSE
  where OK = 1
  delete from SUSPENSE
  where OK = 1
  set identity_insert IMPORT off
commit transaction IMPORT
CHECKPOINT -- bjk 07/01/03 add checkpoint






GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.sps_IMPORT_A_DataCleanupInvalidAddress    Script Date: 1/11/2008 10:59:13 AM ******/

/****** Object:  Stored Procedure dbo.sps_IMPORT_A_DataCleanupInvalidAddress    Script Date: 8/11/2006 10:57:45 AM ******/





CREATE PROCEDURE sps_IMPORT_A_DataCleanupInvalidAddress AS
/*

	Desigened AND Developed 01/2003

	Legal Information...
	 ©1996-2003 Statline, LLC. All rights reserved. 

	 Statline is a registered trademark of Statline, LLC in the U.S.A. 


	 7555 East Hampden Avenue, Ste. 104, 
	 Denver, CO 80231. 
	 1-888-881-7828. 
*/
declare @suspect varchar(255)
select @suspect = 'Invalid Address IMPORT_A'
begin transaction IMPORT_A
  insert SUSPENSE_A
  select *, 0, @suspect from IMPORT_A
  where ((isnull(AADDR1,'') ='' AND isnull(BADDR1,'') ='')
   or    (isnull(ACITY,'') = '' AND isnull(BCITY,'') = '')
   or    (isnull(ASTATE,'') = '' AND isnull(BSTATE,'') = '')
   or    (isnull(AZIP,'') = '' AND isnull(BZIP,'') = '')
 )
  update IMPORTLOG
  set RecordsSuspended = RecordsSuspended + @@rowcount
  where RunStatus = 'LOADING'
  delete from IMPORT_A
  where ((isnull(AADDR1,'') ='' AND isnull(BADDR1,'') ='')
   or    (isnull(ACITY,'') = '' AND isnull(BCITY,'') = '')
   or    (isnull(ASTATE,'') = '' AND isnull(BSTATE,'') = '')
   or    (isnull(AZIP,'') = '' AND isnull(BZIP,'') = '')
 )
commit transaction IMPORT_A

CHECKPOINT





GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.sps_IMPORT_A_DataCleanupInvalidGender    Script Date: 1/11/2008 10:59:13 AM ******/

/****** Object:  Stored Procedure dbo.sps_IMPORT_A_DataCleanupInvalidGender    Script Date: 8/11/2006 10:57:45 AM ******/





-- sp_helptext IMPORT_DataCleanupInvalidGender
CREATE PROCEDURE sps_IMPORT_A_DataCleanupInvalidGender AS
/*

	Desigened AND Developed 01/2003

	Legal Information...
	 ©1996-2003 Statline, LLC. All rights reserved. 

	 Statline is a registered trademark of Statline, LLC in the U.S.A. 


	 7555 East Hampden Avenue, Ste. 104, 
	 Denver, CO 80231. 
	 1-888-881-7828. 
*/
declare @suspect varchar(255)
select @suspect = 'Invalid Gender IMPORT_A'
begin transaction IMPORT_A
  insert SUSPENSE_A
  select *, 0, @suspect from IMPORT_A
  where upper(Gender) <> 'M'
  and   upper(Gender) <> 'F'
  and   upper(Gender) <> 'U'
  update IMPORTLOG
  set RecordsSuspended = RecordsSuspended + @@rowcount
  where RunStatus = 'LOADING'
  delete from IMPORT_A
  where upper(Gender) <> 'M'
  and   upper(Gender) <> 'F'
  and   upper(Gender) <> 'U'
commit transaction IMPORT_A
CHECKPOINT






GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.sps_IMPORT_A_DataCleanupUpperDonor    Script Date: 1/11/2008 10:59:13 AM ******/

/****** Object:  Stored Procedure dbo.sps_IMPORT_A_DataCleanupUpperDonor    Script Date: 8/11/2006 10:57:45 AM ******/





-- sp_helptext IMPORT_DataCleanupUpperDonor
CREATE PROCEDURE sps_IMPORT_A_DataCleanupUpperDonor AS
/*

	Desigened AND Developed 01/2003

	Legal Information...
	 ©1996-2003 Statline, LLC. All rights reserved. 

	 Statline is a registered trademark of Statline, LLC in the U.S.A. 


	 7555 East Hampden Avenue, Ste. 104, 
	 Denver, CO 80231. 
	 1-888-881-7828. 
*/
begin transaction IMPORT_A
  update IMPORT_A
  set Donor = upper(Donor)
commit transaction IMPORT_A

CHECKPOINT





GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.sps_IMPORT_A_DataCleanupUpperGender    Script Date: 1/11/2008 10:59:13 AM ******/

/****** Object:  Stored Procedure dbo.sps_IMPORT_A_DataCleanupUpperGender    Script Date: 8/11/2006 10:57:45 AM ******/





-- sp_helptext CREATE PROCEDURE IMPORT_DataCleanupUpperGender AS
CREATE PROCEDURE sps_IMPORT_A_DataCleanupUpperGender AS
/*

	Desigened AND Developed 01/2003

	Legal Information...
	 ©1996-2003 Statline, LLC. All rights reserved. 

	 Statline is a registered trademark of Statline, LLC in the U.S.A. 


	 7555 East Hampden Avenue, Ste. 104, 
	 Denver, CO 80231. 
	 1-888-881-7828. 
*/
begin transaction IMPORT_A
  update IMPORT_A
  set Gender = upper(Gender)
commit transaction IMPORT_A

CHECKPOINT





GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.sps_IMPORT_A_ImportSuspense    Script Date: 1/11/2008 10:59:13 AM ******/

/****** Object:  Stored Procedure dbo.sps_IMPORT_A_ImportSuspense    Script Date: 8/11/2006 10:57:45 AM ******/





CREATE PROCEDURE sps_IMPORT_A_ImportSuspense AS
/*

	Desigened AND Developed 01/2003

	Legal Information...
	 ©1996-2003 Statline, LLC. All rights reserved. 

	 Statline is a registered trademark of Statline, LLC in the U.S.A. 


	 7555 East Hampden Avenue, Ste. 104, 
	 Denver, CO 80231. 
	 1-888-881-7828. 
*/
BEGIN TRANSACTION IMPORT_A
  
  INSERT IMPORT_A(IMPORTLOGID, LAST, FIRST, MIDDLE, SUFFIX, AADDR1, ACITY, ASTATE, AZIP, BADDR1, BCITY, BSTATE, BZIP, DOB, GENDER, LICENSE, DONOR, RENEWALDATE, DECEASEDDATE, CSORSTATE, CSORLICENSE)
  SELECT IMPORTLOGID, LAST, FIRST, MIDDLE, SUFFIX, AADDR1, ACITY, ASTATE, AZIP, BADDR1, BCITY, BSTATE, BZIP, DOB, GENDER, LICENSE, DONOR, RENEWALDATE, DECEASEDDATE, CSORSTATE, CSORLICENSE
  FROM SUSPENSE_A
  WHERE OK = 1
  
  DELETE FROM SUSPENSE_A
  WHERE OK = 1
COMMIT TRANSACTION IMPORT_A

CHECKPOINT





GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.sps_IMPORT_All_ImportArchiveBULK    Script Date: 1/11/2008 10:59:13 AM ******/

/****** Object:  Stored Procedure dbo.sps_IMPORT_All_ImportArchiveBULK    Script Date: 8/11/2006 10:57:45 AM ******/





CREATE PROCEDURE sps_IMPORT_All_ImportArchiveBULK AS
/*

	Desigened AND Developed 01/2003

	Legal Information...
	 ©1996-2003 Statline, LLC. All rights reserved. 

	 Statline is a registered trademark of Statline, LLC in the U.S.A. 


	 7555 East Hampden Avenue, Ste. 104, 
	 Denver, CO 80231. 
	 1-888-881-7828. 
*/
begin transaction ARCHIVE 
  insert IMPORTARCHIVE_A
  select *, NULL, NULL
  from IMPORT_A
  insert IMPORTARCHIVE_B
  select *, NULL, NULL
  from IMPORT_B
  insert IMPORTARCHIVE_C
  select *, NULL, NULL
  from IMPORT_C
commit transaction ARCHIVE

CHECKPOINT





GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.sps_IMPORT_B_ImportSuspense    Script Date: 1/11/2008 10:59:13 AM ******/

/****** Object:  Stored Procedure dbo.sps_IMPORT_B_ImportSuspense    Script Date: 8/11/2006 10:57:45 AM ******/





CREATE PROCEDURE sps_IMPORT_B_ImportSuspense AS
/*

	Desigened AND Developed 01/2003

	Legal Information...
	 ©1996-2003 Statline, LLC. All rights reserved. 

	 Statline is a registered trademark of Statline, LLC in the U.S.A. 


	 7555 East Hampden Avenue, Ste. 104, 
	 Denver, CO 80231. 
	 1-888-881-7828. 
*/
BEGIN TRANSACTION IMPORT_B
  
  INSERT IMPORT_B(IMPORTLOGID, LICENSE, LAST, FIRST, MIDDLE, SUFFIX, DATEOFCHANGE, TIMEOFCHANGE, DOB, FILMNUM, USERID, DATEOFMOD, TIMEOFMOD )
  SELECT IMPORTLOGID, LICENSE, LAST, FIRST, MIDDLE, SUFFIX, DATEOFCHANGE, TIMEOFCHANGE, DOB, FILMNUM, USERID, DATEOFMOD, TIMEOFMOD
  FROM SUSPENSE_B
  WHERE OK = 1
  
  DELETE FROM SUSPENSE_B
  WHERE OK = 1
COMMIT TRANSACTION IMPORT_B
CHECKPOINT -- bjk 07/01/03 add checkpoint






GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.sps_IMPORT_C_DataCleanupInvalidAddress    Script Date: 1/11/2008 10:59:13 AM ******/

/****** Object:  Stored Procedure dbo.sps_IMPORT_C_DataCleanupInvalidAddress    Script Date: 8/11/2006 10:57:45 AM ******/





CREATE PROCEDURE sps_IMPORT_C_DataCleanupInvalidAddress AS
/*

	Desigened AND Developed 01/2003

	Legal Information...
	 ©1996-2003 Statline, LLC. All rights reserved. 

	 Statline is a registered trademark of Statline, LLC in the U.S.A. 


	 7555 East Hampden Avenue, Ste. 104, 
	 Denver, CO 80231. 
	 1-888-881-7828. 
*/

declare @suspect varchar(255)
select @suspect = 'Invalid Address IMPORT_C'
begin transaction IMPORT_C
  insert SUSPENSE_C
  select *, 0, @suspect from IMPORT_C
  where ((isnull(AADDR1,'') ='' AND isnull(BADDR1,'') ='')
   or    (isnull(ACITY,'') = '' AND isnull(BCITY,'') = '')
   or    (isnull(ASTATE,'') = '' AND isnull(BSTATE,'') = '')
   or    (isnull(AZIP,'') = '' AND isnull(BZIP,'') = '')
 )
  update IMPORTLOG
  set RecordsSuspended = RecordsSuspended + @@rowcount
  where RunStatus = 'LOADING'
  delete from IMPORT_C
  where ((isnull(AADDR1,'') ='' AND isnull(BADDR1,'') ='')
   or    (isnull(ACITY,'') = '' AND isnull(BCITY,'') = '')
   or    (isnull(ASTATE,'') = '' AND isnull(BSTATE,'') = '')
   or    (isnull(AZIP,'') = '' AND isnull(BZIP,'') = '')
 )
commit transaction IMPORT_C
CHECKPOINT -- bjk 07/01/03 add checkpoint






GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.sps_IMPORT_C_ImportSuspense    Script Date: 1/11/2008 10:59:13 AM ******/

/****** Object:  Stored Procedure dbo.sps_IMPORT_C_ImportSuspense    Script Date: 8/11/2006 10:57:45 AM ******/





CREATE PROCEDURE sps_IMPORT_C_ImportSuspense AS
/*

	Desigened AND Developed 01/2003

	Legal Information...
	 ©1996-2003 Statline, LLC. All rights reserved. 

	 Statline is a registered trademark of Statline, LLC in the U.S.A. 


	 7555 East Hampden Avenue, Ste. 104, 
	 Denver, CO 80231. 
	 1-888-881-7828. 
*/
 BEGIN TRANSACTION IMPORT_C
    INSERT IMPORT_C( IMPORTLOGID, LICENSE, AADDR1, ACITY, ASTATE, AZIP, BADDR1, BCITY, BSTATE, BZIP)
    SELECT IMPORTLOGID, LICENSE, AADDR1, ACITY, ASTATE, AZIP, BADDR1, BCITY, BSTATE, BZIP
    FROM SUSPENSE_C
    WHERE OK = 1
  DELETE FROM SUSPENSE_C
    WHERE OK = 1
  
 COMMIT TRANSACTION IMPORT_C

CHECKPOINT -- bjk 07/01/03 add checkpoint





GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.sps_IMPORT_ImportInitialize    Script Date: 1/11/2008 10:59:13 AM ******/

/****** Object:  Stored Procedure dbo.sps_IMPORT_ImportInitialize    Script Date: 8/11/2006 10:57:45 AM ******/





CREATE PROCEDURE sps_IMPORT_ImportInitialize AS
/*

	Desigened AND Developed 01/2003

	Legal Information...
	 ©1996-2003 Statline, LLC. All rights reserved. 

	 Statline is a registered trademark of Statline, LLC in the U.S.A. 


	 7555 East Hampden Avenue, Ste. 104, 
	 Denver, CO 80231. 
	 1-888-881-7828. 
*/
insert IMPORTLOG(RecordsTotal) values(0)
return @@IDENTITY







GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.sps_SourceEvent    Script Date: 1/11/2008 10:59:13 AM ******/

/****** Object:  Stored Procedure dbo.sps_SourceEvent    Script Date: 8/11/2006 10:57:45 AM ******/





CREATE PROCEDURE sps_SourceEvent AS


SELECT 
	SourceCodeName, 
	SourceCodeID  
FROM 	RegistryEventSourceCodes  
ORDER BY SourceCodeName









GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.sps_WebUser    Script Date: 1/11/2008 10:59:13 AM ******/

/****** Object:  Stored Procedure dbo.sps_WebUser    Script Date: 8/11/2006 10:57:45 AM ******/




CREATE PROCEDURE sps_WebUser
		@Access 		INT	= 0
AS
SET NOCOUNT ON
If @Access <> 0
BEGIN

	SELECT * FROM webuser, registry
	WHERE access & @Access <> 0	
	AND webuser.RegistryID *= registry.ID

--	SELECT * FROM webuser
--	WHERE access & @Access <> 0
END

















GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.sps_WebUserEmail    Script Date: 1/11/2008 10:59:13 AM ******/

/****** Object:  Stored Procedure dbo.sps_WebUserEmail    Script Date: 8/11/2006 10:57:45 AM ******/




CREATE PROCEDURE sps_WebUserEmail
		@vEmail 		Varchar(500)= ''
AS

If @vEmail <> ''
BEGIN
	SELECT @vEmail =replace(@vEmail, '*', '%')

	SELECT * FROM webuser, registry
	WHERE email like @vEmail
	AND webuser.RegistryID *= registry.ID

--	SELECT * FROM webuser
--	WHERE email like @vEmail
END








GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.sps_WebUserLogin    Script Date: 1/11/2008 10:59:13 AM ******/

/****** Object:  Stored Procedure dbo.sps_WebUserLogin    Script Date: 8/11/2006 10:57:45 AM ******/




/****** Object:  Stored Procedure dbo.sps_WebUserLogin    Script Date: 5/30/03 ******/
/************************************************
	Email Error Codes

	1 --> New Email already exists
	2 --> Incorrect Login Password
	3 --> Login Email Address Incorrect

***********************************************/

CREATE PROCEDURE sps_WebUserLogin
		@vEmail 		varchar(500)	= null,
		@vPwd			varchar(50)	= null

AS
SET NOCOUNT ON
If @vEmail IS NOT NULL AND @vPwd IS NOT NULL
BEGIN
	If NOT EXISTS (	SELECT * FROM WebUser WHERE Email = @vEmail)
		BEGIN
			-- Insert
			select 0 AS 'WebUserID' , 0 AS 'RegistryID', 0 AS 'Access', 3 as 'ErrorCode'
		END
	ELSE
		BEGIN
		IF EXISTS (SELECT * FROM WebUser WHERE Email = @vEmail AND Pwd = @vPwd)
			BEGIN
				-- Login
				SELECT	WebUserID, RegistryID, Access, 0 as 'ErrorCode'
			        	FROM 		WebUser
				WHERE 	Email = @vEmail
				AND 		Pwd = @vPwd
			END
		ELSE
			BEGIN
				-- Password Error
				select 0 AS 'WebUserID' , 0 AS 'RegistryID', 0 AS 'Access', 2 as 'ErrorCode'
			END
		END
END
ELSE
BEGIN
	select NULL AS 'WebUserID' , NULL AS 'RegistryID', NULL AS 'Access'
END



















GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.sps_WebUserbyID    Script Date: 1/11/2008 10:59:13 AM ******/

/****** Object:  Stored Procedure dbo.sps_WebUserbyID    Script Date: 8/11/2006 10:57:45 AM ******/




CREATE PROCEDURE sps_WebUserbyID
		@WebUserID 		INT	= 0
AS
SET NOCOUNT ON
If @WebUserID <> 0
BEGIN

	SELECT * FROM webuser, registry
	WHERE webuserid=@WebUserID
	AND webuser.RegistryID *= registry.ID

END






GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.spu_ConfirmOnlineRegistrant    Script Date: 1/11/2008 10:59:13 AM ******/

/****** Object:  Stored Procedure dbo.spu_ConfirmOnlineRegistrant    Script Date: 8/11/2006 10:57:45 AM ******/





CREATE PROCEDURE spu_ConfirmOnlineRegistrant AS

/*

Desigened AND Developed 02/2003

Legal Information...
 ©1996-2003 Statline, LLC. All rights reserved. 

 Statline is a registered trademark of Statline, LLC in the U.S.A. 


 7555 East Hampden Avenue, Ste. 104, 
 Denver, CO 80231. 
 1-888-881-7828. 

*/
UPDATE	Registry 
SET 	DonorConfirmed = 1
-- select DATEDIFF(D,MailerDate, GETDATE()) ,* from Registry 
WHERE	DonorConfirmed = 0
AND	DATEDIFF(D,MailerDate, GETDATE()) >= 30







GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.spu_IMPORT_A_DataCleanupDeceasedDate    Script Date: 1/11/2008 10:59:13 AM ******/

/****** Object:  Stored Procedure dbo.spu_IMPORT_A_DataCleanupDeceasedDate    Script Date: 8/11/2006 10:57:45 AM ******/





-- sp_helptext IMPORT_DataCleanupDeceasedDate
CREATE PROCEDURE spu_IMPORT_A_DataCleanupDeceasedDate AS
/*

	Desigened AND Developed 01/2003

	Legal Information...
	 ©1996-2003 Statline, LLC. All rights reserved. 

	 Statline is a registered trademark of Statline, LLC in the U.S.A. 


	 7555 East Hampden Avenue, Ste. 104, 
	 Denver, CO 80231. 
	 1-888-881-7828. 
*/
  update IMPORT
  set DeceasedDate = NULL
  where DeceasedDate = '00000000'







GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.spu_IMPORT_A_DataCleanupDuplicateLicense    Script Date: 1/11/2008 10:59:13 AM ******/

/****** Object:  Stored Procedure dbo.spu_IMPORT_A_DataCleanupDuplicateLicense    Script Date: 8/11/2006 10:57:45 AM ******/





CREATE PROCEDURE spu_IMPORT_A_DataCleanupDuplicateLicense AS
/*

	Desigened AND Developed 01/2003

	Legal Information...
	 ©1996-2003 Statline, LLC. All rights reserved. 

	 Statline is a registered trademark of Statline, LLC in the U.S.A. 


	 7555 East Hampden Avenue, Ste. 104, 
	 Denver, CO 80231. 
	 1-888-881-7828. 
*/
declare @suspect varchar(255)
select @suspect = 'Duplicate License Number in IMPORT_A File'
begin transaction IMPORT_A
  insert SUSPENSE_A
  select i.*, 0, @suspect
  from IMPORT_A i, (select LICENSE
                  from IMPORT_A
                  group by LICENSE
                  having count(ID) > 1) d
  where i.LICENSE = d.LICENSE
  update IMPORTLOG
  set RecordsSuspended = RecordsSuspended + @@rowcount
  where RunStatus = 'LOADING'
  delete from IMPORT_A
  from IMPORT_A i, (select LICENSE
                  from IMPORT_A
                  group by LICENSE
                  having count(ID) > 1) d
  where i.LICENSE = d.LICENSE
commit transaction IMPORT_A

CHECKPOINT -- bjk 07/01/03 add checkpoint





GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.spu_IMPORT_A_DataCleanupInvalidDOB    Script Date: 1/11/2008 10:59:13 AM ******/

/****** Object:  Stored Procedure dbo.spu_IMPORT_A_DataCleanupInvalidDOB    Script Date: 8/11/2006 10:57:45 AM ******/





-- sp_helptext IMPORT_DataCleanupInvalidDOB
CREATE PROCEDURE spu_IMPORT_A_DataCleanupInvalidDOB AS
/*

	Desigened AND Developed 01/2003

	Legal Information...
	 ©1996-2003 Statline, LLC. All rights reserved. 

	 Statline is a registered trademark of Statline, LLC in the U.S.A. 


	 7555 East Hampden Avenue, Ste. 104, 
	 Denver, CO 80231. 
	 1-888-881-7828. 
*/
declare @suspect varchar(255)
select @suspect = 'Invalid Date of Birth IMPORT_A'
begin transaction IMPORT_A
  insert SUSPENSE_A
  select *, 0, @suspect from IMPORT_A
  where isnull(DOB,'') = ''
  update IMPORTLOG
  set RecordsSuspended = RecordsSuspended + @@rowcount
  where RunStatus = 'LOADING'
  delete from IMPORT_A
  where isnull(DOB,'') = ''
commit transaction IMPORT_A

CHECKPOINT -- bjk 07/01/03 add checkpoint





GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.spu_IMPORT_A_DataCleanupInvalidFirstLast    Script Date: 1/11/2008 10:59:13 AM ******/

/****** Object:  Stored Procedure dbo.spu_IMPORT_A_DataCleanupInvalidFirstLast    Script Date: 8/11/2006 10:57:45 AM ******/





CREATE PROCEDURE spu_IMPORT_A_DataCleanupInvalidFirstLast AS
/*

	Desigened AND Developed 01/2003

	Legal Information...
	 ©1996-2003 Statline, LLC. All rights reserved. 

	 Statline is a registered trademark of Statline, LLC in the U.S.A. 


	 7555 East Hampden Avenue, Ste. 104, 
	 Denver, CO 80231. 
	 1-888-881-7828. 
*/
declare @suspect varchar(255)
select @suspect = 'Invalid First or Last Name IMPORT_A'
begin transaction IMPORT_A
  insert SUSPENSE_A
  select *, 0, @suspect from IMPORT_A
  where isnull(FIRST,'') = ''
 OR isnull(LAST,'') = ''
  update IMPORTLOG
  set RecordsSuspended = RecordsSuspended + @@rowcount
  where RunStatus = 'LOADING'
  delete from IMPORT_A
  where isnull(FIRST,'') = ''
 OR isnull(LAST,'') = ''
commit transaction IMPORT_A

CHECKPOINT -- bjk 07/01/03 add checkpoint






GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.spu_IMPORT_A_DataCleanupInvalidLicense    Script Date: 1/11/2008 10:59:14 AM ******/

/****** Object:  Stored Procedure dbo.spu_IMPORT_A_DataCleanupInvalidLicense    Script Date: 8/11/2006 10:57:45 AM ******/





--sp_helptext IMPORT_DataCleanupInvalidLicense
CREATE PROCEDURE spu_IMPORT_A_DataCleanupInvalidLicense AS
/*

	Desigened AND Developed 01/2003

	Legal Information...
	 ©1996-2003 Statline, LLC. All rights reserved. 

	 Statline is a registered trademark of Statline, LLC in the U.S.A. 


	 7555 East Hampden Avenue, Ste. 104, 
	 Denver, CO 80231. 
	 1-888-881-7828. 
*/
declare @suspect varchar(255)
select @suspect = 'Invalid DMV License Number IMPORT_A'
begin transaction IMPORT_A
  insert SUSPENSE_A
  select *, 0, @suspect from IMPORT_A
  where isnull(LICENSE,'') = ''
  update IMPORTLOG
  set RecordsSuspended = RecordsSuspended + @@rowcount
  where RunStatus = 'LOADING'
  delete from IMPORT_A
  where isnull(LICENSE,'') = ''
commit transaction IMPORT_A

CHECKPOINT -- bjk 07/01/03 add checkpoint





GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.spu_IMPORT_All_ImportLog2    Script Date: 1/11/2008 10:59:14 AM ******/

/****** Object:  Stored Procedure dbo.spu_IMPORT_All_ImportLog2    Script Date: 8/11/2006 10:57:45 AM ******/





CREATE PROCEDURE spu_IMPORT_All_ImportLog2 AS
/*

	Desigened AND Developed 01/2003

	Legal Information...
	 ©1996-2003 Statline, LLC. All rights reserved. 

	 Statline is a registered trademark of Statline, LLC in the U.S.A. 


	 7555 East Hampden Avenue, Ste. 104, 
	 Denver, CO 80231. 
	 1-888-881-7828. 
*/
declare @@RecordsUpdated             int
declare @@RecordsAdded               int
select @@RecordsUpdated = count(IMPORT.ID)
from IMPORT, DMV
where IMPORT.LICENSE = DMV.LICENSE
select @@RecordsAdded = count(IMPORT.ID)
from IMPORT
where not exists(select IMPORT.LICENSE
                 from DMV where IMPORT.LICENSE = DMV.LICENSE)
update IMPORTLOG
set RecordsUpdated            = @@RecordsUpdated,
    RecordsAdded              = @@RecordsAdded
where RunStatus = 'LOADING'







GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.spu_IMPORT_All_ImportLogStats    Script Date: 1/11/2008 10:59:14 AM ******/

/****** Object:  Stored Procedure dbo.spu_IMPORT_All_ImportLogStats    Script Date: 8/11/2006 10:57:45 AM ******/





CREATE PROCEDURE spu_IMPORT_All_ImportLogStats AS
/*

	Desigened AND Developed 01/2003

	Legal Information...
	 ©1996-2003 Statline, LLC. All rights reserved. 

	 Statline is a registered trademark of Statline, LLC in the U.S.A. 


	 7555 East Hampden Avenue, Ste. 104, 
	 Denver, CO 80231. 
	 1-888-881-7828. 
*/
declare @@RDonorY             int
declare @@RDonorChange        int
declare @@RM                  int
declare @@RF                  int
declare @@RMDonorY            int
declare @@RFDonorY            int
declare @@RM18Total           int
declare @@RM18DonorY          int
declare @@RF18Total           int
declare @@RF18DonorY          int
declare @@RM17Total           int
declare @@RM17DonorY          int
declare @@RF17Total           int
declare @@RF17DonorY          int
select @@RDonorChange = count(IMPORT.ID)
from IMPORT, DMV
where IMPORT.LICENSE      = DMV.LICENSE
and   upper(IMPORT.DONOR) = 'Y'
and   DMV.DONOR           = 0
select @@RM = count(IMPORT.ID)
from IMPORT
where upper(Gender) = "M"
select @@RF = count(IMPORT.ID)
from IMPORT
where upper(Gender) = "F"
select @@RMDonorY = count(IMPORT.ID)
from IMPORT
where upper(Gender) = "M"
and   upper(DONOR)  = "Y"
select @@RFDonorY = count(IMPORT.ID)
from IMPORT
where upper(Gender) = "F"
and   upper(DONOR)  = "Y"
select @@RM18Total = count(IMPORT.ID)
from IMPORT
where upper(Gender) = "M"
and   convert(datetime,DOB) >= (getdate()-(18*365))
select @@RF18Total = count(IMPORT.ID)
from IMPORT
where upper(Gender) = "F"
and   convert(datetime,DOB) >= (getdate()-(18*365))
select @@RM18DonorY = count(IMPORT.ID)
from IMPORT
where upper(Gender) = "M"
and   upper(DONOR)  = "Y"
and   convert(datetime,DOB) >= (getdate()-(18*365))
select @@RF18DonorY = count(IMPORT.ID)
from IMPORT
where upper(Gender) = "F"
and   upper(DONOR)  = "Y"
and   convert(datetime,DOB) >= (getdate()-(18*365))
select @@RM17Total = count(IMPORT.ID)
from IMPORT
where upper(Gender) = "M"
and   convert(datetime,DOB) < (getdate()-(18*365))
select @@RF17Total = count(IMPORT.ID)
from IMPORT
where upper(Gender) = "F"
and   convert(datetime,DOB) < (getdate()-(18*365))
select @@RM17DonorY = count(IMPORT.ID)
from IMPORT
where upper(Gender) = "M"
and   upper(DONOR)  = "Y"
and   convert(datetime,DOB) < (getdate()-(18*365))
select @@RF17DonorY = count(IMPORT.ID)
from IMPORT
where upper(Gender) = "F"
and   upper(DONOR)  = "Y"
and   convert(datetime,DOB) < (getdate()-(18*365))
update IMPORTLOGSTATS
set RDonorY          = @@RDonorY,
    RDonorChange     = @@RDonorChange,
    RM               = @@RM,
    RF               = @@RF,
    RMDonorY         = @@RMDonorY,
    RFDonorY         = @@RFDonorY,
    RM18Total        = @@RM18Total,
    RM18DonorY       = @@RM18DonorY,
    RF18Total        = @@RF18Total,
    RF18DonorY       = @@RF18DonorY,
    RM17Total        = @@RM17Total,
    RM17DonorY       = @@RM17DonorY,
    RF17Total        = @@RF17Total,
    RF17DonorY       = @@RF17DonorY
where RunStatus = 'LOADING'







GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.spu_IMPORT_B_DataCleanupDuplicateLicense    Script Date: 1/11/2008 10:59:14 AM ******/

/****** Object:  Stored Procedure dbo.spu_IMPORT_B_DataCleanupDuplicateLicense    Script Date: 8/11/2006 10:57:45 AM ******/





CREATE PROCEDURE spu_IMPORT_B_DataCleanupDuplicateLicense AS
/*

	Desigened AND Developed 01/2003

	Legal Information...
	 ©1996-2003 Statline, LLC. All rights reserved. 

	 Statline is a registered trademark of Statline, LLC in the U.S.A. 


	 7555 East Hampden Avenue, Ste. 104, 
	 Denver, CO 80231. 
	 1-888-881-7828. 
*/
declare @suspect varchar(255)
select @suspect = 'Duplicate License Number in IMPORT_B File'
begin transaction IMPORT_B
  insert SUSPENSE_B
  select i.*, 0, @suspect
  from IMPORT_B i, (select LICENSE
                  from IMPORT_B
                  group by LICENSE
                  having count(ID) > 1) d
  where i.LICENSE = d.LICENSE
  update IMPORTLOG
  set RecordsSuspended = RecordsSuspended + @@rowcount
  where RunStatus = 'LOADING'
  delete from IMPORT_B
  from IMPORT_B i, (select LICENSE
                  from IMPORT_B
                  group by LICENSE
                  having count(ID) > 1) d
  where i.LICENSE = d.LICENSE
commit transaction IMPORT_B

CHECKPOINT -- bjk 07/01/03 add checkpoint






GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.spu_IMPORT_B_DataCleanupInvalidDOB    Script Date: 1/11/2008 10:59:14 AM ******/

/****** Object:  Stored Procedure dbo.spu_IMPORT_B_DataCleanupInvalidDOB    Script Date: 8/11/2006 10:57:45 AM ******/





CREATE PROCEDURE spu_IMPORT_B_DataCleanupInvalidDOB AS
/*

	Desigened AND Developed 01/2003

	Legal Information...
	 ©1996-2003 Statline, LLC. All rights reserved. 

	 Statline is a registered trademark of Statline, LLC in the U.S.A. 


	 7555 East Hampden Avenue, Ste. 104, 
	 Denver, CO 80231. 
	 1-888-881-7828. 
*/
declare @suspect varchar(255)
select @suspect = 'Invalid Date of Birth IMPORT_B'
begin transaction IMPORT_B
  insert SUSPENSE_B
  select *, 0, @suspect from IMPORT_B
  where isnull(DOB,'') = ''
  update IMPORTLOG
  set RecordsSuspended = RecordsSuspended + @@rowcount
  where RunStatus = 'LOADING'
  delete from IMPORT_B
  where isnull(DOB,'') = ''
commit transaction IMPORT_B

CHECKPOINT -- bjk 07/01/03 add checkpoint





GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.spu_IMPORT_B_DataCleanupInvalidFirstLast    Script Date: 1/11/2008 10:59:14 AM ******/

/****** Object:  Stored Procedure dbo.spu_IMPORT_B_DataCleanupInvalidFirstLast    Script Date: 8/11/2006 10:57:45 AM ******/





CREATE PROCEDURE spu_IMPORT_B_DataCleanupInvalidFirstLast AS
/*

	Desigened AND Developed 01/2003

	Legal Information...
	 ©1996-2003 Statline, LLC. All rights reserved. 

	 Statline is a registered trademark of Statline, LLC in the U.S.A. 


	 7555 East Hampden Avenue, Ste. 104, 
	 Denver, CO 80231. 
	 1-888-881-7828. 
*/
declare @suspect varchar(255)
select @suspect = 'Invalid First or Last Name IMPORT_B'
begin transaction IMPORT_B
  insert SUSPENSE_B
  select *, 0, @suspect from IMPORT_B
  where isnull(FIRST,'') = ''
 OR isnull(LAST,'') = ''
  update IMPORTLOG
  set RecordsSuspended = RecordsSuspended + @@rowcount
  where RunStatus = 'LOADING'
  delete from IMPORT_B
  where isnull(FIRST,'') = ''
 OR isnull(LAST,'') = ''
commit transaction IMPORT_B
CHECKPOINT -- bjk 07/01/03 add checkpoint
/*
DECLARE @FIRST VARCHAR(10),
 @LAST VARCHAR(10)
SELECT @FIRST = 'BRET'
SELECT @LAST = NULL
SELECT ':' + isnull(@FIRST,'') + isnull(@LAST,'') +  ':', ':' + ':', ': :'
*/







GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.spu_IMPORT_B_DataCleanupInvalidLicense    Script Date: 1/11/2008 10:59:14 AM ******/

/****** Object:  Stored Procedure dbo.spu_IMPORT_B_DataCleanupInvalidLicense    Script Date: 8/11/2006 10:57:45 AM ******/





CREATE PROCEDURE spu_IMPORT_B_DataCleanupInvalidLicense AS
/*

	Desigened AND Developed 01/2003

	Legal Information...
	 ©1996-2003 Statline, LLC. All rights reserved. 

	 Statline is a registered trademark of Statline, LLC in the U.S.A. 


	 7555 East Hampden Avenue, Ste. 104, 
	 Denver, CO 80231. 
	 1-888-881-7828. 
*/
declare @suspect varchar(255)
select @suspect = 'Invalid DMV License Number IMPORT_B'
begin transaction IMPORT_B
  insert SUSPENSE_B
  select *, 0, @suspect from IMPORT_B
  where isnull(LICENSE,'') = ''
  update IMPORTLOG
  set RecordsSuspended = RecordsSuspended + @@rowcount
  where RunStatus = 'LOADING'
  delete from IMPORT_B
  where isnull(LICENSE,'') = ''
commit transaction IMPORT_B

CHECKPOINT -- bjk 07/01/03 add checkpoint





GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.spu_IMPORT_C_DataCleanupDuplicateLicense    Script Date: 1/11/2008 10:59:14 AM ******/

/****** Object:  Stored Procedure dbo.spu_IMPORT_C_DataCleanupDuplicateLicense    Script Date: 8/11/2006 10:57:45 AM ******/





CREATE PROCEDURE spu_IMPORT_C_DataCleanupDuplicateLicense AS
/*

	Desigened AND Developed 01/2003

	Legal Information...
	 ©1996-2003 Statline, LLC. All rights reserved. 

	 Statline is a registered trademark of Statline, LLC in the U.S.A. 


	 7555 East Hampden Avenue, Ste. 104, 
	 Denver, CO 80231. 
	 1-888-881-7828. 
*/
declare @suspect varchar(255)
select @suspect = 'Duplicate License Number in IMPORT_C File'
begin transaction IMPORT_C
  insert SUSPENSE_C
  select i.*, 0, @suspect
  from IMPORT_C i, (select LICENSE
                  from IMPORT_C
                  group by LICENSE
                  having count(ID) > 1) d
  where i.LICENSE = d.LICENSE
  update IMPORTLOG
  set RecordsSuspended = RecordsSuspended + @@rowcount
  where RunStatus = 'LOADING'
  delete from IMPORT_C
  from IMPORT_C i, (select LICENSE
                  from IMPORT_C
                  group by LICENSE
                  having count(ID) > 1) d
  where i.LICENSE = d.LICENSE
commit transaction IMPORT_C

CHECKPOINT -- bjk 07/01/03 add checkpoint





GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.spu_IMPORT_C_DataCleanupInvalidLicense    Script Date: 1/11/2008 10:59:14 AM ******/

/****** Object:  Stored Procedure dbo.spu_IMPORT_C_DataCleanupInvalidLicense    Script Date: 8/11/2006 10:57:45 AM ******/





CREATE PROCEDURE spu_IMPORT_C_DataCleanupInvalidLicense AS
/*

	Desigened AND Developed 01/2003

	Legal Information...
	 ©1996-2003 Statline, LLC. All rights reserved. 

	 Statline is a registered trademark of Statline, LLC in the U.S.A. 


	 7555 East Hampden Avenue, Ste. 104, 
	 Denver, CO 80231. 
	 1-888-881-7828. 
*/
declare @suspect varchar(255)
select @suspect = 'Invalid DMV License Number IMPORT_C'
begin transaction IMPORT_C
  insert SUSPENSE_C
  select *, 0, @suspect from IMPORT_C
  where isnull(LICENSE,'') = ''
  update IMPORTLOG
  set RecordsSuspended = RecordsSuspended + @@rowcount
  where RunStatus = 'LOADING'
  delete from IMPORT_C
  where isnull(LICENSE,'') = ''
commit transaction IMPORT_C

CHECKPOINT -- bjk 07/01/03 add checkpoint





GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.spu_IMPORT_DataCleanupReplaceEmptyString    Script Date: 1/11/2008 10:59:14 AM ******/

/****** Object:  Stored Procedure dbo.spu_IMPORT_DataCleanupReplaceEmptyString    Script Date: 8/11/2006 10:57:45 AM ******/





CREATE PROCEDURE spu_IMPORT_DataCleanupReplaceEmptyString AS
/*

	Desigened AND Developed 01/2003

	Legal Information...
	 ©1996-2003 Statline, LLC. All rights reserved. 

	 Statline is a registered trademark of Statline, LLC in the U.S.A. 


	 7555 East Hampden Avenue, Ste. 104, 
	 Denver, CO 80231. 
	 1-888-881-7828. 
*/
declare @tbl as varchar(255), 
        @col as varchar(255), 
        @sql as varchar(255)
declare cIMPORTTBL cursor for 
 select TableName
   from IMPORTFILES 
   order by WorkOrder
open cIMPORTTBL
fetch next from cIMPORTTBL into @tbl 
 while @@fetch_status = 0
 begin
   RAISERROR (@tbl,1,1)with LOG
      declare cIMPORT cursor for 
         Select c.name 
         from sysobjects o, syscolumns c
         where c.id = o.id
         and o.name = @tbl
         and c.name <> 'ID'
         order by c.colid
      open cIMPORT
      fetch next from cIMPORT into @col 
      while @@fetch_status = 0
        begin
   select @sql = "update " + @tbl + " set " + @col + " = NULL where rtrim(ltrim(" + @col + ")) = ''"
   exec (@sql)
   fetch next from cIMPORT into @col
        end
     close cIMPORT
     deallocate cIMPORT
     fetch next from cIMPORTTBL into @tbl 
  end
close cIMPORTTBL
deallocate cIMPORTTBL







GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.spu_IMPORT_DataCleanupTrimBlanks    Script Date: 1/11/2008 10:59:14 AM ******/

/****** Object:  Stored Procedure dbo.spu_IMPORT_DataCleanupTrimBlanks    Script Date: 8/11/2006 10:57:45 AM ******/





CREATE PROCEDURE spu_IMPORT_DataCleanupTrimBlanks AS
/*

	Desigened AND Developed 01/2003

	Legal Information...
	 ©1996-2003 Statline, LLC. All rights reserved. 

	 Statline is a registered trademark of Statline, LLC in the U.S.A. 


	 7555 East Hampden Avenue, Ste. 104, 
	 Denver, CO 80231. 
	 1-888-881-7828. 
*/
declare @tbl as varchar(255), 
        @col as varchar(255), 
        @sql as varchar(255)
declare cIMPORTTBL cursor for 
 select TableName
   from IMPORTFILES 
   order by WorkOrder
open cIMPORTTBL
fetch next from cIMPORTTBL into @tbl 
 while @@fetch_status = 0
 begin
   RAISERROR (@tbl,1,1)with LOG
      declare cIMPORT cursor for 
         Select c.name 
         from sysobjects o, syscolumns c
         where c.id = o.id
         and o.name = @tbl
         and c.name <> 'ID'
	 and c.name <> 'MIDDLE'
         order by c.colid
      open cIMPORT
      fetch next from cIMPORT into @col 
      while @@fetch_status = 0
        begin
	select @sql = "update " + @tbl + " set " + @col + " = rtrim(ltrim(" + @col + "))"   
   exec (@sql)
   fetch next from cIMPORT into @col
        end
     close cIMPORT
     deallocate cIMPORT
     fetch next from cIMPORTTBL into @tbl 
  end
close cIMPORTTBL
deallocate cIMPORTTBL









GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.spu_IMPORT_ImportLog1    Script Date: 1/11/2008 10:59:14 AM ******/

/****** Object:  Stored Procedure dbo.spu_IMPORT_ImportLog1    Script Date: 8/11/2006 10:57:45 AM ******/





CREATE PROCEDURE spu_IMPORT_ImportLog1 AS
/*

	Desigened AND Developed 01/2003

	Legal Information...
	 ©1996-2003 Statline, LLC. All rights reserved. 

	 Statline is a registered trademark of Statline, LLC in the U.S.A. 


	 7555 East Hampden Avenue, Ste. 104, 
	 Denver, CO 80231. 
	 1-888-881-7828. 
*/
declare @@RecordsTotal               int
select @@RecordsTotal = count(IMPORT_A.ID)
from IMPORT_A
select @@RecordsTotal = @@RecordsTotal + count(IMPORT_B.ID)
from IMPORT_B
select @@RecordsTotal = @@RecordsTotal + count(IMPORT_C.ID)
from IMPORT_C
update IMPORTLOG
set RecordsTotal              = @@RecordsTotal
where RunStatus = 'LOADING'







GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.spu_SetOnlineMailerDate    Script Date: 1/11/2008 10:59:14 AM ******/

/****** Object:  Stored Procedure dbo.spu_SetOnlineMailerDate    Script Date: 8/11/2006 10:57:45 AM ******/





CREATE PROCEDURE spu_SetOnlineMailerDate
	@Donor 		CHAR(1)		=NULL,
	@StartDate 	SMALLDATETIME 	=NULL,
	@EndDate	SMALLDATETIME 	=NULL
AS
/*

Desigened AND Developed 02/2003

Legal Information...
 ©1996-2003 Statline, LLC. All rights reserved. 

 Statline is a registered trademark of Statline, LLC in the U.S.A. 


 7555 East Hampden Avenue, Ste. 104, 
 Denver, CO 80231. 
 1-888-881-7828. 

Paramameters
	Donor 		- Flag indicating a Donors wishes 0 is Not Yes, 1 is Yes and NULL is either
	StartDate	- Start of OnlineRegDate to query
	EndDate		- End of OnlineRegDate to query
*/

UPDATE 	Registry
SET	MailerDate = GETDATE()
-- SELECT * FROM Registry
WHERE	(Donor		= @Donor	OR ISNULL(@Donor,	'')='')
AND 	DonorConfirmed = 0
AND 	(OnlineRegDate  >= @StartDate	OR ISNULL(@StartDate,	'')='')
AND 	(OnlineRegDate  <= @EndDate	OR ISNULL(@EndDate,	'')='')









GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.spu_Suspense_B_CleanUpLicenseDups    Script Date: 1/11/2008 10:59:14 AM ******/

/****** Object:  Stored Procedure dbo.spu_Suspense_B_CleanUpLicenseDups    Script Date: 8/11/2006 10:57:45 AM ******/





CREATE PROCEDURE spu_Suspense_B_CleanUpLicenseDups AS
/*

	Desigened AND Developed 01/2003

	Legal Information...
	 ©1996-2003 Statline, LLC. All rights reserved. 

	 Statline is a registered trademark of Statline, LLC in the U.S.A. 


	 7555 East Hampden Avenue, Ste. 104, 
	 Denver, CO 80231. 
	 1-888-881-7828. 
*/
DECLARE @LICENSE AS VARCHAR(255)
DECLARE WeedOutDups CURSOR FOR
 select License from suspense_b group by License having count(License) >1 
OPEN WeedOutDups
 FETCH NEXT FROM WeedOutDups
 INTO @LICENSE
 WHILE @@FETCH_STATUS = 0 
 BEGIN
  UPDATE SUSPENSE_B
  SET OK = 1
  WHERE	LICENSE = @LICENSE
  AND 	CAST( DATEOFCHANGE + ' ' + SUBSTRING(TIMEOFCHANGE, 1, 2) + ':' + SUBSTRING(TIMEOFCHANGE, 3, 2) AS SMALLDATETIME) =  (SELECT MAX(CAST( DATEOFCHANGE + ' ' + SUBSTRING(TIMEOFCHANGE, 1, 2) + ':' + SUBSTRING(TIMEOFCHANGE, 3, 2) AS SMALLDATETIME)) FROM SUSPENSE_B WHERE LICENSE = @LICENSE)
  DELETE SUSPENSE_B WHERE LICENSE = @LICENSE AND OK <> 1
  FETCH NEXT FROM WeedOutDups
  INTO @LICENSE
 END
CLOSE WeedOutDups
DEALLOCATE WeedOutDups







GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.spui_RegistryTest    Script Date: 1/11/2008 10:59:14 AM ******/

/****** Object:  Stored Procedure dbo.spui_RegistryTest    Script Date: 8/11/2006 10:57:46 AM ******/





CREATE PROCEDURE spui_RegistryTest
	@pvDMVID 	AS INT 		= NULL,
	@pvLASTNAME 	AS VARCHAR(25) 	= NULL,
	@pvFIRSTNAME 	AS VARCHAR(20) 	= NULL,
	@pvMIDDLENAME	AS VARCHAR(20) 	= NULL,
	@pvGENDER 	AS VARCHAR(1) 	= NULL,
	@pvSSN 		AS VARCHAR(11) 	= NULL,
	@pvDOB 		AS SMALLDATETIME = NULL,
	@pvRACE 	AS INT 		= NULL,
	@pvRADDR	AS VARCHAR(40)	= NULL,
	@pvRCITY	AS VARCHAR(25)	= NULL,
	@pvRSTATE	AS VARCHAR(2)	= NULL,
	@pvRZIP		AS VARCHAR(10)	= NULL,
	@pvMADDR	AS VARCHAR(40)	= NULL,
	@pvMCITY	AS VARCHAR(25)	= NULL,
	@pvMSTATE	AS VARCHAR(2)	= NULL,
	@pvMZIP		AS VARCHAR(10)	= NULL,
	@pvPHONE	AS VARCHAR(10)	= NULL,
	@pvLICENSE	AS VARCHAR(9)	= NULL,
	@pvDONOR	AS VARCHAR(1)	= NULL,
	@pvDMVDONOR	AS VARCHAR(1)	= NULL,
	@pvCOMMENTS	AS VARCHAR(200)	= NULL,
	@pvSOURCECODE	AS VARCHAR(10)	= NULL,
	@pvUSERID	AS INT		= NULL,	
	@pvSIGNATUREDATE AS SMALLDATETIME= NULL,
	@pvRegistryID	AS INT		= NULL
	
AS
/*

	Desigened AND Developed 01/2003

	Legal Information...
	 ©1996-2003 Statline, LLC. All rights reserved. 

	 Statline is a registered trademark of Statline, LLC in the U.S.A. 


	 7555 East Hampden Avenue, Ste. 104, 
	 Denver, CO 80231. 
	 1-888-881-7828. 
*/
-- turn off record counts
SET NOCOUNT ON

DECLARE @CURRENTID 		AS INT,
	@CURRENTRESIDENTIALID 	AS INT,
	@CURRENTMAILINGID 	AS INT,
	@RegistryID		AS INT,
	@RegistryResult		AS VARCHAR(50),
	@ResidentialResult	AS VARCHAR(50),
	@MailingResult		AS VARCHAR(50)

-- clean up data
	SELECT @pvDMVID 	= CASE 	WHEN @pvDMVID = 0 THEN NULL 
					ELSE @pvDMVID 
				  END
	SELECT @pvMIDDLENAME	= CASE	WHEN @pvMIDDLENAME ='' THEN NULL 
					WHEN CHARINDEX('.',RIGHT(@pvMIDDLENAME,1)) > 0 THEN UPPER(LEFT(@pvMIDDLENAME, LEN(@pvMIDDLENAME) - 1) + REPLACE(RIGHT(@pvMIDDLENAME,1),'.',''))
					ELSE UPPER(@pvMIDDLENAME)
				  END			
	SELECT @pvLASTNAME 	= UPPER(@pvLASTNAME )
	SELECT @pvFIRSTNAME 	= UPPER(@pvFIRSTNAME )	
	SELECT @pvGENDER	= CASE @pvGENDER 
					WHEN '' THEN NULL 
					ELSE @pvGENDER 
				  END
	SELECT @pvSSN		= CASE	WHEN @pvSSN = '' THEN NULL
					ELSE @pvSSN
				  END
	SELECT @pvRACE		= CASE	WHEN @pvRACE = 0 THEN NULL
					ELSE @pvRACE
				  END
	SELECT @pvRADDR		= CASE	WHEN @pvRADDR = '' THEN NULL
					ELSE @pvRADDR
				  END
	SELECT @pvRCITY		= CASE	WHEN @pvRCITY = '' THEN NULL
					ELSE @pvRCITY
				  END
	SELECT @pvRSTATE	= CASE	WHEN @pvRSTATE = '' THEN NULL
					ELSE @pvRSTATE
				  END
	SELECT @pvRZIP		= CASE	WHEN @pvRZIP = '' THEN NULL
					ELSE @pvRZIP
				  END
	SELECT @pvMADDR		= CASE	WHEN @pvMADDR = ''THEN NULL
					ELSE @pvMADDR
				  END
	SELECT @pvMCITY		= CASE	WHEN @pvMCITY = ''THEN NULL
					ELSE @pvMCITY
				  END
	SELECT @pvMSTATE	= CASE	WHEN @pvMSTATE = '' THEN NULL
					ELSE @pvMSTATE
				  END
	SELECT @pvMZIP		= CASE	WHEN @pvMZIP = '' THEN NULL
					ELSE @pvMZIP
				  END
	SELECT @pvPHONE		= CASE	WHEN @pvPHONE = ''THEN NULL
					ELSE @pvPHONE
				  END
	SELECT @pvLICENSE	= CASE	WHEN @pvLICENSE = '' THEN NULL
					ELSE @pvLICENSE
				  END
	SELECT @pvCOMMENTS	= CASE	WHEN @pvCOMMENTS = '' THEN NULL
					ELSE @pvCOMMENTS
				  END
	SELECT @pvSOURCECODE	= CASE	WHEN @pvSOURCECODE = '' THEN NULL
					ELSE @pvSOURCECODE
				  END
	SELECT @pvUSERID	= CASE	WHEN @pvUSERID = 0 THEN NULL
					ELSE @pvUSERID
				  END
	SELECT @pvRegistryID	= CASE	WHEN @pvRegistryID = 0 THEN NULL
					ELSE @pvRegistryID
				  END

-- determine if this record is an insert or an update
IF @pvRegistryID = 0
BEGIN
	SELECT	@CURRENTID = R.ID 
	FROM 	Registry R
	WHERE	((DOB		LIKE @pvDOB	   OR ISNULL(@pvDOB, 	  '')='')
	AND   	(FirstName      LIKE @pvFirstName  OR ISNULL(@pvFirstName,  '')='')
	AND   	(MiddleName     LIKE @pvMiddleName OR ISNULL(@pvMiddleName, '')='')	
	AND   	(LastName	LIKE @pvLastName   OR ISNULL(@pvLastName,   '')=''))
END
ELSE
BEGIN
	SELECT @CURRENTID = @pvRegistryID
END
	

SELECT @pvLastName, @pvFirstName, @pvMiddleName, @pvDOB, @pvRegistryID







GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.spi_Archive_Deceased    Script Date: 1/11/2008 10:59:14 AM ******/

/****** Object:  Stored Procedure dbo.spi_Archive_Deceased    Script Date: 8/11/2006 10:57:46 AM ******/






-- sp_helptext sps_IMPORT_All_ImportArchive
-- sp_help dmvarchive select distinct RecordType from dmvarchive
-- Select * from Datadict_donor-a
CREATE  PROCEDURE spi_Archive_Deceased 
	@ArchiveReason INT = 2
AS
/*

	Desigened AND Developed 01/2003

	Legal Information...
	 ©1996-2003 Statline, LLC. All rights reserved. 

	 Statline is a registered trademark of Statline, LLC in the U.S.A. 


	 7555 East Hampden Avenue, Ste. 104, 
	 Denver, CO 80231. 
	 1-888-881-7828. 
*/
 declare @@IMPORTLOGID int
 select @@IMPORTLOGID = ID
 from IMPORTLOG
 where upper(RunStatus) = 'LOADING'
 
 begin transaction ARCHIVE
 insert DMVARCHIVE
  SELECT	DMV.ID, 
		DMV.ImportLogID, 
		DMV.SSN, 
		DMV.License, 
		DMV.DOB, DMV.FirstName, DMV.MiddleName, DMV.LastName, 
		DMV.Suffix, DMV.Gender, DMV.Donor, DMV.RenewalDate, 
		DMV.DeceasedDate, DMV.CSORState, DMV.CSORLicense, 
		DMV.UserID, DMV.LastModified, DMV.CreateDate,
		@@IMPORTLOGID, @ArchiveReason 
  from DMV
    where ISNULL(DMV.DeceasedDate, '')<> ''  
   insert DMVARCHIVEADDR
    select 
	DMVADDR.[ID], DMVADDR.[DMVID], DMVADDR.[AddrTypeID], 
	DMVADDR.[Addr1], DMVADDR.[Addr2], DMVADDR.[City], DMVADDR.[State], 
	DMVADDR.[Zip], DMVADDR.[UserID], DMVADDR.[LastModified], 
	DMVADDR.[CreateDate] 
    from DMV, DMVADDR
    where DMV.ID = DMVADDR.DMVID
    and   ISNULL(DMV.DeceasedDate, '')<> ''
 
 insert DMVARCHIVEORGAN
    select 
	DMVORGAN.[ID], DMVORGAN.[DMVID], DMVORGAN.[OrganTypeID], 
	DMVORGAN.[LastModified], DMVORGAN.[CreateDate] 
    from DMV, DMVORGAN
    where DMV.ID = DMVORGAN.DMVID
    and   ISNULL(DMV.DeceasedDate, '')<> ''
   delete from DMVORGAN
    from DMV, DMVORGAN
    where DMV.ID = DMVORGAN.DMVID
    and   ISNULL(DMV.DeceasedDate, '')<> ''
   delete from DMVADDR
    from DMV, DMVADDR
    where DMV.ID = DMVADDR.DMVID
    and   ISNULL(DMV.DeceasedDate, '')<> ''
   delete from DMV
    from DMV, IMPORT
    where ISNULL(DMV.DeceasedDate, '')<> ''
 commit transaction ARCHIVE
CHECKPOINT













GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.spi_Archive_OutOfState    Script Date: 1/11/2008 10:59:14 AM ******/

/****** Object:  Stored Procedure dbo.spi_Archive_OutOfState    Script Date: 8/11/2006 10:57:46 AM ******/






-- sp_helptext sps_IMPORT_All_ImportArchive
-- sp_help dmvarchive select distinct RecordType from dmvarchive
-- Select * from Datadict_donor-a
CREATE  PROCEDURE spi_Archive_OutOfState AS
/*

	Desigened AND Developed 01/2003

	Legal Information...
	 ©1996-2003 Statline, LLC. All rights reserved. 

	 Statline is a registered trademark of Statline, LLC in the U.S.A. 


	 7555 East Hampden Avenue, Ste. 104, 
	 Denver, CO 80231. 
	 1-888-881-7828. 
*/
 declare @@IMPORTLOGID int
 select @@IMPORTLOGID = ID
 from IMPORTLOG
 where upper(RunStatus) = 'LOADING'
 
 begin transaction ARCHIVE
 insert DMVARCHIVE
    select 
 		DMV.ID, DMV.ImportLogID, DMV.SSN, DMV.License, 
		DMV.DOB, DMV.FirstName, DMV.MiddleName, DMV.LastName, 
		DMV.Suffix, DMV.Gender, DMV.Donor, DMV.RenewalDate, 
		DMV.DeceasedDate, DMV.CSORState, DMV.CSORLicense, 
		DMV.UserID, DMV.LastModified, DMV.CreateDate,
		@@IMPORTLOGID, 3 
    from DMV
    where ISNULL(DMV.CSORState,'')<>''
    OR ISNULL(DMV.CSORLicense, '')<> ''
  
   insert DMVARCHIVEADDR
    select 
	DMVADDR.[ID], DMVADDR.[DMVID], DMVADDR.[AddrTypeID], 
	DMVADDR.[Addr1], DMVADDR.[Addr2], DMVADDR.[City], DMVADDR.[State], 
	DMVADDR.[Zip], DMVADDR.[UserID], DMVADDR.[LastModified], 
	DMVADDR.[CreateDate] 	
    from DMV, DMVADDR
    where DMV.ID = DMVADDR.DMVID
    and   (ISNULL(DMV.CSORState,'')<>''
    OR ISNULL(DMV.CSORLicense, '')<> '')
 
 insert DMVARCHIVEORGAN
    select 
	DMVORGAN.[ID], DMVORGAN.[DMVID], DMVORGAN.[OrganTypeID], 
	DMVORGAN.[LastModified], DMVORGAN.[CreateDate] 
    from DMV, DMVORGAN
    where DMV.ID = DMVORGAN.DMVID
    and   (ISNULL(DMV.CSORState,'')<>''
    OR ISNULL(DMV.CSORLicense, '')<> '')
   delete from DMVORGAN
    from DMV, DMVORGAN
    where DMV.ID = DMVORGAN.DMVID
    and   (ISNULL(DMV.CSORState,'')<>''
    OR ISNULL(DMV.CSORLicense, '')<> '')
   delete from DMVADDR
    from DMV, DMVADDR
    where DMV.ID = DMVADDR.DMVID
    and   (ISNULL(DMV.CSORState,'')<>''
    OR ISNULL(DMV.CSORLicense, '')<> '')
   delete from DMV
    from DMV, IMPORT
    where (ISNULL(DMV.CSORState,'')<>''
    OR ISNULL(DMV.CSORLicense, '')<> '')
 commit transaction ARCHIVE
CHECKPOINT







GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

/****** Object:  Stored Procedure dbo.sps_CheckRegistry_NEOB    Script Date: 1/11/2008 10:59:14 AM ******/





CREATE  Procedure sps_CheckRegistry_NEOB
	@DOB   		DATETIME    	= NULL,
	@LastName	VARCHAR(25) 	= NULL,
	@FirstName 	VARCHAR(25) 	= NULL,
	@NADD 		INT	       	= NULL, -- NADD = No Additional Donor Data	
	@MiddleName 	VARCHAR(25) 	= NULL,
	@SSN   		VARCHAR(11) 	= NULL,
	@LICENSE 	VARCHAR(15) 	= NULL,
	@StreetAddress 	VARCHAR(45) 	= NULL,
	@City 		VARCHAR(25) 	= NULL,
	@State 		VARCHAR(2) 	= NULL,
	@Zip 		VARCHAR(10) 	= NULL
AS

SET NOCOUNT ON
/* ccarroll 09/20/2006 - Similar to sps_CheckRegistry
 adapted to search NEOB registry using sps_CheckRegistryDMVNEOB
   
 Legal Information...
 ©1996-2003 Statline, LLC. All rights reserved. 

Paramameters
	First - Donors First Name
	Last  - Donors Last Name
	DOB   - Donor Date of Birth
	SSN   - Social Security Number	

SP_HELP DMV 

	DECLARE VARIABLES*/
	DECLARE @RegistryID INT,
		@RegistryDonor BIT,
		@RegistryDate SMALLDATETIME,
		@DMVID INT,
		@DMVDonor BIT,
		@DMVDate SMALLDATETIME,
		@RestrictionID INT,		
		@REGRecordsReturned INT,		
		@DMVRecordsReturned INT,
		@DMVSource VARCHAR(10)

	-- initialize @RestrictionID
	SELECT @RestrictionID  = 0 

	-- get values for registry 
	EXEC sps_CheckRegistry_REG
		@DOB, 
		@LastName, 
		@FirstName, 
		@MiddleName, 
		@SSN, 
		@LICENSE, 
		@StreetAddress,
		@City,
		@State,
		@Zip,
		1,			-- This is the suspense variable see Note:			
		@RegistryID OUTPUT,
		@RegistryDonor OUTPUT,
		@RegistryDate OUTPUT,
		@REGRecordsReturned OUTPUT
/*
   Suspense Variable Note:
   NULL returns both registry (non-suspense) and suspense records
   1	returns registry  (non-suspense) records
   0	returns suspense records


  check for multiple records from registry 
  IF MORE THAN 1 RECORD WAS RETURNED ASK FOR ADDITIONAL INFORMATION */

	IF 	@REGRecordsReturned > 1 
		AND
		(ISNULL(@MiddleName, '') +  
		 ISNULL(@SSN, '') +
		 ISNULL(@LICENSE, '') +
		 ISNULL(@StreetAddress, '') +
		 ISNULL(@City, '') +
		 ISNULL(@State, '') +
		 ISNULL(@Zip, '') = '' 
		)
		BEGIN
			SELECT
			'Registration Undetermined' AS 'Source',
			0 AS 'ID',
			'U' AS 'Donor' , -- U is undetermined
			'1/1/1900' AS 'Date',
			0 AS 'RestrictionID'
		
			RETURN
		END
	ELSE IF @REGRecordsReturned > 1 
		AND
		(
		 ISNULL(@NADD,1) = 1
		OR -- BJK 05/27/03 
		 ISNULL(@MiddleName, '') +  
		 ISNULL(@SSN, '') +
		 ISNULL(@LICENSE, '') +
		 ISNULL(@StreetAddress, '') +
		 ISNULL(@City, '') +
		 ISNULL(@State, '') +
		 ISNULL(@Zip, '') <> '' 
		)
		BEGIN
			SELECT
			'Registration Undetermined' AS 'Source',
			0 AS 'ID',
			'N' AS 'Donor' , -- U is undetermined
			'1/1/1900' AS 'Date',
			0 AS 'RestrictionID'
		
			RETURN		
		END
/*  ccarroll 09/20/2006 - added call to check all NEOB databases*/	
	EXEC sps_CheckRegistry_DMVNEOB	
		@DOB, 
		@LastName, 
		@FirstName, 
		@MiddleName, 
		@SSN, 
		@LICENSE, 
		@StreetAddress,
		@City,
		@State,
		@Zip,
		@DMVID OUTPUT,
		@DMVDonor OUTPUT,
		@DMVDate OUTPUT,
		@DMVRecordsReturned OUTPUT,
		@DMVSource OUTPUT
	
	-- check for multiple records from dmv 
	-- IF MORE THAN 1 RECORD WAS RETURNED ASK FOR ADDITIONAL INFORMATION
	IF 	@DMVRecordsReturned > 1 
		AND
		(
		 ISNULL(@MiddleName, '') +  
		 ISNULL(@SSN, '') +
		 ISNULL(@LICENSE, '') +
		 ISNULL(@StreetAddress, '') +
		 ISNULL(@City, '') +
		 ISNULL(@State, '') +
		 ISNULL(@Zip, '') = ''		 
		)
	BEGIN
		SELECT
		'Registration Undetermined' AS 'Source',
		0 AS 'ID',
		'U' AS 'Donor' , -- U is undetermined
		'1/1/1900' AS 'Date',
		0 AS 'RestrictionID'
		
		RETURN
	END
	ELSE IF @DMVRecordsReturned > 1 
		AND
		(
		 ISNULL(@NADD,1) = 1
		OR -- BJK 05/27/03 
		 ISNULL(@MiddleName, '') +  
		 ISNULL(@SSN, '') +
		 ISNULL(@LICENSE, '') +
		 ISNULL(@StreetAddress, '') +
		 ISNULL(@City, '') +
		 ISNULL(@State, '') +
		 ISNULL(@Zip, '') <> '' 
		)
		BEGIN
			SELECT
			'Registration Undetermined' AS 'Source',
			0 AS 'ID',
			'N' AS 'Donor' , -- U is undetermined
			'1/1/1900' AS 'Date',
			0 AS 'RestrictionID'
		
			RETURN		
		END
		


	-- if all the values are null return a blank record set
	IF (ISNULL(@DMVID, '') + ISNULL(@RegistryID, '') = '' )
	
		-- no values were found
		-- return empty record st
		BEGIN
			SELECT
				'No Registration' AS 'Source',
				0 AS 'ID',
				'N' AS 'Donor' ,
				'1/1/1900' AS 'Date',
				0 AS 'RestrictionID'
				
				RETURN

		END

	
	-- check for the Oldest Date
	ELSE
		BEGIN
			IF	(ISNULL(@RegistryDate,'1/1/1900') > ISNULL(@DMVDate,'1/1/1900') )

				--Return Registry
				BEGIN
					SELECT
						'Registry' AS 'Source',
						@RegistryID AS 'ID',
						CASE @RegistryDonor WHEN 1 THEN 'Y' ELSE 'N' END AS 'Donor' ,
						@RegistryDate AS 'Date'	,
						@RestrictionID -- ADD CASE STATMENT FOR REGISTRY ID TO RETURN
						AS 'RestrictionID'
					RETURN				
				END		
			-- check if dmv is the latest date	
			ELSE IF (ISNULL(@DMVDate,'1/1/1900') > ISNULL(@RegistryDate,'1/1/1900'))
				-- Return DMV
				BEGIN
					SELECT
						--ccarroll 08/23/2006 - Pass DMV ID back as source
						@DMVSource AS 'Source',
						@DMVID AS 'ID',
						CASE @DMVDonor WHEN 1 THEN 'Y' ELSE 'N' END AS 'Donor' ,
						@DMVDate AS 'Date',
						CASE @RegistryDonor When 1 Then @RegistryID Else 0 End AS 'RestrictionID' 
					RETURN
				END
			-- check if all the values are not = N for No
			-- Both registry and dmv dates are equal, check that both = Y
			ELSE IF ( ISNULL( @DMVDonor, 1 ) <> 0 AND ISNULL( @RegistryDonor, 1 ) <> 0 )
				BEGIN
					-- if registry is not null return registry
					IF (@RegistryID IS NOT NULL)
						BEGIN
							SELECT
								'Registry' AS 'Source',
								@RegistryID AS 'ID',
								CASE @RegistryDonor WHEN 1 THEN 'Y' ELSE 'N' END AS 'Donor' ,
								@RegistryDate AS 'Date'	,
								@RestrictionID -- ADD CASE STATMENT FOR REGISTRY ID TO RETURN
								AS 'RestrictionID'
							RETURN								
						END
					ELSE 
						BEGIN 
							SELECT
								--ccarroll 08/23/2006 - Pass DMV ID back as source
								@DMVSource AS 'Source',
								@DMVID AS 'ID',
								CASE @DMVDonor WHEN 1 THEN 'Y' ELSE 'N' END AS 'Donor' ,
								@DMVDate AS 'Date',
								CASE @RegistryDonor When 1 Then @RegistryID Else 0 End AS 'RestrictionID' 
							RETURN
						
						END
				
				END
			ELSE 	-- a result cannot be determined			
				-- return empty record st
				BEGIN
					SELECT
						'Undetermined Registration' AS 'Source',
						0 AS 'ID',
						'N' AS 'Donor' ,
						'1/1/1900' AS 'Date',
						@RestrictionID AS 'RestrictionID'

						RETURN
				END			
		END




GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

/****** Object:  Stored Procedure dbo.sps_IMPORT_All_ImportArchive    Script Date: 1/11/2008 10:59:14 AM ******/

CREATE  PROCEDURE sps_IMPORT_All_ImportArchive AS
/******************************************************************************
**		File: sps_IMPORT_All_ImportArchive.sql
**		Name: sps_IMPORT_All_ImportArchive
**		Desc: 
**
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		See Above
**
**		Auth: ccarroll
**		Date: 01/04/2008 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**		01/04/2007		ccarroll				initial
*******************************************************************************/

declare @@IMPORTLOGID int
select @@IMPORTLOGID = ID
from IMPORTLOG
where upper(RunStatus) = 'LOADING'
begin transaction ARCHIVE
  insert DMVARCHIVE
  SELECT	DMV.ID, 
		DMV.ImportLogID, 
		DMV.SSN, 
		DMV.License, 
		DMV.DOB, DMV.FirstName, DMV.MiddleName, DMV.LastName, 
		DMV.Suffix, DMV.Gender, DMV.Donor, DMV.RenewalDate, 
		DMV.DeceasedDate, DMV.CSORState, DMV.CSORLicense, 
		DMV.UserID, DMV.LastModified, DMV.CreateDate,
	 	@@IMPORTLOGID, 1 
  from DMV, IMPORT
  where DMV.LICENSE = IMPORT.LICENSE
  
insert DMVARCHIVEADDR
  SELECT 
	DMVADDR.[ID], DMVADDR.[DMVID], DMVADDR.[AddrTypeID], 
	LEFT(DMVADDR.[Addr1], 40) AS 'Addr1',
	LEFT(DMVADDR.[Addr2], 20) AS 'Addr2',
	LEFT(DMVADDR.[City], 25) AS 'City',
	LEFT(DMVADDR.[State], 2) AS 'State', 
	LEFT(DMVADDR.[Zip], 10) AS 'Zip',
	DMVADDR.[UserID],
	DMVADDR.[LastModified], 
	DMVADDR.[CreateDate] 
  from DMV, DMVADDR, IMPORT
  where DMV.ID = DMVADDR.DMVID
  and   DMV.LICENSE = IMPORT.LICENSE

insert DMVARCHIVEORGAN
  SELECT
	DMVORGAN.[ID], DMVORGAN.[DMVID], DMVORGAN.[OrganTypeID], 
	DMVORGAN.[LastModified], DMVORGAN.[CreateDate] 
  from DMV, DMVORGAN, IMPORT
  where DMV.ID = DMVORGAN.DMVID
  and   DMV.LICENSE = IMPORT.LICENSE

delete from DMVORGAN
  from DMV, DMVORGAN, IMPORT
  where DMV.ID = DMVORGAN.DMVID
  and   DMV.LICENSE = IMPORT.LICENSE

delete from DMVADDR
  from DMV, DMVADDR, IMPORT
  where DMV.ID = DMVADDR.DMVID
  and   DMV.LICENSE = IMPORT.LICENSE

delete from DMV
  from DMV, IMPORT
  where DMV.LICENSE = IMPORT.LICENSE 
commit transaction ARCHIVE
CHECKPOINT



GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.sps_IMPORT_All_ImportDonor    Script Date: 1/11/2008 10:59:14 AM ******/

/****** Object:  Stored Procedure dbo.sps_IMPORT_All_ImportDonor    Script Date: 8/11/2006 10:57:46 AM ******/





CREATE PROCEDURE sps_IMPORT_All_ImportDonor AS
/*

	Desigened AND Developed 01/2003

	Legal Information...
	 ©1996-2003 Statline, LLC. All rights reserved. 

	 Statline is a registered trademark of Statline, LLC in the U.S.A. 


	 7555 East Hampden Avenue, Ste. 104, 
	 Denver, CO 80231. 
	 1-888-881-7828. 
*/
declare @ID       int, 
        @IDENTITY int, 
        @v        varchar(255)
declare @IMPORTLOGID int,
        @Addr1       varchar(255), 
        @Addr2       varchar(255),
        @City        varchar(255), 
        @State       varchar(255), 
        @Zip         varchar(255),
        @Donor       varchar(255),
        @DonorTF     bit
select @IMPORTLOGID = ID
from IMPORTLOG
where upper(RunStatus) = 'LOADING'
declare cIMPORT cursor for 
  select IMPORT.ID
  from IMPORT
open cIMPORT
fetch next from cIMPORT into @id 
while @@fetch_status = 0
  begin
    begin transaction IMPORT
    select @v = convert(varchar(255),@ID)
    print  @v
    select @DonorTF = case upper(DONOR)
                        when 'Y' then 1
                        else 0
                      end
    from IMPORT
    where IMPORT.ID = @ID;
    insert DMV ( IMPORTLOGID, SSN,  License, DOB,                 FirstName, MiddleName, LastName, Suffix, Gender, Donor,    RenewalDate,                 DeceasedDate,                       CSORState, CSORLicense, CreateDate)
    select      @IMPORTLOGID, NULL, LICENSE, CASE ISDATE(DOB)
                                               WHEN 0 THEN NULL
                                               ELSE CONVERT(datetime,DOB)
                                             END,                 FIRST,     MIDDLE,     LAST,     SUFFIX, GENDER, @DonorTF, CASE ISDATE(RENEWALDATE)
                                                                                                                               WHEN 0 THEN NULL
                                                                                                                               ELSE CONVERT(datetime,RENEWALDATE)
                                                                                                                             END,                         CASE ISDATE(DECEASEDDATE)
                                                                                                                                                            WHEN 0 THEN NULL
                                                                                                                                                            ELSE CONVERT(datetime,DECEASEDDATE)
                                                                                                                                                          END,                               CSORSTATE, CSORLICENSE, ISNULL(CREATEDATE,GETDATE())
    from IMPORT
    where IMPORT.ID = @ID;
    select @IDENTITY = @@IDENTITY
    select @Addr1     = ltrim(rtrim(AADDR1)),
           @Addr2     = NULL, 
           @City      = ltrim(rtrim(ACITY)),  
           @State     = ltrim(rtrim(ASTATE)),  
           @Zip       = ltrim(rtrim(AZIP))
    from IMPORT
    where IMPORT.ID = @ID;   
    if isnull(@Addr1,'') + isnull(@Addr2,'') + isnull(@City,'') + isnull(@State,'') + isnull(@Zip,'') <> ''
    insert DMVADDR (DMVID,      ADDRTYPEID, Addr1,  Addr2, City,  State,  Zip)
    select          @IDENTITY,  1,          AADDR1, NULL,  ACITY, ASTATE, AZIP
    from IMPORT
    where IMPORT.ID = @ID;   
    select @Addr1     = ltrim(rtrim(BADDR1)),
           @Addr2     = NULL, 
           @City      = ltrim(rtrim(BCITY)),  
           @State     = ltrim(rtrim(BSTATE)),  
           @Zip       = ltrim(rtrim(BZIP))
    from IMPORT
    where IMPORT.ID = @ID;   
    if isnull(@Addr1,'') + isnull(@Addr2,'') + isnull(@City,'') + isnull(@State,'') + isnull(@Zip,'') <> ''
    insert DMVADDR (DMVID,      ADDRTYPEID, Addr1,  Addr2, City,  State,  Zip)
    select          @IDENTITY,  2,          BADDR1, NULL,  BCITY, BSTATE, BZIP
    from IMPORT
    where IMPORT.ID = @ID;   
    select @Donor = ltrim(rtrim(DONOR))
    from IMPORT
    where IMPORT.ID = @ID;   
    if isnull(@Donor,'') <> ''
    insert DMVORGAN (DMVID, ORGANTYPEID)
    select           @IDENTITY, case ltrim(rtrim(DONOR))
                  when 'Y' then 1                   
           else 0
                                end
    from IMPORT
    where IMPORT.ID = @ID;   
    commit transaction IMPORT
    CHECKPOINT -- bjk 07/01/03 add checkpoint
    fetch next from cIMPORT into @id
  end
close cIMPORT
deallocate cIMPORT










GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.sps_IMPORT_All_ImportDonorFull    Script Date: 1/11/2008 10:59:14 AM ******/

/****** Object:  Stored Procedure dbo.sps_IMPORT_All_ImportDonorFull    Script Date: 8/11/2006 10:57:46 AM ******/

/****** Object:  Stored Procedure dbo.sps_IMPORT_All_ImportDonor    Script Date: 11/7/2005 2:20:34 PM ******/
CREATE  PROCEDURE sps_IMPORT_All_ImportDonorFull AS
/*
	Desigened AND Developed 01/2003
	Legal Information...
	 c1996-2003 Statline, LLC. All rights reserved. 
	 Statline is a registered trademark of Statline, LLC in the U.S.A. 
	 1-888-881-7828. 

	ccarroll, 07/19/2006 Changed to import to DMVtemp and DMVADDRTemp
	for full data loads.
*/
declare @ID       int, 
        @IDENTITY int, 
        @v        varchar(255)
declare @IMPORTLOGID int,
        @Addr1       varchar(255), 
        @Addr2       varchar(255),
        @City        varchar(255), 
        @State       varchar(255), 
        @Zip         varchar(255),
        @Donor       varchar(255),
        @DonorTF     bit
select @IMPORTLOGID = ID
from IMPORTLOG
where upper(RunStatus) = 'LOADING'
declare cIMPORT cursor for 
  select IMPORT.ID
  from IMPORT
open cIMPORT
fetch next from cIMPORT into @id 
while @@fetch_status = 0
  begin
    begin transaction IMPORT
    select @v = convert(varchar(255),@ID)
    print  @v
    select @DonorTF = case upper(DONOR)
                        when 'Y' then 1
                        else 0
                      end
    from IMPORT
    where IMPORT.ID = @ID;
    insert DMVTempTable ( IMPORTLOGID, SSN,  License, DOB, FirstName, MiddleName, LastName, Suffix, Gender, Donor, RenewalDate, DeceasedDate,  CSORState, CSORLicense, CreateDate)
    select      @IMPORTLOGID, NULL, LICENSE, CASE ISDATE(DOB)
                                               WHEN 0 THEN NULL
                                               ELSE CONVERT(datetime,DOB)
                                             END,        LEFT(FIRST,20), LEFT(MIDDLE,20), LEFT(LAST,25),  SUFFIX, GENDER, @DonorTF, CASE ISDATE(RENEWALDATE)

                                                                                                                                WHEN 0 THEN NULL
                                                                                                                               ELSE CONVERT(datetime,RENEWALDATE)
                                                                                                                             END,                         CASE ISDATE(DECEASEDDATE)
                                                                                                                                                            WHEN 0 THEN NULL
                                                                                                                                                            ELSE CONVERT(datetime,DECEASEDDATE)
                                                                                                                                                          END,                               CSORSTATE, CSORLICENSE, ISNULL(CREATEDATE,GETDATE())
    from IMPORT
    where IMPORT.ID = @ID;
    select @IDENTITY = @@IDENTITY
    select @Addr1     = ltrim(rtrim(AADDR1)),
           @Addr2     = NULL, 
           @City      = ltrim(rtrim(ACITY)),  
           @State     = ltrim(rtrim(ASTATE)),  
           @Zip       = ltrim(rtrim(AZIP))
    from IMPORT
    where IMPORT.ID = @ID;   
    if isnull(@Addr1,'') + isnull(@Addr2,'') + isnull(@City,'') + isnull(@State,'') + isnull(@Zip,'') <> ''
    insert DMVADDRTempTable (DMVID,      ADDRTYPEID, Addr1,  Addr2, City,  State,  Zip)
    select          @IDENTITY,  1,          AADDR1, NULL,  ACITY, ASTATE, AZIP
    from IMPORT
    where IMPORT.ID = @ID;   
    select @Addr1     = ltrim(rtrim(BADDR1)),
           @Addr2     = NULL, 
           @City      = ltrim(rtrim(BCITY)),  
           @State     = ltrim(rtrim(BSTATE)),  
           @Zip       = ltrim(rtrim(BZIP))
    from IMPORT
    where IMPORT.ID = @ID;   
    if isnull(@Addr1,'') + isnull(@Addr2,'') + isnull(@City,'') + isnull(@State,'') + isnull(@Zip,'') <> ''
    insert DMVADDRTempTable (DMVID,      ADDRTYPEID, Addr1,  Addr2, City,  State,  Zip)
    select          @IDENTITY,  2,          BADDR1, NULL,  BCITY, BSTATE, BZIP
    from IMPORT
    where IMPORT.ID = @ID;   
    select @Donor = ltrim(rtrim(DONOR))
    from IMPORT
    where IMPORT.ID = @ID;   
    if isnull(@Donor,'') <> ''
    insert DMVORGAN (DMVID, ORGANTYPEID)
    select           @IDENTITY, case ltrim(rtrim(DONOR))
                  when 'Y' then 1                   
           else 0
                                end
    from IMPORT
    where IMPORT.ID = @ID;   
    commit transaction IMPORT
    CHECKPOINT 
    fetch next from cIMPORT into @id
  end
close cIMPORT
deallocate cIMPORT



GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.sps_WebUserUpSert    Script Date: 1/11/2008 10:59:14 AM ******/

/****** Object:  Stored Procedure dbo.sps_WebUserUpSert    Script Date: 8/11/2006 10:57:46 AM ******/




/****** Object:  Stored Procedure dbo.sps_WebUserUpSert    Script Date: 5/30/03 ******/

/************************************************
	Email Error Codes

	1 --> New Email already exists
	2 --> Incorrect Login Password
	3 --> Login Email Address Incorrect

***********************************************/
CREATE PROCEDURE sps_WebUserUpSert
		@vEmail 		varchar(500)	= null,
		@vPwd			varchar(50)	= null,
		@vEmailOld 		varchar(500)	= null,
		@vPwdOld		varchar(50)	= null

AS

If @vEmailOld IS NOT NULL AND @vPwdOld IS NOT NULL
-- Update
BEGIN
	If NOT EXISTS (	SELECT WebUserID FROM WebUser WHERE Email = @vEmail)
	BEGIN
		If NOT EXISTS (	SELECT WebUserID FROM WebUser WHERE Email = @vEmailOld)
		BEGIN
			-- Print 'Email Address Incorrect'
			SELECT 0 as 'WebUserID', 0 as 'RegistryID', 0 as 'Access', 3 as 'ErrorCode'
		END
		ELSE
		BEGIN
			IF EXISTS (SELECT WebUserID FROM WebUser WHERE Email = @vEmailOld AND Pwd = @vPwdOld)
			BEGIN
				-- Update
				Update WebUser
				Set Email = @vEmail, Pwd = @vPwd
				WHERE WebUserID = 
				(
					SELECT	WebUserID
				        	FROM 		WebUser
					WHERE 	Email = @vEmailOld
					AND 		Pwd = @vPwdOld
				)
			
				SELECT 	WebUserID, RegistryID, Access, 0 as 'ErrorCode'
				FROM 		WebUser
				WHERE 	Email = @vEmail
				AND 		Pwd = @vPwd
			END
			ELSE
			BEGIN
				-- Print 'Incorrect Password'
				SELECT 0 as 'WebUserID', 0 as 'RegistryID', 0 as 'Access',  2 as 'ErrorCode'
			END
		END
	END
	ELSE
	BEGIN
		--Print 'Email already exists'
		SELECT 0 as 'WebUserID', 0 as 'RegistryID', 0 as 'Access', 1 as 'ErrorCode'
	END
END
ELSE
BEGIN
	If NOT EXISTS (	SELECT WebUserID FROM WebUser WHERE Email = @vEmail)
	BEGIN
		exec spi_WebUser @vEmail, @vPwd
		SELECT 	WebUserID, RegistryID, Access, 0 as 'ErrorCode'
		FROM 		WebUser
		WHERE 	Email = @vEmail
		AND 		Pwd = @vPwd		
	END
	ELSE
	BEGIN
		--Print 'New Email already exists'
		SELECT 0 as 'WebUserID', 0 as 'RegistryID', 0 as 'Access', 1 as 'ErrorCode'
	END
END










GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.spu_IMPORT_All_ImportOverwriteGuard    Script Date: 1/11/2008 10:59:14 AM ******/

/****** Object:  Stored Procedure dbo.spu_IMPORT_All_ImportOverwriteGuard    Script Date: 8/11/2006 10:57:46 AM ******/





CREATE PROCEDURE spu_IMPORT_All_ImportOverwriteGuard AS
/*

	Desigened AND Developed 01/2003

	Legal Information...
	 ©1996-2003 Statline, LLC. All rights reserved. 

	 Statline is a registered trademark of Statline, LLC in the U.S.A. 


	 7555 East Hampden Avenue, Ste. 104, 
	 Denver, CO 80231. 
	 1-888-881-7828. 
*/
update IMPORT
set LAST  = case isnull(ii.LAST,'')
               when '' then d.LastName
               else ii.LAST
             end,
    FIRST  = case isnull(ii.FIRST,'')
               when '' then d.FirstName
               else ii.FIRST
             end,    
    MIDDLE = case isnull(ii.MIDDLE,'')
		when '' then d.MiddleName
		else ii.MIDDLE
	     end,
    SUFFIX = case isnull(ii.SUFFIX,'')
               when '' then d.Suffix
               else ii.SUFFIX
             end,
    GENDER = case isnull(ii.GENDER,'')
               when '' then d.Gender
               else ii.GENDER
             end,
    DOB    = case isnull(ii.DOB,'')
               when '' then CONVERT(datetime,d.DOB,112)
               else ii.DOB
             end,
    RENEWALDATE = case isnull(ii.RENEWALDATE,'')
		 	when '' then D.RenewalDate
			else ii.RENEWALDATE
		  end,
   CREATEDATE = case isnull(ii.CREATEDATE,'')
			when '' then D.CreateDate
			else ii.CREATEDATE
		end
    
from IMPORT ii, DMV d
where ii.LICENSE = d.License
update IMPORT
set AADDR1 = case isnull(ii.AADDR1,'')
               when '' then a.Addr1
               else ii.AADDR1
             end,
    ACITY  = case isnull(ii.ACITY,'')
               when '' then a.City
               else ii.ACITY
             end,
    ASTATE = case isnull(ii.ASTATE,'')
               when '' then a.State
               else ii.ASTATE
             end,
    AZIP   = case isnull(ii.AZIP,'')
               when '' then a.Zip
               else ii.AZIP
             end
from IMPORT ii, DMV d, DMVADDR a
where ii.LICENSE   = d.License
and   d.ID         = a.DMVID
and   a.ADDRTYPEID = 1
update IMPORT
set BADDR1 = case isnull(ii.BADDR1,'')
               when '' then a.Addr1
               else ii.BADDR1
             end,
    BCITY  = case isnull(ii.BCITY,'')
               when '' then a.City
               else ii.BCITY
             end,
    BSTATE = case isnull(ii.BSTATE,'')
               when '' then a.State
               else ii.BSTATE
             end,
    BZIP   = case isnull(ii.BZIP,'')
               when '' then a.Zip
               else ii.BZIP
             end
from IMPORT ii, DMV d, DMVADDR a
where ii.LICENSE   = d.License
and   d.ID         = a.DMVID
and   a.ADDRTYPEID = 2
update IMPORT
set DONOR = case isnull(ii.DONOR,'')
              when '' then ot.Code
              else ii.DONOR
            end
from IMPORT ii, DMV d, DMVORGAN o, ORGANTYPE ot
where ii.LICENSE    = d.License
and   d.ID          = o.DMVID
and   o.ORGANTYPEID = ot.ID
and   o.ORGANTYPEID = 1









GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

/****** Object:  Stored Procedure dbo.spu_Import_Deletes    Script Date: 1/11/2008 10:59:14 AM ******/

/****** Object:  Stored Procedure dbo.spu_Import_Deletes    Script Date: 8/11/2006 10:57:46 AM ******/

CREATE PROCEDURE spu_Import_Deletes
AS

/* Created for MA import of deletes.  Steps through Import_deletes records, updating any existing records in DMV with matching license numbers. */

DECLARE @ID       int, 
        @IDENTITY int, 
        @v        varchar(255)

DECLARE @IMPORTLOGID int,
        @Addr1       varchar(255), 
        @Addr2       varchar(255),
        @City        varchar(255), 
        @State       varchar(255), 
        @Zip         varchar(255),
        @Donor       varchar(255),
        @DonorTF     bit,
        @matchCount Integer

-- Get the import log ID
SELECT @IMPORTLOGID = ID
	FROM ImportLog
	WHERE Upper(RunStatus) = 'LOADING';

-- Declare a cursor, opening Import_Deletes table
DECLARE cIMPORT CURSOR FOR 
	SELECT Import_Deletes.ID
		FROM Import_Deletes
OPEN cIMPORT

-- Step through Import_Deletes records
FETCH NEXT FROM cIMPORT INTO @id 

WHILE @@fetch_status = 0
      BEGIN
	BEGIN TRANSACTION IMPORT

 	SELECT @v = Convert(varchar(255),@ID)
	PRINT  @v
	-- Set the Donor variable (1 = Y, 0 = N)
	SELECT @DonorTF = CASE Upper(DONOR)
			WHEN 'Y' THEN 1
                      		ELSE 0
                      		END
    		FROM Import_Deletes
		WHERE Import_Deletes.ID = @ID; 

	-- Check for an existing record with a matching License number.
	SET @matchCount = (SELECT Count(*) FROM DMV WHERE DMV.License = (SELECT License FROM Import_Deletes WHERE Import_Deletes.ID = @ID)); 

	IF @matchCount > 0 
	     BEGIN
		-- Matching existing records found, set the donor value to 0, and update any other information
		UPDATE DMV SET
			IMPORTLOGID = @IMPORTLOGID,
			DOB = CASE ISDATE(Import_Deletes.DOB) WHEN 0 THEN NULL ELSE CONVERT(datetime,Import_Deletes.DOB) END,                 
			FirstName = Import_Deletes.First,
			MiddleName = Import_Deletes.Middle,
			LastName = Import_Deletes.Last,
			Suffix = Import_Deletes.Suffix,
			Gender = Import_Deletes.Gender,
			Donor = 0, -- Force Donor status NO
			LastModified = GetDate()
			FROM DMV
			JOIN Import_Deletes
			ON DMV.License = Import_Deletes.License
			WHERE Import_Deletes.ID = @id

		-- Delete any existing address records for found deletes
		DELETE FROM DMVAddr 
			WHERE DmvId IN
			(SELECT DMV.[ID] 
				FROM DMV JOIN Import_Deletes 
				ON DMV.License = Import_Deletes.License 
				WHERE Import_Deletes.[ID] = @id)

		-- Set @Identity variable to allow for insertion of new addresses below
		SET @IDENTITY = (SELECT TOP 1DMV.[ID] 
				FROM DMV JOIN Import_Deletes 
				ON DMV.License = Import_Deletes.License 
				WHERE Import_Deletes.[ID] = @id)

	     END

	ELSE
	     BEGIN
		-- Insert record of NO donor status
		INSERT DMV ( IMPORTLOGID, SSN,  License, DOB, FirstName, MiddleName, LastName, Suffix, Gender, Donor, RenewalDate, DeceasedDate, CSORState, CSORLicense, CreateDate)
    			SELECT @IMPORTLOGID, NULL, LICENSE, 
				CASE ISDATE(DOB)
	                                        	WHEN 0 THEN NULL
	                                        	ELSE CONVERT(datetime,DOB)
	                                        END,                 
				FIRST,  MIDDLE,  LAST, SUFFIX, GENDER, 0,  -- Force Donor status NO 
				CASE ISDATE(RENEWALDATE)
					WHEN 0 THEN NULL
					ELSE CONVERT(datetime,RENEWALDATE)
					END,                         
				CASE ISDATE(DECEASEDDATE)
					WHEN 0 THEN NULL
					ELSE CONVERT(datetime,DECEASEDDATE)
					END,                               
					CSORSTATE, CSORLICENSE, ISNULL(CREATEDATE,GETDATE())
				FROM Import_Deletes
				WHERE Import_Deletes.ID = @ID;
	
	    		SELECT @IDENTITY = @@IDENTITY;
	    END

	--Now, insert Address records, where found, whether new or updated Delete from above
	SELECT @Addr1     = ltrim(rtrim(AADDR1)),
		@Addr2     = NULL, 
	          	@City      = ltrim(rtrim(ACITY)),  
	           	@State     = ltrim(rtrim(ASTATE)),  
	           	@Zip       = ltrim(rtrim(AZIP))
	    	FROM Import_Deletes
	    	WHERE Import_Deletes.ID = @ID;   
	
	IF Isnull(@Addr1,'') + isnull(@Addr2,'') + isnull(@City,'') + isnull(@State,'') + isnull(@Zip,'') <> ''
	    	INSERT DMVADDR (DMVID,      ADDRTYPEID, Addr1,  Addr2, City,  State,  Zip)
	    		SELECT @IDENTITY,  1, AADDR1, NULL,  ACITY, ASTATE, AZIP
	    			FROM Import_Deletes
	    			WHERE Import_Deletes.ID = @ID;   
	
	-- Insert Mailing Address records, where found
	 SELECT @Addr1     = ltrim(rtrim(BADDR1)),
	           	@Addr2     = NULL, 
	          	@City      = ltrim(rtrim(BCITY)),  
	           	@State     = ltrim(rtrim(BSTATE)),  
	           	@Zip       = ltrim(rtrim(BZIP))
	    	FROM Import_Deletes
	    	WHERE Import_Deletes.ID = @ID;   
	
	    IF isnull(@Addr1,'') + isnull(@Addr2,'') + isnull(@City,'') + isnull(@State,'') + isnull(@Zip,'') <> ''
	    	INSERT DMVADDR (DMVID,      ADDRTYPEID, Addr1,  Addr2, City,  State,  Zip)
	    		SELECT  @IDENTITY,  2,  BADDR1, NULL,  BCITY, BSTATE, BZIP
				FROM Import_Deletes
	    			WHERE Import_Deletes.ID = @ID;   
	
	   -- Insert Organ Donor Records, where found
	    SELECT @Donor = ltrim(rtrim(DONOR))
	    	FROM Import_Deletes
	    	WHERE Import_Deletes.ID = @ID;   
	
	    IF isnull(@Donor,'') <> ''
	    	INSERT DMVORGAN (DMVID, ORGANTYPEID)
	    		SELECT  @IDENTITY, 
				CASE ltrim(rtrim(DONOR))
			                  	WHEN 'Y' THEN 1                   
					ELSE 0
	                                		END
				FROM Import_Deletes
	    			WHERE Import_Deletes.ID = @ID;   

	
	COMMIT TRANSACTION IMPORT;

    	CHECKPOINT -- bjk 07/01/03 add checkpoint

	FETCH NEXT FROM cIMPORT INTO @id
     END

CLOSE cIMPORT
DEALLOCATE cIMPORT
;


GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.spui_Registry    Script Date: 1/11/2008 10:59:14 AM ******/

/****** Object:  Stored Procedure dbo.spui_Registry    Script Date: 8/11/2006 10:57:46 AM ******/





CREATE PROCEDURE spui_Registry
	@pvDMVID 	AS INT 		= NULL,
	@pvLASTNAME 	AS VARCHAR(25) 	= NULL,
	@pvFIRSTNAME 	AS VARCHAR(20) 	= NULL,
	@pvMIDDLENAME	AS VARCHAR(20) 	= NULL,
	@pvGENDER 	AS VARCHAR(1) 	= NULL,
	@pvSSN 		AS VARCHAR(11) 	= NULL,
	@pvDOB 		AS SMALLDATETIME = NULL,
	@pvRACE 	AS INT 		= NULL,
	@pvRADDR	AS VARCHAR(40)	= NULL,
	@pvRCITY	AS VARCHAR(25)	= NULL,
	@pvRSTATE	AS VARCHAR(2)	= NULL,
	@pvRZIP		AS VARCHAR(10)	= NULL,
	@pvMADDR	AS VARCHAR(40)	= NULL,
	@pvMCITY	AS VARCHAR(25)	= NULL,
	@pvMSTATE	AS VARCHAR(2)	= NULL,
	@pvMZIP		AS VARCHAR(10)	= NULL,
	@pvPHONE	AS VARCHAR(10)	= NULL,
	@pvLICENSE	AS VARCHAR(9)	= NULL,
	@pvDONOR	AS VARCHAR(1)	= NULL,
	@pvDMVDONOR	AS VARCHAR(1)	= NULL,
	@pvCOMMENTS	AS VARCHAR(200)	= NULL,
	@pvSOURCECODE	AS VARCHAR(10)	= NULL,
	@pvUSERID	AS INT		= NULL,	
	@pvSIGNATUREDATE AS SMALLDATETIME= NULL,
	@pvRegistryID	AS INT		= NULL,
	@pvDonorConfirmed AS VARCHAR(1) ="0",
	@pvOnLineDate	AS SMALLDATETIME=NULL
	
AS
/*

	Desigened AND Developed 01/2003

	Legal Information...
	 ©1996-2003 Statline, LLC. All rights reserved. 

	 Statline is a registered trademark of Statline, LLC in the U.S.A. 


	 7555 East Hampden Avenue, Ste. 104, 
	 Denver, CO 80231. 
	 1-888-881-7828. 
*/
-- turn off record counts
SET NOCOUNT ON

DECLARE @CURRENTID 		AS INT,
	@CURRENTRESIDENTIALID 	AS INT,
	@CURRENTMAILINGID 	AS INT,
	@RegistryResult		AS VARCHAR(50),
	@ResidentialResult	AS VARCHAR(50),
	@MailingResult		AS VARCHAR(50)

-- clean up data
	SELECT @pvDMVID 	= CASE 	WHEN @pvDMVID = 0 THEN NULL 
					ELSE @pvDMVID 
				  END
	SELECT @pvMIDDLENAME	= CASE	WHEN @pvMIDDLENAME ='' THEN NULL 
					WHEN CHARINDEX('.',RIGHT(@pvMIDDLENAME,1)) > 0 THEN UPPER(LEFT(@pvMIDDLENAME, LEN(@pvMIDDLENAME) - 1) + REPLACE(RIGHT(@pvMIDDLENAME,1),'.',''))
					ELSE UPPER(@pvMIDDLENAME)
				  END			
	SELECT @pvLASTNAME 	= UPPER(@pvLASTNAME )
	SELECT @pvFIRSTNAME 	= UPPER(@pvFIRSTNAME )	
	SELECT @pvGENDER	= CASE @pvGENDER 
					WHEN '' THEN NULL 
					ELSE @pvGENDER 
				  END
	SELECT @pvSSN		= CASE	WHEN @pvSSN = '' THEN NULL
					ELSE @pvSSN
				  END
	SELECT @pvRACE		= CASE	WHEN @pvRACE = 0 THEN NULL
					ELSE @pvRACE
				  END
	SELECT @pvRADDR		= CASE	WHEN @pvRADDR = '' THEN NULL
					ELSE @pvRADDR
				  END
	SELECT @pvRCITY		= CASE	WHEN @pvRCITY = '' THEN NULL
					ELSE @pvRCITY
				  END
	SELECT @pvRSTATE	= CASE	WHEN @pvRSTATE = '' THEN NULL
					ELSE @pvRSTATE
				  END
	SELECT @pvRZIP		= CASE	WHEN @pvRZIP = '' THEN NULL
					ELSE @pvRZIP
				  END
	SELECT @pvMADDR		= CASE	WHEN @pvMADDR = ''THEN NULL
					ELSE @pvMADDR
				  END
	SELECT @pvMCITY		= CASE	WHEN @pvMCITY = ''THEN NULL
					ELSE @pvMCITY
				  END
	SELECT @pvMSTATE	= CASE	WHEN @pvMSTATE = '' THEN NULL
					ELSE @pvMSTATE
				  END
	SELECT @pvMZIP		= CASE	WHEN @pvMZIP = '' THEN NULL
					ELSE @pvMZIP
				  END
	SELECT @pvPHONE		= CASE	WHEN @pvPHONE = ''THEN NULL
					ELSE @pvPHONE
				  END
	SELECT @pvLICENSE	= CASE	WHEN @pvLICENSE = '' THEN NULL
					ELSE @pvLICENSE
				  END
	SELECT @pvCOMMENTS	= CASE	WHEN @pvCOMMENTS = '' THEN NULL
					ELSE @pvCOMMENTS
				  END
	SELECT @pvSOURCECODE	= CASE	WHEN @pvSOURCECODE = '' THEN NULL
					ELSE @pvSOURCECODE
				  END
	SELECT @pvUSERID	= CASE	WHEN @pvUSERID = 0 THEN NULL
					ELSE @pvUSERID
				  END
	SELECT @pvRegistryID	= CASE	WHEN @pvRegistryID = 0 THEN NULL
					ELSE @pvRegistryID
				  END

-- determine if this record is an insert or an update
IF @pvRegistryID IS NULL AND @pvDonorConfirmed = 1
BEGIN
	SELECT	@CURRENTID = R.ID 
	FROM 	Registry R
	WHERE	((DOB		LIKE @pvDOB	   OR ISNULL(@pvDOB, 	  '')='')
	AND   	(FirstName      LIKE @pvFirstName  OR ISNULL(@pvFirstName,  '')='')
	AND   	(MiddleName     LIKE @pvMiddleName OR ISNULL(@pvMiddleName, '')='')
	AND	(LastName	LIKE @pvLastName   OR ISNULL(@pvLastName,   '')=''))
END
ELSE
BEGIN
	SELECT @CURRENTID = @pvRegistryID
END
	

-- if @CURRENTID is greater than 0 updte the record
IF @CURRENTID > 0
BEGIN
	UPDATE [REGISTRY] 

	SET  
		 [SSN]	 	= @pvSSN,
		 [DOB]	 	= @pvDOB,
		 [FirstName]	= @pvFIRSTNAME,
		 [MiddleName]	= @pvMIDDLENAME,
		 [LastName]	= @pvLASTNAME,		 
		 [Gender]	= @pvGENDER,
		 [Race]	 	= @pvRACE,
		 [Phone]	= @pvPHONE,
		 [Comment]	= @pvCOMMENTS,
		 [DMVID]	= @pvDMVID,
		 [License]	= @pvLICENSE,
		 [DMVDonor]	= CAST(@pvDMVDONOR AS BIT),
		 [Donor]	= CAST(@pvDONOR AS BIT),
		 [DonorConfirmed] = @pvDonorConfirmed,
		 [SourceCode]	 = @pvSOURCECODE,
		 [SignatureDate] = @pvSIGNATUREDATE,
		 [UserID]	 = @pvUSERID
				 

	WHERE 	ID = @CURRENTID

	-- determine status of update
	IF @@ERROR = 0
	BEGIN
		SELECT @RegistryResult = 'Registry record  ' + CAST(@CURRENTID AS VARCHAR(10) ) + ' was succesfully updated'
	END
	ELSE
	BEGIN
		SELECT @RegistryResult = 'An error occured while updating record  ' + CAST(@CURRENTID AS VARCHAR(10) ) + ' '
	END

	-- import / update residential address
	EXEC SPUI_REGISTRYADDR	
		@CURRENTID,
		1,
		@pvRADDR,
		@pvRCITY,
		@pvRSTATE,
		@pvRZIP,
		@pvUSERID,
		@ResidentialResult OUTPUT
	-- import / update mailing address
	EXEC SPUI_REGISTRYADDR				
		@CURRENTID,
		2,
		@pvMADDR,
		@pvMCITY,
		@pvMSTATE,
		@pvMZIP,
		@pvUSERID,
		@MailingResult OUTPUT 	
		
END
ELSE
BEGIN

	INSERT INTO [REGISTRY] 
	( 
		 [SSN],
		 [DOB],
		 [FirstName],
		 [MiddleName],
		 [LastName],
		 [Gender],
		 [Race],		 
		 [Phone],
		 [Comment],
		 [DMVID],
		 [License],
		 [DMVDonor],
		 [Donor],
		 [DonorConfirmed],
		 [SourceCode],		 
		 [SignatureDate],
		 [UserID],
		 [CreateDate],
		 [DeleteFlag],
		 [OnlineRegDate]
	) 

	VALUES 
		(
		
		@pvSSN,
		@pvDOB,
		@pvFIRSTNAME,
		@pvMIDDLENAME,
		@pvLASTNAME,
		@pvGENDER,
		@pvRACE,
		@pvPHONE,
		@pvCOMMENTS,		
		@pvDMVID,		
		@pvLICENSE,
		CAST(@pvDMVDONOR AS BIT),
		CAST(@pvDONOR AS BIT),
		@pvDonorConfirmed,
		@pvSOURCECODE,
		@pvSIGNATUREDATE,
		@pvUSERID,
		GetDate(),
		0,
		@pvOnLineDate
		)
		
	-- determine status of update
	IF @@ERROR = 0
	BEGIN
		SELECT @CurrentID = @@IDENTITY
		SELECT @RegistryResult = 'Registry record  ' + CAST(@CurrentID AS VARCHAR(10) ) + ' was succesfully created'
	END
	ELSE
	BEGIN
		SELECT @CurrentID = @@IDENTITY
		SELECT @RegistryResult = 'An error occured while inserting record  ' + CAST(@CurrentID AS VARCHAR(10) ) + ' '
	END

		
	EXEC SPUI_REGISTRYADDR
		@CurrentID,
		1,
		@pvRADDR,
		@pvRCITY,
		@pvRSTATE,
		@pvRZIP,
		@pvUSERID,
		@ResidentialResult OUTPUT

	EXEC SPUI_REGISTRYADDR				
		@CurrentID,
		2,
		@pvMADDR,
		@pvMCITY,
		@pvMSTATE,
		@pvMZIP,
		@pvUSERID,
		@MailingResult OUTPUT
END

-- return the result fields
SELECT 
	@CurrentID 	AS 'ID',
	@RegistryResult AS 'Regisry',
	@ResidentialResult AS 'Residential',
	@MailingResult 	AS 'Mailing'














GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO

/****** Object:  Trigger dbo.sp_MSsync_upd_trig_ADDRTYPE_8    Script Date: 1/11/2008 10:59:14 AM ******/

/****** Object:  Trigger dbo.sp_MSsync_upd_trig_ADDRTYPE_8    Script Date: 8/11/2006 10:57:46 AM ******/


/****** bjk 11/21/03 Object:  Trigger dbo.sp_MSsync_upd_trig_ADDRTYPE_8    Script Date: 11/21/03 17:22:05 ******/
create trigger [sp_MSsync_upd_trig_ADDRTYPE_8] on [dbo].[ADDRTYPE] for update as  
 declare @rc int
 select @rc = @@ROWCOUNT 

 if @rc = 0 return 
 if update (msrepl_tran_version) return 
 update [dbo].[ADDRTYPE] set msrepl_tran_version = newid() from [dbo].[ADDRTYPE], inserted  
 	where 	 [dbo].[ADDRTYPE].[ID] = inserted.[ID] 
 



GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO

/****** Object:  Trigger dbo.sp_MSsync_upd_trig_ADDRTYPE_5    Script Date: 1/11/2008 10:59:14 AM ******/

/****** Object:  Trigger dbo.sp_MSsync_upd_trig_ADDRTYPE_5    Script Date: 8/11/2006 10:57:46 AM ******/

create trigger [sp_MSsync_upd_trig_ADDRTYPE_5] on [dbo].[ADDRTYPE] for update as  
 declare @rc int
 select @rc = @@ROWCOUNT 

 if @rc = 0 return 
 if update (msrepl_tran_version) return 
 update [dbo].[ADDRTYPE] set msrepl_tran_version = newid() from [dbo].[ADDRTYPE], inserted  
 	where 	 [dbo].[ADDRTYPE].[ID] = inserted.[ID] 
 


GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Trigger dbo.i_DMVARCHIVE    Script Date: 1/11/2008 10:59:14 AM ******/

/****** Object:  Trigger dbo.i_DMVARCHIVE    Script Date: 8/11/2006 10:57:46 AM ******/

CREATE TRIGGER i_DMVARCHIVE ON dbo.DMVARCHIVE 
FOR INSERT
AS
update DMVARCHIVE
set LastModified= getdate()
from DMVARCHIVE, inserted
where DMVARCHIVE.ID = inserted.ID




GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Trigger dbo.u_DMVARCHIVE    Script Date: 1/11/2008 10:59:14 AM ******/

/****** Object:  Trigger dbo.u_DMVARCHIVE    Script Date: 8/11/2006 10:57:46 AM ******/

CREATE TRIGGER u_DMVARCHIVE ON dbo.DMVARCHIVE 
FOR UPDATE
AS
update DMVARCHIVE
set LastModified = getdate()
from DMVARCHIVE, inserted
where DMVARCHIVE.ID = inserted.ID



GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Trigger dbo.i_DMVARCHIVEADDR    Script Date: 1/11/2008 10:59:14 AM ******/

/****** Object:  Trigger dbo.i_DMVARCHIVEADDR    Script Date: 8/11/2006 10:57:46 AM ******/

CREATE TRIGGER i_DMVARCHIVEADDR ON dbo.DMVARCHIVEADDR 
FOR INSERT
AS
update DMVARCHIVEADDR
set CreateDate = getdate()
from DMVARCHIVEADDR, inserted
where DMVARCHIVEADDR.ID = inserted.ID



GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Trigger dbo.u_DMVARCHIVEADDR    Script Date: 1/11/2008 10:59:14 AM ******/

/****** Object:  Trigger dbo.u_DMVARCHIVEADDR    Script Date: 8/11/2006 10:57:46 AM ******/

CREATE TRIGGER u_DMVARCHIVEADDR ON dbo.DMVARCHIVEADDR 
FOR UPDATE
AS
update DMVARCHIVEADDR
set LastModified = getdate()
from DMVARCHIVEADDR, inserted
where DMVARCHIVEADDR.ID = inserted.ID



GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Trigger dbo.i_DMVARCHIVEORGAN    Script Date: 1/11/2008 10:59:14 AM ******/

/****** Object:  Trigger dbo.i_DMVARCHIVEORGAN    Script Date: 8/11/2006 10:57:46 AM ******/

CREATE TRIGGER i_DMVARCHIVEORGAN ON [DMVARCHIVEORGAN] 
FOR INSERT
AS
update DMVARCHIVEORGAN
set CreateDate = getdate()
from DMVARCHIVEORGAN, inserted
where DMVARCHIVEORGAN.ID = inserted.ID



GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Trigger dbo.u_DMVARCHIVEORGAN    Script Date: 1/11/2008 10:59:14 AM ******/

/****** Object:  Trigger dbo.u_DMVARCHIVEORGAN    Script Date: 8/11/2006 10:57:46 AM ******/

CREATE TRIGGER u_DMVARCHIVEORGAN ON [DMVARCHIVEORGAN] 
FOR UPDATE
AS
update DMVARCHIVEORGAN
set LastModified = getdate()
from DMVARCHIVEORGAN, inserted
where DMVARCHIVEORGAN.ID = inserted.ID



GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Trigger dbo.i_IMPORTARCHIVE    Script Date: 1/11/2008 10:59:15 AM ******/

/****** Object:  Trigger dbo.i_IMPORTARCHIVE    Script Date: 8/11/2006 10:57:46 AM ******/

CREATE TRIGGER i_IMPORTARCHIVE ON dbo.IMPORTARCHIVE 
FOR INSERT
AS
update IMPORTARCHIVE
set CreateDate = getdate()
from IMPORTARCHIVE, inserted
where IMPORTARCHIVE.ID = inserted.ID



GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Trigger dbo.u_IMPORTARCHIVE    Script Date: 1/11/2008 10:59:15 AM ******/

/****** Object:  Trigger dbo.u_IMPORTARCHIVE    Script Date: 8/11/2006 10:57:46 AM ******/

CREATE TRIGGER u_IMPORTARCHIVE ON dbo.IMPORTARCHIVE 
FOR UPDATE
AS
update IMPORTARCHIVE
set LastModified = getdate()
from IMPORTARCHIVE, inserted
where IMPORTARCHIVE.ID = inserted.ID



GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Trigger dbo.i_IMPORTARCHIVE_A    Script Date: 1/11/2008 10:59:15 AM ******/

/****** Object:  Trigger dbo.i_IMPORTARCHIVE_A    Script Date: 8/11/2006 10:57:46 AM ******/

CREATE TRIGGER i_IMPORTARCHIVE_A ON dbo.IMPORTARCHIVE_A 
FOR INSERT
AS
update IMPORTARCHIVE_A
set CreateDate = getdate()
from IMPORTARCHIVE_A, inserted
where IMPORTARCHIVE_A.ID = inserted.ID



GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Trigger dbo.u_IMPORTARCHIVE_A    Script Date: 1/11/2008 10:59:15 AM ******/

/****** Object:  Trigger dbo.u_IMPORTARCHIVE_A    Script Date: 8/11/2006 10:57:46 AM ******/

CREATE TRIGGER u_IMPORTARCHIVE_A ON dbo.IMPORTARCHIVE_A 
FOR UPDATE
AS
update IMPORTARCHIVE_A
set LastModified = getdate()
from IMPORTARCHIVE_A, inserted
where IMPORTARCHIVE_A.ID = inserted.ID



GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Trigger dbo.i_IMPORTARCHIVE_B    Script Date: 1/11/2008 10:59:15 AM ******/

/****** Object:  Trigger dbo.i_IMPORTARCHIVE_B    Script Date: 8/11/2006 10:57:46 AM ******/

CREATE TRIGGER i_IMPORTARCHIVE_B ON dbo.IMPORTARCHIVE_B 
FOR INSERT
AS
update IMPORTARCHIVE_B
set CreateDate = getdate()
from IMPORTARCHIVE_B, inserted
where IMPORTARCHIVE_B.ID = inserted.ID



GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Trigger dbo.u_IMPORTARCHIVE_B    Script Date: 1/11/2008 10:59:15 AM ******/

/****** Object:  Trigger dbo.u_IMPORTARCHIVE_B    Script Date: 8/11/2006 10:57:46 AM ******/

CREATE TRIGGER u_IMPORTARCHIVE_B ON dbo.IMPORTARCHIVE_B 
FOR UPDATE
AS
update IMPORTARCHIVE_B
set LastModified = getdate()
from IMPORTARCHIVE_B, inserted
where IMPORTARCHIVE_B.ID = inserted.ID



GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Trigger dbo.i_IMPORTARCHIVE_C    Script Date: 1/11/2008 10:59:15 AM ******/

/****** Object:  Trigger dbo.i_IMPORTARCHIVE_C    Script Date: 8/11/2006 10:57:46 AM ******/

CREATE TRIGGER i_IMPORTARCHIVE_C ON dbo.IMPORTARCHIVE_C 
FOR INSERT
AS
update IMPORTARCHIVE_C
set CreateDate = getdate()
from IMPORTARCHIVE_C, inserted
where IMPORTARCHIVE_C.ID = inserted.ID



GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Trigger dbo.u_IMPORTARCHIVE_C    Script Date: 1/11/2008 10:59:15 AM ******/

/****** Object:  Trigger dbo.u_IMPORTARCHIVE_C    Script Date: 8/11/2006 10:57:46 AM ******/

CREATE TRIGGER u_IMPORTARCHIVE_C ON dbo.IMPORTARCHIVE_C 
FOR UPDATE
AS
update IMPORTARCHIVE_C
set LastModified = getdate()
from IMPORTARCHIVE_C, inserted
where IMPORTARCHIVE_C.ID = inserted.ID



GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Trigger dbo.i_IMPORTLOG    Script Date: 1/11/2008 10:59:15 AM ******/

/****** Object:  Trigger dbo.i_IMPORTLOG    Script Date: 8/11/2006 10:57:46 AM ******/

CREATE TRIGGER i_IMPORTLOG ON dbo.IMPORTLOG 
FOR INSERT
AS
update IMPORTLOG
set CreateDate = getdate()
from IMPORTLOG, inserted
where IMPORTLOG.ID = inserted.ID
update IMPORTLOG 
set RunStatus =  'CANCELLED'
from IMPORTLOG, inserted
where IMPORTLOG.RunStatus =  'LOADING'
and   IMPORTLOG.ID        <> inserted.ID
insert IMPORTLOGSTATS(ID, RAdded, RSuspended, RTotal, RUpdated, RunEnd, RunStart, RunStatus)
select ID, RecordsAdded, RecordsSuspended, RecordsTotal, RecordsUpdated, RunEnd, RunStart, RunStatus 
from inserted



GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Trigger dbo.u_IMPORTLOG    Script Date: 1/11/2008 10:59:15 AM ******/

/****** Object:  Trigger dbo.u_IMPORTLOG    Script Date: 8/11/2006 10:57:46 AM ******/

CREATE TRIGGER u_IMPORTLOG ON [IMPORTLOG] 
FOR UPDATE 
AS
update IMPORTLOG
set LastModified = getdate()
from IMPORTLOG, inserted
where IMPORTLOG.ID = inserted.ID
update IMPORTLOGSTATS
set RAdded      = i.RecordsAdded,
    RSuspended  = i.RecordsSuspended,
    RTotal      = i.RecordsTotal,
    RUpdated    = i.RecordsUpdated,
    RunEnd      = i.RunEnd,
    RunStart    = i.RunStart,
    RunStatus   = i.RunStatus
from inserted i
where IMPORTLOGSTATS.ID = i.ID



GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Trigger dbo.i_IMPORTLOGSTATS    Script Date: 1/11/2008 10:59:15 AM ******/

/****** Object:  Trigger dbo.i_IMPORTLOGSTATS    Script Date: 8/11/2006 10:57:46 AM ******/

CREATE TRIGGER i_IMPORTLOGSTATS ON [IMPORTLOGSTATS] 
FOR INSERT
AS
update IMPORTLOGSTATS
set CreateDate = getdate()
from IMPORTLOGSTATS, inserted
where IMPORTLOGSTATS.ID = inserted.ID



GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Trigger dbo.u_IMPORTLOGSTATS    Script Date: 1/11/2008 10:59:15 AM ******/

/****** Object:  Trigger dbo.u_IMPORTLOGSTATS    Script Date: 8/11/2006 10:57:46 AM ******/

CREATE TRIGGER u_IMPORTLOGSTATS ON [IMPORTLOGSTATS] 
FOR UPDATE
AS
update IMPORTLOGSTATS
set LastModified = getdate()
from IMPORTLOGSTATS, inserted
where IMPORTLOGSTATS.ID = inserted.ID



GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO

/****** Object:  Trigger dbo.sp_MSsync_upd_trig_ORGANTYPE_8    Script Date: 1/11/2008 10:59:15 AM ******/

/****** Object:  Trigger dbo.sp_MSsync_upd_trig_ORGANTYPE_8    Script Date: 8/11/2006 10:57:46 AM ******/


/****** Object:  Trigger dbo.sp_MSsync_upd_trig_ORGANTYPE_8    Script Date: 11/21/03 17:22:05 ******/
create trigger [sp_MSsync_upd_trig_ORGANTYPE_8] on [dbo].[ORGANTYPE] for update as  
 declare @rc int
 select @rc = @@ROWCOUNT 

 if @rc = 0 return 
 if update (msrepl_tran_version) return 
 update [dbo].[ORGANTYPE] set msrepl_tran_version = newid() from [dbo].[ORGANTYPE], inserted  
 	where 	 [dbo].[ORGANTYPE].[ID] = inserted.[ID] 
 



GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO

/****** Object:  Trigger dbo.sp_MSsync_upd_trig_ORGANTYPE_5    Script Date: 1/11/2008 10:59:15 AM ******/

/****** Object:  Trigger dbo.sp_MSsync_upd_trig_ORGANTYPE_5    Script Date: 8/11/2006 10:57:46 AM ******/

create trigger [sp_MSsync_upd_trig_ORGANTYPE_5] on [dbo].[ORGANTYPE] for update as  
 declare @rc int
 select @rc = @@ROWCOUNT 

 if @rc = 0 return 
 if update (msrepl_tran_version) return 
 update [dbo].[ORGANTYPE] set msrepl_tran_version = newid() from [dbo].[ORGANTYPE], inserted  
 	where 	 [dbo].[ORGANTYPE].[ID] = inserted.[ID] 
 


GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Trigger dbo.Insert_Registry    Script Date: 1/11/2008 10:59:15 AM ******/

/****** Object:  Trigger dbo.Insert_Registry    Script Date: 8/11/2006 10:57:46 AM ******/


/****** Object:  Trigger dbo.Insert_Registry    Script Date: 11/21/03 17:22:05 ******/
CREATE TRIGGER Insert_Registry ON [REGISTRY] 
FOR INSERT
AS

UPDATE REGISTRY
SET LastModified = getdate()
FROM REGISTRY, inserted
WHERE REGISTRY.ID = inserted.ID





GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Trigger dbo.Update_REGISTRY    Script Date: 1/11/2008 10:59:15 AM ******/

/****** Object:  Trigger dbo.Update_REGISTRY    Script Date: 8/11/2006 10:57:46 AM ******/


/****** Object:  Trigger dbo.Update_REGISTRY    Script Date: 11/21/03 17:22:05 ******/
CREATE TRIGGER Update_REGISTRY ON dbo.REGISTRY
FOR UPDATE
AS
 -- bjk 11/21/03 
 declare @rc int
 select @rc = @@ROWCOUNT 

 if @rc = 0 return 
 if update (msrepl_tran_version) return 
 update [dbo].[REGISTRY] set msrepl_tran_version = newid() from [dbo].[REGISTRY], inserted  
 	where 	 [dbo].[REGISTRY].[ID] = inserted.[ID] 

UPDATE REGISTRY
SET LastModified = getdate()
FROM REGISTRY, inserted
WHERE REGISTRY.ID = inserted.ID





GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Trigger dbo.Insert_REGISTRYADDR    Script Date: 1/11/2008 10:59:15 AM ******/

/****** Object:  Trigger dbo.Insert_REGISTRYADDR    Script Date: 8/11/2006 10:57:46 AM ******/


/****** Object:  Trigger dbo.Insert_REGISTRYADDR    Script Date: 11/21/03 17:22:05 ******/

CREATE TRIGGER Insert_REGISTRYADDR ON dbo.REGISTRYADDR
FOR INSERT
AS
UPDATE REGISTRYADDR
SET LastModified = getdate()
FROM REGISTRYADDR, inserted
WHERE REGISTRYADDR.ID = inserted.ID



GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Trigger dbo.Update_REGISTRYADDR    Script Date: 1/11/2008 10:59:15 AM ******/

/****** Object:  Trigger dbo.Update_REGISTRYADDR    Script Date: 8/11/2006 10:57:46 AM ******/

/****** Object:  Trigger dbo.Update_REGISTRYADDR    Script Date: 11/21/03 17:22:05 ******/
CREATE TRIGGER Update_REGISTRYADDR ON dbo.REGISTRYADDR
FOR UPDATE
AS
UPDATE REGISTRYADDR
SET LastModified = getdate()
FROM REGISTRYADDR, inserted
WHERE REGISTRYADDR.ID = inserted.ID




GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Trigger dbo.Insert_REGISTRYORGAN    Script Date: 1/11/2008 10:59:15 AM ******/

/****** Object:  Trigger dbo.Insert_REGISTRYORGAN    Script Date: 8/11/2006 10:57:46 AM ******/


CREATE TRIGGER Insert_REGISTRYORGAN ON dbo.REGISTRYORGAN
FOR INSERT
AS
UPDATE REGISTRYORGAN
SET LastModified = getdate()
FROM REGISTRYORGAN, inserted
WHERE REGISTRYORGAN.ID = inserted.ID



GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Trigger dbo.Update_REGISTRYORGAN    Script Date: 1/11/2008 10:59:15 AM ******/

/****** Object:  Trigger dbo.Update_REGISTRYORGAN    Script Date: 8/11/2006 10:57:46 AM ******/


CREATE TRIGGER Update_REGISTRYORGAN ON dbo.REGISTRYORGAN
FOR UPDATE
AS
UPDATE REGISTRYORGAN
SET LastModified = getdate()
FROM REGISTRYORGAN, inserted
WHERE REGISTRYORGAN.ID = inserted.ID




GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO

/****** Object:  Trigger dbo.sp_MSsync_upd_trig_RegistryEventSourceCodes_7    Script Date: 1/11/2008 10:59:15 AM ******/

/****** Object:  Trigger dbo.sp_MSsync_upd_trig_RegistryEventSourceCodes_7    Script Date: 8/11/2006 10:57:46 AM ******/

create trigger [sp_MSsync_upd_trig_RegistryEventSourceCodes_7] on [dbo].[RegistryEventSourceCodes] for update as  
 declare @rc int
 select @rc = @@ROWCOUNT 

 if @rc = 0 return 
 if update (msrepl_tran_version) return 
 update [dbo].[RegistryEventSourceCodes] set msrepl_tran_version = newid() from [dbo].[RegistryEventSourceCodes], inserted  
 	where 	 [dbo].[RegistryEventSourceCodes].[SourceCodeID] = inserted.[SourceCodeID] 
 


GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO

/****** Object:  Trigger dbo.sp_MSsync_upd_trig_RegistryEventSourceCodes_11    Script Date: 1/11/2008 10:59:16 AM ******/

/****** Object:  Trigger dbo.sp_MSsync_upd_trig_RegistryEventSourceCodes_11    Script Date: 8/11/2006 10:57:47 AM ******/


create trigger [sp_MSsync_upd_trig_RegistryEventSourceCodes_11] on [dbo].[RegistryEventSourceCodes] for update as  
 declare @rc int
 select @rc = @@ROWCOUNT 

 if @rc = 0 return 
 if update (msrepl_tran_version) return 
 update [dbo].[RegistryEventSourceCodes] set msrepl_tran_version = newid() from [dbo].[RegistryEventSourceCodes], inserted  
 	where 	 [dbo].[RegistryEventSourceCodes].[SourceCodeID] = inserted.[SourceCodeID] 
 



GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Trigger dbo.i_DMVORGAN    Script Date: 1/11/2008 10:59:16 AM ******/

/****** Object:  Trigger dbo.i_DMVORGAN    Script Date: 8/11/2006 10:57:47 AM ******/


/****** Object:  Trigger dbo.i_DMVORGAN    Script Date: 11/21/03 17:22:05 ******/
CREATE TRIGGER i_DMVORGAN ON [DMVORGAN] 
FOR INSERT
AS
update DMVORGAN
set CreateDate = getdate()
from DMVORGAN, inserted
where DMVORGAN.ID = inserted.ID




GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Trigger dbo.u_DMVORGAN    Script Date: 1/11/2008 10:59:16 AM ******/

/****** Object:  Trigger dbo.u_DMVORGAN    Script Date: 8/11/2006 10:57:47 AM ******/


/****** Object:  Trigger dbo.u_DMVORGAN    Script Date: 11/21/03 17:22:05 ******/
CREATE TRIGGER u_DMVORGAN ON [DMVORGAN] 
FOR UPDATE
AS
update DMVORGAN
set LastModified = getdate()
from DMVORGAN, inserted
where DMVORGAN.ID = inserted.ID




GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

