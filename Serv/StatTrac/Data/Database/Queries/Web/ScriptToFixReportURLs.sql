 /* Script to modify report names */

DECLARE @OldURL Varchar(255)
DECLARE @NewURL Varchar(255)

SET @OldURL = 'OrganizationAuditTrail'
SET @NewURL = 'AuditTrailOrganization'
UPDATE Report SET ReportVirtualURL = Replace(ReportVirtualURL, @OldURL, @NewURL) WHERE ReportVirtualURL LIKE '%' + @OldURL

SET @OldURL = 'PersonAuditTrail'
SET @NewURL = 'AuditTrailPerson'
UPDATE Report SET ReportVirtualURL = Replace(ReportVirtualURL, @OldURL, @NewURL) WHERE ReportVirtualURL LIKE '%' + @OldURL

SET @OldURL = 'MessageAuditTrail'
SET @NewURL = 'AuditTrailMessage'
UPDATE Report SET ReportVirtualURL = Replace(ReportVirtualURL, @OldURL, @NewURL) WHERE ReportVirtualURL LIKE '%' + @OldURL

SET @OldURL = 'ImportOfferAuditTrail'
SET @NewURL = 'AuditTrailImportOffer'
UPDATE Report SET ReportVirtualURL = Replace(ReportVirtualURL, @OldURL, @NewURL) WHERE ReportVirtualURL LIKE '%' + @OldURL

SET @OldURL = 'Processor Number'
SET @NewURL = 'ProcessorNumber'
UPDATE Report SET ReportVirtualURL = Replace(ReportVirtualURL, @OldURL, @NewURL) WHERE ReportVirtualURL LIKE '%' + @OldURL

SET @OldURL = 'Conversion Rate'
SET @NewURL = 'FS Conversion Rate'
UPDATE Report SET ReportVirtualURL = Replace(ReportVirtualURL, @OldURL, @NewURL) WHERE ReportVirtualURL LIKE '%' + @OldURL