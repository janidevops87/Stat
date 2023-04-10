if not exists (select * from CloseCaseTrigger where CloseCaseTriggerID < 3)
BEGIN

	INSERT CloseCaseTrigger
	VALUES ('Referral Complete')

	INSERT CloseCaseTrigger
	VALUES ('Registry Complete')
END 

if not exists (select * from CloseCaseTrigger where CloseCaseTriggerID = 0)
BEGIN
	set identity_insert CloseCaseTrigger ON 
	INSERT CloseCaseTrigger (CloseCaseTriggerID, CloseCaseTriggerName)
	VALUES (0, 'none')
	set identity_insert CloseCaseTrigger OFF
END 


