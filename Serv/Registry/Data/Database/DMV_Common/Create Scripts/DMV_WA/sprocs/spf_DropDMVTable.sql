if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spf_DropDMVTable]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
Begin
	drop procedure [dbo].[spf_DropDMVTable]
End
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO



CREATE PROCEDURE spf_DropDMVTable AS

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[DMV]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[DMV]


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/********************************* BEGIN ERROR HANDLING *********************************************/
	IF @@ERROR <> 0 
	BEGIN
	   PRINT 'spf_DropDMVTable create script failed'
	   PRINT ''
	END
	ELSE
	BEGIN
	   PRINT 'SUCCESS - 3.0 Procedure spf_DropDMVTable created'
	   PRINT ''
	END
	GO
/********************************* END ERROR HANDLING *********************************************/