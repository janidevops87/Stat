-- CCRST306
-- Robert Hudson
-- 12/12/2019
-- Adds/updates StatFileMessageDetail2019.xslt to ExportFileXsltName
-- Adds/updates Message Detail to ExportFileType

-- Get current xslt table before change
--SELECT * FROM ExportFileXslt;

-- Add/update xslt
IF (NOT EXISTS (SELECT * FROM ExportFileXslt WHERE ExportFileXsltName = 'StatFileMessageDetail2019.xslt')) BEGIN
	INSERT INTO ExportFileXslt
			(ExportFileXsltName)
		VALUES
			('StatFileMessageDetail2019.xslt');
END

-- Capture ID of xslt
DECLARE @MessageDetail2019ExportFileXsltId INT =
	(SELECT TOP(1) ExportFileXsltID FROM ExportFileXslt WHERE ExportFileXsltName = 'StatFileMessageDetail2019.xslt');

-- Get current file types before change
--SELECT * FROM ExportFileType;

-- Check that Message file data type exists and gets data type ID
DECLARE @MessageExportFileDataTypeId INT =
	(SELECT TOP(1) ExportFileDataTypeID FROM ExportFileDataType WHERE ExportFileDataTypeAbbreviation = 'M');

-- Add/update file type
IF (@MessageExportFileDataTypeId IS NOT NULL) AND (NOT EXISTS(SELECT * FROM ExportFileType WHERE ExportFileTypeName = 'Message Detail 2019')) BEGIN
	INSERT INTO ExportFileType
			(ExportFileTypeName, LastModified, ExportFileXsltID, Enabled, ExportFileDataTypeID)
		VALUES
			('Message Detail 2019', GETDATE(), @MessageDetail2019ExportFileXsltId, 1, @MessageExportFileDataTypeId);
END