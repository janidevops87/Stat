using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Statline.Stattrac.Framework;
using Statline.Stattrac.Data.Types.Schedule;
using Statline.Stattrac.DataAccess.Organization;
using Statline.Stattrac.DataAccess.Schedule;

namespace Statline.Stattrac.BusinessRules.Schedule
{
    public class ScheduleLogBR: BaseBR
    {
        #region properties
            public int TimeZoneDif { 
                get
                {
                    return ((ScheduleLogDA)AssociatedDA).TimeZoneDif;
                }
                
                set
                {
                    ((ScheduleLogDA)AssociatedDA).TimeZoneDif = value;
                }
            
            }
            public int ScheduleGroupID 
            {
                get
                {
                    return ((ScheduleLogDA)AssociatedDA).ScheduleGroupID;
                }

                set
                {
                    ((ScheduleLogDA)AssociatedDA).ScheduleGroupID = value;
                }
            }
            public DateTime FromDate
            {
                get
                {
                    return ((ScheduleLogDA)AssociatedDA).FromDate;
                }

                set
                {
                    ((ScheduleLogDA)AssociatedDA).FromDate = value;
                }
            }
            public DateTime ToDate
            {
                get
                {
                    return ((ScheduleLogDA)AssociatedDA).ToDate;
                }

                set
                {
                    ((ScheduleLogDA)AssociatedDA).ToDate = value;
                }
            }


        #endregion

        public ScheduleLogBR()
        {
            AssociatedDataSet = new ScheduleLogDS();
            AssociatedDA = new ScheduleLogDA(); 
        
        }
    }
}
