using System;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Windows.Forms;
using Statline.Stattrac.Constant;
using Statline.Stattrac.Windows.UI;
using Infragistics.Win.UltraWinSpellChecker;

namespace Statline.Stattrac.Windows.Forms
{
	public class TextBox : System.Windows.Forms.TextBox
	{
		private TextBoxMask mask;
        private bool _spellCheckEnabled;
        private bool _required;
        private UltraSpellChecker _ultraSpellChecker;
        private AsYouTypeManager  _asYouTypeManager;

        #region Properties
        /// <summary>
        /// Determines if the field is Required.
        /// If the field is empty the field is not valid.
        /// </summary>
        [Description("Determines if the field is Required.\nIf the field is empty the field is not valid.")]
        public bool Required
        {
            get { return _required; }
            set { _required = value; }
        }
        /// <summary>
        /// Determines if the text box should be Spell Checked.
        /// </summary>
        [Description("Determines if the text box should be Spell Checked.\nIf the box is spell checked a dialog box will popup to help correct the error")]
        public bool SpellCheckEnabled
        {
            get { return _spellCheckEnabled; }
            set { _spellCheckEnabled = value; }
        }
        /// <summary>
        /// Choose a predefined mask.
        /// If the mask does not exist it can be created by modifying this control
        /// or TextBoxMask control can be used.
        /// </summary>
		[DefaultValue(TextBoxMask.None)]
        [Description("Choose a predefined mask.\nIf the mask does not exist \nit can be created by modifying this control \nor TextBoxMask control can be used.")]
		public TextBoxMask Mask
		{
			set { mask = value; }
			get { return mask; }
        }
        #endregion

        #region Methods
        public void BindDataSet(DataSet ds, string tableName, string columnName)
		{
			if (DataBindings["Text"] == null)
			{
				DataBindings.Add("Text", ds, tableName + "." + columnName);
			}
			// Set the length of the textbox
			if (ds.Tables[tableName].Columns[columnName].MaxLength > 0)
			{
				MaxLength = ds.Tables[tableName].Columns[columnName].MaxLength;
			}
        }
        public void BindDataSet(DataView dv, string columnName)
        {
            if (DataBindings["Text"] == null)
            {
                DataBindings.Add("Text", dv, columnName);
            }
            // Set the length of the textbox
            if (dv.Table.Columns[columnName].MaxLength > 0)
            {
                MaxLength = dv.Table.Columns[columnName].MaxLength;
            }
        } 

        #region Events				
        protected override void OnValidating(CancelEventArgs e)
        {
            if(Required)
            {
                if (Text.Length < 1)
                {
                    e.Cancel = true;
                    BackColor = Color.Yellow;
                }
                else
                    BackColor = Color.White;
            }
            base.OnValidating(e);
        }
        #endregion

        protected override void OnLayout(LayoutEventArgs levent)
		{
			this.TextChanged += new EventHandler(TextBox_TextChanged);
			switch (mask)
			{
				case TextBoxMask.None:
					break;
				case TextBoxMask.ReadOnly:
					SetReadOnly();
					break;
				case TextBoxMask.Password:
					SetPassWordMask();
					break;
				case TextBoxMask.PositiveInteger:
					SetPositiveIntegerMask();
					break;
				case TextBoxMask.Decimal:
					SetDecimalMask();
					break;
                case TextBoxMask.Phone:
                    SetPhoneMask();
                    break;

				default:
					break;
			}

			// For a multiline set the scroll bar to show
			if (Multiline)
			{
				ScrollBars = ScrollBars.Vertical;			
			}
            this.Font = new Font("Tahoma", 8F);
			base.OnLayout(levent);
		}

		private void TextBox_TextChanged(object sender, EventArgs e)
		{
			BaseForm baseForm = FindForm() as BaseForm;
			if (baseForm != null)
			{
				baseForm.DataChanged();
			}
            if (!_spellCheckEnabled)
                return;
            if (_ultraSpellChecker == null)
            {
                _ultraSpellChecker = new UltraSpellChecker();
                _ultraSpellChecker.UserDictionary = @"Styles\CustomDictionary.dict";
                _ultraSpellChecker.Mode = SpellCheckingMode.AsYouType;
            }
            if (_asYouTypeManager == null)
            {
                _asYouTypeManager = new AsYouTypeManager(_ultraSpellChecker, this);
                _asYouTypeManager.Enabled = true;
            }

            _asYouTypeManager.RecheckAllText();
         
		}
        
        private void SetPassWordMask()
        {
            WindowsConstant windowsConstant = WindowsConstant.CreateInstance();

            PasswordChar = windowsConstant.TextBoxPasswordChar;
            Font = new System.Drawing.Font(windowsConstant.TextBoxPasswordFont, 8.25F);
            ForeColor = Color.Red;
        }
        #endregion

        #region SetPositiveIntegerMask
        private void SetPositiveIntegerMask()
		{
			KeyPress += new KeyPressEventHandler(TextBox_KeyPress_PositiveInteger);
		}

		private void TextBox_KeyPress_PositiveInteger(object sender, KeyPressEventArgs e)
		{
			if (e.KeyChar == (char)8)// Allow backspace
			{
				e.Handled = false;
			}
			else if (Char.IsNumber(e.KeyChar))
			{
				if (Int64.Parse(Text + e.KeyChar, GeneralConstant.CreateInstance().StattracCulture) <= int.MaxValue)
					e.Handled = false;
				else
					e.Handled = true;
			}
			else
			{
				e.Handled = true;
			}
		}
		#endregion

		#region SetReadOnly
		/// <summary>
		/// Set the control to readonly
		/// </summary>
		private void SetReadOnly()
		{
			ReadOnly = true;
			TabStop = false;
			Enter += new EventHandler(TextBox_Enter);
		}

		/// <summary>
		/// When the user sets focus on this then set the focus on the parent
		/// </summary>
		/// <param name="sender"></param>
		/// <param name="e"></param>
		private void TextBox_Enter(object sender, EventArgs e)
		{
			Parent.Focus();
		}
		#endregion

		#region SetDecimalMask
		/// <summary>
		/// Set the mask for Decimal number
		/// </summary>
		private void SetDecimalMask()
		{
			KeyPress += new KeyPressEventHandler(TextBox_KeyPress_Decimal);
		}
        private void SetPhoneMask()
        {
           
        }

		/// <summary>
		/// Only accept the number if it is a valid decimal number
		/// </summary>
		/// <param name="sender"></param>
		/// <param name="e"></param>
		private void TextBox_KeyPress_Decimal(object sender, KeyPressEventArgs e)
		{
			try
			{
				// Allow backspace
				if (e.KeyChar == (char)8)
				{
					e.Handled = false;
				}
				else
				{
					// Only accept if this is a valid Decimal
					Decimal.Parse(Text + e.KeyChar, GeneralConstant.CreateInstance().StattracCulture);
					e.Handled = false;
				}
			}
			catch (Exception)
			{
				e.Handled = true;
			}
		} 
		#endregion
	}
}
