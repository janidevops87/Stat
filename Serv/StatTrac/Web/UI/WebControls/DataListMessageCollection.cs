using System;
using System.Data;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using System.Web.UI;
using System.Web.UI.WebControls;

//using Statline.StatTrac.Caching;

namespace Statline.StatTrac.Web.UI.WebControls
{
	/// <summary>
	/// Summary description for DataListMessageCollection.
	/// </summary>
	[ToolboxData("<{0}:DataListMessageCollection runat=server></{0}:DataListMessageCollection>")]
	public class DataListMessageCollection : WebControl
	{
		/// <summary>
		/// Overrides the Page to allow access to the framework BasePage.
		/// </summary>
		[Browsable(false)]
		public new BasePage Page
		{
			get
			{
				if( base.Page as BasePage != null )
					return base.Page as BasePage;
				else
					throw new ApplicationException( "Invalid BasePage." );
			}
		}

		//		private const string messagePolicyHTML = 
		//			"<div><span style=\"width: 22px;\"><img class=messageicon height=17 width=17 border=0 src={0}></span><span style=\"height:17px;color:red;\">{1}</span></div>";

		private const string messagePolicyHTML = "<li class=\"Error\">{0}";

		/// <summary>
		/// Called once for each message in the collection.
		/// </summary>
		/// <param name="sender"></param>
		/// <param name="e"></param>
		private void messagesDataList_ItemDataBound(
			object sender, 
			System.Web.UI.WebControls.DataListItemEventArgs e
			)
		{
			if( e.Item.ItemType == ListItemType.Item | 
				e.Item.ItemType == ListItemType.AlternatingItem )
			{

				DisplayMessage message = e.Item.DataItem as DisplayMessage;
			
				if( message != null )
				{
					string imagePath = 
						this.Page.CreateSharedImagePath( message.Type.ImageFileName );

					LiteralControl literalControl = new LiteralControl();

//					literalControl.Text = 
//						string.Format( messagePolicyHTML, imagePath,
//						message.Text );

					literalControl.Text = 
						string.Format( messagePolicyHTML, message.Text );

					e.Item.Controls.Add( literalControl );
				}
			}
		}

		/// <summary>
		/// Renders contents of the display messages.
		/// </summary>
		/// <param name="writer"></param>
		protected override void Render( HtmlTextWriter writer )
		{
			if( !this.Enabled )
			{
				return;
			}

            if( DisplayMessages.Count > 0 )
			{
				DataList ds = new DataList();
				ds.Width = new Unit( "100%");

				ds.ItemDataBound += 
					new System.Web.UI.WebControls.DataListItemEventHandler(
					this.messagesDataList_ItemDataBound);
	
				ds.DataSource = DisplayMessages.Messages;
				ds.DataBind();

				this.Controls.Add( ds );

				base.Render( writer );

				DisplayMessages.Clear();

				this.Visible = true;
			}
			else
			{
				this.Visible = false;
			}
		}
	}
}