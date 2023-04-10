using System;
using System.Globalization;

namespace Statline.Stattrac.Constant
{
	/// <summary>
	/// Constants used in general
	/// </summary>
	public class GeneralConstant
    {
        #region Public Constants
        public const string FamilyServicesAspOnly = "Family Services ASP Only";
        
        #endregion
        #region Private Fields
        private readonly CultureInfo cultureInfo;
		private readonly bool isUseLocal;
		private readonly string activeDirectory;
		private readonly string invalidLogOn;
        private readonly string invalidUserName;
        private readonly string duplicateUserName;
        private int organizationId;
        private const string phonePattern = @"^[\(]{1}\d{3}[\)]{1}[ ]?\d{3}[ ]?-[ ]?\d{4}$";
        private int contactId;
        private int contactPhoneId;
        private int questionID;
        private int questionGroupConfigID;
        private int childQuestionId;
        private int indicationQuestionAssociatedId;
        private string organizationName;
        private int sourceCodeId;
        private string sourceCodeName;
        private int sourceCodeCallTypeId;
        private string sourceCodeCallTypeName;
        private bool sourceCodeDisplayAll;
        private bool sourceCodeOrganizationGetSelected;
        private int callTypeId;
        private int indicationId;
        private int criteriaId;
        private int criteriaProcessorTypeId;
        private int criteriaProcessorStateId;
        private int donorCategoryId;
        private int referralId;
        private int firstRow;
        private int defaultValue;
		private int tcssRecipientId;
        private int comboBoxID;
        private string comboBoxValue;
		private int tcssDonorId;
        private bool allPermissions;
        private string currentDB;
        private bool isNewCallOrganization = false;
        private AppScreenType openOrganization = AppScreenType.OrganizationsOrganizationProperties;
        private AppScreenType openSourceCode = AppScreenType.AdministrationSourceCode;
        private string selectedTab;
        private int recycleCallID;
        private bool restoreCall;
        private bool deleteCall;
        private string deleteReason;
        private string deletePatientFirstName;
        private string deletePatientLastName;
        private string oasisOPTN;
        private string oasisMatchID;
        private string oasisOrgan;
        private bool oasisReadOnly;
        private bool oasisImportClick;
        private string autoDisplaySourceCode;
        private int autoDisplayCallTypeID;
        private int messageCallTypeID;
        private bool isPerformanceCounterCounterAvailable;


        #endregion

        #region Singleton Implementation


        private static GeneralConstant framework;
		protected GeneralConstant()
		{
			cultureInfo = CultureInfo.CurrentCulture;
			isUseLocal = true;
			activeDirectory = "LDAP://DC=inside,DC=mtf,DC=org";
			invalidLogOn = "Invalid User name or password";
            invalidUserName = "The user name you are logging in as does not exist.";
			referralId = int.MinValue;
            FirstRow = 0;
            DefaultValue = 0;
			tcssRecipientId = int.MinValue;
            duplicateUserName = "The User Name entered exists! Please enter a different username.";
            allPermissions = false;
		}

        
		public static GeneralConstant CreateInstance()
		{
			if (framework == null)
			{
				framework = new GeneralConstant();
			}
			return framework;
		}
		#endregion
        #region Public Enum
        public enum AuditLogType
        {
            Create = 1,
            Review = 2,
            Modify = 3,
            Delete = 4,
            Unknown = 5
        }
        public enum CallType
        {
            Referral = 1,
            Message = 2,
            NoCall = 3,
            Import = 4,
            COD = 5,
            OASIS = 6 
        }
        public enum Organizations
        {
            Statline = 194,
            CO = 50,
            GOLM = 2309
        }
        public enum PanelNavigation
        {
            Dashboard = 2,
            NewCall = 3,
            Schedules = 4,
            //GeneralAlerts = 5,
            //LeaseOrgs = 6,
            KeyCodes = 229,
            Organizations = 7,
            Admin = 8,
            Help = 9
        }
        #endregion
        #region Public Properties
        /// <summary>
        /// Required In Business Rule and Data Access Dlls.
        /// Used by OrganizationDA
        /// </summary>
        public bool AllPermissions
        {
            get { return allPermissions; }
            set { allPermissions = value; }
        }
        /// <summary>
        /// Auto Display of Source Code        
        /// </summary>
        public string AutoDisplaySourceCode
        {
            get { return autoDisplaySourceCode; }
            set { autoDisplaySourceCode = value; }
        }
        /// <summary>
        /// 
        /// </summary>
        public int AutoDisplayCallTypeID
        {
            get { return autoDisplayCallTypeID; }
            set { autoDisplayCallTypeID = value; }
        }
        /// <summary>
        /// Message for Duplicate User Name in Contact Permissions.
        /// </summary>
        public string DuplicateUserName
        {
            get { return duplicateUserName; }
        } 

        /// <summary>
        /// Used to for first row in a data set
        /// </summary>
        public int FirstRow
        {
            get { return firstRow; }
            set { firstRow = value; }
        }
        /// <summary>
        /// Used to set Default Value
        /// </summary>
        public int DefaultValue
        {
            get { return defaultValue; }
            set { defaultValue = value; }
        }
        /// <summary>
		/// The culture 
		/// </summary>
		public CultureInfo StattracCulture
		{
			get { return cultureInfo; }
		}

		/// <summary>
		/// The current Date time
		/// </summary>
		public DateTime CurrentDateTime
		{
			get
			{
				if (isUseLocal)
					return DateTime.Now;
				else
					return DateTime.UtcNow;
			}
		}

		/// <summary>
		/// The url of the active directory
		/// </summary>
		public string ActiveDirectory
		{
			get { return activeDirectory; }
		}

		/// <summary>
		/// Message for invalid login
		/// </summary>
		public string InvalidLogOn
		{
			get { return invalidLogOn; }
		}
        /// <summary>
        /// Message for invalid User Name
        /// </summary>
        public string InvalidUserName
        {
            get { return invalidUserName; }
        }
		/// <summary>
		/// The Id field of the currently Edited Organization
		/// </summary>
		public int OrganizationId
		{
			get { return organizationId; }
			set { organizationId = value; }
		}
        /// <summary>
        /// Use by Regular Expressions to determine if a text string is a valid Phone Number
        /// </summary>
        public string PhonePattern
        {
            get { return phonePattern; }
        } 
        /// <summary>
        /// The Id field of the currently Edited Contact (aka Phone)
        /// </summary>
        public int ContactId
        {
            get { return contactId; }
            set { contactId = value; }
        }
        /// <summary>
        /// The Id field of the currently Edited ContactPhone (aka PersonPhone)
        /// </summary>
        public int ContactPhoneId
        {
            get { return contactPhoneId; }
            set { contactPhoneId = value; }
        }

        /// <summary>
        /// The Id field of the currently Edited Quesiton
        /// </summary>
        public int QuestionID
        {
            get { return questionID; }
            set { questionID = value; }
        }
        /// The Id field of the currently Edited Quesiton
        /// </summary>
        public int ChildQuestionID
        {
            get { return childQuestionId; }
            set { childQuestionId = value; }
        }

        /// <summary>
        /// The Id field of the currently Edited Quesiton
        /// </summary>
        public int QuestionGroupConfigID
        {
            get { return questionGroupConfigID; }
            set { questionGroupConfigID = value; }
        }

        /// <summary>
        /// The Name field of the currently Edited Organization
        /// </summary>
        public string OrganizationName
        {
            get { return organizationName; }
            set { organizationName = value; }
        }

		/// <summary>
		/// The Id of the Family services
		/// </summary>
		public int ReferralId
		{
			get { return referralId; }
			set { referralId = value; }
		}

		/// <summary>
		/// The Id of the Tcss Recipient
		/// </summary>
		public int TcssRecipientId
		{
			get { return tcssRecipientId; }
			set { tcssRecipientId = value; }
		}
        /// <summary>
        /// The Id field of the currently Edited SourceCode
        /// </summary>
        public int SourceCodeId
        {
            get { return sourceCodeId; }
            set { sourceCodeId = value; }
        }
        /// <summary>
        /// The Name field of the currently Edited SourceCode
        /// </summary>
        public string SourceCodeName
        {
            get { return sourceCodeName; }
            set { sourceCodeName = value; }
        }
        /// <summary>
        /// The Id field of the currently Edited SourceCodeCallType
        /// </summary>
        public int SourceCodeCallTypeId
        {
            get { return sourceCodeCallTypeId; }
            set { sourceCodeCallTypeId = value; }
        }
        /// <summary>
        /// The Name field of the currently Edited SourceCodeCallType
        /// </summary>
        public string SourceCodeCallTypeName
        {
            get { return sourceCodeCallTypeName; }
            set { sourceCodeCallTypeName = value; }
        }
        /// <summary>
        /// The boolean value to display all source codes
        /// </summary>
        public bool SourceCodeDisplayAll
        {
            get { return sourceCodeDisplayAll; }
            set { sourceCodeDisplayAll = value; }
        }
        /// <summary>
        /// The boolean value to GetSelected parameter of SourceCodeOrganizationSelect.
        /// When set to true it returns selected organizations.
        /// When set to false it will return un-selected organizations.
        /// </summary>
        public bool SourceCodeOrganizationGetSelected
        {
            get { return sourceCodeOrganizationGetSelected; }
            set { sourceCodeOrganizationGetSelected = value; }
        }
        /// <summary>
        /// The Id field of the currently Edited CallType
        /// </summary>
        public int CallTypeId
        {
            get { return callTypeId; }
            set { callTypeId = value; }
        }

        /// <summary>
        /// The Id field of the currently Edited IndicationId
        /// </summary>
        public int IndicationId
        {
            get { return indicationId; }
            set { indicationId = value; }
        }

        /// <summary>
        /// The Id field of the currently Edited CriteriaId
        /// </summary>
        public int CriteriaId
        {
            get { return criteriaId; }
            set { criteriaId = value; }
        }
        /// <summary>
        /// The Id field of the currently Edited CriteriaId
        /// </summary>
        public int CriteriaProcessorTypeId
        {
            get { return criteriaProcessorTypeId; }
            set { criteriaProcessorTypeId = value; }
        }
        /// <summary>
        /// The Id field of the currently Edited CriteriaId
        /// </summary>
        public int CriteriaProcessorStateId
        {
            get { return criteriaProcessorStateId; }
            set { criteriaProcessorStateId = value; }
        }
        /// <summary>
        /// The Id field of the currently Edited DonorCategoryId
        /// </summary>
        public int DonorCategoryId
        {
            get { return donorCategoryId; }
            set { donorCategoryId = value; }
        }

        /// <summary>
        /// The Id field of the currently Edited IndicationQuestionAssociatedId
        /// </summary>
        public int IndicationQuestionAssociatedId
        {
            get { return indicationQuestionAssociatedId; }
            set { indicationQuestionAssociatedId = value; }
        }

        /// <summary>
        /// The ID of a combobox
        /// </summary>
        public int ComboBoxID
        {
            get { return comboBoxID; }
            set { comboBoxID = value; }
        }

        /// <summary>
        /// The value of a combobox
        /// </summary>
        public string ComboBoxValue
        {
            get { return comboBoxValue; }
            set { comboBoxValue = value; }
        }

		/// <summary>
		/// The Id of the Tcss Recipient
		/// </summary>
		public int TcssDonorId
		{
			get { return tcssDonorId; }
			set { tcssDonorId = value; }
		}

        /// <summary>
        /// The database user selected at logon
        /// </summary>
        public string CurrentDB
        {
            get { return currentDB; }
            set { currentDB = value; }
        }
        /// <summary>
        /// Used to indicate an Organization is being created by a Call Window Referral, Message, NoCall, Oasis
        /// </summary>
        public bool IsNewCallOrganization
        {
            get { return isNewCallOrganization; }
            set { isNewCallOrganization = value; }
        }
        /// <summary>
        /// Used to indicate an OrganizationEd is being opened to dispaly contact information.
        /// </summary>
        public AppScreenType OpenOrganization
        {
            get { return openOrganization; }
            set { openOrganization = value; }
        }
        /// <summary>
        /// Used to open SourceCode from VB app
        /// </summary>
        public AppScreenType OpenSourceCode
        {
            get { return openSourceCode; }
            set { openSourceCode = value; }
        }

        /// <summary>
        /// the selected tab from the dashboard
        /// </summary>
        public string SelectedTab
        {
            get { return selectedTab; }
            set { selectedTab = value; }
        }
        public int RecycleCallID
        {
            get { return recycleCallID; }
            set { recycleCallID = value; }
        }
        public bool RestoreCall
        {
            get { return restoreCall; }
            set { restoreCall = value; }
        }
        public bool DeleteCall
        {
            get { return deleteCall; }
            set { deleteCall = value; }
        }
        public string DeleteReason
        {
            get { return deleteReason; }
            set { deleteReason = value; }
        }
        public string DeletePatientFirstName
        {
            get { return deletePatientFirstName; }
            set { deletePatientFirstName = value; }
        }
        public string DeletePatientLastName
        {
            get { return deletePatientLastName; }
            set { deletePatientLastName = value; }
        }
        public string OasisOPTN
        {
            get { return oasisOPTN; }
            set { oasisOPTN = value; }
        }
        public string OasisMatchID
        {
            get { return oasisMatchID; }
            set { oasisMatchID = value; }
        }
        public string OasisOrgan
        {
            get { return oasisOrgan; }
            set { oasisOrgan = value; }
        }
        public bool OasisReadOnly
        {
            get { return oasisReadOnly; }
            set { oasisReadOnly = value; }
        }
        public bool OasisImportClick
        {
            get { return oasisImportClick; }
            set { oasisImportClick = value; }
        }
        public int MessageCallTypeID
        {
            get { return messageCallTypeID; }
            set { messageCallTypeID = value; }
        }

        public bool IsPerformanceCounterCounterAvailable
        {
            get { return isPerformanceCounterCounterAvailable; }
            set { isPerformanceCounterCounterAvailable = value; }
        }
        #endregion
    }
}
