create file 
Mon 12/13/2010 
10:00 AM
st-prodsql-1 _ReferralProd "C:\Projects\Statline\StatTrac\Development\Main\Database\Queries\Statline.StatTrac.database.sql" 
CREATE NONCLUSTERED INDEX
[IDX_LogEvent_LogEventCallbackPending_LogEventTypeID]
Dec 13 2010 10:03AM
CREATE NONCLUSTERED INDEX
[IDX_LogEvent_LogEventCallbackPending_LogEventTypeID]
Dec 13 2010 10:03AM
CREATE NONCLUSTERED INDEX [IDX_Call_CallTemp] ON [dbo].[Call]
Dec 13 2010 10:04AM
DROP INDEX [IDX_CallTempSavedByID_CallTemp]
Dec 13 2010 10:04AM
DROP INDEX [IDX_Call_CallNumber]
Dec 13 2010 10:04AM
CREATE NONCLUSTERED INDEX [IDX_LogEvent_CallID_SchedulGroupID]
Dec 13 2010 10:04AM
CREATE NONCLUSTERED INDEX [IDX_LogEvent_CallID]
Dec 13 2010 10:05AM
DROP INDEX [IDX_Call_CallActive_CallDateTime_SourceCodeID]
Dec 13 2010 10:05AM
CREATE NONCLUSTERED INDEX [IDX_Call_CallDateTime_CallID_CallActive]
CREATE NONCLUSTERED INDEX [IDX_Call_Callid]
Dec 13 2010 10:05AM
DROP INDEX [IDX_Referral_ReferralDonorLastName]
Dec 13 2010 10:05AM
CREATE NONCLUSTERED INDEX [IDX_Referral_ReferralDonorLastName]
Dec 13 2010 10:05AM
WI 8614 Updating FamilyServicesExpiredEvents from 30 to 180 minutes
Dec 13 2010 10:05AM
(1 row affected)
 Add Doripenem antibiotic to the FS Antibiotic list.
Dec 13 2010 10:05AM
(1 row affected)
Fixing spelling of Ceclor 	anitbiotic
Dec 13 2010 10:05AM
(1 row affected)
Creating Procedure SelectRegistryStatusType
Creating Procedure SelectRegistryStatus
Creating Procedure SelectSecondaryApproach
Creating Procedure SelectOrganization
Dec 13 2010 10:05AM
Creating Procedure SelectWebPerson
Dec 13 2010 10:05AM
Creating Procedure SelectServiceLevelSecondaryCtls
Dec 13 2010 10:05AM
Creating Procedure SelectCounty
Dec 13 2010 10:05AM
Creating Procedure SelectIndication
Dec 13 2010 10:05AM
Creating Procedure SelectKeyCode
Dec 13 2010 10:05AM
Creating Procedure SelectDictionaryItem
Dec 13 2010 10:05AM
Creating Procedure SelectOrganizationType
Dec 13 2010 10:05AM
Creating Procedure SelectMessageType
Dec 13 2010 10:05AM
Creating Procedure SelectReference
Dec 13 2010 10:05AM
Creating Procedure SelectNoCallType
Dec 13 2010 10:05AM
Creating Procedure SelectCauseOfDeath
Dec 13 2010 10:05AM
Creating Procedure SelectRotationOrganization
Dec 13 2010 10:05AM
Creating Procedure SelectRotation
Dec 13 2010 10:05AM
Creating Procedure SelectRotationAlerts
Dec 13 2010 10:05AM
Creating Procedure SelectRotationScheduleGroup
Dec 13 2010 10:05AM
Creating Procedure SelectRotationReportGroup
Dec 13 2010 10:05AM
Creating Procedure SelectRotationSourceCode
Dec 13 2010 10:05AM
Creating Procedure SelectRotationCriteria
Dec 13 2010 10:05AM
Creating Procedure SelectScheduleGroup
Dec 13 2010 10:05AM
Creating Procedure SelectCriteria
Dec 13 2010 10:05AM
Creating Procedure SelectDynamicDonorCategory
Dec 13 2010 10:05AM
Creating Procedure SelectAlert
Dec 13 2010 10:05AM
Creating Procedure SelectPersonType
Dec 13 2010 10:05AM
Creating Procedure SelectSubLocation
Dec 13 2010 10:05AM
Creating Procedure SelectNOK
Dec 13 2010 10:05AM
Creating Procedure SelectState
Dec 13 2010 10:05AM
Creating Procedure SelectCallCriteria
Dec 13 2010 10:05AM
Creating Procedure SelectMessage
Dec 13 2010 10:05AM
Creating Procedure SelectNoCall
Dec 13 2010 10:05AM
Creating Procedure SelectLogEvent
Creating Procedure SelectReferral
Dec 13 2010 10:05AM
Dropping Procedure: spi_CallRecycleRestore
Creating Procedure: spi_CallRecycleRestore
Mon 12/13/2010 
10:03 AM
Mon 12/13/2010 
10:03 AM
st-prodsql-2 _ReferralProdArchive "C:\Projects\Statline\StatTrac\Development\Main\Database\Queries\Statline.StatTrac.database.sql" 
CREATE NONCLUSTERED INDEX
[IDX_LogEvent_LogEventCallbackPending_LogEventTypeID]
Dec 13 2010 10:05AM
CREATE NONCLUSTERED INDEX
[IDX_LogEvent_LogEventCallbackPending_LogEventTypeID]
Dec 13 2010 10:05AM
CREATE NONCLUSTERED INDEX [IDX_Call_CallTemp] ON [dbo].[Call]
Dec 13 2010 10:08AM
DROP INDEX [IDX_CallTempSavedByID_CallTemp]
Dec 13 2010 10:08AM
CREATE NONCLUSTERED INDEX [IDX_LogEvent_CallID_SchedulGroupID]
Dec 13 2010 10:08AM
CREATE NONCLUSTERED INDEX [IDX_LogEvent_CallID]
Dec 13 2010 10:09AM
DROP INDEX [ScheduleItemEndTimeID]
Dec 13 2010 10:09AM
DROP INDEX [ScheduleItemStartTimeID]
Dec 13 2010 10:09AM
CREATE NONCLUSTERED INDEX [IDX_Call_CallDateTime_CallID_CallActive]
DROP INDEX [DonorLastName]
Dec 13 2010 10:09AM
CREATE NONCLUSTERED INDEX [IDX_Call_Callid]
Dec 13 2010 10:09AM
CREATE NONCLUSTERED INDEX [IDX_Referral_ReferralDonorLastName]
Dec 13 2010 10:10AM
WI 8614 Updating FamilyServicesExpiredEvents from 30 to 180 minutes
Dec 13 2010 10:10AM
(1 row affected)
Msg 213, Level 16, State 1, Server ST-PRODSQL-2, Line 16
Column name or number of supplied values does not match table definition.
Note: Bret Knoll 12/13/2010 10:26 This is the insert script on a replicated table. The data is pushed from production

Creating Procedure SelectRegistryStatusType
Creating Procedure SelectRegistryStatus
Creating Procedure SelectSecondaryApproach
Creating Procedure SelectOrganization
Dec 13 2010 10:10AM
Creating Procedure SelectWebPerson
Dec 13 2010 10:10AM
Creating Procedure SelectServiceLevelSecondaryCtls
Dec 13 2010 10:10AM
Creating Procedure SelectCounty
Dec 13 2010 10:10AM
Creating Procedure SelectIndication
Dec 13 2010 10:10AM
Creating Procedure SelectKeyCode
Dec 13 2010 10:10AM
Creating Procedure SelectDictionaryItem
Dec 13 2010 10:10AM
Creating Procedure SelectOrganizationType
Dec 13 2010 10:10AM
Creating Procedure SelectMessageType
Dec 13 2010 10:10AM
Creating Procedure SelectReference
Dec 13 2010 10:10AM
Creating Procedure SelectNoCallType
Dec 13 2010 10:10AM
Creating Procedure SelectCauseOfDeath
Dec 13 2010 10:10AM
Creating Procedure SelectRotationOrganization
Dec 13 2010 10:10AM
Creating Procedure SelectRotation
Dec 13 2010 10:10AM
Creating Procedure SelectRotationAlerts
Dec 13 2010 10:10AM
Creating Procedure SelectRotationScheduleGroup
Dec 13 2010 10:10AM
Creating Procedure SelectRotationReportGroup
Dec 13 2010 10:10AM
Creating Procedure SelectRotationSourceCode
Dec 13 2010 10:10AM
Creating Procedure SelectRotationCriteria
Dec 13 2010 10:10AM
Creating Procedure SelectScheduleGroup
Dec 13 2010 10:10AM
Creating Procedure SelectCriteria
Dec 13 2010 10:10AM
Creating Procedure SelectDynamicDonorCategory
Dec 13 2010 10:10AM
Creating Procedure SelectAlert
Dec 13 2010 10:10AM
Creating Procedure SelectPersonType
Dec 13 2010 10:10AM
Creating Procedure SelectSubLocation
Dec 13 2010 10:10AM
Creating Procedure SelectNOK
Dec 13 2010 10:10AM
Creating Procedure SelectState
Dec 13 2010 10:10AM
Creating Procedure SelectCallCriteria
Dec 13 2010 10:10AM
Creating Procedure SelectMessage
Dec 13 2010 10:10AM
Creating Procedure SelectNoCall
Dec 13 2010 10:10AM
Creating Procedure SelectLogEvent
Creating Procedure SelectReferral
Dec 13 2010 10:10AM
Dropping Procedure: spi_CallRecycleRestore
Creating Procedure: spi_CallRecycleRestore
Mon 12/13/2010 
10:07 AM
Mon 12/13/2010 
10:07 AM
st-prodsql-2 _ReferralProdReport "C:\Projects\Statline\StatTrac\Development\Main\Database\Queries\Statline.StatTrac.database.sql" 
Msg 213, Level 16, State 1, Server ST-PRODSQL-2, Line 16
Column name or number of supplied values does not match table definition.
Note: Bret Knoll 12/13/2010 10:26 This is the insert script on a replicated table. The data is pushed from production
Creating Procedure SelectRegistryStatusType
Creating Procedure SelectRegistryStatus
Creating Procedure SelectSecondaryApproach
Creating Procedure SelectOrganization
Dec 13 2010 10:10AM
Creating Procedure SelectWebPerson
Dec 13 2010 10:10AM
Creating Procedure SelectServiceLevelSecondaryCtls
Dec 13 2010 10:10AM
Creating Procedure SelectCounty
Dec 13 2010 10:10AM
Creating Procedure SelectIndication
Dec 13 2010 10:10AM
Creating Procedure SelectKeyCode
Dec 13 2010 10:10AM
Creating Procedure SelectDictionaryItem
Dec 13 2010 10:10AM
Creating Procedure SelectOrganizationType
Dec 13 2010 10:10AM
Creating Procedure SelectMessageType
Dec 13 2010 10:10AM
Creating Procedure SelectReference
Dec 13 2010 10:10AM
Creating Procedure SelectNoCallType
Dec 13 2010 10:10AM
Creating Procedure SelectCauseOfDeath
Dec 13 2010 10:10AM
Creating Procedure SelectRotationOrganization
Dec 13 2010 10:10AM
Creating Procedure SelectRotation
Dec 13 2010 10:10AM
Creating Procedure SelectRotationAlerts
Dec 13 2010 10:10AM
Creating Procedure SelectRotationScheduleGroup
Dec 13 2010 10:10AM
Creating Procedure SelectRotationReportGroup
Dec 13 2010 10:10AM
Creating Procedure SelectRotationSourceCode
Dec 13 2010 10:10AM
Creating Procedure SelectRotationCriteria
Dec 13 2010 10:10AM
Creating Procedure SelectScheduleGroup
Dec 13 2010 10:10AM
Creating Procedure SelectCriteria
Dec 13 2010 10:10AM
Creating Procedure SelectDynamicDonorCategory
Dec 13 2010 10:10AM
Creating Procedure SelectAlert
Dec 13 2010 10:10AM
Creating Procedure SelectPersonType
Dec 13 2010 10:10AM
Creating Procedure SelectSubLocation
Dec 13 2010 10:10AM
Creating Procedure SelectNOK
Dec 13 2010 10:10AM
Creating Procedure SelectState
Dec 13 2010 10:10AM
Creating Procedure SelectCallCriteria
Dec 13 2010 10:10AM
Creating Procedure SelectMessage
Dec 13 2010 10:10AM
Creating Procedure SelectNoCall
Dec 13 2010 10:10AM
Creating Procedure SelectLogEvent
Creating Procedure SelectReferral
Dec 13 2010 10:10AM
Dropping Procedure: spi_CallRecycleRestore
Creating Procedure: spi_CallRecycleRestore
Mon 12/13/2010 
10:07 AM
Mon 12/13/2010 
10:07 AM
st-prodsql-1 _ReferralProd "C:\2005Projects\Statline\StatTrac\Data\Database\Statline.StatTrac.Database.sql" 
Dropping procedure [sps_DonorTracReferralFS]
Dec 13 2010 10:10AM
Creating procedure [sps_DonorTracReferralFS]
Dec 13 2010 10:10AM
Mon 12/13/2010 
10:07 AM
Mon 12/13/2010 
10:07 AM
st-statrepsql _ReferralProdArchive "C:\2005Projects\Statline\StatTrac\Data\Database\Statline.StatTrac.Database.sql" 
[SQL Native Client]Named Pipes Provider: Could not open a connection to SQL
Server [2].
[SQL Native Client]Login timeout expired
[SQL Native Client]An error has occurred while establishing a connection to
the server. When connecting to SQL Server 2005, this failure may be caused by
the fact that under the default settings SQL Server does not allow remote
connections.
Note: Bret 12/13/2010 this was reran and the results are below.
Mon 12/13/2010 
10:07 AM
Mon 12/13/2010 
10:07 AM
st-prodsql-2 _ReferralProdReport "C:\2005Projects\Statline\StatTrac\Data\Database\Statline.StatTrac.Database.sql" 
Dropping procedure [sps_DonorTracReferralFS]
Dec 13 2010 10:10AM
Creating procedure [sps_DonorTracReferralFS]
Dec 13 2010 10:10AM
Mon 12/13/2010 
10:07 AM
Mon 12/13/2010 
10:07 AM
st-prodsql-2 _ReferralAuditTrail "C:\2005Projects\Statline\StatTrac\Data\Database\Statline.StatTrac.Database.sql" 
Creating procedure [sps_DonorTracReferralFS]
Dec 13 2010 10:10AM
Mon 12/13/2010 
10:07 AM
Mon 12/13/2010 
10:07 AM
st-prodsql-2 DMV_CT "C:\2005Projects\Statline\Registry\Data\Database\DMV_Common\Queries\Statline.Registry.DMV_CTRegistry.sql" 
----------------------------------- Update Database: DMV_CT
-----------------------------------
Dropping Procedure: sps_checkregistry_DMVLoad
Creating Procedure: sps_checkregistry_DMVLoad
Mon 12/13/2010 
10:07 AM
Mon 12/13/2010 
10:07 AM
st-prodsql-2 DMV_MA "C:\2005Projects\Statline\Registry\Data\Database\DMV_Common\Queries\Statline.Registry.DMV_MARegistry.sql" 
----------------------------------- Update Database: DMV_MA
-----------------------------------
Dropping Procedure: sps_checkregistry_DMVLoad
Creating Procedure: sps_checkregistry_DMVLoad
Mon 12/13/2010 
10:07 AM
Mon 12/13/2010 
10:07 AM
st-prodsql-2 DMV_ME "C:\2005Projects\Statline\Registry\Data\Database\DMV_Common\Queries\Statline.Registry.DMV_MERegistry.sql" 
----------------------------------- Update Database: DMV_ME
-----------------------------------
Dropping Procedure: sps_checkregistry_DMVLoad
Creating Procedure: sps_checkregistry_DMVLoad
Mon 12/13/2010 
10:07 AM
Mon 12/13/2010 
10:07 AM
st-prodsql-2 DMV_NH "C:\2005Projects\Statline\Registry\Data\Database\DMV_Common\Queries\Statline.Registry.DMV_NHRegistry.sql" 
----------------------------------- Update Database: DMV_NH
-----------------------------------
Dropping Procedure: sps_checkregistry_DMVLoad
Creating Procedure: sps_checkregistry_DMVLoad
Mon 12/13/2010 
10:07 AM
Mon 12/13/2010 
10:07 AM
st-prodsql-2 DMV_RI "C:\2005Projects\Statline\Registry\Data\Database\DMV_Common\Queries\Statline.Registry.DMV_RIRegistry.sql" 
----------------------------------- Update Database: DMV_RI
-----------------------------------
Dropping Procedure: sps_checkregistry_DMVLoad
Creating Procedure: sps_checkregistry_DMVLoad
Mon 12/13/2010 
10:07 AM
Mon 12/13/2010 
10:07 AM
st-prodsql-2 DMV_VT "C:\2005Projects\Statline\Registry\Data\Database\DMV_Common\Queries\Statline.Registry.DMV_VTRegistry.sql" 
----------------------------------- Update Database: DMV_VT
-----------------------------------
Dropping Procedure: sps_checkregistry_DMVLoad
Creating Procedure: sps_checkregistry_DMVLoad
Mon 12/13/2010 
10:08 AM

Note: Bret 12/13/2010 this is the rerun.
create file 
Mon 12/13/2010 
10:20 AM
st-prodsql-1 _ReferralProd "C:\2005Projects\Statline\StatTrac\Data\Database\Statline.StatTrac.Database.sql" 
Dropping procedure [sps_DonorTracReferralFS]
Dec 13 2010 10:23AM
Creating procedure [sps_DonorTracReferralFS]
Dec 13 2010 10:23AM
Mon 12/13/2010 
10:20 AM
Mon 12/13/2010 
10:20 AM
st-prodsql-2 _ReferralProdArchive "C:\2005Projects\Statline\StatTrac\Data\Database\Statline.StatTrac.Database.sql" 
Dropping procedure [sps_DonorTracReferralFS]
Dec 13 2010 10:23AM
Creating procedure [sps_DonorTracReferralFS]
Dec 13 2010 10:23AM
Mon 12/13/2010 
10:20 AM
Mon 12/13/2010 
10:20 AM
st-prodsql-2 _ReferralProdReport "C:\2005Projects\Statline\StatTrac\Data\Database\Statline.StatTrac.Database.sql" 
Dropping procedure [sps_DonorTracReferralFS]
Dec 13 2010 10:23AM
Creating procedure [sps_DonorTracReferralFS]
Dec 13 2010 10:23AM
Mon 12/13/2010 
10:20 AM
Mon 12/13/2010 
10:20 AM
st-prodsql-2 _ReferralAuditTrail "C:\2005Projects\Statline\StatTrac\Data\Database\Statline.StatTrac.Database.sql" 
Dropping procedure [sps_DonorTracReferralFS]
Dec 13 2010 10:23AM
Creating procedure [sps_DonorTracReferralFS]
Dec 13 2010 10:23AM
Mon 12/13/2010 
10:20 AM
Mon 12/13/2010 
10:20 AM
st-prodsql-2 DMV_CT "C:\2005Projects\Statline\Registry\Data\Database\DMV_Common\Queries\Statline.Registry.DMV_CTRegistry.sql" 
----------------------------------- Update Database: DMV_CT
-----------------------------------
Dropping Procedure: sps_checkregistry_DMVLoad
Creating Procedure: sps_checkregistry_DMVLoad
Mon 12/13/2010 
10:20 AM
Mon 12/13/2010 
10:20 AM
st-prodsql-2 DMV_MA "C:\2005Projects\Statline\Registry\Data\Database\DMV_Common\Queries\Statline.Registry.DMV_MARegistry.sql" 
----------------------------------- Update Database: DMV_MA
-----------------------------------
Dropping Procedure: sps_checkregistry_DMVLoad
Creating Procedure: sps_checkregistry_DMVLoad
Mon 12/13/2010 
10:20 AM
Mon 12/13/2010 
10:20 AM
st-prodsql-2 DMV_ME "C:\2005Projects\Statline\Registry\Data\Database\DMV_Common\Queries\Statline.Registry.DMV_MERegistry.sql" 
----------------------------------- Update Database: DMV_ME
-----------------------------------
Dropping Procedure: sps_checkregistry_DMVLoad
Creating Procedure: sps_checkregistry_DMVLoad
Mon 12/13/2010 
10:20 AM
Mon 12/13/2010 
10:20 AM
st-prodsql-2 DMV_NH "C:\2005Projects\Statline\Registry\Data\Database\DMV_Common\Queries\Statline.Registry.DMV_NHRegistry.sql" 
----------------------------------- Update Database: DMV_NH
-----------------------------------
Dropping Procedure: sps_checkregistry_DMVLoad
Creating Procedure: sps_checkregistry_DMVLoad
Mon 12/13/2010 
10:20 AM
Mon 12/13/2010 
10:20 AM
st-prodsql-2 DMV_RI "C:\2005Projects\Statline\Registry\Data\Database\DMV_Common\Queries\Statline.Registry.DMV_RIRegistry.sql" 
----------------------------------- Update Database: DMV_RI
-----------------------------------
Dropping Procedure: sps_checkregistry_DMVLoad
Creating Procedure: sps_checkregistry_DMVLoad
Mon 12/13/2010 
10:20 AM
Mon 12/13/2010 
10:20 AM
st-prodsql-2 DMV_VT "C:\2005Projects\Statline\Registry\Data\Database\DMV_Common\Queries\Statline.Registry.DMV_VTRegistry.sql" 
----------------------------------- Update Database: DMV_VT
-----------------------------------
Dropping Procedure: sps_checkregistry_DMVLoad
Creating Procedure: sps_checkregistry_DMVLoad
Mon 12/13/2010 
10:20 AM
