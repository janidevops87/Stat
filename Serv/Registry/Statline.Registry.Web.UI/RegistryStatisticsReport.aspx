<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RegistryStatisticsReport.aspx.cs" Inherits="Statline.Registry.Web.UI.RegistryStatisticsReport" %>
<%@ Register Assembly="Statline.StatTrac.Web" Namespace="Statline.StatTrac.Web.UI.MasterPages" TagPrefix="mp" %>
<%@ Register Src="Controls/RegistryStatisticsReportControl.ascx" TagName="RegistryStatisticsReportControl" TagPrefix="uc1" %>
<mp:ContentContainer ID="cC" MasterPageFile="~/Framework/Templates/BasicViewSecure.ascx" runat="server">
    <mp:Content ID="cR" runat="server">
        <uc1:RegistryStatisticsReportControl ID="RegistryStatisticsReportControl" runat="server" />
    </mp:Content>
</mp:ContentContainer>
