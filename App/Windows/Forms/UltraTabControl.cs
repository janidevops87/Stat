using System;
using Infragistics.Win.UltraWinTabControl;
using System.Windows.Forms;
using Statline.Stattrac.Constant;

namespace Statline.Stattrac.Windows.Forms
{
	public class UltraTabControl : Infragistics.Win.UltraWinTabControl.UltraTabControl
	{
		#region Private Fields
		private GeneralConstant generalConstant = GeneralConstant.CreateInstance();
		#endregion

		#region Public Methods
		/// <summary>
		/// Add a tab item with the associated control
		/// </summary>
		/// <param name="appScreenType"></param>
		/// <param name="displayValue"></param>
		/// <param name="control"></param>
		public void AddTabItem(AppScreenType appScreenType, string displayValue, Control control)
		{
			string key = ((int)appScreenType).ToString(generalConstant.StattracCulture);
			UltraTab tab = Tabs.Add(key, displayValue);
			if (control != null)
			{
				control.Dock = DockStyle.Fill;
				// Only add the tabpage if it does not alredy exist becuase creating a new one causes some rendering issue
				if (tab.TabPage == null)
				{
					tab.TabPage = new Infragistics.Win.UltraWinTabControl.UltraTabPageControl();
				}
				// Clear the controls and add the new contrsl
				tab.TabPage.Controls.Clear();
				tab.TabPage.Controls.Add(control);
				Controls.Add(tab.TabPage);
			}
		}

		protected override void OnSelectedTabChanged(SelectedTabChangedEventArgs e)
		{
			base.OnSelectedTabChanged(e);
			// Set the first item in the page with focus
			for (int index = 0; index < e.Tab.TabPage.Controls.Count; index++)
			{
				if (e.Tab.TabPage.Controls[index].TabStop)
				{
					e.Tab.TabPage.Controls[index].Focus();
					break;
				}
			}
		}
		#endregion
	}
}
