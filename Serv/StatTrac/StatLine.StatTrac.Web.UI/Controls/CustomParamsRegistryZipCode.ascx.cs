using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Statline.Registry.Data.Types.Reports;
using Infragistics.WebUI.UltraWebGrid;
using Statline.StatTac.Web.UI.Controls;

namespace Statline.StatTrac.Web.UI.Controls
{
    public partial class CustomParamsRegistryZipCode :
        Statline.StatTrac.Web.UI.BaseUserControl,
        Statline.StatTrac.Web.UI.IBaseParameters
    {
        protected CheckBoxList localchkBoxListState;
        protected Statline.Registry.Data.Types.Reports.RegistryData dsRegData;
        protected Statline.Registry.Data.Types.Reports.RegistryData dsSelectedRegData;        
        protected string state;
        protected string zipCode;
        protected Boolean paramsChanged = false;
        
        protected void Page_Load(object sender, EventArgs e)
        {
            //run the page_load if the control is being loaded.
            if(Visible == false)
                return;
            localChkBoxListState_Initialize();
            ManyZipCodesChecked_radioButtonZipCodeOptions();
            TopTenZipCodesChecked_radioButtonZipCodeOptions();                       
            if (!IsPostBack)
                return;
            Set_LocalchkBoxListState_EventHandler();
        }

        #region enum
        public enum ZipCodeOptions
        {
            Top10 = 1,
            Many = 2, 
            All = 3
        }
        #endregion

        #region Methods
        /// <summary>
        /// If radioButtonZipCodeOptions is 2 for Many Zip Codes turn on the state radio button postback
        /// </summary>
        protected void Set_LocalchkBoxListState_EventHandler()
        {
            if (localchkBoxListState != null)
            {                
                localchkBoxListState.TextChanged += new EventHandler(localchkBoxListState_TextChanged);
            }

        }

        protected void localchkBoxListState_AutoPostBack(Boolean visible)
        {
            if (localchkBoxListState == null)
            {
                localChkBoxListState_Initialize();
            }
            localchkBoxListState.AutoPostBack = visible;
             
        }
        protected Boolean ManyZipCodesChecked_radioButtonZipCodeOptions()
        {
            //2 is Select Many
            Boolean _return = false;
            _return = (Convert.ToInt32(radioButtonZipCodeOptions.SelectedValue) == Convert.ToInt32(ZipCodeOptions.Many));
            if (_return)
            {
                localchkBoxListState_AutoPostBack(true);
                PnlZipCodeCityRegion.Visible = true;                                
            }
            else
            {
                PnlZipCodeCityRegion.Visible = false;
                localchkBoxListState_AutoPostBack(false);
            }
                return _return;
        }

        protected void SetSelectedStates()
        {
            state = customParamsRegistryStateControZC.SelectedStates();
        }
        
        protected void SetParams_ZipCodeCityRegion()
        {
            SetSelectedStates();
            if (state.Length > 0 || paramsChanged )
                Load_gridZipCodeCityRegion();

            //DataBind();

        }

        protected Boolean TopTenZipCodesChecked_radioButtonZipCodeOptions()
        {
            //2 is Select Many
            Boolean _return = false;
            _return = (Convert.ToInt32(radioButtonZipCodeOptions.SelectedValue) == Convert.ToInt32(ZipCodeOptions.Top10));
            CustomParamsRegistryDonorDesignationStatus donordesignation = (CustomParamsRegistryDonorDesignationStatus)Parent.FindControl("CustomParamsRegistryDonorDesignationStatus");
            if (_return)
            {                                
                if(donordesignation != null)
                    ((CheckBox)donordesignation.FindControl("chkBoxTotalYes")).Enabled = false;

            }
            else
            {
                if (donordesignation != null)
                    ((CheckBox)donordesignation.FindControl("chkBoxTotalYes")).Enabled = true;                
                
            }
            return _return;
        }

        protected void localChkBoxListState_Initialize()
        {
            localchkBoxListState = (CheckBoxList)customParamsRegistryStateControZC.FindControl("chkBoxListState");
            state = "";
            zipCode = "";
        }
        
        protected void Load_gridZipCodeCityRegion()
        {
            if (localchkBoxListState == null)
            {
                localChkBoxListState_Initialize();
            }
            //try to set state
            if (state.Length < 1)
            {
                SetSelectedStates();  
            }
            if (state.Length < 1)
            {
                //dsRegData.ZipCodeCityRegion.Clear();
                gridZipCodeCityRegion.Clear();
                return;
            }
            /* Replace ODS with DataSet
            odsZipCodeCityRegion.SelectParameters["state"].DefaultValue = state;
            odsZipCodeCityRegion.DataBind();
             */
            gridZipCodeCityRegion.DataSourceID = null;
            gridZipCodeCityRegion.DataSource = dsRegData;
            gridZipCodeCityRegion.DataMember = "ZipCodeCityRegion";
            if (dsRegData == null)
                dsRegData = new RegistryData();
            Registry.Reports.RegistryReferenceManager.FillRegistryZipCodeCityRegion(dsRegData, state);
            //gridZipCodeCityRegion.DataBind();
        }

        protected void AddZipCode(string newZipCode)
        {
            //only add the zip code if it does not exist.
            if (txtBoxZipCode.Text.ToString().Contains(newZipCode))
                return;
            if (txtBoxZipCode.Text.ToString().Length > 0)
                    txtBoxZipCode.Text += ",";
            txtBoxZipCode.Text += newZipCode;
            //if (zipCode.Contains(newZipCode))
            //    return;
            //if (zipCode.Length > 0)
            //    zipCode += ",";            
            //zipCode += newZipCode;
        }

        protected void AdddsSelectedRegData(
            Boolean _checked, 
            string zipCode,
            string city,
            string state
        )
        {

            string[] newRowValues = {_checked.ToString(), zipCode, city, state};
            UltraGridRow newRow = new UltraGridRow(newRowValues);

            gridSelectedZipCodeCityRegion.Rows.Add(newRow);

            PnlZipCodeCityRegion.Visible = true;

        }
        #endregion

        #region IBaseParameters Members

        public void BuildParams(Hashtable reportParams)
        {
                
            customParamsRegistryStateControZC.BuildParams(reportParams);
            
            reportParams.Add(ReportParams.ZipCodeOptions, radioButtonZipCodeOptions.SelectedValue);

            foreach (UltraGridRow row in gridSelectedZipCodeCityRegion.Rows)
            {
                if (Convert.ToBoolean(row.Cells[gridSelectedZipCodeCityRegion.Columns.IndexOf("checked")].Value) == true)
                    AddZipCode(
                        row.Cells[gridSelectedZipCodeCityRegion.Columns.IndexOf("ZipCode")].Value.ToString());

            }

            if (txtBoxZipCode.Text.ToString().Length > 0)
                reportParams.Add(ReportParams.ZipCodeData, txtBoxZipCode.Text.ToString());         
        }

        #endregion  

        #region events
        protected void localchkBoxListState_TextChanged(object sender, EventArgs e)
        {
            paramsChanged = true;
            if (ManyZipCodesChecked_radioButtonZipCodeOptions())
                SetParams_ZipCodeCityRegion();
        }

        protected void radioButtonZipCodeOptions_TextChanged(object sender, EventArgs e)
        {            
            //check the radioButtonZipCodeOptions for top 10 bottom 10
            paramsChanged = true;
            if (ManyZipCodesChecked_radioButtonZipCodeOptions())
                SetParams_ZipCodeCityRegion();
        }
                
        protected void odsZipCodeCityRegion_Selecting(object sender, ObjectDataSourceSelectingEventArgs e)
        {
            odsZipCodeCityRegion.SelectParameters["State"].DefaultValue = null;         
            if (odsZipCodeCityRegion.SelectParameters["State"].DefaultValue == null || paramsChanged == false)
                e.Cancel = true;                        
        }
        
        protected void gridZipCodeCityRegion_UpdateRowBatch(object sender, Infragistics.WebUI.UltraWebGrid.RowEventArgs e)
        {

            if (!zipCode.Contains(e.Row.Cells[1].Value.ToString()))
            {
                AddZipCode(Convert.ToString(e.Row.Cells[1].Value));

                AdddsSelectedRegData(
                    Convert.ToBoolean(e.Row.Cells[0].Value),
                    Convert.ToString(e.Row.Cells[1].Value),
                    Convert.ToString(e.Row.Cells[2].Value),
                    Convert.ToString(e.Row.Cells[3].Value)
                    );
            }
        }

        protected void gridZipCodeCityRegion_Load(object sender, EventArgs e)
        {
            UltraWebGrid uGrid = (UltraWebGrid)sender;
            for (int loopCount = 0; uGrid.Rows.Count > loopCount; loopCount++)
            {
                if (Convert.ToBoolean(uGrid.Rows[loopCount].Cells[uGrid.Columns.IndexOf("checked")].Value) == true)
                    AddZipCode(
                        uGrid.Rows[loopCount].Cells[uGrid.Columns.IndexOf("ZipCode")].Value.ToString());
            }

        }

        protected void gridZipCodeCityRegion_InitializeDataSource(object sender, UltraGridEventArgs e)
        {
            if (ManyZipCodesChecked_radioButtonZipCodeOptions())
            {
                Load_gridZipCodeCityRegion();
                //gridZipCodeCityRegion.DataBind();
            }
        }
         protected void gridZipCodeCityRegion_UpdateRow(object sender, RowEventArgs e)
        {
            if (txtBoxZipCode.Text.ToString().Contains(e.Row.Cells[1].Value.ToString()))
            {
                AddZipCode(Convert.ToString(e.Row.Cells[1].Value));

                AdddsSelectedRegData(
                    Convert.ToBoolean(e.Row.Cells[0].Value),
                    Convert.ToString(e.Row.Cells[1].Value),
                    Convert.ToString(e.Row.Cells[2].Value),
                    Convert.ToString(e.Row.Cells[3].Value)
                    );
            }
        }

        protected void gridSelectedZipCodeCityRegion_InitializeDataSource(object sender, UltraGridEventArgs e)
        {
            
            if (dsSelectedRegData == null)
                dsSelectedRegData = new RegistryData();
            gridSelectedZipCodeCityRegion.DataBind();
        }
          
        #endregion

        protected void gridZipCodeCityRegion_InitializeLayout(object sender, LayoutEventArgs e)
        {
            //ccarroll 06/20/2011 -  Added configuration for LoadOnDemand
            gridZipCodeCityRegion.Browser = BrowserLevel.Xml;
            e.Layout.LoadOnDemand = LoadOnDemand.Xml;

            // LoadOnDemand configuration options
            e.Layout.RowsRange = 1500;
            e.Layout.XmlLoadOnDemandType = XmlLoadOnDemandType. Accumulative;
        }





        
    }
}