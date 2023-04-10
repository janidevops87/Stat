using System;
using System.Windows.Forms;
using System.Runtime.InteropServices;
using System.Security.Permissions;
using System.Reflection;
using SHDocVw;

namespace Statline.Stattrac.Windows.Forms
{
	public enum DISPID
	{
		NewWindow2 = 251
	}

	[ComImport(), Guid("34A715A0-6587-11D0-924A-0020AFC7AC4D"), InterfaceType(ComInterfaceType.InterfaceIsIDispatch), TypeLibType(TypeLibTypeFlags.FHidden)]
	public interface WebBrowserEvents
	{
		[DispId((int)DISPID.NewWindow2)]
		void NewWindow2([In, Out, MarshalAs(UnmanagedType.IDispatch)] ref object pDisp, [In, Out] ref bool cancel);
	}

	public class WebBrowserNewWindow2EventArgs : System.ComponentModel.CancelEventArgs
	{
		#region Private Fields
		private object ppDispValue;
		#endregion

		#region Public Constructor
		public WebBrowserNewWindow2EventArgs(object ppDisp)
		{
			this.ppDispValue = ppDisp;
		}
		#endregion

		#region Public Properties
		public object ppDisp
		{
			get { return ppDispValue; }
			set { ppDispValue = value; }
		}
		#endregion
	}

	public class WebBrowser : System.Windows.Forms.WebBrowser
	{
		#region Private Fields
		private AxHost.ConnectionPointCookie cookie;
		private WebBrowser2EventHelper helper;
		#endregion

		#region Public Events
		public event WebBrowserNewWindow2EventHandler NewWindow2;
		#endregion

		#region Public Delegates
		public delegate void WebBrowserNewWindow2EventHandler(object sender, WebBrowserNewWindow2EventArgs e);
		#endregion

		#region Protected Method for Extended Events
		protected virtual void OnNewWindow2(WebBrowserNewWindow2EventArgs e)
		{
			if (NewWindow2 != null)
			{
				NewWindow2(this, e);
			}
		}
		#endregion

		#region Overridden Methods for Sink
		[PermissionSetAttribute(SecurityAction.LinkDemand, Name = "FullTrust")]
		protected override void CreateSink()
		{
			base.CreateSink();
			helper = new WebBrowser2EventHelper(this);
			cookie = new AxHost.ConnectionPointCookie(this.ActiveXInstance, helper, typeof(WebBrowserEvents));
		}

		[PermissionSetAttribute(SecurityAction.LinkDemand, Name = "FullTrust")]
		protected override void DetachSink()
		{
			if (cookie != null)
			{
				cookie.Disconnect();
				cookie = null;
			}
			base.DetachSink();
		}
		#endregion

		#region Public Properties for the Com Object
		[System.ComponentModel.DesignerSerializationVisibility(System.ComponentModel.DesignerSerializationVisibility.Hidden)]
		[System.Runtime.InteropServices.DispIdAttribute(200)]
		public object Application
		{
			get
			{
				if ((this.ActiveXInstance == null))
				{
					throw new AxHost.InvalidActiveXStateException("Application", AxHost.ActiveXInvokeKind.PropertyGet);
				}
				object application = ((SHDocVw.WebBrowser_V1)ActiveXInstance).Application;
				return application;
			}
		}

		[System.ComponentModel.DesignerSerializationVisibility(System.ComponentModel.DesignerSerializationVisibility.Hidden)]
		[System.Runtime.InteropServices.DispIdAttribute(552)]
		public bool RegisterAsBrowser
		{
			get
			{
				if ((this.ActiveXInstance == null))
				{
					throw new AxHost.InvalidActiveXStateException("RegisterAsBrowser", AxHost.ActiveXInvokeKind.PropertyGet);
				}

				IWebBrowser2 wWebBrowser2 = (IWebBrowser2)ActiveXInstance;
				return wWebBrowser2.RegisterAsBrowser;
			}

			set
			{
				if ((this.ActiveXInstance == null))
				{
					throw new AxHost.InvalidActiveXStateException("RegisterAsBrowser", AxHost.ActiveXInvokeKind.PropertySet);
				}

				IWebBrowser2 wWebBrowser2 = (IWebBrowser2)ActiveXInstance;
				wWebBrowser2.RegisterAsBrowser = true;

			}
		}
		#endregion

		#region WebBrowser2EventHelper Private Class
		private class WebBrowser2EventHelper : StandardOleMarshalObject, WebBrowserEvents
		{
			#region Private Fields
			private WebBrowser parent;
			#endregion

			#region Public Constructor
			public WebBrowser2EventHelper(WebBrowser parent)
			{
				this.parent = parent;
			}
			#endregion

			#region DWebBrowserEvents2 Members
			public void NewWindow2(ref object ppDisp, ref bool cancel)
			{
				WebBrowserNewWindow2EventArgs e = new WebBrowserNewWindow2EventArgs(ppDisp);
				this.parent.OnNewWindow2(e);
				ppDisp = e.ppDisp;
				cancel = e.Cancel;
			}
			#endregion
		}
		#endregion
	}
}
