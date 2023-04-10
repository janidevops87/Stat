using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Statline.Stattrac.Framework;
using Statline.Stattrac.DataAccess.ReferralDonorData;
using Statline.Stattrac.Data.Types.ReferralDonorData;

namespace Statline.Stattrac.BusinessRules.ReferralDonorData
{
    public class ReferralDonorDataBR : BaseBR
    {
        #region properties
        public string FirstName
        {
            get
            {
                return ((ReferralDonorDataDA)AssociatedDA).FirstName;
            }

            set
            {
                ((ReferralDonorDataDA)AssociatedDA).FirstName = value;
            }

        }
        public string LastName
        {
            get
            {
                return ((ReferralDonorDataDA)AssociatedDA).LastName;
            }

            set
            {
                ((ReferralDonorDataDA)AssociatedDA).LastName = value;
            }

        }
        public DateTime DOB
        {
            get
            {
                return ((ReferralDonorDataDA)AssociatedDA).DOB;
            }

            set
            {
                ((ReferralDonorDataDA)AssociatedDA).DOB = value;
            }
        }


        #endregion
        public ReferralDonorDataBR()
        {
            AssociatedDataSet = new ReferralDonorDataDS();
            AssociatedDA = new ReferralDonorDataDA();

        }
    }
}
