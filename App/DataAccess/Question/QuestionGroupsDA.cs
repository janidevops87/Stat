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
    public enum QuestionGroupsDASprocs
    {
        QuestionAssociatedSelectDataSet,
        QuestionAssociatedSelect
    }
    public class QuestionGroupsDA : BaseDA
    {
        public int QuestionID { get; set; }
        public int QuestionCategoryID { get; set; }
        public Int16 Inactive { get; set; }
        public int QuestionAssociatedID { get; set; }
        public int ChildQuestionID { get; set; }
        public QuestionGroupsDASprocs SprocName { get; set; }
        public QuestionGroupsDA()
			: base(QuestionGroupsDASprocs.QuestionAssociatedSelectDataSet.ToString())
		{
            ListTableSave.Add(new TableSave("QuestionAssocicated", "QuestionAssociatedInsert", "QuestionAssociatedUpdate", "QuestionAssociatedDelete"));
        }
        public void SetDefaultTableSelect()
        {

            SpSelect = QuestionGroupsDASprocs.QuestionAssociatedSelectDataSet.ToString();
            SetTablesSelect(
                "Question",
                "QuestionAssociated"
                
                );
        }

        protected override void AddParameterForSelectDataSet(BaseCommand commandWrapper)
        {

            switch ((QuestionGroupsDASprocs)Enum.Parse(typeof(QuestionGroupsDASprocs), SpSelect, true))
            {
                case QuestionGroupsDASprocs.QuestionAssociatedSelectDataSet:
                    SetDefaultTableSelect();
                    //commandWrapper.AddInParameterForSelect("StatEmployeeId", DbType.Int32, StattracIdentity.Identity.UserId);
                    commandWrapper.AddInParameterForSelect("QuestionID", DbType.Int32, QuestionID);
                    break;

                case QuestionGroupsDASprocs.QuestionAssociatedSelect:
                    commandWrapper.AddInParameterForSelect("QuestionAssociatedID", DbType.Int32, QuestionAssociatedID);
                    commandWrapper.AddInParameterForSelect("QuestionID", DbType.Int32, QuestionID);
                    commandWrapper.AddInParameterForSelect("ChildQuestionID", DbType.Int32, ChildQuestionID);
                    break;
                default:
                    break;
            }
        }

        //public void SelectQuestions(int questionID, int questionCategoryID, Int16 inactive)
        //{
        //    SpSelect = QuestionGroupsDASprocs.QuestionSelect.ToString();
        //    QuestionID = questionID;
        //    QuestionCategoryID = questionCategoryID;
        //    Inactive = inactive;
        //    SetTablesSelect("Question");

        //}

        //public void SelectQuestions(Int16 inactive)
        //{
        //    SpSelect = QuestionGroupsDASprocs.QuestionSelect.ToString();
        //    Inactive = inactive;
        //    SetTablesSelect("Question");

        //}

        public void SelectAssociatedQuestions(int questionAssocID, int questionID, int childQuestionID)
        {
            SpSelect = QuestionGroupsDASprocs.QuestionAssociatedSelect.ToString();
            QuestionID = questionID;
            QuestionAssociatedID = questionAssocID;
            ChildQuestionID = childQuestionID;
            SetTablesSelect("Question");

        }

        public void SelectAssociatedQuestions(int questionAssocID)
        {
            SpSelect = QuestionGroupsDASprocs.QuestionAssociatedSelect.ToString();
            QuestionAssociatedID = questionAssocID;
            SetTablesSelect("QuestionAssociated");

        }
    }
}
