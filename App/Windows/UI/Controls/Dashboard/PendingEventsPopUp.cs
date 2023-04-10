using System;
using System.Drawing;
using System.Windows.Forms;
using Infragistics.Win.UltraWinGrid;
using Statline.Stattrac.BusinessRules.Dashboard;
using Statline.Stattrac.Common;
using Statline.Stattrac.Constant;
using Statline.Stattrac.Constant.Enum;
using Statline.Stattrac.Data.Types.Dashboard;
using Statline.Stattrac.Windows.Forms;

namespace Statline.Stattrac.Windows.UI.Controls.Dashboard
{
    public partial class FormPendingEventsPop : BaseForm
    {
        string file = Application.StartupPath;
        private GeneralConstant generalConstant = GeneralConstant.CreateInstance();
        public FormPendingEventsPop()
        {
            InitializeComponent();
            this.StartPosition = FormStartPosition.CenterScreen;
            BindDataToUIPending();
        }

        protected GeneralConstant GRConstant
        {
            get { return generalConstant; }
        }

        public void BindDataToUIPending()
        {
            ugPending.UltraGridType = UltraGridType.ReadOnly;
            PendingEventsPopUpBR pendingEventsPopUpBR = new PendingEventsPopUpBR();
            pendingEventsPopUpBR.orgName = generalConstant.OrganizationName;
            pendingEventsDS1 = (PendingEventsDS)pendingEventsPopUpBR.SelectDataSet();
            if (pendingEventsDS1.PendingList.Count == 0)
            {
                Close();
                return;
            }
            ugPending.DataMember = pendingEventsDS1.PendingList.TableName;
            ugPending.DataSource = pendingEventsDS1;
        }

        private void ultraGrid1_InitializeRow(object sender, InitializeRowEventArgs e)
        {
            CellsCollection cellsCollection = e.Row.Cells;
            TimeSpan expireMinutes = System.DateTime.Now - (DateTime)cellsCollection["LogEventDateTime"].Value;
            //color precedence...black,light coral (a.k.a. red),blue,green,orange,yellow...so, apply black last and yellow first
            //red hot chili peppers supercede locks and are applied to hot colors black,red,orange and yellow

            //green
            //if (cellsCollection["LogEventTypeID"].Value.ToString() == Convert.ToInt32(LogEventTypeConstant.EventType.FaxPending).ToString())
            //{
            //    e.Row.ToolTipText = "Fax Pending";
            //    e.Row.CellAppearance.BackColor = Color.LightGreen;
            //}

            //blue
            if (cellsCollection["LogEventTypeID"].Value.ToString() == Convert.ToInt32(LogEventTypeConstant.EventType.OnlineReviewPending).ToString())
            {
                if (StattracIdentity.Identity.UserOrganizationId == Convert.ToInt32(GeneralConstant.Organizations.Statline))
                {
                    e.Row.ToolTipText = "Client Created";
                    e.Row.CellAppearance.BackColor = Color.LightBlue;
                }
            }
            //bold
            if (cellsCollection["LogEventOrg"].Value.ToString() == "DonorNet")
            {
                e.Row.CellAppearance.FontData.Bold = Infragistics.Win.DefaultableBoolean.True;
                e.Row.CellAppearance.BackColor = Color.Black;
                e.Row.CellAppearance.ForeColor = Color.White;
                ugPending.Rows[e.Row.Index].Cells["icon"].Value = Image.FromFile(string.Format("{0}{1}", file.Replace(WindowsUIConstant.CreateInstance().DebugPathForImages, ""), "\\images\\chili-pepper5.gif"));
            }
            else
            {
                //callout pendings and acknowledget to evaluate show when expired and go to red and then black
                if (cellsCollection["LogEventTypeID"].Value.ToString() == Convert.ToInt32(LogEventTypeConstant.EventType.AcknowledgetoEvaluate).ToString()
                    || cellsCollection["LogEventTypeID"].Value.ToString() == Convert.ToInt32(LogEventTypeConstant.EventType.CalloutPending).ToString())
                {
                    int overexpiredminutes;
                    //overexpire is different per event type
                    if (cellsCollection["LogEventTypeID"].Value.ToString() == Convert.ToInt32(LogEventTypeConstant.EventType.AcknowledgetoEvaluate).ToString())
                        overexpiredminutes = Convert.ToInt32(cellsCollection["acknowledgeevalexpireminutes"].Value);
                    else
                        overexpiredminutes = Convert.ToInt32(cellsCollection["overexpirationminutes"].Value);
                    //black
                    if (expireMinutes.TotalMinutes > overexpiredminutes + Convert.ToInt32(cellsCollection["overexpirationminutes"].Value))
                    {
                        e.Row.ToolTipText = "Over Expired";
                        e.Row.CellAppearance.BackColor = Color.Black;
                        e.Row.CellAppearance.ForeColor = System.Drawing.Color.White;
                        e.Row.CellAppearance.FontData.Bold = Infragistics.Win.DefaultableBoolean.True;
                        ugPending.Rows[e.Row.Index].Cells["icon"].Value = Image.FromFile(string.Format("{0}{1}", file.Replace(WindowsUIConstant.CreateInstance().DebugPathForImages, ""), "\\images\\chili-pepper5.gif"));
                    }
                    else
                        //red
                        e.Row.CellAppearance.BackColor = Color.LightCoral;
                    e.Row.ToolTipText = "Expired";
                    ugPending.Rows[e.Row.Index].Cells["icon"].Value = Image.FromFile(string.Format("{0}{1}", file.Replace(WindowsUIConstant.CreateInstance().DebugPathForImages, ""), "\\images\\chili-pepper5.gif"));

                }
                else
                {//the other events show immediately and go red and black after the interval
                    //black
                    
                    if (expireMinutes.TotalMinutes > (Convert.ToInt32(cellsCollection["interval"].Value) + Convert.ToInt32(cellsCollection["overexpirationminutes"].Value)))
                    {
                        e.Row.ToolTipText = "Over Expired";
                        e.Row.CellAppearance.BackColor = Color.Black;
                        e.Row.CellAppearance.ForeColor = System.Drawing.Color.White;
                        e.Row.CellAppearance.FontData.Bold = Infragistics.Win.DefaultableBoolean.True;
                        ugPending.Rows[e.Row.Index].Cells["icon"].Value = Image.FromFile(string.Format("{0}{1}", file.Replace(WindowsUIConstant.CreateInstance().DebugPathForImages, ""), "\\images\\chili-pepper5.gif"));
                    }
                    else
                        //red
                        if (expireMinutes.TotalMinutes > Convert.ToInt32(cellsCollection["interval"].Value))
                        {
                            e.Row.CellAppearance.BackColor = Color.LightCoral;
                            e.Row.ToolTipText = "Expired";
                            ugPending.Rows[e.Row.Index].Cells["icon"].Value = Image.FromFile(string.Format("{0}{1}", file.Replace(WindowsUIConstant.CreateInstance().DebugPathForImages, ""), "\\images\\chili-pepper5.gif"));
                        }
                }
            }
            //icon column needs to be white
            e.Row.Cells["icon"].Appearance.BackColor = System.Drawing.Color.White;
            ugPending.Rows[e.Row.Index].Cells["icon"].Value = Image.FromFile(string.Format("{0}{1}", file.Replace(WindowsUIConstant.CreateInstance().DebugPathForImages, ""), "\\images\\Q.bmp"));
        }

        private void btnCancel_Click(object sender, EventArgs e)
        {
            DialogResult dialogResult = BaseMessageBox.ShowYesNo(
                    "Are you sure you want to close window...you still have pending events");
            switch (dialogResult)
            {
                case DialogResult.Yes:
                    Close();
                    break;
                default:
                    break;
            }
        }

        private void btnRefresh_Click(object sender, EventArgs e)
        {
            BindDataToUIPending();
        }
        
        private void ugPending_DoubleClick(object sender, EventArgs e)
        {
            if (ugPending.Selected.Rows.Count == 1 && ugPending.Selected.Rows[0].Cells != null)
            {
                CellsCollection cellsCollection = ugPending.Selected.Rows[0].Cells;
                NavigateToEditScreen((int)cellsCollection[0].Value);
                BindDataToUIPending();
            }
        }
        protected void NavigateToEditScreen(int callID)
        {
            UIMap openstatTrac = Statline.Stattrac.Windows.VBUIMap.OpenStatTracVBForms.CreateInstance();
            string callType = ugPending.Selected.Rows[0].Cells["CallType"].Value.ToString();
            CellsCollection cellsCollection = ugPending.Selected.Rows[0].Cells;
            if (callType.Contains("M") || callType.Contains("I"))
            {
                //Set MessageCallType
                if ((bool)callType.Contains("I"))
                    GRConstant.MessageCallTypeID = (int)GeneralConstant.CallType.Import;
                else
                    GRConstant.MessageCallTypeID = (int)GeneralConstant.CallType.Message;

                openstatTrac.Open(AppScreenType.VBMsgEventLog, (int)cellsCollection["CallID"].Value);

                // Reset MessageCallType
                GRConstant.MessageCallTypeID = 0;

            }
            else
            {
                openstatTrac.Open(AppScreenType.VBEventLog, (int)cellsCollection["CallID"].Value);
            }
        }

        private void FormPendingEventsPop_Leave(object sender, EventArgs e)
        {
            generalConstant.OrganizationName = null;
        }
    }
}
