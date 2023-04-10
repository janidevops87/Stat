if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spf_CreateDMVOrganTempTable]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
Begin
	drop procedure [dbo].[spf_CreateDMVOrganTempTable]
End
GO


SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE  PROCEDURE spf_CreateDMVOrganTempTable AS

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[DMVOrganTempTable]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[DMVOrganTempTable]






CREATE TABLE [dbo].[DMVOrganTempTable] (
	[ID] [int] IDENTITY (1, 1) NOT NULL ,
	[DMVID] [int] NULL ,
	[OrganTypeID] [int] NULL ,
	[LastModified] [datetime] NULL ,
	[CreateDate] [datetime] NULL ,
) ON [PRIMARY]


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/********************************* BEGIN ERROR HANDLING *********************************************/
	IF @@ERROR <> 0 
	BEGIN
	   PRINT 'spf_CreateDMVOrganTempTable create script failed'
	   PRINT ''
	END
	ELSE
	BEGIN
	   PRINT 'SUCCESS - 3.0 Procedure spf_CreateDMVOrganTempTable created'
	   PRINT ''
	END
	GO
/********************************* END ERROR HANDLING *********************************************/