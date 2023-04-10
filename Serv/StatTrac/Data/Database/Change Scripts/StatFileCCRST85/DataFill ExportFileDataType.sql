
IF NOT EXISTS (SELECT * FROM ExportFileDataType WHERE ExportFileDataTypeID < 5)
BEGIN
	PRINT 'DATA FILL ExportFileDataType'
	SET IDENTITY_INSERT ExportFileDataType ON 
	INSERT  ExportFileDataType (ExportFileDataTypeID, ExportFileDataTypeName)
	VALUES (1, 'Referral')
	INSERT  ExportFileDataType (ExportFileDataTypeID, ExportFileDataTypeName)
	VALUES (2, 'Message')
	INSERT  ExportFileDataType (ExportFileDataTypeID, ExportFileDataTypeName)
	VALUES (3, 'Referral Event')
	INSERT  ExportFileDataType (ExportFileDataTypeID, ExportFileDataTypeName)
	VALUES (4, 'Message Event')
	
SET IDENTITY_INSERT ExportFileDataType OFF 
	update ExportFileDataType
	set ExportFileDataTypeAbbreviation = substring(ExportFileDataTypeName, 1, 1)

	update ExportFileDataType
	set ExportFileDataTypeAbbreviation = ExportFileDataTypeAbbreviation + 'E'
	where ExportFileDataTypeName like '%Event'
	
END