<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RegistrySearch.aspx.cs" Inherits="Statline.Registry.Web.UI.RegistrySearch" %>

<%@ Register Assembly="Statline.StatTrac.Web" Namespace="Statline.StatTrac.Web.UI.MasterPages"
    TagPrefix="mp" %>
<%@ Register Src="Controls/RegistrySearchControl.ascx" TagName="RegistrySearchControl"  TagPrefix="uc1" %>
<mp:ContentContainer ID="cC" MasterPageFile="~/Framework/Templates/BasicViewSecure.ascx" runat="server">
    <mp:Content ID="cR" runat="server">
        <uc1:RegistrySearchControl ID="RegistrySearchControl" runat="server" />
    </mp:Content>
</mp:ContentContainer>