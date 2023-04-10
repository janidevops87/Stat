using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Statline.Stattrac.Framework;
using Statline.Stattrac.Constant;
using System.Data;
using Statline.Stattrac.Data.Types.ScreenConfig;
using Statline.Stattrac.Common.Organization;

namespace Statline.Stattrac.DataAccess.ScreenConfig
{
    public enum ScreenConfigDASprocs
    {
        ScreenConfigSelectDataSet,
        ScreenFieldAttributeSelect,
        ScreenFieldSelect,
        ServiceLevelSelect,
        TcssListLabSelect1,
        TcssListVitalSignSelect1,
        SourceCodeSelect,
        ServiceLevelCustomFieldSelect,
        ServiceLevelCustomListSelect,
        ScreenConfigRegistryUpdateSelect
    }

    public class ScreenConfigDA : BaseDA
    {
        public int ScreenID { get; set; }
        public int ScreenConfigID { get; set; }
        public int ServiceLevelID { get; set; }
        public int SourceCodeID { get; set; }
        public int TcssListLabId { get; set; }
        public int TcssListVitalSignId { get; set; }
        public SearchParameter OrganizationSearchParameter { get; set; }
        //public Int16 Inactive { get; set; }
        //public int QuestionAssociatedID { get; set; }
        //public int ChildQuestionID { get; set; }
        //public QuestionDetailDASprocs SprocName { get; set; }
        public ScreenConfigDA()
            : base(ScreenConfigDASprocs.ScreenConfigSelectDataSet.ToString())
        {
            ListTableSave.Add(new TableSave("ScreenFieldAttribute", "ScreenFieldAttributeInsert", "ScreenFieldAttributeUpdate", "ScreenFieldAttributeDelete"));
            ListTableSave.Add(new TableSave("ScreenField", "ScreenFieldMerge", "ScreenFieldMerge", "ScreenFieldMerge"));
            ListTableSave.Add(new TableSave("SourceCode", "SourceCodeInsert", "SourceCodeUpdate", "SourceCodeDelete"));
            ListTableSave.Add(new TableSave("TcssListVitalSign", "TcssListVitalSignInsert", "TcssListVitalSignUpdate", "TcssListVitalSignDelete"));
            ListTableSave.Add(new TableSave("TcssListLab", "TcssListLabInsert", "TcssListLabUpdate", "TcssListLabDelete"));
            ListTableSave.Add(new TableSave("ServiceLevelCustomField", "ServiceLevelCustomFieldInsert", "ServiceLevelCustomFieldUpdate", "ServiceLevelCustomFieldDelete"));
            ListTableSave.Add(new TableSave("ServiceLevelCustomList", "ServiceLevelCustomListInsert", "ServiceLevelCustomListUpdate", "ServiceLevelCustomListDelete"));
            ListTableSave.Add(new TableSave("ServiceLevelDRDSN", "DRDSNMerge", "DRDSNMerge", "DRDSNMerge"));
            ListTableSave.Add(new TableSave("ScreenConfig", "ScreenConfigInsert", "ScreenConfigUpdate", "ScreenConfigDelete"));
        }

        public ScreenConfigDA(int screenID)
			: base("ScreenConfigSelectDataSet")
		{
            SetTablesSelect("ScreenFieldAttribute");
            ListTableSave.Add(new TableSave("ScreenFieldAttribute", "ScreenFieldAttributeInsert", "ScreenFieldAttributeUpdate", "ScreenFieldAttributeDelete"));
            this.ScreenID = screenID;
		}

        public void SetDefaultTableSelect()
        {

            SpSelect = ScreenConfigDASprocs.ScreenConfigSelectDataSet.ToString();
            SetTablesSelect(
                "ScreenFieldAttribute"
                , "SourceCode",
                "SourceCodeOrganization"

                );
        }

        protected override void AddParameterForSelectDataSet(BaseCommand commandWrapper)
        {

            switch ((ScreenConfigDASprocs)Enum.Parse(typeof(ScreenConfigDASprocs), SpSelect, true))
            {
                case ScreenConfigDASprocs.ScreenConfigSelectDataSet:
                    SetDefaultTableSelect();
                    //commandWrapper.AddInParameterForSelect("StatEmployeeId", DbType.Int32, StattracIdentity.Identity.UserId);
                    commandWrapper.AddInParameterForSelect("ScreenID", DbType.Int32, ScreenID);
                    break;
                case ScreenConfigDASprocs.ScreenFieldAttributeSelect:
                    //commandWrapper.AddInParameterForSelect("QuestionID", DbType.Int32, QuestionID);
                    commandWrapper.AddInParameterForSelect("ScreenID", DbType.Int32, ScreenID);
                    //commandWrapper.AddInParameterForSelect("Inactive", DbType.Int16, Inactive);
                    break;
                case ScreenConfigDASprocs.ServiceLevelSelect:
                    //commandWrapper.AddInParameterForSelect("QuestionAssociatedID", DbType.Int32, QuestionAssociatedID);
                    commandWrapper.AddInParameterForSelect("ServiceLevelID", DbType.Int32, ServiceLevelID);
                    //commandWrapper.AddInParameterForSelect("ChildQuestionID", DbType.Int32, ChildQuestionID);
                    break;
                case ScreenConfigDASprocs.ServiceLevelCustomFieldSelect:
                    //commandWrapper.AddInParameterForSelect("QuestionAssociatedID", DbType.Int32, QuestionAssociatedID);
                    commandWrapper.AddInParameterForSelect("ServiceLevelID", DbType.Int32, ServiceLevelID);
                    //commandWrapper.AddInParameterForSelect("ChildQuestionID", DbType.Int32, ChildQuestionID);
                    break;
                case ScreenConfigDASprocs.ScreenConfigRegistryUpdateSelect:
                    //commandWrapper.AddInParameterForSelect("QuestionAssociatedID", DbType.Int32, QuestionAssociatedID);
                    commandWrapper.AddInParameterForSelect("ServiceLevelID", DbType.Int32, ServiceLevelID);
                    //commandWrapper.AddInParameterForSelect("ChildQuestionID", DbType.Int32, ChildQuestionID);
                    break;
                case ScreenConfigDASprocs.ScreenFieldSelect:
                    //commandWrapper.AddInParameterForSelect("QuestionAssociatedID", DbType.Int32, QuestionAssociatedID);
                    commandWrapper.AddInParameterForSelect("ScreenConfigID", DbType.Int32, ScreenConfigID);
                    //commandWrapper.AddInParameterForSelect("ChildQuestionID", DbType.Int32, ChildQuestionID);
                    break;
                case ScreenConfigDASprocs.ServiceLevelCustomListSelect:
                    //commandWrapper.AddInParameterForSelect("QuestionAssociatedID", DbType.Int32, QuestionAssociatedID);
                    commandWrapper.AddInParameterForSelect("ServiceLevelID", DbType.Int32, ServiceLevelID);
                    //commandWrapper.AddInParameterForSelect("ChildQuestionID", DbType.Int32, ChildQuestionID);
                    break;
                default:
                    break;
            }
        }

        //public void SelectQuestions(int questionID, int questionCategoryID, Int16 inactive)
        //{
        //    SpSelect = QuestionDetailDASprocs.QuestionSelect.ToString();
        //    QuestionID = questionID;
        //    QuestionCategoryID = questionCategoryID;
        //    Inactive = inactive;
        //    SetTablesSelect("Question");

        //}

        public void SelectScreen(int screenID)
        {
            SpSelect = ScreenConfigDASprocs.ScreenFieldAttributeSelect.ToString();
            ScreenID = screenID;
            SetTablesSelect("ScreenFieldAttribute");

        }

        public void SelectServiceLevel(int serviceLevelID)
        {
            SpSelect = ScreenConfigDASprocs.ServiceLevelSelect.ToString();
            ServiceLevelID = serviceLevelID;
            SetTablesSelect("ServiceLevel");

        }

        public void SelectSourceCode(int sourceCodeID)
        {
            SpSelect = ScreenConfigDASprocs.SourceCodeSelect.ToString();
            SourceCodeID = sourceCodeID;
            SetTablesSelect("SourceCode");

        }

        public void SelectVitalSigns(int tcssListVitalSignId)
        {
            SpSelect = ScreenConfigDASprocs.TcssListVitalSignSelect1.ToString();
            TcssListVitalSignId = tcssListVitalSignId;
            SetTablesSelect("TcssListVitalSign");

        }

        public void SelectLabProfile(int tcssListLabId)
        {
            SpSelect = ScreenConfigDASprocs.TcssListLabSelect1.ToString();
            TcssListLabId = tcssListLabId;
            SetTablesSelect("TcssListLab");

        }

        public void SelectServiceLevelCustomList(int serviceLevelID)
        {
            SpSelect = ScreenConfigDASprocs.ServiceLevelCustomListSelect.ToString();
            ServiceLevelID = serviceLevelID;
            SetTablesSelect("ServiceLevelCustomList");

        }

        public void SelectServiceLevelCustomField(int serviceLevelID)
        {
            SpSelect = ScreenConfigDASprocs.ServiceLevelCustomFieldSelect.ToString();
            ServiceLevelID = serviceLevelID;
            SetTablesSelect("ServiceLevelCustomField");

        }

        public void SelectRegistryServiceLevel(int serviceLevelID)
        {
            SpSelect = ScreenConfigDASprocs.ScreenConfigRegistryUpdateSelect.ToString();
            ServiceLevelID = serviceLevelID;
            SetTablesSelect("ServiceLevelDRDSN");

        }

        public void SelectScreenField(int screenConfigID)
        {
            SpSelect = ScreenConfigDASprocs.ScreenFieldSelect.ToString();
            ScreenConfigID = screenConfigID;
            SetTablesSelect("ScreenField");

        }
    }
}
