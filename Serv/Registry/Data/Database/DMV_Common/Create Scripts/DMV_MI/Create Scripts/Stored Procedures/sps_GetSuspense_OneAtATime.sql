
CREATE PROCEDURE sps_GetSuspense_OneAtATime
 @vSuspenseRecordID int = 0

/* Gets the top suspense records if no @vSuspenseRecordID is sent,
   otherwise, gets the record requested.
   Modified 2/17/05 - SAP
 */

AS

SET NOCOUNT ON

--If IDs NOT passed in, then bring top most record.
IF @vSuspenseRecordID = 0
   BEGIN
	SELECT  TOP 20
		ID, FIRST, MIDDLE, LAST, SUFFIX, 
		AADDR1, ACITY, ASTATE, AZIP, RENEWALDATE, 
		FULLNAME, CITYSTATEZIP, TIFFFILE, OK, REASON
 	FROM  SUSPENSE_A
 	WHERE  OK = 0
 	ORDER BY ID;
   END

--If ID's passed in, then return the record equal to that ID
ELSE IF @vSuspenseRecordID <> 0
   BEGIN	
	SELECT  
  		ID, FIRST, MIDDLE, LAST, SUFFIX, 
		AADDR1, ACITY, ASTATE, AZIP, RENEWALDATE, 
		FULLNAME, CITYSTATEZIP, TIFFFILE, OK, REASON
	FROM  SUSPENSE_A
	WHERE  OK = 0
	AND ID = @vSuspenseRecordID;
   END
GO
