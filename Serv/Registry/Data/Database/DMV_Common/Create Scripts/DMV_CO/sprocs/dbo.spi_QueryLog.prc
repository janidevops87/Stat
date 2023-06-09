SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.spi_QueryLog    Script Date: 5/14/2007 10:02:40 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_QueryLog]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spi_QueryLog]
GO


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

