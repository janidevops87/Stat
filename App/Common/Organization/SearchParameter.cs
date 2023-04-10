using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;


namespace Statline.Stattrac.Common.Organization
{
    public class SearchParameter
    {
        #region Singleton Implementation
        private static SearchParameter _singletonSearchParameter;
        public static SearchParameter CreateInstance()
        {
            if (_singletonSearchParameter == null)
            {
                _singletonSearchParameter = new SearchParameter();
            }
            return _singletonSearchParameter;
        }

        protected SearchParameter()
        {
            
        }
        #endregion
        private string _administrationGroupFieldValue = "";
        public string AdministrationGroupFieldValue
        {
            get
            {
                if (_administrationGroupFieldValue == null)
                    _administrationGroupFieldValue = "";
                return _administrationGroupFieldValue;
            }
            set { _administrationGroupFieldValue = value; }
        }
        public bool ContractedStatlineClient
        {
            get;
            set;
        }

        private string _organizationName = "";
        public string OrganizationName
        {
            get
            {
                if(_organizationName == null)
                    _organizationName = "";
                return _organizationName;
            }
            set { _organizationName = value; }
        }
        public int OrganizationTypeId
        {
            get;
            set;
        }

        public int SourceCodeId
        {
            get;
            set;
        }
        public int CriteriaId
        {
            get;
            set;
        }

        public int StateId
        {
            get;
            set;
        }
        public Boolean View_Asp_Organizations
        {
            get;
            set;
        }
        public int GetSelected
        {
            get;
            set;
        }
    }
}