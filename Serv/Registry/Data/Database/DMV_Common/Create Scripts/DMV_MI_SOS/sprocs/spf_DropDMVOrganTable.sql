if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spf_DropDMVOrganTable]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
Begin
	drop procedure [dbo].[spf_DropDMVOrganTable]
End
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO



CREATE PROCEDURE spf_DropDMVOrganTable AS

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[DMVOrgan]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[DMVOrgan]


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/********************************* BEGIN ERROR HANDLING *********************************************/
	IF @@ERROR <> 0 
	BEGIN
	   PRINT 'spf_DropDMVOrganTable create script failed'
	   PRINT ''
	END
	ELSE
	BEGIN
	   PRINT 'SUCCESS - 3.0 Procedure spf_DropDMVOrganTable created'
	   PRINT ''
	END
	GO
/********************************* END ERROR HANDLING *********************************************/