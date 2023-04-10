using System;
using Statline.StatTrac.Data.Types;
using Statline.StatTrac.QAUpdate;
using Infragistics.WebUI.UltraWebGrid;

namespace Statline.StatTrac.Web.UI
{
    public partial class QAManageErrorHeaderControl : System.Web.UI.UserControl
    {
        protected UltraWebGrid parentGrid;
        protected Statline.StatTrac.Data.Types.QAUpdateData dsQAUpdateData;
        protected void Page_Load(object sender, EventArgs e)
        {
            parentGrid = (UltraWebGrid)Parent.FindControl("gridErrorLocations");
            if (parentGrid != null)
            {
                parentGrid.UpdateRowBatch += new Infragistics.WebUI.UltraWebGrid.UpdateRowBatchEventHandler(gridErrorLocations_UpdateRowBatch);
                
            }
        }

        protected void ddlOrganization_SelectedRowChanged(object sender, Infragistics.WebUI.WebCombo.SelectedRowChangedEventArgs e)
        {
            this.dsQAUpdateData = new Statline.StatTrac.Data.Types.QAUpdateData();
            this.dsQAUpdateData.DataSetName = "QAUpdateData";
            parentGrid = (UltraWebGrid)Parent.FindControl("gridQAMonitoringForms");
            if (parentGrid != null)
            {
                parentGrid.InitializeDataSource += new Infragistics.WebUI.UltraWebGrid.InitializeDataSourceEventHandler(parentGrid_InitializeMonitoringFormsDataSource);
                parentGrid.OnInitializeDataSource();
                parentGrid.DataBind();
            }
            parentGrid = (UltraWebGrid)Parent.FindControl("gridErrorLocations");
            if (parentGrid != null)
            {
                parentGrid.UpdateRowBatch += new Infragistics.WebUI.UltraWebGrid.UpdateRowBatchEventHandler(gridErrorLocations_UpdateRowBatch);
                parentGrid.InitializeDataSource += new Infragistics.WebUI.UltraWebGrid.InitializeDataSourceEventHandler(parentGrid_InitializeErrorLocationDataSource);
                parentGrid.OnInitializeDataSource();
                parentGrid.DataBind();
            }
            parentGrid = (UltraWebGrid)Parent.FindControl("gridProcessSteps");
            if (parentGrid != null)
            {
                parentGrid.InitializeDataSource += new Infragistics.WebUI.UltraWebGrid.InitializeDataSourceEventHandler(parentGrid_InitializeProcessStepsDataSource);
                parentGrid.OnInitializeDataSource();
                parentGrid.DataBind();
            }
            parentGrid = (UltraWebGrid)Parent.FindControl("gridManageErrorTypes");
            if (parentGrid != null)
            {
                parentGrid.InitializeDataSource += new Infragistics.WebUI.UltraWebGrid.InitializeDataSourceEventHandler(parentGrid_InitializeManageErrorTypesDataSource);
                parentGrid.OnInitializeDataSource();
                parentGrid.DataBind();
            }
            parentGrid = (UltraWebGrid)Parent.FindControl("gridErrorLists");
            if (parentGrid != null)
            {
                parentGrid.InitializeDataSource += new Infragistics.WebUI.UltraWebGrid.InitializeDataSourceEventHandler(parentGrid_InitializeErrorListsDataSource);
                parentGrid.OnInitializeDataSource();
                parentGrid.DataBind();
            }
            
        }

        protected void ddlQMF_SelectedRowChanged(object sender, Infragistics.WebUI.WebCombo.SelectedRowChangedEventArgs e)
        {
            this.dsQAUpdateData = new Statline.StatTrac.Data.Types.QAUpdateData();
            this.dsQAUpdateData.DataSetName = "QAUpdateData";
            parentGrid = (UltraWebGrid)Parent.FindControl("gridErrorLists");
            if (parentGrid != null)
            {
                parentGrid.InitializeDataSource += new Infragistics.WebUI.UltraWebGrid.InitializeDataSourceEventHandler(parentGrid_InitializeErrorListsDataSource);
                parentGrid.OnInitializeDataSource();
                parentGrid.DataBind();
            }
        }

        protected void parentGrid_InitializeMonitoringFormsDataSource(object sender, Infragistics.WebUI.UltraWebGrid.UltraGridEventArgs e)
        {
            parentGrid.Columns.Band.BaseTableName = "QAMonitoringForm";
            parentGrid.Rows.Band.BaseTableName = "QAMonitoringForm";
            parentGrid.Rows.Band.Key = "QAMonitoringForm";
            parentGrid.DataMember = "QAMonitoringForm";
            parentGrid.DataSource = "dsQAUpdateData";
            
            QAUpdateManager.FillQAGridManageQualityMonitoringForm(dsQAUpdateData, Convert.ToInt32(ddlOrganization.SelectedRow.Cells[1].Value), 1);
            for (int loopCount = 0; dsQAUpdateData.GridManageQualityMonitoringForms.Count > loopCount; loopCount++)
            {
                UltraGridRow newRow = new UltraGridRow();
                newRow.Cells.Add(new UltraGridCell());
                newRow.Cells.Add(new UltraGridCell());
                newRow.Cells.Add(new UltraGridCell());
                newRow.Cells.Add(new UltraGridCell());
                newRow.Cells.Add(new UltraGridCell());
                newRow.Cells.Add(new UltraGridCell());
                newRow.Cells.Add(new UltraGridCell());
                newRow.Cells[0].Value = dsQAUpdateData.GridManageQualityMonitoringForms[loopCount].QAMonitoringFormID;
                newRow.Cells[1].Value = dsQAUpdateData.GridManageQualityMonitoringForms[loopCount].QAMonitoringFormName;
                //newRow.Cells[2].Value = dsQAUpdateData.GridManageQualityMonitoringForms[loopCount].QAMonitoringFormLogo;
                newRow.Cells[3].Value = dsQAUpdateData.GridManageQualityMonitoringForms[loopCount].QATrackingTypeID;
                newRow.Cells[4].Value = dsQAUpdateData.GridManageQualityMonitoringForms[loopCount].QAMonitoringFormCalculateScore;
                //newRow.Cells[5].Value = dsQAUpdateData.GridManageQualityMonitoringForms[loopCount].QAMonitoringFormRequireReview;
                newRow.Cells[6].Value = dsQAUpdateData.GridManageQualityMonitoringForms[loopCount].QAMonitoringFormActive;
                parentGrid.Rows.Add(newRow);
            }
        }

        protected void parentGrid_InitializeErrorLocationDataSource(object sender, Infragistics.WebUI.UltraWebGrid.UltraGridEventArgs e)
        {
            parentGrid.Columns.Band.BaseTableName = "QAErrorLocation";
            parentGrid.Rows.Band.BaseTableName = "QAErrorLocation";
            parentGrid.Rows.Band.Key = "QAErrorLocation";
            parentGrid.DataMember = "QAErrorLocation";
            parentGrid.DataSource = "dsQAUpdateData";
            QAUpdateManager.FillQAErrorLocation(dsQAUpdateData, Convert.ToInt32(ddlOrganization.SelectedRow.Cells[1].Value), 1, Convert.ToInt32(Request.QueryString["TrackingTypeID"]));
            for (int loopCount = 0; dsQAUpdateData.QAErrorLocation.Count > loopCount; loopCount++)
            {
                UltraGridRow newRow = new UltraGridRow();
                newRow.Cells.Add(new UltraGridCell());
                newRow.Cells.Add(new UltraGridCell());
                newRow.Cells.Add(new UltraGridCell());
                newRow.Cells[0].Value = dsQAUpdateData.QAErrorLocation[loopCount].QAErrorLocationID;
                newRow.Cells[1].Value = dsQAUpdateData.QAErrorLocation[loopCount].QAErrorLocationDescription;
                newRow.Cells[2].Value = dsQAUpdateData.QAErrorLocation[loopCount].QAErrorLocationActive;
                parentGrid.Rows.Add(newRow);
            }
        }

        protected void parentGrid_InitializeProcessStepsDataSource(object sender, Infragistics.WebUI.UltraWebGrid.UltraGridEventArgs e)
        {
            parentGrid.Columns.Band.BaseTableName = "QAProcessStep";
            parentGrid.Rows.Band.BaseTableName = "QAProcessStep";
            parentGrid.Rows.Band.Key = "QAProcessStep";
            parentGrid.DataMember = "QAProcessStep";
            parentGrid.DataSource = "dsQAUpdateData";
            QAUpdateManager.FillQAProcessStep(dsQAUpdateData, Convert.ToInt32(ddlOrganization.SelectedRow.Cells[1].Value), 1);
            for (int loopCount = 0; dsQAUpdateData.QAProcessStep.Count > loopCount; loopCount++)
            {
                UltraGridRow newRow = new UltraGridRow();
                newRow.Cells.Add(new UltraGridCell());
                newRow.Cells.Add(new UltraGridCell());
                newRow.Cells.Add(new UltraGridCell());
                newRow.Cells[0].Value = dsQAUpdateData.QAProcessStep[loopCount].QAProcessStepID;
                newRow.Cells[1].Value = dsQAUpdateData.QAProcessStep[loopCount].QAProcessStepDescription;
                newRow.Cells[2].Value = dsQAUpdateData.QAProcessStep[loopCount].QAProcessStepActive;
                parentGrid.Rows.Add(newRow);
            }
        }

        protected void parentGrid_InitializeManageErrorTypesDataSource(object sender, Infragistics.WebUI.UltraWebGrid.UltraGridEventArgs e)
        {
            parentGrid.Columns.Band.BaseTableName = "GridManageErrorLists";
            parentGrid.Rows.Band.BaseTableName = "GridManageErrorLists";
            parentGrid.Rows.Band.Key = "GridManageErrorLists";
            parentGrid.DataMember = "GridManageErrorLists";
            parentGrid.DataSource = "dsQAUpdateData";
            QAUpdateManager.FillQAGridManageErrorLists(dsQAUpdateData, Convert.ToInt32(ddlOrganization.SelectedRow.Cells[1].Value), Convert.ToInt16(cbxDisplayAll.Checked), 0);
            for (int loopCount = 0; dsQAUpdateData.GridManageErrorLists.Count > loopCount; loopCount++)
            {
                UltraGridRow newRow = new UltraGridRow();
                newRow.Cells.Add(new UltraGridCell());
                newRow.Cells.Add(new UltraGridCell());
                newRow.Cells.Add(new UltraGridCell());
                newRow.Cells.Add(new UltraGridCell());
                newRow.Cells[0].Value = dsQAUpdateData.GridManageErrorLists[loopCount].QAErrorTypeID;
                newRow.Cells[1].Value = dsQAUpdateData.GridManageErrorLists[loopCount].QAErrorTypeActive;
                newRow.Cells[2].Text = dsQAUpdateData.GridManageErrorLists[loopCount].QAErrorTypeDescription;
                newRow.Cells[2].TargetURL = string.Format("@[]QAAddEditErrorType.aspx?ErrorID={0}&LocationDesc={1}", dsQAUpdateData.GridManageErrorLists[loopCount].QAErrorTypeID , dsQAUpdateData.GridManageErrorLists[loopCount].QAErrorLocationDescription);
                newRow.Cells[3].Value = dsQAUpdateData.GridManageErrorLists[loopCount].QAErrorLocationDescription;
                parentGrid.Rows.Add(newRow);
            }
        }

        protected void parentGrid_InitializeErrorListsDataSource(object sender, Infragistics.WebUI.UltraWebGrid.UltraGridEventArgs e)
        {
            parentGrid.Columns.Band.BaseTableName = "GridManageErrorLists";
            parentGrid.Rows.Band.BaseTableName = "GridManageErrorLists";
            parentGrid.Rows.Band.Key = "GridManageErrorLists";
            parentGrid.DataMember = "GridManageErrorLists";
            parentGrid.DataSource = "dsQAUpdateData";
            int QMFID = new int();
            int OrgID = new int();
            if (ddlQMF.SelectedRow != null)
            {
                QMFID = Convert.ToInt32(ddlQMF.SelectedRow.Cells[0].Value);
            }
            if (ddlOrganization.SelectedRow != null)
            {
                OrgID = Convert.ToInt32(ddlOrganization.SelectedRow.Cells[1].Value);
            }

            QAUpdateManager.FillQAGridManageErrorLists(dsQAUpdateData, OrgID, QMFID, 1);
            for (int loopCount = 0; dsQAUpdateData.GridManageErrorLists.Count > loopCount; loopCount++)
            {
                UltraGridRow newRow = new UltraGridRow();
                newRow.Cells.Add(new UltraGridCell());
                newRow.Cells.Add(new UltraGridCell());
                newRow.Cells.Add(new UltraGridCell());
                newRow.Cells.Add(new UltraGridCell());
                newRow.Cells.Add(new UltraGridCell());
                newRow.Cells[0].Value = dsQAUpdateData.GridManageErrorLists[loopCount].QAErrorTypeID;
                newRow.Cells[1].Value = dsQAUpdateData.GridManageErrorLists[loopCount].QAErrorTypeActive;
                newRow.Cells[2].Value = dsQAUpdateData.GridManageErrorLists[loopCount].QAMonitoringFormTemplateOrder;
                newRow.Cells[3].Text = dsQAUpdateData.GridManageErrorLists[loopCount].QAErrorTypeDescription;
                newRow.Cells[3].TargetURL = string.Format("@[]QAAddEditErrorType.aspx?ErrorType={0}", dsQAUpdateData.GridManageErrorLists[loopCount].QAErrorTypeID);
                newRow.Cells[4].Value = dsQAUpdateData.GridManageErrorLists[loopCount].QAErrorLocationDescription;
                parentGrid.Rows.Add(newRow);
            }
        }

        protected void ddlQMF_InitializeLayout(object sender, LayoutEventArgs e)
        {
            ddlQMF.DropDownLayout.BaseTableName = "DdlQAForms";
            ddlQMF.Columns[ddlQMF.Columns.IndexOf("QAMonitoringFormID")].Hidden = true;
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            parentGrid = (UltraWebGrid)Parent.FindControl("gridManageErrorTypes");
            if (parentGrid != null)
            {
                QueryStringManager.Redirect(PageName.QAAddEditErrorType);
            }
            parentGrid = (UltraWebGrid)Parent.FindControl("gridErrorLists");
            if (parentGrid != null)
            {
                QueryStringManager.Redirect(PageName.QAAddEditErrorType);
            }
        }
        protected void gridErrorLocations_UpdateRowBatch(object sender, Infragistics.WebUI.UltraWebGrid.RowEventArgs e)
        {
            QAUpdateData ds = new QAUpdateData();
            QAUpdateData.QAErrorLocationRow row;
            CellsCollection cells = e.Row.Cells;
            row = ds.QAErrorLocation.NewQAErrorLocationRow();
            foreach (UltraGridCell cell in e.Row.Cells)
            {

                // update each data row with the grid row values 
                if (cell.Key == "QAErrorLocationID")
                    continue;
                if (cell.Value != null)
                {
                    row[cell.Column.BaseColumnName] = cell.Value;
                }
                else
                {
                    row[cell.Column.BaseColumnName] = DBNull.Value;
                }
            }
        }
    }
}