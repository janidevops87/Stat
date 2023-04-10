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
using Statline.StatTrac.Web.UI;
using Statline.Registry.Common;
using Statline.Registry.Data.Common;
using Statline.Registry.Data.Types;
using Statline.Registry.Data.Types.Common;
using Microsoft.Practices.EnterpriseLibrary.Logging;

namespace Statline.Registry.Web.UI.Controls
{       

    public partial class SubCategoryEditControl : BaseUserControlSecure
    {
        string SubCategoryID;
        string CategoryID;

        string LastStatEmployeeID;

        protected RegistryCommon dsCommonData;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {

                SubCategoryID = Request.QueryString["SubCategoryID"] == null ? "-1" : Request.QueryString["SubCategoryID"];
                if (SubCategoryID == "-1")
                {   // This is a new record
                    cbxSubCategoryActive.Checked = true;
                }
                else // This is an Update. Get record for update
                {
                    CategoryID = Request.QueryString["CategoryID"] == null ? "-1" : Request.QueryString["CategoryID"];

                    if (dsCommonData == null) dsCommonData = new RegistryCommon();
                    try
                    {
                        RegistryCommonManager.FillEventSubCategoryEdit(dsCommonData,
                            Convert.ToInt32(SubCategoryID),
                            0, // Category not needed
                            0 //Display both active and non-active
                        );

                        cbxSubCategoryActive.Checked = dsCommonData.EventSubCategory[0].EventSubCategoryActive;
                        txtSubCategoryName.Text = dsCommonData.EventSubCategory[0].EventSubCategoryName.ToString();
                        cbxSubCategoryAdditionalText.Checked = dsCommonData.EventSubCategory[0].EventSubCategorySpecifyText;
                        txtSubCategorySourceCode.Text = dsCommonData.EventSubCategory[0].EventSubCategorySourceCode.ToString();
                    }
                    catch (Exception ex)
                    {
                        Logger.Write(ex, "General", 1);
                        DisplayMessages.Add(MessageType.ErrorMessage, "A database error occurred.");
                    }
                    
                    LastStatEmployeeID = Page.Cookies.StatEmployeeID.ToString();

                }
            } //end !postback
        } //end pageload

        protected void btnSubCategorySave_Click(object sender, EventArgs e)
        {

            SubCategoryID = Request.QueryString["SubCategoryID"] == null ? "-1" : Request.QueryString["SubCategoryID"];
            CategoryID = Request.QueryString["CategoryID"] == null ? "-1" : Request.QueryString["CategoryID"];
            LastStatEmployeeID = Page.Cookies.StatEmployeeID.ToString();

            if (dsCommonData == null) dsCommonData = new RegistryCommon();
            try
            {

                if (SubCategoryID == "-1") // this is an insert
                {
                    RegistryCommon.EventSubCategoryRow row;
                    row = dsCommonData.EventSubCategory.NewEventSubCategoryRow();
                    row["EventCategoryID"] = Convert.ToInt32(CategoryID);
                    row["EventSubCategoryName"] = txtSubCategoryName.Text.ToString();
                    row["EventSubCategorySourceCode"] = txtSubCategorySourceCode.Text.ToString();
                    row["EventSubCategoryActive"] = cbxSubCategoryActive.Checked == true ? true : false;
                    row["EventSubCategorySpecifyText"] = cbxSubCategoryAdditionalText.Checked == true ? true : false;
                    row["LastStatEmployeeID"] = Convert.ToInt32(LastStatEmployeeID);
                    dsCommonData.EventSubCategory.AddEventSubCategoryRow(row);

                    // commit changes
                    RegistryCommonManager.UpdateEventSubCategory(dsCommonData);

                    // Get CategoryID
                    CategoryID = dsCommonData.EventSubCategory[0].EventCategoryID.ToString();

                }
                else // this is an update
                {
                    RegistryCommonManager.FillEventSubCategoryEdit(dsCommonData,
                    Convert.ToInt32(SubCategoryID),
                    0, // Sub Category not required
                    0  // Display both active and non-active
                    );

                    dsCommonData.EventSubCategory[0].EventSubCategoryActive = cbxSubCategoryActive.Checked == true ? true : false;
                    dsCommonData.EventSubCategory[0].EventSubCategoryName = txtSubCategoryName.Text.ToString();
                    dsCommonData.EventSubCategory[0].EventSubCategorySpecifyText = cbxSubCategoryAdditionalText.Checked == true ? true : false;
                    dsCommonData.EventSubCategory[0].EventSubCategorySourceCode = txtSubCategorySourceCode.Text.ToString();
                    dsCommonData.EventSubCategory[0].LastStatEmployeeID = Convert.ToInt32(LastStatEmployeeID);

                    // commit changes
                    RegistryCommonManager.UpdateEventSubCategory(dsCommonData);

                    // Get CategoryID
                    CategoryID = dsCommonData.EventSubCategory[0].EventCategoryID.ToString();
                }
            }
            catch (Exception ex)    
            {
                Logger.Write(ex, "General", 1);
                DisplayMessages.Add(MessageType.ErrorMessage, "A database error occurred.");
            }
            
            Response.Redirect("CategoryEdit.aspx?CategoryID=" + CategoryID.ToString());
        }

        protected void btnSubCategoryCancel_Click(object sender, EventArgs e)
        {
            SubCategoryID = Request.QueryString["SubCategoryID"] == null ? "-1" : Request.QueryString["SubCategoryID"];
            CategoryID = Request.QueryString["CategoryID"] == null ? "-1" : Request.QueryString["CategoryID"];

            if (CategoryID == "-1")
            {
                if (dsCommonData == null) dsCommonData = new RegistryCommon();
                RegistryCommonManager.FillEventSubCategoryEdit(dsCommonData,
                Convert.ToInt32(SubCategoryID),
                0, // Category not required
                0  // Display both active and non-active
                );

                CategoryID = dsCommonData.EventSubCategory[0].EventCategoryID.ToString();
            }

            Response.Redirect("CategoryEdit.aspx?CategoryID=" + CategoryID.ToString());
        }
    }
}