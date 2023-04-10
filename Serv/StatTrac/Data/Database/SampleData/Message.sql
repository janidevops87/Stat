 INSERT INTO Call (CallNumber, CallTypeID, CallDateTime, StatEmployeeID, CallTotalTime, CallSeconds, CallTemp, SourceCodeID, CallOpenByID, CallTempExclusive, CallTempSavedByID, RecycleNCFlag, CallActive, CallSaveLastByID, CallExtension) VALUES (NULL,2,'5/16/2007 5:59:00 PM',45,'00:00:00',0,0,44,-1,-1,-1,1,0,45,33)
 
EXEC spu_Update_Transaction 6054467, 45, 0
 
 INSERT INTO Message (CallID, MessageCallerName, MessageCallerPhone, MessageCallerOrganization, OrganizationID, PersonID, MessageTypeID, MessageUrgent, MessageDescription, MessageExtension, MessageImportPatient, MessageImportUNOSID, MessageImportCenter) VALUES (6054467,'Zadith Pino','(303) 691-3363',NULL,0,0,0,-1,NULL,NULL,NULL,NULL,NULL)
 
 UPDATE Call SET CallOpenByID = -1 WHERE Call.CallID = 6054467

UPDATE Call SET CallNumber = '6054467-45',CallTypeID = 2,CallDateTime = '5/16/2007 6:01:00 PM',StatEmployeeID = 45,CallTotalTime = NULL,CallSeconds = 0,CallTemp = 0,SourceCodeID = 44,CallOpenByID = -1,CallTempExclusive = 0,CallTempSavedByID = -1,RecycleNCFlag = 2,CallActive = 0,CallSaveLastByID = 45 WHERE CallID = 6054467

EXEC spu_Update_Transaction 6054467, 45, 0


INSERT INTO LogEvent (CallID, LogEventTypeID, LogEventName, LogEventPhone, LogEventOrg, LogEventDesc, StatEmployeeID, LogEventDateTime, LogEventCallbackPending, OrganizationID, ScheduleGroupID, PersonID, PhoneID, LogEventContactConfirmed, LogEventCalloutDateTime, LogEventNumber) VALUES (6054467,1,NULL,NULL,NULL,'test',45,'5/16/2007 6:03:19 PM',0,0,0,0,0,0,NULL,NULL)

UPDATE Call SET CallNumber = '6054467-45',CallTypeID = 2,CallDateTime = '5/16/2007 6:01:00 PM',StatEmployeeID = 45,CallTotalTime = '00:04:42',CallSeconds = 282,CallTemp = -1,SourceCodeID = 44,CallOpenByID = -1,CallTempExclusive = -1,CallTempSavedByID = 45,RecycleNCFlag = -1,CallActive = -1,CallSaveLastByID = 45 WHERE CallID = 6054467

UPDATE Message SET CallID = 6054467,MessageCallerName = 'Zadith Pino',MessageCallerPhone = '(303) 691-3363',MessageCallerOrganization = 'UCLA',OrganizationID = 51,PersonID = 749398,MessageTypeID = 3,MessageUrgent = 0,MessageDescription = 'test message 1',MessageExtension = NULL,MessageImportPatient = NULL,MessageImportUNOSID = NULL,MessageImportCenter = NULL WHERE CallID = 6054467

INSERT INTO LogEvent (CallID, LogEventTypeID, LogEventName, LogEventPhone, LogEventOrg, LogEventDesc, StatEmployeeID, LogEventDateTime, LogEventCallbackPending, OrganizationID, ScheduleGroupID, PersonID, PhoneID, LogEventContactConfirmed, LogEventCalloutDateTime, LogEventNumber) VALUES (6054467,2,'Zadith Pino',NULL,'UCLA','Recorded message information.',45,'5/16/2007 6:01:00 PM',0,-1,-1,-1,-1,0,NULL,NULL)

UPDATE Call SET CallTotalTime = '00:04:42' WHERE Call.CallID = 6054467

UPDATE Call SET CallOpenByID = -1 WHERE Call.CallID = 6054467
