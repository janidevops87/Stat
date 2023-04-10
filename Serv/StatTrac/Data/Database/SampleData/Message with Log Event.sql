DECLARE @CallID int
INSERT INTO Call (CallNumber, CallTypeID, CallDateTime, StatEmployeeID, CallTotalTime, CallSeconds, CallTemp, SourceCodeID, CallOpenByID, CallTempExclusive, CallTempSavedByID, RecycleNCFlag, CallActive, CallSaveLastByID, CallExtension) VALUES (NULL,2, GetDate(),45,'00:00:00',0,0,44,-1,-1,-1,1,0,45,3333)

SET @CallID = SCOPE_IDENTITY()
PRINT @CallID
INSERT INTO Message (CallID, MessageCallerName, MessageCallerPhone, MessageCallerOrganization, OrganizationID, PersonID, MessageTypeID, MessageUrgent, MessageDescription, MessageExtension, MessageImportPatient, MessageImportUNOSID, MessageImportCenter) VALUES (@CallID,'Sally Alcantara','(303) 691-3363',NULL,0,0,0,-1,NULL,NULL,NULL,NULL,NULL)

UPDATE Call SET CallOpenByID = -1 WHERE Call.CallID = @CallID

INSERT INTO LogEvent (CallID, LogEventTypeID, LogEventName, LogEventPhone, LogEventOrg, LogEventDesc, StatEmployeeID, LogEventDateTime, LogEventCallbackPending, OrganizationID, ScheduleGroupID, PersonID, PhoneID, LogEventContactConfirmed, LogEventCalloutDateTime, LogEventNumber) VALUES (@CallID,1,NULL,NULL,NULL,'test note',45,GetDate(),0,0,0,0,0,0,NULL,NULL)

UPDATE Call SET CallNumber = CONVERT(VARCHAR(10),@CallID) + '-45',CallTypeID = 2,CallDateTime = '5/16/2007 4:54:00 PM',StatEmployeeID = 45,CallTotalTime = '00:02:00',CallSeconds = 120,CallTemp = -1,SourceCodeID = 44,CallOpenByID = -1,CallTempExclusive = -1,CallTempSavedByID = 45,RecycleNCFlag = -1,CallActive = -1,CallSaveLastByID = 45 WHERE CallID = 6054451

UPDATE Message SET CallID = @CallID,MessageCallerName = 'Sally Alcantara',MessageCallerPhone = '(303) 691-3363',MessageCallerOrganization = 'Baltimore Washington Memorial Hospital',OrganizationID = 50,PersonID = 830322,MessageTypeID = 3,MessageUrgent = 0,MessageDescription = 'This is a test message. 1',MessageExtension = NULL,MessageImportPatient = NULL,MessageImportUNOSID = NULL,MessageImportCenter = NULL WHERE CallID = @CallID


INSERT INTO LogEvent (CallID, LogEventTypeID, LogEventName, LogEventPhone, LogEventOrg, LogEventDesc, StatEmployeeID, LogEventDateTime, LogEventCallbackPending, OrganizationID, ScheduleGroupID, PersonID, PhoneID, LogEventContactConfirmed, LogEventCalloutDateTime, LogEventNumber) VALUES (@CallID,2,'Sally Alcantara',NULL,'Baltimore Washington Memorial Hospital','Recorded message information.',45, GetDate(),0,-1,-1,-1,-1,0,NULL,NULL)

UPDATE Call SET CallTotalTime = '00:02:00' WHERE Call.CallID = 6054451
go
UPDATE Call SET CallOpenByID = -1 WHERE Call.CallID = 6054451
go
 