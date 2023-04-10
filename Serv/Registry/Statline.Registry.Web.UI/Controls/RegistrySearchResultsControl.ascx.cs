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
using Statline.StatTrac.Person;
using Statline.StatTrac.Web.Security;

namespace Statline.Registry.Web.UI.Controls
{
    public partial class RegistrySearchResultsControl : BaseUserControlSecure
    {
        protected RegistryCommon dsCommonData;
        Int32 RegistryOwnerID;
        Int32 DMVCounts = -1;
        Int32 WebCounts = -1;
        Int32 DMV_MICounts = -1;
        Int32 Web_MICounts = -1;
        Boolean DisplayWebHeader = true;
        Boolean DisplayDMVHeader = true;
        Boolean DisplayDMV_MIHeader = true;
        Boolean DisplayWeb_MIHeader = true;
        bool AllowDisplayNoDonors = false;

        protected void Page_Load(object sender, EventArgs e)
        {

            if (!this.IsPostBack)
            {   //Set default QueryString values
                string SearchFirstName = Request.QueryString["FirstName"] == null ? "*" : HttpUtility.UrlDecode(Request.QueryString["FirstName"]);
                string SearchMiddleName = Request.QueryString["MiddleName"] == null ? "*" : HttpUtility.UrlDecode(Request.QueryString["MiddleName"]);
                string SearchLastName = Request.QueryString["LastName"] == null ? "*" : HttpUtility.UrlDecode(Request.QueryString["LastName"]);
                string SearchCity = Request.QueryString["City"] == null ? "*" : HttpUtility.UrlDecode(Request.QueryString["City"]);
                string SearchState = Request.QueryString["State"] == null ? "*" : HttpUtility.UrlDecode(Request.QueryString["State"]);
                string SearchZip = Request.QueryString["Zip"] == null ? "*" : HttpUtility.UrlDecode(Request.QueryString["Zip"]);
                string SearchLicense = Request.QueryString["SID"] == null ? "*" : HttpUtility.UrlDecode(Request.QueryString["SID"]);
                string SearchWebRegistryID = Request.QueryString["WebID"] == null ? "-1" : HttpUtility.UrlDecode(Request.QueryString["WebID"]);
                string SearchDOB = Request.QueryString["DOB"] == null ? "01/01/1900" : HttpUtility.UrlDecode(Request.QueryString["DOB"]);
                string SearchStateSelection = Request.QueryString["StateSelection"] == null ? "" : HttpUtility.UrlDecode(Request.QueryString["StateSelection"]);
                string DisplayWebDonors = Request.QueryString["DisplayWebDonors"] == null ? "false" : HttpUtility.UrlDecode(Request.QueryString["DisplayWebDonors"]);
                string DisplayDMVDonors = Request.QueryString["DisplayDMVDonors"] == null ? "false" : HttpUtility.UrlDecode(Request.QueryString["DisplayDMVDonors"]);
                string DisplayWebPendingSignature = Request.QueryString["DisplayPending"] == null ? "false" : HttpUtility.UrlDecode(Request.QueryString["DisplayPending"]);
                string DisplayDMVYesOnly = Request.QueryString["DMVYesOnly"] == null ? "" : HttpUtility.UrlDecode(Request.QueryString["DMVYesOnly"]);
                string DisplayNoDonors = AllowDisplayNoDonors ? "true": "false";
                string SortBy1 = Request.QueryString["SortBy1"] == null ? "FirstName" : HttpUtility.UrlDecode(Request.QueryString["SortBy1"]);
                string SortBy2 = Request.QueryString["SortBy2"] == null ? "LastName" : HttpUtility.UrlDecode(Request.QueryString["SortBy2"]);
                string SortBy3 = Request.QueryString["SortBy3"] == null ? "Zip" : HttpUtility.UrlDecode(Request.QueryString["SortBy3"]);

                if (dsCommonData == null) dsCommonData = new RegistryCommon();

                try
                {
                    RegistryCommonManager.FillDataListRegistrySearchResults(dsCommonData,
                      SearchFirstName.ToString(),
                      SearchMiddleName.ToString(),
                      SearchLastName.ToString(),
                      SearchCity.ToString(),
                      SearchState.ToString(),
                      SearchZip.ToString(),
                      SearchLicense.ToString(),
                      SearchWebRegistryID.ToString(),
                      SearchDOB.ToString(),
                      DisplayWebDonors.ToString(),
                      DisplayDMVDonors.ToString(),
                      DisplayWebPendingSignature.ToString(),
                      DisplayDMVYesOnly.ToString(),
                      SearchStateSelection.ToString(),
                      RegistryOwnerID.ToString(),
                      DisplayNoDonors.ToString()
                      );


                }
                catch (System.Data.SqlClient.SqlException sqlEx)
                {
                    if (sqlEx.Message.Contains("exceeds the current limit"))
                    {
                        lblDMVNoData.Visible = false;
                        lblWebNoData.Visible = false;
                        lblDMV_MINoData.Visible = false;
                        lblWeb_MINoData.Visible = false;
                        DisplayMessages.Add(MessageType.ErrorMessage, sqlEx.Message.ToString());
                    }
                }
                finally
                {
                }

                //Count records before databind
                DataView DMVView = new DataView(dsCommonData.DataListRegistrySearchResults);
                DMVView.RowFilter = "RegistrySearchResultSourceName = 'DMV'";
                DMVCounts = DMVView.Count;

             
                DataView WebView = new DataView(dsCommonData.DataListRegistrySearchResults);
                WebView.RowFilter = "RegistrySearchResultSourceName = 'Web'";
                WebCounts = WebView.Count;

                DataView DMV_MI = new DataView(dsCommonData.DataListRegistrySearchResults);
                DMV_MI.RowFilter = "RegistrySearchResultSourceName = 'DMV_MI'";
                DMV_MICounts = DMV_MI.Count;

                DataView Web_MI = new DataView(dsCommonData.DataListRegistrySearchResults);
                Web_MI.RowFilter = "RegistrySearchResultSourceName = 'Web_MI'";
                Web_MICounts = Web_MI.Count;
                
                if (Request.QueryString["DisplayWebDonors"] == "true" && WebCounts == 0)
                {
                    this.lblWebNoData.Text = "No data found in Web Registry";
                    DisplayWebHeader = false;
                }

                if (Request.QueryString["DisplayDMVDonors"] == "true" && DMVCounts == 0)
                {
                    this.lblDMVNoData.Text = "No data found in DMV Registry";
                    DisplayDMVHeader = false;
                }

                if (IsGOLMUser())
                {
                    if (DMV_MICounts == 0)
                    {
                        {
                            this.lblDMV_MINoData.Text = "No data found in Legacy DMV Registry";
                            DisplayDMV_MIHeader = false;
                        }
                    }
                }
                else
                {
                    DisplayWeb_MIHeader = false;
                    DisplayDMV_MIHeader = false;
                }


                //Custom sort
                if (Request.QueryString["SortBy1"] != null ||
                    Request.QueryString["SortBy2"] != null ||
                    Request.QueryString["SortBy3"] != null)
                {

                    string Field = "RegistrySearchResult";

                    string Sort1 = Field + SortBy1;
                    string Sort2 = Field + SortBy2;
                    string Sort3 = Field + SortBy3;

                    string CustomSort = "[RegistrySearchResultSourceName] DESC, [" + Sort1 + "], [" + Sort2 + "], [" + Sort3 + "]";

                    DataView CustomSortView = new DataView(dsCommonData.DataListRegistrySearchResults);
                    CustomSortView.Sort = CustomSort;

                    dlRegistrySearchResults.DataSource = CustomSortView;
                }
                else
                {
                    dlRegistrySearchResults.DataSource = dsCommonData;
                }
                //Use default Sort
                dlRegistrySearchResults.DataBind();
                

            }

        }

        protected void dlRegistrySearchResults_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
        
        protected string DisplayRegistryControls(string ControlSourceID, string ControlSource, string ControlState, string Display)
        {
            switch (ControlSource) 
            {   
                case "DMV":
                    Display = ControlState;
                    break;

                case "DMV_MI":
                    Display = ControlState;
                    break;

                case "Web_MI":
                    Display = ControlState;
                    break;

                case "Web":

                    if (SecurityChecker.CheckAccessToRule(AuthRule.RegistryUpdate))
                   {
                       if (RegistryOwnerID == 1)
                       { // Check if registry owner is NEOB(1) and redirect accordingly
                           Display = "<a href= javascript:openPage('/Register/Enrollment.aspx?RegistryID=" + ControlSourceID + "&RegistrationStatus=Add')>Update</a>" +
                                      "<br/><br/>" +
                                      "<a href= javascript:openPage('/Register/Enrollment.aspx?RegistryID=" + ControlSourceID + "&RegistrationStatus=Remove')>Delete</a>";
                       }
                       else
                       {
                           Display = "<a href= javascript:openPage('/Register/Dynamic/Enrollment.aspx?RegistryID=" + ControlSourceID + "&RegistrationStatus=Add')>Update</a>" +
                                      "<br/><br/>" +
                                      "<a href= javascript:openPage('/Register/Dynamic/Enrollment.aspx?RegistryID=" + ControlSourceID + "&RegistrationStatus=Remove')>Delete</a>";
                       }

                    }
                   else
                   {
                      Display = " ";
                   }

                    break;
            }
            return Display;
        }

        protected string GetHeader(string SourceName)
        {

            // prepare state selection for DMV display
            string StateSelection = Request.QueryString["StateSelection"].Replace(",", ", ");
            StateSelection = StateSelection.Substring(0, (StateSelection.Length - 2));

            if (SourceName == "DMV_MI" && DisplayDMV_MIHeader == true)
            {
                SourceName = "<div style='font-size: 12pt; height: 55px; text-align: bottom;'><br><br><b>Legacy DMV (" + StateSelection + ") Query Results: </b>" + DMV_MICounts.ToString() + " found in Legacy DMV Registry</div>";
                DisplayDMV_MIHeader = false;
            }
            
            if (SourceName == "Web_MI" && DisplayWeb_MIHeader == true)
            {
                SourceName = "<div style='font-size: 12pt; height: 55px; text-align: bottom;'><br><br><b>Legacy Web Registry (" + StateSelection + ") Query Results: </b>" + Web_MICounts.ToString() + " found in Legacy Web Registry</div>";
                DisplayWeb_MIHeader = false;
            }else if ((SourceName == "Web" || Request.QueryString["DisplayWebDonors"] == "true") && DisplayWebHeader == true)
            {
                SourceName = "<div style='height: 55px; vertical-align: bottom;'><div style='font-size: 12pt;'><br><br><b>" + SourceName + " Registry Query Results: </b>" + WebCounts.ToString() + " found in Web Registry</div></div>";
                DisplayWebHeader = false;
            }

            if (SourceName == "DMV" && DisplayDMVHeader == true) 
            {
                string sourcePrefix = "DMV";
                if (IsGOLMUser())
                {
                    sourcePrefix = "DMV SOS";
                }
                SourceName = "<div style='font-size: 12pt; height: 55px; text-align: bottom;'><br><br><b>" + sourcePrefix +" (" + StateSelection + ") Query Results: </b>" + DMVCounts.ToString() + " found in DMV Registry</div>";
                DisplayDMVHeader = false;
            }

            if (SourceName == "DMV" || SourceName == "Web" || SourceName == "DMV_MI" || SourceName == "Web_MI")
            {   // set default blank by removing orginal SourceName
                SourceName = "";
            }
            return SourceName;
        }
     
        protected string GetVerificationURL(string SourceID, string Source, string State, string DonorStatus) 
        {
            string URL;
            string yes = "Y";
            if (
                (Request.QueryString["FirstName"] != null &&
                Request.QueryString["LastName"] != null &&
                Request.QueryString["DOB"] != null &&
                // Donor 
                DonorStatus.Contains(yes) 
                ) 
                || 
                (Request.QueryString["FirstName"] != null &&
                Request.QueryString["LastName"] != null &&
                RoleAllowsDOBVerificationFormByPass() &&
                // Donor 
                DonorStatus.Contains(yes) 
                )
                )

            {
                URL = "<a href='Register/Dynamic/DonorVerification.aspx?RegistryID=" + SourceID + "&Source=" + Source + "&State=" + State + "' target=_blank >Verification Form</a>";
            }
            else
            {
                URL = "<div>Verification Form</div>";
            }

            return URL;
        }
        
        protected string DisplayWebSourceID(string SourceID, string Source, string BranchNumber)
        {
            string DisplaySource;
            if (Source == "Web")
            {
                DisplaySource = "Web Registry #: " + SourceID.ToString();
            }
            else if (IsGOLMUser() && Source == "DMV")
            {
                DisplaySource = "Branch #: " + BranchNumber.ToString(); ;
            }
            else
            {
                DisplaySource = "";
            }
            return DisplaySource;
        }
        
        protected override void OnInit(EventArgs e)
        {
            if (Session["RegistryOwnerID"] != null) RegistryOwnerID = Convert.ToInt32((string)(Session["RegistryOwnerID"].ToString()));
            else { SetSession(); } // set RegistryOwnerID session
            
            // Set AllowDisplayNoDonors session value
            if (Session["AllowDisplayNoDonors"] != null) bool.TryParse((string)(Session["AllowDisplayNoDonors"].ToString()), out AllowDisplayNoDonors);

        }
        
        public void SetSession()
        {
            RegistryOwnerID = RegistryCommonManager.GetRegistryOwnerUserOrg(Convert.ToInt32(Page.Cookies.UserOrgID), 0);
            Session.Add("RegistryOwnerID", RegistryOwnerID.ToString());
        }

        
        private bool RoleAllowsDOBVerificationFormByPass()
        { 
            //enabled to allow refactoring if rule for ByPass expands beyond GOLM User
            return IsGOLMUser();
        }

        private bool IsGOLMUser()
        {
            bool result = false;

            try
            {
                Statline.StatTrac.Data.Types.UserData loggedInUser = Statline.StatTrac.Security.RolesManager.GetRoles(Page.Cookies.UserId);
                
                for (int roleIndex = 0; roleIndex < loggedInUser.Roles.Rows.Count; roleIndex++)
                {
                    switch (loggedInUser.Roles.Rows[roleIndex].ItemArray[1].ToString())
                   {
                       case "Gift_of_Life_MI:Registry": 
                           result = true;
                           roleIndex = loggedInUser.Roles.Rows.Count + 1;
                           break;
                   }
                }

            }
            catch (Exception ex)
            {
                throw (ex);
            }

            return result;
        }

    }
}