using System;
using System.Collections;
using System.Collections.Generic;
using System.Windows.Forms;
using System.Linq;
using Infragistics.Win.UltraWinGrid;
using Statline.Stattrac.BusinessRules.Organization;
using Statline.Stattrac.Constant;
using Statline.Stattrac.Constant.GridColumns;
using Statline.Stattrac.Data.Types.Organization;
using Statline.Stattrac.Windows.UI;
using Statline.Stattrac.Security;

namespace Statline.Stattrac.Windows.Controls.Organization
{
    /// <summary>
    /// Load Referrals based on OrganizationID or PhoneID
    /// View Referrals
    /// </summary>
    public partial class OrganizationAssociatedCall : Statline.Stattrac.Windows.UI.BaseUserControl
    {
        private OrganizationAssociatedCallDS _organizationAssociatedCallDS;
        private int _organizationID;
        private int _phoneID;
        private SecurityHelper _securityHelper;
        public OrganizationAssociatedCall()
        {
            InitializeComponent();
            _securityHelper = SecurityHelper.GetInstance();
            if (_securityHelper != null)
            {
                btnReassign.Enabled = false;
                if (_securityHelper.Authorized(SecurityRule.Reassign_Numbers.ToString()))
                    btnReassign.Enabled = true;
            }
        }
        public override void BindDataToUI()
        {
            if (_organizationAssociatedCallDS == null)
                _organizationAssociatedCallDS = (OrganizationAssociatedCallDS)BusinessRule.AssociatedDataSet;

            ugAssociatedReferrals.DataMember = _organizationAssociatedCallDS.AssociatedCall.TableName;
            ugAssociatedReferrals.DataSource = _organizationAssociatedCallDS;

        }
        /// <summary>
        /// called by parent Control or Form to load Associated Referrals        /// </summary>
        /// <param name="organizationID"></param>
        /// <param name="phoneID"></param>
        /// <returns>Count of Associated Calls</returns>
        /// <summary>
        public Int32 SelectAssociatedCall(int organizationID, int phoneID)
        {
            int associatedCallRowCount = 0;
            _organizationID = organizationID;
            _phoneID = phoneID;
            // add initialization here
            if (BusinessRule == null)
            {
                InitializeBR(new OrganizationAssociatedCallBR());
                BindDataToUI();
            }                   
            //We only want to either query by phoneID or OrganizationID
            if(_phoneID > 0)
            {
                int passZeroForOrganizationID = 0;
                ((OrganizationAssociatedCallBR)BusinessRule).SelectAssociatedCall(passZeroForOrganizationID, phoneID);
            }
            else if (_organizationID > 0)
            {
                int passZeroForPhoneID = 0; 
                ((OrganizationAssociatedCallBR)BusinessRule).SelectAssociatedCall(organizationID, passZeroForPhoneID);
            }
            associatedCallRowCount = _organizationAssociatedCallDS.AssociatedCall.Rows.Count;

            return associatedCallRowCount;
        }
        /// <summary>
        /// Removes records from the DataSet/UltraGrid. 
        /// Process:
        /// 1. Create a list callIDs to remove
        /// 2. Loop through the callIDs removing from dataset
        /// Note: if Calls are removed instead of generating the list the proces ends prematurely, failing to remove all records. 
        /// </summary>
        public void ClearControlGrid()
        { 
            Cursor.Current = Cursors.WaitCursor;
            List<Int32> callList = new List<int>();

            //clear data set tableted
            foreach (UltraGridRow ugRow in ugAssociatedReferrals.Selected.Rows)
            {
                Int32 callID = 0;
                try
                {
                    callID = Int32.Parse(ugRow.Cells[_organizationAssociatedCallDS.AssociatedCall.CallIDColumn.ColumnName].Value.ToString());
                }
                catch { }
                if (callID > 0)
                    callList.Add(callID);
                    
            }
            callList.ForEach(item => ((OrganizationAssociatedCallBR)BusinessRule).ClearAssociatedCallRow(item));
            
            Cursor.Current = Cursors.Default;    
            

        }
        private void cbOrganization_SelectedIndexChanged(object sender, EventArgs e)
        {
            //requery OrganizationPHone based on selected Organization.
            if (cbOrganization.SelectedIndex < 1)
                return;
            //load the associated numbers
            string sprocName = "OrganizationPhoneListSelect";
            Hashtable parmList = new Hashtable();
            parmList.Add("OrganizationID", cbOrganization.SelectedValue);

            cbOrganizationPhone.BindData(sprocName, parmList);

        }

        private void btnReassign_Click(object sender, EventArgs e)
        {
            //reassign associate referrals
            if (cbOrganization.SelectedIndex < 1)
                return;
            if (cbOrganizationPhone.SelectedIndex < 1)
                return;
            if (ugAssociatedReferrals.Selected.Rows.Count < 1)
                return;
            Cursor.Current = Cursors.WaitCursor;
            int newOrganizationID = (int)cbOrganization.SelectedValue;
            int newPhoneID = (int)cbOrganizationPhone.SelectedValue;

            //build a  list of AssociatedCalls
            List<OrganizationAssociatedCallDS.AssociatedCallRow> listOfOrganizationAssociatedCallDS = new List<OrganizationAssociatedCallDS.AssociatedCallRow>();
            
            //get non Archived calls
            ugAssociatedReferrals.Selected.Rows.OfType<UltraGridRow>().ToList().ForEach(ugAssociatedReferralsRow =>
                    {
                        OrganizationAssociatedCallDS.AssociatedCallRow associatedCallRow = _organizationAssociatedCallDS.AssociatedCall.NewAssociatedCallRow();
                        associatedCallRow.CallID = (int)ugAssociatedReferralsRow.Cells[_organizationAssociatedCallDS.AssociatedCall.CallIDColumn.ColumnName].Value;
                        associatedCallRow.CallTypeName = ugAssociatedReferralsRow.Cells[_organizationAssociatedCallDS.AssociatedCall.CallTypeNameColumn.ColumnName].Value.ToString();
                        associatedCallRow.CallDateTime = (DateTime)ugAssociatedReferralsRow.Cells[_organizationAssociatedCallDS.AssociatedCall.CallDateTimeColumn.ColumnName].Value;
                        associatedCallRow.SourceCodeID = (int)ugAssociatedReferralsRow.Cells[_organizationAssociatedCallDS.AssociatedCall.SourceCodeIDColumn.ColumnName].Value;
                        associatedCallRow.SourceCodeName = ugAssociatedReferralsRow.Cells[_organizationAssociatedCallDS.AssociatedCall.SourceCodeNameColumn.ColumnName].Value.ToString();
                        associatedCallRow.Name = ugAssociatedReferralsRow.Cells[_organizationAssociatedCallDS.AssociatedCall.NameColumn.ColumnName].Value.ToString();
                        associatedCallRow.DBInstance = ugAssociatedReferralsRow.Cells[_organizationAssociatedCallDS.AssociatedCall.DBInstanceColumn.ColumnName].Value.ToString();
                        listOfOrganizationAssociatedCallDS.Add(associatedCallRow);
                    });

            ((OrganizationAssociatedCallBR)BusinessRule).ReassignCall(listOfOrganizationAssociatedCallDS, _organizationID, newOrganizationID, _phoneID, newPhoneID);
            Cursor.Current = Cursors.Default;
            ClearControlGrid();
            
        }

        private void btnClearAssociatedReferrals_Click(object sender, EventArgs e)
        {
            ClearControlGrid();
        }

        private void btnViewAssociatedAssociatedReferrals_Click(object sender, EventArgs e)
        {
            //query associated referrals
            ((OrganizationAssociatedCallBR)BusinessRule).SelectAssociatedCall(_organizationID, _phoneID);

        }

        private void ugAssociatedReferrals_InitializeLayout(object sender, Infragistics.Win.UltraWinGrid.InitializeLayoutEventArgs e)
        {
            int band = 0;
            ugAssociatedReferrals.ColumnDisplay(band, typeof(AssociatedCall), _organizationAssociatedCallDS.AssociatedCall);
            ugAssociatedReferrals.DisplayLayout.Bands[GRConstant.FirstRow].Override.SelectTypeRow = SelectType.Extended;

        }

        private void ugAssociatedReferrals_DoubleClick(object sender, EventArgs e)
        {
            if (ugAssociatedReferrals.Selected.Rows.Count < 1)
                return;
            //get calltype from the grid
            string callType = ugAssociatedReferrals.Selected.Rows[GRConstant.FirstRow].Cells[_organizationAssociatedCallDS.AssociatedCall.CallTypeNameColumn.ColumnName].Value.ToString();
            //determine the callid from the grid
            int callID = (int)ugAssociatedReferrals.Selected.Rows[GRConstant.FirstRow].Cells[_organizationAssociatedCallDS.AssociatedCall.CallIDColumn.ColumnName].Value;
            string currentDB = GRConstant.CurrentDB;
            GRConstant.CurrentDB = ugAssociatedReferrals.Selected.Rows[GRConstant.FirstRow].Cells[_organizationAssociatedCallDS.AssociatedCall.DBInstanceColumn.ColumnName].Value.ToString();

            switch (callType)
            {
                case "Referral":
                    ((BaseForm)FindForm()).NavigateToVBScreen(AppScreenType.VBReferral, callID);
                    break;
                case "Message":
                    ((BaseForm)FindForm()).NavigateToVBScreen(AppScreenType.VBMessage, callID);
                    break;
                case "OASIS":
                    GeneralConstant.CreateInstance().ReferralId = callID;
                    ((BaseForm)FindForm()).LoadInFormPromptForm(AppScreenType.None, AppScreenType.Tcss);
                    break;

            }

            GRConstant.CurrentDB = currentDB;

        }

        private void cbOrganization_MouseDown(object sender, MouseEventArgs e)
        {
            if (ugAssociatedReferrals.Selected.Rows.Count > 0)
            {
                cbOrganization.DataSource = null;
                int sourceCodeID = 0;
                if (ugAssociatedReferrals.Selected.Rows[GeneralConstant.CreateInstance().FirstRow].Cells[_organizationAssociatedCallDS.AssociatedCall.SourceCodeIDColumn.ColumnName].Value.ToString().Length > 0)
                    sourceCodeID = (int)ugAssociatedReferrals.Selected.Rows[GeneralConstant.CreateInstance().FirstRow].Cells[_organizationAssociatedCallDS.AssociatedCall.SourceCodeIDColumn.ColumnName].Value;
                if (sourceCodeID == 0)
                {
                    BaseMessageBox.ShowWarning("Source Code is required to reassign!", "Source Code Required");

                    return;
                }
                Hashtable paramList = new Hashtable();
                paramList.Add("SourcecodeID", sourceCodeID);

                cbOrganization.BindData("OrganizationListSelect", paramList);
                paramList.Clear();
            }
            else
            {
                cbOrganization.DataSource = null;
            }

        }

        private void OrganizationAssociatedCall_Load(object sender, EventArgs e)
        {
            //InitializeBR(new OrganizationAssociatedCallBR());

        }
    }
}
