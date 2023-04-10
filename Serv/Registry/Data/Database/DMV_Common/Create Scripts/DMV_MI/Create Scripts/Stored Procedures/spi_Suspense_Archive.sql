
CREATE PROCEDURE spi_Suspense_Archive
	@SuspenseID INT = NULL,
	@ArchiveReason  INT = 5
AS
/*
 Designed AND Developed 01/2003
 Legal Information...
  c1996-2003 Statline, LLC. All rights reserved. 
  Statline is a registered trademark of Statline, LLC in the U.S.A. 
  7555 East Hampden Avenue, Ste. 104, 
  Denver, CO 80231. 
  1-888-881-7828. 
*/ 

BEGIN TRANSACTION ARCHIVE
	-- SUSPENSEARCHIVE
	INSERT INTO SUSPENSE_A_ARCHIVE
	SELECT SUSPENSE_A.*, @ArchiveReason 
	FROM SUSPENSE_A
	WHERE SUSPENSE_A.ID = @SuspenseID;
 
 	-- REGISTRY
	DELETE FROM SUSPENSE_A
	FROM SUSPENSE_A
	WHERE SUSPENSE_A.ID = @SuspenseID;

COMMIT TRANSACTION ARCHIVE
-- SELECT * FROM SUSPENSEARCHIVETYPE



GO
