  
 PRINT 'Update ExportFileType'
 

 
update ExportFileType
set 
ExportFileDataTypeID = 2
where patindex('Message%', ExportFileTypeName)>0

update ExportFileType
set 
ExportFileDataTypeID = 1
where patindex('%Referral%', ExportFileTypeName)>0

 update ExportFileType
set 
ExportFileDataTypeID = 4
where patindex('Message%Event%', ExportFileTypeName)>0

update ExportFileType
set 
ExportFileDataTypeID = 3
where patindex('Referral%Event%', ExportFileTypeName)>0 
 
 
 
 
update ExportFileType
set 
ExportFileXsltID  = ExportFileTypeID
, Enabled = 1
 
 PRINT 'SET CLOSECASETRIGGERID AND CLOSECASEOVVERRIDE'
 update exportFile
set CloseCaseTriggerID = 0
, CloseCaseOverride = 0
, ExportFileFrequencyQuantity = 1