using System;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Statline.StatTrac.Web.UI.MasterPages
{

	/// <summary>
	/// This control contains the content for a particular region
	/// </summary>
	[ToolboxData("<{0}:Content width=300 height=100 runat=server></{0}:Content>")]
	public class Content : PlaceHolder 
	{

		internal string _templateSourceDirectory;

		/// <summary>
		/// Overrides <see cref="Control.PolicySourceDirectory"/>.
		/// </summary>
		public override string TemplateSourceDirectory 
		{
			get 
			{
				return _templateSourceDirectory;
			}
		}
	}
}