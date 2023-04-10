using System;
using Statline.Stattrac.Constant;
using System.Data;

namespace Statline.Stattrac.Windows.Forms
{
	public class DateTimePicker : System.Windows.Forms.DateTimePicker
	{
		private WindowsConstant windowsConstant;

		public DateTimePicker()
		{
			Format = System.Windows.Forms.DateTimePickerFormat.Custom;
			windowsConstant = WindowsConstant.CreateInstance();
			CustomFormat = windowsConstant.DateTimeFormat;
		}

		public new object Value
		{
			get
			{
				if (base.Value == windowsConstant.DateTimeNull)
					return DBNull.Value;
				else
					return base.Value;
			}
			set
			{
				try
				{
					base.Value = DateTime.Parse(value.ToString());
					CustomFormat = windowsConstant.DateTimeFormat;
				}
				catch (Exception)
				{
					CustomFormat = windowsConstant.DateTimeNullFormat;
					base.Value = windowsConstant.DateTimeNull;
				}
			}
		}

		protected override void OnCloseUp(EventArgs eventargs)
		{
			if (MouseButtons == System.Windows.Forms.MouseButtons.None)
			{
				CustomFormat = windowsConstant.DateTimeFormat;
			}
			base.OnCloseUp(eventargs);
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
