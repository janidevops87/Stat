using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Statline.Stattrac.Framework;
using System.Data;

namespace Statline.Stattrac.DataAccess.Schedule
{
    public enum ScheduleDASprocs
    { 
        ScheduleSelect
    }

    public class ScheduleDA : BaseDA
    {
        #region properties
        public int TimeZoneDif { get; set; }
        public int ScheduleGroupID { get; set; }
        public DateTime FromDate { get; set; }
        public DateTime ToDate { get; set; }

        #endregion

       public ScheduleDA()
           : base(ScheduleDASprocs.ScheduleSelect.ToString())
        {
            SetDefaultTableSelect();
            ListTableSave.Add(new TableSave("Schedule", "ScheduleInsert", "ScheduleUpdate", "ScheduleDelete"));
            ListTableSave.Add(new TableSave("ScheduleLog", "ScheduleLogInsert", "ScheduleLogUpdate", "ScheduleLogDelete"));
        }
        public void SetDefaultTableSelect()
        {

            SpSelect = ScheduleDASprocs.ScheduleSelect.ToString();
            SetTablesSelect(
                "Schedule"
                );
        }
        protected override void AddParameterForSelectDataSet(BaseCommand commandWrapper)
        {

            switch ((ScheduleDASprocs)Enum.Parse(typeof(ScheduleDASprocs), SpSelect, true))
            {
                case ScheduleDASprocs.ScheduleSelect:
                    commandWrapper.AddInParameterForSelect("TimeZoneDif", DbType.Int32, TimeZoneDif);
                    commandWrapper.AddInParameterForSelect("ScheduleGroupID", DbType.Int32, ScheduleGroupID);
                    commandWrapper.AddInParameterForSelect("FromDate", DbType.DateTime, FromDate);
                    commandWrapper.AddInParameterForSelect("ToDate", DbType.DateTime, ToDate);


                    break;
            }
        }

    }
}
