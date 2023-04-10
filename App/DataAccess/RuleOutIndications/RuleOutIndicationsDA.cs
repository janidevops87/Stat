using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Statline.Stattrac.Framework;
using Statline.Stattrac.Constant;
using System.Data;
using Statline.Stattrac.Data.Types.RuleOutIndications;

namespace Statline.Stattrac.DataAccess.RuleOutIndications
{
    public enum RuleOutIndicationsDASprocs
    {
        IndicationSelectDataSet,
        IndicationSelect,
        IndicationResponseSelect,
        AssociatedCriteriaGroupsSelect,
        IndicationQuestionAssociatedSelect

    }
    public class RuleOutIndicationsDA : BaseDA
    {
        public int IndicationID { get; set; }
        public int QuestionID { get; set; }
        public int QuestionCategoryID { get; set; }
        public Int16 Inactive { get; set; }
        public int IndicationQuestionAssociatedID { get; set; }
        public int ChildQuestionID { get; set; }


        public RuleOutIndicationsDA()
            : base(RuleOutIndicationsDASprocs.IndicationSelectDataSet.ToString())
		{
            ListTableSave.Add(new TableSave("Indication", "IndicationInsert", "IndicationUpdate", "IndicationDelete"));
            ListTableSave.Add(new TableSave("IndicationResponse", "IndicationResponseInsert", "IndicationResponseUpdate", "IndicationResponseDelete"));
            ListTableSave.Add(new TableSave("Question", "QuestionInsert", "QuestionUpdate", "QuestionDelete"));
            ListTableSave.Add(new TableSave("IndicationQuestionAssociated", "IndicationQuestionAssociatedInsert", "IndicationQuestionAssociatedUpdate", "IndicationQuestionAssociatedDelete"));
        }
        public void SetDefaultTableSelect()
        {

            SpSelect = RuleOutIndicationsDASprocs.IndicationSelectDataSet.ToString();
            SetTablesSelect(
                "Indication",
                "IndicationResponse",
                "AssociatedCriteriaGroups",
                "IndicationQuestionAssociated"
                );
        }

        protected override void AddParameterForSelectDataSet(BaseCommand commandWrapper)
        {

            switch ((RuleOutIndicationsDASprocs)Enum.Parse(typeof(RuleOutIndicationsDASprocs), SpSelect, true))
            {
                case RuleOutIndicationsDASprocs.IndicationSelectDataSet:
                    SetDefaultTableSelect();
                    //commandWrapper.AddInParameterForSelect("StatEmployeeId", DbType.Int32, StattracIdentity.Identity.UserId);
                    commandWrapper.AddInParameterForSelect("IndicationID", DbType.Int32, IndicationID);
                    commandWrapper.AddInParameterForSelect("ChildQuestionID", DbType.Int32, ChildQuestionID);
                    break;
                case RuleOutIndicationsDASprocs.IndicationSelect:
                    commandWrapper.AddInParameterForSelect("IndicationID", DbType.Int32, IndicationID);
                    break;
                case RuleOutIndicationsDASprocs.IndicationResponseSelect:
                    commandWrapper.AddInParameterForSelect("IndicationID", DbType.Int32, IndicationID);
                    break;
                case RuleOutIndicationsDASprocs.AssociatedCriteriaGroupsSelect:
                    commandWrapper.AddInParameterForSelect("IndicationID", DbType.Int32, IndicationID);
                    break;
                case RuleOutIndicationsDASprocs.IndicationQuestionAssociatedSelect:
                    commandWrapper.AddInParameterForSelect("ChildQuestionID", DbType.Int32, ChildQuestionID);
                    break;

                default:
                    break;
            }
        }

        public void SelectIndication(int IndicationID)
        {
            SpSelect = RuleOutIndicationsDASprocs.IndicationSelect.ToString();
            IndicationID = IndicationID;
            SetTablesSelect("Indication");

        }

        public void SelectIndicationResponse(int IndicationID)
        {
            SpSelect = RuleOutIndicationsDASprocs.IndicationResponseSelect.ToString();
            IndicationID = IndicationID;
            SetTablesSelect("Indication");

        }
        public void SelectAssociatedCriteriaGroups(int IndicationID)
        {
            SpSelect = RuleOutIndicationsDASprocs.AssociatedCriteriaGroupsSelect.ToString();
            IndicationID = IndicationID;
            SetTablesSelect("AssociatedCriteriaGroups");

        }
        public void SelectIndicationAssociatedQuestions(int childQuestionID)
        {
            SpSelect = RuleOutIndicationsDASprocs.IndicationQuestionAssociatedSelect.ToString();
            ChildQuestionID = childQuestionID;
            SetTablesSelect("IndicationQuestionAssociated");

        }

    }
}
