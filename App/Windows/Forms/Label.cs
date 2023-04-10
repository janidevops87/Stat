using System;
using System.Data;
using System.Drawing;
using System.Windows.Forms;

namespace Statline.Stattrac.Windows.Forms
{
	public class Label : System.Windows.Forms.Label
	{
		public void BindDataSet(DataSet ds, string tableName, string columnName)
		{
			if (DataBindings["Text"] == null)
			{
				DataBindings.Add("Text", ds, tableName + "." + columnName);
			}
		}

		private LabelStyle labelStyle;

		public LabelStyle LabelStyle
		{
		  get { return labelStyle; }
		  set { labelStyle = value; }
		}

		protected override void OnLayout(LayoutEventArgs levent)
		{
			switch (labelStyle)
			{
				case LabelStyle.None:
                    this.Font = new Font("Tahoma", 8F);
					break;
				case LabelStyle.NormalBlue:
                    this.Font = new Font("Tahoma", 8F);
					this.ForeColor = Color.Blue;
					break;
				case LabelStyle.NormalRed:
                    this.Font = new Font("Tahoma", 8F);
					this.ForeColor = Color.Red;
					break;
				case LabelStyle.Bold:
					this.Font = new Font("Tahoma", 8F, FontStyle.Bold);
					break;
				default:
					break;
			}
		}
	}

	public enum LabelStyle
	{
		None = 0,
		NormalBlue = 1,
		NormalRed = 2,
		Bold = 3
	}
}
