if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spf_DropDMVADDRTable]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
Begin
	drop procedure [dbo].[spf_DropDMVADDRTable]
End
go


SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO



CREATE PROCEDURE spf_DropDMVADDRTable AS

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[DMVADDR]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[DMVADDR]


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


/********************************* BEGIN ERROR HANDLING *********************************************/
	IF @@ERROR <> 0 
	BEGIN
	   PRINT 'spf_DropDMVADDRTable - Failure'
	   PRINT ''
	END
	ELSE
	BEGIN
	   PRINT 'SUCCESS - 3.0 Procedure spf_DropDMVADDRTable created'
	   PRINT ''
	END
	GO
/********************************* END ERROR HANDLING *********************************************/