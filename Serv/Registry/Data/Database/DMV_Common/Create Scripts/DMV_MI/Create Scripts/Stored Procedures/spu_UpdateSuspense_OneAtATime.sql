
CREATE PROCEDURE spu_UpdateSuspense_OneAtATime
	@vSuspenseRecordID as varchar(255), 
	@FIRST    as varchar(255) = '', 
	@MIDDLE   as varchar(255) = '', 
	@LAST    as varchar(255) = '',
	@SUFFIX   as varchar(255),
	@AADDR1   as varchar(255),
	@ACITY    as varchar(255),
	@ASTATE   as varchar(255),
	@AZIP    as varchar(255),
	@RENEWALDATE   as varchar(255),
	@OK    as varchar(3) = "off"

AS

SET NOCOUNT ON

-- Update Full Name with newly established proper name.  3/3/05 - SAP
DECLARE @FullName AS Varchar(255)

SET @FullName = UPPER(RTRIM(@FIRST)) + ' '
IF LEN(RTRIM(@MIDDLE)) > 0 
    BEGIN
	SET @FullName = @FullName + UPPER(RTRIM(@MIDDLE)) + ' '
    END
SET @FullName = @FullName + UPPER(RTRIM(@LAST)) + ' '

IF @OK = "on"
    BEGIN
	UPDATE SUSPENSE_A
 		SET [FIRST] = @FIRST,
		MIDDLE = @MIDDLE,
		[LAST] = @LAST,
		SUFFIX = @SUFFIX,
		AADDR1 = @AADDR1,
		ACITY = @ACITY,
		ASTATE = @ASTATE,
		AZIP = @AZIP,
		RENEWALDATE = @RENEWALDATE,
		FullName = @FullName,
		OK = 1
	WHERE ID = @vSuspenseRecordID;
   END
ELSE
   BEGIN
	UPDATE SUSPENSE_A
 		SET [FIRST] = @FIRST,
		MIDDLE = @MIDDLE,
		[LAST] = @LAST,
		SUFFIX = @SUFFIX,
		AADDR1 = @AADDR1,
		ACITY = @ACITY,
		ASTATE = @ASTATE,
		AZIP = @AZIP,
		RENEWALDATE = @RENEWALDATE,
		FullName = @FullName,
		OK = 0
	WHERE ID = @vSuspenseRecordID;
   END

GO
