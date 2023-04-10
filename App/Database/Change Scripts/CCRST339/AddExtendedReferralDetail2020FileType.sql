/******************************************************************************
**		File: AddExtendedReferralDetail2020FileType.sql
**		Name: AddExtendedReferralDetail2020FileType.sql
**		Desc: Adds Extended Referral Detail 2020 file to list of export file types
**
**		Auth: Robert Hudson
**		Date: 01/27/2021
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**      01/27/2021	Robert Hudson		initial
*******************************************************************************/

IF NOT EXISTS (SELECT * FROM ExportFileXslt WHERE ExportFileXsltName = 'StatFileExtendedReferralDetail2020.xslt') BEGIN
	INSERT INTO ExportFileXslt VALUES
		-- ExportFileXsltName
		('StatFileExtendedReferralDetail2020.xslt')
END

IF NOT EXISTS (SELECT * FROM ExportFileType WHERE ExportFileTypeName = 'Extended Referral Detail 2020') BEGIN
	INSERT INTO ExportFileType VALUES
		-- Name								LastModified	UpdatedFlag		ExportFileXsltID	Enabled		ExportFileDataTypeID
		('Extended Referral Detail 2020',	GETDATE(),		NULL,			12,					1,			1)
END