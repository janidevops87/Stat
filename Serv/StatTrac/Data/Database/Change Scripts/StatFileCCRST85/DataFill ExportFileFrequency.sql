if not exists(select * from ExportFileFrequency where ExportFileFrequencyID < 6)
BEGIN
	PRINT 'DATA FILL ExportFileFrequency'
	
 	SET IDENTITY_INSERT ExportFileFrequency ON 
	INSERT ExportFileFrequency (ExportFileFrequencyID, ExportFileFrequencyName)
	VALUES(0, 'Daily')
	INSERT ExportFileFrequency (ExportFileFrequencyID, ExportFileFrequencyName)
	VALUES(1, 'Weekly')
	INSERT ExportFileFrequency (ExportFileFrequencyID, ExportFileFrequencyName)
	VALUES(2, 'Monthly')
	INSERT ExportFileFrequency (ExportFileFrequencyID, ExportFileFrequencyName)
	VALUES(3, 'Hourly')
	INSERT ExportFileFrequency (ExportFileFrequencyID, ExportFileFrequencyName)
	VALUES(5, 'Minute')
	INSERT ExportFileFrequency (ExportFileFrequencyID, ExportFileFrequencyName)
	VALUES(4, 'Custom')
	SET IDENTITY_INSERT ExportFileFrequency OFF
END