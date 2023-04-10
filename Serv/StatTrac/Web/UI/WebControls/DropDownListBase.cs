using System;
using System.Data;
using System.Collections;
using System.ComponentModel;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Statline.StatTrac.Web.UI.WebControls
{
	/// <summary>
	/// Summary description for DropDownListBase
	/// </summary>
	public class DropDownListBase : System.Web.UI.WebControls.DropDownList
	{

		protected string defaultText = string.Empty;

		protected const string EmptyText = "Empty";
		
		[Bindable(false),
		Category("DataBinding"), 
		DefaultValue("Empty"), 
		Description("The default text for the unselected item. Set to Empty to display nothing.")] 
		public string DefaultText
		{
			get { return this.defaultText; }
			set { this.defaultText = value; }
		}

		private string defaultValue = "0";
		[Bindable(false),
		Category("DataBinding"),
		DefaultValue("0"), 
		Description("The default value for the default text.")] 
		public string DefaultValue
		{
			get { return this.defaultValue; }
			set { this.defaultValue = value; }
		}


		[Browsable(false)]
		public new BasePage Page
		{
			get
			{
				if( base.Page as BasePage != null )
					return base.Page as BasePage;
				else
					return null; //throw new ApplicationException( "Invalid BasePage." );
			}
		}
		
		public override void DataBind()
		{
			if( this.Items.Count == 0 )
			{
				base.DataBind();
				this.AddDefaultItem();
			}
		}

		[Browsable(false)]
		public new string DataTextField
		{
			set { base.DataTextField = value; }
			get { return base.DataTextField; }
		}

		[Browsable(false)]
		public new string DataValueField
		{
			set { base.DataValueField = value; }
			get { return base.DataValueField; }
		}

		[Browsable(false)]
		protected int Value
		{
			get 
			{
				if( this.mode != ValueMode.Integer )
				{
					throw new ApplicationException( "Invalid mode set for this type of access." );
				}

				if( this.SelectedItem != null )
				{
					return int.Parse( this.SelectedItem.Value );
				}
				else
				{
					return 0;
				}
			}
			set
			{
				this.StringValue = value.ToString();
			}
		}

		[Browsable(false)]
		protected string StringValue
		{
			get 
			{
				if( this.mode != ValueMode.String )
				{
					throw new ApplicationException( "Invalid mode set for this type of access." );
				}

				if( this.SelectedItem != null )
				{
					return this.SelectedItem.Value;
				}
				else
				{
					return null;
				}
			}
			set
			{
				this.DataBind();
				ListItem listItem = this.Items.FindByValue( value.ToString() );
				if( listItem != null  )
				{
					foreach( ListItem currentListItem in this.Items )
					{
						currentListItem.Selected = false;
					}

					listItem.Selected = true;
				}
				//this.SelectedIndex = this.Items.IndexOf( listItem );
			}
		}

		public enum ValueMode { Integer, String };

		private ValueMode mode = ValueMode.Integer;

		[Bindable(false), Category("DataBinding"), 
		DefaultValue(ValueMode.Integer), 
		Description("The value mode for the setting the selected item in the drop down" )]
		public ValueMode Mode
		{
			get
			{
				return this.mode;
			}
			set
			{
				this.mode= value;
			}
		}

		protected void AddDefaultItem()
		{
			if( this.defaultText.Trim() == EmptyText )
				this.Items.Insert( 0, new ListItem( string.Empty, this.defaultValue ) );
			else if( this.defaultText.Trim().Length > 0 )
				this.Items.Insert( 0, new ListItem( this.defaultText, this.defaultValue ) );
		}

	}
}