using System;
using System.Data;
using System.Collections;
using System.ComponentModel;
using System.Resources;
using System.Web.UI;
using System.Web.UI.WebControls;

//using Statline.StatTrac.Caching;
using Statline.StatTrac.Data.Types;

namespace Statline.StatTrac.Web.UI.WebControls
{

	[ToolboxData("<{0}:HyperLinkInsertToken runat=server></{0}:HyperLinkInsertToken>")]
	public class HyperLinkInsertToken : HyperLink
	{

		public HyperLinkInsertToken() : base ()
		{
		}

		protected override void OnPreRender(System.EventArgs e) 
		{
			base.OnPreRender(e);
			this.RegisterClientScript();
		}
        

		private TextBox targetTextBox;
		[Browsable(false)]
		public TextBox TargetTextBox
		{
			get { return this.targetTextBox; }
			set { this.targetTextBox = value; }
		}

		private DropDownList sourceDropDown;
		[Browsable(false)]
		public DropDownList SourceDropDown
		{
			get { return this.sourceDropDown; } 
			set { this.sourceDropDown = value; }
		}

		protected virtual void RegisterClientScript() 
		{
			if ( this.Enabled ) 
			{
				if( !Page.ClientScript.IsClientScriptBlockRegistered( "Statline.StatTrac.Web.UI.WebControls.TokenInsertScript" ) ) 
				{
					ResourceManager manager = new ResourceManager( this.GetType() );
					String script = manager.GetResourceSet(System.Globalization.CultureInfo.CurrentCulture, true, true).GetString("TokenInsertScript");
					this.Page.RegisterClientScriptBlock("Statline.StatTrac.Web.UI.WebControls.TokenInsertScript", script );
				}

				string sourceDropDownId = this.sourceDropDown.UniqueID.Replace( ":", "_" );
				string targetTextBoxId = this.targetTextBox.UniqueID.Replace( ":", "_" );

				base.NavigateUrl = "#";

				string onClick = "javascript: return Token_Insert( '" + sourceDropDownId + "', '" + targetTextBoxId + "' );"; 

				base.Attributes.Add( "OnClick", onClick );
			}
		}

	}
}