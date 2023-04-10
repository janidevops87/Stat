using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Statline.Stattrac.Framework;
using Statline.Stattrac.Constant;
using System.Data;
using Statline.Stattrac.Data.Types.Question;

namespace Statline.Stattrac.DataAccess.Question
{
    public enum QuestionGroupsConfigDASprocs
    {
        QuestionGroupConfigSelectDataSet,
        QuestionGroupConfigSelect,
        QuestionGroupAssociationSelect,
        ScreenSelect,
        QuestionConfigFieldUpdateSelect,
        QuestionConfigReferralTypeSelect,
        QuestionConfigEventTypeSelect,
        QuestionConfigEventTypeUpdateSelect
    }
    public class QuestionGroupsConfigDA : BaseDA
    {
        public int QuestionGroupConfigID { get; set; }
        public int QuestionGroupID { get; set; }
        public int QuestionConfigReferralTypeID { get; set; }
        public int QuestionConfigEventTypeUpdateID { get; set; }
        public int QuestionConfigEventTypeID { get; set; }
        public int DonorCategoryID { get; set; }
        public int QuestionConfigDonorCategoryValueID { get; set; }
        //public int CallTypeID { get; set; }
        //public Int16 Inactive { get; set; }
        public int ScreenID { get; set; }
        //public int ChildQuestionID { get; set; }
        public QuestionGroupsConfigDASprocs SprocName { get; set; }
        public QuestionGroupsConfigDA()
            : base(QuestionGroupsConfigDASprocs.QuestionGroupConfigSelectDataSet.ToString())
        {
            ListTableSave.Add(new TableSave("QuestionGroupConfig", "QuestionGroupConfigInsert", "QuestionGroupConfigUpdate", "QuestionGroupConfigDelete"));
            ListTableSave.Add(new TableSave("QuestionGroupAssociation", "QuestionGroupAssociationInsert", "QuestionGroupAssociationUpdate", "QuestionGroupAssociationDelete"));
            ListTableSave.Add(new TableSave("QuestionConfigFieldUpdate", "QuestionConfigFieldUpdateMerge", "QuestionConfigFieldUpdateMerge", "QuestionConfigFieldUpdateMerge"));
        }
        public void SetDefaultTableSelect()
        {

            SpSelect = QuestionGroupsConfigDASprocs.QuestionGroupConfigSelectDataSet.ToString();
            SetTablesSelect(
                "QuestionGroupConfig",
                "QuestionGroupAssociation",
                "QuestionConfigFieldUpdate"
                );
        }

        protected override void AddParameterForSelectDataSet(BaseCommand commandWrapper)
        {

            switch ((QuestionGroupsConfigDASprocs)Enum.Parse(typeof(QuestionGroupsConfigDASprocs), SpSelect, true))
            {
                case QuestionGroupsConfigDASprocs.QuestionGroupConfigSelectDataSet:
                    SetDefaultTableSelect();
                    //commandWrapper.AddInParameterForSelect("StatEmployeeId", DbType.Int32, StattracIdentity.Identity.UserId);
                    commandWrapper.AddInParameterForSelect("QuestionGroupConfigID", DbType.Int32, QuestionGroupConfigID);
                    break;
                case QuestionGroupsConfigDASprocs.QuestionConfigEventTypeSelect:
                    commandWrapper.AddInParameterForSelect("QuestionGroupConfigID", DbType.Int32, QuestionGroupConfigID);
                    break;
                case QuestionGroupsConfigDASprocs.QuestionConfigEventTypeUpdateSelect:
                    commandWrapper.AddInParameterForSelect("QuestionGroupConfigID", DbType.Int32, QuestionGroupConfigID);
                    break;
                case QuestionGroupsConfigDASprocs.QuestionGroupConfigSelect:
                    commandWrapper.AddInParameterForSelect("QuestionGroupID", DbType.Int32, QuestionGroupID);
                    commandWrapper.AddInParameterForSelect("QuestionGroupConfigID", DbType.Int32, QuestionGroupConfigID);
                    break;
                case QuestionGroupsConfigDASprocs.QuestionGroupAssociationSelect:
                    commandWrapper.AddInParameterForSelect("QuestionGroupConfigID", DbType.Int32, QuestionGroupConfigID);
                    break;
                case QuestionGroupsConfigDASprocs.QuestionConfigFieldUpdateSelect:
                    commandWrapper.AddInParameterForSelect("ScreenID", DbType.Int32, ScreenID);
                    commandWrapper.AddInParameterForSelect("QuestionGroupConfigID", DbType.Int32, QuestionGroupConfigID);
                    break;
                case QuestionGroupsConfigDASprocs.QuestionConfigReferralTypeSelect:
                    commandWrapper.AddInParameterForSelect("QuestionConfigReferralTypeID", DbType.Int32, QuestionConfigReferralTypeID);
                    commandWrapper.AddInParameterForSelect("QuestionGroupConfigID", DbType.Int32, QuestionGroupConfigID);
                    commandWrapper.AddInParameterForSelect("DonorCategoryID", DbType.Int32, DonorCategoryID);
                    commandWrapper.AddInParameterForSelect("QuestionConfigDonorCategoryValueID", DbType.Int32, QuestionConfigDonorCategoryValueID);
                    break;
                default:
                    break;
            }
        }

        public void SelectQuestions(int questionGroupConfigID)
        {
            SpSelect = QuestionGroupsConfigDASprocs.QuestionGroupAssociationSelect.ToString();
            QuestionGroupConfigID = questionGroupConfigID;
            //QuestionCategoryID = questionCategoryID;
            //Inactive = inactive;
            SetTablesSelect("QuestionGroupAssociation");
        }

        public void SelectQuestionsConfig(int questionGroupID, int questionGroupConfigID)
        {
            SpSelect = QuestionGroupsConfigDASprocs.QuestionGroupConfigSelect.ToString();
            QuestionGroupID = questionGroupID;
            QuestionGroupConfigID = questionGroupConfigID;
            //Inactive = inactive;
            SetTablesSelect("QuestionGroupConfig");
        }

        public void SelectScreenFields(int screenID, int questionGroupConfigID)
        {
            SpSelect = QuestionGroupsConfigDASprocs.QuestionConfigFieldUpdateSelect.ToString();
            ScreenID = screenID;
            QuestionGroupConfigID = questionGroupConfigID;
            //Inactive = inactive;
            SetTablesSelect("QuestionConfigFieldUpdate");
        }
        public void SelectReferralType(int questionConfigReferralTypeID, int questionGroupConfigID)
        {
            SpSelect = QuestionGroupsConfigDASprocs.QuestionConfigReferralTypeSelect.ToString();
            QuestionConfigReferralTypeID = questionConfigReferralTypeID;
            QuestionGroupConfigID = questionGroupConfigID;
            //Inactive = inactive;
            SetTablesSelect("QuestionConfigReferralType");
        }

        public void SelectEventLog(int questionConfigEventTypeID, int questionGroupConfigID)
        {
            SpSelect = QuestionGroupsConfigDASprocs.QuestionConfigEventTypeSelect.ToString();
            QuestionConfigEventTypeID = questionConfigEventTypeID;
            QuestionGroupConfigID = questionGroupConfigID;
            //Inactive = inactive;
            SetTablesSelect("QuestionConfigEventType");
        }

        public void SelectEventUpdate(int questionConfigEventTypeUpdateID, int questionGroupConfigID)
        {
            SpSelect = QuestionGroupsConfigDASprocs.QuestionConfigEventTypeUpdateSelect.ToString();
            QuestionConfigEventTypeUpdateID = questionConfigEventTypeUpdateID;
            QuestionGroupConfigID = questionGroupConfigID;
            //Inactive = inactive;
            SetTablesSelect("QuestionConfigEventTypeUpdate");
        }
    }
}
