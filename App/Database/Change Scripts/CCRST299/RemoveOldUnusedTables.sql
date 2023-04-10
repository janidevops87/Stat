/*
	Remove old unused Tables


*/


if exists(select 1 from sys.tables where name like 'StatEmployeeLog')
begin
	drop table StatEmployeeLog
end
--if exists(select 1 from sys.tables where name like ' LineItemProductDescription')
--begin
--	drop table  LineItemProductDescription
--end
if exists(select 1 from sys.tables where name like '_backupInvoiceLineItem2019')
begin
	drop table _backupInvoiceLineItem2019
end
if exists(select 1 from sys.tables where name like 'tempInvoicePriceList')
begin
	drop table tempInvoicePriceList
end
if exists(select 1 from sys.tables where name like 'tempInvoicePriceUpdate')
begin
	drop table tempInvoicePriceUpdate
end	
if exists (select 1 from sys.tables where name like 'ArchiveAppropriateCounts')
begin
	drop table ArchiveAppropriateCounts
end
if exists (select 1 from sys.tables where name like 'ArchiveCall')
begin
	drop table ArchiveCall
end
if exists (select 1 from sys.tables where name like 'ArchiveCallCriteria')
begin
	drop table ArchiveCallCriteria
end
if exists (select 1 from sys.tables where name like 'ArchiveCallCustomField')
begin
	drop table ArchiveCallCustomField
end
if exists (select 1 from sys.tables where name like 'ArchiveCODCaller')
begin
	drop table ArchiveCODCaller
end
if exists (select 1 from sys.tables where name like 'ArchiveCODQuestionLog')
begin
	drop table ArchiveCODQuestionLog
end
if exists (select 1 from sys.tables where name like 'ArchiveDonorData')
begin
	drop table ArchiveDonorData
end
if exists (select 1 from sys.tables where name like 'ArchiveFSCase')
begin
	drop table ArchiveFSCase
end
if exists (select 1 from sys.tables where name like 'ArchiveLOCall')
begin
	drop table ArchiveLOCall
end
if exists (select 1 from sys.tables where name like 'ArchiveLogEvent')
begin
	drop table ArchiveLogEvent
end
if exists (select 1 from sys.tables where name like 'ArchiveMessage')
begin
	drop table ArchiveMessage
end
if exists (select 1 from sys.tables where name like 'ArchiveNDRICallSheet')
begin
	drop table ArchiveNDRICallSheet
end
if exists (select 1 from sys.tables where name like 'ArchiveNoCall')
begin
	drop table ArchiveNoCall
end
if exists (select 1 from sys.tables where name like 'ArchiveNOK')
begin
	drop table ArchiveNOK
end
if exists (select 1 from sys.tables where name like 'ArchiveReferral')
begin
	drop table ArchiveReferral
end
if exists (select 1 from sys.tables where name like 'ArchiveReferralSecondaryData')
begin
	drop table ArchiveReferralSecondaryData
end
if exists (select 1 from sys.tables where name like 'ArchiveRegistryStatus')
begin
	drop table ArchiveRegistryStatus
end
if exists (select 1 from sys.tables where name like 'ArchiveSecondary')
begin
	drop table ArchiveSecondary
end
if exists (select 1 from sys.tables where name like 'ArchiveSecondary2')
begin
	drop table ArchiveSecondary2
end
if exists (select 1 from sys.tables where name like 'ArchiveSecondaryApproach')
begin
	drop table ArchiveSecondaryApproach
end
if exists (select 1 from sys.tables where name like 'ArchiveSecondaryDisposition')
begin
	drop table ArchiveSecondaryDisposition
end
if exists (select 1 from sys.tables where name like 'ArchiveSecondaryMedication')
begin
	drop table ArchiveSecondaryMedication
end
if exists (select 1 from sys.tables where name like 'ArchiveSecondaryMedicationOther')
begin
	drop table ArchiveSecondaryMedicationOther
end
if exists (select 1 from sys.tables where name like 'ArchiveSecondaryTBI')
begin
	drop table ArchiveSecondaryTBI
end
--if exists (select 1 from sys.tables where name like 'ArchiveStatus')
--begin
--	drop table ArchiveStatus
--end