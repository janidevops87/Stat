using System;
using System.Collections;
using System.Data;
using System.ComponentModel;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Statline.StatTrac.Web.UI.WebControls
{
	/// <summary>
	/// Summary description for RadioButtonListBase
	/// </summary>
	public class RadioButtonListBase : System.Web.UI.WebControls.RadioButtonList
	{


		[Browsable(false)]
		public new BasePage Page
		{
			get
			{
				return base.Page as BasePage;
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
		public virtual ValueMode Mode
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


		public override void DataBind()
		{

			if( this.Items.Count == 0 )
			{

				this.Items.Clear();

				base.DataBind();

			}

		}

	}
}