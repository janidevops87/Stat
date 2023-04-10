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
using System.Text.RegularExpressions;
using Statline.StatTrac.Web.UI;
using Statline.Registry.Common;
using Statline.Registry.Data.Common;
using Statline.Registry.Data.Types;
using Statline.Registry.Data.Types.Common;

namespace Statline.Registry.Web.UI.Controls
{
    public partial class EnrollmentControl : BaseUserControl
    {
        protected RegistryCommon dsDonorData;
        protected RegistryCommon dsRegistry;
        protected RegistryCommon dsAddr;
        protected RegistryCommon dsEvent;

        const int Web = 1;

        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {

                // Look for mobile device and redirect if found
                if (Request.Browser.IsMobileDevice)
                {
                    Response.Redirect("~/register/ma/m");
                }
                
                txtLimitations.Attributes.Add("OnKeyPress", "return textMaxLength(this, '200', event)");

                //add one year to the end of Max allowed date to allow users to choose all months
                ddlDOB.MaxDate = DateTime.Now.AddYears(1);
                txtCategorySpecifyText.Visible = false;
                lblCategorySpecifyText.Visible = false;

                txtSubCategorySpecifyText.Visible = false;
                lblSubCategorySpecifyText.Visible = false;

                String StatEmployeeID = Page.Cookies.StatEmployeeID.ToString();
 
                // Fill Category control
                if (dsRegistry == null) dsRegistry = new RegistryCommon();
                RegistryCommonManager.FillEventCategoryEdit(dsRegistry, 0, 1, 1);

                mddlCategory.DataTextField = "EventCategoryName";
                mddlCategory.DataValueField = "EventCategoryID";
                mddlCategory.DataSource = dsRegistry.EventCategory;
                mddlCategory.DataBind();
                mddlCategory.Items.Insert(0, new ListItem("","0"));

                InitializeSubCategory();

                // Fill State DropDownList
                if (dsRegistry == null) dsRegistry = new RegistryCommon();
                RegistryCommonManager.FillDropDownListState(dsRegistry, 1);
                mddlState.DataTextField = "RegistryOwnerStateAbbrv";
                mddlState.DataValueField = "RegistryOwnerStateAbbrv";
                mddlState.DataSource = dsRegistry.RegistryOwnerStateConfig;
                mddlState.DataBind();
                // Set default state selection
                mddlState.Items.Insert(0, new ListItem("", "0"));

                if (!String.IsNullOrEmpty(Request.QueryString["RegistryID"]) && Convert.ToInt32(Page.Cookies.UserId) > 0)
                {
                    Int32 RegistryID = Convert.ToInt32(Request.QueryString["RegistryID"]);
                    String RegistrationStatus = Request.QueryString["RegistrationStatus"];

                    if (dsRegistry == null) dsRegistry = new RegistryCommon();
                    RegistryCommonManager.FillRegistry(dsRegistry, RegistryID);
                    RegistryCommonManager.FillRegistryAddr(dsRegistry, RegistryID, 1);
                    RegistryCommonManager.FillEventRegistry(dsRegistry, RegistryID);

                    String gender = dsRegistry.Registry[0].Gender.ToString();

                    String FindState = dsRegistry.RegistryAddr[0].State == null ? "MA" : dsRegistry.RegistryAddr[0].State.ToString();
                    Int32 FindCategoryID = dsRegistry.EventRegistry[0].EventCategoryID > 0 ? dsRegistry.EventRegistry[0].EventCategoryID : 0;
                    Int32 FindSubCategoryID = dsRegistry.EventRegistry[0].EventSubCategoryID > 0 ? dsRegistry.EventRegistry[0].EventSubCategoryID : 0;

                    // populate form fields
                    if (RegistrationStatus == "Add") rdoAdd.Checked = true;
                    if (RegistrationStatus == "Remove") rdoRemove.Checked = true;
                    this.txtFirstName.Text = dsRegistry.Registry[0].FirstName.ToString();
                    this.txtMiddleName.Text = dsRegistry.Registry[0].MiddleName.ToString();
                    this.txtLastName.Text = dsRegistry.Registry[0].LastName.ToString();
                    if (gender == "M") this.rdoMale.Checked = true;
                    if (gender == "F") this.rdoFemale.Checked = true;
                    this.ddlDOB.Value = Convert.ToDateTime(dsRegistry.Registry[0].DOB);
                    this.txtStreetAddress.Text = dsRegistry.RegistryAddr[0].Addr1.ToString();
                    this.txtAddress2.Text = dsRegistry.RegistryAddr[0].Addr2.ToString();
                    //this.txtAddress2.Text = dsRegistry.RegistryAddr.Count > 1 ? dsRegistry.RegistryAddr[1].Addr2.ToString() : "";
                    this.txtCity.Text = dsRegistry.RegistryAddr[0].City.ToString();

                    mddlCategory.DataBind();
                    
                    mddlState.SelectedValue = FindState.ToString();

                    this.txtZip.Text = dsRegistry.RegistryAddr[0].Zip.ToString();
                    this.txtEmailAddress.Text = dsRegistry.Registry[0].Email.ToString();
                    this.txtLastFourSSN.Text = dsRegistry.Registry[0].SSN.ToString();
                    this.txtLimitations.Text = dsRegistry.Registry[0].Limitations.ToString();

                    if (RegistrationStatus == "Add")
                    { // populate eventCategory controls
                        try
                        {
                            if (dsRegistry == null) dsRegistry = new RegistryCommon();
                            RegistryCommonManager.FillEventRegistry(dsRegistry, RegistryID);

                            Int32 CategoryID = dsRegistry.EventRegistry[0].EventCategoryID;
                            Int32 SubCategoryID = dsRegistry.EventRegistry[0].EventSubCategoryID;

                            mddlCategory.SelectedValue = CategoryID.ToString();
                            lblEventCategory.Text = mddlCategory.SelectedItem.Text.ToString();

                            // Fill Sub Category control
                            if (dsRegistry == null) dsRegistry = new RegistryCommon();
                            RegistryCommonManager.FillEventSubCategoryEdit(dsRegistry, 0, CategoryID, 1);
                            mddlSubCategory.DataValueField = "EventSubCategoryID";
                            mddlSubCategory.DataTextField = "EventSubCategoryName";
                            mddlSubCategory.DataSource = dsRegistry.EventSubCategory;
                            mddlSubCategory.DataBind();
                            mddlSubCategory.Items.Insert(0, new ListItem("", "0"));
                            mddlSubCategory.SelectedValue = SubCategoryID.ToString();
 
                            txtCategorySpecifyText.Text = dsRegistry.EventRegistry[0].EventCategorySpecifyText == null ? "" : dsRegistry.EventRegistry[0].EventCategorySpecifyText.ToString();
                            txtSubCategorySpecifyText.Text = dsRegistry.EventRegistry[0].EventSubCategorySpecifyText == null ? "" : dsRegistry.EventRegistry[0].EventSubCategorySpecifyText.ToString();

                            DisplayCategorySpecifyText();
                            DisplaySubCategorySpecifyText();
                        }
                        catch
                        {
                            mddlCategory.SelectedIndex = 0;
                            mddlSubCategory.SelectedIndex = 0;
                        }
                        finally
                        {
                        }
                    }
                    else
                    {
                        DisableEventCategoryControls();
                    }


                    mddlSubCategory.SelectedValue = FindSubCategoryID.ToString();
                    this.txtComments.Text = dsRegistry.Registry[0].Comment.ToString();

                } // End of querystring check
                else
                { // This is a blank enrollment form.
                  // The EventCategory control was loaded prior to querystring check.
                  // EventSubcategory control requires binding to the datatable before pageload completes
                  // data will be loaded when the select category event is fulfilled.
                mddlSubCategory.DataSource = dsRegistry.EventSubCategory;
                mddlSubCategory.DataBind();
                }

            } // End of Postback check
            if (this.IsPostBack && mddlCategory.SelectedValue == "0")
            {   // initialize SubCategory
                InitializeSubCategory();
            }
         }

        private void InitializeSubCategory()
        {
            if (dsRegistry == null) dsRegistry = new RegistryCommon();
            RegistryCommonManager.FillEventSubCategoryEdit(dsRegistry, 0, -1, 1);
            mddlSubCategory.DataValueField = "EventSubCategoryID";
            mddlSubCategory.DataTextField = "EventSubCategoryName";
            mddlSubCategory.DataSource = dsRegistry.EventSubCategory;
            mddlSubCategory.DataBind();
            mddlSubCategory.Items.Insert(0, new ListItem("","0"));
        }

        protected void btnRegisterNow_Click(object sender, EventArgs e)
        {
            //validate user form information prior to post
             if (IsValid())
            {
                SaveData();
                string RegistryID;
                if (Session["RegistryID"] != null) { RegistryID = (string)(Session["RegistryID"].ToString()); }
                 else {RegistryID = "0";}

                 if (rdoRemove.Checked == true)
                {
                    // Check for existing record prior to IDology check.
                    //  1.  -1, New donor
                    //  2.   0, Don't update this record. More than one donor exists with the same criteria
                    //  3. n>1, This is an update. One donor match found. Value returned is old RegistryID
                    int RegistryOwnerID = 1; //NEOB
                    string FirstName = removeIllegalSQL(txtFirstName.Text.ToString());
                    string LastName = removeIllegalSQL(txtLastName.Text.ToString());
                    string LastFourSSN = txtLastFourSSN.Text.ToString();
                    string License = "-"; //NEOB does not use license
                    string DOB = ddlDOB.Text.ToString();

                    Int32 DonorID = RegistryCommonManager.GetExistingDonor(Convert.ToInt32(RegistryID), RegistryOwnerID, FirstName, LastName, LastFourSSN, License, DOB, 0);

                    if (DonorID < 1) // cannot confirm donor 
                    {
                        // Either donor does not exist or multiple records found.
                        // IDology check not required.
                        Session.Add("IDRequestType", "DisplayPageOnly");
                    }
                }                 
                 
                 //validate with IDology and continue registration
                QueryStringManager.Redirect(PageName.Validate);
            }

        }
        public void SaveData()
        {   
            if (dsDonorData == null) dsDonorData = new RegistryCommon();
            Int32 RegistryID;
            String DonorRegistrationRequest = rdoAdd.Checked ? "Add" : rdoRemove.Checked ? "Remove" : "";
            string StatEmployeeID = Page.Cookies.StatEmployeeID.ToString();

            // Create New temporary record (unconfirmed)
                RegistryID = 0;
                RegistryCommon.RegistryRow row;
                row = dsDonorData.Registry.NewRegistryRow();
                row["RegistryOwnerID"] = 1; // NEOB OwnerID
                row["SSN"] = txtLastFourSSN.Text.ToString();
                row["DOB"] = Convert.ToDateTime(ddlDOB.Text).ToShortDateString();
                row["FirstName"] = removeIllegalSQL(txtFirstName.Text.ToString());
                row["MiddleName"] = removeIllegalSQL(txtMiddleName.Text.ToString());
                row["LastName"] = removeIllegalSQL(txtLastName.Text.ToString());
                //row["Suffix"] = DBNull.Value;
                row["Gender"] = rdoMale.Checked ? "M" : rdoFemale.Checked ? "F" : "U";
                //row["Race"] = DBNull.Value;
                //row["EyeColor"] = DBNull.Value;
                //row["Phone"] = DBNull.Value;
                row["Email"] = txtEmailAddress.Text.ToString();
                row["Comment"] = removeIllegalSQL(txtComments.Text.ToString());
                row["Limitations"] = removeIllegalSQL(txtLimitations.Text.ToString());
                //row["LimitationsOther"] = DBNull.Value;
                //row["license"] = DBNull.Value;
                row["Donor"] = false; //not a donor until IDolody confirms and electronic signature obtained
                row["DonorConfirmed"] = false; //not a donor until IDolody confirms and electronic signature obtained
                row["OnlineRegDate"] = DateTime.Now.ToString();
                //row["SignatureDate"] = DBNull.Value;
                //row["MailerDate"] = DBNull.Value;
                row["DeleteFlag"] = true; //not a donor until IDolody confirms and electronic signature obtained
                //row["DeceaseDate"] = DBNull.Value;
                //row["PreviousDonor"] = DBNull.Value;
                //row["PreviousDonorConfirmed"] = DBNull.Value;
                //row["CreateDate"] = DBNull.Value;
                //row["LastModified"] = DBNull.Value;
                row["LastStatEmployeeID"] = Convert.ToInt32(StatEmployeeID); //Public(0) Admin (> 0)
                row["AuditLogTypeID"] = 1;
                row["RegisteredByID"] = Web;

                dsDonorData.Registry.AddRegistryRow(row);
                RegistryCommonManager.UpdateRegistry(dsDonorData);

                RegistryID = row.RegistryID;

                // Insert Registry Address data
                RegistryCommon.RegistryAddrRow rowAddr;
                rowAddr = dsDonorData.RegistryAddr.NewRegistryAddrRow();
                rowAddr["RegistryID"] = RegistryID;
                rowAddr["AddrTypeID"] = 1;
                rowAddr["Addr1"] = removeIllegalSQL(txtStreetAddress.Text.ToString());
                rowAddr["Addr2"] = removeIllegalSQL(txtAddress2.Text.ToString());
                rowAddr["City"] = removeIllegalSQL(txtCity.Text.ToString());
                rowAddr["State"] = mddlState.SelectedItem.Text.ToString();  //electedRow.Cells[3].Value.ToString();
                rowAddr["Zip"] = txtZip.Text.ToString();
                rowAddr["LastStatEmployeeID"] = Convert.ToInt32(StatEmployeeID); //Public(0) Admin (> 0)
                rowAddr["AuditLogTypeID"] = 1;
                dsDonorData.RegistryAddr.AddRegistryAddrRow(rowAddr);
                RegistryCommonManager.UpdateRegistryAddr(dsDonorData);

                // Insert Event Registry data
                RegistryCommon.EventRegistryRow rowEventReg;
                rowEventReg = dsDonorData.EventRegistry.NewEventRegistryRow();
                rowEventReg["RegistryID"] = RegistryID;
                rowEventReg["EventCategoryID"] = mddlCategory.SelectedIndex == -1 ? 0 : Convert.ToInt32(mddlCategory.SelectedValue);
                rowEventReg["EventSubCategoryID"] = mddlSubCategory.SelectedIndex == -1 ? 0 : Convert.ToInt32(mddlSubCategory.SelectedValue);
                rowEventReg["LastStatEmployeeID"] = Convert.ToInt32(StatEmployeeID); //Public(0) Admin (> 0)
                rowEventReg["AuditLogTypeID"] = 1;
                dsDonorData.EventRegistry.AddEventRegistryRow(rowEventReg);
                RegistryCommonManager.UpdateEventRegistry(dsDonorData);

                //data has been stored
                SaveStateInformation(RegistryID, DonorRegistrationRequest);
        
        }

        private void SaveStateInformation(Int32 RegistryID, String DonorRegistrationRequest)
        {
            //Save state information
            Session.Add("IDRequestType", "New");
            Session.Add("RegistryID", RegistryID.ToString());
            Session.Add("DonorRegistrationRequest", DonorRegistrationRequest);
            Session.Add("FirstName", removeIllegalSQL(txtFirstName.Text.ToString()));
            Session.Add("LastName", removeIllegalSQL(txtLastName.Text.ToString()));
            Session.Add("Address", removeIllegalSQL(txtStreetAddress.Text.ToString()));
            Session.Add("City", removeIllegalSQL(txtCity.Text.ToString()));
            Session.Add("State", mddlState.SelectedItem.Text.ToString()); //ddlState.SelectedRow.Cells[3].Value.ToString());
            Session.Add("Zip", txtZip.Text.ToString());
            Session.Add("LastFourSSN", txtLastFourSSN.Text.ToString());
            Session.Add("DOBYear", Convert.ToDateTime(ddlDOB.Text).Year.ToString());
            Session.Add("DOB", Convert.ToDateTime(ddlDOB.Text).ToString());
        }



        public bool IsValid()
        {
            bool returnValue = true;

            //Check to see that registration status is selected
            if ((rdoAdd.Checked == true) || (rdoRemove.Checked == true))
            {
                //Item is selected
                rdoAdd.BackColor = System.Drawing.Color.White;
                rdoRemove.BackColor = System.Drawing.Color.White;

            }
            else
            {
                rdoAdd.BackColor = System.Drawing.Color.Yellow;
                rdoRemove.BackColor = System.Drawing.Color.Yellow;
                returnValue = false;
            }
            //Check FirstName
            if (txtFirstName.Text.Length > 0) 
            {
                //add reg explesion check here
                txtFirstName.BackColor = System.Drawing.Color.White;
            }
            else
            {
                txtFirstName.BackColor = System.Drawing.Color.Yellow;
                returnValue = false;
            }

            //Check LastName
            if (txtLastName.Text.Length > 0)
            {
                //add reg explesion check here
                txtLastName.BackColor = System.Drawing.Color.White;
            }
            else
            {
                txtLastName.BackColor = System.Drawing.Color.Yellow;
                returnValue = false;
            }
            
            //Check Gender
            // ccarroll  7/14/2009 Corrected Gender assign(=) to evaluation(==)
            // changed order of text box Firstname, Lastname on form. Was: Lastname, Firstname
            // Change requested by client.
            if ((rdoMale.Checked == true) || (rdoFemale.Checked == true))
            {
                rdoMale.BackColor = System.Drawing.Color.White;
                rdoFemale.BackColor = System.Drawing.Color.White;
            }
            else
            {
                rdoMale.BackColor = System.Drawing.Color.Yellow;
                rdoFemale.BackColor = System.Drawing.Color.Yellow;
                returnValue = false;
            }

            //Check DOB
            if (ddlDOB.Text != "" &&
                DateTime.Parse(ddlDOB.Text).Date > DateTime.Now.AddYears(-100).Date &&
                DateTime.Parse(ddlDOB.Text).Date < DateTime.Now.Date
                )

            {
                ddlDOB.BackColor = System.Drawing.Color.White;
            }
            else
            {
                ddlDOB.BackColor = System.Drawing.Color.Yellow;
                returnValue = false;
            }
            
            //Check Street Address
            if (txtStreetAddress.Text.Length > 0)
            {
                txtStreetAddress.BackColor = System.Drawing.Color.White;
            }
            else
            {
                txtStreetAddress.BackColor = System.Drawing.Color.Yellow;
                returnValue = false;
            }
            //Check City

            if (txtCity.Text.Length > 0)
            {
                txtCity.BackColor = System.Drawing.Color.White;
            }
            else
            {
                txtCity.BackColor = System.Drawing.Color.Yellow;
                returnValue = false;
            }

            //Check State
            if (mddlState.SelectedIndex != 0)
            {
                mddlState.BackColor = System.Drawing.Color.White;
            }
            else
            {
                mddlState.BackColor = System.Drawing.Color.Yellow;
                returnValue = false;
            }

            //Check Zip code
            string zipPattern = @"^\d{5}(-\d{4})?$";
            Regex zipRegex = new Regex(zipPattern);
            string zip = txtZip.Text.ToString();
            Match z = zipRegex.Match(zip);
            if (z.Success)
            {
                txtZip.BackColor = System.Drawing.Color.White;
            }
            else
            {
                txtZip.BackColor = System.Drawing.Color.Yellow;
                returnValue = false;
            }



            //Check Email address
            string emailPattern = @"^(([\w-]+\.)+[\w-]+|([a-zA-Z]{1}|[\w-]{2,}))@"
            + @"((([0-1]?[0-9]{1,2}|25[0-5]|2[0-4][0-9])\.([0-1]?[0-9]{1,2}|25[0-5]|2[0-4][0-9])\."
            + @"([0-1]?[0-9]{1,2}|25[0-5]|2[0-4][0-9])\.([0-1]?[0-9]{1,2}|25[0-5]|2[0-4][0-9])){1}|"
            + @"([a-zA-Z]+[\w-]+\.)+[a-zA-Z]{2,4})$";

            Regex emailregex = new Regex(emailPattern);
            string email = txtEmailAddress.Text.ToString();
            Match m = emailregex.Match(email);
            if (m.Success)
            {
                txtEmailAddress.BackColor = System.Drawing.Color.White;
            }
            else
            {
                txtEmailAddress.BackColor = System.Drawing.Color.Yellow;
                returnValue = false;
            }

            //Check SSN lastFour (Turn back on after testing)
            string ssnPattern = @"([0-9][0-9][0-9][0-9])";
            Regex ssnRegex = new Regex(ssnPattern);
            string ssn = txtLastFourSSN.Text.ToString();
            Match s = ssnRegex.Match(ssn);
            if (s.Success)
            {
                txtLastFourSSN.BackColor = System.Drawing.Color.White;
            }
            else
            {
                txtLastFourSSN.BackColor = System.Drawing.Color.Yellow;
                returnValue = false;
            }

            //Check Category
            if (mddlCategory.Visible == true)
            {
                if (mddlCategory.SelectedValue != "0")
                {
                    mddlCategory.BackColor = System.Drawing.Color.White;
                }
                else
                {
                    mddlCategory.BackColor = System.Drawing.Color.Yellow;
                    returnValue = false;
                }
            }

            //Check CategorySpecifyText
            if (txtCategorySpecifyText.Visible == true)
            {
                if (txtCategorySpecifyText.Text.Length > 0)
                {
                    txtCategorySpecifyText.BackColor = System.Drawing.Color.White;
                }
                else
                {
                    txtCategorySpecifyText.BackColor = System.Drawing.Color.Yellow;
                    returnValue = false;
                }
            }

            //Check SubCategorySpecifyText
            if (txtSubCategorySpecifyText.Visible == true)
            {
                if (txtSubCategorySpecifyText.Text.Length > 0)
                {
                    txtSubCategorySpecifyText.BackColor = System.Drawing.Color.White;
                }
                else
                {
                    txtSubCategorySpecifyText.BackColor = System.Drawing.Color.Yellow;
                    returnValue = false;
                }
            }

            ////Check SubCategory
            if (mddlSubCategory.Visible == true)
            {
                if (mddlSubCategory.SelectedValue != "0")
                {
                    mddlSubCategory.BackColor = System.Drawing.Color.White;
                }
                else
                {
                    mddlSubCategory.BackColor = System.Drawing.Color.Yellow;
                    returnValue = false;
                }

            }



            // if any validation fails, give warning 
            if (returnValue == false)
            {
                DisplayMessages.Add(MessageType.ErrorMessage, "Please correct the following items highlighted in yellow:");
            }

            return returnValue;
        }

        // Remove apostrophe (single quote) if present.
        private string removeIllegalSQL(string inputSQL)
        {
            return inputSQL.Replace("'", string.Empty);
        }

        private void DisplayCategorySpecifyText()
        {
            int CategoryValue = Convert.ToInt32(mddlCategory.SelectedValue);

            if (dsRegistry == null) dsRegistry = new RegistryCommon();
            RegistryCommonManager.FillEventCategoryEdit(dsRegistry, CategoryValue, 1, 1);

            if (dsRegistry.EventCategory.Count == 0 || CategoryValue == 0)
            {
                txtCategorySpecifyText.Text = "";
                txtCategorySpecifyText.Visible = false;
                lblCategorySpecifyText.Visible = false;
                return;
            }
            if (dsRegistry.EventCategory[0].EventCategorySpecifyText == true)
            {
                txtCategorySpecifyText.Visible = true;
                lblCategorySpecifyText.Visible = true;
            }
            else
            {
                txtCategorySpecifyText.Text = "";
                txtCategorySpecifyText.Visible = false;
                lblCategorySpecifyText.Visible = false;
            }
        }

        private void DisplaySubCategorySpecifyText()
        {
            int SubCategoryValue = Convert.ToInt32(mddlSubCategory.SelectedValue);

            if (dsRegistry == null) dsRegistry = new RegistryCommon();
            RegistryCommonManager.FillEventSubCategoryEdit(dsRegistry, SubCategoryValue, 0, 1);

            if (dsRegistry.EventSubCategory.Count == 0 || SubCategoryValue == 0)
            {
                txtSubCategorySpecifyText.Text = "";
                txtSubCategorySpecifyText.Visible = false;
                lblSubCategorySpecifyText.Visible = false;
                return;

            }
                if (dsRegistry.EventSubCategory[0].EventSubCategorySpecifyText == true)
            {
                txtSubCategorySpecifyText.Visible = true;
                lblSubCategorySpecifyText.Visible = true;
            }
            else
            {
                txtSubCategorySpecifyText.Text = "";
                txtSubCategorySpecifyText.Visible = false;
                lblSubCategorySpecifyText.Visible = false;
            }
        }

        protected void odsCategory_Selecting(object sender, ObjectDataSourceSelectingEventArgs e)
        {
            if (this.IsPostBack)
            {
                // e.Cancel = true;
            }
        }

        protected void rdoRemove_CheckedChanged(object sender, EventArgs e)
        {
            DisableEventCategoryControls();
        }

        protected void rdoAdd_CheckedChanged(object sender, EventArgs e)
        {
            // if Add is selected populate the SubCategory control
            // And enable
            InitializeSubCategory();
            EnableEventCategoryControls();
        }

          private void DisableEventCategoryControls()
        {
            if (rdoRemove.Checked == true)
            {
                // Hide/disable EventCategory controls
                mddlCategory.SelectedIndex = -1;
                mddlSubCategory.SelectedIndex = -1;
                txtCategorySpecifyText.Text = "";
                txtSubCategorySpecifyText.Text = "";

                lblEventCategoryMessage.Visible = false;
                lblCategorySpecifyText.Visible = false;
                mddlCategory.Visible = false;
                txtCategorySpecifyText.Visible = false;
                lblEventCategory.Visible = false;
                lblSubCategorySpecifyText.Visible = false;
                mddlSubCategory.Visible = false;
                txtSubCategorySpecifyText.Visible = false;

                // Hide disable Comments (registering in memory of:)
                lblComment.Visible = false;
                txtComments.Visible = false;

                txtComments.Text = "";
            }
        }
        
        private void EnableEventCategoryControls()
        {
            if (rdoAdd.Checked == true)
            {
                // Show/enable EventCategory controls
                lblEventCategoryMessage.Visible = true;
                mddlCategory.Visible = true;
                mddlSubCategory.Visible = true;
                lblEventCategory.Visible = true;

                txtCategorySpecifyText.Text = "";
                txtSubCategorySpecifyText.Text = "";

                if (mddlCategory.SelectedIndex == 0)
                {
                    mddlSubCategory.Visible = false;
                    lblEventCategory.Visible = false;
                }

                // Show/enable Comments (registering in memory of:)
                lblComment.Visible = true;
                txtComments.Visible = true;

                txtComments.Text = "";
            }
        }


        protected void mddlCategory_SelectedIndexChanged(object sender, EventArgs e)
        {
            DisplayCategorySpecifyText();

            // reset SubCategory (Default)
            txtSubCategorySpecifyText.Text = "";
            txtSubCategorySpecifyText.Visible = false;
            lblSubCategorySpecifyText.Visible = false;

            Int32 EventCategory = Convert.ToInt32(mddlCategory.SelectedValue);
            lblEventCategory.Text = mddlCategory.SelectedItem.Text;

            if (EventCategory == 0) //Nothing selected
            {
                EventCategory = -1;
            }
            else 
            {
                mddlCategory.BackColor = System.Drawing.Color.White;
            }

            if (dsRegistry == null) dsRegistry = new RegistryCommon();
            RegistryCommonManager.FillEventSubCategoryEdit(dsRegistry, 0, EventCategory, 1);

            if (dsRegistry.EventSubCategory.Count > 0)
            {
                mddlSubCategory.DataSource = dsRegistry.EventSubCategory;
                mddlSubCategory.DataTextField = "EventSubCategoryName";
                mddlSubCategory.DataValueField = "EventSubCategoryID";
                mddlSubCategory.DataBind();
                mddlSubCategory.Items.Insert(0, new ListItem("", "0"));
                lblEventCategory.Visible = true;
                mddlSubCategory.Visible = true;
            }
            else
            {
                // No data to show
                mddlSubCategory.SelectedIndex = -1; //set default
                lblEventCategory.Visible = false;
                mddlSubCategory.Visible = false;

            }

        }

        protected void mddlSubCategory_SelectedIndexChanged(object sender, EventArgs e)
        {
            DisplaySubCategorySpecifyText();
            mddlSubCategory.BackColor = System.Drawing.Color.White;
        }



    }
}