using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Statline.Stattrac.Common.Organization;
using Statline.Stattrac.Framework;
using System.Data;
using System.Threading;
using Statline.Stattrac.Constant;

namespace Statline.Stattrac.DataAccess.Organization
{
    public class OrganizationSearchDA : BaseDA
    {
        private StattracIdentity stattracIdentity;        
        public OrganizationSearchDA()
            : base("OrganizationSearchSelect")
		{
			SetTablesSelect("OrganizationSearch");
            stattracIdentity = (StattracIdentity)Thread.CurrentPrincipal.Identity;
        }

        #region properties
        private SearchParameter _searchParameter = SearchParameter.CreateInstance();
        public SearchParameter OrganizationSearchParameter
        {
            get { return _searchParameter; }
            set { _searchParameter = value; }
        }

        private int _organizationId;
        public int OrganizationId
        {
            get { return _organizationId; }
            set { _organizationId = value; }
        }

        private bool _displayAllOrganizations;
        public bool DisplayAllOrganizations
        {
            get { return _displayAllOrganizations; }
            set { _displayAllOrganizations = value;}
        }

  

        #endregion

        #region ovrriden methods
        protected override void AddParameterForSelectDataSet(BaseCommand commandWrapper)
        {
            //commandWrapper.AddInParameterForSelect("StatEmployeeId", DbType.Int32, StattracIdentity.Identity.UserId);
            if (_organizationId > 0)
                commandWrapper.AddInParameterForSelect("OrganizationId", DbType.Int32, _organizationId);
            if (OrganizationSearchParameter.SourceCodeId > 0)
                commandWrapper.AddInParameterForSelect("SourceCodeId", DbType.Int32, OrganizationSearchParameter.SourceCodeId);
            if (OrganizationSearchParameter.OrganizationName.Length > 0)
                commandWrapper.AddInParameterForSelect("OrganizationName", DbType.String, OrganizationSearchParameter.OrganizationName);
            if (OrganizationSearchParameter.OrganizationTypeId > 0)
                commandWrapper.AddInParameterForSelect("OrganizationTypeId", DbType.Int32, OrganizationSearchParameter.OrganizationTypeId);
            if (OrganizationSearchParameter.StateId > 0)
                commandWrapper.AddInParameterForSelect("StateId", DbType.Int32, OrganizationSearchParameter.StateId);
            if(OrganizationSearchParameter.ContractedStatlineClient)
                commandWrapper.AddInParameterForSelect("ContractedStatlineClient", DbType.Boolean, OrganizationSearchParameter.ContractedStatlineClient);
            
            commandWrapper.AddInParameterForSelect("DisplayAllOrganizations", DbType.Boolean, DisplayAllOrganizations);

            if (OrganizationSearchParameter.AdministrationGroupFieldValue.Length > 0)
                commandWrapper.AddInParameterForSelect("AdministrationGroupFieldValue", DbType.String, OrganizationSearchParameter.AdministrationGroupFieldValue);

            commandWrapper.AddInParameterForSelect("userOrganizationID", DbType.Int32, stattracIdentity.UserOrganizationId);

        }
        #endregion
    }
}
