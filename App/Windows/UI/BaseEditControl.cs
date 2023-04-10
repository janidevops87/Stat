using System;
using System.Windows.Forms;
using Statline.Stattrac.Constant;
using Statline.Stattrac.Framework;

namespace Statline.Stattrac.Windows.UI
{
	public partial class BaseEditControl : UserControl
	{
		#region Protected Fields
		/// <summary>
		/// Business Rules object
		/// </summary>
		private BaseBR baseBR;

		protected BaseBR BusinessRule
		{
			get { return baseBR; }
			set { baseBR = value; }
		}


		private GeneralConstant generalConstant = GeneralConstant.CreateInstance();

		protected GeneralConstant GRConstant
		{
			get { return generalConstant; }
		}
		#endregion

		#region Constructor
		/// <summary>
		/// Initilize parameters
		/// </summary>
		public BaseEditControl()
		{
			InitializeComponent();
            
		}
		#endregion

		#region Protected Virtual Methods
        /// <summary>
		/// Initilize Business Rules object
		/// </summary>
		/// <param name="baseBR"></param>
		public virtual void InitializeBR(BaseBR businessRule)
		{
			baseBR = businessRule;
		}

		/// <summary>
		/// Bind the data to the ui
		/// </summary>
		public virtual void BindDataToUI() { }

		/// <summary>
		/// Load the data from the UI
		/// </summary>
		public virtual void LoadDataFromUI() { } 
		#endregion

        #region Events
        private void BaseEditControl_Load(object sender, EventArgs e)
        {
            HScroll = false;
         
        }
        #endregion
    }
}
