using Statline.StatTrac.Web.UI;


namespace Statline.StatTrac.Web.UI.Framework.Navigation 
{


	/// <summary>
	///		Summary description for InnerMenuControl.
	/// </summary>
	public partial class InnerMenuControl : Statline.StatTrac.Web.UI.BaseMenuControl
	{
		//protected System.Web.UI.WebControls.DataList menuDataList;
		//protected System.Web.UI.WebControls.DataList menuDataList;
		// commented out on 2/08/07 protected System.Web.UI.WebControls.DataList menuDataList;
	
		private void InitializeComponent()
		{

		}
		
		protected override MenuName SelectedMenuItem
		{
			get
			{
				return BaseMenuControl.SubMenu;
			}
		}

	}

}