SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_GetServerDB]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_GetServerDB]
GO

CREATE PROCEDURE sps_GetServerDB 

AS

SELECT @@ServerName as 'Server_Name', DB_NAME(db_id()) AS 'DB_Name'

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

