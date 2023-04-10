using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;
using System.ComponentModel;

using Statline.Configuration;

namespace Statline.StatTrac.Web.UI.MasterPages
{


	/// <summary>
	/// This control serves two distincts purposes:
	/// - it marks the location where the Master Page will be inserted into the Page
	/// - it contains the various Content sections that will be matched to the Master Page's
	///   Region controls (based on their ID's).
	/// </summary>
	public class ContentContainer : PlaceHolder
	{

		/// <summary>
		/// Creates a new instance of the ContentContainer class.
		/// </summary>
		public ContentContainer()
		{
			try
			{
				this.MasterPageFile = ApplicationSettings.GetSetting( SettingName.MasterPagesPolicy );
			}
			catch
			{
				// do nothing - added the try/catch for designer support
			}
		}

		/// <summary>
		/// Only allows <see cref="Content"/> controls to be added.
		/// </summary>
		protected override void AddParsedSubObject(object obj)
		{
			if (obj is Content)
			{
				_contents.Add(obj);
			}
			else
			{
				throw new Exception("The ContentContainer control can only contain content controls");
			}
		}

		private ArrayList _contents = new ArrayList();

		/// <summary>
		/// Overrides the <see cref="Control.OnInit"/> event to load the master page.
		/// </summary>
		protected override void OnInit(EventArgs e)
		{
			this.LoadMasterPage();
			base.OnInit(e);
		}

		private void LoadMasterPage()
		{

			if (MasterPageFile == null) {
				throw new Exception("You need to set the MasterPageFile property");
			}

			Control masterPage = Page.LoadControl(MasterPageFile);
			Controls.Add(masterPage);

			MoveContentsIntoRegions();
		}


		/// <summary>
		/// 
		/// </summary>
		private void MoveContentsIntoRegions()
		{

			foreach (Content content in _contents) {
				Control region = Region.FindRegion(content.ID);
				if ( region == null ) {
					throw new Exception("Could not find matching region for content with ID '" + content.ID + "'");
				}

				// Set the Content control's PolicySourceDirectory to be the one from the
				// page.  Otherwise, it would end up using the one from the Master Pages user control,
				// which would be incorrect.
				content._templateSourceDirectory = TemplateSourceDirectory;

				region.Controls.Clear();
				region.Controls.Add(content);
			}

		}

		/// <summary>
		/// The path to MasterPage that specifies the layout used to render the contained content.
		/// </summary>
		[
		Category("Behavior"),
		DefaultValue(""),
		Description("The path to MasterPage that specifies the layout used to render the contained content.")
		]
		public string MasterPageFile
		{
			
			get 
			{
				return (string)ViewState["MasterPageFile"];
			}
			set 
			{
				ViewState["MasterPageFile"] = value;
				ChildControlsCreated = false;
			}
		}
	}

}
