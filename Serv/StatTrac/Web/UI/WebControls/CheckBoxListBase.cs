using System;
using System.Collections;
using System.Data;
using System.ComponentModel;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Statline.StatTrac.Web.UI.WebControls
{

	/// <summary>
	/// Defines the base CheckBoxList for the framework.
	/// </summary>
	public class CheckBoxListBase : System.Web.UI.WebControls.CheckBoxList
	{
        
		/// <summary>
		/// Overrides the Page to allow access to the framework BasePage.
		/// </summary>
		[Browsable(false)]
		public new BasePage Page
		{
			get
			{
				return base.Page as BasePage;
			}
		}

		/// <summary>
		/// Hides the DataTextField from the designer
		/// </summary>
		[Browsable(false)]
		public new string DataTextField
		{
			set { base.DataTextField = value; }
			get { return base.DataTextField; }
		}

		/// <summary>
		/// Hides the DataValueField from the designer
		/// </summary>
		[Browsable(false)]
		public new string DataValueField
		{
			set { base.DataValueField = value; }
			get { return base.DataValueField; }
		}

		/// <summary>
		/// Sets and gets a byte array of the list items
		/// </summary>
		[Browsable(false)]
		protected int[] Values
		{
			get
			{ 
				ArrayList selectedListItems = new ArrayList();
				ArrayList selectedValues = new ArrayList();

				for( ListItem listItem = this.SelectedItem; listItem != null; listItem = this.SelectedItem )
				{
					selectedListItems.Add( listItem );
					selectedValues.Add( int.Parse( listItem.Value ) );
					listItem.Selected = false;
				}

				foreach( ListItem listItem in selectedListItems )
					listItem.Selected = true;

				return (int[])selectedValues.ToArray( typeof( int ) );
			}
			set
			{

				this.DataBind();

				for( ListItem listItem = this.SelectedItem; listItem != null; listItem = this.SelectedItem )
					listItem.Selected = false;

				foreach( int valueId in value )
				{
					ListItem listItem = this.Items.FindByValue( valueId.ToString() );
					if( listItem != null )
						listItem.Selected = true;

				}
			}
		}


		public override void DataBind()
		{

			if( this.Items.Count == 0 )
			{
			
				base.DataBind();

			}

		}

	}
}