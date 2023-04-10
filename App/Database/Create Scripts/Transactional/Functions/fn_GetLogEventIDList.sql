  IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[fn_GetLogEventIDList]') AND xtype in (N'FN', N'IF', N'TF'))
	BEGIN
		PRINT 'Dropping Function fn_GetLogEventIDList'
		DROP Function fn_GetLogEventIDList
	END
GO

PRINT 'Creating Function fn_GetLogEventIDList' 
GO


CREATE FUNCTION dbo.fn_GetLogEventIDList
    (
    @vStartDateTime as datetime,
    @vEndDateTime as datetime,
    @vCreated bit,
    @vModified bit
    )
RETURNS @LogEventIDTable TABLE
    (
        LogEventID int
    )         
AS
/******************************************************************************
**        File: 
**        Name: dbo.fn_GetLogEventIDList
**        Desc: 
**
**        This function provides a list of LogEventIDs based on the provided parameters.
**        The vCreated and vModified to determine which select statment is ran. Data
**        is select by create date, last modified or both
**        Called by:  
** 
**      StatFile.Net        
**        sps_StatFileMessageEventLog.sql
**        sps_StatFileMessageEventLog.sql
**        
**
**        Auth: Bret Knoll
**        Date: 10/10/2006
*******************************************************************************
**        Change History
*******************************************************************************
**        Date:        Author:                Description:
**        --------        --------                -------------------------------------------
**    
*******************************************************************************/
BEGIN
    
        IF (@vCreated = 1 AND @vModified <> 1 )
            BEGIN
                
                INSERT 
                    @LogEventIDTable
                SELECT 
                    LogEventID 
                FROM 
                    LogEvent    
                WHERE 
                    LogEvent.LogEventDateTime >= @vStartDateTime 
                AND LogEvent.LogEventDateTime <= @vEndDateTime
            END
 
        IF (@vModified = 1 AND @vCreated <> 1 )
            BEGIN
                
                INSERT 
                    @LogEventIDTable
                SELECT 
                    LogEventID 
                FROM 
                    LogEvent    
                WHERE 
                    LogEvent.LastModified >= @vStartDateTime 
                AND LogEvent.LastModified <= @vEndDateTime
                AND NOT (LogEvent.LogEventDateTime >= @vStartDateTime 
                AND LogEvent.LogEventDateTime <= @vEndDateTime )
            END
    
        IF (@vModified = 1 AND @vCreated = 1)
            BEGIN
                INSERT 
                    @LogEventIDTable
                SELECT 
                    LogEventID 
                FROM 
                    LogEvent    
                WHERE
                    (LogEvent.LastModified >= @vStartDateTime 
                AND LogEvent.LastModified <= @vEndDateTime)
                OR (LogEvent.LogEventDateTime >= @vStartDateTime 
                AND LogEvent.LogEventDateTime <= @vEndDateTime)
            END
    RETURN
END       
		
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

