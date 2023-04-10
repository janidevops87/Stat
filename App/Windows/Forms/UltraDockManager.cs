using System;
using System.Runtime.Serialization;

namespace Statline.Stattrac.Windows.Forms
{
	[Serializable]
	public partial class UltraDockManager : Infragistics.Win.UltraWinDock.UltraDockManager
	{
		#region Constructor
		/// <summary>
		/// Initilizes the default values for the dock manager
		/// </summary>
		public UltraDockManager()
		{
            AnimationEnabled = false;
			AnimationSpeed = Infragistics.Win.UltraWinDock.AnimationSpeed.StandardSpeedPlus5;
			AutoHideDelay = 1;
			CaptionStyle = Infragistics.Win.UltraWinDock.CaptionStyle.Office2003;
			//UnpinnedTabStyle = Infragistics.Win.UltraWinTabs.TabStyle.PropertyPage2003;
			WindowStyle = Infragistics.Win.UltraWinDock.WindowStyle.Office2003;
		}

		protected UltraDockManager(SerializationInfo info, StreamingContext context)
			: base(info, context)
		{
		}
		#endregion
	}
}
