using System;
using System.Data;
using Statline.Stattrac.Windows.UI;
using Statline.Stattrac.Framework;
using System.Drawing;

namespace Statline.Stattrac.Windows.Forms
{
	public class CheckBox : System.Windows.Forms.CheckBox
	{
		public void BindDataSet(DataSet ds, string tableName, string columnName)
		{
			if (DataBindings["Checked"] == null)
			{
				DataBindings.Add("Checked", ds, tableName + "." + columnName);
			}
		}

		protected override void OnLayout(System.Windows.Forms.LayoutEventArgs levent)
		{
			this.CheckedChanged += new EventHandler(CheckBox_CheckedChanged);
            this.Font = new Font("Tahoma", 8F);
			base.OnLayout(levent);
		}

		/// <summary>
		/// When the data changes we need to inform the user that data need to be saved
		/// </summary>
		/// <param name="sender"></param>
		/// <param name="e"></param>
		private void CheckBox_CheckedChanged(object sender, EventArgs e)
		{
			BaseForm baseForm = FindForm() as BaseForm;
			if (baseForm != null)
			{
				baseForm.DataChanged();
			}
		}

		/// <summary>
		/// We need to make this an object since doing the DataBindings can potentiallly use DBNull
		/// </summary>
		public new object Checked
		{
			get
			{
				return base.Checked;
			}
			set
			{
				try
				{
					if (value == DBNull.Value)
					{
						base.Checked = false;
					}
					else
					{
                        base.Checked = Convert.ToBoolean(value);
					}
				}
				catch (Exception ex)
				{
                    if (value.ToString() != "1")
                    {
                        BaseLogger.LogFormUnhandledException(ex, this);
                        BaseMessageBox.Show(this.Name + " must bind to a boolean value");
                    }
				}
			}
		}
	}
}
