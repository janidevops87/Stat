using System;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Windows.Forms;
using Statline.Stattrac.Constant;
using Statline.Stattrac.Windows.UI;
using Infragistics.Win.UltraWinSpellChecker;

namespace Statline.Stattrac.Windows.Forms
{
	public class RadioButton : System.Windows.Forms.RadioButton
	{
		protected override void OnLayout(System.Windows.Forms.LayoutEventArgs levent)
		{
			this.CheckedChanged += new EventHandler(RadioButton_CheckedChanged);
			base.OnLayout(levent);
		}

		void RadioButton_CheckedChanged(object sender, EventArgs e)
		{
			BaseForm baseForm = FindForm() as BaseForm;
			if (baseForm != null)
			{
				baseForm.DataChanged();
			}
		}

        public void BindDataSet(DataSet ds, string tableName, string columnName)
        {
            if (DataBindings["Checked"] == null)
            {
                DataBindings.Add("Checked", ds, tableName + "." + columnName);
            }
        }
	}
}
