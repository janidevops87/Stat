<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EventLogUpdate.aspx.cs" Inherits="Statline.StatTrac.Web.UI.EventLogUpdate" %>

<%@ Register Src="Controls/EventLogUpdateControl.ascx" TagName="EventLogUpdateControl"
    TagPrefix="uc2" %>
<%@ Register TagPrefix="uc1" TagName="ReportListControl" Src="Controls/ReportListControl.ascx" %>
<%@ Register TagPrefix="mp" Namespace="Statline.StatTrac.Web.UI.MasterPages" Assembly="Statline.StatTrac.Web" %>
<mp:contentcontainer id="cC" MasterPageFile="~/Framework/Templates/BasicViewSecure.ascx" runat="server">
	<mp:content id="cR" runat="server">
	    <uc2:EventLogUpdateControl ID="EventLogUpdateControl1" runat="server" />
	</mp:content>
</mp:contentcontainer>

