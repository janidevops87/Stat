/******************************************************************************
**	File: Update_ServiceLevelDonorIntentDocumentName_DOCX.sql
**	Name: Update_ServiceLevelDonorIntentDocumentName_DOCX
**	Desc: Update ServiceLevelDonorIntenDocumentName to the new docx format.
**	Used By: StatFax
**	Auth: ccarroll	
**	Date: 01/12/2012
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**  10/16/2012		ccarroll				initial
*******************************************************************************/

DECLARE @NewDocExt AS nvarchar(10) = '.docx'
DECLARE @OldDocExt AS nvarchar(10) = '.doc'

IF (SELECT Count(*) FROM ServiceLevel WHERE ServiceLevelDonorIntentDocumentName LIKE '%' + @NewDocExt) > 0
	BEGIN
		Print 'ServiceLevel Donor Intent Document has already been re-named to '+ @NewDocExt+ '. Re-name Aborted.'
	END
ELSE
	BEGIN
		Print 'Updating Donor Intent Documents: ' + @OldDocExt + ' to ' + @NewDocExt
		
		
		/* Update document names to new format  */
		--SELECT ServiceLevelDonorIntentDocumentName AS Old_Name, REPLACE(ServiceLevelDonorIntentDocumentName, @OldDocExt, @NewDocExt) AS New_Name FROM ServiceLevel
		UPDATE ServiceLevel SET ServiceLevelDonorIntentDocumentName = REPLACE(ServiceLevelDonorIntentDocumentName, @OldDocExt, @NewDocExt)
		WHERE PATINDEX('%' + @OldDocExt, ServiceLevelDonorIntentDocumentName) > 0 
		AND  ServiceLevelStatus IN(1, 0)

	END

		/* Scrub FaxQueue  */
		Print 'Scrub FaxQueue: Renaming ' + @OldDocExt + ' to ' + @NewDocExt
		
		UPDATE FaxQueue SET FaxQueueFormName = REPLACE(FaxQueueFormName, @OldDocExt, @NewDocExt)
		WHERE  FaxQueueSentDate is Null
		AND  PATINDEX('%' + @OldDocExt, FaxQueueFormName) > 0

GO