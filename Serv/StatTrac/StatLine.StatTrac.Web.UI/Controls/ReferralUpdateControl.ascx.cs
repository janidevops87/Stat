using System;
using System.Data;
using System.Text;
using System.Web.UI.WebControls;
using Statline.Configuration;
using Statline.StatTrac.Data.Types;
using Statline.StatTrac.Referral;
using Statline.StatTrac.Person;

namespace Statline.StatTrac.Web.UI.Controls
{
    public partial class ReferralUpdateControl : BaseUserControlSecure
    {
        protected ReferralData dsReferralData;
        protected ReferralData dsCallData;

        protected void Page_Load(object sender, System.EventArgs e)
        {
            if (IsPostBack) return;

            if (!String.IsNullOrEmpty(Request.QueryString["CallID"]))
            {
                Page.Cookies.StatEmployeeID = PersonManager.CheckStatEmployee(Page.Cookies.StatEmployeeID, Page.Cookies.UserId);
                odsReferralSingle.SelectParameters["CallID"].DefaultValue = Request.QueryString["CallID"];
                odsReferralSingle.SelectParameters["UserOrgID"].DefaultValue = Request.QueryString["RefCallerOrgID"];
                odsReferralSingle.SelectParameters["reportGroupID"].DefaultValue = Page.Cookies.ReportGroupID.ToString();
                odsReferralSingle.SelectParameters["timeZone"].DefaultValue = Page.Cookies.TimeZone;
                odsApproacherList.SelectParameters["CallID"].DefaultValue = Request.QueryString["CallID"];

                Page.Cookies.CallID = Convert.ToInt32(Request.QueryString["CallID"]);
                Page.Cookies.OrganizationID = Convert.ToInt32(Request.QueryString["RefCallerOrgID"]);
                Page.Cookies.CallNumber = Request.QueryString["CallNumber"];
                Page.Cookies.PatientDemographics = Request.QueryString["A/S/R"];
                Page.Cookies.OrganizationName = Request.QueryString["OrganizationName"];
                Page.Cookies.PatientInfo = Request.QueryString["ReferralDonorName"];
                Page.Cookies.CallDate = Convert.ToDateTime(Request.QueryString["BasedOnDT"]);
                this.lblSourceCodeName.Text = Request.QueryString["SourceCodeName"];
            }
            else
            {
                odsReferralSingle.SelectParameters["CallID"].DefaultValue = Page.Cookies.CallID.ToString();
                odsReferralSingle.SelectParameters["UserOrgID"].DefaultValue = Page.Cookies.OrganizationID.ToString();
                odsReferralSingle.SelectParameters["reportGroupID"].DefaultValue = Page.Cookies.ReportGroupID.ToString();
                odsReferralSingle.SelectParameters["timeZone"].DefaultValue = Page.Cookies.TimeZone;
                odsApproacherList.SelectParameters["CallID"].DefaultValue = Page.Cookies.CallID.ToString();
            }
            gridAppropriate.DataBind();
            gridConsent.DataBind();
            gridRecovery.DataBind();

            int test = ReferralManager.GetCallLocked(Page.Cookies.CallID, Page.Cookies.StatEmployeeID, 0);
            if (test == 1)
            {
                DisplayMessages.Add(MessageType.ErrorMessage, "Referral is currently opened by another user.");
                btnSave.Enabled = false;
            }
            else
            {
                ReferralManager.LockCall(Convert.ToInt32(Page.Cookies.CallID), Page.Cookies.StatEmployeeID, Page.Cookies.UserId, Page.Cookies.StatEmployeeID, 3, 0);//was 2
            }
        }

        protected void UltraWebGrid1_DataBound(object sender, EventArgs e)
        {
            //have to get the data this way, because the date wouldn't come over as query string
            try
            {
                Page.Cookies.CallDate = Convert.ToDateTime(gridAppropriate.Rows[0].Cells[7].Text);
                this.lblCallDT1.Text = gridAppropriate.Rows[0].Cells[7].Text;
                if (dsReferralData == null) dsReferralData = new ReferralData();
                ReferralManager.FillDonorCategoryList(dsReferralData, Convert.ToInt32(Page.Cookies.OrganizationID), lblSourceCodeName.Text.ToString());
                for (int loop = 1; loop < dsReferralData.DonorCategory.Count; loop++)
                {
                    gridAppropriate.Rows[0].Cells[Convert.ToInt32(dsReferralData.DonorCategory[loop].DonorCategoryID)].Column.Header.Caption = dsReferralData.DonorCategory[loop].DynamicDonorCategoryName;
                }
                //the last category goes to cell 26...
                gridAppropriate.Rows[0].Cells[26].Column.Header.Caption = dsReferralData.DonorCategory[6].DynamicDonorCategoryName;
            }
            catch { };
            //handle whether to show appropriate data
            if (gridAppropriate.Rows[0].Cells[11].Text == "0") gridAppropriate.Rows[0].Cells[1].Text = null;
            if (gridAppropriate.Rows[0].Cells[12].Text == "0") gridAppropriate.Rows[0].Cells[2].Text = null;
            if (gridAppropriate.Rows[0].Cells[13].Text == "0") gridAppropriate.Rows[0].Cells[3].Text = null;
            if (gridAppropriate.Rows[0].Cells[14].Text == "0") gridAppropriate.Rows[0].Cells[4].Text = null;
            if (gridAppropriate.Rows[0].Cells[15].Text == "0") gridAppropriate.Rows[0].Cells[5].Text = null;
            if (gridAppropriate.Rows[0].Cells[16].Text == "0") gridAppropriate.Rows[0].Cells[6].Text = null;
            if (gridAppropriate.Rows[0].Cells[24].Text == "0") gridAppropriate.Rows[0].Cells[26].Text = null;
        }

        #region Populate DropDowns
        
        protected void GetApproachType(object sender, EventArgs e)
        {
            if (IsPostBack) return;
            DropDownList dropdownlist = (DropDownList)sender;
            if (gridAppropriate.Rows[0].Cells[8].Text != null)
            {
                dropdownlist.Items.Insert(0, new ListItem(gridAppropriate.Rows[0].Cells[8].Text, gridAppropriate.Rows[0].Cells[23].Text));
            }
            else
            {
                dropdownlist.Items.Insert(0, new ListItem("", "-1"));
            }
           
        }

        protected void GetApproacher(object sender, EventArgs e)
        {
            if (IsPostBack) return;
            DropDownList dropdownlist = (DropDownList)sender;
            if (gridAppropriate.Rows[0].Cells[23].Text == "1")
            {
                dropdownlist.Enabled = false;
                dropdownlist.Items.Clear();
            }
            else
            {
                if (gridAppropriate.Rows[0].Cells[9].Text == null)
                {
                    dropdownlist.Items.Insert(0, new ListItem("","-1"));
                }
                else
                {
                    dropdownlist.Items.Insert(0, new ListItem(gridAppropriate.Rows[0].Cells[9].Text, gridAppropriate.Rows[0].Cells[48].Text));
                }
            }
            
        }

        protected void GetConsent(object sender, EventArgs e)
        {
            if (IsPostBack) return;
            DropDownList dropdownlist = (DropDownList)sender;
            if (gridAppropriate.Rows[0].Cells[23].Text == "1")
            {
                dropdownlist.Enabled = false;
                dropdownlist.Items.Clear();
            }
            else
            {
                string val;
                dropdownlist.Items.Clear();
                switch (gridAppropriate.Rows[0].Cells[10].Text)
                {
                        case "Yes-Written" : val = "1";
                            break;
                        case "Yes-Verbal" : val = "2";
                            break;
                        case "No" : val = "3";
                            break;
                        default: val = "-1";
                            break;

                    } 
                dropdownlist.Items.Insert(0, new ListItem("No", "3"));
                dropdownlist.Items.Insert(0, new ListItem("Yes-Verbal", "2"));
                dropdownlist.Items.Insert(0, new ListItem("Yes-Written", "1"));
                
                if (gridAppropriate.Rows[0].Cells[10].Text == null)
                {
                    dropdownlist.Items.Insert(0, new ListItem("", val));
                }
                else
                {
                    dropdownlist.Items.Insert(0, new ListItem(gridAppropriate.Rows[0].Cells[10].Text, val));
                }
                
            }
        }

        protected void GetCurrentApproachOrgan(object sender, EventArgs e)
        {
            if (IsPostBack) return;
            DropDownList dropdownlist = (DropDownList)sender;
            try
            {
                if (gridAppropriate.Rows[0].Cells[1].Text != "Yes")
                {
                    //dropdownlist.Enabled = false;
                    dropdownlist.Items.Clear();
                }
                else
                {
                    //service level on (is -1) view on and update on
                    if (gridAppropriate.Rows[0].Cells[27].Text == "-1" && gridAppropriate.Rows[0].Cells[11].Text == "1" && gridAppropriate.Rows[0].Cells[17].Text == "1")
                    {
                        dropdownlist.Enabled = true;
                        dropdownlist.Items.Insert(0, new ListItem("", "-1"));
                        dropdownlist.Items.Insert(0, gridApproach.Rows[0].Cells[1].Text);
                        return;
                    }

                    if ((gridAppropriate.Rows[0].Cells[27].Text == "-1") && (gridAppropriate.Rows[0].Cells[11].Text == "1") && (gridAppropriate.Rows[0].Cells[17].Text == "0"))
                    {
                        dropdownlist.Items.Insert(0, gridApproach.Rows[0].Cells[1].Text);
                        return;
                    }
                    dropdownlist.Items.Clear();
                }
            }
            catch { }
        }

        protected void GetCurrentApproachBone(object sender, EventArgs e)
        {
            if (IsPostBack) return;
            DropDownList dropdownlist = (DropDownList)sender;
            try
            {
                if (gridAppropriate.Rows[0].Cells[2].Text != "Yes")
                {
                    //dropdownlist.Enabled = false;
                    dropdownlist.Items.Clear();
                }
                else
                {
                    if (gridAppropriate.Rows[0].Cells[28].Text == "-1" && gridAppropriate.Rows[0].Cells[12].Text == "1" && gridAppropriate.Rows[0].Cells[18].Text == "1")
                    {
                        dropdownlist.Enabled = true;
                        dropdownlist.Items.Insert(0, new ListItem("", "-1"));
                        dropdownlist.Items.Insert(0, gridApproach.Rows[0].Cells[2].Text);
                        return;
                    }

                    if ((gridAppropriate.Rows[0].Cells[28].Text == "-1") && (gridAppropriate.Rows[0].Cells[12].Text == "1") && (gridAppropriate.Rows[0].Cells[18].Text == "0"))
                    {
                        dropdownlist.Items.Insert(0, gridApproach.Rows[0].Cells[2].Text);
                        return;
                    }
                    dropdownlist.Items.Clear();
                }
            }
            catch{}
        }

        protected void GetCurrentApproachTissue(object sender, EventArgs e)
        {
            if (IsPostBack) return;
            DropDownList dropdownlist = (DropDownList)sender;
            try
            {
                if (gridAppropriate.Rows[0].Cells[3].Text != "Yes")
                {
                    //dropdownlist.Enabled = false;
                    dropdownlist.Items.Clear();
                }
                else
                {
                    if (gridAppropriate.Rows[0].Cells[29].Text == "-1" && gridAppropriate.Rows[0].Cells[13].Text == "1" && gridAppropriate.Rows[0].Cells[19].Text == "1")
                    {
                        dropdownlist.Enabled = true;
                        dropdownlist.Items.Insert(0, new ListItem("", "-1"));
                        dropdownlist.Items.Insert(0, gridApproach.Rows[0].Cells[3].Text);
                        return;
                    }
                    if ((gridAppropriate.Rows[0].Cells[29].Text == "-1") && (gridAppropriate.Rows[0].Cells[13].Text == "1") && (gridAppropriate.Rows[0].Cells[19].Text == "0"))
                    {
                        dropdownlist.Items.Insert(0, gridApproach.Rows[0].Cells[3].Text);
                        return;
                    }
                    dropdownlist.Items.Clear();
                }
            }
            catch{}
        }

        protected void GetCurrentApproachSkin(object sender, EventArgs e)
        {
            if (IsPostBack) return;
            DropDownList dropdownlist = (DropDownList)sender;
            try
            {
                if (gridAppropriate.Rows[0].Cells[4].Text != "Yes")
                {
                    //dropdownlist.Enabled = false;
                    dropdownlist.Items.Clear();
                }
                else
                {
                    if (gridAppropriate.Rows[0].Cells[30].Text == "-1" && gridAppropriate.Rows[0].Cells[14].Text == "1" && gridAppropriate.Rows[0].Cells[20].Text == "1")
                    {
                        dropdownlist.Enabled = true;
                        dropdownlist.Items.Insert(0, new ListItem("", "-1"));
                        dropdownlist.Items.Insert(0, gridApproach.Rows[0].Cells[4].Text);
                        return;
                    }
                    if ((gridAppropriate.Rows[0].Cells[30].Text == "-1") && (gridAppropriate.Rows[0].Cells[14].Text == "1") && (gridAppropriate.Rows[0].Cells[20].Text == "0"))
                    {
                        dropdownlist.Items.Insert(0, gridApproach.Rows[0].Cells[4].Text);
                        return;
                    }
                    dropdownlist.Items.Clear();
                }
            }
            catch{}
        }

        protected void GetCurrentApproachValve(object sender, EventArgs e)
        {
            if (IsPostBack) return;
            DropDownList dropdownlist = (DropDownList)sender;
            try
            {
                if (gridAppropriate.Rows[0].Cells[5].Text != "Yes")
                {
                    //dropdownlist.Enabled = false;
                    dropdownlist.Items.Clear();
                }
                else
                {
                    if (gridAppropriate.Rows[0].Cells[31].Text == "-1" && gridAppropriate.Rows[0].Cells[15].Text == "1" && gridAppropriate.Rows[0].Cells[21].Text == "1")
                    {
                        dropdownlist.Enabled = true;
                        dropdownlist.Items.Insert(0, new ListItem("", "-1"));
                        dropdownlist.Items.Insert(0, gridApproach.Rows[0].Cells[5].Text);
                        return;
                    }
                    if ((gridAppropriate.Rows[0].Cells[31].Text == "-1") && (gridAppropriate.Rows[0].Cells[15].Text == "1") && (gridAppropriate.Rows[0].Cells[21].Text == "0"))
                    {
                        dropdownlist.Items.Insert(0, gridApproach.Rows[0].Cells[5].Text);
                        return;
                    }
                    dropdownlist.Items.Clear();
                }
            }
            catch{}
        }

        protected void GetCurrentApproachEyes(object sender, EventArgs e)
        {
            if (IsPostBack) return;
            DropDownList dropdownlist = (DropDownList)sender;
            try
            {
                if (gridAppropriate.Rows[0].Cells[6].Text != "Yes")
                {
                    //dropdownlist.Enabled = false;
                    dropdownlist.Items.Clear();
                }
                else
                {
                    if (gridAppropriate.Rows[0].Cells[32].Text == "-1" && gridAppropriate.Rows[0].Cells[16].Text == "1" && gridAppropriate.Rows[0].Cells[22].Text == "1")
                    {
                        dropdownlist.Enabled = true;
                        dropdownlist.Items.Insert(0, new ListItem("", "-1"));
                        dropdownlist.Items.Insert(0, gridApproach.Rows[0].Cells[6].Text);
                        return;
                    }
                    if (gridAppropriate.Rows[0].Cells[32].Text == "-1" && gridAppropriate.Rows[0].Cells[16].Text == "1" && gridAppropriate.Rows[0].Cells[22].Text == "0")
                    {
                        dropdownlist.Items.Insert(0, gridApproach.Rows[0].Cells[6].Text);
                        return;
                    }
                    dropdownlist.Items.Clear();
                }
            }
            catch{}
        }

        protected void GetCurrentApproachOther(object sender, EventArgs e)
        {
            if (IsPostBack) return;
            DropDownList dropdownlist = (DropDownList)sender;
            try
            {
                if (gridAppropriate.Rows[0].Cells[26].Text != "Yes")
                {
                    //dropdownlist.Enabled = false;
                    dropdownlist.Items.Clear();
                }
                else
                {
                    if (gridAppropriate.Rows[0].Cells[33].Text == "-1" && gridAppropriate.Rows[0].Cells[24].Text == "1" && gridAppropriate.Rows[0].Cells[25].Text == "1")
                    {
                        dropdownlist.Enabled = true;
                        dropdownlist.Items.Insert(0, new ListItem("", "-1"));
                        dropdownlist.Items.Insert(0, gridApproach.Rows[0].Cells[7].Text);
                        return;
                    }
                    if (gridAppropriate.Rows[0].Cells[33].Text == "-1" && gridAppropriate.Rows[0].Cells[24].Text == "1" && gridAppropriate.Rows[0].Cells[25].Text == "0")
                    {
                        dropdownlist.Items.Insert(0, gridApproach.Rows[0].Cells[7].Text);
                        return;
                    }
                    dropdownlist.Items.Clear();
                }
            }
            catch { }
        }
       
        protected void GetCurrentConsentOrgan(object sender, EventArgs e)
        {
            DropDownList dropdownlist = (DropDownList)sender;
            try 
            {
                if (gridAppropriate.Rows[0].Cells[1].Text != "Yes")
                {
                    dropdownlist.Enabled = false;
                    dropdownlist.Items.Clear();
                    return;
                }

                if (ddlApproachOrgan.SelectedItem.Text != "Yes")
                {
                    dropdownlist.Enabled = false;
                    dropdownlist.Items.Clear();
                    return;
                }
                if (IsPostBack) return;
                if (gridAppropriate.Rows[0].Cells[34].Text == "-1" && gridAppropriate.Rows[0].Cells[11].Text == "1" && gridAppropriate.Rows[0].Cells[17].Text == "1")
                {
                    dropdownlist.Enabled = true;
                    dropdownlist.Items.Insert(0, new ListItem("", "-1"));
                    dropdownlist.Items.Insert(0, gridConsent.Rows[0].Cells[1].Text);
                    return;
                }

                if ((gridAppropriate.Rows[0].Cells[34].Text == "-1") && (gridAppropriate.Rows[0].Cells[11].Text == "1") && (gridAppropriate.Rows[0].Cells[17].Text == "0"))
                {
                    dropdownlist.Items.Insert(0, gridConsent.Rows[0].Cells[1].Text);
                    return;
                }
                dropdownlist.Items.Clear();
            }
            catch
            {
                dropdownlist.Items.Clear();
            }
        }

        protected void GetCurrentConsentBone(object sender, EventArgs e)
        {
            DropDownList dropdownlist = (DropDownList)sender;
            try 
            {
                if (gridAppropriate.Rows[0].Cells[2].Text != "Yes")
                {
                    dropdownlist.Enabled = false;
                    dropdownlist.Items.Clear();
                    return;
                }
                if (ddlApproachBone.SelectedItem.Text != "Yes")
                {
                    dropdownlist.Enabled = false;
                    dropdownlist.Items.Clear();
                    return;
                }
                if (IsPostBack) return;
                if (gridAppropriate.Rows[0].Cells[35].Text == "-1" && gridAppropriate.Rows[0].Cells[12].Text == "1" && gridAppropriate.Rows[0].Cells[18].Text == "1")
                {
                    dropdownlist.Enabled = true;
                    dropdownlist.Items.Insert(0, new ListItem("", "-1"));
                    dropdownlist.Items.Insert(0, gridConsent.Rows[0].Cells[2].Text);
                    return;
                }

                if ((gridAppropriate.Rows[0].Cells[35].Text == "-1") && (gridAppropriate.Rows[0].Cells[12].Text == "1") && (gridAppropriate.Rows[0].Cells[18].Text == "0"))
                {
                    dropdownlist.Items.Insert(0, gridConsent.Rows[0].Cells[2].Text);
                    return;
                }
                dropdownlist.Items.Clear();
            }
            catch
            {
                dropdownlist.Items.Clear();
            }
        }

        protected void GetCurrentConsentTissue(object sender, EventArgs e)
        {
            DropDownList dropdownlist = (DropDownList)sender;
            try
            {
                if (gridAppropriate.Rows[0].Cells[3].Text != "Yes")
                {
                    dropdownlist.Enabled = false;
                    dropdownlist.Items.Clear();
                    return;
                }
                if (ddlApproachTissue.SelectedItem.Text != "Yes")
                {
                    dropdownlist.Enabled = false;
                    dropdownlist.Items.Clear();
                    return;
                } 
                if (IsPostBack) return;
                if (gridAppropriate.Rows[0].Cells[36].Text == "-1" && gridAppropriate.Rows[0].Cells[13].Text == "1" && gridAppropriate.Rows[0].Cells[19].Text == "1")
                {
                    dropdownlist.Enabled = true;
                    dropdownlist.Items.Insert(0, new ListItem("", "-1"));
                    dropdownlist.Items.Insert(0, gridConsent.Rows[0].Cells[3].Text);
                    return;
                }
                if ((gridAppropriate.Rows[0].Cells[36].Text == "-1") && (gridAppropriate.Rows[0].Cells[13].Text == "1") && (gridAppropriate.Rows[0].Cells[19].Text == "0"))
                {
                    dropdownlist.Items.Insert(0, gridConsent.Rows[0].Cells[3].Text);
                    return;
                }
                dropdownlist.Items.Clear();
            }
            catch
            {
                dropdownlist.Items.Clear();
            }
        }

        protected void GetCurrentConsentSkin(object sender, EventArgs e)
        {
            DropDownList dropdownlist = (DropDownList)sender;
            try 
            {
                if (gridAppropriate.Rows[0].Cells[4].Text != "Yes")
                {
                    dropdownlist.Enabled = false;
                    dropdownlist.Items.Clear();
                    return;
                }
                if (ddlApproachSkin.SelectedItem.Text != "Yes")
                {
                    dropdownlist.Enabled = false;
                    dropdownlist.Items.Clear();
                    return;
                }
                if (IsPostBack) return;
                if (gridAppropriate.Rows[0].Cells[37].Text == "-1" && gridAppropriate.Rows[0].Cells[14].Text == "1" && gridAppropriate.Rows[0].Cells[20].Text == "1")
                {
                    dropdownlist.Enabled = true;
                    dropdownlist.Items.Insert(0, new ListItem("", "-1"));
                    dropdownlist.Items.Insert(0, gridConsent.Rows[0].Cells[4].Text);
                    return;
                }
                if ((gridAppropriate.Rows[0].Cells[37].Text == "-1") && (gridAppropriate.Rows[0].Cells[14].Text == "1") && (gridAppropriate.Rows[0].Cells[20].Text == "0"))
                {
                    dropdownlist.Items.Insert(0, gridConsent.Rows[0].Cells[4].Text);
                    return;
                }
                dropdownlist.Items.Clear();
            }
            catch
            {
                dropdownlist.Items.Clear();
            }
        }

        protected void GetCurrentConsentValve(object sender, EventArgs e)
        {
            DropDownList dropdownlist = (DropDownList)sender;
            try
            {
                if (gridAppropriate.Rows[0].Cells[5].Text != "Yes")
                {
                    dropdownlist.Enabled = false;
                    dropdownlist.Items.Clear();
                    return;
                }
                if (ddlApproachValve.SelectedItem.Text != "Yes")
                {
                    dropdownlist.Enabled = false;
                    dropdownlist.Items.Clear();
                    return;
                }
                if (IsPostBack) return;
                if (gridAppropriate.Rows[0].Cells[38].Text == "-1" && gridAppropriate.Rows[0].Cells[15].Text == "1" && gridAppropriate.Rows[0].Cells[21].Text == "1")
                {
                    dropdownlist.Enabled = true;
                    dropdownlist.Items.Insert(0, new ListItem("", "-1"));
                    dropdownlist.Items.Insert(0, gridConsent.Rows[0].Cells[5].Text);
                    return;
                }
                if ((gridAppropriate.Rows[0].Cells[38].Text == "-1") && (gridAppropriate.Rows[0].Cells[15].Text == "1") && (gridAppropriate.Rows[0].Cells[21].Text == "0"))
                {
                    dropdownlist.Items.Insert(0, gridConsent.Rows[0].Cells[5].Text);
                    return;
                }
                dropdownlist.Items.Clear();
            }
            catch
            {
                dropdownlist.Items.Clear();
            }
        }

        protected void GetCurrentConsentEyes(object sender, EventArgs e)
        {
            DropDownList dropdownlist = (DropDownList)sender;
            try 
            {
                if (gridAppropriate.Rows[0].Cells[6].Text != "Yes")
                {
                    dropdownlist.Enabled = false;
                    dropdownlist.Items.Clear();
                    return;
                }
                if (ddlApproachEyes.SelectedItem.Text != "Yes")
                {
                    dropdownlist.Enabled = false;
                    dropdownlist.Items.Clear();
                    return;
                }
                if (IsPostBack) return;
                if (gridAppropriate.Rows[0].Cells[39].Text == "-1" && gridAppropriate.Rows[0].Cells[16].Text == "1" && gridAppropriate.Rows[0].Cells[22].Text == "1")
                {
                    dropdownlist.Enabled = true;
                    dropdownlist.Items.Insert(0, new ListItem("", "-1"));
                    dropdownlist.Items.Insert(0, gridConsent.Rows[0].Cells[6].Text);
                    return;
                }
                if (gridAppropriate.Rows[0].Cells[39].Text == "-1" && gridAppropriate.Rows[0].Cells[16].Text == "1" && gridAppropriate.Rows[0].Cells[22].Text == "0")
                {
                    dropdownlist.Items.Insert(0, gridConsent.Rows[0].Cells[6].Text);
                    return;
                }
                dropdownlist.Items.Clear();
            }
            catch
            {
                dropdownlist.Items.Clear();
            }
        }

        protected void GetCurrentConsentOther(object sender, EventArgs e)
        {
            DropDownList dropdownlist = (DropDownList)sender;
            try
            {
                if (gridAppropriate.Rows[0].Cells[26].Text != "Yes")
                {
                    dropdownlist.Enabled = false;
                    dropdownlist.Items.Clear();
                    return;
                }
                if (ddlApproachOther.SelectedItem.Text != "Yes")
                {
                    dropdownlist.Enabled = false;
                    dropdownlist.Items.Clear();
                    return;
                }
                if (IsPostBack) return;
                if (gridAppropriate.Rows[0].Cells[40].Text == "-1" && gridAppropriate.Rows[0].Cells[24].Text == "1" && gridAppropriate.Rows[0].Cells[25].Text == "1")
                {
                    dropdownlist.Enabled = true;
                    dropdownlist.Items.Insert(0, new ListItem("", "-1"));
                    dropdownlist.Items.Insert(0, gridConsent.Rows[0].Cells[7].Text);
                    return;
                }
                if (gridAppropriate.Rows[0].Cells[40].Text == "-1" && gridAppropriate.Rows[0].Cells[24].Text == "1" && gridAppropriate.Rows[0].Cells[25].Text == "0")
                {
                    dropdownlist.Items.Insert(0, gridConsent.Rows[0].Cells[7].Text);
                    return;
                }
                dropdownlist.Items.Clear();
            }
            catch
            {
                dropdownlist.Items.Clear();
            }
        }

        protected void GetCurrentRecoveryOrgan(object sender, EventArgs e)
        {
            DropDownList dropdownlist = (DropDownList)sender;
            try 
            {
                if (gridAppropriate.Rows[0].Cells[1].Text != "Yes")
                {
                    dropdownlist.Enabled = false;
                    dropdownlist.Items.Clear();
                    return;
                }
                if (ddlConsentOrgan.SelectedIndex == -1 || ddlConsentOrgan.SelectedItem.Text != "Yes")
                {
                    dropdownlist.Enabled = false;
                    dropdownlist.Items.Clear();
                    return;
                }
                if (IsPostBack) return;
                if (gridAppropriate.Rows[0].Cells[41].Text == "-1" && gridAppropriate.Rows[0].Cells[11].Text == "1" && gridAppropriate.Rows[0].Cells[17].Text == "1")
                {
                    dropdownlist.Enabled = true;
                    dropdownlist.Items.Insert(0, new ListItem("", "-1"));
                    dropdownlist.Items.Insert(0, gridRecovery.Rows[0].Cells[1].Text);
                    if (!String.IsNullOrEmpty(gridRecovery.Rows[0].Cells[1].Text)) txtRecoveryOutcome.Enabled = true;
                    return;
                }
                if (gridAppropriate.Rows[0].Cells[41].Text == "-1" && gridAppropriate.Rows[0].Cells[11].Text == "1" && gridAppropriate.Rows[0].Cells[17].Text == "0")
                {
                    dropdownlist.Items.Insert(0, gridRecovery.Rows[0].Cells[1].Text);
                    return;
                }
                dropdownlist.Items.Clear();
            }
            catch
            {
                dropdownlist.Items.Clear();
            }
        }

        protected void GetCurrentRecoveryBone(object sender, EventArgs e)
        {
            DropDownList dropdownlist = (DropDownList)sender;
            try 
            {
                if (gridAppropriate.Rows[0].Cells[2].Text != "Yes")
                {
                    dropdownlist.Enabled = false;
                    dropdownlist.Items.Clear();
                    return;
                }
                if (ddlConsentBone.SelectedIndex == -1 || ddlConsentBone.SelectedItem.Text != "Yes")
                {
                    dropdownlist.Enabled = false;
                    dropdownlist.Items.Clear();
                    //txtRecoveryOutcome.Enabled = false;
                    return;
                }
                if (IsPostBack) return;
                if (gridAppropriate.Rows[0].Cells[42].Text == "-1" && gridAppropriate.Rows[0].Cells[12].Text == "1" && gridAppropriate.Rows[0].Cells[18].Text == "1")
                {
                    dropdownlist.Enabled = true;
                    dropdownlist.Items.Insert(0, new ListItem("", "-1"));
                    dropdownlist.Items.Insert(0, gridRecovery.Rows[0].Cells[2].Text);
                    if (!String.IsNullOrEmpty(gridRecovery.Rows[0].Cells[2].Text)) txtRecoveryOutcome.Enabled = true;
                    return;
                }
                if (gridAppropriate.Rows[0].Cells[42].Text == "-1" && gridAppropriate.Rows[0].Cells[12].Text == "1" && gridAppropriate.Rows[0].Cells[18].Text == "0")
                {
                    dropdownlist.Items.Insert(0, gridRecovery.Rows[0].Cells[2].Text);
                    return;
                }
                dropdownlist.Items.Clear();
            }
            catch
            {
                dropdownlist.Items.Clear();
            }
        }

        protected void GetCurrentRecoveryTissue(object sender, EventArgs e)
        {
            DropDownList dropdownlist = (DropDownList)sender;
            try 
            {
                if (gridAppropriate.Rows[0].Cells[3].Text != "Yes")
                {
                    dropdownlist.Enabled = false;
                    dropdownlist.Items.Clear();
                    return;
                }
                if (ddlConsentTissue.SelectedIndex == -1 || ddlConsentTissue.SelectedItem.Text != "Yes")
                {
                    dropdownlist.Enabled = false;
                    dropdownlist.Items.Clear();
                    //txtRecoveryOutcome.Enabled = false;
                    return;
                }
                if (IsPostBack) return;
                if (gridAppropriate.Rows[0].Cells[43].Text == "-1" && gridAppropriate.Rows[0].Cells[13].Text == "1" && gridAppropriate.Rows[0].Cells[19].Text == "1")
                {
                    dropdownlist.Enabled = true;
                    dropdownlist.Items.Insert(0, new ListItem("", "-1"));
                    dropdownlist.Items.Insert(0, gridRecovery.Rows[0].Cells[3].Text);
                    if (!String.IsNullOrEmpty(gridRecovery.Rows[0].Cells[3].Text)) txtRecoveryOutcome.Enabled = true;
                    return;
                }
                if (gridAppropriate.Rows[0].Cells[43].Text == "-1" && gridAppropriate.Rows[0].Cells[13].Text == "1" && gridAppropriate.Rows[0].Cells[19].Text == "0")
                {
                    dropdownlist.Items.Insert(0, gridRecovery.Rows[0].Cells[3].Text);
                    return;
                }
                dropdownlist.Items.Clear();
            }
            catch
            {
                dropdownlist.Items.Clear();
            }
        }

        protected void GetCurrentRecoverySkin(object sender, EventArgs e)
        {
            DropDownList dropdownlist = (DropDownList)sender;
            try 
            {
                if (gridAppropriate.Rows[0].Cells[4].Text != "Yes")
                {
                    dropdownlist.Enabled = false;
                    dropdownlist.Items.Clear();
                    return;
                }
                if (ddlConsentSkin.SelectedIndex == -1 || ddlConsentSkin.SelectedItem.Text != "Yes")
                {
                    dropdownlist.Enabled = false;
                    dropdownlist.Items.Clear();
                    //txtRecoveryOutcome.Enabled = false;
                    return;
                }
                if (IsPostBack) return;
                if (gridAppropriate.Rows[0].Cells[44].Text == "-1" && gridAppropriate.Rows[0].Cells[14].Text == "1" && gridAppropriate.Rows[0].Cells[20].Text == "1")
                {
                    dropdownlist.Enabled = true;
                    dropdownlist.Items.Insert(0, new ListItem("", "-1"));
                    dropdownlist.Items.Insert(0, gridRecovery.Rows[0].Cells[4].Text);
                    if (!String.IsNullOrEmpty(gridRecovery.Rows[0].Cells[4].Text)) txtRecoveryOutcome.Enabled = true;
                    return;
                }
                if (gridAppropriate.Rows[0].Cells[44].Text == "-1" && gridAppropriate.Rows[0].Cells[14].Text == "1" && gridAppropriate.Rows[0].Cells[20].Text == "0")
                {
                    dropdownlist.Items.Insert(0, gridRecovery.Rows[0].Cells[4].Text);
                    return;
                }
                dropdownlist.Items.Clear();
            }
            catch
            {
                dropdownlist.Items.Clear();
            }
        }

        protected void GetCurrentRecoveryValve(object sender, EventArgs e)
        {
            DropDownList dropdownlist = (DropDownList)sender;
            try 
            {
                if (gridAppropriate.Rows[0].Cells[5].Text != "Yes")
                {
                    dropdownlist.Enabled = false;
                    dropdownlist.Items.Clear();
                    return;
                }
                if (ddlConsentValve.SelectedIndex == -1 || ddlConsentValve.SelectedItem.Text != "Yes")
                {
                    dropdownlist.Enabled = false;
                    dropdownlist.Items.Clear();
                    //txtRecoveryOutcome.Enabled = false;
                    return;
                }
                if (IsPostBack) return;
                if (gridAppropriate.Rows[0].Cells[45].Text == "-1" && gridAppropriate.Rows[0].Cells[15].Text == "1" && gridAppropriate.Rows[0].Cells[21].Text == "1")
                {
                    dropdownlist.Enabled = true;
                    dropdownlist.Items.Insert(0, new ListItem("", "-1"));
                    dropdownlist.Items.Insert(0, gridRecovery.Rows[0].Cells[5].Text);
                    if (!String.IsNullOrEmpty(gridRecovery.Rows[0].Cells[5].Text)) txtRecoveryOutcome.Enabled = true;
                    return;
                }
                if (gridAppropriate.Rows[0].Cells[45].Text == "-1" && gridAppropriate.Rows[0].Cells[15].Text == "1" && gridAppropriate.Rows[0].Cells[21].Text == "0")
                {
                    dropdownlist.Items.Insert(0, gridRecovery.Rows[0].Cells[5].Text);
                    return;
                }
                dropdownlist.Items.Clear();
            }
            catch
            {
                dropdownlist.Items.Clear();
            }
        }

        protected void GetCurrentRecoveryEyes(object sender, EventArgs e)
        {
            DropDownList dropdownlist = (DropDownList)sender;
            try 
            {
                if (gridAppropriate.Rows[0].Cells[6].Text != "Yes")
                {
                    dropdownlist.Enabled = false;
                    dropdownlist.Items.Clear();
                    return;
                }
                if (ddlConsentEyes.SelectedIndex == -1 || ddlConsentEyes.SelectedItem.Text != "Yes")
                {
                    dropdownlist.Enabled = false;
                    dropdownlist.Items.Clear();
                    //txtRecoveryOutcome.Enabled = false;
                    return;
                }
                if (IsPostBack) return;
                if (gridAppropriate.Rows[0].Cells[46].Text == "-1" && gridAppropriate.Rows[0].Cells[16].Text == "1" && gridAppropriate.Rows[0].Cells[22].Text == "1")
                {
                    dropdownlist.Enabled = true;
                    dropdownlist.Items.Insert(0, new ListItem("", "-1"));
                    dropdownlist.Items.Insert(0, gridRecovery.Rows[0].Cells[6].Text);
                    if (!String.IsNullOrEmpty(gridRecovery.Rows[0].Cells[6].Text)) txtRecoveryOutcome.Enabled = true;
                    return;
                }
                if (gridAppropriate.Rows[0].Cells[46].Text == "-1" && gridAppropriate.Rows[0].Cells[16].Text == "1" && gridAppropriate.Rows[0].Cells[22].Text == "0")
                {
                    dropdownlist.Items.Insert(0, gridRecovery.Rows[0].Cells[6].Text);
                    return;
                }
                dropdownlist.Items.Clear();
            }
            catch
            {
                dropdownlist.Items.Clear();
            }
        }

        protected void GetCurrentRecoveryOther(object sender, EventArgs e)
        {
            DropDownList dropdownlist = (DropDownList)sender;
            try
             {
                 if (gridAppropriate.Rows[0].Cells[26].Text != "Yes")
                 {
                     dropdownlist.Enabled = false;
                     dropdownlist.Items.Clear();
                     return;
                 }
                 if (ddlConsentOther.SelectedIndex == -1 || ddlConsentOther.SelectedItem.Text != "Yes")
                 {
                     dropdownlist.Enabled = false;
                     dropdownlist.Items.Clear();
                     //txtRecoveryOutcome.Enabled = false;
                     return;
                 }
                 if (IsPostBack) return;
                 if (gridAppropriate.Rows[0].Cells[47].Text == "-1" && gridAppropriate.Rows[0].Cells[24].Text == "1" && gridAppropriate.Rows[0].Cells[25].Text == "1")
                 {
                     dropdownlist.Enabled = true;
                     dropdownlist.Items.Insert(0, new ListItem("", "-1"));
                     dropdownlist.Items.Insert(0, gridRecovery.Rows[0].Cells[7].Text);
                     if (!String.IsNullOrEmpty(gridRecovery.Rows[0].Cells[7].Text)) txtRecoveryOutcome.Enabled = true;
                     return;
                 }
                 if (gridAppropriate.Rows[0].Cells[47].Text == "-1" && gridAppropriate.Rows[0].Cells[24].Text == "1" && gridAppropriate.Rows[0].Cells[25].Text == "0")
                 {
                     dropdownlist.Items.Insert(0, gridRecovery.Rows[0].Cells[7].Text);
                     return;
                 }
                 dropdownlist.Items.Clear();
            }
            catch
            {
                dropdownlist.Items.Clear();
            }
        }
        
        #endregion

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (IsValid())
            {
                try
                {
                    LoadData();
                    //Contact Required?
                    //Check first if call is asp...don't do contact required if asp
                    ReferralData dsCallData = new ReferralData();
                    Statline.StatTrac.Data.Referral.ReferralDB.FillCall(dsCallData, Page.Cookies.CallID);

                    //Get the original data to check if the DOB and weight fields have value other than null
                    ReferralData originalReferral = new ReferralData();
                    Statline.StatTrac.Data.Referral.ReferralDB.FillCall(originalReferral, Page.Cookies.CallID);
                    Statline.StatTrac.Data.Referral.ReferralDB.FillReferral(originalReferral, Page.Cookies.CallID);

                    bool isAllowOnlineReviewPendingEvents = Boolean.Parse(ApplicationSettings.GetSetting( SettingName.AllowOnlineReviewPendingEvents));

                    // If Allow.OnlineReviewPendingEvents (application setting) is set to True we do not want to check isContactRequired
                    // and do want OnlineReviewPendingEvent. If, however, Allow.OnlineReviewPendingEvents is False we will not add 
                    // OnlineReviewPendingEvent and need to check isContactRequired.
                    if (!isAllowOnlineReviewPendingEvents)
                    {
                        if (dsCallData.Call[0].ASP == 0)
                        {
                            if (ReferralManager.isContactRequired(dsReferralData, Page.Cookies.CallID, Page.Cookies.OrganizationID))
                            {
                                DisplayMessages.Add(MessageType.ErrorMessage, "To make this update you must contact Statline.");
                                return;
                            }
                        }
                    }
                    if (dsReferralData.Referral.Rows.Count != 0)
                    {
                         // Get SourceCodeName from loaded callId
                        string sourceCodeName = ReferralManager.GetSourceCodeName(Convert.ToInt32(Page.Cookies.CallID), "");

                            if (isAllowOnlineReviewPendingEvents)
                            { 
                                if (IsDispositionChanged())
                                {
                                    // CreateLogEventOnlineReviewPending
                                    CreateLogEventOnlineReviewPending(sourceCodeName);
                                }
                            }

                            dsReferralData.Referral[0].LastStatEmployeeID = Page.Cookies.StatEmployeeID;
                            dsReferralData.Referral[0].AuditLogTypeID = 3;
                        //If the value is not null, resend that value for update in order not to lose the data.
                        //Otherwise a null value is sent which clears the existing data.
                        if (originalReferral.Referral[0]["ReferralDonorWeight"] != DBNull.Value)
                            dsReferralData.Referral[0]["ReferralDonorWeight"] = originalReferral.Referral[0]["ReferralDonorWeight"];
                        if (originalReferral.Referral[0]["ReferralDOB"] != DBNull.Value)
                            dsReferralData.Referral[0]["ReferralDOB"] = originalReferral.Referral[0]["ReferralDOB"];
                        ReferralManager.UpdateReferral(dsReferralData, Convert.ToInt32(Page.Cookies.CallID));

                        string outcomeConsentOutcomeDesc;
                        if (string.IsNullOrEmpty(txtConsentOutcome.Text))
                        {
                            outcomeConsentOutcomeDesc = "ILB";
                        }
                        else
                        {
                            outcomeConsentOutcomeDesc = txtConsentOutcome.Text.ToString();
                        }
                        CreateLogEventOutcome(31, outcomeConsentOutcomeDesc);
                        
                        if (txtRecoveryOutcome.Enabled)
                        {
                            string outcomeRecOutcomeDesc;
                            if (string.IsNullOrEmpty(txtRecoveryOutcome.Text))
                            {
                                outcomeRecOutcomeDesc = "ILB";
                            }
                            else
                            {
                                outcomeRecOutcomeDesc = txtRecoveryOutcome.Text.ToString();
                            }
                            CreateLogEventOutcome(32, outcomeRecOutcomeDesc);
                        }

                        if (txtApproacherChangeNote.Enabled && !string.IsNullOrEmpty(txtApproacherChangeNote.Text))
                        {
                            CreateLogEventOutcome(1, txtApproacherChangeNote.Text.ToString());
                            CreateLogEventOutcome(1, "Changed approach person from " + gridAppropriate.Rows[0].Cells[9].Text + " to " + ddlApproacher.SelectedItem.Text);
                        }
                        //unlock call
                        ReferralManager.LockCall(Convert.ToInt32(Page.Cookies.CallID), -1, -1, Page.Cookies.StatEmployeeID, 3, 0);
                        QueryStringManager.Redirect(PageName.ReferralSearch);
                    }
                }
                catch (Exception ex)
                {
                    DisplayMessages.Add(MessageType.ErrorMessage, "A database error has prevented the updates from being saved. Please logout and try again. ");
                }
            }
        }

        protected bool IsDispositionChanged()
        {
            bool dispositionChanged = false;
            // Check for valid row
            if (dsReferralData == null)
                return dispositionChanged;
            if (dsReferralData.Referral.Rows.Count == 0)
                return dispositionChanged;

            
            //Set Default value
            dispositionChanged = true;

            // Check for changes in disposition
            if(
                // Organ
                DispositionValueChanged(dsReferralData.Referral.ReferralOrganApproachIDColumn.ColumnName.ToString())||
                DispositionValueChanged(dsReferralData.Referral.ReferralOrganConsentIDColumn.ColumnName.ToString())||
                DispositionValueChanged(dsReferralData.Referral.ReferralOrganConversionIDColumn.ColumnName.ToString())||

                // Bone 
                DispositionValueChanged(dsReferralData.Referral.ReferralBoneApproachIDColumn.ColumnName.ToString())||
                DispositionValueChanged(dsReferralData.Referral.ReferralBoneConsentIDColumn.ColumnName.ToString())||
                DispositionValueChanged(dsReferralData.Referral.ReferralBoneConversionIDColumn.ColumnName.ToString())||

                // Tissue(Veins)
                DispositionValueChanged(dsReferralData.Referral.ReferralTissueApproachIDColumn.ColumnName.ToString()) ||
                DispositionValueChanged(dsReferralData.Referral.ReferralTissueConsentIDColumn.ColumnName.ToString()) ||
                DispositionValueChanged(dsReferralData.Referral.ReferralTissueConversionIDColumn.ColumnName.ToString()) ||

                // Skin
                DispositionValueChanged(dsReferralData.Referral.ReferralSkinApproachIDColumn.ColumnName.ToString()) ||
                DispositionValueChanged(dsReferralData.Referral.ReferralSkinConsentIDColumn.ColumnName.ToString()) ||
                DispositionValueChanged(dsReferralData.Referral.ReferralSkinConversionIDColumn.ColumnName.ToString()) ||
                
                // Valves 
                DispositionValueChanged(dsReferralData.Referral.ReferralValvesApproachIDColumn.ColumnName.ToString()) ||
                DispositionValueChanged(dsReferralData.Referral.ReferralValvesConsentIDColumn.ColumnName.ToString()) ||
                DispositionValueChanged(dsReferralData.Referral.ReferralValvesConversionIDColumn.ColumnName.ToString()) ||
                
                // Eyes 
                DispositionValueChanged(dsReferralData.Referral.ReferralEyesTransApproachIDColumn.ColumnName.ToString()) ||
                DispositionValueChanged(dsReferralData.Referral.ReferralEyesTransConsentIDColumn.ColumnName.ToString()) ||
                DispositionValueChanged(dsReferralData.Referral.ReferralEyesTransConversionIDColumn.ColumnName.ToString()) ||
                
                // Other 
                DispositionValueChanged(dsReferralData.Referral.ReferralEyesRschApproachIDColumn.ColumnName.ToString()) ||
                DispositionValueChanged(dsReferralData.Referral.ReferralEyesRschConsentIDColumn.ColumnName.ToString()) ||
                DispositionValueChanged(dsReferralData.Referral.ReferralEyesRschConversionIDColumn.ColumnName.ToString())
              )
                return dispositionChanged;

            // If disposition has not changed return false
            dispositionChanged = false;
            return dispositionChanged;
        }

        protected bool DispositionValueChanged(string dispositionName)
        {
            bool returnValue = false;
            const int firstRow = 0;
            
            if (dsReferralData.Referral[firstRow][dispositionName, DataRowVersion.Original] != null &&
                dsReferralData.Referral[firstRow][dispositionName] != null)
            {
                int original;
                int pending;
                original = Convert.ToInt32(dsReferralData.Referral[firstRow][dispositionName, DataRowVersion.Original]);
                pending = Convert.ToInt32(dsReferralData.Referral[firstRow][dispositionName]);

                if (original != pending)
                    returnValue = true;
            }

            return returnValue;
        }

        #region Get DropDown Data
      
        protected void GetCurrentApproachOrganChanged(object sender, EventArgs e)
        {
            DropDownList dropdownlist = (DropDownList)sender;
            ddlConsentOrgan.Items.Clear();
            ddlRecoveryOrgan.Items.Clear();
            ddlRecoveryOrgan.DataBind();
            if (dropdownlist.SelectedItem.Value == "1" || dropdownlist.SelectedItem.Value == "Yes")
            {
                ddlConsentOrgan.Items.Insert(0, new ListItem("", "-1"));
                ddlConsentOrgan.Enabled = true;
            }
            else
            {
                ddlConsentOrgan.Enabled = false;
                ddlRecoveryOrgan.Enabled = false;
            } 
            ddlConsentOrgan.DataBind();
        }

        protected void GetCurrentApproachBoneChanged(object sender, EventArgs e)
        {
            DropDownList dropdownlist = (DropDownList)sender;
            ddlConsentBone.Items.Clear();
            ddlRecoveryBone.Items.Clear();
            ddlRecoveryBone.DataBind();
            if (dropdownlist.SelectedItem.Value == "1" || dropdownlist.SelectedItem.Value == "Yes")
            {
                ddlConsentBone.Items.Insert(0, new ListItem("", "-1"));
                ddlConsentBone.Enabled = true;
            }
            else
            {
                ddlConsentBone.Enabled = false;
                ddlRecoveryBone.Enabled = false;
            }
            ddlConsentBone.DataBind();
        }

        protected void GetCurrentApproachTissueChanged(object sender, EventArgs e)
        {
            DropDownList dropdownlist = (DropDownList)sender;
            ddlConsentTissue.Items.Clear();
            ddlRecoveryTissue.Items.Clear();
            ddlRecoveryTissue.DataBind();
            if (dropdownlist.SelectedItem.Value == "1" || dropdownlist.SelectedItem.Value == "Yes")
            {
                ddlConsentTissue.Items.Insert(0, new ListItem("", "-1"));
                ddlConsentTissue.Enabled = true;
            }
            else
            {
                ddlConsentTissue.Enabled = false;
                ddlRecoveryTissue.Enabled = false;
            }
            ddlConsentTissue.DataBind();
        }

        protected void GetCurrentApproachSkinChanged(object sender, EventArgs e)
        {
            DropDownList dropdownlist = (DropDownList)sender;
            ddlConsentSkin.Items.Clear();
            ddlRecoverySkin.Items.Clear();
            ddlRecoverySkin.DataBind();
            if (dropdownlist.SelectedItem.Value == "1" || dropdownlist.SelectedItem.Value == "Yes")
            {
                ddlConsentSkin.Items.Insert(0, new ListItem("", "-1"));
                ddlConsentSkin.Enabled = true;
            }
            else
            {

                ddlConsentSkin.Enabled = false;
                ddlRecoverySkin.Enabled = false;
            }
            ddlConsentSkin.DataBind();
        }
        protected void GetCurrentApproachValveChanged(object sender, EventArgs e)
        {
            DropDownList dropdownlist = (DropDownList)sender;
            ddlConsentValve.Items.Clear();
            ddlRecoveryValve.Items.Clear();
            ddlRecoveryValve.DataBind();
            if (dropdownlist.SelectedItem.Value == "1" || dropdownlist.SelectedItem.Value == "Yes")
            {
                ddlConsentValve.Items.Insert(0, new ListItem("", "-1"));
                ddlConsentValve.Enabled = true;
            }
            else
            {
                ddlConsentValve.Enabled = false;
                ddlRecoveryValve.Enabled = false;
            }
            ddlConsentValve.DataBind();
        }

        protected void GetCurrentApproachEyesChanged(object sender, EventArgs e)
        {
            DropDownList dropdownlist = (DropDownList)sender;
            ddlConsentEyes.Items.Clear();
            ddlRecoveryEyes.Items.Clear();
            ddlRecoveryEyes.DataBind();
            if (dropdownlist.SelectedItem.Value == "1" || dropdownlist.SelectedItem.Value == "Yes")
            {
                ddlConsentEyes.Items.Insert(0, new ListItem("", "-1"));
                ddlConsentEyes.Enabled = true;
            }
            else
            {
                ddlConsentEyes.Enabled = false;
                ddlRecoveryEyes.Enabled = false;
            }
            ddlConsentEyes.DataBind();
        }

        protected void GetCurrentApproachOtherChanged(object sender, EventArgs e)
        {
            DropDownList dropdownlist = (DropDownList)sender;
            ddlConsentOther.Items.Clear();
            ddlRecoveryOther.Items.Clear();
            ddlRecoveryOther.DataBind();
            if (dropdownlist.SelectedItem.Value == "1" || dropdownlist.SelectedItem.Value == "Yes")
            {
                ddlConsentOther.Items.Insert(0, new ListItem("", "-1"));
                ddlConsentOther.Enabled = true;
            }
            else
            {
                ddlConsentOther.Enabled = false;
                ddlRecoveryOther.Enabled = false;
            }
            ddlConsentOther.DataBind();
        }

        protected void GetCurrentConsentOrganChanged(object sender, EventArgs e)
        {
            DropDownList dropdownlist = (DropDownList)sender;
            ddlRecoveryOrgan.Items.Clear();
            ddlRecoveryOrgan.DataBind();
            if (dropdownlist.SelectedItem.Value == "1" || dropdownlist.SelectedItem.Value == "Yes")
            {
                ddlRecoveryOrgan.Items.Insert(0, new ListItem("", "-1"));
                ddlRecoveryOrgan.Enabled = true;
            }
            else
            {
                ddlRecoveryOrgan.Enabled = false;
            }
        }
        protected void GetCurrentConsentBoneChanged(object sender, EventArgs e)
        {
            DropDownList dropdownlist = (DropDownList)sender;
            ddlRecoveryBone.Items.Clear();
            ddlRecoveryBone.DataBind();
            if (dropdownlist.SelectedItem.Value == "1" || dropdownlist.SelectedItem.Value == "Yes")
            {
                ddlRecoveryBone.Items.Insert(0, new ListItem("", "-1"));
                ddlRecoveryBone.Enabled = true;
            }
            else
            {
                ddlRecoveryBone.Enabled = false;
            }
        }

        protected void GetCurrentConsentTissueChanged(object sender, EventArgs e)
        {
            DropDownList dropdownlist = (DropDownList)sender;
            ddlRecoveryTissue.Items.Clear();
            ddlRecoveryTissue.DataBind();
            if (dropdownlist.SelectedItem.Value == "1" || dropdownlist.SelectedItem.Value == "Yes")
            {
                ddlRecoveryTissue.Items.Insert(0, new ListItem("", "-1"));
                ddlRecoveryTissue.Enabled = true;
            }
            else
            {
                ddlRecoveryTissue.Enabled = false;
            }
        }

        protected void GetCurrentConsentSkinChanged(object sender, EventArgs e)
        {
            DropDownList dropdownlist = (DropDownList)sender;
            ddlRecoverySkin.Items.Clear();
            ddlRecoverySkin.DataBind();
            if (dropdownlist.SelectedItem.Value == "1" || dropdownlist.SelectedItem.Value == "Yes")
            {
                ddlRecoverySkin.Items.Insert(0, new ListItem("", "-1"));
                ddlRecoverySkin.Enabled = true;
            }
            else
            {
                ddlRecoverySkin.Enabled = false;
            }
        }
        protected void GetCurrentConsentValveChanged(object sender, EventArgs e)
        {
            DropDownList dropdownlist = (DropDownList)sender;
            ddlRecoveryValve.Items.Clear();
            ddlRecoveryValve.DataBind();
            if (dropdownlist.SelectedItem.Value == "1" || dropdownlist.SelectedItem.Value == "Yes")
            {
                ddlRecoveryValve.Items.Insert(0, new ListItem("", "-1"));
                ddlRecoveryValve.Enabled = true;
            }
            else
            {
                ddlRecoveryValve.Enabled = false;
            }
        }

        protected void GetCurrentConsentEyesChanged(object sender, EventArgs e)
        {
            DropDownList dropdownlist = (DropDownList)sender;
            ddlRecoveryEyes.Items.Clear();
            ddlRecoveryEyes.DataBind();
            if (dropdownlist.SelectedItem.Value == "1" || dropdownlist.SelectedItem.Value == "Yes")
            {
                ddlRecoveryEyes.Items.Insert(0, new ListItem("", "-1"));
                ddlRecoveryEyes.Enabled = true;
            }
            else
            {
                ddlRecoveryEyes.Enabled = false;
            }
        }

        protected void GetCurrentConsentOtherChanged(object sender, EventArgs e)
        {
            DropDownList dropdownlist = (DropDownList)sender;
            ddlRecoveryOther.Items.Clear();
            ddlRecoveryOther.DataBind();
            if (dropdownlist.SelectedItem.Value == "1" || dropdownlist.SelectedItem.Value == "Yes")
            {
                ddlRecoveryOther.Items.Insert(0, new ListItem("", "-1"));
                ddlRecoveryOther.Enabled = true;
            }
            else
            {
                ddlRecoveryOther.Enabled = false;
            }
        }

        protected void GetCurrentRecoveryOrganChanged(object sender, EventArgs e)
        {
            txtRecoveryOutcome.Enabled = true;
        }
        protected void GetCurrentRecoveryBoneChanged(object sender, EventArgs e)
        {
            txtRecoveryOutcome.Enabled = true;
        }

        protected void GetCurrentRecoveryTissueChanged(object sender, EventArgs e)
        {
            txtRecoveryOutcome.Enabled = true;
        }

        protected void GetCurrentRecoverySkinChanged(object sender, EventArgs e)
        {
            txtRecoveryOutcome.Enabled = true;
        }
        protected void GetCurrentRecoveryValveChanged(object sender, EventArgs e)
        {
            txtRecoveryOutcome.Enabled = true;
        }

        protected void GetCurrentRecoveryEyesChanged(object sender, EventArgs e)
        {
            txtRecoveryOutcome.Enabled = true;
        }

        protected void GetCurrentRecoveryOtherChanged(object sender, EventArgs e)
        {
            txtRecoveryOutcome.Enabled = true;
        }

        protected void GetApproachTypeChanged(object sender, EventArgs e)
        {
            if (ddlMOA.SelectedItem.Value == "1" )
            {
                ddlApproacher.Enabled = false;
                ddlApproacher.Items.Clear();
                ddlConsent.Enabled = false;
                ddlConsent.Items.Clear();
            }
            else
            {
                ddlApproacher.Enabled = true;
                ddlApproacher.DataBind();
                ddlApproacher.Items.Insert(0, new ListItem("", "-1"));
                ddlConsent.Enabled = true;
                ddlConsent.Items.Clear();
                ddlConsent.Items.Insert(0, new ListItem("No", "3"));
                ddlConsent.Items.Insert(0, new ListItem("Yes-Verbal", "2"));
                ddlConsent.Items.Insert(0, new ListItem("Yes-Written", "1"));
                ddlConsent.Items.Insert(0, new ListItem("", "-1"));
            }
        }

        protected void GetApproacherChanged(object sender, EventArgs e)
        {
            txtApproacherChangeNote.Enabled = true;
        }
    
        #endregion

        override protected void OnInit(EventArgs e)
        {
            //
            // CODEGEN: This call is required by the ASP.NET Web Form Designer.
            //
            InitializeComponent();
            base.OnInit(e);
        }

        private void InitializeComponent()
        {
            if (IsPostBack) return;
           
            this.dsReferralData = new Statline.StatTrac.Data.Types.ReferralData();
            ((System.ComponentModel.ISupportInitialize)(this.dsReferralData)).BeginInit();
            this.dsReferralData.DataSetName = "ReferralData";
            //this.dsUserData.Locale = new System.Globalization.CultureInfo("en-US");
            ((System.ComponentModel.ISupportInitialize)(this.dsReferralData)).EndInit();

        }

        private void LoadData()
        {
            try
            {
                ReferralManager.FillReferralReport(dsReferralData, Convert.ToInt32(Page.Cookies.CallID));
            }
            catch
            {
                DisplayMessages.Add(MessageType.ErrorMessage, "A database error has prevented the data from being loaded.");
            }
            if (ddlMOA.SelectedIndex != 0)
            {
                dsReferralData.Referral[0].ReferralApproachTypeID = Convert.ToInt32(ddlMOA.SelectedItem.Value);
                if (ddlMOA.SelectedItem.Value == "1")
                {
                    dsReferralData.Referral[0].ReferralApproachedByPersonID = -1;
                    dsReferralData.Referral[0].ReferralGeneralConsent = -1;
                }
            }
            if (ddlApproacher.SelectedIndex != 0)
            {
                if (ddlMOA.SelectedItem.Value == "1")
                {
                    dsReferralData.Referral[0].ReferralApproachedByPersonID = -1;
                    dsReferralData.Referral[0].ReferralGeneralConsent = -1;
                }
                else
                {
                    dsReferralData.Referral[0].ReferralApproachedByPersonID = Convert.ToInt32(ddlApproacher.SelectedItem.Value);
                }
            }
            if (ddlConsent.SelectedIndex != 0)
            {
                if (ddlMOA.SelectedItem.Value == "1")
                {
                    dsReferralData.Referral[0].ReferralGeneralConsent = -1;
                }
                else
                {
                    dsReferralData.Referral[0].ReferralGeneralConsent = Convert.ToInt16(ddlConsent.SelectedItem.Value);
                }
            }
            
            //Load Organ Data in DS
            if (ddlApproachOrgan.SelectedIndex > 0)
            {
                dsReferralData.Referral[0].ReferralOrganApproachID = Convert.ToInt32(ddlApproachOrgan.SelectedItem.Value);
                if (ddlApproachOrgan.SelectedItem.Value != "1")
                {
                    dsReferralData.Referral[0].ReferralOrganConsentID = -1;
                    dsReferralData.Referral[0].ReferralOrganConversionID = -1;
                }
            }
            if (ddlConsentOrgan.SelectedIndex > 0)
            {
                dsReferralData.Referral[0].ReferralOrganConsentID = Convert.ToInt32(ddlConsentOrgan.SelectedItem.Value);
                if (ddlConsentOrgan.SelectedItem.Value != "1") dsReferralData.Referral[0].ReferralOrganConversionID = -1;
            }
            if (ddlRecoveryOrgan.SelectedIndex > 0) dsReferralData.Referral[0].ReferralOrganConversionID = Convert.ToInt32(ddlRecoveryOrgan.SelectedItem.Value);
            //Load Bone Data in DS
            if (ddlApproachBone.SelectedIndex > 0)
            {
                dsReferralData.Referral[0].ReferralBoneApproachID = Convert.ToInt32(ddlApproachBone.SelectedItem.Value);
                if (ddlApproachBone.SelectedItem.Value != "1")
                {
                    dsReferralData.Referral[0].ReferralBoneConsentID = -1;
                    dsReferralData.Referral[0].ReferralBoneConversionID = -1;
                }
            }
            if (ddlConsentBone.SelectedIndex > 0)
            {
                dsReferralData.Referral[0].ReferralBoneConsentID = Convert.ToInt32(ddlConsentBone.SelectedItem.Value);
                if (ddlConsentBone.SelectedItem.Value != "1") dsReferralData.Referral[0].ReferralBoneConversionID = -1;
            }
            if (ddlRecoveryBone.SelectedIndex > 0) dsReferralData.Referral[0].ReferralBoneConversionID = Convert.ToInt32(ddlRecoveryBone.SelectedItem.Value);
            //Load Tissue Data in DS
            if (ddlApproachTissue.SelectedIndex > 0)
            {
                dsReferralData.Referral[0].ReferralTissueApproachID = Convert.ToInt32(ddlApproachTissue.SelectedItem.Value);
                if (ddlApproachTissue.SelectedItem.Value != "1")
                {
                    dsReferralData.Referral[0].ReferralTissueConsentID = -1;
                    dsReferralData.Referral[0].ReferralTissueConversionID = -1;
                }
            }
            if (ddlConsentTissue.SelectedIndex > 0)
            {
                dsReferralData.Referral[0].ReferralTissueConsentID = Convert.ToInt32(ddlConsentTissue.SelectedItem.Value);
                if (ddlConsentTissue.SelectedItem.Value != "1") dsReferralData.Referral[0].ReferralTissueConversionID = -1;
            }
            if (ddlRecoveryTissue.SelectedIndex > 0) dsReferralData.Referral[0].ReferralTissueConversionID = Convert.ToInt32(ddlRecoveryTissue.SelectedItem.Value);
            //Load Skin Data in DS
            if (ddlApproachSkin.SelectedIndex > 0)
            {
                dsReferralData.Referral[0].ReferralSkinApproachID = Convert.ToInt32(ddlApproachSkin.SelectedItem.Value);
                if (ddlApproachSkin.SelectedItem.Value != "1")
                {
                    dsReferralData.Referral[0].ReferralSkinConsentID = -1;
                    dsReferralData.Referral[0].ReferralSkinConversionID = -1;
                }
            }
            if (ddlConsentSkin.SelectedIndex > 0)
            {
                dsReferralData.Referral[0].ReferralSkinConsentID = Convert.ToInt32(ddlConsentSkin.SelectedItem.Value);
                if (ddlConsentSkin.SelectedItem.Value != "1") dsReferralData.Referral[0].ReferralSkinConversionID = -1;
            }
            if (ddlRecoverySkin.SelectedIndex > 0) dsReferralData.Referral[0].ReferralSkinConversionID = Convert.ToInt32(ddlRecoverySkin.SelectedItem.Value);
            //Load Valves Data in DS
            if (ddlApproachValve.SelectedIndex > 0)
            {
                dsReferralData.Referral[0].ReferralValvesApproachID = Convert.ToInt32(ddlApproachValve.SelectedItem.Value);
                if (ddlApproachValve.SelectedItem.Value != "1")
                {
                    dsReferralData.Referral[0].ReferralValvesConsentID = -1;
                    dsReferralData.Referral[0].ReferralValvesConversionID = -1;
                }
            }
            if (ddlConsentValve.SelectedIndex > 0)
            {
                dsReferralData.Referral[0].ReferralValvesConsentID = Convert.ToInt32(ddlConsentValve.SelectedItem.Value);
                if (ddlConsentValve.SelectedItem.Value != "1") dsReferralData.Referral[0].ReferralValvesConversionID = -1;
            }
            if (ddlRecoveryValve.SelectedIndex > 0) dsReferralData.Referral[0].ReferralValvesConversionID = Convert.ToInt32(ddlRecoveryValve.SelectedItem.Value);
            //Load Eyes Data in DS
            if (ddlApproachEyes.SelectedIndex > 0)
            {
                dsReferralData.Referral[0].ReferralEyesTransApproachID = Convert.ToInt32(ddlApproachEyes.SelectedItem.Value);
                if (ddlApproachEyes.SelectedItem.Value != "1")
                {
                    dsReferralData.Referral[0].ReferralEyesTransConsentID = -1;
                    dsReferralData.Referral[0].ReferralEyesTransConversionID = -1;
                }
            }
            if (ddlConsentEyes.SelectedIndex > 0)
            {
                dsReferralData.Referral[0].ReferralEyesTransConsentID = Convert.ToInt32(ddlConsentEyes.SelectedItem.Value);
                if (ddlConsentEyes.SelectedItem.Value != "1") dsReferralData.Referral[0].ReferralEyesTransConversionID = -1;
            }
            if (ddlRecoveryEyes.SelectedIndex > 0) dsReferralData.Referral[0].ReferralEyesTransConversionID = Convert.ToInt32(ddlRecoveryEyes.SelectedItem.Value);
            //Load Other Data in DS
            if (ddlApproachOther.SelectedIndex > 0)
            {
                dsReferralData.Referral[0].ReferralEyesRschApproachID = Convert.ToInt32(ddlApproachOther.SelectedItem.Value);
                if (ddlApproachOther.SelectedItem.Value != "1")
                {
                    dsReferralData.Referral[0].ReferralEyesRschConsentID = -1;
                    dsReferralData.Referral[0].ReferralEyesRschConversionID = -1;
                }
            }
            if (ddlConsentOther.SelectedIndex > 0)
            {
                dsReferralData.Referral[0].ReferralEyesRschConsentID = Convert.ToInt32(ddlConsentOther.SelectedItem.Value);
                if (ddlConsentOther.SelectedItem.Value != "1") dsReferralData.Referral[0].ReferralEyesRschConversionID = -1;
            }
            if (ddlRecoveryOther.SelectedIndex > 0) dsReferralData.Referral[0].ReferralEyesRschConversionID = Convert.ToInt32(ddlRecoveryOther.SelectedItem.Value);
        }

        protected void CreateLogEventOutcome(int outcomeType, string outcomeComments)
        {
            try
            {
                string eventName = null;
                if (outcomeType != 1) eventName = Page.Cookies.UserDisplayName;
                ReferralData.LogEventInsertRow logEventRow;
                //build a logevent row with default values
                logEventRow = dsReferralData.LogEventInsert.AddLogEventInsertRow(
                    Page.Cookies.CallID,
                    outcomeType,//Event type
                    DateTime.Now,//Event Date/Time
                    0,//Event Number
                    eventName,//Event Name or to/from
                    null,//Event Phone
                    Page.Cookies.UserOrganizationName,//Event Org
                    outcomeComments,//Description
                    Page.Cookies.StatEmployeeID,//StatEmployeeID
                    0,//Callback Pending
                    DateTime.Now,//LastModified
                    -1,//ScheduleGroupID
                    -1,//PersonID
                    Page.Cookies.UserOrgID,//OrganizationID
                    -1,//PhoneID
                    0,//LogEventContactConfirmed
                    0,//UpdatedFlag
                    DateTime.Now,//LogEventCalloutDateTime
                    Page.Cookies.StatEmployeeID,
                    "1",//Audit Log Type
                    Page.Cookies.TimeZone);//TimeZone
                ReferralManager.InsertReferralReportLogEvent(dsReferralData);
            }
            catch (Exception ex)
            {
                DisplayMessages.Add(MessageType.ErrorMessage, "A database error has prevented the updates from being saved. Please logout and try again. ");
            }
        }
        protected void CreateLogEventOnlineReviewPending(string sourceCodeName)
        {
            try
            {
                string eventName = null;
                eventName = Page.Cookies.UserDisplayName;
                ReferralData.LogEventInsertRow logEventRow;
                //build a logevent row with default values
                logEventRow = dsReferralData.LogEventInsert.AddLogEventInsertRow(
                    Page.Cookies.CallID,
                    43, //Event type: 43 = OnlineReviewPending
                    DateTime.Now,//Event Date/Time
                    0,//Event Number
                    sourceCodeName, //Event Name or to/from
                    "(000)000-0000",//Event Phone
                    Page.Cookies.UserOrganizationName,//Event Org
                    null,//Description
                    Page.Cookies.StatEmployeeID,//StatEmployeeID
                    -1,//Callback Pending
                    DateTime.Now,//LastModified
                    0,//ScheduleGroupID
                    0,//PersonID
                    Page.Cookies.UserOrgID,//OrganizationID
                    0,//PhoneID
                    0,//LogEventContactConfirmed
                    0,//UpdatedFlag
                    DateTime.Now,//LogEventCalloutDateTime
                    Page.Cookies.StatEmployeeID,
                    "1",//Audit Log Type
                    Page.Cookies.TimeZone);//TimeZone
                ReferralManager.InsertReferralReportLogEvent(dsReferralData);
            }
            catch (Exception ex)
            {
                DisplayMessages.Add(MessageType.ErrorMessage, "A database error has prevented the updates from being saved. Please logout and try again. ");
            }
        }
       
        public bool IsValid()
        {
            bool returnValue = true;
            //test to see if someone else opened the call and saved it
            ReferralData dsCallData = new ReferralData();
            Statline.StatTrac.Data.Referral.ReferralDB.FillCall(dsCallData, Page.Cookies.CallID);
            if (dsCallData.Call[0].CallOpenByID != Page.Cookies.StatEmployeeID)
            {
                DisplayMessages.Add(MessageType.ErrorMessage, "You no longer have permission to update the call...please re-open the call.");
                btnSave.Enabled = false;
                returnValue = false;
                return returnValue;
            }
            //test to see if someone else has it opened
            int test = ReferralManager.GetCallLocked(Page.Cookies.CallID, Page.Cookies.StatEmployeeID, 0);
            if (test == 1)
            {
                DisplayMessages.Add(MessageType.ErrorMessage, "Referral is currently opened by another user.");
                btnSave.Enabled = false;
                returnValue = false;
                return returnValue;
            }
            //anything other than not approached in moa, the rest of the fields must be filled out 1.2
            if ((ddlMOA.SelectedItem.Value != "1") && (ddlApproacher.Text == "-1" || ddlConsent.Text == "-1"))
            {
                returnValue = false;
                DisplayMessages.Add(MessageType.ErrorMessage, "Approacher and Consent are Required Fields with anything other than Not Approached");
                return returnValue;
            }

            //if (ddlMOA.SelectedItem.Value == "1" && (!string.IsNullOrEmpty(ddlApproacher.Text) || !string.IsNullOrEmpty(ddlConsent.Text)))
            //{
            //    returnValue = false;
            //    DisplayMessages.Add(MessageType.ErrorMessage, "Approacher and/or Consent Cannot be Selected When Method of Approach is Not Approached");
            //}

            if (string.IsNullOrEmpty(txtApproacherChangeNote.Text) && txtApproacherChangeNote.Enabled && !string.IsNullOrEmpty(gridAppropriate.Rows[0].Cells[9].Text))
            {
                returnValue = false;
                DisplayMessages.Add(MessageType.ErrorMessage, "You must enter a note if you change the Approacher");
                return returnValue;
            }

            ////Method of Approach Can't be Not Approached and dispo yes 1.3
            string testApproachYes;
            if (ddlApproachOrgan.SelectedIndex > 0)
            {
                testApproachYes = ddlApproachOrgan.SelectedItem.Text;
            }
            else
            {
                testApproachYes = ddlApproachOrgan.Text;
            }
            if (testApproachYes == "Yes" && ddlMOA.SelectedItem.Value == "1")
            {
                returnValue = false;
                ddlApproachOrgan.Focus();
                DisplayMessages.Add(MessageType.ErrorMessage, "Disposition Approach Can not be Yes if Method of Approach is Not Approached");
                return returnValue;
            }

            if (ddlApproachBone.SelectedIndex > 0)
            {
                testApproachYes = ddlApproachBone.SelectedItem.Text;
            }
            else
            {
                testApproachYes = ddlApproachBone.Text;
            }
            if (testApproachYes == "Yes" && ddlMOA.SelectedItem.Value == "1")
            {
                returnValue = false;
                ddlApproachBone.Focus();
                DisplayMessages.Add(MessageType.ErrorMessage, "Disposition Approach Can not be Yes if Method of Approach is Not Approached");
                return returnValue;
            }

            if (ddlApproachTissue.SelectedIndex > 0)
            {
                testApproachYes = ddlApproachTissue.SelectedItem.Text;
            }
            else
            {
                testApproachYes = ddlApproachTissue.Text;
            }
            if (testApproachYes == "Yes" && ddlMOA.SelectedItem.Value == "1")
            {
                returnValue = false;
                ddlApproachTissue.Focus();
                DisplayMessages.Add(MessageType.ErrorMessage, "Disposition Approach Can not be Yes if Method of Approach is Not Approached");
                return returnValue;
            }

            if (ddlApproachSkin.SelectedIndex > 0)
            {
                testApproachYes = ddlApproachSkin.SelectedItem.Text;
            }
            else
            {
                testApproachYes = ddlApproachSkin.Text;
            }
            if (testApproachYes == "Yes" && ddlMOA.SelectedItem.Value == "1")
            {
                returnValue = false;
                ddlApproachSkin.Focus();
                DisplayMessages.Add(MessageType.ErrorMessage, "Disposition Approach Can not be Yes if Method of Approach is Not Approached");
                return returnValue;
            }

            if (ddlApproachValve.SelectedIndex > 0)
            {
                testApproachYes = ddlApproachValve.SelectedItem.Text;
            }
            else
            {
                testApproachYes = ddlApproachValve.Text;
            }
            if (testApproachYes == "Yes" && ddlMOA.SelectedItem.Value == "1")
            {
                returnValue = false;
                ddlApproachValve.Focus();
                DisplayMessages.Add(MessageType.ErrorMessage, "Disposition Approach Can not be Yes if Method of Approach is Not Approached");
                return returnValue;
            }

            if (ddlApproachEyes.SelectedIndex > 0)
            {
                testApproachYes = ddlApproachEyes.SelectedItem.Text;
            }
            else
            {
                testApproachYes = ddlApproachEyes.Text;
            }
            if (testApproachYes == "Yes" && ddlMOA.SelectedItem.Value == "1")
            {
                returnValue = false;
                ddlApproachEyes.Focus();
                DisplayMessages.Add(MessageType.ErrorMessage, "Disposition Approach Can not be Yes if Method of Approach is Not Approached");
                return returnValue;
            }

            if (ddlApproachOther.SelectedIndex > 0)
            {
                testApproachYes = ddlApproachOther.SelectedItem.Text;
            }
            else
            {
                testApproachYes = ddlApproachOther.Text;
            }

            if (testApproachYes == "Yes" && ddlMOA.SelectedItem.Value == "1")
            {
                returnValue = false;
                ddlApproachOther.Focus();
                DisplayMessages.Add(MessageType.ErrorMessage, "Disposition Approach Can not be Yes if Method of Approach is Not Approached");
                return returnValue;
            }
            //no spec number but if the moa is not "not approached", you must fill approach
            if (ddlMOA.SelectedItem.Value != "1")
            {
                if (ddlApproachOrgan.SelectedIndex > 0)
                {
                    testApproachYes = ddlApproachOrgan.SelectedItem.Text;
                }
                else
                {
                    testApproachYes = ddlApproachOrgan.Text;
                }
                if (string.IsNullOrEmpty(testApproachYes) && ddlApproachOrgan.Enabled==true)
                {
                    returnValue = false;
                    ddlApproachOrgan.Focus();
                    DisplayMessages.Add(MessageType.ErrorMessage, "Disposition not Filled Out");
                    return returnValue;
                }

                if (ddlApproachBone.SelectedIndex > 0)
                {
                    testApproachYes = ddlApproachBone.SelectedItem.Text;
                }
                else
                {
                    testApproachYes = ddlApproachBone.Text;
                }
                if (string.IsNullOrEmpty(testApproachYes) && ddlApproachBone.Enabled == true)
                {
                    returnValue = false;
                    ddlApproachBone.Focus();
                    DisplayMessages.Add(MessageType.ErrorMessage, "Disposition not Filled Out");
                    return returnValue;
                }

                if (ddlApproachTissue.SelectedIndex > 0)
                {
                    testApproachYes = ddlApproachTissue.SelectedItem.Text;
                }
                else
                {
                    testApproachYes = ddlApproachTissue.Text;
                }
                if (string.IsNullOrEmpty(testApproachYes) && ddlApproachTissue.Enabled == true)
                {
                    returnValue = false;
                    ddlApproachTissue.Focus();
                    DisplayMessages.Add(MessageType.ErrorMessage, "Disposition not Filled Out");
                    return returnValue;
                }

                if (ddlApproachSkin.SelectedIndex > 0)
                {
                    testApproachYes = ddlApproachSkin.SelectedItem.Text;
                }
                else
                {
                    testApproachYes = ddlApproachSkin.Text;
                }
                if (string.IsNullOrEmpty(testApproachYes) && ddlApproachSkin.Enabled == true)
                {
                    returnValue = false;
                    ddlApproachSkin.Focus();
                    DisplayMessages.Add(MessageType.ErrorMessage, "Disposition not Filled Out");
                    return returnValue;
                }

                if (ddlApproachValve.SelectedIndex > 0)
                {
                    testApproachYes = ddlApproachValve.SelectedItem.Text;
                }
                else
                {
                    testApproachYes = ddlApproachValve.Text;
                }
                if (string.IsNullOrEmpty(testApproachYes) && ddlApproachValve.Enabled == true)
                {
                    returnValue = false;
                    ddlApproachValve.Focus();
                    DisplayMessages.Add(MessageType.ErrorMessage, "Disposition not Filled Out");
                    return returnValue;
                }

                if (ddlApproachEyes.SelectedIndex > 0)
                {
                    testApproachYes = ddlApproachEyes.SelectedItem.Text;
                }
                else
                {
                    testApproachYes = ddlApproachEyes.Text;
                }
                if (string.IsNullOrEmpty(testApproachYes) && ddlApproachEyes.Enabled == true)
                {
                    returnValue = false;
                    ddlApproachEyes.Focus();
                    DisplayMessages.Add(MessageType.ErrorMessage, "Disposition not Filled Out");
                    return returnValue;
                }

                if (ddlApproachOther.SelectedIndex > 0)
                {
                    testApproachYes = ddlApproachOther.SelectedItem.Text;
                }
                else
                {
                    testApproachYes = ddlApproachOther.Text;
                }

                if (string.IsNullOrEmpty(testApproachYes) && ddlApproachOther.Enabled == true)
                {
                    returnValue = false;
                    ddlApproachOther.Focus();
                    DisplayMessages.Add(MessageType.ErrorMessage, "Disposition not Filled Out");
                    return returnValue;
                }
            }

            //test for consent filled if approach yes 1.5
            if (ddlApproachOrgan.SelectedIndex > 0)
            {
                testApproachYes = ddlApproachOrgan.SelectedItem.Text;
            }
            else
            {
                testApproachYes = ddlApproachOrgan.Text;
            }
            if (testApproachYes == "Yes" && (string.IsNullOrEmpty(ddlConsentOrgan.Text) || ddlConsentOrgan.Text == "-1"))
            {
                returnValue = false;
                ddlConsentOrgan.Focus();
                DisplayMessages.Add(MessageType.ErrorMessage, "You must fill out Consent Disposition");
                return returnValue;
            }

            if (ddlApproachBone.SelectedIndex > 0)
            {
                testApproachYes = ddlApproachBone.SelectedItem.Text;
            }
            else
            {
                testApproachYes = ddlApproachBone.Text;
            }
            if (testApproachYes == "Yes" && (string.IsNullOrEmpty(ddlConsentBone.Text) || ddlConsentBone.Text == "-1"))
            {
                returnValue = false;
                ddlConsentBone.Focus();
                DisplayMessages.Add(MessageType.ErrorMessage, "You must fill out Consent Disposition");
                return returnValue;
            }

            if (ddlApproachTissue.SelectedIndex > 0)
            {
                testApproachYes = ddlApproachTissue.SelectedItem.Text;
            }
            else
            {
                testApproachYes = ddlApproachTissue.Text;
            }
            if (testApproachYes == "Yes" && (string.IsNullOrEmpty(ddlConsentTissue.Text) || ddlConsentTissue.Text == "-1"))
            {
                returnValue = false;
                ddlConsentTissue.Focus();
                DisplayMessages.Add(MessageType.ErrorMessage, "You must fill out Consent Disposition");
                return returnValue;
            }

            if (ddlApproachSkin.SelectedIndex > 0)
            {
                testApproachYes = ddlApproachSkin.SelectedItem.Text;
            }
            else
            {
                testApproachYes = ddlApproachSkin.Text;
            }
            if (testApproachYes == "Yes" && (string.IsNullOrEmpty(ddlConsentSkin.Text) || ddlConsentSkin.Text == "-1"))
            {
                returnValue = false;
                ddlConsentSkin.Focus();
                DisplayMessages.Add(MessageType.ErrorMessage, "You must fill out Consent Disposition");
                return returnValue;
            }

            if (ddlApproachValve.SelectedIndex > 0)
            {
                testApproachYes = ddlApproachValve.SelectedItem.Text;
            }
            else
            {
                testApproachYes = ddlApproachValve.Text;
            }
            if (testApproachYes == "Yes" && (string.IsNullOrEmpty(ddlConsentValve.Text) || ddlConsentValve.Text == "-1"))
            {
                returnValue = false;
                ddlConsentValve.Focus();
                DisplayMessages.Add(MessageType.ErrorMessage, "You must fill out Consent Disposition");
                return returnValue;
            }

            if (ddlApproachEyes.SelectedIndex > 0)
            {
                testApproachYes = ddlApproachEyes.SelectedItem.Text;
            }
            else
            {
                testApproachYes = ddlApproachEyes.Text;
            }
            if (testApproachYes == "Yes" && (string.IsNullOrEmpty(ddlConsentEyes.Text) || ddlConsentEyes.Text == "-1"))
            {
                returnValue = false;
                ddlConsentEyes.Focus();
                DisplayMessages.Add(MessageType.ErrorMessage, "You must fill out Consent Disposition");
                return returnValue;
            }

            if (ddlApproachOther.SelectedIndex > 0)
            {
                testApproachYes = ddlApproachOther.SelectedItem.Text;
            }
            else
            {
                testApproachYes = ddlApproachOther.Text;
            }
            if (testApproachYes == "Yes" && (string.IsNullOrEmpty(ddlConsentOther.Text) || ddlConsentOther.Text == "-1"))
            {
                returnValue = false;
                ddlConsentOther.Focus();
                DisplayMessages.Add(MessageType.ErrorMessage, "You must fill out Consent Disposition");
                return returnValue;
            }
            ////if general consent is no and any dispo is yes there is an error 1.4.1
            string testConsentYes;
            if (ddlConsentOrgan.SelectedIndex > 0)
            {
                testConsentYes = ddlConsentOrgan.SelectedItem.Text;
            }
            else
            {
                testConsentYes = ddlConsentOrgan.Text;
            }
            if (testConsentYes == "Yes" && !ddlConsent.SelectedItem.Text.Contains("Yes"))
            {
                returnValue = false;
                ddlConsent.Focus();
                DisplayMessages.Add(MessageType.ErrorMessage, "General Consent and Disposition Must Match");
                return returnValue;
            }
            
            if (ddlConsentBone.SelectedIndex > 0)
            {
                testConsentYes = ddlConsentBone.SelectedItem.Text;
            }
            else
            {
                testConsentYes = ddlConsentBone.Text;
            }
            if (testConsentYes == "Yes" && !ddlConsent.SelectedItem.Text.Contains("Yes"))
            {
                returnValue = false;
                ddlConsent.Focus();
                DisplayMessages.Add(MessageType.ErrorMessage, "General Consent and Disposition Must Match");
                return returnValue;
            }
           
            if (ddlConsentTissue.SelectedIndex > 0)
            {
                testConsentYes = ddlConsentTissue.SelectedItem.Text;
            }
            else
            {
                testConsentYes = ddlConsentTissue.Text;
            }
            if (testConsentYes == "Yes" && !ddlConsent.SelectedItem.Text.Contains("Yes"))
            {
                returnValue = false;
                ddlConsent.Focus();
                DisplayMessages.Add(MessageType.ErrorMessage, "General Consent and Disposition Must Match");
                return returnValue;
            }
            
            if (ddlConsentSkin.SelectedIndex > 0)
            {
                testConsentYes = ddlConsentSkin.SelectedItem.Text;
            }
            else
            {
                testConsentYes = ddlConsentSkin.Text;
            }
            if (testConsentYes == "Yes" && !ddlConsent.SelectedItem.Text.Contains("Yes"))
            {
                returnValue = false;
                ddlConsent.Focus();
                DisplayMessages.Add(MessageType.ErrorMessage, "General Consent and Disposition Must Match");
                return returnValue;
            }
            
            if (ddlConsentValve.SelectedIndex > 0)
            {
                testConsentYes = ddlConsentValve.SelectedItem.Text;
            }
            else
            {
                testConsentYes = ddlConsentValve.Text;
            }
            if (testConsentYes == "Yes" && !ddlConsent.SelectedItem.Text.Contains("Yes"))
            {
                returnValue = false;
                ddlConsent.Focus();
                DisplayMessages.Add(MessageType.ErrorMessage, "General Consent and Disposition Must Match");
                return returnValue;
            }
            
            if (ddlConsentEyes.SelectedIndex > 0)
            {
                testConsentYes = ddlConsentEyes.SelectedItem.Text;
            }
            else
            {
                testConsentYes = ddlConsentEyes.Text;
            }
            if (testConsentYes == "Yes" && !ddlConsent.SelectedItem.Text.Contains("Yes"))
            {
                returnValue = false;
                ddlConsent.Focus();
                DisplayMessages.Add(MessageType.ErrorMessage, "General Consent and Disposition Must Match");
                return returnValue;
            }
            
            if (ddlConsentOther.SelectedIndex > 0)
             {
                testConsentYes = ddlConsentOther.SelectedItem.Text;
            }
            else
            {
                testConsentYes = ddlConsentOther.Text;
            }
            if (testConsentYes == "Yes" && !ddlConsent.SelectedItem.Text.Contains("Yes"))
            {
                returnValue = false;
                ddlConsent.Focus();
                DisplayMessages.Add(MessageType.ErrorMessage, "General Consent and Disposition Must Match");
                return returnValue;
            }
            

            ////if general consent is yes, at least one dispo must be yes 1.4.2
            if (ddlConsent.SelectedIndex != -1)
            {
                if (ddlConsent.SelectedItem.Text.Contains("Yes"))
                {
                    StringBuilder builder = new StringBuilder();
                    if (ddlConsentOrgan.SelectedIndex > 0)
                    {
                        builder = builder.Append(ddlConsentOrgan.SelectedItem.Text).AppendLine();
                    }
                    else
                    {
                        builder = builder.Append(ddlConsentOrgan.Text).AppendLine();
                    }
                    if (ddlConsentBone.SelectedIndex > 0)
                    {
                        builder = builder.Append(ddlConsentBone.SelectedItem.Text).AppendLine();
                    }
                    else
                    {
                        builder = builder.Append(ddlConsentBone.Text).AppendLine();
                    }
                    if (ddlConsentTissue.SelectedIndex > 0)
                    {
                        builder = builder.Append(ddlConsentTissue.SelectedItem.Text).AppendLine();
                    }
                    else
                    {
                        builder = builder.Append(ddlConsentTissue.Text).AppendLine();
                    }
                    if (ddlConsentSkin.SelectedIndex > 0)
                    {
                        builder = builder.Append(ddlConsentSkin.SelectedItem.Text).AppendLine();
                    }
                    else
                    {
                        builder = builder.Append(ddlConsentSkin.Text).AppendLine();
                    }
                    if (ddlConsentValve.SelectedIndex > 0)
                    {
                        builder = builder.Append(ddlConsentValve.SelectedItem.Text).AppendLine();
                    }
                    else
                    {
                        builder = builder.Append(ddlConsentValve.Text).AppendLine();
                    }
                    if (ddlConsentEyes.SelectedIndex > 0)
                    {
                        builder = builder.Append(ddlConsentEyes.SelectedItem.Text).AppendLine();
                    }
                    else
                    {
                        builder = builder.Append(ddlConsentEyes.Text).AppendLine();
                    }
                    if (ddlConsentOther.SelectedIndex > 0)
                    {
                        builder = builder.Append(ddlConsentOther.SelectedItem.Text).AppendLine();
                    }
                    else
                    {
                        builder = builder.Append(ddlConsentOther.Text).AppendLine();
                    }
                    string testYes = builder.ToString();
                    if (!testYes.Contains("Yes"))
                    {
                        returnValue = false;
                        ddlConsent.Focus();
                        DisplayMessages.Add(MessageType.ErrorMessage, "General Consent and Disposition Must Match");
                        return returnValue;
                    }
                }

                
            }
            return returnValue;
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            ReferralData ds = new ReferralData();
            Statline.StatTrac.Data.Referral.ReferralDB.FillCall(ds, Page.Cookies.CallID);
            if (ds.Call[0].CallOpenByID == Page.Cookies.StatEmployeeID)
            {
                ReferralManager.LockCall(Convert.ToInt32(Page.Cookies.CallID), -1, -1, Page.Cookies.StatEmployeeID, 3, 0);
            }
            QueryStringManager.Redirect(PageName.ReferralSearch);
        }


        protected void odsReferralSingle_Selected(object sender, ObjectDataSourceStatusEventArgs e)
        {
            if (e.Exception != null)
            {
                DisplayMessages.Add(MessageType.ErrorMessage, ConstHelper.ERRORGENERALDATABASE);

                e.ExceptionHandled = true;
            }
        }

        protected void odsApproacherList_Selected(object sender, ObjectDataSourceStatusEventArgs e)
        {
            if (e.Exception != null)
            {
                DisplayMessages.Add(MessageType.ErrorMessage, ConstHelper.ERRORGENERALDATABASE);

                e.ExceptionHandled = true;
            }
        }

        protected void odsApproacherTypeList_Selected(object sender, ObjectDataSourceStatusEventArgs e)
        {
            if (e.Exception != null)
            {
                DisplayMessages.Add(MessageType.ErrorMessage, ConstHelper.ERRORGENERALDATABASE);

                e.ExceptionHandled = true;
            }
        }

        protected void odsAppropriate_Selected(object sender, ObjectDataSourceStatusEventArgs e)
        {
            if (e.Exception != null)
            {
                DisplayMessages.Add(MessageType.ErrorMessage, ConstHelper.ERRORGENERALDATABASE);

                e.ExceptionHandled = true;
            }
        }

        protected void odsApproach_Selected(object sender, ObjectDataSourceStatusEventArgs e)
        {
            if (e.Exception != null)
            {
                DisplayMessages.Add(MessageType.ErrorMessage, ConstHelper.ERRORGENERALDATABASE);

                e.ExceptionHandled = true;
            }
        }

        protected void odsConsent_Selected(object sender, ObjectDataSourceStatusEventArgs e)
        {
            if (e.Exception != null)
            {
                DisplayMessages.Add(MessageType.ErrorMessage, ConstHelper.ERRORGENERALDATABASE);

                e.ExceptionHandled = true;
            }
        }

        protected void odsRecovery_Selected(object sender, ObjectDataSourceStatusEventArgs e)
        {
            if (e.Exception != null)
            {
                DisplayMessages.Add(MessageType.ErrorMessage, ConstHelper.ERRORGENERALDATABASE);

                e.ExceptionHandled = true;
            }
        }

        protected void gridApproach_DataBound(object sender, EventArgs e)
        {

        }
    }
}