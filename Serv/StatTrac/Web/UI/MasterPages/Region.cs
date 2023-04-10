using System;
using System.Collections;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Statline.StatTrac.Web.UI.MasterPages
{

	/// <summary>
	/// The control marks a place holder for content in a master page.
	/// </summary>
	public class Region : PlaceHolder, INamingContainer {
	
		/// <summary>
		/// Overrides <see cref="Control.ID"/> to register regions as they are created.
		/// </summary>
		public override string ID 
		{
			get 
			{
				return base.ID;
			}
			set
			{
				base.ID = value;
				RegisterRegion();
			}
		}

		private static readonly string contextKey = "MasterPages.Region";

		/// <summary>
		/// Registers the regions within the current context item collection.
		/// </summary>
		private void RegisterRegion()
		{
			if ( HttpContext.Current != null )
			{
				string myKey = contextKey + "." + this.ID;
				if ( HttpContext.Current.Items.Contains(myKey) )
				{
					throw new InvalidOperationException("Region IDs must be unique. '" + this.ID + "' is already in use.");
				}
				else
				{
					HttpContext.Current.Items[myKey] = this;
				}
			}
		}

		public static void UnRegisterRegions()
		{
			if ( HttpContext.Current != null )
			{
				ArrayList list = new ArrayList();
				
				foreach( string key in HttpContext.Current.Items.Keys )
					if( key.StartsWith( contextKey ) )
						list.Add( key );

				foreach( string key in list  )
					HttpContext.Current.Items.Remove( key );

			}
		}

		/// <summary>
		/// Finds a region with a specific id.
		/// </summary>
		/// <param name="regionId">The id of the region to find.</param>
		/// <returns>The found region.</returns>
		internal static Region FindRegion( 
			string regionId
			)
		{

			if ( HttpContext.Current == null )
			{
				return null;
			}
			
			return HttpContext.Current.Items[contextKey + "." + regionId] as Region;

		}
	
	}
}