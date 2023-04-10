
--this script fixes the error type dupes...inactivates all but one and reassigns inactives to one form
--Answers call timely (< 10 sec)
UPDATE
	QAErrorType

SET
	QAErrorTypeActive = 0 
	
WHERE
	QAErrorTypeID in(93,162,102,201,4)
	
UPDATE
	QAMonitoringFormTemplate

SET
	QAErrorTypeID = 56
	
WHERE
	QAErrorTypeID in(93,162,102,201,4)
--Asks appropriate follow-up questions (e.g. DCD potential)	
UPDATE
	QAErrorType

SET
	QAErrorTypeActive = 0 
	
WHERE
	QAErrorTypeID in(109,176,215)
	
UPDATE
	QAMonitoringFormTemplate

SET
	QAErrorTypeID = 138
	
WHERE
	QAErrorTypeID in(109,176,215)
--	Asks conditional alerts as needed
UPDATE
	QAErrorType

SET
	QAErrorTypeActive = 0 
	
WHERE
	QAErrorTypeID in(98,159,171,210)
	
UPDATE
	QAMonitoringFormTemplate

SET
	QAErrorTypeID = 69
	
WHERE
	QAErrorTypeID in(98,159,171,210)
--	Asks rule out questions per protocol
UPDATE
	QAErrorType

SET
	QAErrorTypeActive = 0 
	
WHERE
	QAErrorTypeID in(169,133,96,208)
	
UPDATE
	QAMonitoringFormTemplate

SET
	QAErrorTypeID = 67
	
WHERE
	QAErrorTypeID in(169,133,96,208)
--	Blank or missing events types in event log
UPDATE
	QAErrorType

SET
	QAErrorTypeActive = 0 
	
WHERE
	QAErrorTypeID in(193,150)
	
UPDATE
	QAMonitoringFormTemplate

SET
	QAErrorTypeID = 228
	
WHERE
	QAErrorTypeID in(193,150)		
--	Contacts timely (<10 min)
UPDATE
	QAErrorType

SET
	QAErrorTypeActive = 0 
	
WHERE
	QAErrorTypeID in(124,224,189)
	
UPDATE
	QAMonitoringFormTemplate

SET
	QAErrorTypeID = 146
	
WHERE
	QAErrorTypeID in(124,224,189)
--	Correct screening level
UPDATE
	QAErrorType

SET
	QAErrorTypeActive = 0 
	
WHERE
	QAErrorTypeID in(168,158,95,66,25)
	
UPDATE
	QAMonitoringFormTemplate

SET
	QAErrorTypeID = 207
	
WHERE
	QAErrorTypeID in(168,158,95,66,25)							
--	Did not speak clearly or effectively
UPDATE
	QAErrorType

SET
	QAErrorTypeActive = 0 
	
WHERE
	QAErrorTypeID in(196,152,112,88)
	
UPDATE
	QAMonitoringFormTemplate

SET
	QAErrorTypeID = 234
	
WHERE
	QAErrorTypeID in(196,152,112,88)
	
--	Documents appropriate follow up to conditional alerts
UPDATE
	QAErrorType

SET
	QAErrorTypeActive = 0 
	
WHERE
	QAErrorTypeID in(29,160,172,99,211)
	
UPDATE
	QAMonitoringFormTemplate

SET
	QAErrorTypeID = 70
	
WHERE
	QAErrorTypeID in(29,160,172,99,211)
--	Documents correct caller's full name/title
UPDATE
	QAErrorType

SET
	QAErrorTypeActive = 0 
	
WHERE
	QAErrorTypeID in(130,104,204)
	
UPDATE
	QAMonitoringFormTemplate

SET
	QAErrorTypeID = 165
	
WHERE
	QAErrorTypeID in(130,104,204)
--	Documents correct contact phone # for caller
UPDATE
	QAErrorType

SET
	QAErrorTypeActive = 0 
	
WHERE
	QAErrorTypeID in(203,164,129)
	
UPDATE
	QAMonitoringFormTemplate

SET
	QAErrorTypeID = 103
	
WHERE
	QAErrorTypeID in(203,164,129)
--	Documents correct CTOD
UPDATE
	QAErrorType

SET
	QAErrorTypeActive = 0 
	
WHERE
	QAErrorTypeID in(132,65,206,106)
	
UPDATE
	QAMonitoringFormTemplate

SET
	QAErrorTypeID = 167
	
WHERE
	QAErrorTypeID in(132,65,206,106)
--	Documents correct event type
UPDATE
	QAErrorType

SET
	QAErrorTypeActive = 0 
	
WHERE
	QAErrorTypeID in(227,127,149,47,86)
	
UPDATE
	QAMonitoringFormTemplate

SET
	QAErrorTypeID = 192
	
WHERE
	QAErrorTypeID in(227,127,149,47,86)	
--	Documents pertinent responses/medical info
UPDATE
	QAErrorType

SET
	QAErrorTypeActive = 0 
	
WHERE
	QAErrorTypeID in(97,134,170,209)
	
UPDATE
	QAMonitoringFormTemplate

SET
	QAErrorTypeID = 68
	
WHERE
	QAErrorTypeID in(97,134,170,209)
--	Followed call instructions
UPDATE
	QAErrorType

SET
	QAErrorTypeActive = 0 
	
WHERE
	QAErrorTypeID in(225,125,85,147)
	
UPDATE
	QAMonitoringFormTemplate

SET
	QAErrorTypeID = 190
	
WHERE
	QAErrorTypeID in(225,125,85,147)	
--	Follows client specific alerts not noted elsewhere
UPDATE
	QAErrorType

SET
	QAErrorTypeActive = 0 
	
WHERE
	QAErrorTypeID in(121,151,219,181)
	
UPDATE
	QAMonitoringFormTemplate

SET
	QAErrorTypeID = 80
	
WHERE
	QAErrorTypeID in(121,151,219,181)
--	If outgoing call, communicates update correctly
UPDATE
	QAErrorType

SET
	QAErrorTypeActive = 0 
	
WHERE
	QAErrorTypeID in(191,226,126)
	
UPDATE
	QAMonitoringFormTemplate

SET
	QAErrorTypeID = 148
	
WHERE
	QAErrorTypeID in(191,226,126)		
--	Major spelling errors
UPDATE
	QAErrorType

SET
	QAErrorTypeActive = 0 
	
WHERE
	QAErrorTypeID in(116,177,32,73,161)
	
UPDATE
	QAMonitoringFormTemplate

SET
	QAErrorTypeID = 216
	
WHERE
	QAErrorTypeID in(116,177,32,73,161)
--	Negative call experience
UPDATE
	QAErrorType

SET
	QAErrorTypeActive = 0 
	
WHERE
	QAErrorTypeID in(156,200,115,230)
	
UPDATE
	QAMonitoringFormTemplate

SET
	QAErrorTypeID = 92
	
WHERE
	QAErrorTypeID in(156,200,115,230)
--	NOK info obtained (after consent has been given)
UPDATE
	QAErrorType

SET
	QAErrorTypeActive = 0 
	
WHERE
	QAErrorTypeID in(140)
	
UPDATE
	QAMonitoringFormTemplate

SET
	QAErrorTypeID = 217
	
WHERE
	QAErrorTypeID in(140)		
--	Notified ALL appropriate clients (not otherwise listed)
UPDATE
	QAErrorType

SET
	QAErrorTypeActive = 0 
	
WHERE
	QAErrorTypeID in(223,145)
	
UPDATE
	QAMonitoringFormTemplate

SET
	QAErrorTypeID = 188
	
WHERE
	QAErrorTypeID in(223,145)
--	Obtains NOK information
UPDATE
	QAErrorType

SET
	QAErrorTypeActive = 0 
	
WHERE
	QAErrorTypeID in(117,179)
	
UPDATE
	QAMonitoringFormTemplate

SET
	QAErrorTypeID = 75
	
WHERE
	QAErrorTypeID in(117,179)
--	Provided or withheld referral # as appropriate
UPDATE
	QAErrorType

SET
	QAErrorTypeActive = 0 
	
WHERE
	QAErrorTypeID in(120)
	
UPDATE
	QAMonitoringFormTemplate

SET
	QAErrorTypeID = 79
	
WHERE
	QAErrorTypeID in(120)
	--	Rude 
UPDATE
	QAErrorType

SET
	QAErrorTypeActive = 0 
	
WHERE
	QAErrorTypeID in(231,155,91,114)
	
UPDATE
	QAMonitoringFormTemplate

SET
	QAErrorTypeID = 199
	
WHERE
	QAErrorTypeID in(231,155,91,114)
--	Rules in inappropriately
UPDATE
	QAErrorType

SET
	QAErrorTypeActive = 0 
	
WHERE
	QAErrorTypeID in(173,71,30,212,100)
	
UPDATE
	QAMonitoringFormTemplate

SET
	QAErrorTypeID = 135
	
WHERE
	QAErrorTypeID in(173,71,30,212,100)
--	Rules out inappropriately
UPDATE
	QAErrorType

SET
	QAErrorTypeActive = 0 
	
WHERE
	QAErrorTypeID in(31,72,174,136,101)
	
UPDATE
	QAMonitoringFormTemplate

SET
	QAErrorTypeID = 213
	
WHERE
	QAErrorTypeID in(31,72,174,136,101)
--	Rushes call, talks over caller or interrupts
UPDATE
	QAErrorType

SET
	QAErrorTypeActive = 0 
	
WHERE
	QAErrorTypeID in(87,233,195,153)
	
UPDATE
	QAMonitoringFormTemplate

SET
	QAErrorTypeID = 110
	
WHERE
	QAErrorTypeID in(87,233,195,153)
--	Understand type of call
UPDATE
	QAErrorType

SET
	QAErrorTypeActive = 0 
	
WHERE
	QAErrorTypeID in(128,57,202,6,94)
	
UPDATE
	QAMonitoringFormTemplate

SET
	QAErrorTypeID = 163
	
WHERE
	QAErrorTypeID in(128,57,202,6,94)
--	Unprofessional (lacks knowledge, tone not conversant)
UPDATE
	QAErrorType

SET
	QAErrorTypeActive = 0 
	
WHERE
	QAErrorTypeID in(89,197,229,157)
	
UPDATE
	QAMonitoringFormTemplate

SET
	QAErrorTypeID = 113
	
WHERE
	QAErrorTypeID in(89,197,229,157)
--	Updates primary screen (including disposition)
UPDATE
	QAErrorType

SET
	QAErrorTypeActive = 0 
	
WHERE
	QAErrorTypeID in(175,137)
	
UPDATE
	QAMonitoringFormTemplate

SET
	QAErrorTypeID = 214
	
WHERE
	QAErrorTypeID in(175,137)
--	Verifies referral # and/or patient name
UPDATE
	QAErrorType

SET
	QAErrorTypeActive = 0 
	
WHERE
	QAErrorTypeID in(205,131,166)
	
UPDATE
	QAMonitoringFormTemplate

SET
	QAErrorTypeID = 105
	
WHERE
	QAErrorTypeID in(205,131,166)				
--	Documented info that was not given
UPDATE
	QAErrorType

SET
	QAErrorTypeActive = 0 
	
WHERE
	QAErrorTypeID in(122)
	
UPDATE
	QAMonitoringFormTemplate

SET
	QAErrorTypeID = 82
	
WHERE
	QAErrorTypeID in(122)
--	More data
UPDATE
	QAErrorType

SET
	QAErrorTypeActive = 0 
	
WHERE
	QAErrorTypeID in(118)
	
UPDATE
	QAMonitoringFormTemplate

SET
	QAErrorTypeID = 76
	
WHERE
	QAErrorTypeID in(118) 
--	Not engaged (ie: dead air, unnecessary delays)
UPDATE
	QAErrorType

SET
	QAErrorTypeActive = 0 
	
WHERE
	QAErrorTypeID in(90,232,198,154)
	
UPDATE
	QAMonitoringFormTemplate

SET
	QAErrorTypeID = 111
	
WHERE
	QAErrorTypeID in(90,232,198,154)
	