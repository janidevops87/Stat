using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Drawing;
using System.Text;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Statline.StatTrac.Data.Types;
using Statline.StatTrac.Web;
using Statline.StatTrac.Web.UI;
using Infragistics.WebUI.WebCombo;
using Infragistics.WebUI.UltraWebGrid;


namespace Statline.StatTrac.Web.UI
{
    public partial class PersonData : System.Web.UI.Page
    {
        protected Statline.StatTrac.Data.Types.UserData dsUserData;
        protected void Page_Load(object sender, EventArgs e)
        {
            //if (Application["ValidPoints"].ToString() == "NO")
            odsOrgs.SelectParameters["userOrgID"].DefaultValue = Application["OrgID"].ToString();
            odsPersonType.SelectParameters["organizationID"].DefaultValue = Application["OrgID"].ToString();
        }

        protected void odsPersonType_Selecting(object sender, ObjectDataSourceSelectingEventArgs e)
        {

        }

        protected void ddlPersonType_InitializeLayout(object sender, LayoutEventArgs e)
        {
            ddlPersonType.DropDownLayout.BaseTableName = "PersonType";
            ddlPersonType.Columns[ddlPersonType.Columns.IndexOf("PersonTypeID")].Hidden = true;
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            if (IsValid())
            {
                this.dsUserData = new Statline.StatTrac.Data.Types.UserData();
                UserData.PersonRow personRow;
                //build a person row with default values
                personRow = dsUserData.Person.AddPersonRow(
                    txtBoxFirstName.Text,//first name
                    null,//middle intial
                    txtBoxLastName.Text,//last name
                    Convert.ToInt32(ddlPersonType.SelectedRow.Cells[0].Value.ToString()),//org
                    Convert.ToInt32(ddlOrganization.SelectedRow.Cells[1].Value.ToString()),//type
                    null,//Person Notes
                    0,//Busy
                    0, //isverified
                    0,//Inactive
                    DateTime.Now,//Busy Until
                    0,//Note Active
                    DateTime.Now,//Expires
                    "",//Temp Note
                    "",//Unused
                    0,//Access
                    0,//Security
                    0,//Archive
                    -1,//Last Employee
                    1);//Audit Log ID
                Person.PersonManager.UpdatePerson(dsUserData, -1);
            }
        }
         public bool IsValid()
        {
            bool returnValue = true;
            Label5.Visible = false;
            if (string.IsNullOrEmpty(txtBoxFirstName.Text) || string.IsNullOrEmpty(txtBoxLastName.Text) || ddlPersonType.SelectedIndex == -1 || ddlOrganization.SelectedIndex == -1)
            {
                returnValue = false;
                Label5.Visible = true;
                //return returnValue;
            }

            return returnValue;
        }

        protected void ddlOrganization_SelectedRowChanged(object sender, SelectedRowChangedEventArgs e)
        {
            ddlOrganization.DropDownLayout.BaseTableName = "OrganizationList";
            ddlOrganization.Columns[ddlOrganization.Columns.IndexOf("OrganizationID")].Hidden = true;
        }
    }
}
