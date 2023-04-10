using System;
using System.Windows.Forms;
using Statline.Stattrac.BusinessRules.NewCall;
using Statline.Stattrac.Data.Types.NewCall;
using Statline.Stattrac.Framework;
using Statline.Stattrac.Windows.UI.Properties;

namespace Statline.Stattrac.Windows.UI.Controls.NewCall.Tcss
{
	public partial class ImportDonorCardControl : BaseEditControl
	{
		#region Private Fields
		/// <summary>
		/// We store these two events so that we can dynamiacally add the event and remove it.
		/// By removing the event we allow the users to navigate to other screen once we have finished
		/// gathering the data
		/// </summary>
		private WebBrowserDocumentCompletedEventHandler wbMain_DocumentCompletedventHandler;
		private WebBrowserDocumentCompletedEventHandler wbPopup_DocumentCompletedventHandler;

		// These are used to update the values in the Offer Infromation control
		private CurrencyManager tcssDonorCurrenycyManager;
		private CurrencyManager tcssRecipientOfferInformationtcssRecipientCurrencyManager;
        
		#endregion

		#region Constructor
		public ImportDonorCardControl()
		{
			InitializeComponent();
		}
		#endregion

		#region Overriden Methods
		/// <summary>
		/// Bind Data to UI
		/// </summary>
		public override void BindDataToUI()
		{
			TcssDS tcssDS = (TcssDS)BusinessRule.AssociatedDataSet;
            if (tcssDS.TcssRecipientOfferInformation.Count == 1 && !tcssDS.TcssRecipientOfferInformation[0].IsTcssListStatusOfImportDataIdNull())
            {
                txtMatchId.Enabled = false;
                txtOptn.Enabled = false;
            }
            else
            {
                txtMatchId.Enabled = true;
                txtOptn.Enabled = true;
            }
			// Initilize the currency manager
			tcssDonorCurrenycyManager = (CurrencyManager)BindingContext[tcssDS, tcssDS.TcssDonor.TableName];
			tcssRecipientOfferInformationtcssRecipientCurrencyManager = (CurrencyManager)BindingContext[tcssDS, tcssDS.TcssRecipientOfferInformation.TableName];
            
			// Get the user name and pasword from the config files
			txtUserId.Text = Settings.Default.UnosUserId;
			txtPassword.Text = Settings.Default.UnosPassword;

			string tableName = tcssDS.TcssDonor.TableName; 
			txtOptn.BindDataSet(tcssDS, tableName, tcssDS.TcssDonor.OptnNumberColumn.ColumnName);

			tableName = tcssDS.TcssRecipientOfferInformation.TableName;
			txtMatchId.BindDataSet(tcssDS, tableName, tcssDS.TcssRecipientOfferInformation.MatchIdColumn.ColumnName);
		}

		protected override bool ProcessCmdKey(ref Message msg, Keys keyData)
		{
			if (keyData == Keys.Enter || keyData == Keys.Return)
			{
				btnImport_Click(this, new EventArgs());
			}
			return base.ProcessCmdKey(ref msg, keyData);
		}
		#endregion

		#region Events
		/// <summary>
		/// End the edit so that data is updated elsewhere
		/// </summary>
		/// <param name="sender"></param>
		/// <param name="e"></param>
		private void EndCurrentEdit(object sender, EventArgs e)
		{
			if (tcssDonorCurrenycyManager != null)
			{
				tcssDonorCurrenycyManager.EndCurrentEdit();
				tcssRecipientOfferInformationtcssRecipientCurrencyManager.EndCurrentEdit();
			}
		}

		private void btnImport_Click(object sender, EventArgs e)
		{
			// If this is the first time the case is bieng imported then allow the import, otherwise prompt the 
			// user that they will lose all their data if importing
			TcssDS tcssDS = (TcssDS)BusinessRule.AssociatedDataSet;
            GRConstant.OasisImportClick = false;
			if (tcssDS.TcssRecipientOfferInformation.Count == 1 &&
				!tcssDS.TcssRecipientOfferInformation[0].IsTcssListStatusOfImportDataIdNull())
			{
				DialogResult dialogResult = BaseMessageBox.ShowYesNo(
					"Re-Importing the donor card information will overwrite any data currently entered\n" +
					"in the donor card including modifications made after the last import.\n" +
					"Are you sure you want to re-import the data.");
				switch (dialogResult)
				{
					case DialogResult.Yes:
						((TcssBR)BusinessRule).DeleteDataBeforeImport();
						ImportDataFromUnos();
                        GRConstant.OasisImportClick = true;
						break;
					default:
						break;
				}
			}
			else
			{
				ImportDataFromUnos();
                GRConstant.OasisImportClick = true;
			}
		}

		private void ImportDataFromUnos()
		{
			AttachEventHandlerForWebBrowser();
			txtImportStatus.Text = "Downloading...";
			// Go to the login page the first time other resue the login
			if (wbPopup.Url == null)
			{
				wbMain.Navigate(Settings.Default.UnosUrl);
                if (Settings.Default.UnosUrl != "portal.unos.org")
                    txtImportStatus.Text = "User ID or Password Incorrect";
				ultraTabControl1.Tabs[1].Selected = true;
			}
			else
			{
				wbPopup.Navigate(Settings.Default.UnosUrl + "/DonorNet/SearchAndListDonor.aspx");
				ultraTabControl1.Tabs[2].Selected = true;
			}
		}

		private void wbMain_DocumentCompleted(object sender, WebBrowserDocumentCompletedEventArgs e)
		{
			switch (e.Url.LocalPath)
			{
				case "/":
				case "/index.aspx":
					wbMain.Document.Body.SetAttribute("onload", "");
					wbMain.Document.All["txtUsername"].SetAttribute("value", txtUserId.Text);
					wbMain.Document.All["txtPassword"].SetAttribute("value", txtPassword.Text);
					wbMain.Document.InvokeScript("Form_Submit");
					break;
				case "/demosplash.html":
					wbMain.Document.GetElementsByTagName("a")[0].InvokeMember("Click");
					break;
				case "/DataReports.aspx":
					LaunchDonorNet();
					break;
				default:
					break;
			}
		}

		private void LaunchDonorNet()
		{
			Object[] objArray = new Object[1];
			objArray[0] = Settings.Default.UnosUrl + "/privacyStatementPassthru.aspx?link=%2fCreateNewInstance.aspx?link=%2fDonorNet%2fdefault.aspx%3f";
			wbMain.Document.InvokeScript("popWin", objArray);
		}

		private void wbPopup_DocumentCompleted(object sender, WebBrowserDocumentCompletedEventArgs e)
		{
			Object[] objArray = null;
			switch (e.Url.LocalPath)
			{
				case "/":
					LaunchDonorNet();
					break;
				case "/DonorNet/blank.htm":
				case "/DonorNet/DefaultPageWebParts/TXC_Console_Poll.aspx":
					break;
				case "/DonorNet/default.aspx":
					objArray = new Object[2];
					objArray[0] = "/DonorNet/SearchAndListDonor.aspx?action=search";
					objArray[1] = "_self";
					wbPopup.Document.InvokeScript("openLink", objArray);
					break;
				case "/donornet/util/datebox.aspx":
					break;
				case "/DonorNet/SearchAndListDonor.aspx":
                    string testInnerText = wbPopup.Document.Body.InnerText;
                    //set the status to failure here when you have an invalid optn # and match id...error message is: You do not have permissions to view this page.
                    if (testInnerText.Contains("permissions") || testInnerText.Contains("try again"))
                    {
                        txtImportStatus.Text = "Failure";
                    }
                    if (testInnerText.Contains("did not return"))
                    {
                        txtImportStatus.Text = "Unknown Match ID or OPTN";
                    }
					// Set the Donor Id and the match Id
					wbPopup.Document.GetElementById("searchDCDDonors1_valDonID").SetAttribute("value", txtOptn.Text);
					wbPopup.Document.GetElementById("searchDCDDonors1_NumMatchId").SetAttribute("value", txtMatchId.Text);
                    
					// click on the search button
					wbPopup.Document.GetElementById("buttonGroup1__btnSearch").InvokeMember("Click");
					break;
				case "/DonorNet/ListMatchResults.aspx":
					try
					{
						((TcssBR)BusinessRule).LoadMatchResultsFromUnos(wbPopup.Document.Window.Frames["ListMatchResults"].Document);
					}
					catch (Exception ex)
					{
						BaseLogger.LogFormUnhandledException(ex, this);
						DetachEventHandlerForWebBrowser();
						txtImportStatus.Text = "Failure";
						ultraTabControl1.Tabs[0].Selected = true;
					}
					// we need to click this after the match list loads
					wbPopup.Document.GetElementById("tabDonorEdit").InvokeMember("Click");
					break;
				case "/DonorNet/DonorEdit.aspx":
					try
					{
						((TcssBR)BusinessRule).LoadDonorSummaryFromUnos(wbPopup.Document.Window.Frames["DonorEdit"].Document);
						DetachEventHandlerForWebBrowser();
						TcssManager.ReBindDataToUI();
						txtImportStatus.Text = "Success";
						ultraTabControl1.Tabs[0].Selected = true;
						TcssManager.ToggleEditForDataScrapeFromUnos(false);
					}
					catch (Exception ex)
					{
						BaseLogger.LogFormUnhandledException(ex, this);
						DetachEventHandlerForWebBrowser();
						txtImportStatus.Text = "Failure";
						ultraTabControl1.Tabs[0].Selected = true;
					}
					break;
				case "/DonorNet/DonorEdit_DiagTests.aspx":
				case "/DonorNet/images/blank.gif":
				case "blank":
				case "/DonorNet/PollTXCContactStatus.aspx":
				case "/DonorNet/DonorContainer.aspx":
					break;
				default:
					break;
			}
		}

		private void wbMain_NewWindow2(object sender, Statline.Stattrac.Windows.Forms.WebBrowserNewWindow2EventArgs e)
		{
			e.ppDisp = wbPopup.Application;
			wbPopup.RegisterAsBrowser = true;
			ultraTabControl1.Tabs[2].Selected = true;
		}

		private void AttachEventHandlerForWebBrowser()
		{
			wbMain_DocumentCompletedventHandler = new System.Windows.Forms.WebBrowserDocumentCompletedEventHandler(this.wbMain_DocumentCompleted);
			wbPopup_DocumentCompletedventHandler = new System.Windows.Forms.WebBrowserDocumentCompletedEventHandler(this.wbPopup_DocumentCompleted);

			this.wbMain.DocumentCompleted += wbMain_DocumentCompletedventHandler;
			this.wbPopup.DocumentCompleted += wbPopup_DocumentCompletedventHandler;
		}

		private void DetachEventHandlerForWebBrowser()
		{
			this.wbMain.DocumentCompleted -= wbMain_DocumentCompletedventHandler;
			this.wbPopup.DocumentCompleted -= wbPopup_DocumentCompletedventHandler;
		}
		#endregion
	}
}
