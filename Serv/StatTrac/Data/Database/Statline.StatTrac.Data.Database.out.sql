 create file 
Mon 12/27/2010 
10:12 AM
st-prodsql-1 _ReferralProd "C:\2005Projects\Statline\StatTrac\Data\Database\Statline.StatTrac.CCRST123.sql" 
----------------------------------- Update Database: _ReferralProd
-----------------------------------
Dropping Procedure InsertTrackingNumber
Creating Procedure InsertTrackingNumber
Dropping Procedure GetPoints
Creating Procedure GetPoints
Mon 12/27/2010 
10:12 AM
Mon 12/27/2010 
10:12 AM
st-prodsql-2 _ReferralProdArchive "C:\2005Projects\Statline\StatTrac\Data\Database\Statline.StatTrac.CCRST123.sql" 
----------------------------------- Update Database: _ReferralProdArchive
-----------------------------------
Creating Procedure InsertTrackingNumber
Msg 213, Level 16, State 1, Server ST-PRODSQL-2, Procedure InsertTrackingNumber, Line 42
Column name or number of supplied values does not match table definition.
-- Bret Knoll 12/27/2010 Error expected because of Identity Column configuration
Dropping Procedure GetPoints
Creating Procedure GetPoints
Mon 12/27/2010 
10:12 AM
Mon 12/27/2010 
10:12 AM
st-prodsql-2 _ReferralProdReport "C:\2005Projects\Statline\StatTrac\Data\Database\Statline.StatTrac.CCRST123.sql" 
----------------------------------- Update Database: _ReferralProdReport
-----------------------------------
Creating Procedure InsertTrackingNumber
Msg 213, Level 16, State 1, Server ST-PRODSQL-2, Procedure InsertTrackingNumber, Line 42
Column name or number of supplied values does not match table definition.
-- Bret Knoll 12/27/2010 Error expected because of Identity Column configuration
Dropping Procedure GetPoints
Creating Procedure GetPoints
Mon 12/27/2010 
10:12 AM
Mon 12/27/2010 
10:12 AM
st-prodsql-2 _ReferralAuditTrail "C:\2005Projects\Statline\StatTrac\Data\Database\Statline.StatTrac.CCRST123.sql" 
----------------------------------- Update Database: _ReferralAuditTrail
-----------------------------------
The module 'sps_CallStaffStats' depends on the missing object 'spf_TZDif'. The
module will still be created; however, it cannot run successfully until the
object exists.
Creating Procedure InsertTrackingNumber
Msg 213, Level 16, State 1, Server ST-PRODSQL-2, Procedure InsertTrackingNumber, Line 42
Column name or number of supplied values does not match table definition.
-- Bret Knoll 12/27/2010 Error expected because of Identity Column configuration
Dropping Procedure GetPoints
Creating Procedure GetPoints
Mon 12/27/2010 
10:12 AM
Mon 12/27/2010 
10:12 AM
st-prodsql-1 _ReferralProd "C:\2005Projects\Statline\StatTrac\Data\Database\Statline.StatTrac.Database.sql" 
----------------------------------- Update Database: _ReferralProd
-----------------------------------
Dropping Procedure sps_rpt_ImportOfferDetail
Creating Procedure sps_rpt_ImportOfferDetail
Dropping Procedure sps_rpt_ImportOfferDetail_Select
Creating Procedure sps_rpt_ImportOfferDetail_Select
Dropping Procedure sps_rpt_ReferralFacilityCompliance
Creating Procedure sps_rpt_ReferralFacilityCompliance
The module 'sps_rpt_ReferralFacilityCompliance' depends on the missing object
'_ReferralDev_DataWarehouse.dbo.sps_GetReportGroupSourceCodeList'. The module
will still be created; however, it cannot run successfully until the object
exists.
The module 'sps_rpt_ReferralFacilityCompliance' depends on the missing object
'_ReferralProd_DataWarehouse.dbo.sps_GetReportGroupSourceCodeList'. The module
will still be created; however, it cannot run successfully until the object
exists.
Dropping Procedure sps_rpt_ReportSearchParameterLookup
Creating Procedure sps_rpt_ReportSearchParameterLookup
Dropping Procedure sps_rpt_QA
Creating Procedure sps_rpt_QA
Dropping Procedure sps_rpt_QAErrorLog_Select
Creating Procedure sps_rpt_QAErrorLog_Select
Dropping Procedure sps_rpt_QATrackingForm_Select
Creating Procedure sps_rpt_QATrackingForm_Select
Dropping Procedure sps_rpt_QAbyError
Creating Procedure sps_rpt_QAbyError
Dropping Procedure sps_rpt_QAbyTrackingNumber
Creating Procedure sps_rpt_QAbyTrackingNumber
Dropping Procedure sps_rpt_QAScorebyEmployee
Creating Procedure sps_rpt_QAScorebyEmployee
Msg 2627, Level 14, State 1, Server ST-PRODSQL-1, Line 38
Violation of PRIMARY KEY constraint 'PK_QATrackingType'. Cannot insert
duplicate key in object 'dbo.QATrackingType'.
The statement has been terminated.
Msg 2627, Level 14, State 1, Server ST-PRODSQL-1, Line 50
Violation of PRIMARY KEY constraint 'PK_QALogos'. Cannot insert duplicate key
in object 'dbo.QALogos'.
The statement has been terminated.
Mon 12/27/2010 
10:12 AM
Mon 12/27/2010 
10:12 AM
st-prodsql-2 _ReferralProdArchive "C:\2005Projects\Statline\StatTrac\Data\Database\Statline.StatTrac.Database.sql" 
----------------------------------- Update Database: _ReferralProdArchive
-----------------------------------
Dropping Procedure sps_rpt_ImportOfferDetail
Creating Procedure sps_rpt_ImportOfferDetail
Dropping Procedure sps_rpt_ImportOfferDetail_Select
Creating Procedure sps_rpt_ImportOfferDetail_Select
Dropping Procedure sps_rpt_ReferralFacilityCompliance
Creating Procedure sps_rpt_ReferralFacilityCompliance
The module 'sps_rpt_ReferralFacilityCompliance' depends on the missing object
'_ReferralDev_DataWarehouse.dbo.sps_GetReportGroupSourceCodeList'. The module
will still be created; however, it cannot run successfully until the object
exists.
-- Bret Knoll 12/27/2010 Error expected because sproc is only used in reporting databases
Dropping Procedure sps_rpt_ReportSearchParameterLookup
Creating Procedure sps_rpt_ReportSearchParameterLookup
Dropping Procedure sps_rpt_QA
Creating Procedure sps_rpt_QA
Dropping Procedure sps_rpt_QAErrorLog_Select
Creating Procedure sps_rpt_QAErrorLog_Select
Dropping Procedure sps_rpt_QATrackingForm_Select
Creating Procedure sps_rpt_QATrackingForm_Select
Dropping Procedure sps_rpt_QAbyError
Creating Procedure sps_rpt_QAbyError
Dropping Procedure sps_rpt_QAbyTrackingNumber
Creating Procedure sps_rpt_QAbyTrackingNumber
Dropping Procedure sps_rpt_QAScorebyEmployee
Creating Procedure sps_rpt_QAScorebyEmployee
Mon 12/27/2010 
10:12 AM
Mon 12/27/2010 
10:12 AM
st-prodsql-2 _ReferralProdReport "C:\2005Projects\Statline\StatTrac\Data\Database\Statline.StatTrac.Database.sql" 
----------------------------------- Update Database: _ReferralProdReport
-----------------------------------
Dropping Procedure sps_rpt_ImportOfferDetail
Creating Procedure sps_rpt_ImportOfferDetail
Dropping Procedure sps_rpt_ImportOfferDetail_Select
Creating Procedure sps_rpt_ImportOfferDetail_Select
Dropping Procedure sps_rpt_ReferralFacilityCompliance
Creating Procedure sps_rpt_ReferralFacilityCompliance
The module 'sps_rpt_ReferralFacilityCompliance' depends on the missing object
'_ReferralDev_DataWarehouse.dbo.sps_GetReportGroupSourceCodeList'. The module
will still be created; however, it cannot run successfully until the object
exists.
-- Bret Knoll 12/27/2010 Error expected.
Dropping Procedure sps_rpt_ReportSearchParameterLookup
Creating Procedure sps_rpt_ReportSearchParameterLookup
Dropping Procedure sps_rpt_QA
Creating Procedure sps_rpt_QA
Dropping Procedure sps_rpt_QAErrorLog_Select
Creating Procedure sps_rpt_QAErrorLog_Select
Dropping Procedure sps_rpt_QATrackingForm_Select
Creating Procedure sps_rpt_QATrackingForm_Select
Dropping Procedure sps_rpt_QAbyError
Creating Procedure sps_rpt_QAbyError
Dropping Procedure sps_rpt_QAbyTrackingNumber
Creating Procedure sps_rpt_QAbyTrackingNumber
Dropping Procedure sps_rpt_QAScorebyEmployee
Creating Procedure sps_rpt_QAScorebyEmployee
Mon 12/27/2010 
10:12 AM
Mon 12/27/2010 
10:12 AM
st-prodsql-2 _ReferralAuditTrail "C:\2005Projects\Statline\StatTrac\Data\Database\Statline.StatTrac.Database.sql" 
----------------------------------- Update Database: _ReferralAuditTrail
-----------------------------------
Dropping Procedure sps_rpt_ImportOfferDetail
Creating Procedure sps_rpt_ImportOfferDetail
Dropping Procedure sps_rpt_ImportOfferDetail_Select
Creating Procedure sps_rpt_ImportOfferDetail_Select
The module 'sps_rpt_ImportOfferDetail_Select' depends on the missing object
'SPS_RPT_CHECKCUSTOMREPORTUSERORG'. The module will still be created; however,
it cannot run successfully until the object exists.
-- Bret Knoll 12/27/2010 Error Ok.
Dropping Procedure sps_rpt_ReferralFacilityCompliance
Creating Procedure sps_rpt_ReferralFacilityCompliance
The module 'sps_rpt_ReferralFacilityCompliance' depends on the missing object
'fn_GetOrganizationCustomReport'. The module will still be created; however,
it cannot run successfully until the object exists.
-- Bret Knoll 12/27/2010 Error Ok.
The module 'sps_rpt_ReferralFacilityCompliance' depends on the missing object
'_ReferralDev_DataWarehouse.dbo.sps_GetReportGroupSourceCodeList'. The module
will still be created; however, it cannot run successfully until the object
exists.
-- Bret Knoll 12/27/2010 Error Ok.
The module 'sps_rpt_ReferralFacilityCompliance_Select' depends on the missing
object 'fn_GetOrganizationCustomReport'. The module will still be created;
however, it cannot run successfully until the object exists.
-- Bret Knoll 12/27/2010 Error Ok.
Dropping Procedure sps_rpt_ReportSearchParameterLookup
Creating Procedure sps_rpt_ReportSearchParameterLookup
Dropping Procedure sps_rpt_QA
Creating Procedure sps_rpt_QA
Dropping Procedure sps_rpt_QAErrorLog_Select
Creating Procedure sps_rpt_QAErrorLog_Select
Dropping Procedure sps_rpt_QATrackingForm_Select
Creating Procedure sps_rpt_QATrackingForm_Select
Dropping Procedure sps_rpt_QAbyError
Creating Procedure sps_rpt_QAbyError
Dropping Procedure sps_rpt_QAbyTrackingNumber
Creating Procedure sps_rpt_QAbyTrackingNumber
Dropping Procedure sps_rpt_QAScorebyEmployee
Creating Procedure sps_rpt_QAScorebyEmployee
Mon 12/27/2010 
10:12 AM
