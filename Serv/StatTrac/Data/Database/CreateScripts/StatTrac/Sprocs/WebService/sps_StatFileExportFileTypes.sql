SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_StatFileExportFileTypes]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_StatFileExportFileTypes]
GO



CREATE PROCEDURE sps_StatFileExportFileTypes
--Stored proc to return the file types for statTrac.net
 AS

select exportfiletypeid as 'ID',exportfiletypename as 'Value'  from exportfiletype


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

