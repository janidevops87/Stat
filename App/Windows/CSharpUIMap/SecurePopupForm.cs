using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using Statline.Stattrac.BusinessRules.Framework;
using Statline.Stattrac.Constant;
using Statline.Stattrac.Security;
using Statline.Stattrac.Windows.Controls.Organization;
using Statline.Stattrac.Windows.Controls.Administration;
using Statline.Stattrac.Windows.Controls.Administration.SourceCode;
using Statline.Stattrac.Data.Types.Framework;


namespace Statline.Stattrac.Windows.CSharpUIMap
{
    public partial class SecurePopupForm : Statline.Stattrac.Windows.UI.BaseForm
    {
        #region Private Fields
        private AppScreenDS dataSet;
        private AppScreenBR br;
        private GeneralConstant generalConstant = GeneralConstant.CreateInstance();
        private UserControl selectedUserControl;
        private AppScreenType selectedType;
        private SecurityHelper securityHelper;
        #endregion
        #region Constructor
        /// <summary>
        /// 
        /// </summary>
        public SecurePopupForm()
        {
            InitializeComponent();
            br = new AppScreenBR();
            dataSet = (AppScreenDS)br.SelectDataSet();
            InitializeSecurityHelper();
        }
        #endregion
        public override void LoadSubControl(AppScreenType groupType, AppScreenType screenTypes)
        {
            DisplayPanel(((int)groupType).ToString(generalConstant.StattracCulture),
                ((int)screenTypes).ToString(generalConstant.StattracCulture));
        }
        /// <summary>
        /// Display the control based on the event
        /// </summary>
        /// <param name="groupKey"></param>
        /// <param name="itemKey"></param>
        private void DisplayPanel(string groupKey, string itemKey)
        {

            // Only change the panel if the item key exists
            if (itemKey != null)
            {
                // Create the control based on the itemKey
                selectedType = (AppScreenType)int.Parse(itemKey, generalConstant.StattracCulture);
                CreateControlInstance(selectedType);
                // Remove previous controls and add a new control
                pnlBody.Controls.Clear();
                AutoSize = false;
                Width = selectedUserControl.Width;
                Height = selectedUserControl.Height;

                if (selectedUserControl != null)
                {
                    pnlBody.Controls.Add(selectedUserControl);
                }
            }
        }        
        /// <summary>
        /// Gets the usercontrol that is associated with the AppScreenType
        /// </summary>
        /// <param name="selectedType"></param>
        /// <returns></returns>
        private void CreateControlInstance(AppScreenType selectedType)
        {
            InitializeSecurityHelper();

            //this code is causing the timer datasets to blow up jth 10/20/10...don't know if we need it
            if (selectedUserControl != null)
            {
                //After disposing the object we want to call the garbage collection 
                //explicitly to clear up the resources
                selectedUserControl.Dispose();
                //GC.Collect();
                //GC.WaitForPendingFinalizers();
            }

            switch (selectedType)
            {

                case AppScreenType.OrganizationsOrganizationEdit:
                    selectedUserControl = new OrganizationEditManager();
                    break;
                case AppScreenType.SourceCodeSourceCode:
                    selectedUserControl = new SourceCodeEditManager();
                    break;
                //case AppScreenType.OrganizationsOrganizationDelete:
                //    selectedUserControl = new OrganizationDeleteControl();
                //    break;
                default:
                    selectedUserControl = new UserControl();
                    break;
            }

            selectedUserControl.Dock = System.Windows.Forms.DockStyle.Fill;

        }
        /// <summary>
        /// Check the local instance of securityHelper and gets the singleton version if null
        /// </summary>
        private void InitializeSecurityHelper()
        {            
            if (securityHelper == null)
                securityHelper = SecurityHelper.GetInstance();
        }
    }
}
