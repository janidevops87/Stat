using System;
using System.Drawing;

namespace Statline.Stattrac.Windows.Forms
{
	public class ListBox : System.Windows.Forms.ListBox
	{

        protected override void OnLayout(System.Windows.Forms.LayoutEventArgs levent)
        {
            this.Font = new Font("Tahoma", 8F);
            base.OnLayout(levent);
        }
	}
}
