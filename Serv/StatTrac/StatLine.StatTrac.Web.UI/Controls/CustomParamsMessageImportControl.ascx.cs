using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Statline.StatTrac.Data.Types;

namespace Statline.StatTrac.Web.UI.Controls
{
    public partial class CustomParamsMessageImportControl : Statline.StatTrac.Web.UI.BaseUserControl,
        Statline.StatTrac.Web.UI.IBaseParameters
    {
        DropDownList parentddlSourceCode;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Visible)
                return;


            if (Page.Cookies.UserOrgID == ConstHelper.STATLINEORGANIZATIONID)
            {
                ddlSourceCode_Initialize();                
                if(!IsPostBack)
                    ddlCallerOrganization_LoadData();
            }

            if(!IsPostBack)
                ddlPersonList_LoadData();
            ajaxPanelMessageFor.AddLinkedRequestTrigger(ddlCallerOrganization);

        }

        #region IBaseParameters Members

        public void BuildParams(Hashtable reportParams)
        {           
            if (txtBoxCallerOrganization.Text.Length > 0)
               reportParams.Add(ReportParams.MessageCallerOrganization,  txtBoxCallerOrganization.Text);
            if(ddlPersonList.SelectedRow != null)
                reportParams.Add(ReportParams.MessageFor, ddlPersonList.SelectedRow.Cells[ddlPersonList.SelectedRow.Cells.IndexOf("PersonID")].Text);
            if (ddlCallerOrganization.SelectedRow != null)
                reportParams.Add(ReportParams.MessageForOrganizationID, ddlCallerOrganization.SelectedRow.Cells[ddlCallerOrganization.SelectedRow.Cells.IndexOf("OrganizationID")].Text);
        }

        #endregion

        protected void odsOrganizationList_Selecting(object sender, ObjectDataSourceSelectingEventArgs e)
        {
            if (!Visible)
                e.Cancel = true;
            //if (odsOrganizationList.SelectParameters["sourceCode"].DefaultValue == "...")
            //    e.Cancel = true;
        }

        protected void odsOrganizationList_Selected(object sender, ObjectDataSourceStatusEventArgs e)
        {
            //catch any errors from the data source
            if (e.Exception != null)
            {
                DisplayMessages.Add(MessageType.ErrorMessage, ConstHelper.ERRORGENERALDATABASE);

                e.ExceptionHandled = true;
            }

        }
        private void ddlCallerOrganization_LoadData()
        {            
            if (parentddlSourceCode != null && parentddlSourceCode.SelectedItem.ToString() != "...")
            {
                
                odsOrganizationList.SelectParameters["sourceCode"].DefaultValue = parentddlSourceCode.SelectedItem.ToString();
            }
            string sourceCodeType;
            if(Page.Cookies.ReportDisplayName.Contains("Message"))
                sourceCodeType = Convert.ToInt32(ConstHelper.SourceCodeType.Message).ToString();
            else
                sourceCodeType = Convert.ToInt32(ConstHelper.SourceCodeType.Imports).ToString();
            odsOrganizationList.SelectParameters["sourceCodeType"].DefaultValue = sourceCodeType;
            odsOrganizationList.SelectParameters["organizationID"].DefaultValue = Page.Cookies.UserOrgID.ToString();
        }
        private void ddlPersonList_LoadData()
        {
            string organizationID = "";
            if (ddlCallerOrganization.SelectedRow != null)
                organizationID = ddlCallerOrganization.SelectedRow.Cells.FromKey("OrganizationID").ToString();
            else
                organizationID = Page.Cookies.UserOrgID.ToString();
            odsPersonList.SelectParameters["organizationID"].DefaultValue = organizationID;
        }
        private void ddlSourceCode_Initialize()            
        {
            parentddlSourceCode = (DropDownList)this.Parent.FindControl("ddlSourceCode");

            if (parentddlSourceCode != null)
            {
                parentddlSourceCode.SelectedIndexChanged += new EventHandler(ddlSourceCode_SelectedIndexChanged);
                parentddlSourceCode.AutoPostBack = true;
                //setup the ajaxPanel to referesh the CallOrganization when the SourceCode is changed. 
                ajaxPanelCallerOrganization.AddLinkedRequestTrigger(parentddlSourceCode);
            }
        }
        private void ddlSourceCode_SelectedIndexChanged(object sender, System.EventArgs e)
        {
            ddlCallerOrganization_LoadData();
        }
        protected void ddlCallerOrganization_Init(object sender, EventArgs e)
        {
            ddlCallerOrganization_LoadData();
            ddlCallerOrganization.DataBind();
        }
        protected void odsPersonList_Selecting(object sender, ObjectDataSourceSelectingEventArgs e)
        {
            if (odsPersonList.SelectParameters["organizationID"].DefaultValue  == "")
                e.Cancel = true;
            if (!Visible)
                e.Cancel = true;
        }
        protected void odsPersonList_Selected(object sender, ObjectDataSourceStatusEventArgs e)
        {
            //catch any errors from the data source
            if (e.Exception != null)
            {
                DisplayMessages.Add(MessageType.ErrorMessage, ConstHelper.ERRORGENERALDATABASE);
                e.ExceptionHandled = true;
            }
        }
        protected void ddlCallerOrganization_SelectedRowChanged(object sender, Infragistics.WebUI.WebCombo.SelectedRowChangedEventArgs e)
        {
            ddlPersonList_LoadData();
        }
        protected void ddlPersonList_InitializeLayout(object sender, Infragistics.WebUI.UltraWebGrid.LayoutEventArgs e)
        {
            ddlPersonList.Columns.FromKey("PersonID").Hidden = true;
        }
        protected void ddlCallerOrganization_InitializeLayout(object sender, Infragistics.WebUI.UltraWebGrid.LayoutEventArgs e)
        {
            ddlCallerOrganization.Columns.FromKey("OrganizationID").Hidden = true;
        }
    }
}