<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="QAManageErrorTypes.aspx.cs" Inherits="Statline.StatTrac.Web.UI.QAManageErrorTypes" %>
<%@ Register Src="Controls/QAManageErrorTypesControl.ascx" TagName="QAManageErrorTypesControl" TagPrefix="uc2" %>
<%@ Register TagPrefix="uc1" TagName="ReportListControl" Src="Controls/ReportListControl.ascx" %>
<%@ Register TagPrefix="mp" Namespace="Statline.StatTrac.Web.UI.MasterPages" Assembly="Statline.StatTrac.Web" %>
<mp:contentcontainer id="cC" MasterPageFile="~/Framework/Templates/BasicViewSecure.ascx" runat="server">
	<mp:content id="cR" runat="server">
	    <uc2:QAManageErrorTypesControl ID="qAManageErrorTypesControl" runat="server" />
	</mp:content>
</mp:contentcontainer>