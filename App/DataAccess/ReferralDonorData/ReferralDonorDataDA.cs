using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Statline.Stattrac.Framework;
using System.Data;

namespace Statline.Stattrac.DataAccess.ReferralDonorData
{
    public enum ReferralDonorDataDASprocs
    {
        CheckRegistrySelect
    }
    public class ReferralDonorDataDA : BaseDA
    {
        #region properties
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public DateTime DOB { get; set; }

        #endregion

       public ReferralDonorDataDA():
            base(ReferralDonorDataDASprocs.CheckRegistrySelect.ToString())
        {
            SetDefaultTableSelect();
        }
        public void SetDefaultTableSelect()
        {

            SpSelect = ReferralDonorDataDASprocs.CheckRegistrySelect.ToString();
            SetTablesSelect(
                "ReferralDonorData"
                );
        }
        protected override void AddParameterForSelectDataSet(BaseCommand commandWrapper)
        {

            switch ((ReferralDonorDataDASprocs)Enum.Parse(typeof(ReferralDonorDataDASprocs), SpSelect, true))
            {
                case ReferralDonorDataDASprocs.CheckRegistrySelect:
                    commandWrapper.AddInParameterForSelect("FirstName", DbType.String, FirstName);
                    commandWrapper.AddInParameterForSelect("LastName", DbType.String, LastName);
                    commandWrapper.AddInParameterForSelect("DOB", DbType.DateTime, DOB);

                    break;
            }
        }
    }

}
