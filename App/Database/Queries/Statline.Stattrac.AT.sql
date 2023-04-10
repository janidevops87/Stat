PRINT '----------------------------------- Update Database: ' + DB_NAME()  + ' -----------------------------------'
-- -- -- File Manifest Created On:7/7/2016 4:13:30 PM-- -- --  
-- D:\Statline\StatTrac\Serv\Dev\StatTrac\Data\Database\CreateScripts\AudiTrail\tables\CreateTable\WebReportGroup.sql
-- D:\Statline\StatTrac\Serv\Dev\StatTrac\Data\Database\CreateScripts\AudiTrail\tables\CreateTable\WebReportGroupOrg.sql
-- D:\Statline\StatTrac\Serv\Dev\StatTrac\Data\Database\CreateScripts\AudiTrail\tables\CreateTable\WebReportGroupSourceCode.sql
-- D:\Statline\StatTrac\Serv\Dev\StatTrac\Data\Database\CreateScripts\AudiTrail\stored procedures\spd_Audit_SourceCode.sql
-- D:\Statline\StatTrac\Serv\Dev\StatTrac\Data\Database\CreateScripts\AudiTrail\stored procedures\spd_Audit_SourceCodeOrganization.sql
-- D:\Statline\StatTrac\Serv\Dev\StatTrac\Data\Database\CreateScripts\AudiTrail\stored procedures\spd_Audit_WebReportGroup.sql
-- D:\Statline\StatTrac\Serv\Dev\StatTrac\Data\Database\CreateScripts\AudiTrail\stored procedures\spd_Audit_WebReportGroupOrg.sql
-- D:\Statline\StatTrac\Serv\Dev\StatTrac\Data\Database\CreateScripts\AudiTrail\stored procedures\spd_Audit_WebReportGroupSourceCode.sql
-- D:\Statline\StatTrac\Serv\Dev\StatTrac\Data\Database\CreateScripts\AudiTrail\stored procedures\spi_Audit_SourceCode.sql
-- D:\Statline\StatTrac\Serv\Dev\StatTrac\Data\Database\CreateScripts\AudiTrail\stored procedures\spi_Audit_SourceCodeOrganization.sql
-- D:\Statline\StatTrac\Serv\Dev\StatTrac\Data\Database\CreateScripts\AudiTrail\stored procedures\spi_Audit_WebReportGroup.sql
-- D:\Statline\StatTrac\Serv\Dev\StatTrac\Data\Database\CreateScripts\AudiTrail\stored procedures\spi_Audit_WebReportGroupOrg.sql
-- D:\Statline\StatTrac\Serv\Dev\StatTrac\Data\Database\CreateScripts\AudiTrail\stored procedures\spi_Audit_WebReportGroupSourceCode.sql
-- D:\Statline\StatTrac\Serv\Dev\StatTrac\Data\Database\CreateScripts\AudiTrail\stored procedures\spu_Audit_SourceCode.sql
-- D:\Statline\StatTrac\Serv\Dev\StatTrac\Data\Database\CreateScripts\AudiTrail\stored procedures\spu_Audit_SourceCodeOrganization.sql
-- D:\Statline\StatTrac\Serv\Dev\StatTrac\Data\Database\CreateScripts\AudiTrail\stored procedures\spu_Audit_WebReportGroup.sql
-- D:\Statline\StatTrac\Serv\Dev\StatTrac\Data\Database\CreateScripts\AudiTrail\stored procedures\spu_Audit_WebReportGroupOrg.sql
-- D:\Statline\StatTrac\Serv\Dev\StatTrac\Data\Database\CreateScripts\AudiTrail\stored procedures\spu_Audit_WebReportGroupSourceCode.sql

PRINT 'D:\Statline\StatTrac\Serv\Dev\StatTrac\Data\Database\CreateScripts\AudiTrail\tables\CreateTable\WebReportGroup.sql'
GO
/****** Object:  Table [dbo].[WebReportGroup]    Script Date: 05/04/2016 14:31:12 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING OFF
GO
 
if not exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[WebReportGroup]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN
	CREATE TABLE [dbo].[WebReportGroup](
		[WebReportGroupID] [int] NOT NULL,
		[WebReportGroupName] [varchar](80) NULL,
		[OrgHierarchyParentID] [int] NULL,
		[Verified] [smallint] NULL,
		[Inactive] [smallint] NULL,
		[WebReportGroupMaster] [int] NULL,
		[LastModified] [datetime] NULL,
		[UpdatedFlag] [smallint] NULL,
		[BatchFlag] [smallint] NULL,
		[LastStatEmployeeID] [int] NULL,
		[AuditLogTypeID] [int] NULL
	) ON [PRIMARY]
END
GO

SET ANSI_PADDING OFF
GO
 


GO
PRINT 'D:\Statline\StatTrac\Serv\Dev\StatTrac\Data\Database\CreateScripts\AudiTrail\tables\CreateTable\WebReportGroupOrg.sql'
GO
/****** Object:  Table [dbo].[WebReportGroupOrg]    Script Date: 05/04/2016 14:35:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

if not exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[WebReportGroupOrg]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN
	CREATE TABLE [dbo].[WebReportGroupOrg](
	[WebReportGroupOrgID] [int] NOT NULL,
	[ReportID] [int] NULL,
	[WebReportGroupID] [int] NULL,
	[OrganizationID] [int] NULL,
	[PersonID] [int] NULL,
	[LastModified] [datetime] NULL,
	[UpdatedFlag] [smallint] NULL,
	[LastStatEmployeeID] [int] NULL,
	[AuditLogTypeID] [int] NULL
	) ON [PRIMARY]
END
GO





GO
PRINT 'D:\Statline\StatTrac\Serv\Dev\StatTrac\Data\Database\CreateScripts\AudiTrail\tables\CreateTable\WebReportGroupSourceCode.sql'
GO
/****** Object:  Table [dbo].[WebReportGroupSourceCodee]    Script Date: 05/04/2016 14:35:37 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

if not exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[WebReportGroupSourceCode]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN
	CREATE TABLE [dbo].[WebReportGroupSourceCode](
		[WebReportGroupSourceCodeID] [int] NOT NULL,
		[WebReportGroupID] [int] NULL,
		[SourceCodeID] [int] NULL,
		[LastModified] [smalldatetime] NULL,
		[AccessOrgans] [smallint] NULL,
		[AccessBone] [smallint] NULL,
		[AccessTissue] [smallint] NULL,
		[AccessSkin] [smallint] NULL,
		[AccessValves] [smallint] NULL,
		[AccessEyes] [smallint] NULL,
		[AccessResearch] [smallint] NULL,
		[AccessOrgansUpdate] [smallint] NULL,
		[AccessBoneUpdate] [smallint] NULL,
		[AccessTissueUpdate] [smallint] NULL,
		[AccessSkinUpdate] [smallint] NULL,
		[AccessValvesUpdate] [smallint] NULL,
		[AccessEyesUpdate] [smallint] NULL,
		[AccessResearchUpdate] [smallint] NULL,
		[AccessTypeOTE] [smallint] NULL,
		[AccessTypeTE] [smallint] NULL,
		[AccessTypeEOnly] [smallint] NULL,
		[AccessTypeRuleout] [smallint] NULL,
		[UpdatedFlag] [smallint] NULL
	) ON [PRIMARY]

END
GO

 


GO
PRINT 'D:\Statline\StatTrac\Serv\Dev\StatTrac\Data\Database\CreateScripts\AudiTrail\stored procedures\spd_Audit_SourceCode.sql'
GO
SET QUOTED_IDENTIFIER ON 
GO 
SET ANSI_NULLS ON  
GO 
 if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spd_Audit_SourceCode]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
    drop procedure [dbo].[spd_Audit_SourceCode] 
GO  
/****** Object:  StoredProcedure [dbo].[spd_Audit_SourceCode]    Script Date: 05/02/2016 15:57:10 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


create procedure [dbo].[spd_Audit_SourceCode]
	@pkc1 int
as

BEGIN
DECLARE @UpdateFlag int 
SET @UpdateFlag = 4;

insert into dbo.[SourceCode]
( 
	[SourceCodeID]	 
	,[LastModified]	 		 
	,[AuditLogTypeID]
)

values	
( 
	 @pkc1	
	,GETDATE()
	,@UpdateFlag 
)
END

GO



GO
PRINT 'D:\Statline\StatTrac\Serv\Dev\StatTrac\Data\Database\CreateScripts\AudiTrail\stored procedures\spd_Audit_SourceCodeOrganization.sql'
GO
SET QUOTED_IDENTIFIER ON 
GO 
SET ANSI_NULLS ON  
GO 
 if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spd_Audit_SourceCodeOrganization]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
    drop procedure [dbo].[spd_Audit_SourceCodeOrganization] 
GO  

/****** Object:  StoredProcedure [dbo].[spd_Audit_SourceCodeOrganization]    Script Date: 05/02/2016 15:57:10 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


create procedure [dbo].[spd_Audit_SourceCodeOrganization]
	@pkc1 int
as

BEGIN
DECLARE @UpdateFlag int 
SET @UpdateFlag = 4;

insert into dbo.SourceCodeOrganization
( 
	[SourceCodeOrganizationID]	 
	,[LastModified]	 		 
	,[UpdatedFlag]
)

values	
( 
	 @pkc1	
	,GETDATE()
	,@UpdateFlag 
)
END

GO



GO
PRINT 'D:\Statline\StatTrac\Serv\Dev\StatTrac\Data\Database\CreateScripts\AudiTrail\stored procedures\spd_Audit_WebReportGroup.sql'
GO
SET QUOTED_IDENTIFIER ON 
GO 
SET ANSI_NULLS ON  
GO 
 if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spd_Audit_WebReportGroup]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
    drop procedure [dbo].[spd_Audit_WebReportGroup] 
GO  
/****** Object:  StoredProcedure [dbo].[spd_Audit_WebReportGroup]    Script Date: 05/02/2016 15:57:10 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


create procedure [dbo].[spd_Audit_WebReportGroup]
	@pkc1 int
as

BEGIN
DECLARE @UpdateFlag int 
SET @UpdateFlag = 4;

insert into dbo.[WebReportGroup]
( 
	[WebReportGroupID]	 
	,[LastModified]	 		 
	,[UpdatedFlag]
)

values	
( 
	 @pkc1	
	,GETDATE()
	,@UpdateFlag 
)
END

GO



GO
PRINT 'D:\Statline\StatTrac\Serv\Dev\StatTrac\Data\Database\CreateScripts\AudiTrail\stored procedures\spd_Audit_WebReportGroupOrg.sql'
GO
SET QUOTED_IDENTIFIER ON 
GO 
SET ANSI_NULLS ON  
GO 
 if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spd_Audit_WebReportGroupOrg]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
    drop procedure [dbo].[spd_Audit_WebReportGroupOrg] 
GO  

/****** Object:  StoredProcedure [dbo].[spd_Audit_WebReportGroupOrg]    Script Date: 05/02/2016 15:57:10 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


create procedure [dbo].[spd_Audit_WebReportGroupOrg]
	@pkc1 int
as

BEGIN
DECLARE @UpdateFlag int 
SET @UpdateFlag = 4;

insert into dbo.[WebReportGroupOrg]
( 
	[WebReportGroupOrgID]	 
	,[LastModified]	 		 
	,[UpdatedFlag]
)

values	
( 
	 @pkc1	
	,GETDATE()
	,@UpdateFlag 
)
END


GO

GO
PRINT 'D:\Statline\StatTrac\Serv\Dev\StatTrac\Data\Database\CreateScripts\AudiTrail\stored procedures\spd_Audit_WebReportGroupSourceCode.sql'
GO
SET QUOTED_IDENTIFIER ON 
GO 
SET ANSI_NULLS ON  
GO 
 if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spd_Audit_WebReportGroupSourceCode]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
    drop procedure [dbo].[spd_Audit_WebReportGroupSourceCode] 
GO  

/****** Object:  StoredProcedure [dbo].[spd_Audit_WebReportGroupSourceCode]    Script Date: 05/02/2016 15:57:10 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


create procedure [dbo].[spd_Audit_WebReportGroupSourceCode]
	@pkc1 int
as

BEGIN
DECLARE @UpdateFlag int 
SET @UpdateFlag = 4;

insert into dbo.[WebReportGroupSourceCode]
( 
	[WebReportGroupSourceCodeID]	 
	,[LastModified]	 		 
	,[UpdatedFlag]
)

values	
( 
	 @pkc1	
	,GETDATE()
	,@UpdateFlag 
)
END
GO



GO
PRINT 'D:\Statline\StatTrac\Serv\Dev\StatTrac\Data\Database\CreateScripts\AudiTrail\stored procedures\spi_Audit_SourceCode.sql'
GO
SET QUOTED_IDENTIFIER ON 
GO 
SET ANSI_NULLS ON  
GO 
 if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Audit_SourceCode]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
    drop procedure [dbo].[spi_Audit_SourceCode] 
GO  

/****** Object:  StoredProcedure [dbo].[spi_Audit_SourceCode]    Script Date: 05/02/2016 11:13:50 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


create procedure [dbo].[spi_Audit_SourceCode] 
	@SourceCodeName  varchar(10)
	,@SourceCodeDescription  varchar(200)
	,@LastModified  datetime
	,@SourceCodeType  int
	,@SourceCodeDefaultAlert  nvarchar(max)
	,@SourceCodeLineCheckInstruc  varchar(255)
	,@SourceCodeLineCheckInterval  int
	,@SourceCode1Start  varchar(5)
	,@SourceCode1End  varchar(5)
	,@SourceCode2Start  varchar(5)
	,@SourceCode2End  varchar(5)
	,@SourceCode3Start  varchar(5)
	,@SourceCode3End  varchar(5)
	,@SourceCode4Start  varchar(5)
	,@SourceCode4End  varchar(5)
	,@SourceCode5Start  varchar(5)
	,@SourceCode5End  varchar(5)
	,@SourceCode6Start  varchar(5)
	,@SourceCode6End  varchar(5)
	,@SourceCode7Start  varchar(5)
	,@SourceCode7End  varchar(5)
	,@SourceCodeDisabledInterval  smallint
	,@SourceCodeNameUnAbbrev  varchar(100)
	,@SourceCodeRotationActive  smallint
	,@SourcecodeRotationAlias  varchar(50)
	,@SourcecodeRotationTrue  smallint
	,@SourcecodeDonorTracClient  smallint
	,@SourceCodeDefault  bit
	,@Inactive  bit
	,@LastStatEmployeeID  int
	,@AuditLogTypeID  int
	,@SourceCodeOrgID  int
	,@SourceCodeCallTypeID  int

AS
BEGIN


insert into dbo.[SourceCode]
( 
	[SourceCodeName]
	,[SourceCodeDescription]
	,[LastModified]
	,[SourceCodeType]
	,[SourceCodeDefaultAlert]
	,[SourceCodeLineCheckInstruc]
	,[SourceCodeLineCheckInterval]
	,[SourceCode1Start]
	,[SourceCode1End]
	,[SourceCode2Start]
	,[SourceCode2End]
	,[SourceCode3Start]
	,[SourceCode3End]
	,[SourceCode4Start]
	,[SourceCode4End]
	,[SourceCode5Start]
	,[SourceCode5End]
	,[SourceCode6Start]
	,[SourceCode6End]
	,[SourceCode7Start]
	,[SourceCode7End]
	,[SourceCodeDisabledInterval]
	,[SourceCodeNameUnAbbrev]
	,[SourceCodeRotationActive]
	,[SourcecodeRotationAlias]
	,[SourcecodeRotationTrue]
	,[SourcecodeDonorTracClient]
	,[SourceCodeDefault]
	,[Inactive]
	,[LastStatEmployeeID]
	,[AuditLogTypeID]
	,[SourceCodeOrgID]
	,[SourceCodeCallTypeID]
)

values	
( 
	@SourceCodeName
	,@SourceCodeDescription
	,@LastModified
	,@SourceCodeType
	,@SourceCodeDefaultAlert
	,@SourceCodeLineCheckInstruc
	,@SourceCodeLineCheckInterval
	,@SourceCode1Start
	,@SourceCode1End
	,@SourceCode2Start
	,@SourceCode2End
	,@SourceCode3Start
	,@SourceCode3End
	,@SourceCode4Start
	,@SourceCode4End
	,@SourceCode5Start
	,@SourceCode5End
	,@SourceCode6Start
	,@SourceCode6End
	,@SourceCode7Start
	,@SourceCode7End
	,@SourceCodeDisabledInterval
	,@SourceCodeNameUnAbbrev
	,@SourceCodeRotationActive
	,@SourcecodeRotationAlias
	,@SourcecodeRotationTrue
	,@SourcecodeDonorTracClient
	,@SourceCodeDefault
	,@Inactive
	,@LastStatEmployeeID
	,@AuditLogTypeID
	,@SourceCodeOrgID
	,@SourceCodeCallTypeID
)


END
GO



GO
PRINT 'D:\Statline\StatTrac\Serv\Dev\StatTrac\Data\Database\CreateScripts\AudiTrail\stored procedures\spi_Audit_SourceCodeOrganization.sql'
GO
SET QUOTED_IDENTIFIER ON 
GO 
SET ANSI_NULLS ON  
GO 
 if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Audit_SourceCodeOrganization]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
    drop procedure [dbo].[spi_Audit_SourceCodeOrganization] 
GO  

/****** Object:  StoredProcedure [dbo].[spi_Audit_SourceCodeOrganization]    Script Date: 05/02/2016 11:13:50 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


create procedure [dbo].[spi_Audit_SourceCodeOrganization] 
	@SourceCodeOrganizationID int	 
	,@SourceCodeID varchar(80)	 
	,@OrganizationId int	 
	,@LastModified datetime	 	
	,@UpdatedFlag smallint	 
	,@LastStatEmployeeID int
	,@AuditLogTypeID int

AS
BEGIN


insert into dbo.[SourceCodeOrganization]
( 
	[SourceCodeOrganizationID] 	 
	,[SourceCodeID]  	 
	,[OrganizationId]  
	,[LastModified]  	
	,[UpdatedFlag] 	 
	,[LastStatEmployeeID]  
	,[AuditLogTypeID] 
)

values	
( 
	@SourceCodeOrganizationID 	 
	,@SourceCodeID  	 
	,@OrganizationId  
	,@LastModified  	
	,@UpdatedFlag 	 
	,@LastStatEmployeeID  
	,@AuditLogTypeID 
)


END


GO



GO
PRINT 'D:\Statline\StatTrac\Serv\Dev\StatTrac\Data\Database\CreateScripts\AudiTrail\stored procedures\spi_Audit_WebReportGroup.sql'
GO
SET QUOTED_IDENTIFIER ON 
GO 
SET ANSI_NULLS ON  
GO 
 if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Audit_WebReportGroup]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
    drop procedure [dbo].[spi_Audit_WebReportGroup] 
GO  

/****** Object:  StoredProcedure [dbo].[spi_Audit_WebReportGroup]    Script Date: 05/02/2016 11:13:50 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


create procedure [dbo].[spi_Audit_WebReportGroup] 
	@WebReportGroupID int,	 
	@WebReportGroupName varchar(80),	 
	@OrgHierarchyParentID int,
	@Verified smallint,
	@Inactive smallint,
	@WebReportGroupMaster int,
	@LastModified datetime,	 	
	@UpdatedFlag smallint,
	@BatchFlag smallint,	 
	@LastStatEmployeeID int,
	@AuditLogTypeID int

AS
BEGIN


insert into dbo.[WebReportGroup]
( 
	[WebReportGroupID]
	,[WebReportGroupName]
	,[OrgHierarchyParentID]
	,[Verified]
	,[Inactive]
	,[WebReportGroupMaster]
	,[LastModified]
	,[UpdatedFlag]
	,[BatchFlag]	 
	,[LastStatEmployeeID]
	,[AuditLogTypeID]	
)

values	
( 
	@WebReportGroupID 	 
	,@WebReportGroupName  	 
	,@OrgHierarchyParentID 
	,@Verified  
	,@Inactive  
	,@WebReportGroupMaster 
	,@LastModified   	
	,@UpdatedFlag 
	,@BatchFlag  	 
	,@LastStatEmployeeID  
	,@AuditLogTypeID  
)


END


GO



GO
PRINT 'D:\Statline\StatTrac\Serv\Dev\StatTrac\Data\Database\CreateScripts\AudiTrail\stored procedures\spi_Audit_WebReportGroupOrg.sql'
GO
SET QUOTED_IDENTIFIER ON 
GO 
SET ANSI_NULLS ON  
GO 
 if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Audit_WebReportGroupOrg]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
    drop procedure [dbo].[spi_Audit_WebReportGroupOrg] 
GO 

/****** Object:  StoredProcedure [dbo].[spi_Audit_WebReportGroupOrg]    Script Date: 05/02/2016 11:13:50 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


create procedure [dbo].[spi_Audit_WebReportGroupOrg] 
	@WebReportGroupOrgID int,
	@ReportId int,
	@WebReportGroupID int,
	@OrganizationId int,
	@PersonId int,
	@LastModified datetime,
	@UpdatedFlag smallint,
	@LastStatEmployeeID int,
	@AuditLogTypeID int

AS
BEGIN


insert into dbo.[WebReportGroupOrg]
( 
	[WebReportGroupOrgID]
	,[ReportId]
	,[WebReportGroupID]
	,[OrganizationId]
	,[PersonId]	 
	,[LastModified]
	,[UpdatedFlag] 
	,[LastStatEmployeeID]
	,[AuditLogTypeID]	
)

values	
( 
	@WebReportGroupOrgID 
	,@ReportId 
	,@WebReportGroupID 
	,@OrganizationId 
	,@PersonId 
	,@LastModified 
	,@UpdatedFlag 
	,@LastStatEmployeeID 
	,@AuditLogTypeID 
)


END


GO



GO
PRINT 'D:\Statline\StatTrac\Serv\Dev\StatTrac\Data\Database\CreateScripts\AudiTrail\stored procedures\spi_Audit_WebReportGroupSourceCode.sql'
GO
SET QUOTED_IDENTIFIER ON 
GO 
SET ANSI_NULLS ON  
GO 
 if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Audit_WebReportGroupSourceCode]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
    drop procedure [dbo].[spi_Audit_WebReportGroupSourceCode] 
GO  

/****** Object:  StoredProcedure [dbo].[spi_Audit_WebReportGroupSourceCode]    Script Date: 05/02/2016 11:13:50 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


create procedure [dbo].[spi_Audit_WebReportGroupSourceCode] 
	@WebReportGroupSoureCodeId int,
	@WebReportGroupID int,	 
	@SourceCodeId int,	 	 
	@LastModified datetime,	 	
	@AccessOrgans smallint,
	@AccessBone smallint,
	@AccessTissue smallint,
	@AccessSkin smallint,
	@AccessValves smallint,
	@AccessEyes smallint,
	@AccessResearch smallint,
	@AccessOrgansUpdate smallint,
	@AccessBoneUpdate smallint,
	@AccessTissueUpdate smallint,
	@AccessSkinUpdate smallint,
	@AccessValvesUpdate smallint,
	@AccessEyesUpdate smallint,
	@AccessResearchUpdate smallint,
	@AccessTypeOTE smallint,
	@AccessTypeTE smallint,
	@AccessTypeEOnly smallint,
	@AccessTypeRuleOut smallint,
	@UpdatedFlag smallint	 		

AS
BEGIN

IF @LastModified IS NULL
BEGIN
	SELECT @LastModified = GetDate()
END

insert into dbo.[WebReportGroupSourceCode]
( 
	[WebReportGroupSourceCodeID]
	,[WebReportGroupID]	 
	,[SourceCodeId]	 	 
	,[LastModified]	 	
	,[AccessOrgans]
	,[AccessBone]
	,[AccessTissue]
	,[AccessSkin]
	,[AccessValves]
	,[AccessEyes]
	,[AccessResearch]
	,[AccessOrgansUpdate]
	,[AccessBoneUpdate]
	,[AccessTissueUpdate]
	,[AccessSkinUpdate]
	,[AccessValvesUpdate]
	,[AccessEyesUpdate]
	,[AccessResearchUpdate]
	,[AccessTypeOTE]
	,[AccessTypeTE]
	,[AccessTypeEOnly]
	,[AccessTypeRuleout]
	,[UpdatedFlag]
)

values	
( 
	@WebReportGroupSoureCodeId
	,@WebReportGroupID  
	,@SourceCodeId 
	,@LastModified 
	,@AccessOrgans 
	,@AccessBone 
	,@AccessTissue 
	,@AccessSkin 
	,@AccessValves 
	,@AccessEyes 
	,@AccessResearch 
	,@AccessOrgansUpdate 
	,@AccessBoneUpdate 
	,@AccessTissueUpdate 
	,@AccessSkinUpdate 
	,@AccessValvesUpdate
	,@AccessEyesUpdate 
	,@AccessResearchUpdate 
	,@AccessTypeOTE 
	,@AccessTypeTE
	,@AccessTypeEOnly 
	,@AccessTypeRuleOut 
	,@UpdatedFlag 
)


END


GO



GO
PRINT 'D:\Statline\StatTrac\Serv\Dev\StatTrac\Data\Database\CreateScripts\AudiTrail\stored procedures\spu_Audit_SourceCode.sql'
GO
SET QUOTED_IDENTIFIER ON 
GO 
SET ANSI_NULLS ON  
GO 
 if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_Audit_SourceCode]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
    drop procedure [dbo].[spu_Audit_SourceCode] 
GO  
create procedure "spu_Audit_SourceCode" 
(
	@SourceCodeId int
	,@SourceCodeName  varchar(10)
	,@SourceCodeDescription  varchar(200)
	,@LastModified  datetime
	,@SourceCodeType  int
	,@SourceCodeDefaultAlert  nvarchar(max)
	,@SourceCodeLineCheckInstruc  varchar(255)
	,@SourceCodeLineCheckInterval  int
	,@SourceCode1Start  varchar(5)
	,@SourceCode1End  varchar(5)
	,@SourceCode2Start  varchar(5)
	,@SourceCode2End  varchar(5)
	,@SourceCode3Start  varchar(5)
	,@SourceCode3End  varchar(5)
	,@SourceCode4Start  varchar(5)
	,@SourceCode4End  varchar(5)
	,@SourceCode5Start  varchar(5)
	,@SourceCode5End  varchar(5)
	,@SourceCode6Start  varchar(5)
	,@SourceCode6End  varchar(5)
	,@SourceCode7Start  varchar(5)
	,@SourceCode7End  varchar(5)
	,@SourceCodeDisabledInterval  smallint
	,@SourceCodeNameUnAbbrev  varchar(100)
	,@SourceCodeRotationActive  smallint
	,@SourcecodeRotationAlias  varchar(50)
	,@SourcecodeRotationTrue  smallint
	,@SourcecodeDonorTracClient  smallint
	,@SourceCodeDefault  bit
	,@Inactive  bit
	,@LastStatEmployeeID  int
	,@AuditLogTypeID  int
	,@SourceCodeOrgID  int
	,@SourceCodeCallTypeID  int
	,@pkc1 int
	,@Bitmap binary(3) 
) 
AS 
IF NOT (SUBSTRING(@Bitmap, 1, 1) & 2 <> 2 --WebReportGroupID 
AND SUBSTRING(@Bitmap, 1, 1) & 4 <> 4 --SourceCodeId 
AND SUBSTRING(@Bitmap, 1, 1) & 8 <> 8 --LastModified 
AND SUBSTRING(@Bitmap, 1, 1) & 16 <> 16 --AccessOrgans 
AND SUBSTRING(@Bitmap, 1, 1) & 32 <> 32 --AccessBone 
AND SUBSTRING(@Bitmap, 1, 1) & 64 <> 64 --AccessTissue 
AND SUBSTRING(@Bitmap, 1, 1) & 128 <> 128 --AccessSkin 
AND SUBSTRING(@Bitmap, 2, 1) & 1 <> 1 --AccessValves 
AND SUBSTRING(@Bitmap, 2, 1) & 2 <> 2 --AccessResearch 
AND SUBSTRING(@Bitmap, 2, 1) & 4 <> 4 --AccessOrgansUpdate 
AND SUBSTRING(@Bitmap, 2, 1) & 8 <> 8 --AccessBoneUpdate 
AND SUBSTRING(@Bitmap, 2, 1) & 16 <> 16 --AccessTissueUpdate 
AND SUBSTRING(@Bitmap, 2, 1) & 32 <> 32 --AccessSkinUpdate 
AND SUBSTRING(@Bitmap, 2, 1) & 64 <> 64 --AccessEyesUpdate 
AND SUBSTRING(@Bitmap, 2, 1) & 128 <> 128 --AccessResearchUpdate 
AND SUBSTRING(@Bitmap, 3, 1) & 1 <> 1 --AccessTypeOTE 
AND SUBSTRING(@Bitmap, 3, 1) & 2 <> 2 --AccessTypeTE 
AND SUBSTRING(@Bitmap, 3, 1) & 4 <> 4 --AccessTypeEOnly 
AND SUBSTRING(@Bitmap, 3, 1) & 8 <> 8 --AccessRuleOut 
AND SUBSTRING(@Bitmap, 3, 1) & 16 <> 16 --UpdatedFlag  
) 
BEGIN 

SELECT TOP 1
	@LastModified = ISNULL(@LastModified, LastModified),
	@LastStatEmployeeID = ISNULL(@LastStatEmployeeID, LastStatEmployeeID),
	@auditLogTypeID = ISNULL(@AuditLogTypeID, AuditLogTypeID)	 
FROM
	SourceCodeOrganization
WHERE 
	SourceCodeOrganizationID = @pkc1
ORDER BY
	LastModified DESC
	
insert into SourceCode
(
	[SourceCodeId]
	,[SourceCodeName]
	,[SourceCodeDescription]
	,[LastModified]
	,[SourceCodeType]
	,[SourceCodeDefaultAlert]
	,[SourceCodeLineCheckInstruc]
	,[SourceCodeLineCheckInterval]
	,[SourceCode1Start]
	,[SourceCode1End]
	,[SourceCode2Start]
	,[SourceCode2End]
	,[SourceCode3Start]
	,[SourceCode3End]
	,[SourceCode4Start]
	,[SourceCode4End]
	,[SourceCode5Start]
	,[SourceCode5End]
	,[SourceCode6Start]
	,[SourceCode6End]
	,[SourceCode7Start]
	,[SourceCode7End]
	,[SourceCodeDisabledInterval]
	,[SourceCodeNameUnAbbrev]
	,[SourceCodeRotationActive]
	,[SourcecodeRotationAlias]
	,[SourcecodeRotationTrue]
	,[SourcecodeDonorTracClient]
	,[SourceCodeDefault]
	,[Inactive]
	,[LastStatEmployeeID]
	,[AuditLogTypeID]
	,[SourceCodeOrgID]
	,[SourceCodeCallTypeID]
) 
Values 
(
 @PKC1, 
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 2 = 2 AND ISNULL(@SourceCodeName, '') = '' THEN 'ILB' ELSE @SourceCodeName END,
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 4 = 4 AND ISNULL(@SourceCodeDescription, '') = '' THEN 'ILB'  ELSE @SourceCodeDescription END,
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 8 = 8 AND ISNULL(@LastModified, '') = '' THEN '01/01/1900' ELSE  @LastModified END,
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 16 = 16 AND ISNULL(@SourceCodeType,   0) = 0 THEN -2 ELSE @SourceCodeType END,
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 32 = 32 AND ISNULL(@SourceCodeDefaultAlert, '') = '' THEN 'ILB' ELSE @SourceCodeDefaultAlert END,
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 64 = 64 AND ISNULL(@SourceCodeLineCheckInstruc,  '') = '' THEN 'ILB' ELSE @SourceCodeLineCheckInstruc END,
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 128 = 128 AND ISNULL(@SourceCodeLineCheckInterval,  0) = 0 THEN -2 ELSE @SourceCodeLineCheckInterval END,
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 1 = 1 AND ISNULL(@SourceCode1Start, '') = '' THEN 'ILB' ELSE @SourceCode1Start END,
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 2 = 2 AND ISNULL(@SourceCode1End, '') = '' THEN 'ILB' ELSE @SourceCode1End END,
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 4 = 4 AND ISNULL(@SourceCode2Start, '') = '' THEN 'ILB' ELSE @SourceCode2Start END,
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 8 = 8 AND ISNULL(@SourceCode2End, '') = '' THEN 'ILB' ELSE @SourceCode2End END,
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 16 = 16 AND ISNULL(@SourceCode3Start, '') = '' THEN 'ILB' ELSE @SourceCode3Start END,
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 32 = 32 AND ISNULL(@SourceCode3End, '') = '' THEN 'ILB' ELSE @SourceCode3End END,
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 64 = 64 AND ISNULL(@SourceCode4Start, '') = '' THEN 'ILB' ELSE @SourceCode4Start END,
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 128 = 128 AND ISNULL(@SourceCode4End, '') = '' THEN 'ILB' ELSE @SourceCode4End END,
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 1 = 1 AND ISNULL(@SourceCode5Start,  '') = '' THEN 'ILB' ELSE @SourceCode5Start END,
CASE WHEN SUBSTRING(@Bitmap, 3, 1) & 2 = 2 AND ISNULL(@SourceCode5End,   '') = '' THEN 'ILB' ELSE @SourceCode5End END,
CASE WHEN SUBSTRING(@Bitmap, 3, 1) & 4 = 4 AND ISNULL(@SourceCode6Start,  '') = '' THEN 'ILB' ELSE @SourceCode6Start END,
CASE WHEN SUBSTRING(@Bitmap, 3, 1) & 8 = 8 AND ISNULL(@SourceCode6End,   '') = '' THEN 'ILB' ELSE @SourceCode6End END,
CASE WHEN SUBSTRING(@Bitmap, 3, 1) & 16 = 16  AND ISNULL(@SourceCode7Start,  '') = '' THEN 'ILB' ELSE @SourceCode7Start END,
CASE WHEN SUBSTRING(@Bitmap, 3, 1) & 32 = 32 AND ISNULL(@SourceCode7End,  '') = '' THEN 'ILB' ELSE @SourceCode7End END, 
CASE WHEN SUBSTRING(@Bitmap, 3, 1) & 64 = 64 AND ISNULL(@SourceCodeDisabledInterval,  0) = 0 THEN -2 ELSE @SourceCodeDisabledInterval END, 
CASE WHEN SUBSTRING(@Bitmap, 3, 1) & 128 = 128 AND ISNULL(@SourceCodeNameUnAbbrev, '') = '' THEN 'ILB' ELSE @SourceCodeNameUnAbbrev END,
CASE WHEN SUBSTRING(@Bitmap, 3, 1) & 1 = 1 AND ISNULL(@SourceCodeRotationActive,    0) = 0 THEN -2 ELSE @SourceCodeRotationActive END,
CASE WHEN SUBSTRING(@Bitmap, 4, 1) & 2 = 2 AND ISNULL(@SourcecodeRotationAlias,  '') = '' THEN 'ILB'  ELSE @SourcecodeRotationAlias END,
CASE WHEN SUBSTRING(@Bitmap, 4, 1) & 4 = 4 AND ISNULL(@SourcecodeRotationTrue, 0) = 0 THEN -2  ELSE @SourcecodeRotationTrue END,
CASE WHEN SUBSTRING(@Bitmap, 4, 1) & 8 = 8 AND ISNULL(@SourcecodeDonorTracClient, 0) = 0 THEN -2 ELSE @SourcecodeDonorTracClient END,
CASE WHEN SUBSTRING(@Bitmap, 4, 1) & 16 = 16 THEN @SourceCodeDefault ELSE NULL END,
CASE WHEN SUBSTRING(@Bitmap, 4, 1) & 32 = 32 THEN @Inactive ELSE NULL END,
CASE WHEN SUBSTRING(@Bitmap, 4, 1) & 64 = 64 AND ISNULL(@LastStatEmployeeID, 0) = 0 THEN -2 ELSE @LastStatEmployeeID END,
CASE WHEN SUBSTRING(@Bitmap, 4, 1) & 128 = 128 AND ISNULL(@AuditLogTypeID, 0) = 0 THEN -2 ELSE @AuditLogTypeID END,
CASE WHEN SUBSTRING(@Bitmap, 5, 1) & 1 = 1 AND ISNULL(@SourceCodeOrgID, 0) = 0 THEN -2 ELSE @SourceCodeOrgID END,
CASE WHEN SUBSTRING(@Bitmap, 5, 1) & 2 = 2 AND ISNULL(@SourceCodeCallTypeID, 0) = 0 THEN -2 ELSE @SourceCodeCallTypeID END
) 
 END 
 GO 
 SET QUOTED_IDENTIFIER OFF 
 GO 
 SET ANSI_NULLS ON 
 GO 
GO
PRINT 'D:\Statline\StatTrac\Serv\Dev\StatTrac\Data\Database\CreateScripts\AudiTrail\stored procedures\spu_Audit_SourceCodeOrganization.sql'
GO
SET QUOTED_IDENTIFIER ON 
GO 
SET ANSI_NULLS ON  
GO 
 if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_Audit_SourceCodeOrganization]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
    drop procedure [dbo].[spu_Audit_SourceCodeOrganization] 
GO  
create procedure "spu_Audit_SourceCodeOrganization" 
(
	@SourceCodeOrganizationID int	 
	,@SourceCodeID varchar(80)	 
	,@OrganizationId int	 
	,@LastModified datetime	 	
	,@UpdatedFlag smallint	 
	,@LastStatEmployeeID int
	,@AuditLogTypeID int
	,@pkc1 int
	,@bitmap binary(3) 
) 
AS 
IF NOT ( SUBSTRING(@Bitmap, 1, 1) & 2 <> 2 -- SourceCodeOrganizationID
AND SUBSTRING(@Bitmap, 1, 1) & 4 <> 4 -- SourceCodeID
AND SUBSTRING(@Bitmap, 1, 1) & 8 <> 8 -- OrganizationId
AND SUBSTRING(@Bitmap, 1, 1) & 16 <> 16 -- LastModified
AND SUBSTRING(@Bitmap, 1, 1) & 32 <> 32 -- UpdatedFlag
AND SUBSTRING(@Bitmap, 1, 1) & 64 <> 64 -- LastStatEmployeeID
AND SUBSTRING(@Bitmap, 1, 1) & 128 <> 128 -- AuditLogTypeID
) 
BEGIN 

SELECT TOP 1
	@LastModified = ISNULL(@LastModified, LastModified),
	@LastStatEmployeeID = ISNULL(@LastStatEmployeeID, LastStatEmployeeID),
	@auditLogTypeID = ISNULL(@AuditLogTypeID, AuditLogTypeID)	 
FROM
	SourceCodeOrganization
WHERE 
	SourceCodeOrganizationID = @pkc1
ORDER BY
	LastModified DESC
	
insert into SourceCodeOrganization
(
	[SourceCodeOrganizationID] 	 
	,[SourceCodeID]  	 
	,[OrganizationId]  
	,[LastModified]  	
	,[UpdatedFlag] 	 
	,[LastStatEmployeeID]  
	,[AuditLogTypeID] 
) 
Values 
(
@pkc1 
,CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 2 = 2 AND ISNULL(@SourceCodeID,  '') = '' THEN 'ILB' ELSE @SourceCodeID END
,CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 4 = 4 AND ISNULL(@OrganizationId, 0) = 0 THEN -2 ELSE @OrganizationId END
,CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 8 = 8 AND ISNULL(@LastModified, '') = '' THEN '01/01/1900' ELSE @LastModified END
,CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 16 = 16 AND ISNULL(@UpdatedFlag, 0) = 0 THEN -2 ELSE @UpdatedFlag END
,CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 32 = 32 AND ISNULL(@LastStatEmployeeID, 0) = 0 THEN -2 ELSE @LastStatEmployeeID END
,CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 64 = 64 AND ISNULL(@AuditLogTypeID, 0) = 0 THEN -2  ELSE @AuditLogTypeID END
) 
 END 
 GO 
 SET QUOTED_IDENTIFIER OFF 
 GO 
 SET ANSI_NULLS ON 
 GO 

GO
PRINT 'D:\Statline\StatTrac\Serv\Dev\StatTrac\Data\Database\CreateScripts\AudiTrail\stored procedures\spu_Audit_WebReportGroup.sql'
GO
drop  procedure "spu_Audit_WebReportGroup" 
go
create procedure "spu_Audit_WebReportGroup" 
(
	@WebReportGroupID int	 
	,@WebReportGroupName varchar(80)	 
	,@OrgHeirarchyParentId int
	,@Verified smallint
	,@Inactive smallint
	,@WebReportGroupMaster int
	,@LastModified datetime	 	
	,@UpdatedFlag smallint
	,@BatchFlag smallint	 
	,@LastStatEmployeeID int
	,@AuditLogTypeID int
	,@pkc1 int
	,@bitmap binary(3) 
) 
AS 

SELECT TOP 1
	@LastModified = ISNULL(@LastModified, LastModified),
	@LastStatEmployeeID = ISNULL(@LastStatEmployeeID, LastStatEmployeeID),
	@auditLogTypeID = ISNULL(@AuditLogTypeID, AuditLogTypeID)	 	 
FROM
	WebReportGroup
WHERE 
	WebReportGroupID = @pkc1
ORDER BY
	LastModified DESC
	
IF NOT ( SUBSTRING(@Bitmap, 1, 1) & 2 <> 2 -- WebReportGroupID
AND SUBSTRING(@Bitmap, 1, 1) & 4 <> 4 -- WebReportGroupName
AND SUBSTRING(@Bitmap, 1, 1) & 8 <> 8 -- OrgHeirarchyParentId
AND SUBSTRING(@Bitmap, 1, 1) & 16 <> 16 -- Verified
AND SUBSTRING(@Bitmap, 1, 1) & 32 <> 32 -- Inactive
AND SUBSTRING(@Bitmap, 1, 1) & 64 <> 64 -- WebReportGroupMaster
AND SUBSTRING(@Bitmap, 1, 1) & 128 <> 128 -- LastModified
AND SUBSTRING(@Bitmap, 2, 1) & 1 <> 1 -- UpdatedFlag
AND SUBSTRING(@Bitmap, 2,
 1) & 2 <> 2 -- BatchFlag
AND SUBSTRING(@Bitmap, 2, 1) & 4 <> 4 -- AuditLogTypeID 
) 
BEGIN 

insert into WebReportGroup
(
	[WebReportGroupID]
	,[WebReportGroupName]
	,[OrgHierarchyParentID]
	,[Verified]
	,[Inactive]
	,[WebReportGroupMaster]
	,[LastModified]
	,[UpdatedFlag]
	,[BatchFlag]	 
	,[LastStatEmployeeID]
	,[AuditLogTypeID]	
) 
Values 
(
@pkc1
,CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 2 = 2 AND ISNULL(@WebReportGroupName, '') = '' THEN 'ILB' ELSE @WebReportGroupName END
,CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 4 = 4 AND ISNULL(@OrgHeirarchyParentId, 0) = 0 THEN -2 
ELSE @OrgHeirarchyParentId END
,CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 8 = 8 AND ISNULL(@Verified, 0) = 0 THEN -2 ELSE @Verified END
,CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 16 = 16 AND ISNULL(@Inactive, '') = '' THEN -2 ELSE @Inactive END
,CASE WHEN SUBSTRING
(@Bitmap, 1, 1) & 32 = 32 AND ISNULL(@WebReportGroupMaster, 0) = 0 THEN -2 ELSE @WebReportGroupMaster END
,CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 64 = 64 AND ISNULL(@LastModified, '') = '' THEN '01/01/1900' ELSE @LastModified END
,CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 128 = 128 AND ISNULL(@UpdatedFlag, '') = '' THEN -2 ELSE @UpdatedFlag END
,CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 1 = 1 AND ISNULL(@BatchFlag, 0) = 0 THEN -2 ELSE @BatchFlag END
,CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 2 = 2 AND ISNULL(@LastStatEmployeeID, 0) = 0 THEN -2 ELSE @LastStatEmployeeID END
,CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 4 = 4  AND ISNULL(@AuditLogTypeID, 0) = 0 THEN -2 ELSE @AuditLogTypeID END 
) 
 END 



GO
PRINT 'D:\Statline\StatTrac\Serv\Dev\StatTrac\Data\Database\CreateScripts\AudiTrail\stored procedures\spu_Audit_WebReportGroupOrg.sql'
GO
SET QUOTED_IDENTIFIER ON 
GO 
SET ANSI_NULLS ON  
GO 
 if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_Audit_WebReportGroupOrg]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
    drop procedure [dbo].[spu_Audit_WebReportGroupOrg] 
GO  
create procedure "spu_Audit_WebReportGroupOrg" 
(
	@WebReportGroupOrgID int
	,@ReportId int
	,@WebReportGroupID int
	,@OrganizationId int
	,@PersonId int
	,@LastModified datetime
	,@UpdatedFlag smallint
	,@LastStatEmployeeID int
	,@AuditLogTypeID int
	,@pkc1 int
	,@bitmap binary(3) 
) 
AS 
IF NOT ( SUBSTRING(@Bitmap, 1, 1) & 2 <> 2 -- WebReportGroupOrgID
AND SUBSTRING(@Bitmap, 1, 1) & 4 <> 4 -- ReportId
AND SUBSTRING(@Bitmap, 1, 1) & 8 <> 8 -- WebReportGroupID
AND SUBSTRING(@Bitmap, 1, 1) & 16 <> 16 -- OrganizationId
AND SUBSTRING(@Bitmap, 1, 1) & 32 <> 32 -- PersonId
AND SUBSTRING(@Bitmap, 1, 1) & 64 <> 64 -- LastModified
AND SUBSTRING(@Bitmap, 1, 1) & 128 <> 128 -- UpdatedFlag
AND SUBSTRING(@Bitmap, 2, 1) & 1 <> 1 -- LastStatEmployeeID
AND SUBSTRING(@Bitmap, 2, 1) & 2 <> 2 -- BatchFlag
AND SUBSTRING(@Bitmap, 2, 1) & 4 <> 4 -- AuditLogTypeID 
) 
BEGIN 

SELECT TOP 1
	@LastModified = ISNULL(@LastModified, LastModified),
	@WebReportGroupID = ISNULL(@WebReportGroupID, WebReportGroupID)	  
FROM
	WebReportGroupOrg
WHERE 
	WebReportGroupOrgID = @pkc1
ORDER BY
	LastModified DESC
	
insert into WebReportGroupOrg
(
	[WebReportGroupOrgID]
	,[ReportId]
	,[WebReportGroupID]
	,[OrganizationId]
	,[PersonId]	 
	,[LastModified]
	,[UpdatedFlag] 
	,[LastStatEmployeeID]
	,[AuditLogTypeID]	
) 
Values 
(
@pkc1
,CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 2 = 2 AND ISNULL(@ReportId, 0) = 0 THEN -2 ELSE @ReportId END
,CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 4 = 4 AND ISNULL(@WebReportGroupID, 0) = 0 THEN -2 ELSE @WebReportGroupID END
,CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 8 = 8 AND ISNULL(@OrganizationId, 0) = 0 THEN -2 ELSE @OrganizationId END
,CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 16 = 16 AND ISNULL(@PersonId, 0) = 0 THEN -2 ELSE @PersonId END
,CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 32 = 32 AND ISNULL(@LastModified, '') = '' THEN '01/01/1900' ELSE @LastModified END
,CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 64 = 64 AND ISNULL(@UpdatedFlag, 0) = 0 THEN -2 ELSE @UpdatedFlag END
,CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 128 = 128 AND ISNULL(@LastStatEmployeeID,  0) = 0 THEN -2 ELSE @LastStatEmployeeID END
,CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 1 = 1 AND ISNULL(@AuditLogTypeID, 0) = 0 THEN -2 ELSE @AuditLogTypeID END 
) 
 END 
 GO 
 SET QUOTED_IDENTIFIER OFF 
 GO 
 SET ANSI_NULLS ON 
 GO 

GO
PRINT 'D:\Statline\StatTrac\Serv\Dev\StatTrac\Data\Database\CreateScripts\AudiTrail\stored procedures\spu_Audit_WebReportGroupSourceCode.sql'
GO
SET QUOTED_IDENTIFIER ON 
GO 
SET ANSI_NULLS ON  
GO 
 if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_Audit_WebReportGroupSourceCode]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
    drop procedure [dbo].[spu_Audit_WebReportGroupSourceCode] 
GO  
create procedure "spu_Audit_WebReportGroupSourceCode" 
(
	@WebReportGroupSourceCodeId int
	,@WebReportGroupID int	 
	,@SourceCodeId int	 	 
	,@LastModified datetime	 	
	,@AccessOrgans smallint
	,@AccessBone smallint
	,@AccessTissue smallint
	,@AccessSkin smallint
	,@AccessValves smallint
	,@AccessEyes smallint
	,@AccessResearch smallint
	,@AccessOrgansUpdate smallint
	,@AccessBoneUpdate smallint
	,@AccessTissueUpdate smallint
	,@AccessSkinUpdate smallint
	,@AccessValvesUpdate smallint
	,@AccessEyesUpdate smallint
	,@AccessResearchUpdate smallint
	,@AccessTypeOTE smallint
	,@AccessTypeTE smallint
	,@AccessTypeEOnly smallint
	,@AccessTypeRuleout smallint
	,@UpdatedFlag smallint	 	
	,@pkc1 int
	,@Bitmap binary(3) 
) 
AS 
IF NOT (SUBSTRING(@Bitmap, 1, 1) & 2 <> 2 --WebReportGroupID 
AND SUBSTRING(@Bitmap, 1, 1) & 4 <> 4 --SourceCodeId 
AND SUBSTRING(@Bitmap, 1, 1) & 8 <> 8 --LastModified 
AND SUBSTRING(@Bitmap, 1, 1) & 16 <> 16 --AccessOrgans 
AND SUBSTRING(@Bitmap, 1, 1) & 32 <> 32 --AccessBone 
AND SUBSTRING(@Bitmap, 1, 1) & 64 <> 64 --AccessTissue 
AND SUBSTRING(@Bitmap, 1, 1) & 128 <> 128 --AccessSkin 
AND SUBSTRING(@Bitmap, 2, 1) & 1 <> 1 --AccessValves 
AND SUBSTRING(@Bitmap, 2, 1) & 2 <> 2 --AccessResearch 
AND SUBSTRING(@Bitmap, 2, 1) & 4 <> 4 --AccessOrgansUpdate 
AND SUBSTRING(@Bitmap, 2, 1) & 8 <> 8 --AccessBoneUpdate 
AND SUBSTRING(@Bitmap, 2, 1) & 16 <> 16 --AccessTissueUpdate 
AND SUBSTRING(@Bitmap, 2, 1) & 32 <> 32 --AccessSkinUpdate 
AND SUBSTRING(@Bitmap, 2, 1) & 64 <> 64 --AccessValvesUpdate 
AND SUBSTRING(@Bitmap, 2, 1) & 128 <> 128 --AccessEyesUpdate  
AND SUBSTRING(@Bitmap, 3, 1) & 1 <> 1 --AccessResearchUpdate  
AND SUBSTRING(@Bitmap, 3, 1) & 2 <> 2 --AccessTypeOTE 
AND SUBSTRING(@Bitmap, 3, 1) & 4 <> 4 --AccessTypeTE
AND SUBSTRING(@Bitmap, 3, 1) & 8 <> 8 --AccessTypeEOnly  
AND SUBSTRING(@Bitmap, 3, 1) & 16 <> 16 --AccessTypeRuleout  
AND SUBSTRING(@Bitmap, 3, 1) & 32 <> 32 --UpdatedFlag  

) 
BEGIN 

SELECT TOP 1
	@LastModified = ISNULL(@LastModified, GETDATE()),
	@SourceCodeId = ISNULL(@SourceCodeId, SourceCodeId)	  
FROM
	WebReportGroupSourceCode
WHERE 
	WebReportGroupSourceCodeID = @pkc1
ORDER BY
	LastModified DESC
	
insert into WebReportGroupSourceCode
(
	[WebReportGroupSourceCodeId]
	,[WebReportGroupID]	 
	,[SourceCodeId]	 	 
	,[LastModified]	 	
	,[AccessOrgans]
	,[AccessBone]
	,[AccessTissue]
	,[AccessSkin]
	,[AccessValves]
	,[AccessEyes]
	,[AccessResearch]
	,[AccessOrgansUpdate]
	,[AccessBoneUpdate]
	,[AccessTissueUpdate]
	,[AccessSkinUpdate]
	,[AccessValvesUpdate]
	,[AccessEyesUpdate]
	,[AccessResearchUpdate]
	,[AccessTypeOTE]
	,[AccessTypeTE]
	,[AccessTypeEOnly]
	,[AccessTypeRuleout]
	,[UpdatedFlag]
) 
Values 
(
@pkc1,
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 2 = 2 AND ISNULL(@WebReportGroupID, 0) = 0 THEN -2 ELSE @WebReportGroupID END,
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 2 = 2 AND ISNULL(@SourceCodeId, '') = '' THEN '01/01/1900'  ELSE @SourceCodeId END,
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 4 = 4 AND ISNULL(@LastModified,  0) = 0 THEN -2 ELSE @LastModified END,
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 8 = 8 AND ISNULL(@AccessOrgans, 0) = 0 THEN -2 ELSE @AccessOrgans END,
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 16 = 16 AND ISNULL(@AccessBone, 0) = 0 THEN -2 ELSE @AccessBone END,
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 32 = 32 AND ISNULL(@AccessTissue, 0) = 0 THEN -2 ELSE @AccessTissue END,
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 64 = 64 AND ISNULL(@AccessSkin, 0) = 0 THEN -2 ELSE @AccessSkin END,
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 128 = 128 AND ISNULL(@AccessValves, 0) = 0 THEN -2 ELSE @AccessValves END,
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 1 = 1 AND ISNULL(@AccessEyes, 0) = 0 THEN -2 ELSE @AccessEyes END,
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 2 = 2 AND ISNULL(@AccessResearch, 0) = 0 THEN -2 ELSE @AccessResearch END,
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 4 = 4 AND ISNULL(@AccessOrgansUpdate,  0) = 0 THEN -2 ELSE @AccessOrgansUpdate END,
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 8 = 8 AND ISNULL(@AccessBoneUpdate,  0) = 0 THEN -2 ELSE @AccessBoneUpdate END,
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 16 = 16 AND ISNULL(@AccessTissueUpdate,  0) = 0 THEN -2 ELSE @AccessTissueUpdate END,
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 32 = 32 AND ISNULL(@AccessSkinUpdate,  0) = 0 THEN -2 ELSE @AccessSkinUpdate END,
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 64 = 64 AND ISNULL(@AccessValvesUpdate,  0) = 0 THEN -2 ELSE @AccessValvesUpdate END,
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 128 = 128 AND ISNULL(@AccessEyesUpdate,  0) = 0 THEN -2 ELSE @AccessEyesUpdate END,
CASE WHEN SUBSTRING(@Bitmap, 3, 1) & 1 = 1 AND ISNULL(@AccessResearchUpdate,  0) = 0 THEN -2 ELSE @AccessResearchUpdate END,
CASE WHEN SUBSTRING(@Bitmap, 3, 1) & 2 = 2 AND ISNULL(@AccessTypeOTE,  0) = 0 THEN -2 ELSE @AccessTypeOTE END,
CASE WHEN SUBSTRING(@Bitmap, 3, 1) & 4 = 4 AND ISNULL(@AccessTypeTE,  0) = 0 THEN -2 ELSE @AccessTypeTE END,
CASE WHEN SUBSTRING(@Bitmap, 3, 1) & 8 = 8 AND ISNULL(@AccessTypeEOnly,  0) = 0 THEN -2 ELSE @AccessTypeEOnly END,
CASE WHEN SUBSTRING(@Bitmap, 3, 1) & 16 = 16 AND ISNULL(@AccessTypeRuleout,  0) = 0 THEN -2 ELSE @AccessTypeRuleout END, 
CASE WHEN SUBSTRING(@Bitmap, 3, 1) & 32 = 32 AND ISNULL(@UpdatedFlag,  0) = 0 THEN -2 ELSE @UpdatedFlag END 
) 
 END 
 GO 
 SET QUOTED_IDENTIFIER OFF 
 GO 
 SET ANSI_NULLS ON 
 GO 

GO
