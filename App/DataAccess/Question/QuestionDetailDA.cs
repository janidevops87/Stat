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
    public enum QuestionDetailDASprocs
    {
        QuestionSelectDataSet,
        QuestionSelect,
        QuestionAssociatedSelect
    }
    public class QuestionDetailDA : BaseDA
    {
        public int QuestionID { get; set; }
        public int QuestionCategoryID { get; set; }
        public Int16 Inactive { get; set; }
        public int QuestionAssociatedID { get; set; }
        public int ChildQuestionID { get; set; }
        public QuestionDetailDASprocs SprocName { get; set; }
        public QuestionDetailDA()
			: base(QuestionDetailDASprocs.QuestionSelectDataSet.ToString())
		{
            ListTableSave.Add(new TableSave("Question", "QuestionInsert", "QuestionUpdate", "QuestionDelete"));
            ListTableSave.Add(new TableSave("QuestionAssociated", "QuestionAssociatedInsert", "QuestionAssociatedUpdate", "QuestionAssociatedDelete"));
        }
        public void SetDefaultTableSelect()
        {

            SpSelect = QuestionDetailDASprocs.QuestionSelectDataSet.ToString();
            SetTablesSelect(
                "Question",
                "QuestionAssociated"
                
                );
        }

        protected override void AddParameterForSelectDataSet(BaseCommand commandWrapper)
        {

            switch ((QuestionDetailDASprocs)Enum.Parse(typeof(QuestionDetailDASprocs), SpSelect, true))
            {
                case QuestionDetailDASprocs.QuestionSelectDataSet:
                    SetDefaultTableSelect();
                    //commandWrapper.AddInParameterForSelect("StatEmployeeId", DbType.Int32, StattracIdentity.Identity.UserId);
                    commandWrapper.AddInParameterForSelect("QuestionID", DbType.Int32, QuestionID);
                    break;
                case QuestionDetailDASprocs.QuestionSelect:
                    commandWrapper.AddInParameterForSelect("QuestionID", DbType.Int32, QuestionID);
                    commandWrapper.AddInParameterForSelect("QuestionCategoryID", DbType.Int32, QuestionCategoryID);
                    commandWrapper.AddInParameterForSelect("Inactive", DbType.Int16, Inactive);
                    break;
                case QuestionDetailDASprocs.QuestionAssociatedSelect:
                    commandWrapper.AddInParameterForSelect("QuestionAssociatedID", DbType.Int32, QuestionAssociatedID);
                    commandWrapper.AddInParameterForSelect("QuestionID", DbType.Int32, QuestionID);
                    commandWrapper.AddInParameterForSelect("ChildQuestionID", DbType.Int32, ChildQuestionID);
                    break;
                default:
                    break;
            }
        }

        public void SelectQuestions(int questionID, int questionCategoryID, Int16 inactive)
        {
            SpSelect = QuestionDetailDASprocs.QuestionSelect.ToString();
            QuestionID = questionID;
            QuestionCategoryID = questionCategoryID;
            Inactive = inactive;
            SetTablesSelect("Question");

        }

        public void SelectQuestions(Int16 inactive)
        {
            SpSelect = QuestionDetailDASprocs.QuestionSelect.ToString();
            Inactive = inactive;
            SetTablesSelect("Question");

        }

        public void SelectAssociatedQuestions(int questionID)
        {
            SpSelect = QuestionDetailDASprocs.QuestionAssociatedSelect.ToString();
            QuestionID = questionID;
            SetTablesSelect("QuestionAssociated");

        }

        public void SelectAssociatedQuestions(int questionAssocID, int questionID, int childQuestionID)
        {
            SpSelect = QuestionDetailDASprocs.QuestionAssociatedSelect.ToString();
            QuestionID = questionID;
            QuestionAssociatedID = questionAssocID;
            ChildQuestionID = childQuestionID;
            SetTablesSelect("QuestionAssociated");

        }
    }
}
