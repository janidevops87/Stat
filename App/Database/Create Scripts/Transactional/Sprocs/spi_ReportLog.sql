SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_ReportLog]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spi_ReportLog]
GO






/****** Object:  Stored Procedure dbo.spi_ReportLog    Script Date: 2/24/99 1:12:44 AM ******/
CREATE PROCEDURE spi_ReportLog

	@vDateTime	datetime	= null,
	@vReportID	int		= null,
	@vWebPersonID	int		= null,
	@vRemoteAddress	varchar(20)	= null,
	@vQueryString	varchar(200)	= null

AS

	INSERT ReportLog (ReportLogDateTime, ReportID, WebPersonID, ReportLogRemoteAddress, ReportLogQueryString, LastModified)
	
	VALUES (@vDateTime, @vReportID, @vWebPersonID, @vRemoteAddress, @vQueryString, GetDate())




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

