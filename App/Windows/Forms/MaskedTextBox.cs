using System;
using System.Data;
using Statline.Stattrac.Windows.UI;

namespace Statline.Stattrac.Windows.Forms
{
	public class MaskedTextBox : System.Windows.Forms.MaskedTextBox
	{
		protected override void OnLayout(System.Windows.Forms.LayoutEventArgs levent)
		{
			this.TextChanged += new EventHandler(TextBox_TextChanged);
			base.OnLayout(levent);
		}

		public void BindDataSet(DataSet ds, string tableName, string columnName)
		{
			if (DataBindings["Text"] == null)
			{
				DataBindings.Add("Text", ds, tableName + "." + columnName);
			}   

		}
        public void BindDataSet(DataView dv, string columnName)
        {
            if (DataBindings["Text"] == null)
            {
                DataBindings.Add("Text", dv, columnName);
            }            
        } 

		private void TextBox_TextChanged(object sender, EventArgs e)
		{
			BaseForm baseForm = FindForm() as BaseForm;
			if (baseForm != null)
			{
				baseForm.DataChanged();
			}
		}
	}
}
