using System;
using System.Windows.Forms;
using Statline.Stattrac.Constant;
using Statline.Stattrac.Framework;

namespace Statline.Stattrac.Windows.UI
{
	public class BaseUserControl : UserControl
	{
		#region Protected Fields
		/// <summary>
		/// Business Rules object
		/// </summary>
		private BaseBR baseBR;

		private GeneralConstant generalConstant = GeneralConstant.CreateInstance();
		private WindowsUIConstant windowsUiConstant = WindowsUIConstant.CreateInstance();

		protected BaseBR BusinessRule
		{
			get { return baseBR; }
			set { baseBR = value; }
		}

		protected GeneralConstant GRConstant
		{
			get { return generalConstant; }
		}

		protected WindowsUIConstant UIConstant
		{
			get { return windowsUiConstant; }
		}
		#endregion

		#region Public Methods
		/// <summary>
		/// Load data from the database and bind to the UI
		/// </summary>
		public void RefreshPage()
		{            
            try
            {
                LoadDataFromDB();
			    BindDataToUI();
            }
            catch (Exception ex)
            {
                BaseLogger.LogFormUnhandledException(ex, this);
				BaseMessageBox.ShowError(BaseConfiguration.GetSetting(SettingName.DatabaseError), owner: ParentForm);
            }
        }

		/// <summary>
		/// Load data from the UI and save to database
		/// </summary>
		public void SavePage()
		{
            try
            {
			LoadDataFromUI();
			SaveDataToDB();
            }
            catch (Exception ex)
            {
                BaseLogger.LogFormUnhandledException(ex, this);
                BaseMessageBox.ShowError(BaseConfiguration.GetSetting(SettingName.DatabaseError), owner: ParentForm);
            }
        }
		#endregion

		#region Protected Methods
		/// <summary>
		/// Initialize Business Rules object
		/// </summary>
		/// <param name="baseBR"></param>
		protected void InitializeBR(BaseBR businessRule)
		{
			baseBR = businessRule;
		}

		/// <summary>
		/// Load data from the database
		/// </summary>
		protected void LoadDataFromDB()
		{
			if (baseBR != null)
			{
                try
                {
				baseBR.SelectDataSet();
                }
                catch (Exception ex)
                {
                    BaseLogger.LogFormUnhandledException(ex, this);
                    BaseMessageBox.ShowError(BaseConfiguration.GetSetting(SettingName.DatabaseError), owner: ParentForm);
                }
            }
		}

		/// <summary>
		/// Save the data into the database
		/// </summary>
		protected void SaveDataToDB()
		{
			if (baseBR != null)
			{
                try
                {
                baseBR.SaveDataSet();
                }
                catch (Exception ex)
                {
                    BaseLogger.LogFormUnhandledException(ex, this);
                    BaseMessageBox.ShowError(BaseConfiguration.GetSetting(SettingName.DatabaseError), owner: ParentForm);
                }
            }
		}
		#endregion

		#region Protected Virtual Methods
		/// <summary>
		/// Bind the data to the ui
		/// </summary>
		public virtual void BindDataToUI() { }

		/// <summary>
		/// Load the data from the UI
		/// </summary>
		public virtual void LoadDataFromUI() { } 
		#endregion
	}
}
