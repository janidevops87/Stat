INSERT 
	AuditTrailStatus (MaxID, AuditTrailTableID)
select 
	Max(CallID) , 
	1 -- Call
FROM 
	Call


select Max(MaxID) from AuditTrailStatus where AuditTrailTableID = 1 --Call


INSERT 
	AuditTrailStatus (MaxID, AuditTrailTableID)
select 
	Max(NOKID) , 
	7 -- NOK
FROM 
	NOK

select Max(MaxID) from AuditTrailStatus where AuditTrailTableID = 7 --NOK

INSERT 
	AuditTrailStatus (MaxID, AuditTrailTableID)
select 
	Max(OrganizationID) , 
	8 -- Organization
FROM 
	Organization
select Max(MaxID) from AuditTrailStatus where AuditTrailTableID = 8 --Organization

INSERT 
	AuditTrailStatus (MaxID, AuditTrailTableID)
select 
	Max(PersonID) , 
	9 -- Person
FROM 
	Person
select Max(MaxID) from AuditTrailStatus where AuditTrailTableID = 9 --Person

-- Roles
INSERT 
	AuditTrailStatus (MaxID, AuditTrailTableID)
select 
	Max(RoleID) , 
	(select AuditTrailTableID from AuditTrailTable att where att.AuditTrailTableName = 'Roles')

FROM 
	Roles

-- WebPerson
INSERT 
	AuditTrailStatus (MaxID, AuditTrailTableID)
select 
	Max(WebPersonID) , 
	(select AuditTrailTableID from AuditTrailTable att where att.AuditTrailTableName = 'WebPerson')

FROM 
	WebPerson

-- ReportRule
INSERT 
	AuditTrailStatus (MaxID, AuditTrailTableID)
select 
	Max(ReportRuleID) , 
	(select AuditTrailTableID from AuditTrailTable att where att.AuditTrailTableName = 'ReportRule')

FROM 
	ReportRule

