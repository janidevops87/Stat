sp_help sps_DonorTracUpdateBatch 'DTCAOL', 'kiwibike1031', '6/16/06', '6/18/06'
-- ReferralList.ReferralsList
-- ReferralManager.GetReferralList
sp_help sps_DonorTracMissedReferralslastBatch 'DTCAOL', 'kiwibike1031'
-- MissedReferrals.MissedReferrals
-- ReferralManager.GetMissedReferrals
sps_DonorTracUpdateBatchFS 'DTCAOL', 'kiwibike1031', '6/17/06', '6/18/06'
-- ReferrallList.ReferralList
-- ReferralManager.GetReferralFSList
sp_help sps_DonorTracReferralFS 'DTCAOL', 'kiwibike1031', 5423356
-- ReferralList.ReferralsList 
-- ReferralManager.GetReferralFS
sp_help sps_DonorTracUpdateReferral 'DTCAOL', 'kiwibike1031', 5421278
-- ReferralDetail.ReferralDetail
-- ReferralManager.GetReferral
sp_help sps_DonorTracUpdateBatchEventLog 'DTCAOL', 'kiwibike1031', '6/17/06', '6/18/06'
-- EvenLogDetail.EventLogDetail
-- EventLogManager.GetEventLogList

sp_help sps_DonorTracUpdateReferralEventLog 'DTCAOL', 'kiwibike1031', 421278
-- EventLogDetail.EventLogDetail
-- EventLogManager.GetEventLog
sps_DonorTracReferralFSMedications 'DTCAOL', 'kiwibike1031', 5423356
-- Medications.MedicationList
-- MedicationManager.GetFSMedicationList

--- STATFILE.NET Methods
sp_help sps_StatFileOrgID 'DTCAOL', 'kiwibike1031'
-- StatFile.OrganizationList
-- StatFileManager.GetOrganizationID
sps_StatFileExportFileTypes
-- StatFile.ExportFileTypes
-- StatFileManager.GetStatTracFileTypeList
sps_DonorTracExportFileTypes
-- StatFile.ExportFileTypes

-- StatFileManager.GetDonorTracFileTypeList
sps_StatTracReportGroups 'DTCAOL', 'kiwibike1031'
-- StatFile.ReporGroups
sps_DonorTracReportGroups 'DTCAOL', 'kiwibike1031'
-- StatFile.ReporGroups
sp_help sps_StatFileGetFrequencies 'DTCAOL', 'kiwibike1031'
-- StatFile.Frequencies
-- StatFileManager.GetFrequencyList
-- sp_help sps_DonorTracUpdateBatch 


-- select * from webperson where webpersonusername like '%CAOL%'