using System;
using System.Windows.Forms;
using System.ComponentModel;
using Statline.Stattrac.Windows.UI;
using Infragistics.Win.UltraWinGrid;
using Statline.Stattrac.Constant;
using Statline.Stattrac.Data.Types.Dashboard;
using Statline.Stattrac.Constant.GridColumns;
using Statline.Stattrac.BusinessRules.Framework;
using Statline.Stattrac.BusinessRules.Dashboard;
using Statline.Stattrac.Common;
using Statline.Stattrac.Windows.CSharpUIMap;

namespace Statline.Stattrac.Windows.UI.Header
{
    

	public partial class MainHeader : BaseUserControl
	{
        #region TimeZoneEnum and TimeZone Time adjustment
        //note: moved TimeZones and Time Adjustement to a globally accessible class once Oasis is integrated with New StatTrac
        [Description("List of TimeZones for time conversion. This is almost a complete list.")]
        private bool militaryTimeDisplay = true;

        public enum TimeZones
        {
            Alaskan_Standard_Time,
            Atlantic_Standard_Time,
            AUS_Eastern_Standard_Time,
            Azerbaijan_Standard_Time,
            Caucasus_Standard_Time,
            Central_Brazilian_Standard_Time,
            Central_Standard_Time,
            Eastern_Standard_Time,
            Egypt_Standard_Time,
            Georgian_Standard_Time,
            Greenwich_Standard_Time,
            GTB_Standard_Time,
            Iran_Standard_Time,
            Jerusalem_Standard_Time,
            Jordan_Standard_Time,
            Middle_East_Standard_Time,
            Montevideo_Standard_Time,
            Mountain_Standard_Time,
            Myanmar_Standard_Time,
            Namibia_Standard_Time,
            New_Zealand_Standard_Time,
            Newfoundland_Standard_Time,
            //Pacific_SA_Standard_Time,
            Pacific_Standard_Time,
            SA_Pacific_Standard_Time,
            Sri_Lanka_Standard_Time,
            Tasmania_Standard_Time,
            Hawaiian_Standard_Time
            //Hawaii_Aleutian_Daylight_Time - this tz id isn't in the system class...use the one above
        }

        private void UpdateTime()
        {
            if (militaryTimeDisplay)
            {
                txtAls.Text = AdjustTimeFromUtc(TimeZones.Alaskan_Standard_Time).ToString("HH:mm");
                txtPac.Text = AdjustTimeFromUtc(TimeZones.Pacific_Standard_Time).ToString("HH:mm");
                txtMnt.Text = AdjustTimeFromUtc(TimeZones.Mountain_Standard_Time).ToString("HH:mm");
                txtCnt.Text = AdjustTimeFromUtc(TimeZones.Central_Standard_Time).ToString("HH:mm");
                txtEst.Text = AdjustTimeFromUtc(TimeZones.Eastern_Standard_Time).ToString("HH:mm");
                txtAtl.Text = AdjustTimeFromUtc(TimeZones.Atlantic_Standard_Time).ToString("HH:mm");
                txtHaw.Text = AdjustTimeFromUtc(TimeZones.Hawaiian_Standard_Time).ToString("HH:mm");
            }
                else
            {
                txtAls.Text = AdjustTimeFromUtc(TimeZones.Alaskan_Standard_Time).ToShortTimeString();
                txtPac.Text = AdjustTimeFromUtc(TimeZones.Pacific_Standard_Time).ToShortTimeString();
                txtMnt.Text = AdjustTimeFromUtc(TimeZones.Mountain_Standard_Time).ToShortTimeString();
                txtCnt.Text = AdjustTimeFromUtc(TimeZones.Central_Standard_Time).ToShortTimeString();
                txtEst.Text = AdjustTimeFromUtc(TimeZones.Eastern_Standard_Time).ToShortTimeString();
                txtAtl.Text = AdjustTimeFromUtc(TimeZones.Atlantic_Standard_Time).ToShortTimeString();
                txtHaw.Text = AdjustTimeFromUtc(TimeZones.Hawaiian_Standard_Time).ToShortTimeString();
            }


            if (!TimeZoneInfo.Local.IsDaylightSavingTime(DateTime.Now))
            {
                lblMnt.Text = "Mountain/AZ";
                lblPac.Text = "Pacific";
            }
            else
            {
                lblMnt.Text = "Mountain";
                lblPac.Text = "Pacific/AZ";
            }

        }
        private DateTime AdjustTimeFromUtc(TimeZones timeZone, DateTime dateTime)
        {
            //get the TimeZone info to calculate adjustment. The Time Zone is past in
            TimeZoneInfo timeZoneInfo = TimeZoneInfo.FindSystemTimeZoneById(timeZone.ToString().Replace("_", " "));
            
            //adjust the time based on the past in timezone
            dateTime = dateTime.Add(timeZoneInfo.GetUtcOffset(dateTime));

            //return the adjusted time. 
            return dateTime;

        }
        private DateTime AdjustTimeFromUtc(TimeZones timeZone)
        {
            //get current time
            DateTime currentDatetime = DateTime.UtcNow;

            currentDatetime = AdjustTimeFromUtc(timeZone, currentDatetime);

            return currentDatetime;
        }

        #endregion

		#region Constructor
		public MainHeader()
		{
			InitializeComponent();
			InitializeBR(new BulletinBoardBR());
            GeneralConstant generalConstant = GeneralConstant.CreateInstance();
            lblDataBase.Text = "Database:  " + generalConstant.CurrentDB;
			RefreshPage();
		}
		#endregion

		#region Protected Methods
		public override void BindDataToUI()
		{
		    timerClock.Interval = 60000;
		    timerClock.Start();
            UpdateTime();

            //Bind Bulletinboard data
            ugBulletinboard.DataSource = BusinessRule.AssociatedDataSet;
            base.BindDataToUI();
		}
	    #endregion

		#region Private Methods
		private void timerClock_Elapsed(object sender, System.Timers.ElapsedEventArgs e)
        {
            
            UpdateTime();
            
            //Refresh Bulletinboard 
            base.RefreshPage();
        }


        private void ugBulletinboard_AfterRowUpdate(object sender, RowEventArgs e)
        {
            //SaveRecord();
            timerClock.Stop();

            // After post check to make certain the Alert was filled in
            const string alert = "Alert";
            const string organization = "Organization";
            int newRowIndex = ugBulletinboard.Rows.Count - 1;



            if (ugBulletinboard.Rows[newRowIndex].Cells[alert].Value.ToString().Length > 0 &&
                ugBulletinboard.Rows[newRowIndex].Cells[organization].Value.ToString().Length > 0)
            {
                timerClock.Start();
                SaveRecord();
            }
            else
            {

                if (ugBulletinboard.Rows[newRowIndex].Cells[organization].Value.ToString().Length < 1)
                {
                    ugBulletinboard.ActiveCell = ugBulletinboard.Rows[newRowIndex].Cells[organization];
                    if (ugBulletinboard.ActiveRow.Cells[organization].CanEnterEditMode)
                    {
                        ugBulletinboard.ActiveRow.Cells[organization].Activate();
                        ugBulletinboard.PerformAction(Infragistics.Win.UltraWinGrid.UltraGridAction.EnterEditMode, false, false);
                        ugBulletinboard.DisplayLayout.Override.ActiveCellAppearance.BackColor = System.Drawing.Color.Yellow;
                        timerClock.Stop();
                    }
                }

                if (ugBulletinboard.Rows[newRowIndex].Cells[alert].Value.ToString().Length < 1)
                {
                    ugBulletinboard.ActiveCell = ugBulletinboard.Rows[newRowIndex].Cells[alert];
                    if (ugBulletinboard.ActiveRow.Cells[alert].CanEnterEditMode)
                    {
                        ugBulletinboard.ActiveRow.Cells[alert].Activate();
                        ugBulletinboard.PerformAction(Infragistics.Win.UltraWinGrid.UltraGridAction.EnterEditMode, false, false);
                        ugBulletinboard.DisplayLayout.Override.ActiveCellAppearance.BackColor = System.Drawing.Color.Yellow;                    }
                        timerClock.Stop();

                    }
            }
        }

        private void ugBulletinboard_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {
                ugBulletinboard.UpdateData();
            }
        }
        private void SaveRecord()
        {   
            //Validate uncommited values before save

            //update changes
            base.SaveDataToDB();
            base.RefreshPage();
        }

        private void ugBulletinboard_MouseDown(object sender, MouseEventArgs e)
        {
            Security.SecurityHelper securityHelper = Security.SecurityHelper.GetInstance();
            if (!securityHelper.Authorized(SecurityRule.Delete_Bulletin_Board.ToString()))
                deleteLineToolStripMenuItem.Visible = false;
            
            if (e.Button == MouseButtons.Right)
                contextMenuStrip1.Show(Control.MousePosition.X, Control.MousePosition.Y);
        }

        public void addLineToolStripMenuItem_Click(object sender, EventArgs e)
        {
            //Add empty row and default values if record count is under AlertLimit
            BulletinBoardDS bulletinBoardDS = (BulletinBoardDS)BusinessRule.AssociatedDataSet;

            //Number of alerts allowed in grid at one time
            int AlertLimit = 5;

            if (ugBulletinboard.Rows.Count > (AlertLimit - 1))
            {
                BaseMessageBox.ShowWarning("Limit of " + Convert.ToString(AlertLimit) + " Alerts has been reached. \nPlease delete alert(s) to add more.");
            }
            else
            {
                ((BulletinBoardBR)BusinessRule).AddEmptyRow(bulletinBoardDS.BulletinBoard);
                
                // Direct user to enter value in newly created row
                const string organization = "Organization";
                 int newRowIndex = ugBulletinboard.Rows.Count - 1;
                 ugBulletinboard.ActiveCell = ugBulletinboard.Rows[newRowIndex].Cells[organization];
                 if (ugBulletinboard.ActiveRow.Cells[organization].CanEnterEditMode)
                 {
                     ugBulletinboard.ActiveRow.Cells[organization].Activate();
                     ugBulletinboard.PerformAction(Infragistics.Win.UltraWinGrid.UltraGridAction.EnterEditMode, false, false);
                 }
                //Stop Timer to allow data input
                 timerClock.Stop();
            }
        }

        public void deleteLineToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Security.SecurityHelper securityHelper = Security.SecurityHelper.GetInstance();
            if (ugBulletinboard.Selected.Rows.Count == 1 && ugBulletinboard.Selected.Rows[0].Cells != null)
            {
                   CellsCollection cellsCollection = ugBulletinboard.Selected.Rows[0].Cells;
                   ugBulletinboard.Selected.Rows[0].Delete();
                   SaveRecord();
            }
        }

        private void IssueToolStripButton_Click(object sender, EventArgs e)
        {
            ((BaseForm)FindForm()).LoadInFormPromptForm(AppScreenType.None, AppScreenType.ReportIssueFeedbackup);
        }


    
        private void newToolStripButton_Click(object sender, EventArgs e)
        {
            UIMap openstatTrac = Statline.Stattrac.Windows.VBUIMap.OpenStatTracVBForms.CreateInstance();
            openstatTrac.Open(AppScreenType.VBNew, 0);
        }

        private void SearchToolStripButton_Click(object sender, EventArgs e)
        {
            UIMap openstatTrac = Statline.Stattrac.Windows.VBUIMap.OpenStatTracVBForms.CreateInstance();
            openstatTrac.Open(AppScreenType.VBSearch, 0);
        }

        private void organizationToolStripButton_Click(object sender, EventArgs e)
        {
            ((BaseForm)FindForm()).LoadSubControl(AppScreenType.Organizations, AppScreenType.OrganizationsOrganizationSearch);
        }

        private void phoneToolStripButton_Click(object sender, EventArgs e)
        {
            UIMap openstatTrac = Statline.Stattrac.Windows.VBUIMap.OpenStatTracVBForms.CreateInstance();
            openstatTrac.Open(AppScreenType.VBOnCall, 0);
        }

        private void helptoolStripButton_Click(object sender, EventArgs e)
        {
            UIMap openstatTrac = Statline.Stattrac.Windows.VBUIMap.OpenStatTracVBForms.CreateInstance();
            openstatTrac.Open(AppScreenType.VBHelp, 0);
        }
        #endregion

        private void timeChange_Click(object sender, EventArgs e)
        {
            if (militaryTimeDisplay)
            {
                militaryTimeDisplay = false;
            }
            else
            {
                militaryTimeDisplay = true;
            }
            UpdateTime();
        }

       
        private void DisplayRequiredFieldMessage(string errorFieldName)
        {
            //define error message
            const string error = "Input Error";
            string errorMessage = errorFieldName.ToString() + " is a required field. Please enter a value";
            BaseMessageBox.ShowError(errorMessage, error);
        }

       

        private void refreshToolStripMenuItem_Click(object sender, EventArgs e)
        {
            //Refresh Bulletinboard
            timerClock.Start();
            base.RefreshPage();
        }

        private void ugBulletinboard_Leave(object sender, EventArgs e)
        {
            //Refresh Bulletinboard
            if (timerClock != null)
            {
                timerClock.Start();
                base.RefreshPage();            
            }

        }
           
    }
}
