using System;
using Statline.StatTrac.Web.UI;
using Statline.Registry.Data.Types.Common;
using Statline.Registry.Common;

namespace Statline.Registry.Web.UI.Controls
{
    public partial class CategoryEditControl : BaseUserControlSecure
    {
        string CategoryID;
        Int32 RegistryOwnerID;
        string LastStatEmployeeID;

        protected RegistryCommon dsCommonData;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                //if (Session["RegistryOwnerID"] != null) RegistryOwnerID = Convert.ToInt32((string)(Session["RegistryOwnerID"].ToString()));
                //else { RegistryOwnerID = 1; } //set default
                
                LastStatEmployeeID = Page.Cookies.StatEmployeeID.ToString();
                CategoryID = Request.QueryString["CategoryID"] == null ? "-1" : Request.QueryString["CategoryID"];

                if (CategoryID == "-1")
                {   // this is a new record
                    cbxCategoryActive.Checked = true;
                }
                else 
                {   // this is an update. get record to update
                    //RegistryOwnerID = "1";
                    if (dsCommonData == null) dsCommonData = new RegistryCommon();
                    try
                    {
                        RegistryCommonManager.FillEventCategoryEdit(dsCommonData,
                            Convert.ToInt32(CategoryID),
                            Convert.ToInt32(RegistryOwnerID),
                            0 //Display both active and non-active
                        );

                        cbxCategoryActive.Checked = dsCommonData.EventCategory[0].EventCategoryActive;
                        txtCategoryName.Text = dsCommonData.EventCategory[0].EventCategoryName.ToString();
                        cbxCategoryAdditionalText.Checked = dsCommonData.EventCategory[0].EventCategorySpecifyText;


                    }
                    catch
                    {
                    }
                    finally
                    {
                    }
                }
                //Get SubCategory values
                odsSubCategory.SelectParameters["EventSubCategoryID"].DefaultValue = "0"; // Return all sub category
                odsSubCategory.SelectParameters["EventCategoryID"].DefaultValue = CategoryID;
                odsSubCategory.SelectParameters["EventSubCategoryActive"].DefaultValue = "0"; // Return both active and non-active
                odsSubCategory.DataBind();            
            } //end !postback
        }


        protected void gridMaintainSubCategoryLists_InitializeLayout(object sender, Infragistics.WebUI.UltraWebGrid.LayoutEventArgs e)
        {

        }

        protected void btnSubCategoryAdd_Click(object sender, EventArgs e)
        {
            
            CategoryID = Request.QueryString["CategoryID"] == null ? "-1" : Request.QueryString["CategoryID"];
            if (CategoryID != "-1")
            {
                Response.Redirect("SubCategoryEdit.aspx?CategoryID=" + CategoryID.ToString());
            }
        }

        protected void btnCategorySave_Click(object sender, EventArgs e)
        {
            CategoryID = Request.QueryString["CategoryID"] == null ? "-1" : Request.QueryString["CategoryID"];
            //RegistryOwnerID = "1";
            LastStatEmployeeID = Page.Cookies.StatEmployeeID.ToString();

            if (dsCommonData == null) dsCommonData = new RegistryCommon();
            try
            {
                RegistryCommonManager.FillEventCategoryEdit(dsCommonData,
                Convert.ToInt32(CategoryID),
                Convert.ToInt32(RegistryOwnerID),
                0 //Display both active and non-active
                );

                if (CategoryID == "-1") // this is a new record
                {
                    RegistryCommon.EventCategoryRow row;
                    row = dsCommonData.EventCategory.NewEventCategoryRow();
                    row["RegistryOwnerID"] = Convert.ToInt32(RegistryOwnerID);
                    row["EventCategoryName"] = txtCategoryName.Text.ToString();
                    row["EventCategoryActive"] = cbxCategoryActive.Checked == true ? true : false;
                    row["EventCategorySpecifyText"] = cbxCategoryAdditionalText.Checked == true ? true : false;
                    row["LastStatEmployeeID"] = Convert.ToInt32(LastStatEmployeeID);
                    dsCommonData.EventCategory.AddEventCategoryRow(row);
                }
                else // this is an update 
                {
                    dsCommonData.EventCategory[0].EventCategoryActive = cbxCategoryActive.Checked == true ? true : false;
                    dsCommonData.EventCategory[0].EventCategoryName = txtCategoryName.Text.ToString();
                    dsCommonData.EventCategory[0].EventCategorySpecifyText = cbxCategoryAdditionalText.Checked == true ? true : false;
                    dsCommonData.EventCategory[0].LastStatEmployeeID = Convert.ToInt32(LastStatEmployeeID);
                    // commit changes
                }
                RegistryCommonManager.UpdateEventCategory(dsCommonData);

            }
            catch
            {
            }
            finally
            {
            }
            
            //redirect to preceding page
            Response.Redirect("MaintainCategory.aspx");
        }

        protected void btnCategoryCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("MaintainCategory.aspx");

        }
        protected override void OnInit(EventArgs e)
        {
            if (Session["RegistryOwnerID"] != null) RegistryOwnerID = Convert.ToInt32((string)(Session["RegistryOwnerID"].ToString()));
        }
    }
}