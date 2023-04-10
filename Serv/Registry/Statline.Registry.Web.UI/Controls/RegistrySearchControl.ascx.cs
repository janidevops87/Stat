using System;
using System.Data;
using System.Text;
using System.Configuration;
using System.Collections;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Security;
using System.Security;
using System.Security.Cryptography;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Statline.StatTrac.Web.UI;
using Statline.StatTrac.Web.Security;
using Statline.StatTrac.Report;
using Statline.Registry.Common;
using Statline.Registry.Data.Common;
using Statline.Registry.Data.Types;
using Statline.Registry.Data.Types.Common;
using Statline.Registry.Web.UI.Framework.Navigation;
using Microsoft.Practices.EnterpriseLibrary.Logging;

namespace Statline.Registry.Web.UI.Controls
{
    public partial class RegistrySearchControl : BaseUserControlSecure
    {
        Int32 RegistryOwnerID;
        String RegistryOwnerIDValue;
        String RegistryOwnerRouteName = String.Empty;
        String RegistryOwnerName;
        protected RegistryCommon dsCommonData;
        protected RegistryCommon dsRegistry;
        CheckBox cboState;
        bool AllowDisplayNoDonors = false;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
            ddlDOB.MaxDate = DateTime.Now.AddYears(1);
            // Set Default Sort options
            ddlSort1.SelectedRow = ddlSort1.FindByText("Last Name").Row;
            ddlSort2.SelectedRow = ddlSort2.FindByText("First Name").Row;
            ddlSort3.SelectedRow = ddlSort3.FindByText("Zip Code").Row;


            //Get Specific RegistryOwner Settings
            if (dsRegistry == null)
                dsRegistry = new RegistryCommon();
            try
            {
                RegistryCommonManager.FillRegistryOwner(dsRegistry, RegistryOwnerID, RegistryOwnerRouteName);
            }
            catch (Exception ex)
            {
                Logger.Write(ex, "General", 1);
                DisplayMessages.Add(MessageType.ErrorMessage, "A database error has prevented this page from loading.");
            }

            try
            {
                //Get Registry Owner options
                AllowDisplayNoDonors = dsRegistry.RegistryOwner[0].AllowDisplayNoDonors;
                RegistryOwnerName = dsRegistry.RegistryOwner[0].RegistryOwnerName;

                // Create session
                Session.Add("AllowDisplayNoDonors", AllowDisplayNoDonors.ToString());
                Session.Add("RegistryOwnerName", (string)RegistryOwnerName.ToString());
            }
            catch (Exception ex)
            {
                Logger.Write(ex, "General", 1);
            }
            
            }
        }

        private void CreateStateCheckbox()
        {
            // Set active state selection
            int tabIndex = 30;
            int zIndex = 103;
            int top = 11;

            if (dsCommonData == null) dsCommonData = new RegistryCommon();
            RegistryCommonManager.GetRegistryOwnerStateDMVSearchOptions(dsCommonData, RegistryOwnerID);

            // Build dynamic list of state controls
            for (int i = 0; i < dsCommonData.RegistryOwnerStateConfig.Rows.Count; i++)
            {
                string stateAbbrv = dsCommonData.RegistryOwnerStateConfig[i].RegistryOwnerStateAbbrv.ToString();
                bool addControl = true;

                cboState = new CheckBox();
                cboState.Text = stateAbbrv.ToString();
                cboState.ID = "cboState" + stateAbbrv.ToString();
                cboState.Checked = true; // (Default)
                cboState.Style["z-index"] = zIndex.ToString();
                cboState.Style["TabIndex"] = tabIndex.ToString();
                cboState.Style["top"] = top.ToString() + "px";
                cboState.Style["left"] = "440px";
                cboState.Style["Width"] = "45px";
                cboState.Style["position"] = "absolute";

                //Prevent adding duplicate controls if RegistryOwner is configured to use the same state more than once (example: MIOP)
                for (int ii = 0; ii < divSection3.Controls.Count; ii++)
                {
                    if (divSection3.Controls[ii].ID == cboState.ID)
                    {
                        addControl = false;
                        ii = divSection3.Controls.Count + 1;
                    }

                }
                if (addControl)
                {
                    divSection3.Controls.Add(cboState);
                }
                // Increment position for next control
                tabIndex = tabIndex + 1;
                zIndex = zIndex + 1;
                top = top + 22;                

            }
        }

        protected void ddlSort1_SelectedRowChanged(object sender, Infragistics.WebUI.WebCombo.SelectedRowChangedEventArgs e)
        {

        }

        protected void ddlSort2_SelectedRowChanged(object sender, Infragistics.WebUI.WebCombo.SelectedRowChangedEventArgs e)
        {

        }

        protected void btnReset_Click(object sender, EventArgs e)
        {   
            // reload page with defaults
            QueryStringManager.Redirect(PageName.RegistrySearch);
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {

            //validate user input prior to post
            if (IsValid())
            {
                string SearchParameters = CreateQueryParameters();
                string URL = "RegistrySearchResults.aspx?"
                            + encryptQueryString(SearchParameters);

                //Get resultsPage
                Response.Redirect(URL);
            }
        }

        
        public bool IsValid()
        {
            bool returnValue = true;
            bool validateStatePassFlag = false; 
            // Check that at least one Registrant specific information item is checked  

            if 
                ((txtFirstName.Text.Length > 0) ||
                (txtLastName.Text.Length > 0) ||
                (txtMiddleName.Text.Length > 0) ||
                (txtCity.Text.Length > 0) ||
                (ddlState.SelectedIndex != -1) ||
                (txtZipCode.Text.Length > 0) ||
                (txtStateID.Text.Length > 0) ||
                (txtWebRegistryID.Text.Length > 0) ||
                (ddlDOB.Text.Length > 0)
                )
               
            {
                txtFirstName.BackColor = System.Drawing.Color.White;
                txtLastName.BackColor = System.Drawing.Color.White;
                txtMiddleName.BackColor = System.Drawing.Color.White;
                txtCity.BackColor = System.Drawing.Color.White;
                ddlState.BackColor = System.Drawing.Color.White;
                txtZipCode.BackColor = System.Drawing.Color.White;
                txtStateID.BackColor = System.Drawing.Color.White;
                txtWebRegistryID.BackColor = System.Drawing.Color.White;
                ddlDOB.BackColor = System.Drawing.Color.White;
            }
            else
            {
                txtFirstName.BackColor = System.Drawing.Color.Yellow;
                txtLastName.BackColor = System.Drawing.Color.Yellow;
                txtMiddleName.BackColor = System.Drawing.Color.Yellow;
                txtCity.BackColor = System.Drawing.Color.Yellow;
                ddlState.BackColor = System.Drawing.Color.Yellow;
                txtZipCode.BackColor = System.Drawing.Color.Yellow;
                txtStateID.BackColor = System.Drawing.Color.Yellow;
                txtWebRegistryID.BackColor = System.Drawing.Color.Yellow;
                ddlDOB.BackColor = System.Drawing.Color.Yellow; 
                returnValue = false;
            }


            //Check Zip code
            if (txtZipCode.Text.Length > 0)
            {
                string zipPattern = @"^\d{5}(-\d{4})?$";
                Regex zipRegex = new Regex(zipPattern);
                string zip = txtZipCode.Text.ToString();
                Match z = zipRegex.Match(zip);
                if (z.Success)
                {
                    txtZipCode.BackColor = System.Drawing.Color.White;
                }
                else
                {
                    txtZipCode.BackColor = System.Drawing.Color.Yellow;
                    returnValue = false;
                }

            }
            else 
            {
                txtZipCode.Text = "";
            }

            //Check DOB
            if (ddlDOB.Text == "" ||
                    (
                        DateTime.Parse(ddlDOB.Text).Date > DateTime.Now.AddYears(-100).Date &&
                        DateTime.Parse(ddlDOB.Text).Date < DateTime.Now.Date
                    )
               )
            {
                ddlDOB.BackColor = System.Drawing.Color.White;
            }
            else
            {
                ddlDOB.BackColor = System.Drawing.Color.Yellow;
                returnValue = false;
            }

            //Section 2 Registry Options
            if (cboDMV.Checked || cboWeb.Checked || cboWebPending.Checked)
            {
                cboWeb.BackColor = System.Drawing.Color.White;
                cboDMV.BackColor = System.Drawing.Color.White;
                cboWebPending.BackColor = System.Drawing.Color.White;
            }
            else 
            {
                cboWeb.BackColor = System.Drawing.Color.Yellow;
                cboDMV.BackColor = System.Drawing.Color.Yellow;
                cboWebPending.BackColor = System.Drawing.Color.Yellow;
                returnValue = false;

            }


            // Registry Owner State Validation
            foreach (Control ctl in divSection3.Controls)
            {
                if (ctl is CheckBox)
                {
                    CheckBox cbo = (CheckBox)ctl;
                    if (cbo.Checked == true)
                    {
                        // if at least one state checkbox is checked then
                        // validation passes.
                        validateStatePassFlag = true;
                    }
                }
            }

            if (validateStatePassFlag == true)
            {
                SetStateColor(System.Drawing.Color.White);
            }
            else
            {
                SetStateColor(System.Drawing.Color.Yellow);
                returnValue = false;
            }


            // if any validation fails, give warning 
            if (returnValue == false)
            {
                DisplayMessages.Add(MessageType.ErrorMessage, "Please correct the following items highlighted in yellow:");
            }

            return returnValue;
        }

        protected void SetStateColor(System.Drawing.Color color)
        {
            foreach (Control ctl in divSection3.Controls)
            {
                if (ctl is CheckBox)
                {
                    CheckBox cbo = (CheckBox)ctl;
                    cbo.BackColor = color;
                }
            }

        }

        public String CreateQueryParameters()
        {

            //NEOB set true
            Boolean DMVYesOnly = false;

            ArrayList fieldNameList = new ArrayList();
            ArrayList fieldValueList = new ArrayList();

            //Build StateSelection
            StringBuilder StateSelections = new StringBuilder();

            foreach (Control ctl in divSection3.Controls)
            {
                if (ctl is CheckBox)
                {
                    CheckBox cbo = (CheckBox)ctl;
                    if (cbo.Checked == true)
                    {
                        // Add state to query list
                        StateSelections.Append(cbo.Text.ToString());
                        StateSelections.Append(",");
                    }
                }
            }

           
            // Build Query String by adding key value pairs if they exist
            if (txtFirstName.Text.Length > 0) { fieldNameList.Add("FirstName"); fieldValueList.Add(txtFirstName.Text.ToString()); }
            if (txtMiddleName.Text.Length > 0) { fieldNameList.Add("MiddleName"); fieldValueList.Add(txtMiddleName.Text.ToString()); }
            if (txtLastName.Text.Length > 0) { fieldNameList.Add("LastName"); fieldValueList.Add(txtLastName.Text.ToString()); }
            if (txtCity.Text.Length > 0) { fieldNameList.Add("City"); fieldValueList.Add(txtCity.Text.ToString()); }
            if (ddlState.SelectedIndex != -1) { fieldNameList.Add("State"); fieldValueList.Add(ddlState.SelectedRow.Cells[3].Value.ToString()); }
            if (txtZipCode.Text.Length > 0) { fieldNameList.Add("Zip"); fieldValueList.Add(txtZipCode.Text.ToString()); }
            if (txtStateID.Text.Length > 0) 
                {
                    fieldNameList.Add("SID"); fieldValueList.Add(txtStateID.Text.ToString());
                }
            if (txtWebRegistryID.Text.Length > 0)
                {
                    fieldNameList.Add("WebID"); fieldValueList.Add(txtWebRegistryID.Text.ToString());
                    // Search Web only
                    cboDMV.Checked = false;
                    cboWeb.Checked = true;
                }
            if (ddlDOB.Text.Length > 0) { fieldNameList.Add("DOB"); fieldValueList.Add(ddlDOB.Text.ToString()); }

            if (StateSelections.Length > 0) { fieldNameList.Add("StateSelection"); fieldValueList.Add(StateSelections.ToString()); }

            if (cboWeb.Checked == true) { fieldNameList.Add("DisplayWebDonors"); fieldValueList.Add("true"); }
            if (cboDMV.Checked == true) { fieldNameList.Add("DisplayDMVDonors"); fieldValueList.Add("true"); }
            if (cboWebPending.Checked == true) { fieldNameList.Add("DisplayPending"); fieldValueList.Add("true"); }
            if (DMVYesOnly == true) { fieldNameList.Add("DMVYesOnly"); fieldValueList.Add("true"); }
                               else { fieldNameList.Add("DMVYesOnly"); fieldValueList.Add("false"); }

            if (ddlSort1.SelectedIndex != -1) { fieldNameList.Add("SortBy1"); fieldValueList.Add(ddlSort1.SelectedRow.Cells[1].Value.ToString()); }
            if (ddlSort2.SelectedIndex != -1) { fieldNameList.Add("SortBy2"); fieldValueList.Add(ddlSort2.SelectedRow.Cells[1].Value.ToString()); }
            if (ddlSort3.SelectedIndex != -1) { fieldNameList.Add("SortBy3"); fieldValueList.Add(ddlSort3.SelectedRow.Cells[1].Value.ToString()); }

            StringBuilder RequestQuery = new StringBuilder();
            for (int i = 0; i < fieldNameList.Count; i++)
            {
                RequestQuery.Append("&");
                RequestQuery.Append(fieldNameList[i]);
                RequestQuery.Append("=");
                RequestQuery.Append(HttpUtility.UrlEncode(fieldValueList[i].ToString()));
            }
            
            // Remove the first "&" character and add "?"
            return RequestQuery.ToString().Substring(1);
        }

        public string encryptQueryString(string strQueryString)
        {
            //ExtractAndSerialize.Encryption64 oES =
            //    new ExtractAndSerialize.Encryption64();
            //return oES.Encrypt(strQueryString, "!#$a54?3");
            return strQueryString;
        }


        protected void ddlState_InitializeLayout(object sender, Infragistics.WebUI.UltraWebGrid.LayoutEventArgs e)
        {
            ddlState.DropDownLayout.BaseTableName = "DdlState";
            ddlState.Columns[ddlState.Columns.IndexOf("RegistryOwnerStateConfigID")].Hidden = true;
            ddlState.Columns[ddlState.Columns.IndexOf("RegistryOwnerID")].Hidden = true;
            ddlState.Columns[ddlState.Columns.IndexOf("RegistryOwnerStateID")].Hidden = true;
            ddlState.Columns[ddlState.Columns.IndexOf("RegistryOwnerStateName")].Hidden = true;
            ddlState.Columns[ddlState.Columns.IndexOf("RegistryOwnerStateVerificationForm")].Hidden = true;
            ddlState.Columns[ddlState.Columns.IndexOf("RegistryOwnerStateDMVDSN")].Hidden = true;
            ddlState.Columns[ddlState.Columns.IndexOf("RegistryOwnerStateActive")].Hidden = true;
            ddlState.Columns[ddlState.Columns.IndexOf("CreateDate")].Hidden = true;
            ddlState.Columns[ddlState.Columns.IndexOf("LastModified")].Hidden = true;
            ddlState.Columns[ddlState.Columns.IndexOf("LastStatEmployeeID")].Hidden = true;
            ddlState.Columns[ddlState.Columns.IndexOf("AuditLogTypeID")].Hidden = true;


        }

        protected void ddlSort1_InitializeLayout(object sender, Infragistics.WebUI.UltraWebGrid.LayoutEventArgs e)
        {
            

        }

        protected int NumberOfControls
        {
            get { return (int)ViewState["NumControls"]; }
            set { ViewState["NumControls"] = value; }
        }

        private void InitializeComponent()
        {
            //this.Init += new System.EventHandler(this.OnInit);
        }

        protected override void OnInit(EventArgs e)
        {
            if (Session["RegistryOwnerID"] != null) RegistryOwnerID = Convert.ToInt32((string)(Session["RegistryOwnerID"].ToString()));
            else { SetSession(); } // set RegistryOwnerID session

            //Create State checkboxes prior to page load
            CreateStateCheckbox();
        }

        public void SetSession()
        {
            RegistryOwnerID = RegistryCommonManager.GetRegistryOwnerUserOrg(Convert.ToInt32(Page.Cookies.UserOrgID), 0);
            Session.Add("RegistryOwnerID", RegistryOwnerID.ToString());
            Session.Add("DisplayAllStates", "1");
        }

        protected void odsState_Selecting(object sender, ObjectDataSourceSelectingEventArgs e)
        {
            if (!Visible)
                e.Cancel = true;
        }
    }
}