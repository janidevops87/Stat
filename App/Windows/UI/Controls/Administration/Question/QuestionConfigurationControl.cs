using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using Statline.Stattrac.Data.Types.Question;
using Statline.Stattrac.Constant.GridColumns;
using Statline.Stattrac.BusinessRules.Question;
using Statline.Stattrac.Framework;
using Statline.Stattrac.BusinessRules.Framework;


namespace Statline.Stattrac.Windows.UI.Controls.Administration.Question
{
    public partial class QuestionConfigurationControl : Statline.Stattrac.Windows.UI.BaseEditControl
    {
        private QuestionGroupsControl questionGroups;
        private CurrencyManager _currencyManager;

        public QuestionGroupsControl QuestionGroupsControl
        {
            get { return questionGroups; }
            set { questionGroups = value; }
        }
        
        private QuestionConfigurationEventLogControl questionConfigurationEventLogControl;
        private QuestionConfigurationUpdateControl questionConfigurationUpdateControl;
        private QuestionConfigurationRefTypeControl questionConfigRefTypeControl;
        private QuestionConfigurationQuestionControl questionConfigQuestionControl;
        public QuestionConfigurationControl()
        {
            InitializeComponent();
            BusinessRule = new QuestionGroupConfigBR(); 
            //InitializeBR(new QuestionGroupConfigBR());
            questionConfigurationUpdateControl = new QuestionConfigurationUpdateControl();
            questionConfigRefTypeControl = new QuestionConfigurationRefTypeControl();
            questionConfigurationEventLogControl = new QuestionConfigurationEventLogControl();
            questionConfigQuestionControl = new QuestionConfigurationQuestionControl();
             
            BindToValues();
        }
        
        protected void BindToValues()
        {
            //QuestionDS questionDS = (QuestionDS)BusinessRule.AssociatedDataSet;
            
            cbScreen.BindData("ScreenListSelect");
            cbAskonInit.BindData("QuestionConfigOnInitialCallListSelect");
            cbAskonUpdate.BindData("QuestionConfigOnUpdateListSelect");
            cbDateTimeType.BindData("QuestionConfigTimeSettingListSelect");
            cbOnce.BindData("QuestionConfigOnlyAskOnceListSelect");
            cbRequire.BindData("QuestionConfigAskOnIncompleteListSelect");
            cbResponse.BindData("QuestionConfigAskUntilYesListSelect");
            cbTime.BindData("QuestionConfigOnTimeListSelect");
           
        }
        public override void BindDataToUI()
        {
            if (GRConstant.QuestionGroupConfigID != 0)
            {
                QuestionDS questionDS = (QuestionDS)BusinessRule.AssociatedDataSet;
                QuestionGroupConfigBR questionGroupConfigBR = (QuestionGroupConfigBR)BusinessRule;
                //questionGroupConfigBR.SelectQuestionsConfig(0,GRConstant.QuestionGroupConfigID);
                string tableName = questionDS.QuestionGroupConfig.TableName;
                _currencyManager = (CurrencyManager)BindingContext[questionDS, questionDS.QuestionGroupConfig.TableName];
                _currencyManager.Position = questionDS.QuestionGroupConfig.Rows.IndexOf(questionDS.QuestionGroupConfig.FindByQuestionGroupConfigID(GRConstant.QuestionGroupConfigID));
                
                cbAskonInit.BindDataSet(questionDS, tableName, questionDS.QuestionGroupConfig.QuestionConfigOnInitialCallIDColumn.ColumnName);
                cbAskonUpdate.BindDataSet(questionDS, tableName, questionDS.QuestionGroupConfig.QuestionConfigOnUpdateIDColumn.ColumnName);
                cbDateTimeType.BindDataSet(questionDS, tableName, questionDS.QuestionGroupConfig.QuestionConfigTimeSettingIDColumn.ColumnName);
                cbOnce.BindDataSet(questionDS, tableName, questionDS.QuestionGroupConfig.QuestionConfigOnlyAskOnceIDColumn.ColumnName);
                cbRequire.BindDataSet(questionDS, tableName, questionDS.QuestionGroupConfig.QuestionConfigAskOnIncompleteIDColumn.ColumnName);
                cbResponse.BindDataSet(questionDS, tableName, questionDS.QuestionGroupConfig.QuestionConfigAskUntilYesIDColumn.ColumnName);
                cbTime.BindDataSet(questionDS, tableName, questionDS.QuestionGroupConfig.QuestionConfigOnTimeIDColumn.ColumnName);
                cbScreen.BindDataSet(questionDS, tableName, questionDS.QuestionGroupConfig.ScreenIDColumn.ColumnName);

                questionGroupConfigBR.SelectScreenFields(questionDS.QuestionGroupConfig[_currencyManager.Position].ScreenID, GRConstant.QuestionGroupConfigID);
                availableSelectedControl1.ColumnList = typeof(Statline.Stattrac.Constant.GridColumns.ScreenConfig);
                availableSelectedControl1.DataMember = questionDS.QuestionConfigFieldUpdate.TableName;
                availableSelectedControl1.DataSource = questionDS;

                questionConfigRefTypeControl.BindDataToUI();
                questionConfigurationEventLogControl.BindDataToUI();
                questionConfigurationUpdateControl.BindDataToUI();
                questionConfigQuestionControl.BindDataToUI();
            }
        }
        private void comboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (QuestionGroupsControl != null)
            {
                this.baseUserControl1.Controls.Clear();
                this.baseUserControl2.Controls.Clear();
                this.baseUserControl3.Controls.Clear();
                string callType = QuestionGroupsControl.callBackCallType();
                //referral call type...1 is a referral
                if (callType == "1")
                {
                    this.baseUserControl1.Controls.Add(questionConfigRefTypeControl);
                    QuestionDS questionDS = (QuestionDS)BusinessRule.AssociatedDataSet;
                    QuestionGroupConfigBR questionGroupConfigBR = (QuestionGroupConfigBR)BusinessRule;
                    
                    //questionGroupConfigBR.SelectScreenFields(Convert.ToInt32(cbScreen.SelectedValue), GRConstant.QuestionGroupConfigID);
                    //availableSelectedControl1.ColumnList = typeof(ScreenField);
                    //availableSelectedControl1.DataMember = questionDS.QuestionConfigFieldUpdate.TableName;
                    //availableSelectedControl1.DataSource = questionDS;
                    //this.baseUserControl2.Location = new Point(7, 899);
                }
                else
                {
                    this.baseUserControl1.Controls.Remove(questionConfigRefTypeControl);
                    //this.baseUserControl2.Location = new Point(7, 569);
                    //this.baseUserControl2.Size = new Size(810, 425);
                }
                //do all this to get the need controls in the proper order and so on
                switch (cbScreen.Text)
                {
                    case "Update":
                        if (callType != "1")
                        {
                            this.baseUserControl1.Controls.Add(questionConfigurationUpdateControl);
                            this.baseUserControl2.Controls.Add(questionConfigQuestionControl);
                        }
                        else
                        {
                            this.baseUserControl2.Controls.Add(questionConfigurationUpdateControl);
                            this.baseUserControl3.Controls.Add(questionConfigQuestionControl);
                        }
                        break;
                        case "Event Log":
                        if (callType != "1")
                        {
                            this.baseUserControl1.Controls.Add(questionConfigurationEventLogControl);
                            this.baseUserControl2.Controls.Add(questionConfigQuestionControl);
                        }
                        else
                        {
                            this.baseUserControl2.Controls.Add(questionConfigurationEventLogControl);
                            this.baseUserControl3.Controls.Add(questionConfigQuestionControl);
                        }
                        break;
                        default:
                        if (callType != "1")
                        {
                            this.baseUserControl1.Controls.Add(questionConfigQuestionControl); ;
                        }
                        else
                        {
                            this.baseUserControl2.Controls.Add(questionConfigQuestionControl); ;
                        }
                        break;
                }
            }
        }
    }
}
