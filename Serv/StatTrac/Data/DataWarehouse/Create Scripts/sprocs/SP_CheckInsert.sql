SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SP_CheckInsert]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SP_CheckInsert]
GO


CREATE PROCEDURE SP_CheckInsert
	@CMD VARCHAR(50) = NULL,
	@DB  VARCHAR(50) = NULL
as


SELECT * FROM MASTER..SYSPROCESSES WHERE CMD = @CMD and dbid = DB_ID(@DB)


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

