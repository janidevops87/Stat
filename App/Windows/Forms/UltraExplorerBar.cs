using System;
using Infragistics.Win.UltraWinExplorerBar;
using Infragistics.Win;
using System.Data;

namespace Statline.Stattrac.Windows.Forms
{
	public partial class UltraExplorerBar : Infragistics.Win.UltraWinExplorerBar.UltraExplorerBar
	{
		#region Constructor
		/// <summary>
		/// Initilizes the default values
		/// </summary>
		public UltraExplorerBar()
		{
			AnimationSpeed = AnimationSpeed.Fast;
			AnimationEnabled = false;
			ImageSizeSmall = new System.Drawing.Size(0, 0);
			GroupSettings.Style = GroupStyle.SmallImagesWithText;
			Style = UltraExplorerBarStyle.Listbar;
			ViewStyle = UltraExplorerBarViewStyle.Office2003;
		}
		#endregion

		#region Public Methods
		/// <summary>
		/// Add a new group with the key
		/// </summary>
		/// <param name="key"></param>
		/// <param name="groupName"></param>
		/// <returns></returns>
		public UltraExplorerBarGroup AddGroup(string key, string groupName)
		{
			return Groups.Add(key, groupName);
		}

		/// <summary>
		/// Add new item in the group
		/// </summary>
		/// <param name="group"></param>
		/// <param name="key"></param>
		/// <param name="itemName"></param>
		public static void AddItem(UltraExplorerBarGroup group, string key, string itemName)
		{
			group.Items.Add(key, itemName);
		}
		#endregion
	}
}
