using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Drawing;
using System.Data;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Collections;
using Infragistics.Win.UltraWinGrid;
using Statline.Stattrac.Windows.UI;
using Statline.Stattrac.Constant;

namespace Statline.Stattrac.Windows.Forms
{
    /// <summary>
    /// AvailableSelectedControl binds the same DataTable to two grids. 
    /// The DataTable must have a column called Hidden. 
    /// The control then will update the visible value for each row in each grid
    /// based on the Hidden value. Set the select sproc should mark any field not select as
    /// Hidden.
    /// </summary>
    [Description(" AvailableSelectedControl binds the same DataTable to two grids.\n The DataTable must have a column called Hidden.\n The control then will update the visible value for each row in each grid\n based on the Hidden value. Set the select sproc should mark any field not select as\n Hidden.")]
    public partial class AvailableSelectedControl : UserControl
    {
        #region Protected Fields
        private GeneralConstant generalConstant = GeneralConstant.CreateInstance();

        protected GeneralConstant GRConstant
        {
            get { return generalConstant; }
        }

        #endregion
        #region Properties
        private string idColumn = "";
        private string textAvailable = "";
        private string textSelected = "";
        private Type _columnList = null;
        
        public string IdColumn
        {
            get { return idColumn; }
            set { idColumn = value; }
        }
        [Description("Name of DataTable to bind to. The table must have a Hidden field. Rows with a Hidden Field of False will display in the selected grid.")]
        public string DataMember 
        {
            get { return ugAvailable.DataMember; }
            set {
                ugAvailable.DataMember = value;
                ugSelected.DataMember = value;
                 }        
        }

        public object DataSource 
        {
            get { return ugAvailable.DataSource; }
            set { 
                ugAvailable.DataSource = value;
                ugSelected.DataSource = value;

                }

        }
        public string TextAvailable
        {
            get { return textAvailable; }
            set { 
                textAvailable = value;
                ugAvailable.Text = value;
            }
        }
        public string TextSelected
        {
            get { return textSelected; }
            set { 
                textSelected = value;
                ugSelected.Text = value;
            }
        }
        [Description("Used to set the Visible columns for a DataTable.\n" +
                "Set before setting DataMember.")]
        public Type ColumnList
        {
            get { return _columnList; }
            set { _columnList = value; }
        }

        #endregion  

        public AvailableSelectedControl()
        {
            InitializeComponent();           

        }

        #region Events        
        private void btnAvailable_Click(object sender, EventArgs e)
        {
            SelectSelected(ugAvailable, ugSelected);                        
        }

        private void btnAvailableAll_Click(object sender, EventArgs e)
        {
            SelectAll(ugAvailable, ugSelected);                        
        }        
        private void btnSelected_Click(object sender, EventArgs e)
        {
            SelectSelected(ugSelected, ugAvailable);
        }
        private void ugAvailable_InitializeLayout(object sender, Infragistics.Win.UltraWinGrid.InitializeLayoutEventArgs e)
        {
            const int band = 0;
            if(String.IsNullOrEmpty(DataMember))
                return;
            DataTable dataMemberTable;
            if(DataSource.GetType().FullName == "System.Data.DataViewManager")
                dataMemberTable = ((DataViewManager) DataSource).DataSet.Tables[DataMember];
            else
                dataMemberTable =  ((DataSet) DataSource).Tables[DataMember];

            if(ColumnList != null && dataMemberTable != null)
                ugAvailable.ColumnDisplay(band, ColumnList, dataMemberTable);
            
            //if the IdColumn is empty set it
            if (IdColumn == "")
                if(ugAvailable.Rows.Count > 0)
                IdColumn = ugAvailable.Rows[GRConstant.FirstRow].Cells[GRConstant.FirstRow].Column.Key;
        }

        private void ugSelected_InitializeLayout(object sender, Infragistics.Win.UltraWinGrid.InitializeLayoutEventArgs e)
        {
            const int band = 0;
            if (String.IsNullOrEmpty(DataMember))
                return;

            DataTable dataMemberTable;
            if(DataSource.GetType().FullName == "System.Data.DataViewManager")
                dataMemberTable = ((DataViewManager)DataSource).DataSet.Tables[DataMember];
            else
                dataMemberTable = ((DataSet)DataSource).Tables[DataMember];


            if (ColumnList != null && dataMemberTable != null)
                ugSelected.ColumnDisplay(band, ColumnList, dataMemberTable);

        }
        #endregion
        #region Private Methods
        /// <summary>
        /// Called when user clicks button to add or remove a setting. Its goal is to update the underlying grid.
        /// </summary>
        private void UpdateDateSet()
        {
            ugSelected.Rows.GetFilteredInNonGroupByRows().ToList().ForEach(delegate(UltraGridRow row) { row.Cells["Hidden"].Value = row.Hidden; });
            ugSelected.UpdateData();
            ugSelected.Update();
            ugAvailable.Update();
        }
        private void RowHide(UltraGridRow row)
        {
            if (row == null)
                return;
            row.Hidden = true;            
        }
        private void RowUnHide(UltraGridRow row)
        {
            if (row == null)
                return;
            row.Hidden = false;            
        }
        private void SetUgSelectedRow(UltraGridRow row)
        {   //Notes:
            //Set Selected
            //In the grid if a row is hidden it will not show on the available side so it needs to be shown on the selected side.                
            if (row.Cells["Hidden"].Value.Equals(false))
                RowHide(row);
            else
                RowUnHide(row);
        }
        private void SetUgAvailableRow(UltraGridRow row)
        {
            //Set Available
            //In the grid if a row is hidden it will not show on the selected side so it needs to be shown on the available side.
            if (row.Cells["Hidden"].Value.Equals(true))
                RowHide(row);
            else
                RowUnHide(row);

        }

        /// <summary>
        /// Hides and UnHides rows in the Available and Selected grids.
        /// Called by the 4 buttons for Setting and Unselecting
        /// The Hidden attribute is analogous to Selected.
        /// When Hidden is true, the item is in the selected grid.
        /// This method uses link
        /// </summary>
        /// <param name="gridHide"></param>
        /// <param name="gridUnHide"></param>
        private void SelectSelected(UltraGrid gridHide, UltraGrid gridUnHide)
        {
            //the delegate command creates and calls a method within this method
            gridHide.Selected.Rows.All.ToList().ForEach(delegate(Object obj)
            {
                UltraGridRow currentRow = (UltraGridRow)obj;
                if (((bool)currentRow.Cells["Hidden"].Value))
                    currentRow.Cells["Hidden"].Value = false;
                else
                    currentRow.Cells["Hidden"].Value = true;

                currentRow.Selected = false;
            });
            this.ugSelected.Rows.All.ToList().ForEach(delegate(Object obj)
            {
                UltraGridRow currentRow = (UltraGridRow)obj;
                SetUgSelectedRow(currentRow);
            });
            ugAvailable.Rows.All.ToList().ForEach(delegate(Object obj)
            {
                UltraGridRow currentRow = (UltraGridRow)obj;
                SetUgAvailableRow(currentRow);
            });
            ugAvailable.UpdateData();
            ugSelected.UpdateData();
            ugSelected.Update();
            ugAvailable.Update();


        }
        /// <summary>
        /// sets all rows non Hidden rows of gridHide to Selected and then calls SelectSelected
        /// 
        /// </summary>
        /// <param name="gridHide"></param>
        /// <param name="gridUnHide"></param>
        private void SelectAll(UltraGrid gridHide, UltraGrid gridUnHide)
        {
            gridHide.Rows.All.ToList().ForEach(delegate(Object obj)
            {
                 UltraGridRow currentRow = (UltraGridRow)obj;
                 if (currentRow.Hidden == false)
                        currentRow.Selected = true;
            });

            SelectSelected(gridHide, gridUnHide);

        }
        #endregion

        private void ugAvailable_ClickCell(object sender, ClickCellEventArgs e)
        {
            e.Cell.Row.Selected = true;
        }

        private void ugAvailable_DoubleClickCell(object sender, DoubleClickCellEventArgs e)
        {
            e.Cell.Row.Selected = true;
            btnAvailable_Click(sender, e);
        }

        private void ugSelected_DoubleClickCell(object sender, DoubleClickCellEventArgs e)
        {
            e.Cell.Row.Selected = true;
            btnSelected_Click(sender, e);
        }

        private void ugSelected_ClickCell(object sender, ClickCellEventArgs e)
        {
            e.Cell.Row.Selected = true;
        }
        private void ugSelected_InitializeRow(object sender, InitializeRowEventArgs e)
        {
            SetUgSelectedRow(e.Row);

        }

        private void ugAvailable_InitializeRow(object sender, InitializeRowEventArgs e)
        {
            SetUgAvailableRow(e.Row);

        }
                
        #region Public Methods
        public void RowFilter(int bands, string columnName, int fieldValue, FilterComparisionOperator filterComparisonOperator)
        {

            if (ugAvailable.DisplayLayout.Bands[bands].Columns.Exists(columnName))
            {
                ugAvailable.DisplayLayout.Bands[bands].ColumnFilters[columnName].FilterConditions.Clear();
                ugAvailable.DisplayLayout.Bands[bands].ColumnFilters[columnName].FilterConditions.Add(filterComparisonOperator, fieldValue);
            }

            if (ugSelected.DisplayLayout.Bands[bands].Columns.Exists(columnName))
            {
                ugSelected.DisplayLayout.Bands[bands].ColumnFilters[columnName].FilterConditions.Clear();
                ugSelected.DisplayLayout.Bands[bands].ColumnFilters[columnName].FilterConditions.Add(filterComparisonOperator, fieldValue);
            }
        }

        #endregion

       private void btnSelectedAll_Click(object sender, EventArgs e)
        {
            SelectAll(ugSelected, ugAvailable);
        }

    }
}
