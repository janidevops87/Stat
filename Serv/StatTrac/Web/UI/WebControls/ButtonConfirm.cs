using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.ComponentModel;

namespace Statline.StatTrac.Web.UI.WebControls
{

	/// <summary>
	/// A Custom button web control that prompts the user on the
	/// client whenever an instance of this button is clicked.
	/// </summary>
	[DefaultProperty("ConfirmationMessage"),
	ToolboxData("<{0}:ButtonConfirm runat=server></{0}:ButtonConfirm>")]
	public class ButtonConfirm : System.Web.UI.WebControls.Button
	{

		protected string confirmationMessage = "Are you sure?";
		protected bool suppressConfirmation = false;

		/// <summary>
		/// The default constructor.
		/// </summary>
		public ButtonConfirm() : base()
		{
			base.CausesValidation = false;
		}

        /// <summary>
        /// Defines the confirmation message that is displayed to the user
        /// when an instance of this button ic clicked.
        /// </summary>
		[Bindable(true),
		Category("Behavior"),
		DefaultValue("Are you sure?")]
		public string ConfirmationMessage
		{
			get { return this.confirmationMessage; }
			set { this.confirmationMessage = value; }
		}

		/// <summary>
		/// If set to true, the confirmation prompt is not displayed.
		/// </summary>
		[Bindable(true),
		Category("Behavior"),
		DefaultValue(false)]
		public bool SuppressConfirmation
		{
			get { return this.suppressConfirmation; }
			set { this.suppressConfirmation = value; }
		}

		/// <summary>
		/// Overrides CausesValidation
		/// </summary>
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

		private const string onClickFormat = "javascript:return confirm('{0}');";

		/// <summary>
		/// Overrides AddAttributesToRender
		/// </summary>
		/// <param name="writer"></param>
		protected override void AddAttributesToRender(HtmlTextWriter writer)
		{

			base.AddAttributesToRender (writer);

			if(!this.suppressConfirmation)
			{
				writer.AddAttribute( HtmlTextWriterAttribute.Onclick, 
					string.Format( onClickFormat, this.confirmationMessage ) );
			}
		}

	}
}
