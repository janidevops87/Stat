using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Drawing.Text;
using System.Text;
using System.Collections;
using System.Windows.Forms;
using Infragistics.Win.UltraWinGrid;
using Statline.Stattrac.Windows.Forms;
using Statline.Stattrac.Data.Types.SourceCode;
using Statline.Stattrac.Constant;
using Statline.Stattrac.Constant.GridColumns;
using Statline.Stattrac.BusinessRules.SourceCode;
using Statline.Stattrac.Framework;
using Statline.Stattrac.BusinessRules.Framework;


namespace Statline.Stattrac.Windows.Controls.Administration.SourceCode
{
    public partial class SourceCodeSourceCodeControl : Statline.Stattrac.Windows.UI.BaseEditControl
    {
        private SourceCodeDS sourceCodeDS; 
        private CurrencyManager _currencyManager;
        private DataView sourceCodeDonorTracURLDv;
        private DataView sourceCodeSourceCodeDv;
        public Boolean IsNewSourceCode;
        public SourceCodeSourceCodeControl()
        {
            InitializeComponent();
            InitializeControls();
            DisplayPanels();

            // Create instance of roles
            Security.SecurityHelper securityHelper = Security.SecurityHelper.GetInstance();

            // Set default access 
            chkInactive.Enabled = false;

            // Check if User has permissions
            if (securityHelper.Authorized(SecurityRule.Set_Source_Code_Inactive.ToString()))
            {
                chkInactive.Enabled = true;
            }
            CheckSourceCodeAccess();

        }

        public bool CheckSourceCodeAccess()
        {
            // Create instance of roles
            Security.SecurityHelper securityHelper = Security.SecurityHelper.GetInstance();

            if (securityHelper.Authorized(SecurityRule.Add_Source_Code.ToString()) && IsNewSourceCode)
            {
                txtSourceCode.Enabled = true;
                return true;
            }
            else
            {
                if (securityHelper.Authorized(SecurityRule.Modify_Source_Code_Name.ToString()))
                {
                    txtSourceCode.Enabled = true;
                    return true;
                }
                else
                {
                    txtSourceCode.Enabled = false;
                    return false;
                }
                
            }
        }

        private bool IsTextBinding;
        /// <summary>
        /// Bind the data to the UI
        /// </summary>
        public override void BindDataToUI()
        {
            sourceCodeDS = (SourceCodeDS)BusinessRule.AssociatedDataSet;
            if (sourceCodeDS == null)
                return;

            //General Information
            string tableName = sourceCodeDS.SourceCode.TableName.ToString();
            string sourceCodeASP = sourceCodeDS.SourceCodeASP.TableName.ToString();
            string donorTracURL = sourceCodeDS.DonorTracURL.TableName.ToString();

            chkInactive.BindDataSet(sourceCodeDS, tableName, sourceCodeDS.SourceCode.InactiveColumn.ColumnName);
            chkASPSourceCode.BindDataSet(sourceCodeDS, sourceCodeASP, sourceCodeDS.SourceCodeASP.ASPColumn.Caption);
            txtSourceCode.BindDataSet(sourceCodeDS, tableName, sourceCodeDS.SourceCode.SourceCodeNameColumn.ColumnName);
            cbFullName.BindDataSet(sourceCodeDS, tableName, sourceCodeDS.SourceCode.SourceCodeOrgIDColumn.ColumnName);
            chkDefaultCallType.BindDataSet(sourceCodeDS, tableName, sourceCodeDS.SourceCode.SourceCodeDefaultColumn.ColumnName);

            //DornorTrac Setup
            chkDonorTracClient.BindDataSet(sourceCodeDS, tableName, sourceCodeDS.SourceCode.SourcecodeDonorTracClientColumn.ColumnName);

            //DonorTracClientIdentifier
            ugDonorTracClientIdentifier.UltraGridType = UltraGridType.AddEdit;
            ugDonorTracClientIdentifier.DataMember = sourceCodeDS.DonorTracIdentifier.TableName;
            ugDonorTracClientIdentifier.DataSource = sourceCodeDS;

            BindValueList();

            //Set SourceCode MaxLength 
            int sourceCodeMaxLength = 6;
            txtSourceCode.MaxLength = sourceCodeMaxLength;
            rtfDefaultAlert.MaxLength = 500;
        }

        private void FilterDonorTracURL()
        {
            //txtDonorTracURL.Text = String.Empty;
            sourceCodeSourceCodeDv = new DataView(sourceCodeDS.SourceCode);
            sourceCodeSourceCodeDv.RowFilter = "SourceCodeID = " + GRConstant.SourceCodeId.ToString();
            if (sourceCodeSourceCodeDv.Count > 0)
            {
                if ((bool)sourceCodeSourceCodeDv[GRConstant.FirstRow]["SourceCodeDonorTracClient"])
                {
                    ugDonorTracClientIdentifier.Enabled = true;
                    txtDonorTracURL.Enabled = true;
                    sourceCodeDonorTracURLDv = new DataView(sourceCodeDS.DonorTracURL);
                    sourceCodeDonorTracURLDv.RowFilter = "SourceCodeID = " + GRConstant.SourceCodeId.ToString();
                }
                else
                {
                    txtDonorTracURL.Text = String.Empty;
                    ugDonorTracClientIdentifier.Enabled = false;
                    txtDonorTracURL.Enabled = false;
                }
            }
        }



        private void InitializeControls()
        {
            //Reset Constants - Initialize Controls
            GRConstant.CallTypeId = 0;

            // Do not reset SourceCodeCallTypeID if comming from Pop-up form
            if (GRConstant.OpenSourceCode != AppScreenType.SourceCodeSourceCode)
            {
                GRConstant.SourceCodeCallTypeId = 0;
            }

            GRConstant.SourceCodeId = 0;
            txtSourceCode.CausesValidation = true;
            chkDefaultCallType.CausesValidation = true;

          
            //Format RTF Controls Greeting and Default Alerts area: 
            //Add Font Family
            string familyName;
            FontFamily[] fontFamilies;
            InstalledFontCollection installedFontCollection = new InstalledFontCollection();
            fontFamilies = installedFontCollection.Families;
            int count = fontFamilies.Length;
            for (int j = 0; j < count; ++j)
            {
                if (    //Only allow fonts with usable styles
                        fontFamilies[j].IsStyleAvailable(FontStyle.Regular)&&
                        fontFamilies[j].IsStyleAvailable(FontStyle.Bold) &&
                        fontFamilies[j].IsStyleAvailable(FontStyle.Italic) &&
                        fontFamilies[j].IsStyleAvailable(FontStyle.Underline)
                   )
                {
                    familyName = fontFamilies[j].Name.ToString();
                    cbFont.Items.Add(familyName);
                }
            }

            //Add FontSize
            int startFontSize = 6;
            int endFontSize = 150;
            for (int i = startFontSize + 1; i < endFontSize + 1; ++i)
            {
                cbFontSize.Items.Add(i.ToString());
            }
            //Add Defaults if required here:
            cbFont.SelectedItem = "Arial";
            cbFontSize.SelectedItem = "10";
            
            int rtfAlertMaxLength = 250;
            rtfDefaultAlert.MaxLength = rtfAlertMaxLength;

        }
        public void BindValueList()
        {
            Hashtable paramList = new Hashtable();


            //Associated SourceCodes
            ugAssociatedSourceCodes.DataSource = null;
            paramList.Add("SourceCodeCallTypeID", GRConstant.SourceCodeCallTypeId);
            paramList.Add("DisplayAllSourceCodes", GRConstant.SourceCodeDisplayAll);
            paramList.Add("StatEmployeeUserId", StattracIdentity.Identity.UserId);
            ugAssociatedSourceCodes.UltraGridType = UltraGridType.AddEdit;
            ugAssociatedSourceCodes.DataMember = sourceCodeDS.AspSourceCodeMap.TableName;
            ugAssociatedSourceCodes.DataSource = sourceCodeDS;
            ugAssociatedSourceCodes.BindValueList("SourceCodeCallTypeListSelect", sourceCodeDS.AspSourceCodeMap.AspSourceCodeIDColumn.ColumnName, sourceCodeDS.AspSourceCodeMap, sourceCodeDS.AspSourceCodeMap.AspSourceCodeNameColumn.ColumnName, paramList);
            paramList.Clear();

            //Associated Import Offer Transplant Centers
            paramList.Add("SourceCodeID", GRConstant.SourceCodeId);
            ugAssociatedImportOfferTransplantCenters.UltraGridType = UltraGridType.AddEdit;
            ugAssociatedImportOfferTransplantCenters.DataMember = sourceCodeDS.SourceCodeTransplantCenter.TableName;
            ugAssociatedImportOfferTransplantCenters.DataSource = sourceCodeDS;
            ugAssociatedImportOfferTransplantCenters.BindValueList("SourceCodeTransplantCenterListSelect", sourceCodeDS.SourceCodeTransplantCenter.OrganizationIDColumn.ColumnName, sourceCodeDS.SourceCodeTransplantCenter, sourceCodeDS.SourceCodeTransplantCenter.TransplantCodeColumn.ColumnName);
            ugAssociatedImportOfferTransplantCenters.BindValueList("SourceCodeOrganizationListSelect", sourceCodeDS.SourceCodeTransplantCenter.MessageOrganizationIDColumn.ColumnName, sourceCodeDS.SourceCodeTransplantCenter, sourceCodeDS.SourceCodeTransplantCenter.MessageOrganizationNameColumn.ColumnName, paramList);
            paramList.Clear();
        }
        public void BindSelectSourceCodeOrganizationValueList()
        {
            Hashtable paramList = new Hashtable();

            //Only load Organizaqtions list if not existing
            if (cbFullName.Items.Count < 1)
            {
                //refresh list of organizations and select default if id exists
                cbFullName.DataSource = null;
                paramList.Add("UserOrganizationID", StattracIdentity.Identity.UserOrganizationId);
                cbFullName.BindData("SourceCodeOrganizationListSelect", paramList);
                paramList.Clear();
            }
        
        }

        
        private void FindSourceCodeOrganizationFullName()
        {
            //if source code organization exists, select it. 
            sourceCodeSourceCodeDv = new DataView(sourceCodeDS.SourceCode);
            sourceCodeSourceCodeDv.RowFilter = "SourceCodeID = " + GRConstant.SourceCodeId;
            if (sourceCodeSourceCodeDv.Count > 0)
            {
                if (sourceCodeSourceCodeDv[GRConstant.FirstRow]["SourceCodeOrgID"] != System.DBNull.Value)
                {
                    cbFullName.SelectedValue = sourceCodeSourceCodeDv[GRConstant.FirstRow]["SourceCodeOrgID"].ToString();
                }
            }
        }
        private void FilterDonorTracClientIdentifierGrid()
        {
            const int band = 0;
            //Clear Filters
            ugDonorTracClientIdentifier.DisplayLayout.Bands[band].ColumnFilters.ClearAllFilters();
           
            //Create Filter condition on SourceCodeID
            FilterCondition sourceCodeIdFilter = new FilterCondition(FilterComparisionOperator.Equals, GRConstant.SourceCodeId);

            ugDonorTracClientIdentifier.DisplayLayout.Bands[band].ColumnFilters[sourceCodeDS.DonorTracIdentifier.SourceCodeIDColumn.ColumnName].
                FilterConditions.Add(sourceCodeIdFilter);
        
        }
        private void FilterAssociatedSourceCodesGrid()
        {
            const int band = 0;
            //Clear Filters
            ugAssociatedSourceCodes.DisplayLayout.Bands[band].ColumnFilters.ClearAllFilters();

            // Create Filter condition on SourceCodeID
            FilterCondition sourceCodeIdFilter = new FilterCondition(FilterComparisionOperator.Equals, GRConstant.SourceCodeId);

            ugAssociatedSourceCodes.DisplayLayout.Bands[band].ColumnFilters[sourceCodeDS.AspSourceCodeMap.SourceCodeIDColumn.ColumnName].
                FilterConditions.Add(sourceCodeIdFilter);

        }
        private void FilterAssociatedImportOfferTransplantCentersGrid()
        {
            const int band = 0;
            //Clear Filters
            ugAssociatedImportOfferTransplantCenters.DisplayLayout.Bands[band].ColumnFilters.ClearAllFilters();

            // Create Filter condition on SourceCodeID
            FilterCondition sourceCodeIdFilter = new FilterCondition(FilterComparisionOperator.Equals, GRConstant.SourceCodeId);

            ugAssociatedImportOfferTransplantCenters.DisplayLayout.Bands[band].ColumnFilters[sourceCodeDS.SourceCodeTransplantCenter.SourceCodeIDColumn.ColumnName].
                FilterConditions.Add(sourceCodeIdFilter);
            
            if (GRConstant.CallTypeId != Convert.ToInt32(SourceCodeListCallType.Import)|| GRConstant.SourceCodeId == 0) 
            {
                gbAssociatedImportOfferTransplantCenters.Enabled = false;
            }
            else
            {
                gbAssociatedImportOfferTransplantCenters.Enabled = true;
            }

        }
        public void SetCurrentRow()
        {
            ((SourceCodeBR)BusinessRule).Select();

            BindSourceCodeDefaultAlert();
            BindValueList();
            BindSelectSourceCodeOrganizationValueList();
            BindDonorTracURL();
            FindSourceCodeOrganizationFullName();
            FilterDonorTracURL();
            FilterDonorTracClientIdentifierGrid();
            FilterAssociatedSourceCodesGrid();
            FilterAssociatedImportOfferTransplantCentersGrid();
            
            //Enable DonorTrac Client if Calltype is Referral
            EnableDonorTracClientForReferral();

        }
        public void DisplayAssociatedImportOfferTransplantCenters()
        {
            if (GRConstant.SourceCodeCallTypeId != Convert.ToInt32(SourceCodeListCallType.Import)) 
            {
                gbAssociatedImportOfferTransplantCenters.Visible = false;
            }
            else
            {
                gbAssociatedImportOfferTransplantCenters.Visible = true;
            }

        }
        public void DisplayPanels()
        {
            if (IsNewSourceCode || GRConstant.SourceCodeId > 0)
            {
                gbGeneralInformation.Enabled = true; 
                gbAssociatedSourceCodes.Enabled = true;
                gbDonorTracSetup.Enabled = true;
                gbFormatGreetingAndDefaultAlert.Enabled = true;
                gbAssociatedImportOfferTransplantCenters.Enabled = true;
            }
            else
            {
                gbGeneralInformation.Enabled = false;
                gbAssociatedSourceCodes.Enabled = false;
                gbDonorTracSetup.Enabled = false;
                gbFormatGreetingAndDefaultAlert.Enabled = false;
                gbAssociatedImportOfferTransplantCenters.Enabled = false;
            }

        }
        public void SetDefaultDonorTracURL()
        {
            EnableDonorTractClient();
            SetDonorTracURLDefaultText();
        }

        public void BindSourceCodeDefaultAlertNewRecord()
        {
            rtfDefaultAlert.DataBindings.Clear();
            sourceCodeSourceCodeDv = new DataView(sourceCodeDS.SourceCode);
            rtfDefaultAlert.DataBindings.Add("Rtf", sourceCodeSourceCodeDv, sourceCodeDS.SourceCode.SourceCodeDefaultAlertColumn.ColumnName);
        }



        private void BindSourceCodeDefaultAlert()
        {
            sourceCodeSourceCodeDv = new DataView(sourceCodeDS.SourceCode);
            sourceCodeSourceCodeDv.RowFilter = "SourceCodeID = " + GRConstant.SourceCodeId;
            rtfDefaultAlert.DataBindings.Clear();

            if (sourceCodeSourceCodeDv.Count < 1)
                return;

            string rtfAlertMessage = sourceCodeSourceCodeDv[GRConstant.FirstRow]["SourceCodeDefaultAlert"].ToString();
            string rtfValue = "{\\rtf1";

            if (rtfAlertMessage.Contains(rtfValue))
            {
                rtfDefaultAlert.DataBindings.Add("Rtf", sourceCodeSourceCodeDv, sourceCodeDS.SourceCode.SourceCodeDefaultAlertColumn.ColumnName);
            }
            else
            {
                rtfDefaultAlert.DataBindings.Add("Text", sourceCodeSourceCodeDv, sourceCodeDS.SourceCode.SourceCodeDefaultAlertColumn.ColumnName);
                IsTextBinding = true;
            }
        }

        private void BindDonorTracURL()
        {
            sourceCodeDonorTracURLDv = new DataView(sourceCodeDS.DonorTracURL);
            sourceCodeDonorTracURLDv.RowFilter = "SourceCodeID = " + GRConstant.SourceCodeId.ToString();
            if (sourceCodeDonorTracURLDv.Count < 1)
                return;

            txtDonorTracURL.DataBindings.Clear();
            txtDonorTracURL.DataBindings.Add("Text", sourceCodeDonorTracURLDv, sourceCodeDS.DonorTracURL.DonorTracProductionURLColumn.ColumnName);
        }

        private void EnableDonorTractClient()
        {
            if ((bool)chkDonorTracClient.Checked == true && GRConstant.SourceCodeCallTypeId == (int)SourceCodeListCallType.Referral)
            {
                ugDonorTracClientIdentifier.Enabled = true;
                txtDonorTracURL.Enabled = true;

                //Add empty row and default values if record does not exist
                SourceCodeDS sourceCodeDS = (SourceCodeDS)BusinessRule.AssociatedDataSet;
                if (sourceCodeDS == null)
                    return;

            }
            else
            {
                ugDonorTracClientIdentifier.Enabled = false;
                txtDonorTracURL.Enabled = false;

            }
        }

        private void EnableDonorTracClientForReferral()
        {
            if (GRConstant.SourceCodeCallTypeId == (int)SourceCodeListCallType.Referral)
            {
                chkDonorTracClient.Enabled = true;
            }
            else
            {
                chkDonorTracClient.Enabled = false;
            }
        }

        private void tb_TextChanged(object sender, EventArgs e)
        { 
        
        }


        private void chkDefaultCallType_CheckedChanged(object sender, EventArgs e)
        {

        }


        private void cbFullName_SelectedIndexChanged(object sender, EventArgs e)
        {
            SourceCodeDS sourceCodeDS = (SourceCodeDS)BusinessRule.AssociatedDataSet;
            if (sourceCodeDS == null)
                return;
            if (cbFullName.SelectedIndex > 0)
            {
                cbFullName.BindDataSet(sourceCodeDS, sourceCodeDS.SourceCode.TableName, sourceCodeDS.SourceCode.SourceCodeOrgIDColumn.ColumnName);
                _currencyManager = (CurrencyManager)BindingContext[sourceCodeDS, sourceCodeDS.SourceCode.TableName];
            }
        }
        public override void LoadDataFromUI()
        {
            Invalidate();
        }



        private void ugAssociatedSourceCodes_InitializeLayout(object sender, InitializeLayoutEventArgs e)
        {
            SourceCodeDS sourceCodeDS = (SourceCodeDS)BusinessRule.AssociatedDataSet;
            if (sourceCodeDS == null)
                return;
            const int band = 0;
            ugAssociatedSourceCodes.ColumnDisplay(band, typeof(SourceCodeAssociatedSourceCodes), sourceCodeDS.AspSourceCodeMap);

        }

        private void ugDonorTracClientIdentifier_InitializeLayout(object sender, InitializeLayoutEventArgs e)
        {
            SourceCodeDS sourceCodeDS = (SourceCodeDS)BusinessRule.AssociatedDataSet;
            if (sourceCodeDS == null)
                return;
            const int band = 0;
            ugDonorTracClientIdentifier.ColumnDisplay(band, typeof(SourceCodeDonorTracClientIdentifier), sourceCodeDS.DonorTracIdentifier);

        }

        private void SetDonorTracURLDefaultText()
        {
            //Set default text for DonorTracURL
            if (txtDonorTracURL.Text.Length == 0 && (bool)chkDonorTracClient.Checked)
            {
                string DefaultURL = BaseConfiguration.GetSetting(SettingName.DonorTracURLDefault);

                //Create record if not exist
                sourceCodeDonorTracURLDv = new DataView(sourceCodeDS.DonorTracURL);
                sourceCodeDonorTracURLDv.RowFilter = "SourceCodeID = " + GRConstant.SourceCodeId.ToString();
                
                if (sourceCodeDonorTracURLDv.Count == 0)
                {   //Create record if not exist
                    txtDonorTracURL.DataBindings.Clear();
                    txtDonorTracURL.DataBindings.Add("Text", sourceCodeDonorTracURLDv, sourceCodeDS.DonorTracURL.DonorTracProductionURLColumn.ColumnName);
                    
                    //Add row to data view
                    DataRowView rowView = sourceCodeDonorTracURLDv.AddNew();

                    //Set values
                    if (GRConstant.SourceCodeId > 0)
                    {
                        rowView["SourceCodeID"] = (int)(GRConstant.SourceCodeId);
                        rowView["SourceCode"] = GRConstant.SourceCodeName.ToString();
                        rowView["DonorTracProductionURL"] = DefaultURL.ToString();
                        rowView.EndEdit();
                        sourceCodeDonorTracURLDv.RowFilter = "SourceCodeID = " + GRConstant.SourceCodeId.ToString();
                    }
                    else
                    {
                        //This is a new record.
                        if (sourceCodeDS == null)
                            return;
                        sourceCodeDS.DonorTracURL.Rows[GRConstant.FirstRow]["SourceCode"] = txtSourceCode.Text.ToString();
                        sourceCodeDS.DonorTracURL.Rows[GRConstant.FirstRow]["DonorTracProductionURL"] = DefaultURL.ToString();
                        txtDonorTracURL.Text = DefaultURL.ToString();
                    }

                }
                if (txtDonorTracURL.Text.Length < 1)
                    txtDonorTracURL.Text = DefaultURL;
            }
        }
        private void ugAssociatedImportOfferTransplantCenters_InitializeLayout(object sender, InitializeLayoutEventArgs e)
        {
            SourceCodeDS sourceCodeDS = (SourceCodeDS)BusinessRule.AssociatedDataSet;
            if (sourceCodeDS == null)
                return;
            const int band = 0;
            ugAssociatedImportOfferTransplantCenters.ColumnDisplay(band, typeof(SourceCodeAssociatedImportOfferTransplantCenters), sourceCodeDS.SourceCodeTransplantCenter);
            e.Layout.Bands[band].Columns["OrganizationName"].CellActivation = Activation.NoEdit;
            e.Layout.Bands[band].Columns["OrganType"].CellActivation = Activation.NoEdit;
        }

        private void chkDonorTracClient_CheckedChanged(object sender, EventArgs e)
        {   
            //May need to move to another event type
            //EnableDonorTractClient();
        }

        private void tsRTF_Bold_Click(object sender, EventArgs e)
        {
            SetFontStyle(rtfDefaultAlert, FontStyle.Bold);
        }

        private void tsRTF_Italic_Click(object sender, EventArgs e)
        {
            SetFontStyle(rtfDefaultAlert, FontStyle.Italic);
        }

        private void tsRTF_underline_Click(object sender, EventArgs e)
        {
            SetFontStyle(rtfDefaultAlert, FontStyle.Underline);
        }
        
        private void SetFontStyle(Statline.Stattrac.Windows.Forms.RichTextBox rtb, FontStyle style)
        {
            int selectionStart = rtb.SelectionStart;
            int selectionLength = rtb.SelectionLength;
            try
            {
                rtb.SelectionFont = new Font(rtb.SelectionFont, rtb.SelectionFont.Style ^ style);
            }
            catch (Exception ex)
            {
                BaseLogger.LogFormUnhandledException(ex, this);
                //if this font does not exist with existing font type then select default
                rtb.SelectionFont = new Font("Arial", 10);

            }
            finally
            {
                rtb.Select(selectionStart, selectionLength);
            }
        }

        private void tsRTF_color_Click(object sender, EventArgs e)
        {
            ColorDialog colorDialog = new ColorDialog();
            // Set the initial color of the dialog to the current text color.
            colorDialog.Color = rtfDefaultAlert.SelectionColor;

            // Determine if the user clicked OK in the dialog and that the color has changed.
            if (colorDialog.ShowDialog() == System.Windows.Forms.DialogResult.OK &&
               colorDialog.Color != rtfDefaultAlert.SelectionColor)
            {
                // Change the selection color to the user specified color.
                rtfDefaultAlert.SelectionColor = colorDialog.Color;
            }

        }

        private void tsRTF_left_Click(object sender, EventArgs e)
        {
            rtfDefaultAlert.SelectionAlignment = HorizontalAlignment.Left;
            
        }

        private void tsRTF_center_Click(object sender, EventArgs e)
        {
            rtfDefaultAlert.SelectionAlignment = HorizontalAlignment.Center;
        }

        private void tsRTF_right_Click(object sender, EventArgs e)
        {
            rtfDefaultAlert.SelectionAlignment = HorizontalAlignment.Right;
        }

        private void tsRTF_Bullet_Click(object sender, EventArgs e)
        {
            if (rtfDefaultAlert.SelectionBullet)
            {
                rtfDefaultAlert.SelectionBullet = false;
            }
            else
            {
                rtfDefaultAlert.SelectionBullet = true;
            }
        }

        private void cbFont_SelectedIndexChanged(object sender, EventArgs e)
        {
           string  currentFontStyle = cbFont.SelectedItem.ToString();
            try
            {
                float currentFontSize = rtfDefaultAlert.SelectionFont.Size;
                rtfDefaultAlert.SelectionFont = new Font(currentFontStyle, currentFontSize);
            }
            catch (Exception ex)
            {
                BaseLogger.LogFormUnhandledException(ex, this);
                //if this font does not exist with existing font type then select default
                rtfDefaultAlert.SelectionFont = new Font("Arial", 10);

            }
        }

        private void cbFontSize_SelectedIndexChanged(object sender, EventArgs e)
        {   
            if (rtfDefaultAlert.SelectionFont == null)
                return;

            string currentFontStyle = rtfDefaultAlert.SelectionFont.Name;
            float currentFontSize = Convert.ToInt64(cbFontSize.SelectedItem.ToString());
            try
            {
                rtfDefaultAlert.SelectionFont = new Font(currentFontStyle, currentFontSize);
            }
            catch (Exception ex)
            {
                BaseLogger.LogFormUnhandledException(ex, this);
                //if this font does not exist with existing size then select default
                rtfDefaultAlert.SelectionFont = new Font("Arial", 10);
            }

            rtfDefaultAlert.SelectionFont = new Font(currentFontStyle, currentFontSize);
        }


        private void gbGeneralInformation_Enter(object sender, EventArgs e)
        {

        }


        private void rtfDefaultAlert_Leave(object sender, EventArgs e)
        {
            if ((bool)IsTextBinding)
            {
                SourceCodeDS sourceCodeDS = (SourceCodeDS)BusinessRule.AssociatedDataSet;
                if (sourceCodeDS == null)
                    return;

                //If IsTextBinding is true then update the data view with rtf data and re-bind. Set IsTextBinding false
                //to prevent unessary re-binding.
                sourceCodeSourceCodeDv[GRConstant.FirstRow]["SourceCodeDefaultAlert"] = rtfDefaultAlert.Rtf;
                rtfDefaultAlert.DataBindings.Clear();
                rtfDefaultAlert.DataBindings.Add("Rtf", sourceCodeSourceCodeDv, sourceCodeDS.SourceCode.SourceCodeDefaultAlertColumn.ColumnName);
                IsTextBinding = false;
            }
        }

        private void chkDonorTracClient_MouseClick(object sender, MouseEventArgs e)
        {
            EnableDonorTractClient();
            SetDonorTracURLDefaultText();
        }

        public void SetSourceCodeFocus()
        {
            // Create instance of roles
            Security.SecurityHelper securityHelper = Security.SecurityHelper.GetInstance();

            if (securityHelper.Authorized(SecurityRule.Add_Source_Code.ToString()))
            {
                txtSourceCode.Enabled = true;
                txtSourceCode.Select();
            }

        }

        private void chkASPSourceCode_CheckStateChanged(object sender, EventArgs e)
        {
            if ((bool)chkASPSourceCode.Checked == true)
            {
                ////Add empty row and set default values
                SourceCodeDS sourceCodeDS = (SourceCodeDS)BusinessRule.AssociatedDataSet;
                if (sourceCodeDS == null)
                    return;
                if (sourceCodeDS.SourceCodeASP.Count == 0)
                {
                    ((SourceCodeBR)BusinessRule).AddDefaultData(sourceCodeDS.SourceCodeASP);
                }

            }
        }
        
        private void ugAssociatedImportOfferTransplantCenters_AfterCellUpdate(object sender, CellEventArgs e)
        {
            Stattrac.Windows.Forms.UltraGrid grid = (Stattrac.Windows.Forms.UltraGrid)sender;

            // Turn off the event to prevent recursion   
            grid.EventManager.SetEnabled(GridEventIds.AfterCellUpdate, false);

            try
            {
                if (e.Cell.Column.Key == "OrganizationID")
                {   //Testing Concept Code
                    // If the TransplantCenter is changed
                    char[] delimiterChars = { '|' };
                    string[] transplantCenterInfo = e.Cell.Row.Cells["OrganizationID"].Text.Split(delimiterChars);
                    e.Cell.Row.Cells["TransplantCode"].Value = transplantCenterInfo[0].ToString();
                    e.Cell.Row.Cells["OrganizationName"].Value = transplantCenterInfo[1].ToString();
                    e.Cell.Row.Cells["OrganType"].Value = transplantCenterInfo[2].ToString();
                }
            }
            finally
            {
                // Re-enabled this event.   
                grid.EventManager.SetEnabled(GridEventIds.AfterCellUpdate, true);
            }
        }

        #region Validation Logic and Notifications
        
        // DefaultCallType
        public bool ValidDefaultCallType(object sender, out string errorMessage)
        {

            string SourceCodeName;
            SourceCodeName = txtSourceCode.Text.ToUpper();

            if (_currencyManager == null)
                _currencyManager = (CurrencyManager)BindingContext[sourceCodeDS, sourceCodeDS.SourceCode.TableName];

            //perform duplicate check if adding or modifing Source Code row
            if (((System.Data.DataRowView)(_currencyManager.List[GRConstant.FirstRow])).IsEdit ||
                ((System.Data.DataRowView)(_currencyManager.List[GRConstant.FirstRow])).IsNew ||
                 (bool)chkDefaultCallType.Checked)
            {
                //perform duplicate check only if Default box is checked
                if ((bool)chkDefaultCallType.Checked)
                {
                    //if another source code exists as a default, show error message. 
                    if (((SourceCodeBR)BusinessRule).CheckForExistingDefaultSourceCode(GRConstant.SourceCodeId, SourceCodeName) > 0)
                    {
                        //SourceCode with that name was found as default. Present warning.
                        errorMessage = "This Source Code cannnot be set as default. \nAnother Source Code with that name \nis already set as a Default Call Type.";
                        //this.chkDefaultCallType.Checked = false;
                        return false;
                    }

                }
            }
            //Default Call type is valid
            errorMessage = String.Empty;
            return true;
        }
        
        // SourceCode
        public bool ValidSourceCode(string sourceCodeName, out string errorMessage)
        {
            string SourceCodeName;
            int SourceCodeID;
            //remove trailing/leading spaces and convert to upper case
            SourceCodeName = sourceCodeName.Trim().ToUpper();
            txtSourceCode.Text = SourceCodeName;

            SourceCodeDS sourceCodeDS = (SourceCodeDS)BusinessRule.AssociatedDataSet;
            if (sourceCodeDS.SourceCode.Count > 0)
            {
                if (_currencyManager == null)
                    _currencyManager = (CurrencyManager)BindingContext[sourceCodeDS, sourceCodeDS.SourceCode.TableName];

                //perform duplicate check if adding or modifing Source Code row
                if (
                    //(SourceCodeName != GRConstant.SourceCodeName) || (_currencyManager.Count == 0) &&
                    ((System.Data.DataRowView)(_currencyManager.List[GRConstant.FirstRow])).IsEdit ||
                    ((System.Data.DataRowView)(_currencyManager.List[GRConstant.FirstRow])).IsNew
                   )
                {
                    //Use SourceCodeID If this is not a new record Else use new record value of zero.
                    SourceCodeID = IsNewSourceCode ? GRConstant.FirstRow : GRConstant.SourceCodeId;

                    if (((SourceCodeBR)BusinessRule).CheckForSourceCodeDuplicates(SourceCodeID, SourceCodeName, GRConstant.SourceCodeCallTypeId) > 0)
                    {
                        //SourceCode with that name was found. Present warning.
                        errorMessage = "A Source Code with that name already exists. \nPlease enter another Source Code name.";
                        return false;
                    }

                    if (SourceCodeName.Length < 1)
                    {
                        //SourceCodeName can not be blank. Present warning.
                        errorMessage = "Source Code can not be blank. \nPlease enter valid Source Code name.";
                        return false;
                    }
                }
            }
            IsNewSourceCode = false;
            errorMessage = String.Empty;
            return true;
        }

        // DonorTracURL 
        public bool ValidDonorTracURL(string donorTracURL, out string errorMessage)
        {
            string DonorTracURL;

            //remove trailing/leading spaces and convert to lower case
            DonorTracURL = donorTracURL.Trim().ToLower();
            txtDonorTracURL.Text = DonorTracURL;


            if ((bool)chkDonorTracClient.Checked && txtDonorTracURL.Enabled && GRConstant.SourceCodeCallTypeId == (int)SourceCodeListCallType.Referral)
            {
                if (txtDonorTracURL.Text.Length < 1)
                {
                    //txtDonorTracURL can not be blank. Present warning.
                    errorMessage = "DonorTrac URL can not be blank. \nPlease enter valid URL.";
                    return false;
                }
            }

            errorMessage = String.Empty;
            return true;
        }

        //DonorTrac Client identifier 
        public bool ValidDonorTracClientIdentifier(object sender, out string errorMessage)
        {

            if ((bool)chkDonorTracClient.Checked && txtDonorTracURL.Enabled && GRConstant.SourceCodeCallTypeId == (int)SourceCodeListCallType.Referral)
            {
                if (ugDonorTracClientIdentifier.Rows.Count < 1)
                {
                    // Present warning.
                    errorMessage = "The DonorTrac Client Identifier is a required field \nwhen the DonorTrac Client checkbox is checked";
                    return false;
                }
            }

            errorMessage = String.Empty;
            return true;
        }

        #endregion
        #region Validating Events
        //DefaultCallType
        private void chkDefaultCallType_Validating(object sender, CancelEventArgs e)
        {
            string errorMsg;
            if (!ValidDefaultCallType(sender, out errorMsg))
            {
                // Cancel the event and select the text to be corrected by the user.
                e.Cancel = true;
                chkDefaultCallType.Select();

                // Set the ErrorProvider error with the text to display. 
                this.errorProvider1.SetError(chkDefaultCallType, errorMsg);
            }
        }

        // SourceCode
        private void txtSourceCode_Validating(object sender, CancelEventArgs e)
        {
            string errorMsg;
            if (!ValidSourceCode(txtSourceCode.Text, out errorMsg))
            {
                // Cancel the event and select the text to be corrected by the user.
                e.Cancel = true;
                txtSourceCode.Select(0, txtSourceCode.Text.Length);

                // Set the ErrorProvider error with the text to display. 
                this.errorProvider1.SetError(txtSourceCode, errorMsg);
            }

        }
        // DonorTracURL
        private void txtDonorTracURL_Validating(object sender, CancelEventArgs e)
        {
            string errorMsg;
            if (!ValidDonorTracURL(txtDonorTracURL.Text, out errorMsg))
            {
                // Cancel the event and select the text to be corrected by the user.
                e.Cancel = true;
                txtDonorTracURL.Select(0, txtDonorTracURL.Text.Length);

                // Set the ErrorProvider error with the text to display. 
                this.errorProvider1.SetError(txtDonorTracURL, errorMsg);
            }
        }
        // DonorTracClientIdentifier
        private void ugDonorTracClientIdentifier_Validating(object sender, CancelEventArgs e)
        {
            string errorMsg;
            if (!ValidDonorTracClientIdentifier(sender, out errorMsg))
            {
                // Cancel the event and select the text to be corrected by the user.
                e.Cancel = true;
                ugDonorTracClientIdentifier.Select();

                // Set the ErrorProvider error with the text to display. 
                this.errorProvider1.SetError(ugDonorTracClientIdentifier, errorMsg);
            }
        }
        #endregion
        #region Validated Events

        private void chkDefaultCallType_Validated(object sender, EventArgs e)
        {
            // If all conditions have been met, clear the ErrorProvider of errors.
            errorProvider1.SetError(chkDefaultCallType, "");
        }

        private void txtSourceCode_Validated(object sender, EventArgs e)
        {
            // If all conditions have been met, clear the ErrorProvider of errors.
            errorProvider1.SetError(txtSourceCode, "");
        }

        private void txtDonorTracURL_Validated(object sender, EventArgs e)
        {
            // If all conditions have been met, clear the ErrorProvider of errors.
            errorProvider1.SetError(txtDonorTracURL, "");
        }

        private void ugDonorTracClientIdentifier_Validated(object sender, EventArgs e)
        {
            // If all conditions have been met, clear the ErrorProvider of errors.
            errorProvider1.SetError(ugDonorTracClientIdentifier, "");
        }
#endregion
    }
}
