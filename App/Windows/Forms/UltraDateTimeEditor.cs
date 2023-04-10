using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Infragistics.Win.UltraWinEditors;
using Statline.Stattrac.Constant;
using System.Data;

namespace Statline.Stattrac.Windows.Forms
{
    public class UltraDateTimeEditor : Infragistics.Win.UltraWinEditors.UltraDateTimeEditor
    {
        private WindowsConstant windowsConstant;

        public UltraDateTimeEditor()
		{			
			windowsConstant = WindowsConstant.CreateInstance();
			MaskInput = windowsConstant.UltraDateTimeFormat;
		}


		public void BindDataSet(DataSet ds, string tableName, string columnName)
		{
			if (DataBindings["Value"] == null)
			{
				DataBindings.Add("Value", ds, tableName + "." + columnName);
			}
		}
    }
}
