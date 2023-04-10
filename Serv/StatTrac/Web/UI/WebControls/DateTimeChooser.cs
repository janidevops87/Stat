using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.ComponentModel;


[assembly: TagPrefix ("Statline.StatTrac.Web.UI.WebControls" , "StatTrac") ]
namespace Statline.StatTrac.Web.UI.WebControls
{
	/// <summary>
	/// Summary description for DateTimeChooser.
	/// </summary>    
	[DefaultProperty("Text"), 
	ToolboxData("<{0}:DateTimeChooser runat=server></{0}:DateTimeChooser>")]
	public class DateTimeChooser : System.Web.UI.Control    //convert to WebControl .WebControls.WebControl

	{
		#region Properties
		private System.Web.UI.WebControls.TextBox txtDateChooser1;
		private System.Web.UI.WebControls.TextBox txtTime;
		private Image imgCal;
		private const string MILITARY_TIME_FORMAT = "HH:mm";

		public void AddAttributes(string key, string value)
		{
			if (txtTime.Attributes[key] != null)
				txtTime.Attributes.Add(key, txtTime.Attributes[key] + value);
			else
				txtTime.Attributes.Add(key, value);

			if (txtDateChooser1.Attributes[key] != null)
				txtDateChooser1.Attributes.Add(key, txtDateChooser1.Attributes[key] + value);
			else
				txtDateChooser1.Attributes.Add(key, value);
		}
		
		public string Value
		{
			set
			{
				//check to make sure that we are not going try to Convert
				//an invalid date value
				if ( value != null && !value.Equals("") )
				{
					DateTime dt = Convert.ToDateTime(value);
					
					// we have a valid date as part of the string
					if ( value.Length > 8 ) 
					{
						string strDate = dt.ToShortDateString();
						string[] dateArray = strDate.Split('/');
					
						if (dateArray[0].Length < 2)
							dateArray[0] = "0" + dateArray[0];
						if (dateArray[1].Length < 2)
							dateArray[1] = "0" + dateArray[1];

						txtDateChooser1.Text = dateArray[0] + "/" + dateArray[1] + "/" + dateArray[2];
					}
					else
						txtDateChooser1.Text = "";

					// make sure a time was passed in with the string, if not, there was no time entered
					if (( value.Length != 10 ))
						txtTime.Text = dt.ToString(MILITARY_TIME_FORMAT);
					else 
						txtTime.Text = "";
				}
				else
				{
					txtDateChooser1.Text = "";
					txtTime.Text = "";
				}
			}
		}
		
		public string Text
		{
			get
			{
				//added to prevent a " " being sent to the ConvertUtil
				//and blowing up the screen
				string retVal = txtDateChooser1.Text + " " + txtTime.Text;
				return retVal.Trim();
			}
		}

		#region Appearance Properties
		
		[Bindable(true),
		Category("Appearance"),
		DefaultValue(false),
		Description("Gets or sets the Cascading Style Sheet (CSS) class rendered by the web server control on the client.")]
		public string CssClass
		{
			get {return txtTime.CssClass;}
			set {txtTime.CssClass = value;}
		}
		
		#endregion
		
		#region Behavior Properties
		[Bindable(true),
		Category("Behavior"),
		DefaultValue(true),
		Description("Get or set a value indicating whether the web server control is enabled.")]
		public bool Enabled
		{
			get
			{							
				return txtDateChooser1.Enabled;
			}			
			set 
			{
				txtDateChooser1.Enabled = value;
				txtTime.Enabled = value;
			}
		}


		private bool required;
		public bool Required
		{
			set 
			{
				this.required = value;
			}
		}

		private string dateErrorMessage;
		public string DateErrorMessage
		{
			set 
			{
				this.dateErrorMessage = value;
			}
		}

		private string timeErrorMessage;
		public string TimeErrorMessage
		{
			set 
			{
				this.timeErrorMessage = value;
			}
		}

		public string DateTextBoxClientID
		{
			get {return this.txtDateChooser1.ClientID;}
		}

		public string TimeTextBoxClientID
		{
			get {return this.txtTime.ClientID;}
		}

		public string CalendarImageClientID
		{
			get {return this.imgCal.ClientID;}
		}

		[Bindable(true),
		Category("Behavior"),
		DefaultValue(false),
		Description("Gets or sets the tab index of the web server control")]
		public short DateTabIndex
		{
			get {return txtDateChooser1.TabIndex;}
			set {txtDateChooser1.TabIndex = value;}
		}

		[Bindable(true),
		Category("Behavior"),
		DefaultValue(false),
		Description("Gets or sets the tab index of the web server control")]
		public short TimeTabIndex
		{
			get {return txtTime.TabIndex;}
			set {txtTime.TabIndex = value;}
		}
		#endregion

		#endregion	

		#region Constructor
		public DateTimeChooser()
		{
			txtDateChooser1 = new System.Web.UI.WebControls.TextBox();
			txtTime = new System.Web.UI.WebControls.TextBox();
		}
		#endregion

		#region Events
		protected override void OnInit(EventArgs e)
		{
			//add date textbox
			txtDateChooser1.CssClass = "StatlineTextBox";
			txtDateChooser1.Width = Unit.Pixel(60);
			txtDateChooser1.ID = "txtDate_" + this.ID;			
			Controls.Add(txtDateChooser1);

			//add calendar image
			imgCal = new Image();
			imgCal.ImageUrl = base.ResolveUrl("~/images/calbutton.gif");
			imgCal.ImageAlign = ImageAlign.AbsMiddle;
			imgCal.ID = "imgCal_" + this.ID;
			imgCal.Attributes.Add("onclick", "javascript:ToggleCalendar('" + this.ID + "', '" + this.txtDateChooser1.ClientID + "');");
			Controls.Add(imgCal);

			//add spacer
			Controls.Add(new LiteralControl("&nbsp;"));

			//add time textbox
			txtTime.CssClass = "StatlineTextBox";
			txtTime.Width = Unit.Pixel(40);
			txtTime.ID = "txtTime_" + this.ID;
			Controls.Add(txtTime);

			base.OnInit (e);
		}


		protected override void CreateChildControls()
		{
			base.CreateChildControls ();
		}

		protected override void OnPreRender(EventArgs e)
		{
			//Apply Security and WorkMode
			Statline.StatTrac.Web.UI.BasePage page =  (Statline.StatTrac.Web.UI.BasePage)Page;

				if (this.required)
				{
					RequiredFieldValidator validatorDate = new RequiredFieldValidator();
					validatorDate.ControlToValidate = this.txtDateChooser1.ID;
					validatorDate.Text = this.dateErrorMessage;
					validatorDate.ErrorMessage = this.dateErrorMessage;						
					validatorDate.Display = ValidatorDisplay.None;
					Controls.Add(validatorDate);

					RequiredFieldValidator validatorTime = new RequiredFieldValidator();
					validatorTime.ControlToValidate = this.txtTime.ID;
					validatorTime.Text = this.timeErrorMessage;
					validatorTime.ErrorMessage = this.timeErrorMessage;						
					validatorTime.Display = ValidatorDisplay.None;
					Controls.Add(validatorTime);
				}

			//			if(this.Enabled)
			//			{
			//add scripts and calendar
			Page.RegisterClientScriptBlock("DateChooser", "<script src='" + base.ResolveUrl("~/scripts/DateChooser.js") + "'></script>");
			Controls.Add(new LiteralControl("<DIV style='Z-INDEX: 10000; LEFT: 8px; DISPLAY: none; WIDTH: 100px; POSITION: absolute; TOP: 8px; HEIGHT: 100px' ms_positioning='GridLayout' id='" + this.ID + "'></DIV>"));
			Controls.Add(new LiteralControl("<IFRAME id='iFrame_" + this.ID + "' name='iFrame_" + this.ID + "' src='javascript:false;' style='Z-INDEX: 1000; LEFT: 8px; DISPLAY: none; WIDTH: 230px; HEIGHT: 178px; POSITION: absolute; TOP: 8px'></IFRAME>"));
			Page.RegisterClientScriptBlock("InputMasks", "<script src='" + base.ResolveUrl("~/scripts/InputMasks.js") + "'></script>");

			//add date mask
			txtDateChooser1.Attributes.Add("maxlength", "8");
			txtDateChooser1.Attributes.Add("onkeydown", "javascript:DateMask('" + txtDateChooser1.ClientID + "');");
			txtDateChooser1.Attributes.Add("onkeypress", "javascript:return false;");

			//add script to clear date if incomplete
			if (txtDateChooser1.Attributes["onblur"] != null)
				txtDateChooser1.Attributes.Add("onblur", txtDateChooser1.Attributes["onblur"] + "DateCheck('" + txtDateChooser1.ClientID + "');");
			else
				txtDateChooser1.Attributes.Add("onblur", "javascript:DateCheck('" + txtDateChooser1.ClientID + "');");

			//add time mask
			txtTime.Attributes.Add("maxlength", "5");
			txtTime.Attributes.Add("onkeydown", "javascript:MilitaryTimeMask('" + txtTime.ClientID + "')");
			txtTime.Attributes.Add("onkeypress", "javascript:return false;");

			//add script to clear time if incomplete
			if (txtTime.Attributes["onblur"] != null)
				txtTime.Attributes.Add("onblur", txtTime.Attributes["onblur"] + "MilitaryTimeCheck('" + txtTime.ClientID + "');");
			else
				txtTime.Attributes.Add("onblur", "javascript:MilitaryTimeCheck('" + txtTime.ClientID + "');");
			//			}
		}
		#endregion
	}
}
