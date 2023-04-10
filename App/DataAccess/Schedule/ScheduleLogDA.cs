using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Statline.Stattrac.Framework;
using System.Data;

namespace Statline.Stattrac.DataAccess.Schedule
{
    public enum ScheduleLogDASprocs
    { 
        ScheduleLogSelect
    }
    public class ScheduleLogDA: BaseDA
    {
        #region properties
        public int TimeZoneDif { get;  set; }
        public int ScheduleGroupID { get;  set; }
        public DateTime FromDate { get;  set; }
        public DateTime ToDate { get; set; }

        #endregion

        public ScheduleLogDA():
            base(ScheduleLogDASprocs.ScheduleLogSelect.ToString())
        {
            SetDefaultTableSelect();
        }
        public void SetDefaultTableSelect()
        {

            SpSelect = ScheduleLogDASprocs.ScheduleLogSelect.ToString();
            SetTablesSelect(
                "ScheduleLog"
                );
        }
        protected override void AddParameterForSelectDataSet(BaseCommand commandWrapper)
        {

            switch ((ScheduleLogDASprocs)Enum.Parse(typeof(ScheduleLogDASprocs), SpSelect, true))
            {
                case ScheduleLogDASprocs.ScheduleLogSelect:
                    commandWrapper.AddInParameterForSelect("TimeZoneDif", DbType.Int32, TimeZoneDif);
                    commandWrapper.AddInParameterForSelect("ScheduleGroupID", DbType.Int32, ScheduleGroupID);
                    commandWrapper.AddInParameterForSelect("FromDate", DbType.DateTime, FromDate);
                    commandWrapper.AddInParameterForSelect("ToDate", DbType.DateTime, ToDate);


                    break;
            }
        }
    }
}
