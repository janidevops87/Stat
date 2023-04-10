using System;
using System.Collections.ObjectModel;
using System.Windows.Forms;
using Statline.Stattrac.Constant;
using Statline.Stattrac.Framework;

namespace Statline.Stattrac.Windows.UI
{
    public partial class BaseManagerControl : UserControl
    {
        private BaseForm baseForm;
        #region Fields
        /// <summary>
        /// Used to bind the UI controls to the dataset
        /// </summary>
        private Collection<BindingSource> bindingSourceList;

        /// <summary>
        /// Business Rules object associated with the control
        /// </summary>
        private BaseBR baseBR;

        /// <summary>
        /// Contains Constants that may be usefull to the object
        /// </summary>
        private GeneralConstant generalConstant;

        /// <summary>
        /// Determines if form allows edits
        /// </summary>
        private Boolean readOnly = false;

        #endregion
        
        #region Constructor
        /// <summary>
        /// Initilize parameters
        /// </summary>
        public BaseManagerControl()
        {
            InitializeComponent();
            baseForm = FindForm() as BaseForm;
            generalConstant = GeneralConstant.CreateInstance();
            Layout += new LayoutEventHandler(BaseManagerControl_Layout);
        }
        #endregion

        #region Properties
        /// <summary>
        /// Determines if form allows edits.
        /// </summary>
        protected Boolean ReadOnly
        {
            get { return readOnly; }
            set { readOnly = value; }
        }

        /// <summary>
        /// Determines if form is saved
        /// </summary>
        public string IsSaved
        {
            get { return btnSave.Text; }
            set { btnSave.Text = value; }
        }

        /// <summary>
        /// Business Rules object associated with the control
        /// </summary>
        protected BaseBR BusinessRule
        {
            get { return baseBR; }
            set
            {
                // Whne this property is set go ahead and bind the value to the controls
                baseBR = value;
                bindingSourceList = new Collection<BindingSource>();
                for (int tableIndex = 0; tableIndex < baseBR.AssociatedDataSet.Tables.Count; tableIndex++)
                {
                    BindingSource bindingSource = new BindingSource(baseBR.AssociatedDataSet, baseBR.AssociatedDataSet.Tables[tableIndex].TableName);
                    bindingSourceList.Add(bindingSource);
                }
            }
        }

        /// <summary>
        /// Contains Constants that may be usefull to the object
        /// </summary>
        protected GeneralConstant GRConstant
        {
            get { return generalConstant; }
        }

        /// <summary>
        /// Get access to the Pale that contains all the controls
        /// </summary>
        protected Statline.Stattrac.Windows.Forms.Panel MainBody
        {
            get { return pnlBody; }
            set { pnlBody = value; }
        }
        #endregion

        #region Methods Protected
        /// <summary>
        /// Enable or disable teh save Button
        /// </summary>
        /// <param name="isEnable"></param>
        protected void EnableSaveButton(bool isEnable)
        {
            btnSave.Enabled = isEnable;
        }
        #endregion

        #region Methods Virtual
        /// <summary>
        /// Update the parameters when the control comes into view
        /// </summary>
        protected virtual void UpdateParameters() { }

        /// <summary>
        /// Navigate Back To Parent Control
        /// </summary>
        protected virtual void NavigateBackToParent() { }

        /// <summary>
        /// Load the data from the database
        /// </summary>
        protected virtual void LoadDataFromDB()
        {
            if (baseBR != null)
            {
                baseBR.SelectDataSet();
            }
        }

        /// <summary>
        /// Save the data into the database
        /// </summary>
        protected virtual void SaveDataToDB()
        {
            if (baseBR != null)
            {
                baseBR.SaveDataSet();
            }
        }

        /// <summary>
        /// Bind the data to the ui
        /// </summary>
        protected virtual void BindDataToUI() { }

        /// <summary>
        /// Load the data from the UI
        /// </summary>
        protected virtual void LoadDataFromUI() { }

        /// <summary>
        /// Set the key for the selected Tab
        /// </summary>
        /// <param name="key"></param>
        public virtual void SetSelectedTabItem(string key) { }
        #endregion

        #region Methods Internal
        internal void ChangeButtonToSave()
        {
            if (readOnly)
                return;
            btnSave.Text = "&Save";
        }
        #endregion

        #region Events
        /// <summary>
        /// Layour the control
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void BaseManagerControl_Layout(object sender, LayoutEventArgs e)
        {
            SetBaseManagerControlKey(this.Name);
        }

        private void SetBaseManagerControlKey(string baseManagerControlKey  )
        {
            baseForm = FindForm() as BaseForm;
            if (baseForm != null)
            {
                baseForm.BaseManagerControlKey = baseManagerControlKey;
            }
        }

        /// <summary>
        /// Set the values to the control
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void BaseManagerControl_Load(object sender, EventArgs e)
        {
            UpdateParameters();
            //Bret 5/13/11 added this so that when Organization is opened from VB Forms using SecurePopupForm Save/Close is Close
            SetBaseManagerControlKey(null);
            LoadDataFromDB();
            BindDataToUI();
            //Bret 5/13/11 added this to renable functionality, allowing Close to change to Save if data is changed.
            SetBaseManagerControlKey(this.Name);
        }

        /// <summary>
        /// Save button is clicked
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btnSave_Click(object sender, EventArgs e)
        {         
            if (btnSave.Text.Contains("Save"))
            {
                if (!readOnly && !ValidateChildren())
                {
                    if (!readOnly && !ValidateChildren())
                    return;
                }
                    

                for (int index = 0; index < bindingSourceList.Count; index++)

                {
                    bindingSourceList[index].EndEdit();
                }
                
                LoadDataFromUI();
                SaveDataToDB();
                LoadDataFromDB();
                BindDataToUI();
                btnSave.Text = "Close";
            }
            else
            {
                
                baseForm.BaseManagerControlKey = null; // set this to null to fix issues with save, close cancel WI 11284
                bindingSourceList.Clear();
                NavigateBackToParent();
            }
        }

		protected void ReLoadDataFromDatabase(object sender, EventArgs e)
		{
			LoadDataFromDB();
			BindDataToUI();
			btnSave.Text = "Close";
		}

        /// <summary>
        /// Requirement 2936: 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void btnCancel_Click(object sender, EventArgs e)
        {
            baseForm.BaseManagerControlKey = null;// set this to null to fix issues with save, close cancel WI 11284
            if (btnSave.Text.Contains("Save"))
            {
                string cancelMessage = "You have unsaved data. Are you sure you want to cancel without saving";

                DialogResult result = BaseMessageBox.ShowQuestion(cancelMessage, string.Empty);
                if (result == DialogResult.OK)
                {
                    NavigateBackToParent();
                }
            }
            else
            {
                NavigateBackToParent();
            }
        }
        #endregion
    }
}
