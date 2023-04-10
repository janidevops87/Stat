using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Statline.Stattrac.Framework;
using Statline.Stattrac.DataAccess.Schedule;
using Statline.Stattrac.Data.Types.Schedule;
using Statline.Stattrac.BusinessRules.Framework;
using System.Collections;
using System.Data;
using Statline.Stattrac.BusinessRules.Organization;
using Statline.Stattrac.Data.Types.Organization;
using Statline.Stattrac.Constant;

namespace Statline.Stattrac.BusinessRules.Schedule
{
    public class ScheduleBR: BaseBR
    {
        #region properties
        public int TimeZoneDif
        {
            get
            {
                return ((ScheduleDA)AssociatedDA).TimeZoneDif;
            }

            set
            {
                ((ScheduleDA)AssociatedDA).TimeZoneDif = value;
            }

        }
        public int ScheduleGroupID
        {
            get
            {
                return ((ScheduleDA)AssociatedDA).ScheduleGroupID;
            }

            set
            {
                ((ScheduleDA)AssociatedDA).ScheduleGroupID = value;
            }
        }
        public DateTime FromDate
        {
            get
            {
                return ((ScheduleDA)AssociatedDA).FromDate;
            }

            set
            {
                ((ScheduleDA)AssociatedDA).FromDate = value;
            }
        }
        public DateTime ToDate
        {
            get
            {
                return ((ScheduleDA)AssociatedDA).ToDate;
            }

            set
            {
                ((ScheduleDA)AssociatedDA).ToDate = value;
            }
        }


        #endregion
        #region private Fields
        private OrganizationBR _OrganizationBr;
        #endregion
        #region Overridden Methods
        protected override void BusinessRulesBeforeSave()
        {
            //check the state of each table if the data has changed update 
            RecordScheduleLogChanges();
        }
        #endregion
        public ScheduleBR()
        { 
            AssociatedDataSet = new ScheduleDS();
            AssociatedDA = new ScheduleDA(); 
        
        }
        private void RecordScheduleLogChanges()
        {
            ((ScheduleDS)AssociatedDataSet).Schedule.ToList().ForEach(row => 
            {
                if (row.RowState != DataRowState.Modified)
                    return;

                //Check for person changes
                for (int i = 1; i <= 18; i++)
                {
                    string person = string.Format("Person{0}", i.ToString());
                    if (!row[person, DataRowVersion.Original].Equals(row[person]))
                    {   
                        // Changes are pending. Find out what they are and record the note.
                         string scheduleLogChangeNote = ScheduleLogChangeReason(row, person);
                         string scheduleLogShift = String.Format("{0:MM/dd/yyyy HH:mm:ss ddd}, {1:MM/dd/yyyy HH:mm:ss ddd}", row.ScheduleStartDateTime, row.ScheduleEndDateTime  ) ;

                        // Add ScheduleLog row for person schedule changes
                         AssociatedDataSet.scheduleDs().ScheduleLog.AddScheduleLogRow(row.ScheduleGroupID, DateTime.Now, StattracIdentity.Identity.UserId, "Edit Person", scheduleLogShift, scheduleLogChangeNote, DateTime.Now); 
                    }
                }

            });

       
        }
        private string ScheduleLogChangeReason(DataRow row, string person)
        {
            string reason = "";
            int personOriginal = 0;
            try
            {
                //original value might be null
                personOriginal = Convert.ToInt32(row[person, DataRowVersion.Original]);
            }
            catch
            { }
            int personCurrent = Convert.ToInt32(row[person]);
            if (_OrganizationBr == null)
            {
                _OrganizationBr = new OrganizationBR();
                _OrganizationBr.AssociatedDataSet.organizationDs().EnforceConstraints = false;
            }
            //get Original PersonID if > 0
            if (personOriginal > 0)
                _OrganizationBr.PersonSelect(personOriginal);
            OrganizationDS.PersonRow personOriginalRow = _OrganizationBr.PersonRow(personOriginal);
            string personOriginalName = "";
            if (personOriginalRow != null)
                personOriginalName = String.Format("{0} {1}", personOriginalRow.PersonFirst, personOriginalRow.PersonLast);


            if (personCurrent > 0)
                _OrganizationBr.PersonSelect(personCurrent);
            OrganizationDS.PersonRow personCurrentRow = _OrganizationBr.PersonRow(personCurrent);
            string personCurrentName = "";
            if (personCurrentRow != null)
                personCurrentName = String.Format("{0} {1}", personCurrentRow.PersonFirst, personCurrentRow.PersonLast);



                    //Check for person deleted
                    if (personOriginal > 0 && personCurrent < 1 )
                    {
                        reason = String.Format("Delete Person #{0} {1} ", person.Replace("Person", ""), personOriginalName );
                    }
                    //Check for person insert
                    else if (personOriginal < 1 && personCurrent > 1)
                    {
                        reason = String.Format("Insert Person #{0} {1} ", person.Replace("Person", ""), personCurrentName );
                    }
                    //Check for person changed
                    else if (personOriginal > 0 && personCurrent > 0)
                    {
                        reason = String.Format("Changed Person #{0} from {1} to {2}", person.Replace("Person", ""), personOriginalName, personCurrentName );
                    }

            return reason; 
        }

        private object ListControlBR(ScheduleDS scheduleDS)
        {
            throw new NotImplementedException();
        }
    }
    public static class DataSetConversion
    {
        public static ScheduleDS scheduleDs(this DataSet dataset)
        {
            try
            {
                return (ScheduleDS)dataset;
            }
            catch
            {
                return null;
            }
        }
    }
}
