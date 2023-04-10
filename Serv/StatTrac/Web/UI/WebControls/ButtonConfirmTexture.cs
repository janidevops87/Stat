using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.ComponentModel;

namespace Statline.StatTrac.Web.UI.WebControls
{

	[ToolboxData("<{0}:ButtonConfirmTexture runat=server></{0}:ButtonConfirmTexture>")]
	public class ButtonConfirmTexture : Statline.StatTrac.Web.UI.WebControls.ButtonConfirm
	{

		/// <summary>
		/// The default constructor.
		/// </summary>
		public ButtonConfirmTexture() : base()
		{
		}

		protected override void Render(HtmlTextWriter writer)
		{

			writer.Write( "<table height=\"20\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\n" );
			writer.Write( "<tr align=\"center\" valign=\"middle\">\n" );
			writer.Write( "<td width=\"11\"><img src=\"Images/Buttons/formButton-LeftEnd.gif\" width=\"11\" height=\"20\"></td>\n" );
			writer.Write( "<td width=\"*\" background=\"Images/Buttons/formButton-CenterTile.gif\">\n" );

			base.Render (writer);

			writer.Write( "</td>\n" );
			writer.Write( "<td width=\"11\"><img src=\"Images/Buttons/formButton-RightEnd.gif\" width=\"11\" height=\"20\"></td>\n" );
			writer.Write( "</tr>\n" );
			writer.Write( "</table>\n" );

		}

	}
}
