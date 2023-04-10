using System;
using System.Drawing;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.ComponentModel;

namespace Statline.StatTrac.Web.UI.WebControls
{

	[DefaultProperty("Text"), ToolboxData("<{0}:SectionHeader runat=server></{0}:SectionHeader>")]
	public class SectionHeader : System.Web.UI.WebControls.WebControl, INamingContainer
	{

		public SectionHeader()
		{
		}

		[Bindable(true), Category("Appearance"), DefaultValue("&nbsp;")] 
		public string Text 
		{
			get
			{
				this.EnsureChildControls();
				return this.sectionTitleCell.Text;
			}
			set
			{
				this.EnsureChildControls();
				this.sectionTitleCell.Text = value;
			}
		}

		public event EventHandler ButtonOneClicked;
		public event EventHandler ButtonTwoClicked;

		public override Unit Width
		{
			get
			{
				this.EnsureChildControls();
				return table.Width;
			}
			set
			{
				this.EnsureChildControls();
				table.Width = value;
			}
		}

		public override Unit Height
		{
			get
			{
				this.EnsureChildControls();
				return table.Height;
			}
			set
			{
				this.EnsureChildControls();
				sectionTitleCell.Height = value;
				table.Height = value;
			}
		}

		protected override void OnInit(EventArgs e)
		{
			this.PreRender += new System.EventHandler( this.SectionHeader_PreRender );
			base.OnInit (e);
		}

		private void SectionHeader_PreRender(
			object sender, 
			System.EventArgs e)
		{
			this.EnsureChildControls();
			this.buttonOneCell.Visible = this.button1.Text.Trim().Length > 0;
			this.buttonTwoCell.Visible = this.button2.Text.Trim().Length > 0;
			
			if( this.buttonOneCell.Visible & this.buttonTwoCell.Visible )
			{
				TableCell newCell = new TableCell();
				newCell.Text = "&nbsp;";

				r.Cells.AddAt( 3, newCell );
			}

			tempC.Visible = this.buttonOneCell.Visible | this.buttonTwoCell.Visible;

		}

		public override Unit BorderWidth
		{
			get
			{
				this.EnsureChildControls();
				return table.BorderWidth;
			}
			set
			{
				this.EnsureChildControls();
				table.BorderWidth = value;
			}
		}

		public override BorderStyle BorderStyle
		{
			get
			{
				this.EnsureChildControls();
				return table.BorderStyle;
			}
			set
			{
				this.EnsureChildControls();
				table.BorderStyle = value;
			}
		}

		[
		Description("Gets or sets the section header border color."),
		Category("Custom"),
		Bindable(false),
		DefaultValue("52759A")
		]
		public override Color BorderColor
		{
			get
			{
				this.EnsureChildControls();
				return table.BorderColor;
			}
			set
			{
				this.EnsureChildControls();
				table.BorderColor = value;
			}
		}

		public override Color BackColor
		{
			get
			{
				this.EnsureChildControls();
				return table.BackColor;
			}
			set
			{
				this.EnsureChildControls();
				table.BackColor = value;
			}
		}

		[
		Description("Gets or sets the cascading style sheet class."),
		Category("Custom"),
		Bindable(false),
		DefaultValue("SectionHeader")
		]
		public override string CssClass
		{
			get
			{
				this.EnsureChildControls();
				return table.CssClass;
			}
			set
			{
				this.EnsureChildControls();
				sectionTitleCell.CssClass = value;
				table.CssClass = value;
			}
		}

		public string BackImageUrl
		{
			get
			{
				this.EnsureChildControls();
				return this.table.BackImageUrl;
			}
			set
			{
				this.EnsureChildControls();
				this.table.BackImageUrl = value;
			}
		}

		public override ControlCollection Controls
		{
			get
			{
				this.EnsureChildControls();
				return base.Controls;
			}
		}

		private string UnderlineButtonText(
			string buttonText
			)
		{
			if( buttonText.Length == 0 )
			{
				return string.Empty;
			}
			else if( buttonText.Length == 1 )
			{
				if( buttonText.Substring( 0, 3 ) != "<u>" )
				{
					return string.Format( "<u>{0}</u>", buttonText );
				}
				else
				{
					return buttonText;
				}
			}
			else
			{
				if( buttonText.Substring( 0, 3 ) != "<u>" )
				{
					return string.Format( "<u>{0}</u>{1}", buttonText[0], buttonText.Substring( 1 ) );
				}
				else
				{
					return buttonText;
				}
			}
		}

		#region Button One

		[
		Description("Gets or sets the Text of Link Button 1."),
		Category("ButtonOne"),
		Bindable(false),
		DefaultValue(null)
		]
		public string ButtonOneText
		{
			get
			{
				this.EnsureChildControls();
				return this.button1.Text;
			}
			set
			{
				this.EnsureChildControls();
				this.button1.Text = UnderlineButtonText( value.Trim() );
				if( value.Length > 0 )
				{
					this.button1.AccessKey = value.Substring( 0, 1 );
				}
			}
		}

		[
		Description("Gets or sets the CommandArgument of Link Button 1."),
		Category("ButtonOne"),
		Bindable(false),
		DefaultValue(null)
		]
		public string ButtonOneCommandArgument
		{
			get
			{
				this.EnsureChildControls();
				return this.button1.CommandArgument;
			}
			set
			{
				this.EnsureChildControls();
				this.button1.CommandArgument = value;
			}
		}

		[
		Description("Gets or sets the ConfirmationMessage of Link Button 1."),
		Category("ButtonOne"),
		Bindable(false),
		DefaultValue(null)
		]
		public string ButtonOneConfirmationMessage
		{
			get
			{
				this.EnsureChildControls();
				return this.button1.ConfirmationMessage;
			}
			set
			{
				this.EnsureChildControls();
				this.button1.ConfirmationMessage = value;
			}
		}

		[
		Description("Gets or sets the SuppressConfirmation of Link Button 1."),
		Category("ButtonOne"),
		Bindable(false),
		DefaultValue(true)
		]
		public bool ButtonOneSuppressConfirmation
		{
			get
			{
				this.EnsureChildControls();
				return this.button1.SuppressConfirmation;
			}
			set
			{
				this.EnsureChildControls();
				this.button1.SuppressConfirmation = value;
			}
		}

		#endregion
        
		#region Button Two

		[
		Description("Gets or sets the Text of Link Button 2."),
		Category("ButtonTwo"),
		Bindable(false),
		DefaultValue(null)
		]
		public string ButtonTwoText
		{
			get
			{
				this.EnsureChildControls();
				return this.button2.Text;
			}
			set
			{
				this.EnsureChildControls();
				this.button2.Text = UnderlineButtonText( value.Trim() );
				if( value.Length > 0 )
				{
					this.button2.AccessKey = value.Substring( 0, 1 );
				}
			}
		}


		[
		Description("Gets or sets the CommandArgument of Link Button 2."),
		Category("ButtonTwo"),
		Bindable(false),
		DefaultValue(null)
		]
		public string ButtonTwoCommandArgument
		{
			get
			{
				this.EnsureChildControls();
				return this.button2.CommandArgument;
			}
			set
			{
				this.EnsureChildControls();
				this.button2.CommandArgument = value;
			}
		}

		[
		Description("Gets or sets the ConfirmationMessage of Link Button 2."),
		Category("ButtonTwo"),
		Bindable(false),
		DefaultValue(null)
		]
		public string ButtonTwoConfirmationMessage
		{
			get
			{
				this.EnsureChildControls();
				return this.button2.ConfirmationMessage;
			}
			set
			{
				this.EnsureChildControls();
				this.button2.ConfirmationMessage = value;
			}
		}

		[
		Description("Gets or sets the SuppressConfirmation of Link Button 2."),
		Category("ButtonTwo"),
		Bindable(false),
		DefaultValue(true)
		]
		public bool ButtonTwoSuppressConfirmation
		{
			get
			{
				this.EnsureChildControls();
				return this.button2.SuppressConfirmation;
			}
			set
			{
				this.EnsureChildControls();
				this.button2.SuppressConfirmation = value;
			}
		}

		#endregion

		Table table;
		TableCell sectionTitleCell;
		TableCell buttonOneCell;
		TableCell buttonTwoCell;
		LinkButtonConfirm button1;
		LinkButtonConfirm button2;
		TableCell tempC;
		TableRow r;
		protected override void CreateChildControls()
		{


			Table t = new Table();
			t.Width = new Unit( "100%" );
			t.CellPadding = 0;
			t.CellSpacing = 0;
			r = new TableRow();
			TableCell c = new TableCell();
			c.Width = new Unit( "100%" );
			r.Cells.Add( c );
			t.Rows.Add( r );

			table = new Table();
			c.Controls.Add( table );

			table.CssClass = "SectionHeader";
			table.BackImageUrl = "~/Images/ContentTitle-Tile.gif";
			table.CellPadding = 0;
			table.CellSpacing = 0;
			TableRow tableRow = new TableRow();
			table.Rows.Add( tableRow );
			sectionTitleCell = new TableCell();
			sectionTitleCell.HorizontalAlign = HorizontalAlign.Left;
			sectionTitleCell.CssClass = "SectionHeader";
			tableRow.Cells.Add( sectionTitleCell );

			tempC = new TableCell();
			tempC.Text = "&nbsp;";
			r.Cells.Add( tempC );

			buttonOneCell = new TableCell();
			buttonOneCell.VerticalAlign = VerticalAlign.Middle;
			buttonOneCell.HorizontalAlign = HorizontalAlign.Right;
			buttonOneCell.Wrap=false;
			r.Cells.Add( buttonOneCell );
			
			button1 = new LinkButtonConfirm();
			button1.Click += new System.EventHandler( this.shLB_Click );
			button1.ID= "shLB1";
			button1.CommandName = "ButtonOne";
			button1.CssClass = "ButtonText";
			button1.SuppressConfirmation = true;
			button1.Text = UnderlineButtonText( button1.Text );
			if( button1.Text.Length > 0 )
			{
				this.button1.AccessKey = button1.Text.Substring( 0, 1 );
			}

			buttonOneCell.Controls.Add( button1 );

			buttonTwoCell = new TableCell();
			buttonTwoCell.VerticalAlign = VerticalAlign.Middle;
			buttonTwoCell.HorizontalAlign = HorizontalAlign.Right;
			buttonTwoCell.Wrap=false;
			r.Cells.Add( buttonTwoCell );

			button2 = new LinkButtonConfirm();
			button2.Click += new System.EventHandler( this.shLB_Click );
			button2.ID= "shLB2";
			button2.CommandName = "ButtonTwo";
			button2.CssClass = "ButtonText";
			button2.SuppressConfirmation = true;
			button2.Text = UnderlineButtonText( button2.Text );
			if( button2.Text.Length > 0 )
			{
				this.button2.AccessKey = this.button2.Text.Substring( 0, 1 );
			}

			buttonTwoCell.Controls.Add( button2 );

			this.Controls.Add( t );

			base.CreateChildControls();
		}

		private void shLB_Click(object sender, System.EventArgs e)
		{
			LinkButton button = sender as LinkButton;
			if( button != null )
			{
				if( button.CommandName == "ButtonOne" )
				{
					if( this.ButtonOneClicked != null )
					{
						this.ButtonOneClicked( sender, e );
					}
				}
				else if( button.CommandName == "ButtonTwo" )
				{
					if( this.ButtonTwoClicked != null )
					{
						this.ButtonTwoClicked( sender, e );
					}
				}
			}
		}


	}
}