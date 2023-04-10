using System;
using System.Collections;
using System.Web.UI;
using System.Web.UI.WebControls;
using Statline.StatTrac.Data.Types;
using Statline.StatTrac.Report;
using Statline.StatTrac.Web.UI.WebControls;
using Statline.StatTrac.Web.Security;
using Statline.Configuration;

namespace Statline.StatTrac.Web.UI.Controls
{
	#region  enum
	/// <summary>
	/// Provides the list of sections for report parameters.
	/// </summary>
	public enum ParamSections
	{
		ReportSpecificParams = 1,
		DateAndTime = 2,
		CoordinatorOrganization = 3,
		AgeGender = 4,
		SortOptions = 5,
		DisplayOptions = 6, 
		TimeZone = 7
	}

	public enum ReportCustomControls
	{
		avayaCustomParams = 1,
		fSConversionParams = 2,
		callParams = 3,
		referralDetailParams = 4,
		customParamsProcessor = 5,
		customParamsStatTracUser = 6,
		customParamsOrganization = 7,
		customParamsPerson = 8,
		customParamsReferralType = 9,
		customParamsCauseOfDeath = 10,
		customParamsPatientName = 11,
		customParamsMedicalRecordNumber = 12,
		customParamsDisplayTriageFSControl = 13,
        customParamsGroupByFacilityControl = 14,
        customParamsDisplayEventLog = 15,
        customParamsRegistryState = 16,
        customParamsRegistryGroupBy = 17,
        customParamsRegistryOutreachEvents = 18,
        customParamsRegistryDonorDesignationStatus = 19,
        customParamsRegistryZipCode = 20,
        customParamsMessageImport = 21,
        customParamsAlert = 22,
        customParamsFSSummary = 23,
        customParamsScheduleLookup = 24,
        customParamsDisplayDisposition = 25,
        customParamsError = 26, 
        customParamsApproacher = 27,
        customParamsCompletedByControl = 28,
        customParamsTrackingNumberControl = 29,
	    customParamsCAPANumberControl = 30,
        customParamsSummarizeByMonthControl = 31,
        customParamsErrorInfoControl = 32,
        customParamsPageBreakByEmployeeControl = 33,
        customParamsEmployeeControl = 34,
        customParamsSummarizeByEmployeeControl = 35,
        customParamsTrackingTypeControl = 36,
        customParamsPendingReferralTypeControl = 37,
        customParamsAgeRangeControl = 38,
        customParamsRegistryDonorStatusControl = 39,
        customParamsRegistryMailingLabelsSourceControl = 40,
        customParamsRegistryDMVWebControl = 41
    }
	public enum ReportControls
	{
		ddlReportDateType = 1,
		ddlReportGroup = 4,
		ddlOrganization = 5,
		ddlSourceCode = 6,
		ddlOrganizationCoordinator = 7,
		txtBoxLowerAge = 8,
		ddlGender = 9,
		txtBoxUpperAge = 10,
		ddlSortOption1 = 11,
		ddlSortOption2 = 12,
		ddlSortOption3 = 13,
		chkBoxDisplayReferralName = 14,
		chkBoxDisplaySSN = 15,
		chkBoxDisplayMedicalRecord = 16,
		radionButtonTimeZoneMountain = 17,
		radionButtonTimeZoneReferral = 18,
        webDateTimeEditStart = 21,
        webDateTimeEditEnd = 22
	    
    }
	public enum ReportParams
	{
		LowerAge,
		UpperAge,
		Gender,
		ReferralStartDateTime,
		ReferralEndDateTime,
		CardiacStartDateTime,
		CardiacEndDateTime,
		StartDateTime,
		EndDateTime,
		ReportGroupID,
		OrganizationID,
		SourceCodeName,
		CoordinatorID,
		SortBy1,
		SortBy2,
		SortBy3,
		DisplayReferralName,
		DisplaySSN,
		DisplayMedicalRecord,
		AnswerLoginID,
		CallingParty,
		DialedNumber,
		MinQueueTime,
		ApproachPersonID,
		BoneSkinOnly,
		CallID,
		MaxRows,
		DisplayEventLog,
		SortSecondaryData,
		DisplaySecondaryData,
		DisplaySecondaryDisposition,
		ProcessorType,
		User,
		OrganizationName,
		FirstName,
		LastName,
		PatientLastName,
		PatientFirstName,
		MedicalRecordNumber,
		ReferralType,
		CauseOfDeath,
		DisplayMT,
		DisplayTriage,
		DisplayFamilyServices,
        GroupByReferralFacility,
        State,
        MainCategoryID,
        SubCategoryID,
        SourceCode,
        ReportFormat,
        NewYes,
        YesToYes,
        NoToYes,
        TotalYes,
        YesToNo,
        RegistryState,
        RegistryWeb,
        DonorStatus,
        Source,
        RegistryDMVWeb,
        ZipCodeOptions,
        ZipCodeData,
        MessageCallerOrganization,
        MessageFor,
        AlertTypeID,
        AlertID,       
        ApproacherOrganization,
        ApproacherData,
        DisplayTotalConsentRate,
        ApproahcerTitle,
        ScheduleOrganization,
        ScheduleGroup,
        DisplayDisposition,
        ErrorSource,
        ErrorComputer,
        ErrorDescription,
        UserOrgID,
        UserID,
        UserDisplayName,
        MessageForOrganizationID,
        BlockEventLog,
        TrackingNum,
        CAPANum,
        CompletedByID,
        SummarizeByMonth,
        PageBreakByEmployee,
        ErrorLocationID,
        ProcessStepID,
        ErrorTypeID,
        HowIdentifiedID,
        ZeroErrors,
        Personids,
        SummarizeByEmployee,
        HideEmployee,
        TrackingTypeID,
        AgeRange

	}
	#endregion

	/// <summary>
	///		Summary description for ReportParamsControl.
	/// </summary>
	public partial class ReportParamsControl : BaseUserControlSecure
	{
        
		#region controls

		protected DateTimeChooser DateTimeChooser1;
		//place holders are for dyanmic content
		protected PlaceHolder phReportSpecificParams;
		protected Hashtable parameters;
		protected CustomParamsAvayaTroubleReportControl avayaCustomParams;
		protected CustomParamsFSConversionRateControl fSConversionParams;
		protected CustomParamsCallControl callParams;
		protected CustomParamsReferralDetail referralDetailParams;
		protected CustomParamsProcessor customParamsProcessor;
		protected CustomParamsStatTracUserControl customParamsStatTracUser;
		protected CustomParamsOrganizationControl customParamsOrganization;
		protected CustomParamsPersonControl customParamsPerson;
		protected CustomParamsPatientNameControl customParamsPatientName;
		protected CustomParamsCauseOfDeathControl customParamsCauseOfDeath;
		protected CustomParamsReferralTypeControl customparamsReferralType;
		protected CustomParamsMedicalRecordNumberControl customParamsMedicalRecordNumber;
		protected ReportReferenceData sortOptionDS;
		#endregion
        
		#region properties

		private string onchangeFunctionName;

        private DateTime archiveDateTime;

        public DateTime ArchiveDateTime
        {
            get { return archiveDateTime; }
            set { archiveDateTime = value; }
        }

		public string OnchangeFunctionName
		{
			get { return onchangeFunctionName; }
			set { onchangeFunctionName = value; }
		}
		#endregion


        #region page load
		protected void Page_Load(object sender, EventArgs e)
		{
            scmReportParams.Scripts.Add(new ScriptReference(ResolveUrl("~/scripts/GenericPage.js")));
            //add the event for asp:table
				AddEvents();
            
			//set the local parameters 
			parameters = Page.Cookies.ReportParameters;
            //hide the calendard for datetime controls
            if(Request.UserAgent.Contains("iPhone"))
            {
                    ajaxPanelViewReport.RemoveTriggerPostBack("btnViewReport");
            }
			if (IsPostBack)
				return;
		    
			// set the report name
            
            lblReportDisplayName.Text = Page.Cookies.ReportDisplayName;			
			//disable all Sections and controls
			DisableSectionsAndControls();
			
			//enabale Sections or Report
			EnableSectionsAndControls();
			DataBind();

        }

        private void EnableSectionsAndControls()
		{

			//build a DataSet to load the parameter controls
			ReportReferenceData reportReference = new ReportReferenceData();
			ReportReferenceManager.FillReportParameterConfigurationList(reportReference, Page.Cookies.ReportID);

            //check for the time zone controls and remove them if the user is not statline
            if (Page.Cookies.UserOrgID != 194)
            {
                //use the string to build a lookp for the reportReference.ReportParameterConfiguration data table
                String selectExpression = "ReportParamSectionName='" + ParamSections.TimeZone.ToString() + "'";
                System.Data.DataRow[] rowList = reportReference.ReportParameterConfiguration.Select(selectExpression);
                foreach (System.Data.DataRow currentRow in rowList)
                {
                    reportReference.ReportParameterConfiguration.Rows.Remove(currentRow);
                }
            }


			//loop through table and Enable Sections and Controls
			foreach(ReportReferenceData.ReportParameterConfigurationRow tr in reportReference.ReportParameterConfiguration)
			{

				string paramSectionName = tr.ReportParamSectionName;
				string paramControlName = tr.ReportControlName;

                //add a section to enable div's
                Control divControl = (Control)FindControl("div" + paramSectionName);
                if (divControl != null)
                    divControl.Visible = true;
				
				Control userControl = (Control) this.FindControl(paramControlName);
				userControl.Visible = true;
				//make sure the row is visible

                SetControlRowVisibility(paramControlName, true);
			}
		}
        private void DisableSectionsAndControls()
		{
		
			//loop through the ReportControls enum and disable the controls
				foreach (string currentControl in Enum.GetNames(typeof(ReportControls)))
				{

					//check if the current loop contains the dateTimeChooser "Start" or "End"
					// these two controls are not WEBCONTROLS so we need to handle them differently
					Control userControl = (Control) this.FindControl(currentControl);
					userControl.Visible = false;
					//disable the currentControl row if it exists
                    SetControlRowVisibility(currentControl, false);
                    //SetLabelVisibility(currentControl, false);
				}

			//treat the customp params differen and seperate
			foreach (string currentControl in Enum.GetNames(typeof(ReportCustomControls)))
			{                
                //check if the current loop contains the dateTimeChooser "Start" or "End"
				// these two controls are not WEBCONTROLS so we need to handle them differently
				Control userControl = (Control) this.FindControl(currentControl);
				userControl.Visible = false; 
				//disable the currentControl row if it exists
                SetControlRowVisibility(currentControl, false);
            }
			//loop through the reportsections and disable them
            foreach (string loopSting in Enum.GetNames(typeof(ParamSections)))
            {
                //add a section to enable div's
                Control divControl = (Control)FindControl("div" + loopSting);
                if (divControl != null)
                    divControl.Visible = false;
            }
		}
		
        private void SetControlRowVisibility(string currentControl, bool visible)
		{
			string stringToFindControl = "";
			//determine if the control has a row to disable
			//check to determine if ddl exists in the string
			//add additional int values to try to find values
			int ddlControl = currentControl.IndexOf("ddl", 0);
			//if ddl is the first 3 characters			
			if(ddlControl > -1 && ddlControl < 3 )
				stringToFindControl = "div" + currentControl.Substring(ddlControl + 3);
            //add additional else if statements to determine if the value exists
            //check to see if control is a check box
            if (stringToFindControl == "")
            {
                ddlControl = currentControl.IndexOf("chkBox", 0);
                //if ddl is the first 3 characters			
                if (ddlControl > -1 && ddlControl < 3)
                    stringToFindControl = "div" + currentControl.Substring(ddlControl + 6);
            }

			//find out if stringToFindControl was built 
			if(stringToFindControl.Length > 0)
			{
				Control rowControl = (Control) this.FindControl(stringToFindControl);
				//check if a control was found and set Visible to false	
				if(rowControl != null)
					rowControl.Visible = visible;

			}                     
               
		}

        #endregion     

        #region DataBind All Controls
        public override void DataBind()
        {

            #region SortOptions
            //sortoptions
			if(
				ddlSortOption1.Visible || 
				ddlSortOption2.Visible || 
				ddlSortOption3.Visible)
			{
				sortOptionDS = new ReportReferenceData(); 
                try
                {
                    ReportReferenceManager.FillReportSortTypeList(sortOptionDS, Page.Cookies.ReportID );
                }
                catch
                {
                    DisplayMessages.Add(MessageType.ErrorMessage, ConstHelper.ERRORGENERALDATABASE);             
                }
			}
			if( ddlSortOption1.Visible )
			{
				ddlSortOption1.SortOptionDataSet = sortOptionDS;
                try
                {
                    ddlSortOption1.DataBind();
                }
                catch
                {
                    DisplayMessages.Add(MessageType.ErrorMessage, ConstHelper.ERRORGENERALDATABASE);             
                }

			}
			if( ddlSortOption2.Visible )
			{
				ddlSortOption2.SortOptionDataSet = sortOptionDS;
                try
                {
                    ddlSortOption2.DataBind();
                }
                catch
                {
                    DisplayMessages.Add(MessageType.ErrorMessage, ConstHelper.ERRORGENERALDATABASE);             
                }

			}
			if( ddlSortOption3.Visible )
			{
				ddlSortOption3.SortOptionDataSet = sortOptionDS;
				
                try
                {
                    ddlSortOption3.DataBind();
                }
                catch
                {
                    DisplayMessages.Add(MessageType.ErrorMessage, ConstHelper.ERRORGENERALDATABASE);             
                }
            }
            #endregion
            #region ReportGroup
            //report group populate if visible or if QA report (QA is not using report group, but need it to correctly populate source code)
			if((	ddlReportGroup.Visible)  || Page.Cookies.ReportDisplayName.ToString().Contains("QA"))
			{
				ddlReportGroup.UserOrgID = Page.Cookies.UserOrgID;
                String allReferrals;
                if (Page.Cookies.UserOrgID.Equals(194))
                    allReferrals = Statline.Configuration.ApplicationSettings.GetSetting(Statline.Configuration.SettingName.StatlineAllReferrals);
                else
                    allReferrals = "All Referrals";
				//set the default value or ReportGroupID
                try
                {
                    ddlReportGroup.DataBind(allReferrals);
                }
                catch
                {
                    DisplayMessages.Add(MessageType.ErrorMessage, ConstHelper.ERRORGENERALDATABASE);             
                }

            }
            #endregion
            #region Oganization
            if (ddlOrganization.Visible)
				ddlOrganization_DataBind();
            #endregion
            #region SourceCode
            if (ddlSourceCode.Visible)
				ddlSourceCode_DataBind();
            #endregion
            #region DateType
            if (ddlReportDateType.Visible)
            {
                ddlReportDateType.ReportID = Page.Cookies.ReportID;
                try
                {
                    ddlReportDateType.DataBind();
                }
                catch
                {
                    DisplayMessages.Add(MessageType.ErrorMessage, ConstHelper.ERRORGENERALDATABASE);
                }
            }
            #endregion
            #region DateTime
            //set the default dates
            if (webDateTimeEditStart.Visible || webDateTimeEditEnd.Visible)
            {
                DateTime startDateTime = new DateTime();
                DateTime endDateTime = new DateTime();
                Boolean isDateOnly = false;

                try
                {
                    ReportReferenceManager.GetReportDateTime(
                    Page.Cookies.ReportID,
                    out startDateTime,
                    out endDateTime,
                    out archiveDateTime,
                    out isDateOnly
                    );
                }
                catch
                {
                    DisplayMessages.Add(MessageType.ErrorMessage, ConstHelper.ERRORGENERALDATABASE);
                }
                webDateTimeEditStart.Value = startDateTime.ToString(ConstHelper.MILITARYDATETIME);
                webDateTimeEditEnd.Value = endDateTime.ToString(ConstHelper.MILITARYDATETIME);
                // isDateOnly is a report DateTime configuration
                if (isDateOnly)
                {
                    webDateTimeEditStart.EditModeFormat = ConstHelper.SHORTDATE;
                    webDateTimeEditEnd.EditModeFormat = ConstHelper.SHORTDATE; 
                }
                // this is hack fix until the need to make this a solution is identeified.
                if (Page.Cookies.ReportName.Contains("ReferralFacilityCompliance"))
                {
                    webDateTimeEditStart.SpinButtons.Delta = 28;
                    webDateTimeEditEnd.SpinButtons.Delta = 28;
                    webDateTimeEditStart.EditModeFormat = "MM/yyyy"; // ConstHelper.SHORTDATE;
                    webDateTimeEditEnd.EditModeFormat = "MM/yyyy"; // ConstHelper.SHORTDATE; 
                }


            }
            else
                webCalendar.Style.Add("display", "none");

            #endregion
            #region OrganizationCoordinator
            if (ddlOrganizationCoordinator.Visible)
            {
                ddlOrganizationCoordinator_DataBind();
            }
            #endregion
        }

		private void ddlOrganization_DataBind()
		{
			// organizations is loaded bases on the select report group value
            if (ddlReportGroup.SelectedValue.Length > 0)
            {
                string defaultValue = string.Empty;
                
                // Default to StatLine organization only if Statline User and QA report
                if (Page.Cookies.UserOrgID.Equals(194) && Page.Cookies.ReportDisplayName.ToString().Contains("QA"))
                    defaultValue = "194";

                ddlOrganization.ReportGroupID = Convert.ToInt32(ddlReportGroup.SelectedValue);
                try
                {
                    ddlOrganization.DataBind(defaultValue);
                }
                catch
                {
                    DisplayMessages.Add(MessageType.ErrorMessage, ConstHelper.ERRORGENERALDATABASE);
                }
            }
            ddlOrganizationCoordinator_DataBind();

		}

		private void ddlSourceCode_DataBind()
		{
			//source code is loaded based on the selected report group value
			if (ddlReportGroup.SelectedValue != "")
			{
				ddlSourceCode.ReportGroupID = Convert.ToInt32(ddlReportGroup.SelectedValue);
			}
			else
			{
				ddlSourceCode.ReportGroupID = 0;
			}
            string reportName = Page.Cookies.ReportName.ToString();
            if (reportName.IndexOf("Referral") > 0)
            {
                ddlSourceCode.SourceCodeTypeID = 1;
            }
            else if (reportName.IndexOf("Message") > 0)
            {
                ddlSourceCode.SourceCodeTypeID = 2;

            }
            else if (reportName.IndexOf("Import") > 0)
            {
                ddlSourceCode.SourceCodeTypeID = 4;

            }
            try
            {
                ddlSourceCode.DataBind();
            }
            catch
            {
                DisplayMessages.Add(MessageType.ErrorMessage, ConstHelper.ERRORGENERALDATABASE);             
            }

		}

        private void ddlOrganizationCoordinator_DataBind()
		{
            ddlOrganizationCoordinator.UserOrgID = Page.Cookies.UserOrgID;
            if (ddlReportGroup.SelectedValue.Length > 0)
                ddlOrganizationCoordinator.ReportGroupID = Convert.ToInt32(ddlReportGroup.SelectedValue);
            if (ddlOrganization.SelectedValue.Length > 0)
                ddlOrganizationCoordinator.CoordinatorOrganizationID = Convert.ToInt32(ddlOrganization.SelectedValue);
            try
            {
                ddlOrganizationCoordinator.DataBind();
            }
            catch
            {
                DisplayMessages.Add(MessageType.ErrorMessage, ConstHelper.ERRORGENERALDATABASE);
            }

		}

        #endregion
        
		#region Web Form Designer generated code

		protected override void OnInit(EventArgs e)
		{
			//
			// CODEGEN: This Call is required by the ASP.NET Web Form Designer.
			//
			InitializeComponent();
			base.OnInit(e);
		}

		/// <summary>
		///		Required method for Designer support - do not modify
		///		the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{

		}

		#endregion

        #region events

        private void AddEvents()
		{
			this.ddlReportGroup.SelectedIndexChanged += new System.EventHandler(this.ddlReportGroup_SelectedIndexChanged);
			this.ddlOrganization.SelectedIndexChanged += new System.EventHandler(this.ddlOrganization_SelectedIndexChanged);
			this.btnViewReport.Click += new System.EventHandler(btnViewReport_Click);

		}

		private void btnViewReport_Click(object sender, EventArgs e)
		{
			//the paramters page needs to only contain new values, clear before building a new one.
			parameters.Clear();
            //loop throught the reportsections and Call the BuildParams
            // if the row id is = to one of the ParamsSections enum values 
            foreach (string loopItem in Enum.GetNames(typeof(ParamSections)))
            {
                //add a section to enable div's
                Control divControl = (Control)FindControl("div" + loopItem);
                if (divControl != null)
                    if(divControl.Visible)
                        BuildParams( (ParamSections)Enum.Parse(typeof(ParamSections), loopItem));
            }

            // this is hack fix until the need to make this a solution is identeified.
            if (Page.Cookies.ReportName.Contains("ReferralFacilityCompliance"))
            {
                DateTime start = Convert.ToDateTime(parameters["Referral" + ReportParams.StartDateTime.ToString()].ToString());
                DateTime end = Convert.ToDateTime(parameters["Referral" + ReportParams.EndDateTime.ToString()].ToString());

                start = Convert.ToDateTime(start.Month + "/1/" + start.Year);
                end = Convert.ToDateTime(end.AddMonths(1).Month + "/1/" + end.AddMonths(1).Year) ;
                end = end.AddSeconds(-1);
                parameters["Referral" + ReportParams.StartDateTime.ToString()] = start.ToString();
                parameters["Referral" + ReportParams.EndDateTime.ToString()] = end.ToString();
                                                
            }
            //add UserOrgID, UserID, and UserDisplayName
			parameters.Add(ReportParams.UserOrgID, Page.Cookies.UserOrgID);
			parameters.Add(ReportParams.UserID, Page.Cookies.UserId);
			parameters.Add(ReportParams.UserDisplayName, Page.Cookies.UserDisplayName);

            //Bret 3/16/09 modified if so if DisplayEventLog is used in report BlockEventLog is sent as a param.
            if (
                parameters.ContainsKey(ReportParams.DisplayEventLog.ToString())
                || ApplicationSettings.GetSetting(SettingName.BlockEventReports).Contains(Page.Cookies.ReportDisplayName)
                )   
                parameters.Add(ReportParams.BlockEventLog, SecurityChecker.CheckAccessToRule(AuthRule.BlockEventLog).ToString()); 

			Page.Cookies.ReportParameters = parameters;
			//Params are set redirect to Display Page
			//QueryStringManager.Redirect(PageName.ReportDisplay);
		}

		private void SetPageState(ParamSections paramSections)
		{
			switch (paramSections)
			{
					//1 "ReportSpecificParams"
				case ParamSections.ReportSpecificParams:
					return;
					//2 "DateAndTime"
				case ParamSections.DateAndTime:
					
					// loop throught the ddldateType drop down and look for the dateType String in the parameters hashtable. 
					// Set the parameters accordinly
					if(webDateTimeEditStart.Visible && webDateTimeEditEnd.Visible)
						for (int loopCount = 0 ; loopCount < ddlReportDateType.Items.Count ; loopCount++ )
						{
							
							if (parameters.ContainsKey(ddlReportDateType.Items[loopCount].Text + "StartDateTime")  )
							{
								// set the ReferralType
								ddlReportDateType.SelectedIndex = loopCount;
								webDateTimeEditStart.Value = (String) parameters[ddlReportDateType.Items[loopCount].Text + "StartDateTime"];
								webDateTimeEditEnd.Value = (String) parameters[ddlReportDateType.Items[loopCount].Text + "EndDateTime"];
								return;
							}
						}

				
					return;
					//3 "CoordinatorOrganization"
				case ParamSections.CoordinatorOrganization:
					if(ddlReportGroup.Visible)
						ddlReportGroup.SelectedIndex =  Convert.ToInt32(parameters[ReportParams.ReportGroupID]);
					if(ddlOrganization.Visible)
						ddlOrganization.SelectedIndex = Convert.ToInt32(parameters[ReportParams.OrganizationID]);
					if(ddlSourceCode.Visible)
						ddlSourceCode.SelectedValue = (String) parameters[ReportParams.SourceCodeName];
					if(ddlOrganizationCoordinator.Visible)
						ddlOrganization.SelectedIndex = Convert.ToInt32(parameters[ReportParams.CoordinatorID]);
					return;
					//4 "AgeGender"
				case ParamSections.AgeGender:
					return;
					//5 sectionSortOptions 
				case ParamSections.SortOptions:
					return;
					//6 sectionDisplayOptions
				case ParamSections.DisplayOptions:
					return;
					//7 sectionTimeZone
				case ParamSections.TimeZone:
					return;
			}
			
		}

		private void BuildParams(ParamSections paramSections)
		{
			switch (paramSections)
			{
				//1 "ReportSpecificParams"
				case ParamSections.ReportSpecificParams:
					// loop through the customparameters and process each
					foreach (string currentControl in Enum.GetNames(typeof(ReportCustomControls)))
					{
						Control userCustomControl = (Control) this.FindControl(currentControl);	
						IBaseParameters userControl = (IBaseParameters) this.FindControl(currentControl);
                                   
						if(userCustomControl.Visible)
						userControl.BuildParams(parameters);
					}
					return;
				//2 "DateAndTime"
				case ParamSections.DateAndTime:
					if(!webDateTimeEditStart.Visible && !webDateTimeEditEnd.Visible)
						return;
                    //store the dates in the params.
                    string startDate;
                    string endDate;

                    //set the date params bases on the date or date and time control
                    startDate = webDateTimeEditStart.Text;
                    endDate = webDateTimeEditEnd.Text;

                    //set the date type and store them in these strings
                    string startDateType = ddlReportDateType.SelectedValue + "StartDateTime";
					string endDateType = ddlReportDateType.SelectedValue + "EndDateTime";

                    //set the paramaters for the report
					parameters.Add(
						startDateType, 
						startDate);
					parameters.Add(
						endDateType, 
						endDate);
					return;
				//3 "CoordinatorOrganization"
				case ParamSections.CoordinatorOrganization:
					if(ddlReportGroup.Visible)
						parameters.Add(
							ReportParams.ReportGroupID, 
							ddlReportGroup.SelectedValue);
					if(ddlOrganization.Visible)
						if(ddlOrganization.SelectedItem.Text != "...")
							parameters.Add(
								ReportParams.OrganizationID, 
								ddlOrganization.SelectedValue);
					if(ddlSourceCode.Visible)
						// if the source code is not selected do not send the parameter.
						if(ddlSourceCode.SelectedItem.Text != "...")
							parameters.Add(
								ReportParams.SourceCodeName, 
								ddlSourceCode.SelectedItem.Text);
					if(ddlOrganizationCoordinator.Visible)
						if(ddlOrganizationCoordinator.SelectedItem.Text != "...")
							parameters.Add(
								ReportParams.CoordinatorID, 
								ddlOrganizationCoordinator.SelectedValue);
					return;
				//4 "AgeGender"
				case ParamSections.AgeGender:
					if(txtBoxLowerAge.Visible)
						if(txtBoxLowerAge.Text.Length > 0)
							parameters.Add(
								ReportParams.LowerAge, 
								txtBoxLowerAge.Text);
					if(txtBoxUpperAge.Visible)
						if(txtBoxUpperAge.Text.Length > 0)
							parameters.Add(
								ReportParams.UpperAge, 
								txtBoxUpperAge.Text);
					if(ddlGender.Visible)
						if(ddlGender.SelectedValue != "...")
						parameters.Add(
							ReportParams.Gender, 
							ddlGender.SelectedValue);
					return;
				//5 sectionSortOptions 
				case ParamSections.SortOptions:
					if(ddlSortOption1.Visible)
						if(ddlSortOption1.SelectedItem.Text != "...")
							parameters.Add(
								ReportParams.SortBy1, 
								ddlSortOption1.SelectedValue);
					if(ddlSortOption2.Visible)
						if(ddlSortOption2.SelectedItem.Text != "...")
							parameters.Add(
								ReportParams.SortBy2, 
								ddlSortOption2.SelectedValue);
					if(ddlSortOption3.Visible)
						if(ddlSortOption3.SelectedItem.Text != "...")
							parameters.Add(
								ReportParams.SortBy3, 
								ddlSortOption3.SelectedValue);
					return;
				//6 sectionDisplayOptions
				case ParamSections.DisplayOptions:
					if(chkBoxDisplayReferralName.Visible)
						parameters.Add(
							ReportParams.DisplayReferralName, 
							chkBoxDisplayReferralName.Checked);
					if(chkBoxDisplaySSN.Visible)
						parameters.Add(
							ReportParams.DisplaySSN, 
							chkBoxDisplaySSN.Checked);
					if(chkBoxDisplayMedicalRecord.Visible)
						parameters.Add(
							ReportParams.DisplayMedicalRecord, 
							chkBoxDisplayMedicalRecord.Checked);
					return;
					//7 sectionTimeZone
				case ParamSections.TimeZone:
					if(radionButtonTimeZoneMountain.Visible)
						parameters.Add(
							ReportParams.DisplayMT,
							radionButtonTimeZoneMountain.Checked);
					return;

			}
		}

		private void ddlReportGroup_SelectedIndexChanged(object sender, System.EventArgs e)
		{
            // note: ddlOrganization_DataBind() calls ddlOrganizationCoordinator_DataBind;
            //odsPendingReferralType.SelectParameters["reportGroupID"].DefaultValue = ddlReportGroup.SelectedValue;
            ddlOrganization_DataBind();
			ddlSourceCode_DataBind();
            
		}

		private void ddlOrganization_SelectedIndexChanged(object sender, System.EventArgs e)
		{
            try
            {
			    ddlOrganizationCoordinator_DataBind();
            }
            catch
            {
                DisplayMessages.Add(MessageType.ErrorMessage, ConstHelper.ERRORGENERALDATABASE);
            }
		}
       #endregion

 
    }
}
