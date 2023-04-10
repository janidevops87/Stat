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
using Infragistics.WebUI.UltraWebGrid;

namespace Statline.StatTrac.Web.UI.Controls
{
    public partial class CustomParamsEmployeeControl : Statline.StatTrac.Web.UI.BaseUserControl,
        Statline.StatTrac.Web.UI.IBaseParameters
    {
        // Employee parameters
        string PersonIds = null;
        string PersonNames = String.Empty;

        protected void Page_Load(object sender, EventArgs e)
        { 
            odsEmployees.SelectParameters["organizationId"].DefaultValue = Page.Cookies.UserOrgID.ToString();
            odsPersonType.SelectParameters["organizationID"].DefaultValue = Page.Cookies.UserOrgID.ToString();
            odsOrgs.SelectParameters["userOrgID"].DefaultValue = Page.Cookies.UserOrgID.ToString();
            if (Page.Cookies.ReportName.EndsWith("QA"))
            {
                CheckBox1.Visible = true;
            }
        }

        protected void ddlPersonType_InitializeLayout(object sender, Infragistics.WebUI.UltraWebGrid.LayoutEventArgs e)
        {
            ddlPersonType.DropDownLayout.BaseTableName = "PersonType";
            ddlPersonType.Columns[ddlPersonType.Columns.IndexOf("personTypeID")].Hidden = true;
        }

        protected void ddlOrganization_SelectedRowChanged(object sender, Infragistics.WebUI.WebCombo.SelectedRowChangedEventArgs e)
        {
            odsEmployees.SelectParameters["organizationId"].DefaultValue = ddlOrganization.SelectedRow.Cells[1].Value.ToString();
            odsPersonType.SelectParameters["organizationID"].DefaultValue = ddlOrganization.SelectedRow.Cells[1].Value.ToString();
        }

        protected void ddlPersonType_SelectedRowChanged(object sender, Infragistics.WebUI.WebCombo.SelectedRowChangedEventArgs e)
        {
            odsEmployees.SelectParameters["personTypeID"].DefaultValue = ddlPersonType.SelectedRow.Cells[0].Value.ToString();
        }

        protected void radioButtonEmployeeOptions_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (radioButtonEmployeeOptions.SelectedValue == "2")
            {
                DisplayEmployeeSelectionControls();
            }
            else
            {

                HideEmployeeSelectionControls();
            }
            
            // Clear Employee selection
            ResetEmployeeSelection();
        }

        private void HideEmployeeSelectionControls()
        {
            // Hide Controls
            EmployeeSelection.Visible = false;
            gridEmployees.Visible = false;
            lbSelectedPersons.Visible = false;
            Label3.Visible = false;
            Label4.Visible = false;
            ddlOrganization.Visible = false;
            ddlPersonType.Visible = false;
            btnAddSelection.Visible = false;
            btnReset.Visible = false;
        }

        private void DisplayEmployeeSelectionControls()
        {
            string personids = String.Empty;

            // Display fieldSet for Employee selection
            EmployeeSelection.Visible = true;

            // If PersonIds exist show the control
            if (Session["PersonIds"] != null) personids = (string)(Session["PersonIds"].ToString());
            if (personids.Length > 0)
            {
                lbSelectedPersons.Visible = true;
            }
            else
            {
                // if selection does not exist show the grid.
                gridEmployees.Visible = true;
                Label3.Visible = true;
                Label4.Visible = true;
                btnAddSelection.Visible = true;
                lbSelectedPersons.Visible = false;
            }

            btnReset.Visible = true;
            ddlOrganization.Visible = true;
            ddlPersonType.Visible = true;
        }

        public void BuildParams(Hashtable parameters)
        {
            string personidsBuildParameters = String.Empty;

            if (Session["PersonIds"] != null) personidsBuildParameters = (string)(Session["PersonIds"].ToString());

            // Add PersonIds if there is a string
            if (personidsBuildParameters.Length > 0)
                parameters.Add(ReportParams.Personids, personidsBuildParameters);
            
            if (CheckBox1.Checked)
                parameters.Add(ReportParams.HideEmployee, CheckBox1.Checked);
        }

        protected void ddlOrganization_InitializeLayout(object sender, LayoutEventArgs e)
        {
            ddlOrganization.Columns[ddlOrganization.Columns.IndexOf("OrganizationID")].Hidden = true;
        }

        protected void odsPersonType_Selecting(object sender, ObjectDataSourceSelectingEventArgs e)
        {
            if (!Visible)
                e.Cancel = true;
        }

        protected void odsOrgs_Selecting(object sender, ObjectDataSourceSelectingEventArgs e)
        {
            if (!Visible)
                e.Cancel = true;
        }

        protected void odsEmployees_Selecting(object sender, ObjectDataSourceSelectingEventArgs e)
        {
            if (!Visible)
                e.Cancel = true;
        }


        private void ResetEmployeeSelection()
        {
            //reset Employee Selection
            Session.Add("PersonIds", String.Empty);
            lbSelectedPersons.Items.Clear();

            ddlOrganization.DisplayValue = Page.Cookies.UserOrganizationName;
            odsEmployees.SelectParameters["OrganizationId"].DefaultValue = Page.Cookies.UserOrgID.ToString();
            odsPersonType.SelectParameters["OrganizationId"].DefaultValue = Page.Cookies.UserOrgID.ToString();
        }

        protected void btnAddSelection_Click(object sender, EventArgs e)
        {
            
            if (gridEmployees.Visible == false)
            {   
                // if a selection has already been made and user presses the Add to Selection btn
                // the show the grid to add new selections.  
                gridEmployees.Visible = true;
                return;
            }

            // Get Employee list patameters if exists.
            if (Session["PersonIds"] != null) PersonIds = (string)(Session["PersonIds"].ToString());
            if (Session["PersonNames"] != null) PersonNames = (string)(Session["PersonNames"].ToString());

            if (radioButtonEmployeeOptions.SelectedValue == "2")
            {
                try
                {
                    // loop to add person ids to selection list
                    for (int loop = 0; loop < gridEmployees.Rows.Count; loop++)
                    {
                        if (Convert.ToBoolean(gridEmployees.Rows[loop].Cells[0].Value) == true)
                        {
                            if (!String.IsNullOrEmpty(PersonIds))
                            {   
                                // Parameter uses comma on data. Pipe is used as separator on display names.
                                PersonIds = PersonIds + "," + gridEmployees.Rows[loop].Cells[3].Text.ToString();
                                PersonNames = PersonNames + "|" + gridEmployees.Rows[loop].Cells[1].Text.ToString();
                            }
                            else
                            {   // Add first person
                                PersonIds = gridEmployees.Rows[loop].Cells[3].Text.ToString();
                                PersonNames = gridEmployees.Rows[loop].Cells[1].Text.ToString();
                            }
                        }
                    }

                    // Store Employee selections
                    Session.Add("PersonIds", (string)PersonIds.ToString());
                    Session.Add("PersonNames", (string)PersonNames.ToString());

                    // Grid and other controls are hidden because selection has been made.
                    // Hide the controls.
                    gridEmployees.Visible = false;
                    Label3.Visible = false;
                    Label4.Visible = false;

                    // The 'Add to Selection' button should display for adding additional items to list.
                    btnAddSelection.Visible = true;

                    // Allow 'Reset' button to clear Employee Selection
                    btnReset.Visible = true;

                    // Clear the Listbox
                    lbSelectedPersons.Items.Clear();
                    
                    // Create an array of person names to display
                    char[] charSeparators = new char[] {'|'};
                    string[] personarray = PersonNames.Split(charSeparators);
                    

                    // Populate Selected Persons Listbox
                    if (!String.IsNullOrEmpty(personarray.ToString()))
                    {
                        for (int i = 0; i < personarray.Length; i++)
                        {
                            lbSelectedPersons.Items.Add(personarray[i]);
                        }
                    }

                    // Show Selected Persons listbox;
                    lbSelectedPersons.Visible = true;

                }

                catch (NullReferenceException nre)
                {

                }
            }
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            // Reset the Employee Selection grid
            ResetEmployeeSelection();
            DisplayEmployeeSelectionControls();
        }

    }
}