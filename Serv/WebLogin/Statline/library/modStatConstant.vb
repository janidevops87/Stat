Option Explicit On 
Module modStatConstant

    'Statline Org ID
    Public Const STATLINE_ID = 194

    'Org Types
    Public Const PROCUREMENT_ORG = 1

    'Call Type Constants
    Public Const REFERRAL = 1
    Public Const Message = 2
    Public Const NOCALL = 3
    Public Const IMPORT = 4

    'Referral Grid Column Constants
    Public Const OPTIONS = 1
    Public Const GIVEN = 2
    Public Const APPROACHED = 3
    Public Const CONSENT = 4
    Public Const CONVERT = 5

    'Referral grid option types
    Public Const ORGAN = 1
    Public Const BONE = 2
    Public Const TISSUE = 3
    Public Const SKIN = 4
    Public Const VALVES = 5
    Public Const EYES = 6
    Public Const RESEARCH = 7
    Public Const LASTGRIDROW = 7


    'Vent constants
    Public Const NEVER = 0
    Public Const PREVIOUSLY = 1
    Public Const CURRENT = 2

    'Log State Constants
    Public Const NEW_EVENT = 0
    Public Const EXISTING_EVENT = 1

    'Log Event Type Constants
    Public Const ALL_TYPES = 0
    Public Const GENERAL = 1
    Public Const INCOMING = 2
    Public Const OUTGOING = 3
    Public Const CONSENT_PENDING = 4
    Public Const RECOVERY_PENDING = 5
    Public Const PAGE_PENDING = 6
    Public Const CONSENT_RESPONSE = 7
    Public Const RECOVERY_RESPONSE = 8
    Public Const PAGE_RESPONSE = 9
    Public Const NO_CONSENT_RESPONSE = 10
    Public Const NO_RECOVERY_RESPONSE = 11
    Public Const NO_PAGE_RESPONSE = 12
    Public Const CORONER_CASE = 13
    Public Const CALLBACK_PENDING = 14
    Public Const SECONDARY_PENDING = 15
    Public Const SECONDARY_RESPONSE = 16
    '10/12/01 drh
    Public Const FAX_PENDING = 18
    Public Const OUTGOING_FAX = 19

    'FSProj 6/25/02 drh
    Public Const FUNERAL_HOME = 20

    Public Const INCOMPLETES = 100

    '7/5/01 drh Secondary Alerts, Secondary WIP, Secondary Activity
    Public Const SECONDARY_ALERT = 200
    Public Const SECONDARY_WIP = 201
    Public Const SECONDARY_ACTIVITY = 202



    'Report Constants
    Public Const MESSAGE_DETAIL = 1
    Public Const IMPORT_DETAIL = 2
    Public Const REFERRAL_DETAIL = 3
    Public Const REFERRAL_ACTIVITY = 4
    Public Const REFERRAL_SUMMARY = 5
    Public Const IMPORT_ACTIVITY = 6
    Public Const MESSAGE_ACTIVITY = 7
    Public Const REFERRAL_STATISTICS = 9
    Public Const REFERRAL_COUNTS1 = 22
    Public Const REFERRAL_COUNTS2 = 23
    Public Const MSG_IMPORT_COUNTS = 24

    'Log Event Form Constants
    Public Const EVENT_ONLY = 1
    Public Const ONCALL_ONLY = 2
    Public Const EVENT_ONCALL = 3

    'Misc Constants
    Public Const ALL_ORG_TYPES = 0
    Public Const ALL_STATES = 0
    Public Const ALL_ORGS = 0


    'Approach Type Constants
    Public Const NOT_APPROACHED = 1
    Public Const PREREF_COUPLED = 2
    Public Const PREREF_DECOUPLED = 3
    Public Const POSTREF_COUPLED = 4
    Public Const POSTREF_DECOUPLED = 5
    Public Const FAMILY_INITIATED = 6
    Public Const UNKNOWN = 7
    '10/18/01 drh
    Public Const Registry = 8

    'Referral Type constants
    Public Const ORGAN_TISSUE_EYE = 1
    Public Const TISSUE_EYE = 2
    Public Const EYE_ONLY = 3
    Public Const RULEOUT = 4

    'Appropriate constants
    Public Const APPROP_YES = 1
    Public Const APPROP_AGE = 2
    Public Const APPROP_HIGH_RISK = 3
    Public Const APPROP_MED_RO = 4
    Public Const APPROP_NOT_APPROPRIATE = 5
    Public Const APPROP_PREVIOUS_VENT = 6

    'Approach constants
    Public Const APRCH_YES = 1
    Public Const APRCH_UNKNOWN = 2
    Public Const APRCH_FAMILY_UNAVAILABLE = 3
    Public Const APRCH_CORONER_DENY = 4
    Public Const APRCH_ARREST = 5
    Public Const APRCH_MED_RO = 6
    Public Const APRCH_LOGISTICS = 7
    Public Const APRCH_NBD = 8
    Public Const APRCH_HIGH_RISK = 9
    Public Const APRCH_UNAPPROACHABLE = 11
    '10/17/01 drh
    Public Const APRCH_YESDMV = 12
    Public Const APRCH_YESREG = 13

    'Consent constants
    Public Const CONSENT_YES = 1
    Public Const CONSENT_ETHNIC = 2
    Public Const CONSENT_RELIGIOUS = 3
    Public Const CONSENT_EMOTIONAL = 4
    Public Const CONSENT_UNKNOWN = 5
    Public Const CONSENT_PREV_DISCUSSION = 6
    '10/17/01 drh
    Public Const CONSENT_YESDMV = 7
    Public Const CONSENT_YESREG = 8

    'Recovery constants
    Public Const RECOVER_YES = 1
    Public Const RECOVER_CORONER_DENY = 2
    Public Const RECOVER_ARREST = 3
    Public Const RECOVER_NBD = 4
    Public Const RECOVER_MED_RO = 5
    Public Const RECOVER_HIGH_RISK = 6
    Public Const RECOVER_LOGISTICS = 7
    Public Const RECOVER_HEART_TXABLE = 8
    Public Const RECOVER_UNKNOWN = 9
    '11/20/01 drh
    Public Const RECOVER_FAMILY_RO = 10

    'Phone type constants
    Public Const CELLULAR_NUM = 1
    Public Const PAGER_NUM = 2
    Public Const WORK_NUM = 3
    Public Const HOME_NUM = 4
    Public Const FAX_NUM = 5


    'Reference constants
    Public Const REF_MSG_NAME = 1
    Public Const REF_MSG_ORG = 2

    'Misc colors
    Public Const COLOR_GREEN = &H8000&
    Public Const COLOR_RED = &HC0&
    Public Const COLOR_BLACK = &H0&
    Public Const COLOR_BLUE = &HFF0000

    'Triage Level
    Public Const VENT_ONLY = 0
    Public Const AGE_ONLY = 1
    Public Const VENT_AGE_ONLY = 2
    Public Const VENT_AGE_MRO = 3

    'MRO Level
    Public Const ADVANCED_MRO = 0
    Public Const STANDARD_MRO = 1
    Public Const NO_MRO = 2

    'Physician Levels
    Public Const MD_NEVER = 0
    Public Const MD_ALWAYS = 1
    Public Const MD_VENT = 2

    'Disposition Codes
    Public Const NO_ORGAN_POTENTIAL = 1
    Public Const NEVER_BRAIN_DEAD = 2
    Public Const AGE_RO = 3
    Public Const MEDICAL_RO = 4
    Public Const CORONER_DENY = 5
    Public Const CONSENT_DENIED = 6
    Public Const OTHER = 7
    Public Const RECOVERED = 8
    Public Const DISP_UNKNOWN = 9


    'System Alert States
    Public Const ALL_ALERTS = 0
    Public Const UNRESOLVED_ALERTS = 1
    Public Const RESOLVED_ALERTS = 2

    'Referral Tab Constants
    Public Const DISPOSITION_TAB = 0
    Public Const RESULTS_TAB = 1
    Public Const CORONER_TAB = 2


    'Person Types
    Public Const PHYSICIAN = 73
    Public Const MDPHYSICIAN = 74
    Public Const DOPHYSICIAN = 75
    Public Const PAPHYSICIAN = 76

    'Auto-pending constants
    Public Const PENDING_HOSPITAL = 0
    Public Const PENDING_AGENCY = 1

    'Prev Vent constants
    Public Const PREVVENT_OTE = 0
    Public Const PREVVENT_TE = 1

    'Approach prompt constants
    Public Const PROMPT = 0
    Public Const NO_PROMPT = 1

    'Criteria schedule group contact constants
    Public Const NO_CONTACT_ON_DENY = 100
    Public Const CONTACT_ON_CONSENT = 101
    Public Const CONTACT_ON_APPROACH = 102
    Public Const CONTACT_ON_CORONER = 103
    Public Const CONTACT_ON_STATLINE_SECONDARY = 104
    Public Const CONTACT_ON_STATLINE_CONSENT = 105
    Public Const CONTACT_ON_CORONER_ONLY = 106

    'Consent status constants
    Public Const CREATE_CONSENT_PENDING = 0
    Public Const CONSENT_PENDING_CURRENT = 1
    Public Const CONSENT_PENDING_CLOSED = 2
    Public Const STATLINE_CONSENT_PENDING = 0

    'Secondary status constants
    Public Const CREATE_SECONDARY_PENDING = 0
    Public Const SECONDARY_PENDING_CURRENT = 1
    Public Const SECONDARY_PENDING_CLOSED = 2

    '7/6/01 drh Family Services Stage Priority Timer Variables
    Public Const FS_OPEN_PRI1 = 20
    Public Const FS_OPEN_PRI2 = 10
    Public Const FS_SYSEVENT_PRI1 = 20
    Public Const FS_SYSEVENT_PRI2 = 10
    Public Const FS_SECCOMP_PRI1 = 20
    Public Const FS_SECCOMP_PRI2 = 10
    Public Const FS_APPROACH_PRI1 = 20
    Public Const FS_APPROACH_PRI2 = 10

    '7/6/01 drh Family Services Security Constants
    Public Const TRIAGE_COORDINATOR = 66
    Public Const FAMILY_SERVICES_COORDINATOR = 81

    'FSProj drh 4/25/02 - FS Historical Criteria
    Public Const WORKING_CRITERIA = 0
    Public Const CURRENT_CRITERIA = 1
    Public Const HISTORICAL_CRITERIA = 2
    Public Const ORIGINAL_CRITERIA = 3

    'FSProj drh 5/2/02 - FS Historical Service Level
    Public Const WORKING_SERVICELEVEL = 0
    Public Const CURRENT_SERVICELEVEL = 1
    Public Const HISTORICAL_SERVICELEVEL = 2
    Public Const ORIGINAL_SERVICELEVEL = 3

    'FSProj 5/2/02 - Cuttof date for using ORIGINAL_CRITERIA and ORIGINAL_SERVICELEVEL
    Public Const HISTORICAL_CUTOFF = "8/13/02 06:31" '"8/4/02"   'KEEP THIS FOR _ReferralDev DB! "5/1/02"

    'FSProj 6/15/02 drh - Control type constants
    Public Const CTL_TEXT = 0
    Public Const CTL_COMBOID = 1
    Public Const CTL_COMBOTEXT = 2
    Public Const CTL_RICHTEXT = 3

    '10/02/02 drh
    Public Const AUDIT_CREATE = 1
    Public Const AUDIT_REVIEW = 2
    Public Const AUDIT_MODIFY = 3
    Public Const AUDIT_DELETE = 4
    Public Const AUDIT_UNKNOWN = 5

    Public Const cnSqlUser = "sa"
    Public Const cnSqlPW = "kuvasz"
End Module
