using System;
using System.Windows.Forms;
using Statline.Stattrac.Common;
using Statline.Stattrac.Constant;
using Statline.Stattrac.Windows.Controls.Common;
using Statline.Stattrac.Windows.Controls.Organization;
using Statline.Stattrac.Windows.Controls.Administration.SourceCode;
using Statline.Stattrac.Windows.Controls.Administration;

namespace Statline.Stattrac.Windows.CSharpUIMap
{
    /// <summary>
    /// implements statline.stattrac.common.UIMap
    /// Used to open stattrac.net (c#) controls.
    /// Use a popup form when a C# contorl is opened from StatTrac.
    /// </summary>
    public class OpenStatTracCSharpForms : UIMap
    {
        private static OpenStatTracCSharpForms openStatTracCSharpForms;
        private GeneralConstant generalConstant;
        private SecurePopupForm securePopupForm;
        protected OpenStatTracCSharpForms() { }

        public static OpenStatTracCSharpForms CreateInstance()
        {
            if (openStatTracCSharpForms != null)
                return openStatTracCSharpForms;

            openStatTracCSharpForms = new OpenStatTracCSharpForms();
            openStatTracCSharpForms.Initialize();

            return openStatTracCSharpForms;
            
        }



        #region UIMap Members

        public void Initialize()
        {
            generalConstant = GeneralConstant.CreateInstance();
        }
        /// <summary>
        /// used by StatTrac.vb to open C# controls with a popup.
        /// </summary>
        /// <param name="vbUiForms"></param>
        /// <param name="recordID"></param>
        public int Open(AppScreenType vbUiForms, int recordID)
        {
            int returnValue = Int32.MinValue;
            switch (vbUiForms)
            {
                case AppScreenType.OrganizationsOrganizationEditPopup:
                    returnValue = OpenOrganization(recordID);
                    break;
                case AppScreenType.OrganizationsOrganizationContactsContactPropertiesEditPopup:
                    returnValue = OpenOrganizationContacts(recordID);
                    break;
                case AppScreenType.OrganizationsOrganizationContactsPhoneEditPopup:
                    returnValue = OpenOrganizationContactsPhone(recordID);
                    break;
                case AppScreenType.AdministrationSourceCodeEditPopup:
                    returnValue = OpenSourceCode(recordID);
                    break;

            }
            return returnValue;
        }
        private int OpenSourceCode(int sourceCodeCallTypeId)
        {
            int returnValue = Int32.MinValue;
            generalConstant.OpenSourceCode = AppScreenType.AdministrationSourceCodeEditPopup;
            generalConstant.SourceCodeCallTypeId = sourceCodeCallTypeId;

            securePopupForm = new SecurePopupForm();

            securePopupForm.LoadSubControl(AppScreenType.AdministrationSourceCode, AppScreenType.SourceCodeSourceCode);
            DialogResult dialogResult = securePopupForm.ShowDialog();
            returnValue = generalConstant.SourceCodeId;

            // reset values
            generalConstant.SourceCodeId = Int32.MinValue;
            generalConstant.SourceCodeCallTypeId = Int32.MinValue;
            generalConstant.OpenSourceCode = AppScreenType.SourceCodeSourceCode;
            return returnValue;

        }

        private int OpenOrganizationContactsPhone(int recordID)
        {
            int returnValue = Int32.MinValue;
            generalConstant.ContactId = recordID;
            generalConstant.OpenOrganization = AppScreenType.OrganizationsOrganizationContactsPhoneEditPopup;
            securePopupForm = new SecurePopupForm();


            securePopupForm.LoadSubControl(AppScreenType.Organizations, AppScreenType.OrganizationsOrganizationEdit);
            DialogResult dialogResult = securePopupForm.ShowDialog();
            returnValue = generalConstant.ContactPhoneId;
            // reset values
            generalConstant.OrganizationId = Int32.MinValue;
            generalConstant.ContactId = Int32.MinValue;
            generalConstant.ContactPhoneId = Int32.MinValue;
            generalConstant.OpenOrganization = AppScreenType.OrganizationsOrganizationProperties;
            return returnValue;
            
        }

        private int OpenOrganizationContacts(int recordID)
        {
            int returnValue = Int32.MinValue;
            generalConstant.ContactId = recordID;
            generalConstant.OpenOrganization = AppScreenType.OrganizationsOrganizationContactsContactPropertiesEditPopup;
            securePopupForm = new SecurePopupForm();

            securePopupForm.LoadSubControl(AppScreenType.Organizations, AppScreenType.OrganizationsOrganizationEdit);
            DialogResult dialogResult = securePopupForm.ShowDialog();
            returnValue = generalConstant.ContactId;
            // reset values
            generalConstant.OrganizationId = Int32.MinValue;
            generalConstant.ContactId = Int32.MinValue;
            generalConstant.ContactPhoneId = Int32.MinValue;
            generalConstant.OpenOrganization = AppScreenType.OrganizationsOrganizationProperties;
            return returnValue;
        }
        public int OpenOrganization(int organizationId)
        {
            int returnValue = Int32.MinValue;
            generalConstant.OpenOrganization = AppScreenType.OrganizationsOrganizationEditPopup;
            generalConstant.OrganizationId = organizationId;
            if (organizationId < 1)
               generalConstant.IsNewCallOrganization = true;
            else
                generalConstant.IsNewCallOrganization = false;

            securePopupForm = new SecurePopupForm();

            securePopupForm.LoadSubControl(AppScreenType.Organizations, AppScreenType.OrganizationsOrganizationEdit);
            DialogResult dialogResult =  securePopupForm.ShowDialog();
            returnValue = generalConstant.OrganizationId;
            // reset values
            generalConstant.OrganizationId = Int32.MinValue;
            generalConstant.ContactId = Int32.MinValue;
            generalConstant.ContactPhoneId = Int32.MinValue;
            generalConstant.OpenOrganization = AppScreenType.OrganizationsOrganizationProperties;

            return returnValue;

        }
        /// <summary>
        /// Used by Statline.Stattrac.windows.UI to open controls in Statline.Stattrac.windows.Controls.
        /// The initial use was for Organization Controls. 
        /// </summary>
        /// <param name="appScreenType"></param>
        /// <returns></returns>
        public UserControl Create(AppScreenType appScreenType)
        {
            UserControl selectedUserControl = new UserControl();
            switch (appScreenType)
            {                 
                case AppScreenType.OrganizationsOrganizationSearch:
                    selectedUserControl = new OrganizationSearchControl();
                    break;
                case AppScreenType.OrganizationsOrganizationEdit:
                    //set IsNewCallOrganization to false.
                    generalConstant.IsNewCallOrganization = false;
                    selectedUserControl = new OrganizationEditManager();
					break;
                case AppScreenType.OrganizationsOrganizationDelete:
                    selectedUserControl = new OrganizationDeleteControl();
                    break;
                case AppScreenType.ReportIssueFeedbackup:
                    selectedUserControl = new ReportIssueFeedback();
                    break;
                case AppScreenType.AdministrationSourceCode:
                    selectedUserControl = new SourceCodeEditManager();
                    break;
                case AppScreenType.SourceCodeSourceCode:
                    selectedUserControl = new SourceCodeSourceCodeControl();
                    break;
                case AppScreenType.SourceCodeAssociatedOrganizations:
                    selectedUserControl = new AssociatedOrganizationsControl();
                    break;

            }
            return selectedUserControl;
        }

        #endregion
    }
}
