using System;
using System.Collections;
using Statline.Configuration;
using Microsoft.Reporting.WebForms;
using Statline.StatTrac.Data.Types;
using Microsoft.Practices.EnterpriseLibrary.Logging;
using Statline.StatTrac.Web.Security;
using Statline.StatTrac.Web;


namespace Statline.StatTrac.Web.UI.Controls
{


	/// <summary>
	///		Summary description for ReportDisplayControl.
	/// </summary>
	public partial class ReportDisplayControl   : Statline.StatTrac.Web.UI.BaseUserControlSecure
	{
	
		#region Controls
		
		
		#endregion	

        #region fields
        ReportParameter[] reportParameters;

        #endregion
        #region Events
        /// <summary>
        /// 5/6/09 Bret: modified code to handle running reports from Parameters and from Report Popup
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
		protected void Page_Load(object sender, System.EventArgs e)
		{
            DisplayMessages.Clear();
            if (IsPostBack)
                return;
            reportViewer.ServerReport.ReportServerUrl = new Uri(ApplicationSettings.GetSetting(SettingName.ReportingServicesUrl));
            reportViewer.ServerReport.ReportServerCredentials = new ReportViewerCredentials();
            if (Request.QueryString.Count > 0)
            {
                reportViewer.ServerReport.ReportPath = Request.QueryString.Get("ReportName");
                BuildReportParams(Request.QueryString.GetEnumerator());                

            }
            else
            {
                reportViewer.ServerReport.ReportPath = Page.Cookies.ReportName;
                BuildReportParams(Page.Cookies.ReportParameters.GetEnumerator(), Page.Cookies.ReportParameters.Count);
            }

            try
            {
                reportViewer.ServerReport.SetParameters(reportParameters);
            }
            catch(Exception ex)
            {
                DisplayMessages.Add(MessageType.ErrorMessage, ConstHelper.ERRORReportDisplay);
                Logger.Write(ex, "General", 1);

            }
            //reportViewer.ServerReport.Refresh();       
		}

        /// <summary>
        /// This method build Parameters when set by the Parameters Page
        /// </summary>
        /// <param name="paramList"></param>
        private void BuildReportParams(IDictionaryEnumerator paramList, int parameterCount)
        {
            reportParameters = new ReportParameter[parameterCount];
            int reportParamatersIndex = 0;
            int currentIndex = 0;
            while (paramList.MoveNext())
            {
                currentIndex = reportParamatersIndex++;
                reportParameters[currentIndex] = new ReportParameter(paramList.Key.ToString().Trim(), paramList.Value.ToString().Trim());
            }
        }
        /// <summary>
        /// This method processes the QueryString in to a HashTable adds some default params and and recalls the BuildReportParams (IDictionaryEnumerator) 
        /// </summary>
        /// <param name="paramList"></param>
        private void BuildReportParams(IEnumerator queryStringList)
        {
            Hashtable parameterList = new Hashtable();

            //Request.QueryString.Remove("ReportName");
            parameterList.Add(ReportParams.UserID, Page.Cookies.UserId.ToString());
            parameterList.Add(ReportParams.UserOrgID, Page.Cookies.UserOrgID.ToString());
            parameterList.Add(ReportParams.UserDisplayName, Page.Cookies.UserDisplayName.ToString());
        
            while (queryStringList.MoveNext())
            {
                if(queryStringList.Current.ToString() != "ReportName")
                    parameterList.Add(queryStringList.Current, Request.QueryString.Get(queryStringList.Current.ToString()));
                //reportParameters[currentIndex] = new ReportParameter(paramList.Current. paramList.Key.ToString().Trim(), paramList.Value.ToString().Trim());
            }
            //Bret 3/16/09 modified if so if DisplayEventLog is used in report BlockEventLog is sent as a param.
            if (
                parameterList.ContainsKey(ReportParams.DisplayEventLog.ToString())
                )
                parameterList.Add(ReportParams.BlockEventLog, SecurityChecker.CheckAccessToRule(AuthRule.BlockEventLog).ToString()); 

            BuildReportParams(parameterList.GetEnumerator(), parameterList.Count);
        }


		#endregion

		#region Web Form Designer generated code
		override protected void OnInit(EventArgs e)
		{
			//
			// CODEGEN: This call is required by the ASP.NET Web Form Designer.
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

        protected void reportViewer_ReportError(object sender, ReportErrorEventArgs e)
        {
            if (e.Exception.Message == "ASP.NET session has expired")
            {
                e.Handled = true;
                reportViewer.ServerReport.Refresh();                                
            }
        }
	}




}
