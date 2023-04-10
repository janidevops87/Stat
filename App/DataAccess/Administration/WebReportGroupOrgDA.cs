using System;
using System.Data;
using Statline.Stattrac.Common.Organization;
using Statline.Stattrac.Constant;
using Statline.Stattrac.Framework;

namespace Statline.Stattrac.DataAccess.Administration
{
    public enum WebReportGroupOrgDASprocs
    {
        WebReportGroupOrgSelectDataSet,
        WebReportGroupOrgSelect,
        WebReportGroupOrgSearchSelect

    }
    public class WebReportGroupOrgDA : BaseDA
    {
        public int WebReportGroupOrgId { get; set; }
        public int OrganizationID { get; set; }

        public WebReportGroupOrgDASprocs SprocName { get; set; }
        private GeneralConstant grConstant;
        public WebReportGroupOrgDA()
            : base(WebReportGroupOrgDASprocs.WebReportGroupOrgSelectDataSet.ToString())
        {
            grConstant = GeneralConstant.CreateInstance();
            SetDefaultTableSelect();
            ListTableSave.Add(new TableSave("WebReportGroupOrg", "WebReportGroupOrgInsert", "WebReportGroupOrgUpdate", "WebReportGroupOrgDelete"));
        }
        public void SetDefaultTableSelect()
        {

            SpSelect = WebReportGroupOrgDASprocs.WebReportGroupOrgSelectDataSet.ToString();
            SetTablesSelect(
                "WebReportGroupOrg"
                );
        }
        #region ovrriden methods
        protected override void AddParameterForSelectDataSet(BaseCommand commandWrapper)
        {
            switch ((WebReportGroupOrgDASprocs)Enum.Parse(typeof(WebReportGroupOrgDASprocs), SpSelect, true))
            {
                case WebReportGroupOrgDASprocs.WebReportGroupOrgSelectDataSet:
                    SetDefaultTableSelect();
                    commandWrapper.AddInParameterForSelect("WebReportGroupOrgID", DbType.Int32, WebReportGroupOrgId);
                    break;
                case WebReportGroupOrgDASprocs.WebReportGroupOrgSelect:
                    commandWrapper.AddInParameterForSelect("WebReportGroupOrgID", DbType.Int32, WebReportGroupOrgId);
                    break;
                case WebReportGroupOrgDASprocs.WebReportGroupOrgSearchSelect:
                    commandWrapper.AddInParameterForSelect("OrganizationID", DbType.Int32, OrganizationID);
                    break;

                default:
                    break;
            }
        }
        #endregion


        public void SelectWebReportGroupOrg(int webReportGroupOrgID)
        {
            SpSelect = WebReportGroupOrgDASprocs.WebReportGroupOrgSelect.ToString();
            WebReportGroupOrgId = webReportGroupOrgID;
            SetTablesSelect("WebReportGroupOrg");
        }

        public void AddWebReportGroupOrgDefault()
        {
            SetTablesSelect("WebReportGroupOrgSearch");
            SpSelect = WebReportGroupOrgDASprocs.WebReportGroupOrgSearchSelect.ToString();

        }
    }
}
