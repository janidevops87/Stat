using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using Statline.Stattrac.Data.Types.ScreenConfig;
using Statline.Stattrac.BusinessRules.ScreenConfig;
using Infragistics.Win.UltraWinGrid;
using Statline.Stattrac.Windows.Forms;
using Statline.Stattrac.Constant;

namespace Statline.Stattrac.Windows.UI.Controls.Administration.ScreenConfig
{
    public partial class MoreDataControl : Statline.Stattrac.Windows.UI.BaseEditControl
    {
        private ScreenConfigNavigation screenConfigNavigation;
        private CurrencyManager _currencyManager;


        public ScreenConfigNavigation ScreenConfigNavigation
        {
            get { return screenConfigNavigation; }
            set { screenConfigNavigation = value; }
        }
        public MoreDataControl()
        {
            InitializeComponent();
            addItemControl1.MoreDataControl = this;
        }

         public override void BindDataToUI()
        {
            string serviceLevelID = ScreenConfigNavigation.callBackScreenConfig();

            Hashtable paramList = new Hashtable();
            paramList.Add("ServiceLevelID", serviceLevelID);
            
            cbDisplayMoreData.BindData("DisplayScreenListSelect");
            
            ScreenConfigDS screenConfigDS = (ScreenConfigDS)BusinessRule.AssociatedDataSet;

            _currencyManager = (CurrencyManager)BindingContext[screenConfigDS, screenConfigDS.ServiceLevelCustomField.TableName];
            _currencyManager.Position = screenConfigDS.ServiceLevelCustomField.Rows.IndexOf(screenConfigDS.ServiceLevelCustomField.FindByServiceLevelID(Convert.ToInt32(serviceLevelID)));

            txtCustomText.BindDataSet(screenConfigDS, "ServiceLevelCustomField", screenConfigDS.ServiceLevelCustomField.ServiceLevelCustomTextAlertColumn.ColumnName);
            txtCustomList.BindDataSet(screenConfigDS, "ServiceLevelCustomField", screenConfigDS.ServiceLevelCustomField.ServiceLevelCustomListAlertColumn.ColumnName);
            txtCustomLabel9.BindDataSet(screenConfigDS, "ServiceLevelCustomField", screenConfigDS.ServiceLevelCustomField.ServiceLevelCustomFieldLabel9Column.ColumnName);
            if (!string.IsNullOrEmpty(txtCustomLabel9.Text))
            {
                cbCustomLabel9.BindData("ServiceLevelCustomListListSelect9", paramList);
                cbCustomLabel9.Enabled = true;
                btnAddCustomLabel9.Enabled = true;
                btnDelCustomLabel9.Enabled = true;
            }
            else
            {
                cbCustomLabel9.Text = null;
                cbCustomLabel9.Enabled = false;
                btnAddCustomLabel9.Enabled = false;
                btnDelCustomLabel9.Enabled = false;
            }
            txtCustomLabel10.BindDataSet(screenConfigDS, "ServiceLevelCustomField", screenConfigDS.ServiceLevelCustomField.ServiceLevelCustomFieldLabel10Column.ColumnName);
            if (!string.IsNullOrEmpty(txtCustomLabel10.Text))
            {
                cbCustomLabel10.BindData("ServiceLevelCustomListListSelect10", paramList);
                cbCustomLabel10.Enabled = true;
                btnAddCustomLabel10.Enabled = true;
                btnDelCustomLabel10.Enabled = true;
            }
            else
            {
                cbCustomLabel10.Text = null;
                cbCustomLabel10.Enabled = false;
                btnAddCustomLabel10.Enabled = false;
                btnDelCustomLabel10.Enabled = false;
            }
            txtCustomLabel11.BindDataSet(screenConfigDS, "ServiceLevelCustomField", screenConfigDS.ServiceLevelCustomField.ServiceLevelCustomFieldLabel11Column.ColumnName);
            if (!string.IsNullOrEmpty(txtCustomLabel11.Text))
            {
                cbCustomLabel11.BindData("ServiceLevelCustomListListSelect11", paramList);
                cbCustomLabel11.Enabled = true;
                btnAddCustomLabel11.Enabled = true;
                btnDelCustomLabel11.Enabled = true;
            }
            else
            {
                cbCustomLabel11.SelectedText = null;
                cbCustomLabel11.Enabled = false;
                btnAddCustomLabel11.Enabled = false;
                btnDelCustomLabel11.Enabled = false;
            }
            txtCustomLabel12.BindDataSet(screenConfigDS, "ServiceLevelCustomField", screenConfigDS.ServiceLevelCustomField.ServiceLevelCustomFieldLabel12Column.ColumnName);
            if (!string.IsNullOrEmpty(txtCustomLabel12.Text))
            {
                cbCustomLabel12.BindData("ServiceLevelCustomListListSelect12", paramList);
                cbCustomLabel12.Enabled = true;
                btnAddCustomLabel12.Enabled = true;
                btnDelCustomLabel12.Enabled = true;
            }
            else
            {
                cbCustomLabel12.SelectedText = null;
                cbCustomLabel12.Enabled = false;
                btnAddCustomLabel12.Enabled = false;
                btnDelCustomLabel12.Enabled = false;
            }
            txtCustomLabel13.BindDataSet(screenConfigDS, "ServiceLevelCustomField", screenConfigDS.ServiceLevelCustomField.ServiceLevelCustomFieldLabel13Column.ColumnName);
            if (!string.IsNullOrEmpty(txtCustomLabel13.Text))
            {
                cbCustomLabel13.BindData("ServiceLevelCustomListListSelect13", paramList);
                cbCustomLabel13.Enabled = true;
                btnAddCustomLabel13.Enabled = true;
                btnDelCustomLabel13.Enabled = true;
            }
            else
            {
                cbCustomLabel13.SelectedText = null;
                cbCustomLabel13.Enabled = false;
                btnAddCustomLabel13.Enabled = false;
                btnDelCustomLabel13.Enabled = false;
            }
            txtCustomLabel14.BindDataSet(screenConfigDS, "ServiceLevelCustomField", screenConfigDS.ServiceLevelCustomField.ServiceLevelCustomFieldLabel14Column.ColumnName);
            if (!string.IsNullOrEmpty(txtCustomLabel14.Text))
            {
                cbCustomLabel14.BindData("ServiceLevelCustomListListSelect14", paramList);
                cbCustomLabel14.Enabled = true;
                btnAddCustomLabel14.Enabled = true;
                btnDelCustomLabel14.Enabled = true;
            }
            else
            {
                cbCustomLabel14.SelectedText = null;
                cbCustomLabel14.Enabled = false;
                btnAddCustomLabel14.Enabled = false;
                btnDelCustomLabel14.Enabled = false;
            }
            txtCustomLabel15.BindDataSet(screenConfigDS, "ServiceLevelCustomField", screenConfigDS.ServiceLevelCustomField.ServiceLevelCustomFieldLabel15Column.ColumnName);
            if (!string.IsNullOrEmpty(txtCustomLabel15.Text))
            {
                cbCustomLabel15.BindData("ServiceLevelCustomListListSelect15", paramList);
                cbCustomLabel15.Enabled = true;
                btnAddCustomLabel15.Enabled = true;
                btnDelCustomLabel15.Enabled = true;
            }
            else
            {
                cbCustomLabel15.SelectedText = null;
                cbCustomLabel15.Enabled = false;
                btnAddCustomLabel15.Enabled = false;
                btnDelCustomLabel15.Enabled = false;
            }
            txtCustomLabel16.BindDataSet(screenConfigDS, "ServiceLevelCustomField", screenConfigDS.ServiceLevelCustomField.ServiceLevelCustomFieldLabel16Column.ColumnName);
            if (!string.IsNullOrEmpty(txtCustomLabel16.Text))
            {
                cbCustomLabel16.BindData("ServiceLevelCustomListListSelect16", paramList);
                cbCustomLabel16.Enabled = true;
                btnAddCustomLabel16.Enabled = true;
                btnDelCustomLabel16.Enabled = true;
            }
            else
            {
                cbCustomLabel16.SelectedText = null;
                cbCustomLabel16.Enabled = false;
                btnAddCustomLabel16.Enabled = false;
                btnDelCustomLabel16.Enabled = false;
            }
         }

        private void btnAddCustomLabel9_Click(object sender, EventArgs e)
        {
            handleAddButton(9);
        }

        private void btnAddCustomLabel10_Click(object sender, EventArgs e)
        {
            handleAddButton(10);
        }

        private void btnAddCustomLabel11_Click(object sender, EventArgs e)
        {
            handleAddButton(11);
        }

        private void btnAddCustomLabel12_Click(object sender, EventArgs e)
        {
            handleAddButton(12);
        }

        private void btnAddCustomLabel13_Click(object sender, EventArgs e)
        {
            handleAddButton(13);
        }

        private void btnAddCustomLabel14_Click(object sender, EventArgs e)
        {
            handleAddButton(14);
        }

        private void btnAddCustomLabel15_Click(object sender, EventArgs e)
        {
            handleAddButton(15);
        }

        private void btnAddCustomLabel16_Click(object sender, EventArgs e)
        {
            handleAddButton(16);
        }

        private void handleAddButton(int comboxBoxID)
        {
            addItemControl1.Show();
            addItemControl1.Focus();
            GRConstant.ComboBoxID = comboxBoxID;
        }

        private void btnDelCustomLabel9_Click(object sender, EventArgs e)
        {
            if (cbCustomLabel9.SelectedIndex < 1 || cbCustomLabel9.SelectedItem == null)
                return;
            deleteItem(Convert.ToInt32(cbCustomLabel9.SelectedValue.ToString()));
        }

        private void btnDelCustomLabel10_Click(object sender, EventArgs e)
        {
            if (cbCustomLabel10.SelectedIndex < 1 || cbCustomLabel10.SelectedItem == null)
                return;
            deleteItem(Convert.ToInt32(cbCustomLabel10.SelectedValue.ToString()));
        }

        private void btnDelCustomLabel11_Click(object sender, EventArgs e)
        {
            if (cbCustomLabel11.SelectedIndex < 1 || cbCustomLabel11.SelectedItem == null)
                return;
            deleteItem(Convert.ToInt32(cbCustomLabel11.SelectedValue.ToString()));
        }

        private void btnDelCustomLabel12_Click(object sender, EventArgs e)
        {
            if (cbCustomLabel12.SelectedIndex < 1 || cbCustomLabel12.SelectedItem == null)
                return;
            deleteItem(Convert.ToInt32(cbCustomLabel12.SelectedValue.ToString()));
        }

        private void btnDelCustomLabel13_Click(object sender, EventArgs e)
        {
            if (cbCustomLabel13.SelectedIndex < 1 || cbCustomLabel13.SelectedItem == null)
                return;
            deleteItem(Convert.ToInt32(cbCustomLabel13.SelectedValue.ToString()));
        }

        private void btnDelCustomLabel14_Click(object sender, EventArgs e)
        {
            if (cbCustomLabel14.SelectedIndex < 1 || cbCustomLabel14.SelectedItem == null)
                return;
            deleteItem(Convert.ToInt32(cbCustomLabel14.SelectedValue.ToString()));
        }

        private void btnDelCustomLabel15_Click(object sender, EventArgs e)
        {
            if (cbCustomLabel15.SelectedIndex < 1 || cbCustomLabel15.SelectedItem == null)
                return;
            deleteItem(Convert.ToInt32(cbCustomLabel15.SelectedValue.ToString()));
        }

        private void btnDelCustomLabel16_Click(object sender, EventArgs e)
        {
            if (cbCustomLabel16.SelectedIndex < 1 || cbCustomLabel16.SelectedItem == null)
                return;
            deleteItem(Convert.ToInt32(cbCustomLabel16.SelectedValue.ToString()));
        }

        public void addItem()
        {
            string serviceLevelID = ScreenConfigNavigation.callBackScreenConfig();
            ScreenConfigDS screenConfigDS = (ScreenConfigDS)BusinessRule.AssociatedDataSet;
            ScreenConfigDS.ServiceLevelCustomListRow row = screenConfigDS.ServiceLevelCustomList.NewServiceLevelCustomListRow();
            row.ServiceLevelID = Convert.ToInt32(serviceLevelID);
            row.ServiceLevelListField = Convert.ToInt16(GRConstant.ComboBoxID);
            row.ServiceLevelListItem = GRConstant.ComboBoxValue;
            row.LastModified = GRConstant.CurrentDateTime;
            screenConfigDS.ServiceLevelCustomList.Rows.Add(row);
            //BindDataToUI();
            //base.BindDataToUI();
        }

        public void deleteItem(int serviceLevelCustomListID)
        {
            ScreenConfigDS screenConfigDS = (ScreenConfigDS)BusinessRule.AssociatedDataSet;
            int rowPosition = screenConfigDS.ServiceLevelCustomList.Rows.IndexOf(screenConfigDS.ServiceLevelCustomList.FindByServiceLevelCustomListID(serviceLevelCustomListID));
            screenConfigDS.ServiceLevelCustomList.Rows.RemoveAt(rowPosition);
            //BindDataToUI();
            //base.BindDataToUI();
        }
    }
}
