using System;
using System.Windows.Forms;
using Statline.Stattrac.BusinessRules.Framework;
using Statline.Stattrac.Common;
using Statline.Stattrac.Constant;
using Statline.Stattrac.Windows.UI;
using Stattrac;


namespace Statline.Stattrac.Windows.VBUIMap
{
    /// <summary>
    /// Implements Statline.Stattrac.Common.UIMap
    /// </summary>
    public class OpenStatTracVBForms : UIMap
    {
        /// <summary>
        /// private reference for a singleton project.
        /// Uses the StatTrac.dll for stattrac.vb
        /// </summary>
        private static OpenStatTracVBForms openStatTracVBCode;
        private GeneralConstant generalConstant = GeneralConstant.CreateInstance();

        protected GeneralConstant GRConstant
        {
            get { return generalConstant; }
        }

        protected OpenStatTracVBForms()
        { }
        public static OpenStatTracVBForms CreateInstance()
        {
            if(openStatTracVBCode != null)
                return openStatTracVBCode;

            openStatTracVBCode = new OpenStatTracVBForms();
            openStatTracVBCode.Initialize();
            return openStatTracVBCode;

        }
        #region UIMap Members

        public void Initialize()
        {
            // Using StatTrac DLL
            //specifies the user used by Stattrac.vb
            string LoginUser = StattracIdentity.Identity.Name.ToString();

            AppMain.ConnectionType = Convert.ToInt16(TranslateDBConnection.CreateInstance().GetHistoricalDBConnection(GeneralConstant.CreateInstance().CurrentDB));
            AppMain.UserID = LoginUser;
            AppMain.Main_Renamed();
        }

        /// <summary>
        /// used to open StatTrac.vb forms.
        /// </summary>
        /// <param name="appScreenType"></param>
        /// <param name="recordID"></param>       
        public int Open(AppScreenType appScreenType, int recordID)
        {
            //reset db connection incase a different DB is needed. 
            short currentConnectionType = AppMain.ConnectionType;

            Initialize();

            int returnValue = Int32.MinValue;
            switch (appScreenType)
            {
                case AppScreenType.VBReferral:
                    returnValue = OpenReferral(recordID);
                    break;
                case AppScreenType.VBReferralReadOnly:
                    returnValue = OpenReferralReadOnly(recordID);
                    break;
                case AppScreenType.VBFS:
                    returnValue = OpenFS(recordID);
                    break;
                case AppScreenType.VBFSOther:
                    returnValue = OpenFSOther(recordID);
                    break;
                case AppScreenType.VBFSReadOnly:
                    returnValue = OpenFSReadOnly(recordID);
                    break;
                case AppScreenType.VBFSOtherReadOnly:
                    returnValue = OpenFSOtherReadOnly(recordID);
                    break;
                case AppScreenType.VBEventLog:
                    returnValue = OpenEventLog(recordID);
                    break;
                case AppScreenType.VBEventLogReadOnly:
                    returnValue = OpenEventLogReadOnly(recordID);
                    break;
                case AppScreenType.VBMessage:
                    returnValue = OpenMessage(recordID);
                    break;
                case AppScreenType.VBMessageReadOnly:
                    returnValue = OpenMessageReadOnly(recordID);
                    break;
                case AppScreenType.VBMsgEventLog:
                    returnValue = OpenMsgEventLog(recordID);
                    break;
                case AppScreenType.VBMsgEventLogReadOnly:
                    returnValue = OpenMsgEventLogReadOnly(recordID);
                    break;
                case AppScreenType.VBNew:
                    returnValue = OpenNewCall();
                    break;
                case AppScreenType.VBNewImp:
                    returnValue = OpenNewCall();
                    break;
                case AppScreenType.VBNewMsg:
                    returnValue = OpenNewCall();
                    break;
                case AppScreenType.VBNewNoCall:
                    returnValue = OpenNewCall();
                    break;
                case AppScreenType.VBNoCall:
                    returnValue = OpenNoCall(recordID);
                    break;
                case AppScreenType.VBNoCallReadOnly:
                    returnValue = OpenNoCallReadOnly(recordID);
                    break;
                case AppScreenType.VBSearch:
                    returnValue = OpenSearch();
                    break;
                case AppScreenType.VBQuickLookup:
                    returnValue = OpenSearch();
                    break;
                case AppScreenType.VBOnCall:
                    returnValue = OpenOnCall();
                    break;
                case AppScreenType.VBSchedule:
                    returnValue = OpenSchedule();
                    break;
                case AppScreenType.VBLeaseOrgCalls:
                    returnValue = OpenLeaseOrgCalls();
                    break;
                case AppScreenType.VBHelp:
                    returnValue = OpenHelp();
                    break;
                case AppScreenType.VBKeyCodes:
                    returnValue = OpenKeyCodes();
                    break;
                case AppScreenType.VBAlerts:
                    returnValue = OpenAlerts();
                    break;
                case AppScreenType.VBCriteria:
                    returnValue = OpenCriteria();
                    break;
                case AppScreenType.VBRuleOutIndications:
                    returnValue = OpenRuleOutIndications();
                    break;
                case AppScreenType.VBScreenConfig:
                    returnValue = OpenScreenConfig();
                    break;
                case AppScreenType.VBReportGroups:
                    returnValue = OpenReportGroups();
                    break;
                case AppScreenType.VBFacilityRotation:
                    returnValue = OpenFacilityRotation();
                    break;
            }

            return returnValue;
        }
        /// <summary>
        /// currently not implemeneted. 
        /// </summary>
        /// <param name="appScreenType"></param>
        /// <returns></returns>
       public UserControl Create(AppScreenType appScreenType)
        {
            UserControl selectedUserControl = new UserControl();

            return selectedUserControl;
        }       
        #endregion
        /// <summary>
        /// called by the Open(... method to open frmreferral
        /// </summary>
        /// <param name="callID"></param>
        private int OpenReferral(int callID)
        {
            // TODO: Add check for recycled referral
            if (AppMain.frmReferral != null)
            {
                ShowPleaseCloseWarning(AppMain.frmReferral.Name);
            }
            else
            {
                // Create Referral instance
                AppMain.frmReferral = new FrmReferral();

                AppMain.frmReferral.FormState = Convert.ToInt16(modODBC.EXISTING_RECORD);
                AppMain.frmReferral.CallId = callID;
                AppMain.frmReferral.AutoSize = true;
                AppMain.frmReferral.Show();
                //Make sure frmReferral is available after attempt to show
                if (AppMain.frmReferral != null)
                {
                    AppMain.frmReferral.CmdCancel.Focus();
                }
            }
            return Int32.MinValue;
        }

        private int OpenReferralReadOnly(int callID)
        {
            // TODO: Add check for recycled referral
            if (AppMain.frmReferral != null)
            {
                ShowPleaseCloseWarning(AppMain.frmReferral.Name);
            }
            else
            {
                // Create Referral instance
                AppMain.frmReferral = new FrmReferral();
                AppMain.frmReferral.CmdNewEvent.Enabled = false;
                AppMain.frmReferral.CmdReferral.Enabled = false;
                AppMain.frmReferral.CmdOK.Enabled = false;
                AppMain.frmReferral.CmdModify.Enabled = false;
                AppMain.frmReferral.CmdNOK.Enabled = false;
                AppMain.frmReferral.CmdDelete.Enabled = false;
                AppMain.frmReferral.FormState = Convert.ToInt16(modODBC.EXISTING_RECORD);
                AppMain.frmReferral.CallId = callID;
                AppMain.frmReferral.AutoSize = true;
                AppMain.frmReferral.Show();
                AppMain.frmReferral.CmdCancel.Focus();
            }
            return Int32.MinValue;
        }

        private int OpenMessage(int callID)
        {
            // TODO: Add check for recycled referral
            if (AppMain.frmMessage != null)
            {
                ShowPleaseCloseWarning(AppMain.frmMessage.Name);
            }
            else
            {
                // Create Referral instance
                AppMain.frmMessage = new FrmMessage();
                AppMain.frmMessage.FormState = Convert.ToInt16(modODBC.EXISTING_RECORD);
                AppMain.frmMessage.CallId = callID;
                AppMain.frmMessage.Show();
                AppMain.frmMessage.CmdCancel.Focus();
            }
            return Int32.MinValue;
        }

        private int OpenMessageReadOnly(int callID)
        {
            // TODO: Add check for recycled referral
            if (AppMain.frmMessage != null)
            {
                ShowPleaseCloseWarning(AppMain.frmMessage.Name);
            }
            else
            {
                // Create Referral instance
                AppMain.frmMessage = new FrmMessage();
                AppMain.frmMessage.CmdNewEvent.Enabled = false;
                AppMain.frmMessage.CmdOK.Enabled = false;
                AppMain.frmMessage.CmdModify.Enabled = false;
                AppMain.frmMessage.CmdDelete.Enabled = false;
                AppMain.frmMessage.FormState = Convert.ToInt16(modODBC.EXISTING_RECORD);
                AppMain.frmMessage.CallId = callID;
                AppMain.frmMessage.Show();
                AppMain.frmMessage.CmdCancel.Focus();
            }
            return Int32.MinValue;
        }
        private int OpenEventLog(int callID)
        {
            if (AppMain.frmReferral != null)
            {
                ShowPleaseCloseWarning(AppMain.frmReferral.Name);
            }
            else
            {
                // Create Referral instance
                AppMain.frmReferral = new FrmReferral();
                AppMain.frmReferral.FormState = Convert.ToInt16(modODBC.EXISTING_RECORD);
                AppMain.frmReferral.CallId = callID;
                AppMain.frmReferral.AutoSize = true;
                AppMain.frmReferral.vTabIndex = AppMain.frmReferral.TabDonor.TabPages.Count - 1;
                //AppMain.frmReferral.TabDonor.SelectedIndex = AppMain.frmReferral.TabDonor.TabPages.Count - 1;
                //ccarroll 11/1/2011 - HS 29072, 29553 - line above removed becauase of registry load issues
                //vOpenEventLog is a flag set to open referral log event tab at end of frmReferral.Actived
                AppMain.frmReferral.vOpenEventLog = true;

                AppMain.frmReferral.CmdCancel.Focus();
                AppMain.frmReferral.ShowDialog();
            }
            return Int32.MinValue;

        }
        private int OpenMsgEventLog(int callID)
        {
            if (AppMain.frmMessage != null)
            {
                ShowPleaseCloseWarning(AppMain.frmMessage.Name);
            }
            else
            {
                // Create Referral instance
                AppMain.frmMessage = new FrmMessage();
                AppMain.frmMessage.FormState = Convert.ToInt16(modODBC.EXISTING_RECORD);
                AppMain.frmMessage.CallId = callID;
                AppMain.frmMessage.CallType = Convert.ToInt16(GRConstant.MessageCallTypeID);
                AppMain.frmMessage.TabMessage.SelectTab(AppMain.frmMessage.TabMessage.TabPages.Count - 1);
                AppMain.frmMessage.CmdCancel.Focus();
                AppMain.frmMessage.ShowDialog();
            }
            return Int32.MinValue;

        }
        private int OpenEventLogReadOnly(int callID)
        {
            if (AppMain.frmReferral != null)
            {
                ShowPleaseCloseWarning(AppMain.frmReferral.Name);
            }
            else
            {
                // Create Referral instance
                AppMain.frmReferral = new FrmReferral();
                AppMain.frmReferral.CmdNewEvent.Enabled = false;
                AppMain.frmReferral.CmdReferral.Enabled = false;
                AppMain.frmReferral.CmdOK.Enabled = false;
                AppMain.frmReferral.CmdModify.Enabled = false;
                AppMain.frmReferral.CmdNOK.Enabled = false;
                AppMain.frmReferral.CmdDelete.Enabled = false;
                AppMain.frmReferral.FormState = Convert.ToInt16(modODBC.EXISTING_RECORD);
                AppMain.frmReferral.CallId = callID;
                AppMain.frmReferral.AutoSize = true;
                AppMain.frmReferral.vTabIndex = AppMain.frmReferral.TabDonor.TabPages.Count - 1;

                //AppMain.frmReferral.TabDonor.SelectedIndex = AppMain.frmReferral.TabDonor.TabPages.Count - 1;
                //ccarroll 11/1/2011 - HS 29072, 29553 - line above removed becauase of registry load issues
                //vOpenEventLog is a flag set to open referral log event tab at end of frmReferral.Actived
                AppMain.frmReferral.vOpenEventLog = true;

                AppMain.frmReferral.CmdCancel.Focus();
                AppMain.frmReferral.ShowDialog();
            }
            return Int32.MinValue;

        }
        private int OpenMsgEventLogReadOnly(int callID)
        {
            if (AppMain.frmMessage != null)
            {
                ShowPleaseCloseWarning(AppMain.frmMessage.Name);
            }
            else
            {
                // Create Referral instance
                AppMain.frmMessage = new FrmMessage();
                AppMain.frmMessage.CmdNewEvent.Enabled = false;
                AppMain.frmMessage.CmdOK.Enabled = false;
                AppMain.frmMessage.CmdModify.Enabled = false;
                AppMain.frmMessage.CmdDelete.Enabled = false;
                AppMain.frmMessage.FormState = Convert.ToInt16(modODBC.EXISTING_RECORD);
                AppMain.frmMessage.CallId = callID;
                AppMain.frmMessage.CallType = Convert.ToInt16(GRConstant.MessageCallTypeID);
                AppMain.frmMessage.TabMessage.SelectTab(AppMain.frmMessage.TabMessage.TabPages.Count - 1);
                AppMain.frmMessage.CmdCancel.Focus();
                AppMain.frmMessage.ShowDialog();
                
            }
            return Int32.MinValue;

        }
        private int OpenNewCall()
        {
            // TODO: Add check for recycled referral
            
            // Check if form is open or call in progress 
            if (AppMain.frmNew != null ||
                AppMain.frmMessage != null ||
                AppMain.frmNoCall != null ||
                AppMain.frmReferral != null ||
                AppMain.frmReferralView != null)
            {
                ShowPleaseCloseWarning(AppMain.frmNew.Name);
            }
            else
            {
                // Create Referral instance
                AppMain.frmNew = new FrmNew();

                AppMain.frmNew.FormState = Convert.ToInt16(modODBC.EXISTING_RECORD);
                
                AppMain.frmNew.Show();
                AppMain.frmNew.BringToFront();
            }
            return Int32.MinValue;
        }
        private int OpenSearch()
        {
            if (AppMain.frmQuickLook != null)
            {
                ShowPleaseCloseWarning(AppMain.frmQuickLook.Name);
            }
            else
            {
                AppMain.frmQuickLook = new FrmQuickLook();
                AppMain.frmQuickLook.Show();
            }
            return Int32.MinValue;
        }
        private int OpenOnCall()
        {
            if (AppMain.frmOnCall != null)
            {
                ShowPleaseCloseWarning(AppMain.frmOnCall.Name);
            }
            else
            {
                AppMain.frmOnCall = new FrmOnCall();
                AppMain.frmOnCall.Show();
            }
            return Int32.MinValue;
        }
        private int OpenSchedule()
        {
            if (AppMain.frmSchedule != null)
            {
                ShowPleaseCloseWarning(AppMain.frmSchedule.Name);
            }
            else
            {
                AppMain.frmSchedule = new FrmSchedule();
                AppMain.frmSchedule.OrganizationId = 0;
                AppMain.frmSchedule.CurrentDate = DateTime.Today;
                AppMain.frmSchedule.OptDatesMonth = false;
                AppMain.frmSchedule.OptDatesMonth = true;
                AppMain.frmSchedule.Show();
            }
            return Int32.MinValue;
        }
        private int OpenLeaseOrgCalls()
        {
            if (AppMain.frmLeaseOrganizationCalls != null)
            {
                ShowPleaseCloseWarning(AppMain.frmLeaseOrganizationCalls.Name);
            }
            else
            {
                AppMain.frmLeaseOrganizationCalls = new FrmLeaseOrganizationCalls();
                AppMain.frmLeaseOrganizationCalls.Show();
            }
            return Int32.MinValue;
        }
        private int OpenHelp()
        {
            if (AppMain.frmAbout != null)
            {
                ShowPleaseCloseWarning(AppMain.frmAbout.Name);
            }
            else
            {
                AppMain.frmAbout = new FrmAbout();
                AppMain.frmAbout.Show();
            }
            return Int32.MinValue;
        }
        private int OpenAlerts()
        {
            if (AppMain.frmAlert != null)
            {
                ShowPleaseCloseWarning(AppMain.frmAlert.Name);
            }
            else
            {
                AppMain.frmAlert = new FrmAlert();
                AppMain.frmAlert.Show();
            }
            return Int32.MinValue;
        }
        private int OpenKeyCodes()
        {
            if (AppMain.frmKeyCodeSelect != null)
            {
                ShowPleaseCloseWarning(AppMain.frmKeyCodeSelect.Name);
            }
            else
            {
                AppMain.frmKeyCodeSelect = new FrmKeyCodeSelect();
                AppMain.frmKeyCodeSelect.Show();
            }
            return Int32.MinValue;
        }
        private int OpenRuleOutIndications()
        {
            if (AppMain.frmIndicationSelect != null)
            {
                ShowPleaseCloseWarning(AppMain.frmIndicationSelect.Name);
            }
            else
            {
                AppMain.frmIndicationSelect = new FrmIndicationSelect();
                AppMain.frmIndicationSelect.Show();
            }
            return Int32.MinValue;
        }
        private int OpenScreenConfig()
        {
            if (AppMain.frmServiceLevel != null)
            {
                ShowPleaseCloseWarning(AppMain.frmServiceLevel.Name);
            }
            else
            {
                AppMain.frmServiceLevel = new FrmServiceLevel();
                AppMain.frmServiceLevel.Show();
            }
            return Int32.MinValue;
        }
        private int OpenFacilityRotation()
        {
            if (AppMain.frmRotateOrganization != null)
            {
                ShowPleaseCloseWarning(AppMain.frmRotateOrganization.Name);
            }
            else
            {
                AppMain.frmRotateOrganization = new FrmRotateOrganization();
                AppMain.frmRotateOrganization.Show();
            }
            return Int32.MinValue;
        }
        private int OpenReportGroups()
        {
            if (AppMain.frmReport != null)
            {
                ShowPleaseCloseWarning(AppMain.frmReport.Name);
            }
            else
            {
                AppMain.frmReport = new FrmReport();
                AppMain.frmReport.Show();
            }
            return Int32.MinValue;
        }
        private int OpenCriteria()
        {
            if (AppMain.frmCriteria != null)
            {
                ShowPleaseCloseWarning(AppMain.frmCriteria.Name);
            }
            else
            {
                AppMain.frmCriteria = new FrmCriteria();
                AppMain.frmCriteria.Show();
            }
            return Int32.MinValue;
        }
        private int OpenNoCall(int callID)
        {
            if (AppMain.frmNoCall != null)
            {
                ShowPleaseCloseWarning(AppMain.frmNoCall.Name);
            }
            else
            {
                AppMain.frmNoCall = new FrmNoCall();
                AppMain.frmNoCall.CallId = callID;
                AppMain.frmNoCall.FormState = Convert.ToInt16(modODBC.EXISTING_RECORD);
                AppMain.frmNoCall.Show();
                AppMain.frmNoCall.CmdCancel.Focus();
            }
            return Int32.MinValue;
        }
        private int OpenNoCallReadOnly(int callID)
        {
            if (AppMain.frmNoCall != null)
            {
                ShowPleaseCloseWarning(AppMain.frmNoCall.Name);
            }
            else
            {
                AppMain.frmNoCall = new FrmNoCall();
                AppMain.frmNoCall.CallId = callID;
                AppMain.frmNoCall.FormState = Convert.ToInt16(modODBC.EXISTING_RECORD);
                AppMain.frmNoCall.CmdOK.Enabled = false;
                AppMain.frmNoCall.CmdNoCallTypeDetail.Enabled = false;
                AppMain.frmNoCall.Show();
                AppMain.frmNoCall.CmdCancel.Focus();
            }
            return Int32.MinValue;
        }
        private int OpenFS(int callID)
        {//opens active FS calls to eventlog
            if (AppMain.frmReferralView != null)
            {
                ShowPleaseCloseWarning(AppMain.frmReferralView.Name);
            }
            else
            {
                AppMain.frmReferralView = new FrmReferralView();
                AppMain.frmReferralView.CallId = callID;
                AppMain.frmReferralView.FormState = Convert.ToInt16(modODBC.EXISTING_RECORD);
                AppMain.frmReferralView.Show();
                AppMain.frmReferralView.TabDonor.SelectTab(AppMain.frmReferralView.TabDonor.TabPages.Count - 3);
                AppMain.frmReferralView.CmdCancel.Focus();
            }
            return Int32.MinValue;
        }
        private int OpenFSOther(int callID)
        {//opens expired and other FS calls
            if (AppMain.frmReferralView != null)
            {
                ShowPleaseCloseWarning(AppMain.frmReferralView.Name);
            }
            else
            {
                AppMain.frmReferralView = new FrmReferralView();
                AppMain.frmReferralView.CallId = callID;
                AppMain.frmReferralView.FormState = Convert.ToInt16(modODBC.EXISTING_RECORD);
                AppMain.frmReferralView.Show();
                AppMain.frmReferralView.CmdCancel.Focus();
            }
            return Int32.MinValue;
        }
        private int OpenFSReadOnly(int callID)
        {//opens active FS calls to eventlog
            if (AppMain.frmReferralView != null)
            {
                ShowPleaseCloseWarning(AppMain.frmReferralView.Name);
            }
            else
            {
                AppMain.frmReferralView = new FrmReferralView();
                AppMain.frmReferralView.CmdNewEvent.Enabled = false;
                AppMain.frmReferralView.CmdReferral.Enabled = false;
                AppMain.frmReferralView.btnSaveAndClose.Enabled = false;
                AppMain.frmReferralView.Cmdactivate.Enabled = false;
                AppMain.frmReferralView.CmdDelete.Enabled = false;
                AppMain.frmReferralView.CallId = callID;
                AppMain.frmReferralView.FormState = Convert.ToInt16(modODBC.EXISTING_RECORD);
                AppMain.frmReferralView.Show();
                AppMain.frmReferralView.TabDonor.SelectTab(AppMain.frmReferralView.TabDonor.TabPages.Count - 3);
                AppMain.frmReferralView.CmdCancel.Focus();
            }
            return Int32.MinValue;
        }
        private int OpenFSOtherReadOnly(int callID)
        {//opens expired and other FS calls
            if (AppMain.frmReferralView != null)
            {
                ShowPleaseCloseWarning(AppMain.frmReferralView.Name);
            }
            else
            {
                AppMain.frmReferralView = new FrmReferralView();
                AppMain.frmReferralView.CmdNewEvent.Enabled = false;
                AppMain.frmReferralView.CmdReferral.Enabled = false;
                AppMain.frmReferralView.btnSaveAndClose.Enabled = false;
                AppMain.frmReferralView.Cmdactivate.Enabled = false;
                AppMain.frmReferralView.CmdDelete.Enabled = false;
                AppMain.frmReferralView.CallId = callID;
                AppMain.frmReferralView.FormState = Convert.ToInt16(modODBC.EXISTING_RECORD);
                AppMain.frmReferralView.Show();
                AppMain.frmReferralView.CmdCancel.Focus();
            }
            return Int32.MinValue;
        }

        private void ShowPleaseCloseWarning(string formName)
        {
            BaseMessageBox.ShowWarning("Please close form to continue.", "Form is Already Open");

            //Make sure form is available...  if so, activate it
            var formToActivate = Application.OpenForms[formName];
            if (formToActivate != null)
            {
                formToActivate.Activate();

            }
        }
    }
}
