using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace Statline.Stattrac.Windows.Utility
{
    public static class ControlHelper
    {


        /// <summary>
        /// Bret Knoll 5/12/2011
        /// Created to disable all controls without disabling main control
        /// </summary>
        public static void EnableAllControls(Control control, Boolean enable)
        {
            // 1. for each control look for controls of type TextBox, checkBox, comboBox, etc
            // .1 specify the type of items from the list to get with OfType 
            // .2 Convert the IQueryable to a list with .ToList
            
            #region disable userControls TextBox, checkBox, comboBox, etc
            control.SuspendLayout();
            var textBox = control.Controls.OfType<Statline.Stattrac.Windows.Forms.TextBox>().ToList();
            textBox.ForEach(currentTextBox =>
                currentTextBox.Enabled = enable
                );

            var checkBox = control.Controls.OfType<Statline.Stattrac.Windows.Forms.CheckBox>().ToList();
            checkBox.ForEach(currentCheckBox =>
                currentCheckBox.Enabled = enable
                );
            
            var checkedListBox = control.Controls.OfType<Statline.Stattrac.Windows.Forms.CheckedListBox>().ToList();
            checkedListBox.ForEach(currentCheckedListBox =>
                currentCheckedListBox.Enabled = enable
                );
            var comboBox = control.Controls.OfType<Statline.Stattrac.Windows.Forms.ComboBox>().ToList();
            comboBox.ForEach(currentComboBox =>
                currentComboBox.Enabled = enable
                );

            var dateTimePicker = control.Controls.OfType<Statline.Stattrac.Windows.Forms.DateTimePicker>().ToList();
            dateTimePicker.ForEach(currentDateTimePicker =>
                currentDateTimePicker.Enabled = enable
                );

            var listBox = control.Controls.OfType<Statline.Stattrac.Windows.Forms.ListBox>().ToList();
            listBox.ForEach(currentListBox =>
                currentListBox.Enabled = enable
                );

            var listView = control.Controls.OfType<Statline.Stattrac.Windows.Forms.ListView>().ToList();
            listView.ForEach(currentListView =>
                currentListView.Enabled = enable
                );

            var maskedTextBox  = control.Controls.OfType<Statline.Stattrac.Windows.Forms.MaskedTextBox>().ToList();
            maskedTextBox.ForEach(currentMaskedTextBox =>
                currentMaskedTextBox.Enabled = enable
                );

            var radioButton = control.Controls.OfType<Statline.Stattrac.Windows.Forms.RadioButton>().ToList();
            radioButton.ForEach(currentRadioButton =>
                currentRadioButton.Enabled = enable
                );
            var richTextBox = control.Controls.OfType<Statline.Stattrac.Windows.Forms.RichTextBox>().ToList();
            richTextBox.ForEach(currentRichTextBox =>
                currentRichTextBox.Enabled = enable
                );

            var ultraGrid = control.Controls.OfType<Statline.Stattrac.Windows.Forms.UltraGrid>().ToList();
            ultraGrid.ForEach(currentUltraGrid =>
                currentUltraGrid.Enabled = enable
                );
            control.ResumeLayout();
            #endregion

            // 2. for each control recall this method
            #region recall self to recurse
            var controls = control.Controls.OfType<Control>().ToList();

            controls.ForEach(currentControl => EnableAllControls(currentControl, enable));
            #endregion
            

        }
    }
}
