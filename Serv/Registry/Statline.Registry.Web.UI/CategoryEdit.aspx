<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CategoryEdit.aspx.cs" Inherits="Statline.Registry.Web.UI.CategoryEdit" %>
<%@ Register Assembly="Statline.StatTrac.Web" Namespace="Statline.StatTrac.Web.UI.MasterPages" TagPrefix="mp" %>
<%@ Register Src="Controls/CategoryEditControl.ascx" TagName="CategoryEditControl" TagPrefix="uc1" %>
<mp:ContentContainer ID="cC" runat="server">
    <mp:Content ID="cR" runat="server">
        <uc1:CategoryEditControl ID="CategoryEditControl" runat="server"/>
    </mp:Content>

</mp:ContentContainer>
