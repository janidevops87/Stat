using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Linq;
using Infragistics.Win;
using Infragistics.Win.UltraWinGrid;
using Infragistics.Win.UltraWinMaskedEdit;
using Statline.Stattrac.BusinessRules.Framework;
using Statline.Stattrac.Constant;
using Statline.Stattrac.Framework;
using Statline.Stattrac.Windows.UI;
using System.Windows.Forms;
using Statline.Stattrac.Data.Types.Framework;

namespace Statline.Stattrac.Windows.Forms
{
	public class UltraGrid : Infragistics.Win.UltraWinGrid.UltraGrid
	{
		#region Private Fields
		/// <summary>
		/// Type of Grid
		/// </summary>
		private UltraGridType ultraGridType;
		#endregion

		#region Public Properties
		/// <summary>
		/// Type of Grid
		/// </summary>
		public UltraGridType UltraGridType
		{
			set { ultraGridType = value; }
			get { return ultraGridType; }
		}
		#endregion

		#region Protected Overriden Methods
		/// <summary>
		/// Set the Stylesheet
		/// </summary>
		/// <param name="e"></param>
		protected override void OnInitializeLayout(Infragistics.Win.UltraWinGrid.InitializeLayoutEventArgs e)
		{
			base.OnInitializeLayout(e);

            string basePath = @"Styles\";

            // we need to save the text property since it gets cleared when we ApplyPresetFromXml with true
			string text = this.Text;
			switch (ultraGridType)
			{
				case UltraGridType.None:
					ApplyPresetFromXml(basePath + "Blank.xml", true);
					break;
				case UltraGridType.AddEdit:
					ApplyPresetFromXml(basePath + "GridAddEdit.xml", true);
					break;
				case UltraGridType.EditOnly:
					ApplyPresetFromXml(basePath + "GridEditOnly.xml", true);
					break;
				case UltraGridType.ReadOnly:
					ApplyPresetFromXml(basePath + "GridReadOnly.xml", true);
					break;
				case UltraGridType.Search:
					ApplyPresetFromXml(basePath + "GridSearch.xml", true);
					break;
				case UltraGridType.VerticalAddEdit:
					DisplayLayout.Bands[0].CardView = true;
					ApplyPresetFromXml(basePath + "GridVerticalAddEdit.xml", true);
					DisplayLayout.Bands[0].CardSettings.MaxCardAreaRows = 1;
					break;
				case UltraGridType.VerticalEditOnly:
					DisplayLayout.Bands[0].CardView = true;
					ApplyPresetFromXml(basePath + "GridVerticalEditOnly.xml", true);
					DisplayLayout.Bands[0].CardSettings.MaxCardAreaRows = 1;
					break;
				case UltraGridType.VerticalReadOnly:
					DisplayLayout.Bands[0].CardView = true;
					DisplayLayout.Bands[0].CardSettings.MaxCardAreaRows = 1;
                    ApplyPresetFromXml(basePath + "GridVerticalReadOnly.xml", true);
					break;
                case UltraGridType.AddEditSearch:
                    ApplyPresetFromXml(basePath + "GridAddEditSearch.xml", true);
                    break;
				default:
					ApplyPresetFromXml(basePath + "Blank.xml", true);
					break;
			}
			// Appply the Text again
			this.Text = text;

			InitializeLayoutDateTimeColumn();
			AfterRowInsert += new RowEventHandler(UltraGrid_AfterRowModified);
			AfterRowUpdate += new RowEventHandler(UltraGrid_AfterRowModified);
			AfterRowsDeleted += new EventHandler(UltraGrid_AfterRowModified);
			BeforeRowUpdate += new CancelableRowEventHandler(UltraGrid_BeforeRowUpdate);
		}
		#endregion

		#region Private Methods
		/// <summary>
		/// Update the last update date time
		/// </summary>
		/// <param name="sender"></param>
		/// <param name="e"></param>
		private void UltraGrid_BeforeRowUpdate(object sender, CancelableRowEventArgs e)
		{
			if (e.Row.Cells.Exists("LastModified"))
			{
				e.Row.Cells["LastModified"].Value = GeneralConstant.CreateInstance().CurrentDateTime;
			}
			if (e.Row.Cells.Exists("LastUpdateDate"))
			{
				e.Row.Cells["LastUpdateDate"].Value = GeneralConstant.CreateInstance().CurrentDateTime;
			}
		}

		/// <summary>
		/// When the row is modified notify the base form that data has been changed and needs to be saved
		/// </summary>
		/// <param name="sender"></param>
		/// <param name="e"></param>
		private void UltraGrid_AfterRowModified(object sender, EventArgs e)
		{
			BaseForm baseForm = FindForm() as BaseForm;
			if (baseForm != null)
			{
				baseForm.DataChanged();
			}
		}


		/// <summary>
		/// Layout used for all date time columns
		/// </summary>
		private void InitializeLayoutDateTimeColumn()
		{
			for (int bandsIndex = 0; bandsIndex < DisplayLayout.Bands.Count; bandsIndex++)
			{
				UltraGridBand band = DisplayLayout.Bands[bandsIndex];
				for (int columnIndex = 0; columnIndex < band.Columns.Count; columnIndex++)
				{
					UltraGridColumn column = band.Columns[columnIndex];
					if (column.DataType.Name == "DateTime")
					{
						DisplayLayout.Bands[bandsIndex].Columns[columnIndex].Format = "MM/dd/yyyy HH:mm";
                        //DisplayLayout.Bands[bandsIndex].Columns[columnIndex].MaskInput = "MM/dd/yyyy HH:mm";
					}
				}
			}
		}
		#endregion

		#region Public Methods
        /// <summary>
        /// checks a ultragrid cell to determine if it is valid and pops a message if it is not. 
        /// </summary>
        /// <param name="ug"></param>
        /// <returns></returns>
        public Boolean ValidDateTime(UltraGridCell ug)
        {

            Boolean valid = false;
            if (!(ug.Value is DateTime))
            {
                BaseMessageBox.ShowError("Invalid date entered, please enter a valid date to continue.");
                valid = true;
            }

            return valid;

        }


        /// <summary>
        /// Hides all columns in a specific band for a give DataTable
        /// </summary>
        /// <param name="band"></param>
        /// <param name="dataTable"></param>
        [Description("Hides all columns in a specific band for a give DataTable.")]
        public void ColumnDisplay(int band, DataTable dataTable)
        {
            bool hide = true;
            for(int currentColumn = 0; currentColumn < dataTable.Columns.Count; currentColumn++)
            {
                ColumnDisplay(band, true, dataTable.Columns[currentColumn].ColumnName);
            }

        }
        /// <summary>
        /// Changes the Hidden parameter of a given column in specified band
        /// </summary>
        /// <param name="band"></param>
        /// <param name="hide"></param>
        /// <param name="columnName"></param>
        [Description("Changes the Hidden parameter of a given column in specified band.")]
        public void ColumnDisplay(int band, bool hide, string columnName)
        {
            if(DisplayLayout.Bands[band].Columns.Exists(columnName))
                DisplayLayout.Bands[band].Columns[columnName].Hidden = hide;    
                
        }
        /// <summary>
        /// Sets Hidden value for columns based on Statline.StatTrac.Constant.GridColumns enums.
        /// </summary>
        /// <param name="band"></param>
        /// <param name="columnEnum"></param>
        /// <param name="dataTable"></param>
        [Description("Sets Hidden value for columns based on Statline.StatTrac.Constant.GridColumns enums.")]
        public void ColumnDisplay(int band, Type columnEnum, DataTable dataTable)
	    {
            //hide all columns
            ColumnDisplay(band, dataTable);
            
            //show columns from Table Enum
            foreach (int enumItem in System.Enum.GetValues(columnEnum))
            {
                
                ColumnDisplay(band, false, System.Enum.GetName(columnEnum, enumItem));

            }
	    }
        /// <summary>
        /// Used to set a column with a mask where the data uses a non default mask;
        /// </summary>
        /// <param name="ultraGridColumnMask"></param>
        /// <param name="ultraGridColumn"></param>
        [Description("Used to set a column with a mask where the data uses a non default mask.\nDeveloper can add new masks as needed.")]
        public void ColumnMaskSet(UltraGridColumnMask ultraGridColumnMask, UltraGridColumn ultraGridColumn )
        {
            
            switch (ultraGridColumnMask)
            {
                case UltraGridColumnMask.Phone:
                    ultraGridColumn.MaskInput = "(###) ###-####";
                    ultraGridColumn.MaskDataMode = MaskMode.Raw;
                    ultraGridColumn.MaskClipMode = MaskMode.IncludeBoth;
                    ultraGridColumn.MaskDisplayMode = MaskMode.IncludeBoth;
                    break;
                default:
                    break;
            }
        }
		/// <summary>
		/// Bind the data from the sproc into the valuelist
		/// </summary>
		/// <param name="sprocName"></param>
		/// <param name="columnName"></param>
		
        public void BindValueList(string sprocName, string columnName)
		{
			// We only want get the valu list item once to reduce the number of trips to the database
			if (DisplayLayout.Bands[0].Columns[columnName].ValueList == null)
			{
				ListControlBR listControlBR = new ListControlBR(sprocName);
				ListControlDS listControlDS = AssignDataset(listControlBR);;

                ValueList valueList = BuildValueList(listControlBR);

                if (valueList.ValueListItems.Count > 0)
                    DisplayLayout.Bands[0].Columns[columnName].ValueList = valueList;
                else
                    DisplayLayout.Bands[0].Columns[columnName].ValueList = null;

                DisplayLayout.Bands[0].Columns[columnName].Style = Infragistics.Win.UltraWinGrid.ColumnStyle.DropDownList;
			}
		}
        public void BindValueList(string sprocName, string columnName, Hashtable paramList)
        {
            ListControlBR listControlBr = new ListControlBR(sprocName, paramList);
            ValueList valueList = BuildValueList(listControlBr);
            if (valueList.ValueListItems.Count > 0)
                DisplayLayout.Bands[0].Columns[columnName].ValueList = valueList;
            else
                DisplayLayout.Bands[0].Columns[columnName].ValueList = null;

            DisplayLayout.Bands[0].Columns[columnName].Style = Infragistics.Win.UltraWinGrid.ColumnStyle.DropDownList;
        }
        /// <summary>
        /// Bind the data from 
        /// </summary>
        /// <param name="sprocName"></param>
        /// <param name="idColumn"></param>
        /// <param name="dataTable"></param>
        /// <param name="displayColumn"></param>
		public void BindValueList(string sprocName, string idColumn, DataTable dataTable, string displayColumn)
		{
			// We only want get the valu list item once to reduce the number of trips to the database
			if (DisplayLayout.Bands[0].Columns[idColumn].ValueList == null)
			{

				//query for the list
                ListControlBR listControlBR = new ListControlBR(sprocName);
                ListControlDS listControlDS = AssignDataset(listControlBR);
                BuildValueList(listControlBR, dataTable, idColumn, displayColumn);                
                ValueList valueList = BuildValueList(listControlBR);
                
                

                //add the values
                DisplayLayout.Bands[0].Columns[idColumn].ValueList = valueList;
                DisplayLayout.Bands[0].Columns[idColumn].Style = Infragistics.Win.UltraWinGrid.ColumnStyle.DropDownList;

			}
		}
        //determines whether to requery the db
        private ListControlDS AssignDataset(ListControlBR listControlBR)
        {
            
            ListControlDS listControlDS;
            if (((ListControlDS)listControlBR.AssociatedDataSet).ListControl.Count == 0)
                listControlDS = (ListControlDS)listControlBR.SelectDataSet();
            else
                listControlDS = (ListControlDS)listControlBR.AssociatedDataSet;

            return listControlDS;
        }
        /// <summary>
        /// Bind the data from db with ParamList
        /// </summary>
        /// <param name="sprocName"></param>
        /// <param name="idColumn"></param>
        /// <param name="dataTable"></param>
        /// <param name="displayColumn"></param>
        /// <param name="paramList"></param>
        public void BindValueList(string sprocName, string idColumn, DataTable dataTable, string displayColumn, Hashtable paramList)
        {
            ListControlBR listControlBr = new ListControlBR(sprocName, paramList);
            BuildValueList(listControlBr, dataTable, idColumn, displayColumn);
            ValueList valueList = BuildValueList(listControlBr);
            
            if (valueList.ValueListItems.Count > 0)
                DisplayLayout.Bands[0].Columns[idColumn].ValueList = valueList;
            else
                DisplayLayout.Bands[0].Columns[idColumn].ValueList = null;

            DisplayLayout.Bands[0].Columns[idColumn].Style = Infragistics.Win.UltraWinGrid.ColumnStyle.DropDownList;

        }

        /// <summary>
        /// Loops through the dataTable and adds values to the value list that do not exist.
        /// </summary>
        /// <param name="valueList"></param>
        /// <param name="dataTable"></param>
        /// <param name="idColumn"></param>
        /// <param name="displayColumn"></param>
        private void BuildValueList(BaseBR listControlBr, DataTable dataTable, string idColumn, string displayColumn)
        {
            for (int rowIndex = 0; rowIndex < dataTable.Rows.Count; rowIndex++)
            {
                ListControlDS listControlDs = AssignDataset((ListControlBR)listControlBr);
                DataRow row = dataTable.Rows[rowIndex];
                if (row[idColumn] != null)
                {
                    if (row[idColumn].ToString() != String.Empty)
                    {

                        if (!listControlDs.ListControl.ToList().Exists(item => item.ListId == (int)row[idColumn]))
                            listControlDs.ListControl.AddListControlRow((int)row[idColumn], row[displayColumn].ToString());
                            
                    }
                }
            }
        }
        private ValueList BuildValueList(BaseBR listControlBr )
        {
            ListControlDS listControlDs = AssignDataset((ListControlBR)listControlBr);
            ValueList valueList = new ValueList();
            foreach (ListControlDS.ListControlRow listControlRow in listControlDs.ListControl)
            {
                valueList.ValueListItems.Add(listControlRow.ListId, listControlRow.FieldValue);
            }

            return valueList;
            
        }
    	#endregion
	}
}
