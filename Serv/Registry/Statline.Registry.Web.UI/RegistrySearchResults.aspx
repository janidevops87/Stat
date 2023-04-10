<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RegistrySearchResults.aspx.cs" Inherits="Statline.Registry.Web.UI.RegistrySearchResults" %>
<%@ Register Assembly="Statline.StatTrac.Web" Namespace="Statline.StatTrac.Web.UI.MasterPages" TagPrefix="mp" %>
<%@ Register Src="Controls/RegistrySearchResultsControl.ascx" TagName="RegistrySearchResultsControl" TagPrefix="uc1" %>
<mp:ContentContainer ID="cC" runat="server">
    <mp:Content ID="cR" runat="server">
        <uc1:RegistrySearchResultsControl ID="RegistrySearchResultsControl" runat="server" />
    </mp:Content>
</mp:ContentContainer>
