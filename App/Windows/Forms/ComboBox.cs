using System;
using System.Data;
using Statline.Stattrac.BusinessRules.Framework;
using Statline.Stattrac.Constant;
using Statline.Stattrac.Windows.UI;
using System.Collections;
using System.ComponentModel;
using System.Drawing;
using Statline.Stattrac.Data.Types.Framework;

namespace Statline.Stattrac.Windows.Forms
{
	public class ComboBox : System.Windows.Forms.ComboBox
	{
        private bool _required;
        #region Properties
        /// <summary>
        /// Determines if the field is Required.
        /// If the field is empty the field is not valid.
        /// </summary>
        [Description("Determines if the field is Required.\nIf the field is empty the field is not valid.")]
        public bool Required
        {
            get { return _required; }
            set { _required = value; }
        }
        #endregion

        public ComboBox()
		{
			AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.SuggestAppend;
			AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems;
			DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.Font = new Font("Tahoma", 8F);
        }
        #region Protected Methods
        protected override void OnLayout(System.Windows.Forms.LayoutEventArgs levent)
		{
                
                //this.Font = new Font("Tahoma", 7F);
                this.SelectedIndexChanged += new EventHandler(ComboBox_SelectedIndexChanged);
                base.OnLayout(levent);
		}
        protected override void OnValidating(CancelEventArgs e)
        {
            if(Required)
            {
                if (SelectedIndex < 1)
                {
                    e.Cancel = true;
                    BackColor = Color.Yellow;
                }
                else
                    BackColor = Color.White;
            }
            base.OnValidating(e);
        }
        #endregion
		private void ComboBox_SelectedIndexChanged(object sender, EventArgs e)
		{
			// When the user select "Select A Value" set it to nothing selected so that it does
			// not insert data that will cause foreign key break
            if (SelectedIndex == 0)
            {
                //SelectedIndex = -1;
            }

			BaseForm baseForm = FindForm() as BaseForm;
			if (baseForm != null)
			{
				baseForm.DataChanged();
			}
		}

		public void BindDataSet(DataSet ds, string tableName, string columnName)
		{
			if (DataBindings["SelectedValue"] == null)
			{
				DataBindings.Add("SelectedValue", ds, tableName + "." + columnName);
			}
		}
        /// <summary>
        /// Takes a paramList of storedProcedure parameters. 
        /// Parameters are passed as strings to the stored procedure 
        /// </summary>
        /// <param name="listName"></param>
        /// <param name="paramList"></param>
        public void BindData(string listName, Hashtable paramList)
        { 
            //if (this.Items.Count == 0)
            //{
                ListControlBR listControlBR = new ListControlBR(listName, paramList);
                ListControlDS listControlDS = (ListControlDS)listControlBR.SelectDataSet();

                BindData(listControlDS);

            //}
        }
        public void BindData(string listName)
		{
			if (this.Items.Count == 0)
			{
				ListControlBR listControlBR = new ListControlBR(listName);
				ListControlDS listControlDS = (ListControlDS)listControlBR.SelectDataSet();
                BindData(listControlDS);
			}
		}

		public void BindOrganizationBySourceCode(int sourceCodeId)
		{
			ListControlBR listControlBR = new ListControlBR("OrganizationBySourceCodeSelect");
			ListControlDS listControlDS = (ListControlDS)listControlBR.SelectOrganizationBySourceCode(sourceCodeId);
            BindData(listControlDS);
		}

		public void BindClinicalCoordinatorByReferralFacility(int organizationId)
		{
			ListControlBR listControlBR = new ListControlBR("ClinicalCoordinatorByReferralFacilitySelect");
			ListControlDS listControlDS = (ListControlDS)listControlBR.SelectClinicalCoordinatorByReferralFacility(organizationId);
            BindData(listControlDS);
		}

		public void BindTransplantSurgeonContactByOrganization(int sourceCodeId, int organizationId)
		{
			ListControlBR listControlBR = new ListControlBR("TransplantSurgeonContactByOrganizationSelect");
			ListControlDS listControlDS = (ListControlDS)listControlBR.SelectTransplantSurgeonContactByOrganization(sourceCodeId, organizationId);
            BindData(listControlDS);
		}

		private void BindData(ListControlDS listControlDS)
		{
			ListControlDS.ListControlRow emptyRow = listControlDS.ListControl.NewListControlRow();
			emptyRow.ListId = 0;
			emptyRow.FieldValue = "Select A Value";
			listControlDS.ListControl.Rows.InsertAt(emptyRow, 0);
			DataSource = listControlDS.ListControl;
			DisplayMember = "FieldValue";
			ValueMember = "ListId";
		}
        
        
	}
}
