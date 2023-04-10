Option Strict Off
Option Explicit On
Module modStatConstant
	
	'03/06/03 drh - Database Connection Variables
	Public Const cnSqlUser As String = "stattracadmin"
	Public Const cnSqlPW As String = "not4generalrelease"
	
	'Statline Org ID
	Public Const STATLINE_ID As Short = 194
	
	'Org Types
	Public Const PROCUREMENT_ORG As Short = 1
	
	'Call Type Constants
	Public Const REFERRAL As Short = 1
	Public Const Message As Short = 2
	Public Const NOCALL As Short = 3
    Public Const IMPORT As Short = 4

    '04/21/2011 ccarroll - Add OASIS for Report Source Code Type 
    Public Const OASIS As Short = 6
    'mds 10/13/03: added INFORMATION call type for Coalition on Donation calls
    Public Const INFORMATION_Renamed As Short = 5

    'Referral Grid Column Constants
    Public Const OPTIONS As Short = 1
	Public Const GIVEN As Short = 2
	Public Const APPROACHED As Short = 3
	Public Const CONSENT As Short = 4
	Public Const CONVERT As Short = 5
	
	'Referral grid option types
    Public Const ORGAN As Short = 1
    Public Const BONE As Short = 2
    Public Const TISSUE As Short = 3
    Public Const SKIN As Short = 4
    Public Const VALVES As Short = 5
    Public Const EYES As Short = 6
    Public Const RESEARCH As Short = 7
    Public Const LASTGRIDROW As Short = 7
    Public Const FIRSTGRIDROW As Short = 1

	'Vent constants
	Public Const NEVER As Short = 0
	Public Const PREVIOUSLY As Short = 1
	Public Const CURRENT As Short = 2
	
	'Log State Constants
	Public Const NEW_EVENT As Short = 0
	Public Const EXISTING_EVENT As Short = 1
	
	'Log Event Type Constants
	Public Const ALL_TYPES As Short = 0
	Public Const GENERAL As Short = 1
	Public Const INCOMING As Short = 2
	Public Const OUTGOING As Short = 3
	Public Const CONSENT_PENDING As Short = 4
	Public Const RECOVERY_PENDING As Short = 5
	Public Const PAGE_PENDING As Short = 6
	Public Const CONSENT_RESPONSE As Short = 7
	Public Const RECOVERY_RESPONSE As Short = 8
	Public Const PAGE_RESPONSE As Short = 9
	Public Const NO_CONSENT_RESPONSE As Short = 10
	Public Const NO_RECOVERY_RESPONSE As Short = 11
	Public Const NO_PAGE_RESPONSE As Short = 12
	Public Const CORONER_CASE As Short = 13
	Public Const CALLBACK_PENDING As Short = 14
	Public Const SECONDARY_PENDING As Short = 15
	Public Const SECONDARY_RESPONSE As Short = 16
	Public Const NOTE As Short = 17
	'10/12/01 drh
	Public Const FAX_PENDING As Short = 18
	Public Const OUTGOING_FAX As Short = 19
	
	'FSProj 6/25/02 drh
	Public Const FUNERAL_HOME As Short = 20
	
	'12/1/04 - SAP
	Public Const EMAIL_PENDING As Short = 21
	Public Const EMAIL_RESPONSE As Short = 22
	'5/27/05 - SAP
	Public Const UNMATCHED_RESPONSE As Short = 23
	'Public Const APPROACH_PENDING = 24
	'Public Const APPROACH_ATTEMPTED_NO_OUTCOME = 25
	'Public Const APPROACH_OUTCOME = 26
	'Public Const SECONDARY_ATTEMPTED_NO_OUTCOME = 27
	'7/18/2005 - T.T
	Public Const Case_Update As Short = 24
	
	'ccarroll 06/06/2006 Added QA note
	Public Const QA_Note As Short = 25
	
	'03/07/2007
	Public Const Manual_Registry_Checked As Short = 26
	Public Const Consent_Obtained As Short = 27
	Public Const Paperwork_Completed As Short = 28
	Public Const Paperwork_Faxed As Short = 29
	Public Const Family_Approached As Short = 30
	Public Const Client_Consent_Outcome As Short = 31
	Public Const Client_Recovery_Outcome As Short = 32
	
	'ccarroll 06/17/2008 StatTrac 8.4.6
	Public Const Incoming_Secondary As Short = 34
	Public Const IM_Conversation As Short = 35
	
	'bret 03/12/2009 StatTrac 8.4.8
	Public Const Donor_Card As Short = 36
	Public Const DonorNet_Acceptance As Short = 37
	Public Const DonorNet_Decline As Short = 38
	Public Const Acknowledge_to_Evaluate As Short = 39
	Public Const Labs_Pending As Short = 40
	Public Const Labs_Received As Short = 41
    Public Const No_Labs_Received As Short = 42

    'ccarroll 06/08/2011 StatTrac CCRST100
    Public Const ONLINE_REVIEW_PENDING As Short = 43
    Public Const ONLINE_REVIEW_RESPONSE As Short = 44

    'ccarroll 09/06/2011 CCRST151
    Public Const DECLARED_CTOD_PENDING As Short = 45
    Public Const DECLARED_CTOD_CONFIRMED As Short = 46

    'ccarroll 04/27/2012 CCRST169
    Public Const CASE_HAND_OFF As Short = 47
    Public Const EMAIL_SENT As Short = 51
    Public Const PAGE_SENT As Short = 52

    'ccarroll 07/16/2014 CCRST175
    Public Const ORGAN_MED_RO_PENDING As Short = 48
    Public Const ORGAN_MED_RO_CONFIRMED As Short = 49

	'mberenson 12/22/2015 CCRST228
	Public Const Process_Exception As Short = 50

	'asavin 2/5/2020 CCRST309
	Public Const Verification_Form_Sent As Short = 53

	'pscheichenost 07/01/2020 CCRST316/325
	Public Const INCOMING_EREFERRAL As Short = 54
	Public Const PENDING_EREFERRAL_REVIEW As Short = 55
	Public Const EREFERRAL_RESPONSE As Short = 56

	Public Const INCOMPLETES As Short = 100
	
	'7/5/01 drh Secondary Alerts, Secondary WIP, Secondary Activity
	Public Const SECONDARY_ALERT As Short = 200
	Public Const SECONDARY_WIP As Short = 201
    Public Const SECONDARY_ACTIVITY As Short = 202
    Public Const FAMILY_SERVICES_ALERT As Short = 4000



    'Report Constants
    Public Const MESSAGE_DETAIL As Short = 1
	Public Const IMPORT_DETAIL As Short = 2
	Public Const REFERRAL_DETAIL As Short = 3
	Public Const REFERRAL_ACTIVITY As Short = 4
	Public Const REFERRAL_SUMMARY As Short = 5
	Public Const IMPORT_ACTIVITY As Short = 6
	Public Const MESSAGE_ACTIVITY As Short = 7
	Public Const REFERRAL_STATISTICS As Short = 9
	Public Const REFERRAL_COUNTS1 As Short = 22
	Public Const REFERRAL_COUNTS2 As Short = 23
	Public Const MSG_IMPORT_COUNTS As Short = 24
	
	'Log Event Form Constants
	Public Const EVENT_ONLY As Short = 1
	Public Const ONCALL_ONLY As Short = 2
	Public Const EVENT_ONCALL As Short = 3
	
	'Misc Constants
	Public Const ALL_ORG_TYPES As Short = 0
	Public Const ALL_STATES As Short = 0
	Public Const ALL_ORGS As Short = 0
	
	
	'Approach Type Constants
	Public Const NOT_APPROACHED As Short = 1
	Public Const PREREF_COUPLED As Short = 2
	Public Const PREREF_DECOUPLED As Short = 3
	Public Const POSTREF_COUPLED As Short = 4
	Public Const POSTREF_DECOUPLED As Short = 5
	Public Const FAMILY_INITIATED As Short = 6
	Public Const UNKNOWN As Short = 7
	'10/18/01 drh
	Public Const Registry As Short = 8
	
	'Referral Type constants
	Public Const ORGAN_TISSUE_EYE As Short = 1
	Public Const TISSUE_EYE As Short = 2
	Public Const EYE_ONLY As Short = 3
    Public Const RULEOUT As Short = 4
    Public Const ORGAN_TISSUE As Short = 5
    Public Const ORGAN_EYE As Short = 6
    Public Const ORGAN_ As Short = 7
    Public Const TISSUE_ As Short = 8
	
	'Referral Type description constants. v 8.0,  5/27/05 - SAP
	Public Const ORGAN_TISSUE_EYE_DESC As String = "Organ/Tissue/Eye"
	Public Const TISSUE_EYE_DESC As String = "Tissue/Eye"
	Public Const EYE_ONLY_DESC As String = "Eyes Only"
    Public Const RULEOUT_DESC As String = "Ruleout"
    Public Const ORGAN_TISSUE_DESC As String = "Organ/Tissue"
    Public Const ORGAN_EYE_DESC As String = "Organ/Eye"
    Public Const ORGAN_DESC As String = "Organ"
    Public Const TISSUE_DESC As String = "Tissue"
	
	'Appropriate constants
	Public Const APPROP_YES As Short = 1
	Public Const APPROP_AGE As Short = 2
	Public Const APPROP_HIGH_RISK As Short = 3
	Public Const APPROP_MED_RO As Short = 4
	Public Const APPROP_NOT_APPROPRIATE As Short = 5
    Public Const APPROP_PREVIOUS_VENT As Short = 6
    Public Const APPROP_BLANK As Short = -1
	
	'Approach constants
	Public Const APRCH_YES As Short = 1
	Public Const APRCH_UNKNOWN As Short = 2
	Public Const APRCH_FAMILY_UNAVAILABLE As Short = 3
	Public Const APRCH_CORONER_DENY As Short = 4
	Public Const APRCH_ARREST As Short = 5
	Public Const APRCH_MED_RO As Short = 6
	Public Const APRCH_LOGISTICS As Short = 7
	Public Const APRCH_NBD As Short = 8
	Public Const APRCH_HIGH_RISK As Short = 9
	Public Const APRCH_UNAPPROACHABLE As Short = 11
	'10/17/01 drh
	Public Const APRCH_YESDMV As Short = 12
    Public Const APRCH_YESREG As Short = 13
    Public Const APRCH_YESDLA As Short = 23
    'Bret 10/11/10
    Public Const APPRCH_SECONDARY_RO As Short = 14
    Public Const APRCH_BLANK As Short = -1


	'Consent constants
	Public Const CONSENT_YES As Short = 1
	Public Const CONSENT_ETHNIC As Short = 2
	Public Const CONSENT_RELIGIOUS As Short = 3
	Public Const CONSENT_EMOTIONAL As Short = 4
	Public Const CONSENT_UNKNOWN As Short = 5
	Public Const CONSENT_PREV_DISCUSSION As Short = 6
	'10/17/01 drh
	Public Const CONSENT_YESDMV As Short = 7
    Public Const CONSENT_YESREG As Short = 8
    Public Const CONSENT_YESDLA As Short = 12
    Public Const CONSENT_BLANK As Short = -1
	
	'Recovery constants
	Public Const RECOVER_YES As Short = 1
	Public Const RECOVER_CORONER_DENY As Short = 2
	Public Const RECOVER_ARREST As Short = 3
	Public Const RECOVER_NBD As Short = 4
	Public Const RECOVER_MED_RO As Short = 5
	Public Const RECOVER_HIGH_RISK As Short = 6
	Public Const RECOVER_LOGISTICS As Short = 7
	Public Const RECOVER_HEART_TXABLE As Short = 8
	Public Const RECOVER_UNKNOWN As Short = 9
	'11/20/01 drh
    Public Const RECOVER_FAMILY_RO As Short = 10
    Public Const RECOVER_CNR As Short = 11
    Public Const RECOVER_BLANK As Short = -1
	
	'Phone type constants
	Public Const CELLULAR_NUM As Short = 1
	Public Const PAGER_NUM As Short = 2
	Public Const WORK_NUM As Short = 3
	Public Const HOME_NUM As Short = 4
	Public Const FAX_NUM As Short = 5
	
	
	'Reference constants
	Public Const REF_MSG_NAME As Short = 1
	Public Const REF_MSG_ORG As Short = 2
	
	'Misc colors
	Public Const COLOR_GREEN As Integer = &H8000
	Public Const COLOR_RED As Integer = &HC0
	Public Const COLOR_BLACK As Integer = &H0
	Public Const COLOR_BLUE As Integer = &HFF0000
	
	'Triage Level
	Public Const VENT_ONLY As Short = 0
	Public Const AGE_ONLY As Short = 1
	Public Const VENT_AGE_ONLY As Short = 2
	Public Const VENT_AGE_MRO As Short = 3
	
	'MRO Level
	Public Const ADVANCED_MRO As Short = 0
	Public Const STANDARD_MRO As Short = 1
	Public Const NO_MRO As Short = 2
	
	'Physician Levels
	Public Const MD_NEVER As Short = 0
	Public Const MD_ALWAYS As Short = 1
	Public Const MD_VENT As Short = 2
	
	'Disposition Codes
	Public Const NO_ORGAN_POTENTIAL As Short = 1
	Public Const NEVER_BRAIN_DEAD As Short = 2
	Public Const AGE_RO As Short = 3
	Public Const MEDICAL_RO As Short = 4
	Public Const CORONER_DENY As Short = 5
	Public Const CONSENT_DENIED As Short = 6
	Public Const OTHER As Short = 7
	Public Const RECOVERED As Short = 8
	Public Const DISP_UNKNOWN As Short = 9
	
	
	'System Alert States
	Public Const ALL_ALERTS As Short = 0
	Public Const UNRESOLVED_ALERTS As Short = 1
	Public Const RESOLVED_ALERTS As Short = 2
	
	'Referral Tab Constants
	Public Const DISPOSITION_TAB As Short = 0
	Public Const RESULTS_TAB As Short = 1
	Public Const CORONER_TAB As Short = 2

	'Person Types
	Public Const PHYSICIAN As Short = 73
	Public Const MDPHYSICIAN As Short = 74
	Public Const DOPHYSICIAN As Short = 75
	Public Const PAPHYSICIAN As Short = 76
	
	'Auto-pending constants
	Public Const PENDING_HOSPITAL As Short = 0
	Public Const PENDING_AGENCY As Short = 1
	
	'Prev Vent constants
	Public Const PREVVENT_OTE As Short = 0
	Public Const PREVVENT_TE As Short = 1
	
	'Approach prompt constants
	Public Const PROMPT As Short = 0
	Public Const NO_PROMPT As Short = 1
	
	'Criteria schedule group contact constants
	Public Const NO_CONTACT_ON_DENY As Short = 100
	Public Const CONTACT_ON_CONSENT As Short = 101
	Public Const CONTACT_ON_APPROACH As Short = 102
	Public Const CONTACT_ON_CORONER As Short = 103
	Public Const CONTACT_ON_STATLINE_SECONDARY As Short = 104
	Public Const CONTACT_ON_STATLINE_CONSENT As Short = 105
	Public Const CONTACT_ON_CORONER_ONLY As Short = 106
	
	'Consent status constants
	Public Const CREATE_CONSENT_PENDING As Short = 0
	Public Const CONSENT_PENDING_CURRENT As Short = 1
	Public Const CONSENT_PENDING_CLOSED As Short = 2
	Public Const STATLINE_CONSENT_PENDING As Short = 0
	
	'Secondary status constants
	Public Const CREATE_SECONDARY_PENDING As Short = 0
	Public Const SECONDARY_PENDING_CURRENT As Short = 1
	Public Const SECONDARY_PENDING_CLOSED As Short = 2
	
	'7/6/01 drh Family Services Stage Priority Timer Variables
	Public Const FS_OPEN_PRI1 As Short = 20
	Public Const FS_OPEN_PRI2 As Short = 10
	Public Const FS_SYSEVENT_PRI1 As Short = 20
	Public Const FS_SYSEVENT_PRI2 As Short = 10
	Public Const FS_SECCOMP_PRI1 As Short = 20
	Public Const FS_SECCOMP_PRI2 As Short = 10
	Public Const FS_APPROACH_PRI1 As Short = 20
	Public Const FS_APPROACH_PRI2 As Short = 10
	
	'7/6/01 drh Family Services Security Constants
	Public Const TRIAGE_COORDINATOR As Short = 66
	Public Const FAMILY_SERVICES_COORDINATOR As Short = 81 '"Family Services Coordinator"
	
	'FSProj drh 4/25/02 - FS Historical Criteria
	Public Const WORKING_CRITERIA As Short = 0
	Public Const CURRENT_CRITERIA As Short = 1
	Public Const HISTORICAL_CRITERIA As Short = 2
	Public Const ORIGINAL_CRITERIA As Short = 3
	
	'FSProj drh 5/2/02 - FS Historical Service Level
	Public Const WORKING_SERVICELEVEL As Short = 0
	Public Const CURRENT_SERVICELEVEL As Short = 1
	Public Const HISTORICAL_SERVICELEVEL As Short = 2
	Public Const ORIGINAL_SERVICELEVEL As Short = 3
	
	'FSProj 5/2/02 - Cuttof date for using ORIGINAL_CRITERIA and ORIGINAL_SERVICELEVEL
	Public Const HISTORICAL_CUTOFF As String = "8/13/02 06:31" '"8/4/02"   'KEEP THIS FOR _ReferralDev DB! "5/1/02"
	
	'FSProj 6/15/02 drh - Control type constants
	Public Const CTL_TEXT As Short = 0
	Public Const CTL_COMBOID As Short = 1
	Public Const CTL_COMBOTEXT As Short = 2
	Public Const CTL_RICHTEXT As Short = 3
	Public Const CTL_ITEMLISTCTL As Short = 4 'drh FSMod 06/09/03
	Public Const CTL_CHECKBOXCTL As Short = 5 'drh FSMod 06/19/03
	
	'10/02/02 drh
	Public Const AUDIT_CREATE As Short = 1
	Public Const AUDIT_REVIEW As Short = 2
	Public Const AUDIT_MODIFY As Short = 3
	Public Const AUDIT_DELETE As Short = 4
	Public Const AUDIT_UNKNOWN As Short = 5
	
	'drh FSMOD 05/20/03
	Public Const SEC_DISPO_CUTOFF_CALLID As Integer = 3333825
	
	'01/06/04 mds Heart Beat constants
	Public Const HEART_BEAT_YES As Short = 1
	Public Const HEART_BEAT_NO As Short = 0
	
	'01/06/04 mds Vent Values
	Public Const VENT_CURRENT As Short = 2
	Public Const VENT_PREV As Short = 1
	Public Const VENT_NEVER As Short = 0

	'Database field names for LogEvent table.  (Created for modStatSave.SaveLogEvent) 12/21/04 - SAP
	Public Const LOGEVENT_FIELD_CALLID As Short = 0
	Public Const LOGEVENT_FIELD_LOGEVENTTYPEID As Short = 1
	Public Const LOGEVENT_FIELD_LOGEVENTNAME As Short = 2
	Public Const LOGEVENT_FIELD_LOGEVENTPHONE As Short = 3
	Public Const LOGEVENT_FIELD_LOGEVENTORG As Short = 4
	Public Const LOGEVENT_FIELD_LOGEVENTDESC As Short = 5
	Public Const LOGEVENT_FIELD_STATEMPLOYEEID As Short = 6
	Public Const LOGEVENT_FIELD_LOGEVENTDATETIME As Short = 7
	Public Const LOGEVENT_FIELD_LOGEVENTCALLBACKPENDING As Short = 8
	Public Const LOGEVENT_FIELD_ORGANIZATIONID As Short = 9
	Public Const LOGEVENT_FIELD_SCHEDULEGROUPID As Short = 10
	Public Const LOGEVENT_FIELD_PERSONID As Short = 11
	Public Const LOGEVENT_FIELD_PHONEID As Short = 12
	Public Const LOGEVENT_FIELD_LOGEVENTCONTACTCONFIRMED As Short = 13
	Public Const LOGEVENT_FIELD_LOGEVENTCALLOUTDATETIME As Short = 14
	Public Const LOGEVENT_FIELD_LOGEVENTNUMBER As Short = 15
	Public Const LOGEVENT_FIELD_LASTSTATEMPLOYEEID As Short = 16 'bret 06/05/07 added 16 - 18 for AuditLog and DeleteFlag
	Public Const LOGEVENT_FIELD_LOGEVENTDELETED As Short = 17
	Public Const LOGEVENT_FIELD_LOGEVENTID As Short = 18
	
	'Constants for PhoneTypes. 12/21/04 - SAP
	Public Const PHONE_TYPE_CELLULAR As Short = 1
	Public Const PHONE_TYPE_PAGER_PRIMARY As Short = 2
	Public Const PHONE_TYPE_WORK As Short = 3
	Public Const PHONE_TYPE_HOME As Short = 4
	Public Const PHONE_TYPE_FAX As Short = 5
	Public Const PHONE_TYPE_PAGER_BACKUP As Short = 6
	Public Const PHONE_TYPE_PAGER_ALPHA As Short = 7
	Public Const PHONE_TYPE_PAGER_AUTORESPONSE As Short = 8
	Public Const PHONE_TYPE_FAX_HOME As Short = 9
	Public Const PHONE_TYPE_FAX_OFFICE As Short = 10
	Public Const PHONE_TYPE_EMAIL As Short = 11
	
	'Constants for Dashboard Tabs.  v. 8.0, 5/24/05 - SAP
	Public Const DASHBOARD_TAB_REFERRAL As Short = 0
	Public Const DASHBOARD_TAB_MESSAGES As Short = 1
	Public Const DASHBOARD_TAB_NO_CALLS As Short = 2
	Public Const DASHBOARD_TAB_CONSENTS_PENDING As Short = 3
	Public Const DASHBOARD_TAB_FAMILY_SERVICES As Short = 4
	Public Const DASHBOARD_TAB_INFO As Short = 5
	Public Const DASHBOARD_TAB_UPDATES As Short = 6
	Public Const DASHBOARD_TAB_RECYCLE As Short = 7
	
	'Constant for colloids T.T 03/20/2007
    Public Const ColloidTime As Date = #3/20/2007 1:00:00 PM#
End Module