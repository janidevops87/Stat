using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

namespace Statline.StatTrac.Web.UI
{

	/// <summary>
	/// Base class for User Controls that support "full-page" editing -- where
	/// the User Control supports both a "view" mode and an "edit" mode.
	/// </summary>
	public class BaseEditableUserControl : BaseUserControlSecure
	{

		/// <summary>
		/// Since this class is intended to serve as a base class for User
		/// Controls in the Web application, don't allow it to be used outside
		/// of this assembly.
		/// </summary>
		public BaseEditableUserControl()
		{
		}

		/// <summary>
		/// Indicates whether the User Control should render itself in view
		/// mode or edit mode.
		/// </summary>
		/// <remarks>
		/// This property is preserved across post-backs.
		/// </remarks>
		public DisplayMode DisplayMode
		{
			get
			{
				DisplayMode mode = DisplayMode.View;

				if ( ViewState["DisplayMode"] != null
					&& ViewState["DisplayMode"].GetType( ) == typeof( DisplayMode ) )
				{
					mode = (DisplayMode)Enum.Parse( typeof( DisplayMode ), ViewState["DisplayMode"].ToString() );
				}

				return mode;
			}
			set
			{

				ViewState["DisplayMode"] = value;

			}
		}

		/// <summary>
		/// Sets the typed DataSet for the User Control.
		/// </summary>
		/// <remarks>
		/// User Controls that derive from this class must override
		/// this method.
		/// </remarks>
		/// <param name="data">The typed DataSet that serves as the underlying
		/// data source for the User Control.</param>
		public virtual void SetData(
			DataSet data )
		{
			throw new ApplicationException( "The SetData method of"
				+ " BaseEditableControl must be overridden." );
		}

		/// <summary>
		/// Synchronizes the underlying typed DataSet with data from the
		/// User Control. This method is typically called just prior to
		/// updating the database from the DataSet.
		/// </summary>
		/// <remarks>
		/// User Controls that derive from this class must override
		/// this method.
		/// </remarks>
		public virtual bool Synchronize()
		{
			throw new ApplicationException( "The SyncData method of"
				+ " BaseEditableControl must be overridden." );
		}

	}
}

