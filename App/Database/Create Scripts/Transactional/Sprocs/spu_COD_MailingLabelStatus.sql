SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_COD_MailingLabelStatus]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spu_COD_MailingLabelStatus]
GO


CREATE PROCEDURE spu_COD_MailingLabelStatus
			@sourceCode varchar(7)
AS

SET NOCOUNT ON

DECLARE 	@currentMonth	varchar(2),
		@currentDay	varchar(2),
		@currentYear	varchar(4),
		@currentHour	varchar(2),
		@currentDate 	varchar(20)

SET @currentMonth =  DATEPART(mm,GetDate())
SET @currentDay = DATEPART(dd,GetDate())
SET @currentYear = DATEPART(yyyy,GetDate())
SET @currentHour = DATEPART(hh,GetDate())  - 1 

SET @currentDate = @currentYear + '-' + @currentMonth + '-' + @currentDay + ' ' + @currentHour + ':00:00'

UPDATE CODCaller
SET CODCallerLabelStatus = '2'
FROM CODCaller a
JOIN Call d ON (d.CallID = a.CallID)
JOIN SourceCode e ON (e.SourceCodeID = d.SourceCodeID)
WHERE a.CODCallerLabelStatus = 1
AND e.SourceCodeName = @sourceCode
AND d.CallDateTime < CONVERT(varchar(20),@currentDate, 20)

SET NOCOUNT OFF
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

