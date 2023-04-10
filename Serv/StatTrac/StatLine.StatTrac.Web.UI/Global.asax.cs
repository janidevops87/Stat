using System;
using System.Collections;
using System.ComponentModel;
using System.Web;
using System.Web.SessionState;
using Statline.StatTrac.Web.Security;

//using Statline.StatTrac.Caching;

namespace Statline.StatTrac.Web.UI 
{
	/// <summary>
	/// Summary description for Global.
	/// </summary>
	public class Global  : BaseApplication
	{

		private System.Timers.Timer timer;

		public override void Init()
		{
			this.InitializeComponent();
			base.Init();
		}

		private void InitializeComponent()
		{
			this.timer = new System.Timers.Timer();
			((System.ComponentModel.ISupportInitialize)(this.timer)).BeginInit();
			// 
			// timer
			// 
			this.timer.Enabled = true;
			this.timer.Interval = 1800000;
			this.timer.Elapsed += new System.Timers.ElapsedEventHandler(this.timer_Elapsed);
			((System.ComponentModel.ISupportInitialize)(this.timer)).EndInit();

		}

		private void timer_Elapsed(object sender, System.Timers.ElapsedEventArgs e)
		{
			
		}

	}
}