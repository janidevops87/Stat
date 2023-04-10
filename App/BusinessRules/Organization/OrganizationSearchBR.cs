using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using Statline.Stattrac.Common.Organization;
using Statline.Stattrac.Framework;
using Statline.Stattrac.Data.Types.Organization;
using Statline.Stattrac.DataAccess.Organization;
using System.Threading;
using Statline.Stattrac.Constant;

namespace Statline.Stattrac.BusinessRules.Organization
{
    public class OrganizationSearchBR : BaseBR
    {
        public OrganizationSearchBR()
		{
            AssociatedDA = new OrganizationSearchDA();
            AssociatedDataSet = new OrganizationSearchDS();
		}
        public SearchParameter OrganizationSearchParameter 
        {
            get { return ((OrganizationSearchDA)AssociatedDA).OrganizationSearchParameter; }
            set { ((OrganizationSearchDA)AssociatedDA).OrganizationSearchParameter = value; }
        }
        public bool DisplayAllOrganizations
        {
            get { return ((OrganizationSearchDA)AssociatedDA).DisplayAllOrganizations; }
            set { ((OrganizationSearchDA)AssociatedDA).DisplayAllOrganizations = value; }
        }
        public int OrganizationId
        {
            get { return ((OrganizationSearchDA)AssociatedDA).OrganizationId; }
            set { ((OrganizationSearchDA)AssociatedDA).OrganizationId = value; }

        }
    }
}
