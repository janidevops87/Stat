using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.ComponentModel;

namespace Statline.StatTrac.Web.UI.WebControls
{

	[DefaultProperty("ConfirmationMessage"),
	ToolboxData("<{0}:ImageButtonConfirm runat=server></{0}:ImageButtonConfirm>")]
	public class ImageButtonConfirm : Statline.StatTrac.Web.UI.WebControls.ImageButtonTexture
	{

		protected string confirmationMessage = "Are you sure?";
		protected bool suppressConfirmation = false;

		public ImageButtonConfirm() : base()
		{
			base.CausesValidation = false;
		}


		[Bindable(true),
		Category("Behavior"),
		DefaultValue("Are you sure?")]
		public string ConfirmationMessage
		{
			get { return this.confirmationMessage; }
			set { this.confirmationMessage = value; }
		}

		[Bindable(true),
		Category("Behavior")]
		public bool SuppressConfirmation
		{
			get { return this.suppressConfirmation; }
			set { this.suppressConfirmation = value; }
		}

		[Browsable(false)]
		public new bool CausesValidation
		{
			get
			{
				return false;
			}
			set
			{
				base.CausesValidation = false;
			}
		}

		protected override void AddAttributesToRender(HtmlTextWriter writer)
		{

			base.AddAttributesToRender (writer);

			if(!this.suppressConfirmation)
			{
				writer.AddAttribute( HtmlTextWriterAttribute.Onclick, 
					string.Format("javascript:return confirm('{0}');", this.confirmationMessage));
			}
		}

	}
}
