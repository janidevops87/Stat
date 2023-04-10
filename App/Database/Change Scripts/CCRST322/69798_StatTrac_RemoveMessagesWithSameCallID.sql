-- StatTrac - Remove Messages With The Same CallID
-- CCRST322 Bug: 69798
-- Description:  In CCRST322, we're adding a constraint to the Message table that ensures
--					CallIDs will remain unique.  That constraint will need the existing 
--					multiple references to the same CallID removed.  That's the purpose of 
--					this script - to confirm and remove the duplicated record(s).
-- DB Server: testsql._ReferralTest


-- Find messages where we've used the same CallID multiple times
/*
select top 10 *
from Message
where CallID IN (select top 100 CallID
			from Message
			group by CallID
			having COUNT(MessageID) > 1);
*/


IF EXISTS(SELECT 1 FROM Message WHERE MessageID = 921107)
BEGIN
	PRINT 'Deleting Message 921107';
	DELETE FROM Message
	WHERE MessageID = 921107;
END
GO
