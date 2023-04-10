using System;
using System.Windows.Forms;
using Statline.Stattrac.Constant;
using Statline.Stattrac.Framework;

namespace Statline.Stattrac.Windows.UI
{
	/// <summary>
	/// Grid that allows to search
	/// Set Properties ButtonSearchVisible, ButtonDeleteVisible, ButtonAddVisible, TimerEnabled, RefereshOnVisible
	/// Implement the protected methods NavigateToAddScreen, NavigateToDeleteScreen, ReloadGrid, UltraGridDoubleClick
	/// Set the Panel 1 collapse value to True if params are used a false if not
	/// </summary>
	public partial class BaseGridSearch : BaseUserControl
	{
		#region Constructor
		/// <summary>
		/// Needed for the designer
		/// </summary>
		public BaseGridSearch()
		{
			InitializeComponent();
			Load += new EventHandler(BaseGridSearch_Load);
			ultraGrid.DoubleClick += new EventHandler(ultraGrid_DoubleClick);
			//bret 6/25/09 do not start the timer if disabled
			if (timer.Enabled)
				timer.Start();
		}
		#endregion

		#region Properties
		/// <summary>
		/// Added region to present control Properties to implementers
		/// </summary>
		private int refreshCount = 0;
		private bool refreshOnVisible = true;
		//presents the Buttons Visible property to any page that uses it
		public bool ButtonSearchVisible
		{
			get { return btnSearch.Visible; }
			set { btnSearch.Visible = value; }
		}
		//presents the Buttons Visible property to any page that uses it
		public bool ButtonDeleteVisible
		{
			get { return btnDelete.Visible; }
			set { btnDelete.Visible = value; }
		}
		//presents the Buttons Visible property to any page that uses it
		public bool ButtonAddVisible
		{
			get { return btnAdd.Visible; }
			set { btnAdd.Visible = value; }
		}
		//presents the Timer to any page that uses it
		public bool TimerEnabled
		{
			get { return timer.Enabled; }
			set { timer.Enabled = value; }
		}
		//presents the Timer to any page that uses it
		public bool RefreshOnVisible
		{
			get { return refreshOnVisible; }
			set { refreshOnVisible = value; }
		}

		#endregion

		#region Public Method
		/// <summary>
		/// Call the base method after binding the datasource
		/// </summary>
		public override void BindDataToUI()
        {
            Cursor.Current = Cursors.WaitCursor;
			txtCount.Text = ultraGrid.Rows.FilteredInNonGroupByRowCount.ToString(GRConstant.StattracCulture);
			base.BindDataToUI();
            Cursor.Current = Cursors.Default;
		}

        public void ReloadGridEnter()
        {
            ReloadGrid();
        }
		#endregion

		#region Protected Method
		protected virtual void NavigateToAddScreen() { }
		/// <summary>
		/// Event fired when Delete Button is clicked
		/// </summary>
		/// <param name="sender"></param>
		/// <param name="e"></param>
		protected virtual void NavigateToDeleteScreen() { }
		/// <summary>
		/// Event fired when Add Button is clicked
		/// </summary>
		/// <param name="sender"></param>
		/// <param name="e"></param>
		protected virtual void ReloadGrid() { }
		/// <summary>
		/// Event fired when a row is selected
		/// </summary>
		/// <param name="sender"></param>
		/// <param name="e"></param>
		protected virtual void UltraGridDoubleClick() { }

		private void ultraGrid_DoubleClick(object sender, EventArgs e)
		{
			UltraGridDoubleClick();
		}

		/// <summary>
		/// Req# 2939
		/// </summary>
		/// <returns></returns>
		protected bool AllowNavigateToEditScreen()
		{
			bool returnValue = true;
			GeneralConstant generalConstant = GeneralConstant.CreateInstance();
            if (generalConstant.ReferralId != -1 && generalConstant.ReferralId != int.MinValue )
			{
				returnValue = false;
				BaseMessageBox.Show("The following Referral is already open: " + generalConstant.ReferralId);
			}
			return returnValue;
		}
		#endregion

		#region Events
		/// <summary>
		/// Reloads the page from the database whenit comes into view
		/// </summary>
		/// <param name="sender"></param>
		/// <param name="e"></param>
		private void BaseGridSearch_Load(object sender, EventArgs e)
		{
			//bret 6/22/09 if RefreshOnVisible is false this event is not ran.
			if (!RefreshOnVisible && refreshCount > 0)
				return;

			if (Visible)
			{
				refreshCount++;
				RefreshPage();
			}
		}

		/// <summary>
		/// Event fired when add button is clicked
		/// </summary>
		/// <param name="sender"></param>
		/// <param name="e"></param>
		private void btnAdd_Click(object sender, EventArgs e)
		{
			NavigateToAddScreen();
		}
        /// <summary>
        /// Event fired when Delete Button is clicked
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void btnDelete_Click(object sender, EventArgs e)
        {
            NavigateToDeleteScreen();
        }
        /// <summary>
        /// Event fired when Search Button is clicked
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void btnSearch_Click(object sender, EventArgs e)
        {
            try
            {
                
                ReloadGrid();
            }
            catch (Exception ex)
            {
                BaseLogger.LogFormUnhandledException(ex, this);
                BaseMessageBox.ShowError(BaseConfiguration.GetSetting(SettingName.DatabaseError), owner: ParentForm);
            }
        }

		#endregion

		#region Private Method
		private void timer_Tick(object sender, EventArgs e)
		{
			if (Visible)
			{
				RefreshPage();
			}
		}
		#endregion
        
	}
}
