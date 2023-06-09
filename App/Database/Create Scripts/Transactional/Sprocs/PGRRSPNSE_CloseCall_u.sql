SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[PGRRSPNSE_CloseCall_u]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[PGRRSPNSE_CloseCall_u]
GO

CREATE PROCEDURE PGRRSPNSE_CloseCall_u @CallID      INT,
                                       @PagerEmail  VARCHAR(255),
                                       @CurrentDate DATETIME AS

DECLARE @@UPDATEROWs INT

UPDATE LogEvent 
SET LogEventCallbackPending = 0
FROM LogEvent le, PersonPhone pp, Phone p
WHERE pp.PhoneID              = p.PhoneID
AND   pp.PersonID             = le.PersonID
AND   p.PhoneTypeID           = 8                       --  Pager(Auto Response)
AND   le.LogEventTypeID       = 6                       --  Page Pending
AND   pp.PhoneAlphaPagerEmail = @PagerEmail
AND   le.CallID               = @CallID

SELECT @@UPDATEROWs = @@ROWCOUNT

INSERT INTO LogEvent(CallID,    LogEventTypeID, LogEventName,    LogEventPhone,    LogEventOrg,    LogEventDesc,               StatEmployeeID, LogEventDateTime, LogEventCallbackPending, OrganizationID,    ScheduleGroupID,    PersonID,    PhoneID, LogEventContactConfirmed, LogEventCalloutDateTime) 
SELECT TOP 1         le.CallID, 9,              le.LogEventName, le.LogEventPhone, le.LogEventOrg, 'AUTOMATED PAGER RESPONSE', 375,            @CurrentDate,     0,                       le.OrganizationID, le.ScheduleGroupID, le.PersonID, 0,       1,                        NULL
FROM LogEvent le, PersonPhone pp, Phone p
WHERE pp.PhoneID              = p.PhoneID
AND   pp.PersonID             = le.PersonID
AND   p.PhoneTypeID           = 8                       --  Pager(Auto Response)
AND   le.LogEventTypeID       = 6                       --  Page Pending
AND   pp.PhoneAlphaPagerEmail = @PagerEmail
AND   le.CallID               = @CallID
ORDER BY LogEventID DESC

RETURN @@UPDATEROWs


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

