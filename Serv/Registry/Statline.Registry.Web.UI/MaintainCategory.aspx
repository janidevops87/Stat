<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MaintainCategory.aspx.cs" Inherits="Statline.Registry.Web.UI.Controls.MaintainCategory" %>
<%@ Register Assembly="Statline.StatTrac.Web" Namespace="Statline.StatTrac.Web.UI.MasterPages" TagPrefix="mp" %>
<%@ Register Src="Controls/MaintainCategoryControl.ascx" TagName="MaintainCategoryControl" TagPrefix="uc1" %>
<mp:ContentContainer ID="cC" MasterPageFile="~/Framework/Templates/BasicViewSecure.ascx" runat="server">
    <mp:Content ID="cR" runat="server" >
       <uc1:MaintainCategoryControl ID="MaintainCategoryControl" runat="server" />
    </mp:Content>
</mp:ContentContainer>
